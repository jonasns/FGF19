#!/bin/bash
#Script used to remove ribosomal RNA still left in the samples after library preparation. Keeps the unmapped reads, which will be the rRNA-depleted files
#Made by Jonas N. Søndergaard, 170303

#UPPMAX commands (Uppsala Multidisciplinary Center for Advanced Computational Science)
#SBATCH -A uppmax_proj_number
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 6:00:00

#load packages. bioinfo-tools is loaded on uppmax in order to load all other packages used.
module load bioinfo-tools
module load bowtie2/2.2.9

#file paths
FQ_PATH=/proj/trimmedFQfiles
OUTPUT_PATH=/proj
REF_PATH=/proj/ref_genomes

#loop to run Bowtie2 alignment to rRNA, and keeping unaligned reads
for i in {1..15}; do \
	FILE_ID=`sed "${i}q;d" ID.list`

	bowtie2 \
		-p 8 \
		--un-conc-gz ${OUTPUT_PATH}/FQfiles_without_rRNA/${FILE_ID}_tc_rmrRNA_R \
		-x ${REF_PATH}/hsap_rRNA \
		-1 ${FQ_PATH}/${FILE_ID}_tc_R1.fastq.gz \
		-2 ${FQ_PATH}/${FILE_ID}_tc_R2.fastq.gz \
		-S ${OUTPUT_PATH}/results_rRNA_alignment/${FILE_ID}_rRNA_hits.sam
done


#Readme:
#-p specifies the number of computational cores/threads that will be used by the program
#--un-conc-gz: Write paired-end reads that fail to align concordantly to file(s) at <path>. Useful for rRNA removal
#--summary-file: Print alignment summary to this file
#-x path to the pre-built genome index
#-1 the first-read mate FASTQ file
#-2 the second-read mate FASTQ file
#-S name of the result file that will be created
