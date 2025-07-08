# 🚀 Accelerate Your Julia Simulations with Parallel Computing

This repository showcases three parallel computing techniques to speed up simulations or computational tasks in Julia.  
Clone the code, experiment with each method, and optimize your workflows! 🎉

## 1️⃣ Multi-Threading
Leverage Julia’s built-in multi-threading to run tasks concurrently on multiple CPU threads. Ideal for shared-memory systems.

**Run the example:**
```
julia --threads 8 Parallel_Threads.jl
```

## 2️⃣ Distributed Computing with Distributed.jl
Distribute tasks across multiple cores or machines using Julia’s **`Distributed.jl`** standard library. Suitable for independent computations with minimal setup.

**Run the example:**
```
julia -p 8 Parallel_Distributed.jl
```
Note: The -p flag specifies the number of worker processes.

## 3️⃣ Distributed Computing with MPI.jl
Distribute tasks across multiple cores or machines using the MPI (Message Passing Interface) standard via **`MPI.jl`**. Best for high-performance, large-scale distributed systems.

**Run the example:**
```
mpiexec -n 8 julia Parallel_MPI.jl
```
Note: The -n flag specifies the number of worker processes. Requires an MPI installation in your system (e.g., OpenMPI or MPICH).

## 📥 Clone this repository

To get started, clone the repository to your local machine using:

```
git clone https://github.com/sy-nguyen-van/Parallel-Computing-in-Julia
```



