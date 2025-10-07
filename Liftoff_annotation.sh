#!/bin/bash

#SBATCH -J liftoff            # Job name
#SBATCH -o liftoff.%j.out       # Specify stdout output file (%j expands to jobId)
#SBATCH -p smp                   # Queue name 'smp' or 'parallel' on Mogon II
#SBATCH -n 1                     # Total number of tasks, here explicitly 1
#SBATCH -c 10                    # Total number of cores for the single task
#SBATCH --mem 80G                # The default is 300M memory per job. You'll likely have to adapt this to your needs
#SBATCH -t 04:00:00              # Run time (hh:mm:ss)

#SBATCH -A m2_jgu-evoltroph     # Specify allocation to charge against

#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=achakrab@uni-mainz.de

## Load all necessary modules if needed
source /lustre/project/m2_jgu-evoltroph/achakrab/anaconda3/bin/activate
conda activate Assembly_env
liftoff SP162_pseudochromosomes_nuclear.fasta Sp_polyrhiza_9509_ref_nuclear.fasta -g Sp_polyrhiza_9509_ref_nuclear.gff3 -o Liftoff_SP162.gff3 -u unmapped_Liftoff.txt -dir Liftoff_SP162_dir -p 10 -polish -exclude_partial -copies -sc 0.90
