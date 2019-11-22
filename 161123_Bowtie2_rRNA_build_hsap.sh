#!/bin/bash
#script to build human rRNA reference genome index files for Bowtie2
#Made by Jonas N. Søndergaard, 161123
#the human_rRNA.fa file was curated by Wenjing Kang (Kang, W., Eldfjell, Y., Fromm, B. et al. miRTrace reveals the organismal origins of microRNA sequencing data. Genome Biol 19, 213 (2018) doi:10.1186/s13059-018-1588-9)

#UPPMAX commands (Uppsala Multidisciplinary Center for Advanced Computational Science)
#SBATCH -A uppmax_proj_number
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 2:00:00

#load packages. bioinfo-tools is loaded on uppmax in order to load all other packages used.
module load bioinfo-tools
module load bowtie2/2.2.9

bowtie2-build \
	/proj/ref_genomes/human_rRNA.fa \
	/proj/ref_genomes/hsap_rRNA \
