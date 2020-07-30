#!/bin/bash
#SBATCH --qos=medium
#SBATCH --time=01:00:00
#SBATCH --array=[1-2]
#SBATCH --nodes=1
#SBATCH --output=Rout/par-%J.out
#SBATCH --error=Rout/par-%J.err
#SBATCH --cpus-per-task=1
#SBATCH --mem=2GB
module load generic
module load singularity

# you can also use HPC or Hydra partitions, which are faster (see: https://www.zi.uzh.ch/en/teaching-and-research/science-it/infrastructure/sciencecluster/cpu-partitions.html)

export JULIA_PKGDIR="sandbox/singularity-juliabase/user/.julia"

srun singularity exec -u sandbox/singularity-juliabase julia intro.jl ${SLURM_ARRAY_TASK_ID}


