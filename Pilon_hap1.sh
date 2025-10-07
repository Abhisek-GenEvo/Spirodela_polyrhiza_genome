#!/bin/bash

#SBATCH -J Pilon_hap1            # Job name
#SBATCH -o Pilon_hap1.%j.out       # Specify stdout output file (%j expands to jobId)
#SBATCH -p bigmem                   # Queue name 'smp' or 'parallel' on Mogon II
#SBATCH -n 1                     # Total number of tasks, here explicitly 1
#SBATCH -c 20                    # Total number of cores for the single task
#SBATCH --mem 350G                # The default is 300M memory per job. You'll likely have to adapt this to your needs
#SBATCH -t 12:00:00              # Run time (hh:mm:ss)

#SBATCH -A m2_jgu-evoltroph     # Specify allocation to charge against

#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=achakrab@uni-mainz.de

## Load all necessary modules if needed
module load bio/BWA/0.7.17
module load bio/SAMtools/1.17-GCC-12.2.0
bwa index SP162_Haplotype1.fasta
bwa mem -t 20 SP162_Haplotype1.fasta SP162_Illumina_R1_paired.fastq SP162_Illumina_R2_paired.fastq -o SP162_pilon_hap1.sam
samtools view -S SP162_pilon_hap1.sam -b -o SP162_pilon_hap1.bam -@ 20
samtools sort SP162_pilon_hap1.bam -o SP162_pilon_hap1_sorted.bam -@ 20 -m 17000000000
samtools index SP162_pilon_hap1_sorted.bam
module load lang/Java/17.0.1
module load bio/Pilon/1.23-Java-11
java -Xmx350G -jar $EBROOTPILON/pilon.jar --genome SP162_Haplotype1.fasta --bam SP162_pilon_hap1_sorted.bam --output SP162_Pilon_Hap1 --outdir SP162_Pilon_Hap1_outdir --threads 20 --changes --vcf --fix snps,indels,local
