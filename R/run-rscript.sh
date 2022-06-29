#!/bin/bash
#SBATCH --qos=medium
#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --output=Rout/par-%J.out
#SBATCH --error=Rout/par-%J.err
#SBATCH --cpus-per-task=1
#SBATCH --mem=2GB
#SBATCH --array=[1-12]

module load generic
module load singularity

# you can also use HPC or Hydra partitions, which are faster (see: https://www.zi.uzh.ch/en/teaching-and-research/science-it/infrastructure/sciencecluster/cpu-partitions.html)

# for details use bash command >> module avail

export id=$SLURM_ARRAY_TASK_ID
echo $id

srun singularity exec -u sandbox/singularity-r Rscript R_intro.R Rout/example_slurm${SLURM_ARRAY_TASK_ID}.Rout
