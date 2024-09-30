# Loftee_Docker
#Download Files
wget ftp://ftp.ensembl.org/pub/release-112/variation/vep/homo_sapiens_vep_112_GRCh38.tar.gz
wget https://s3.amazonaws.com/bcbio_nextgen/human_ancestor.fa.gz
wget https://s3.amazonaws.com/bcbio_nextgen/human_ancestor.fa.gz.fai
wget https://s3.amazonaws.com/bcbio_nextgen/human_ancestor.fa.gz.gzi
wget https://personal.broadinstitute.org/konradk/loftee_data/GRCh38/gerp_conservation_scores.homo_sapiens.GRCh38.bw
wget https://personal.broadinstitute.org/konradk/loftee_data/GRCh37/phylocsf_gerp.sql.gz


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