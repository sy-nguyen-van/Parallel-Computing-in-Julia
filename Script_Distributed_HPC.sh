#!/bin/bash
#SBATCH -N 1
#SBATCH -n 100
#SBATCH -p general
#SBATCH --job-name="Distributed"
#SBATCH --output="Distributed.out"
 
module load  julia/1.10.4
julia -p 60 --project=/gpfs/homefs1/snv22002/Project.toml  Parallel_Threads_Distributed.jl

# sbatch Script_Distributed_HPC.sh