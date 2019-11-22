#!/bin/bash
#Script used to count reads overlapping with an annotated genome assembly
#Made by Jonas N. Søndergaard
#Made on 170307

#UPPMAX commands (Uppsala Multidisciplinary Center for Advanced Computational Science)
#SBATCH -A uppmax_proj_number
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 6:00:00

#load packages. bioinfo-tools is loaded on uppmax in order to load all other packages used.
module load bioinfo-tools
module load htseq/0.7.0

#file paths
BAM_PATH=/proj/Tophat2_alignment
REF_PATH=/proj/ref_genomes
OUTPUT_PATH=/proj/HTseq_count

#loop to run HTseq-count on all files:
for i in {1..15}; do \
	FILE_ID=`sed "${i}q;d" ID.list`

	htseq-count \
		-f bam \
		--stranded=reverse \
		-t exon \
  		${BAM_PATH}/${FILE_ID}.dir/${FILE_ID}_accepted_hits.sorted.bam \
  		${REF_PATH}/gencode.v25.chr_patch_hapl_scaff.annotation.gtf \
		> ${OUTPUT_PATH}/${FILE_ID}.exonlevel.stranded.counts
done

#Readme
#-f: format of input files
#--stranded=reverse: reverse-stranded is selected for Illumina stranded libraries
#-t: feature type (3rd column in GFF file) to be used, all features of other type are ignored (default, suitable for RNA-Seq analysis using an Ensembl GTF file: exon) 
