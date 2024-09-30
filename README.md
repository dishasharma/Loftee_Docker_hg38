# Loftee_Docker

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export PERL5LIB=/LofteeTool/loftee:$PERL5LIB

/LofteeTool/ensembl-vep/vep \
--input_file <vcf_file_path_in_gz> \
--output_file <output_file_name> \
--vcf --offline --phased --cache --dir_cache <cache_directory> \
--assembly GRCh38 \
--plugin LoF,loftee_path:<path_to_loftee_folder>/loftee,human_ancestor_fa:<path_to_ancestry_file>/human_ancestor.fa.gz,conservation_file:<path_to_conservation_file>/gerp_conservation_scores.homo_sapiens.GRCh38.bw \
--force_overwrite