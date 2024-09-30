# Stage 1: Builder
FROM ubuntu:20.04 AS builder

# Set non-interactive mode
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /LofteeTool

# Update packages and install required dependencies
RUN apt-get -y update && apt-get install -y \
    build-essential \
    curl \
    git \
    libpng-dev \
    libexpat1-dev \
    zlib1g-dev \
    libbz2-dev \
    liblzma-dev \
    libxml2-dev \
    libmysqlclient-dev \
    perl \
    unzip \
    wget \
    cpanminus \
    libncurses5-dev \
    libhts-dev \
    libncursesw5-dev \
    samtools \
    libcurl4-openssl-dev \
    libc++-dev \
    libgsl-dev \
    locales \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

    # Configure locales
RUN locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

# Install required Perl modules
RUN cpanm XML::LibXML DBI Set::IntervalTree JSON Text::CSV PerlIO::gzip IO::Uncompress::Gunzip Test::Warnings Sereal HTML::Lint DBD::mysql LWP::Simple XML::Parser XML::Twig XML::DOM 

RUN cpanm Bio::SeqIO::entrezgene 
RUN cpanm Bio::Root::IO 
RUN cpanm Bio::DB::Taxonomy Bio::SeqIO Bio::WebAgent Bio::DB::Query::WebQuery 
RUN cpanm Bio::DB::GenBank Bio::DB::WebDBSeqI Bio::DB::DBFetch Bio::Perl DBD::SQLite

# Install Bio::DB::HTS and its Tabix module
#RUN wget http://www.cpan.org/authors/id/A/AV/AVULLO/Bio-DB-HTS-3.01.tar.gz && \
#    tar -xvzf Bio-DB-HTS-3.01.tar.gz && \
#    cd Bio-DB-HTS-3.01 && \
#    perl INSTALL.pl && \
    #cpanm Bio::DB::HTS::Tabix && \
#    cd .. 
    #&& rm -rf Bio-DB-HTS-3.01.tar.gz Bio-DB-HTS-3.01

# Clone and install Ensembl API
RUN git clone https://github.com/Ensembl/ensembl.git && \
    cd ensembl && \
    cpanm --installdeps . && \
    cd .. && rm -rf ensembl

# Clone and install Ensembl VEP
RUN git clone https://github.com/Ensembl/ensembl-vep.git && \
    cd ensembl-vep && \
    perl INSTALL.pl && \
    cd ..

# Clone Loftee repository
RUN git clone https://github.com/konradjk/loftee.git

# Final cleanup of temporary files
#RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Specify any additional commands if necessary

