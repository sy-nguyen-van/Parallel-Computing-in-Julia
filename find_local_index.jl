# -----Ref: https://juliaparallel.org/MPI.jl/stable/--------
function split_count(N::Integer, n::Integer)
    q, r = divrem(N, n)
    return [i <= r ? q + 1 : q for i = 1:n]
end
# -----------------------------------------------------------
function find_local_index(comm, rank, comm_size, root, N)
    if rank == root
        M = 1
        N_index = collect(1:N)

        test = Matrix{Int64}(reshape(N_index, 1, N))
        output = similar(test)
        # Julia arrays are stored in column-major order, so we need to split along the last dimension
        # dimension
        M_counts = [M for i = 1:comm_size]
        N_counts = split_count(N, comm_size)
        # store sizes in 2 * comm_size Array
        sizes = vcat(M_counts', N_counts')
        size_ubuf = UBuffer(sizes, 2)
        # store number of values to send to each rank in comm_size length Vector
        counts = vec(prod(sizes, dims=1))
        test_vbuf = VBuffer(test, counts) # VBuffer for scatter
        output_vbuf = VBuffer(output, counts) # VBuffer for gather
    else
        # these variables can be set to `nothing` on non-root processes
        size_ubuf = UBuffer(nothing)
        output_vbuf = test_vbuf = VBuffer(nothing)
    end
    MPI.Barrier(comm)
    # ----------------------------------------
    local_size = MPI.Scatter(size_ubuf, NTuple{2,Int}, root, comm)
    local_test = MPI.Scatterv!(test_vbuf, zeros(Int64, local_size), root, comm)
    return local_test
end