#!/bin/bash
#script to build reference genome index files for Bowtie2
#made by Jonas N. Søndergaard, 161123

#UPPMAX commands (Uppsala Multidisciplinary Center for Advanced Computational Science)
#SBATCH -A uppmax_proj_number
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 2:00:00

#load packages. bioinfo-tools is loaded on uppmax in order to load all other packages used.
module load bioinfo-tools
module load bowtie2/2.2.9

#use Bowtie2 to build reference genome
bowtie2-build \
	/proj/ref_genomes/GRCh38.p7.genome.fa \
	/proj/ref_genomes/GRCh38.p7.genome

