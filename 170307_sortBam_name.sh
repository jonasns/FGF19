#!/bin/bash
#Script used to sort BAMfiles by name
#Made by Jonas N. Søndergaard
#Made on 170307

#UPPMAX commands (Uppsala Multidisciplinary Center for Advanced Computational Science)
#SBATCH -A uppmax_proj_number
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 8:00:00

#load packages. bioinfo-tools is loaded on uppmax in order to load all other packages used.
module load bioinfo-tools
module load samtools/1.3.1

#file paths
BAM_PATH=/proj/Tophat2_alignment

#loop to sort all BAMfiles by name
for i in {1..15}; do \
	FILE_ID=`sed "${i}q;d" ID.list`
	
	samtools sort -n \
  		${BAM_PATH}/${FILE_ID}.dir/accepted_hits.bam \
  		${BAM_PATH}/${FILE_ID}.dir/${FILE_ID}_accepted_hits.sorted.bam

done

#Readme:
#-n: sorts the BAMfile by name. In htseq-count, you can choose how your bam is sorted, however, default is by name!
