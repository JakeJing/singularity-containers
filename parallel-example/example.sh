#!/bin/bash
#SBATCH --qos=medium
#SBATCH --time=01:00:00
#SBATCH --array=[1-12]
#SBATCH --nodes=1
#SBATCH --output=Rout/par-%J.out
#SBATCH --error=Rout/par-%J.err
#SBATCH --cpus-per-task=1
#SBATCH --mem=2GB
module load generic
module load singularity

srun singularity exec -u r_latest.sif Rscript R_cluster_example.R Rout/example_slurm${SLURM_ARRAY_TASK_ID}.Rout
