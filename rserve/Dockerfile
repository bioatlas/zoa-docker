FROM rocker/ropensci:3.4.1

RUN R -e 'install.packages("Rserve", repos = "http://cran.csiro.au/")'
RUN R -e 'install.packages("ade4", repos = "http://cran.csiro.au/")'
RUN R -e 'install.packages("adehabitatHR", repos = "http://cran.csiro.au/")'
RUN R -e 'install.packages("adehabitatMA", repos = "http://cran.csiro.au/")'
RUN R -e 'install.packages("maptools", repos = "http://cran.csiro.au/")'
RUN R -e 'install.packages("shapefiles", repos = "http://cran.csiro.au/")'
RUN R -e 'install.packages("alphahull", repos = "http://cran.csiro.au/")'
RUN R -e 'install.packages("plyr", repos = "http://cran.csiro.au/")'
RUN R -e 'install.packages("spatstat", repos = "http://cran.csiro.au/")'
RUN R -e 'install.packages("Grid2Polygons", repos = "http://cran.csiro.au/")'
RUN R -e 'install.packages("googleVis", repos = "http://cran.csiro.au/")'
RUN R -e 'install.packages("spacetime", repos = "http://cran.csiro.au/")'

COPY kftrack_0.70-x64.tar.gz /tmp/kftrack_0.70-x64.tar.gz
COPY ukfsst_0.3-x64.tar.gz /tmp/ukfsst_0.3-x64.tar.gz

RUN R -e 'install.packages("/tmp/kftrack_0.70-x64.tar.gz", repos = NULL)'

RUN R -e 'install.packages("date", repos = "http://cran.csiro.au/")'
RUN R -e 'install.packages("ncdf", repos = "http://cran.csiro.au/")'

RUN R -e 'install.packages("/tmp/ukfsst_0.3-x64.tar.gz", repos = NULL)'

RUN R -e 'devtools::install_github("trestletech/plumber")'

WORKDIR /root

EXPOSE 6311

ENTRYPOINT R -e "Rserve::run.Rserve(remote = TRUE)"

#CMD ["R", "CMD", "Rserve"]
