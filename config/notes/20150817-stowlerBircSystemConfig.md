# stowler BIRC system config: rama.birc.emory.edu on Monday 20150817

_More install/config/testing to be done but this is what I completed today._

Contents
=================

  * [installed git](#installed-git)
  * [installed and synchronized vcsh and mr](#installed-and-synchronized-vcsh-and-mr)
  * [installed vim and command\-line utilities](#installed-vim-and-command-line-utilities)
  * [installed R](#installed-r)
    * [updated apt sources and R packages](#updated-apt-sources-and-r-packages)
    * [updated the installed packages from within R](#updated-the-installed-packages-from-within-r)
    * [installed support for rgl and Rcmdr](#installed-support-for-rgl-and-rcmdr)
    * [compiled R packages and dependencies](#compiled-r-packages-and-dependencies)


# installed git

```bash
$ git --version
The program 'git' is currently not installed. You can install it by typing:
sudo apt-get install git

sudo apt-add-repository ppa:git-core/ppa
sudo apt-get update
sudo apt-get install git

```


# installed and synchronized vcsh and mr

```bash
$ mkdir ${HOME}/src.upstream.gitRepos
$ cd ${HOME}/src.upstream.gitRepos
$ git clone git://github.com/RichiH/vcsh.git
$ sudo mkdir -p /usr/local/bin
$ sudo ln -s ${HOME}/src.upstream.gitRepos/vcsh/vcsh /usr/local/bin/
$ ls -l /usr/local/bin

$ cd ${HOME}/src.upstream.gitRepos
$ git clone git://myrepos.branchable.com/myrepos
$ cd myrepos
$ sudo make install

$ mv ~/.profile ~/.orig_profile
$ mv ~/.bashrc ~/.orig_bashrc
$ vcsh clone https://github.com/stowler/mr.git mr
$ mr up

```

# installed vim and command-line utilities


```bash
$ sudo apt-get install vim vim-doc wget tmux tree htop slurm imagemagick aptitude
```

# installed R


## updated apt sources and R packages

After removing R packages from non-cran apt sources, I edited apt sources:

```bash
$ sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9  
# add this line to /etc/apt/sources.list for 14.04 Trusty, or modify for your ubuntu release per the README  
# deb http://cran.stat.ucla.edu/bin/linux/ubuntu trusty/  

$ sudo apt-get update 
$ sudo apt-get install r-base r-base-dev
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following extra packages will be installed:
  liblzma-dev r-base-core r-base-html r-cran-boot r-cran-class r-cran-cluster
  r-cran-codetools r-cran-foreign r-cran-kernsmooth r-cran-lattice r-cran-mass
  r-cran-matrix r-cran-mgcv r-cran-nlme r-cran-nnet r-cran-rpart
  r-cran-spatial r-cran-survival r-recommended
Suggested packages:
  liblzma-doc ess r-doc-info r-doc-pdf r-mathlib texlive-base
  texlive-latex-base texlive-generic-recommended texlive-fonts-recommended
  texlive-fonts-extra texlive-extra-utils texlive-latex-recommended
  texlive-latex-extra texinfo
The following NEW packages will be installed:
  liblzma-dev r-base r-base-core r-base-dev r-base-html r-cran-boot
  r-cran-class r-cran-cluster r-cran-codetools r-cran-foreign
  r-cran-kernsmooth r-cran-lattice r-cran-mass r-cran-matrix r-cran-mgcv
  r-cran-nlme r-cran-nnet r-cran-rpart r-cran-spatial r-cran-survival
  r-recommended
0 upgraded, 21 newly installed, 0 to remove and 7 not upgraded.
Need to get 36.3 MB of archives.
After this operation, 57.0 MB of additional disk space will be used.
Do you want to continue? [Y/n] Y

```

## updated the installed packages from within R

```
$ sudo R --no-save  
> update.packages(ask=FALSE)  
> q()
```

## installed support for rgl and Rcmdr

```bash
 # rgl dependencies from apt sources:
 $ sudo apt-get install xserver-xorg-dev libx11-dev libglu1-mesa-dev mesa-utils glew-utils

 # Rcmdr dependencies from apt sources:
 # ...could apt-get install r-cran-rjava, but may be better to just install its deps:
 $ sudo apt-get install default-jre default-jdk unixodbc-dev
 $ sudo R CMD javareconf

 # RcmdrPlugin.HH dependencies from apt sources:
 $ sudo apt-get install libgmp-dev libmpfr-dev
```

## compiled R packages and dependencies

```
$ sudo R --no-save  
> install.packages('rgl', dependencies=TRUE)  
> install.packages('car', dependencies=TRUE)  
> install.packages('XLConnect', dependencies=TRUE)  
> install.packages('Rcmdr', dependencies=TRUE)  
> install.packages('RcmdrPlugin.HH', dependencies=TRUE)  
> q()
```
