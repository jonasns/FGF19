#!/bin/bash
#Script used to align RNA-seq reads to a reference genome with TopHat2
#Made by Jonas N. Søndergaard
#Made on 170306

#UPPMAX commands (Uppsala Multidisciplinary Center for Advanced Computational Science)
#SBATCH -A uppmax_proj_number
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 10:00:00

#load packages. bioinfo-tools is loaded on uppmax in order to load all other packages used.
module load bioinfo-tools
module load tophat/2.0.3
module load samtools/1.3.1
module load bowtie2/2.2.9

#file paths
FQ_PATH=/proj/FQfiles_without_rRNA
OUTPUT_PATH=/proj/Tophat2_alignment
REF_PATH=/proj/ref_genomes

#loop to run Tophat2 alignment to a reference genome.
for i in {1..15}; do \
	FILE_ID=`sed "${i}q;d" ID.list`
	
	tophat2 \
		-p 8 \
 		--output-dir ${OUTPUT_PATH}/${FILE_ID}.dir \
		--library-type fr-firststrand \
		${REF_PATH}/GRCh38.p7.genome \
		${FQ_PATH}/${FILE_ID}_tc_rmrRNA_R1.fastq.gz \
		${FQ_PATH}/${FILE_ID}_tc_rmrRNA_R2.fastq.gz

done

#Readme:
#-p: specifies the number of computational cores/threads that will be used by the program
#--library-type: fr-firstrand is selected for Illumina stranded libraries
