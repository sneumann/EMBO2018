FROM container-registry.phenomenal-h2020.eu/bioconductor/release_metabolomics2:latest

MAINTAINER Steffen Neumann <sneumann@ipb-halle.de>

LABEL Description="EMBO2017 course image"

##
## Taken from https://github.com/rocker-org/hadleyverse/blob/master/Dockerfile
## Install some external dependencies. 
##
RUN apt-get update \
  && apt-get install -y --no-install-recommends  \
  && apt-get install -y libxml2-dev \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/

##
## Add required R packages 
##
ADD install.R /tmp/
ADD installBioC.R /tmp/

RUN R -f /tmp/install.R \
  && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

RUN R -f /tmp/installBioC.R \
  && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

## Fix big red startup warning:
RUN echo 'options(repos = c(CRAN = "https://cran.rstudio.com"))' >/usr/local/lib/R/etc/Rprofile.site 

##
## Copy actual analysis
##

# Set-up user folder: 
USER rstudio
ADD dot.rstudio.zip /tmp
WORKDIR /home/rstudio
RUN unzip /tmp/dot.rstudio.zip
ADD MTBLS2.Rmd /home/rstudio/MTBLS2.Rmd
ADD MTBLS2.Rmd /home/rstudio/MTBLS2.bib
ADD MTBLS2.Rmd /home/rstudio/.rstudio/sources/s-A26AA33F/1919306-contents

# Switch back for normal rstudio operation 
USER root
RUN chown -R rstudio /home/rstudio/MTBLS2.Rmd /home/rstudio/.rstudio/
