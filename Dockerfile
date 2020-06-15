FROM continuumio/miniconda3:4.5.11

RUN apt-get update -y; apt-get upgrade -y; \
    apt-get install -y vim-tiny vim-athena ssh \
    build-essential gcc gfortran g++

COPY environment.yml environment.yml
RUN conda env create -f environment.yml
RUN echo "alias l='ls -lah'" >> ~/.bashrc

RUN echo "source activate r-shiny" >> ~/.bashrc

ENV CONDA_EXE /opt/conda/bin/conda
ENV CONDA_PREFIX /opt/conda/envs/r-shiny
ENV CONDA_PYTHON_EXE /opt/conda/bin/python
ENV CONDA_PROMPT_MODIFIER (r-shiny)
ENV CONDA_DEFAULT_ENV r-shiny
ENV PATH /opt/conda/envs/r-shiny/bin:/opt/conda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# This is how we install custom R packages
# RUN R -e "install.packages(c('devtools', 'shiny', 'dplyr'), repos = 'http://cran.us.r-project.org')"

# Copy our app.R (or the entire project)
COPY app.R ./

CMD ["/bin/bash", "-c", "./app.R"]
