# Lettermobile
ShinyMobile App with Komaletter

## Dependencies:

```bash: as root
# update indices
apt update -qq
# install two helper packages we need
apt install --no-install-recommends software-properties-common dirmngr
# import the signing key (by Michael Rutter) for these repo
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
# add the R 4.0 repo from CRAN -- adjust 'focal' to 'groovy' or 'bionic' as needed
add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
# install R
apt install --no-install-recommends r-base
# add cran repo
add-apt-repository ppa:c2d4u.team/c2d4u4.0+
```

see :
https://cloud.r-project.org/bin/linux/ubuntu/

Install packages using R 

``` r
install.packages(c("tinytex","shinyMobile","komaletter","qpdf","golem"))
## warning: this will update your Tex Live installation
## this stack will have many dependencies, installation will be timeconsuming.
```

