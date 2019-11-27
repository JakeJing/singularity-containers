# How to build a singularity-container

This is a short intro to build a container via singularity in ubuntu.

## 1. install go, singularity and other dependencies

There is a nice intro to show how to install singularity in ubuntu (https://sylabs.io/guides/3.5/user-guide/quick_start.html#quick-installation-steps).

Here I provide the bash script to automatically download the install the singularity v3.5.

> bash install-singularity.sh

check whether the singularity is installed successfully

> singularity help


## 2. create a .def file that includes the necessary packages you want to install

I directly fork the template .def files from Taras for building R and Python images, and you can edit the file according to your own need, say installing certain packages or modules. You can easily find some other templates online.


## 3. build the .sif (singularity image file) that can be shared by different machines

You can simply build a .sif file with the following command. It takes some time.

> sudo singularity build singularity-r.sif singularity-r.def

## 4. sharing and testing the image file

> srun singularity exec -u singularity-r.sif Rscript test.R

