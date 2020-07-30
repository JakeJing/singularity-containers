#!/bin/bash
#SBATCH --qos=medium
#SBATCH --time=48:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=8GB
module load generic
# you can also use HPC or Hydra partitions, which are faster (see: https://www.zi.uzh.ch/en/teaching-and-research/science-it/infrastructure/sciencecluster/cpu-partitions.html)
module load singularity
srun singularity exec -u r_latest.sif Rscript test.R




