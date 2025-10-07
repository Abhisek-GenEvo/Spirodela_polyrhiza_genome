#!/bin/bash

#SBATCH -J satsuma            # Job name
#SBATCH -o satsuma.%j.out       # Specify stdout output file (%j expands to jobId)
#SBATCH -p bigmem                   # Queue name 'smp' or 'parallel' on Mogon II
#SBATCH -n 1                     # Total number of tasks, here explicitly 1
#SBATCH -c 20                    # Total number of cores for the single task
#SBATCH --mem 340G                # The default is 300M memory per job. You'll likely have to adapt this to your needs
#SBATCH -t 36:00:00              # Run time (hh:mm:ss)

#SBATCH -A m2_jgu-evoltroph     # Specify allocation to charge against

#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=achakrab@uni-mainz.de

## Load all necessary modules if needed
export SATSUMA2_PATH=/lustre/project/m2_jgu-evoltroph/achakrab/Softwares/satsuma2/product/bin/
Chromosemble -t Sp_polyrhiza_9509_ref_nuclear.fasta -q SP162_polished_Hap1.fasta -o SP162_chromosemble -n 20 -thorough 1
