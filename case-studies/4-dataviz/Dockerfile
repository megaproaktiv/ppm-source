# Use the official R base image
FROM  rocker/r-ubuntu:20.04


# Install required system dependencies for curl
RUN apt-get update 
#RUN apt-get install -y libcurl4-openssl-dev libssl-dev libxml2-dev 
#RUN apt-get install -y libfontconfig1-dev  libfreetype6-dev
#RUN apt-get install -y  libharfbuzz-dev libfribidi-dev

# Install required R packages
RUN R -e "install.packages('tidyverse', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('ggplot2', repos='http://cran.rstudio.com/')"

# Copy your R script to the Docker image
COPY app/scatter.r /app/scatter.R

# Set the working directory
WORKDIR /app

# Command to run the R script and generate the image
CMD ["Rscript", "scatter.R"]

