#!/bin/bash 
#SBATCH -N 4
#SBATCH -n 400
#SBATCH -p general
#SBATCH --job-name="MPI" 
#SBATCH --output="MPI.out"  

export UCX_WARN_UNUSED_ENV_VARS=n
module load openmpi/5.0.2 cuda/11.6 julia/1.10.4
mpirun --map-by core -n 400 julia --project=/gpfs/homefs1/snv22002/Project.toml Parallel_MPI.jl 

# sbatch Script_MPI_HPC.sh
