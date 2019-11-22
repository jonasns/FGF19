#!/bin/bash
#script made to trim away adapters and cut away poor quality ends of RNA-seq reads.
#Made by Jonas N. Søndergaard
#Made on 170302

#UPPMAX commands (Uppsala Multidisciplinary Center for Advanced Computational Science)
#SBATCH -A uppmax_proj_number 
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 2:00:00

#load packages. bioinfo-tools is loaded on uppmax in order to load all other packages used.
module load bioinfo-tools
module load trimmomatic/0.32

#file paths
FQ_PATH=/proj/FQfiles
OUTPUT_PATH=/proj/trimmedFQfiles

#loop to run Trimmomatic for 15 files
for i in {1..15}; do \
	FILE_ID=`sed "${i}q;d" ID.list`


	java -jar $TRIMMOMATIC_HOME/trimmomatic.jar \
		PE \
		-phred33 \
		${FQ_PATH}/${FILE_ID}_R1.fastq.gz \
		${FQ_PATH}/${FILE_ID}_R2.fastq.gz \
		${OUTPUT_PATH}/${FILE_ID}_tc_R1.fastq.gz \
		${OUTPUT_PATH}/${FILE_ID}_tc_unpaired_R1.fastq.gz \
		${OUTPUT_PATH}/${FILE_ID}_tc_R2.fastq.gz \
		${OUTPUT_PATH}/${FILE_ID}_tc_unpaired_R2.fastq.gz \
		ILLUMINACLIP:/proj/TruSeq3-PE-2.fa:2:30:10 \
		CROP:73 \
		HEADCROP:10 \
		LEADING:3 \
		TRAILING:3 \
		SLIDINGWINDOW:4:15 \
		MINLEN:20

done

#README
#PE: reads are paired end
#-phred33: the quality pipeline used
#ILLUMINACLIP: remove Illumina adapters
#CROP: cut away all bases after this base # from the end of the read
#HEADCROP: cut away the first bases corresponding to the #
#LEADING: remove leading low quality or N bases (below quality 3) 
#TRAILING: Remove trailing low quality or N bases (below quality 3)
#SLIDINGWINDOW: Scan the read with a 4-base wide sliding window, cutting when the average quality per base drops below 15 
#MINLEN: minimum length of reads to keep.
