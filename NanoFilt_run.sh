#!/bin/bash

#SBATCH -J NanoFilt            # Job name
#SBATCH -o NanoFilt.%j.out       # Specify stdout output file (%j expands to jobId)
#SBATCH -p smp                   # Queue name 'smp' or 'parallel' on Mogon II
#SBATCH -n 1                     # Total number of tasks, here explicitly 1
#SBATCH -c 10                    # Total number of cores for the single task
#SBATCH --mem 100G                # The default is 300M memory per job. You'll likely have to adapt this to your needs
#SBATCH -t 02:00:00              # Run time (hh:mm:ss)

#SBATCH -A m2_jgu-evoltroph     # Specify allocation to charge against

#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=achakrab@uni-mainz.de

## Load all necessary modules if needed
source /lustre/project/m2_jgu-evoltroph/achakrab/anaconda3/bin/activate
conda activate Assembly_env
NanoFilt -q 10 -l 5000 SP162_ONT.fq > HQ_ONT_reads.fastq
