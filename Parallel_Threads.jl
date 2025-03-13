using LinearAlgebra
using BenchmarkTools
using Base.Threads
# -------------------------
function my_func(N)
    A = zeros(N)
    for e = 1:N
        A[e] = norm(ones(N, N))
    end
end
# -------------------------
function my_func_threads(N)
    A = zeros(N)
    @threads for e = 1:N
        A[e] = norm(ones(N, N))
    end
end
# ==========
N = 1000
print("Sequential computing", "\n")
@btime my_func(N);
print("Multi-threading", "\n")
@btime my_func_threads(N);

# julia --threads 8 Parallel_Threads.jl
