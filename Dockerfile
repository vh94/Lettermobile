FROM rocker/r-ver:4.0.4
RUN apt-get update && apt-get install -y  git-core libcurl4-openssl-dev libgit2-dev libicu-dev libssl-dev libxml2-dev make pandoc pandoc-citeproc && rm -rf /var/lib/apt/lists/*
RUN echo "options(repos = c(CRAN = 'https://cran.rstudio.com/'), download.file.method = 'libcurl', Ncpus = 4)" >> /usr/local/lib/R/etc/Rprofile.site
RUN R -e 'install.packages("remotes")'
RUN Rscript -e 'remotes::install_version("processx",upgrade="never", version = "3.5.1")'
RUN Rscript -e 'remotes::install_version("base64enc",upgrade="never", version = "0.1-3")'
RUN Rscript -e 'remotes::install_version("htmltools",upgrade="never", version = "0.5.1.1")'
RUN Rscript -e 'remotes::install_version("knitr",upgrade="never", version = "1.31")'
RUN Rscript -e 'remotes::install_version("pkgload",upgrade="never", version = "1.2.0")'
RUN Rscript -e 'remotes::install_version("shiny",upgrade="never", version = "1.6.0")'
RUN Rscript -e 'remotes::install_version("rmarkdown",upgrade="never", version = "2.7")'
RUN Rscript -e 'remotes::install_version("testthat",upgrade="never", version = "3.0.2")'
RUN Rscript -e 'remotes::install_version("config",upgrade="never", version = "0.3.1")'
RUN Rscript -e 'remotes::install_version("spelling",upgrade="never", version = "2.2")'
RUN Rscript -e 'remotes::install_version("qpdf",upgrade="never", version = "1.1")'
RUN Rscript -e 'remotes::install_version("komaletter",upgrade="never", version = "0.4.2")'
RUN Rscript -e 'remotes::install_github("RinteRface/shinyMobile@4f8917ace5877963db1a9971c7b9cdbd7ac1889b")'
RUN Rscript -e 'remotes::install_github("ThinkR-open/golem@313ebfaf1d79ba4bb6c66954c0e56bf469746217")'
RUN mkdir /build_zone
ADD . /build_zone
WORKDIR /build_zone
RUN R -e 'remotes::install_local(upgrade="never")'
RUN rm -rf /build_zone
EXPOSE 80
CMD R -e "options('shiny.port'=80,shiny.host='0.0.0.0');Lettermobile::run_app()"
