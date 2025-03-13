# -----Ref: https://juliaparallel.org/MPI.jl/stable/
# -----Ref: https://enccs.github.io/julia-for-hpc/MPI/
# To use MPI on your machine, either Window or Linux, we need to install MPI applications:
# 1. Window: https://www.microsoft.com/en-us/download/details.aspx?id=57467
# 2. Linux: https://www.open-mpi.org/software/ompi/v5.0/
# To use MPI with Julia, Install MPI: julia> ]add MPI
using MPI
using LinearAlgebra
using BenchmarkTools
# ========
include("find_local_index.jl") # This function is used to assign tasks for CPUs
MPI.Init()
comm = MPI.COMM_WORLD
rank = MPI.Comm_rank(comm)
comm_size = MPI.Comm_size(comm)
root = 0
# -------------------------
function my_func(N)
    A = zeros(N)
    for e = 1:N
        A[e] = norm(ones(N, N))
    end
end
# -------------------------
function my_func_MPI(N, local_index)
    A = zeros(N)
    for e = local_index[1]:local_index[end]
        A[e] = norm(ones(N, N))
    end
    return A
end
# =========================
N = 1000
local_index = find_local_index(comm, rank, comm_size, root, N)
comm = MPI.COMM_WORLD
# print("Hello world, I am rank $(MPI.Comm_rank(comm)) of $(MPI.Comm_size(comm))\n")
# print("Hello world, I am rank $(MPI.Comm_rank(comm)) of $(MPI.Comm_size(comm)) with Index = $(local_index)\n")

# ====Communication between CPUs is ready====

A = my_func_MPI(N, local_index)
A = MPI.Reduce(A, +, root, comm)
if rank == 0
    print("Sum of A = $(sum(A))")
end
MPI.Barrier(comm)

# mpiexec -n 7 julia .\Parallel_MPI.jl

# To download codes: https://github.com/sy-nguyen-van/Parallel-Computing-in-Julia
