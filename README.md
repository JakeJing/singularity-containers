# How to build a singularity-container

This is a short intro to build a container via singularity in ubuntu

## 1. install go, singularity and other dependencies

There is a nice intro to show how to install singularity in ubuntu (https://sylabs.io/guides/3.5/user-guide/quick_start.html#quick-installation-steps).

Here I provide the bash script to automatically download the install the singularity v3.5.

> bash install-singularity.sh

check whether the singularity is installed successfully

> singularity help

## 2. create a .def file that includes the necessary packages you want to install

I directly fork the template .def files from Taras for building R and Python images, and you can edit the file according to your own need, say installing certain packages or modules. You can easily find some other templates online.

## 3. build the .sif (singularity image file) that can be shared by different machines

You can simply build a .sif file with the following command. It takes some time. Note: the new **singularity-rstan.def** supports for the **devtools** in R. 

> sudo singularity build singularity-rstan.sif singularity-rstan.def

You can run the shell inside the singularity, and see whether the packages are successfully installed.

```bash
singularity shell singularity-rstan.sif # open singularity virtual env
R
>> library(ggplot2)
```
You can still install some additional packages to the singularity container. The additional packages will also be added in the sandbox. For example,

```R
singularity shell singularity-rstan.sif # open singularity virtual env
R
>> install.packages("data.table")
```

Alternatively, you can run a R script via `singularity exec`. See the test example in the folder of R. 

```bash
singularity exec singularity-rstan.sif Rscript test.R # (Not recommend, better first build sanbox)
```

**Note:** you need to edit the line inside the **singularity-r.def** file to decide which R version to install, such as R version 4.0.1.

> ```
> deb http://cloud.r-project.org/bin/linux/debian buster-cran40/
> ```

## 4. build a sandbox

It is necessary to build a sandbox from the .sif file, so that you can direcly load the data from the sandbox, rather than creating a lot of containers and use up of all of the temporary storage in the /tmp folder. With the sanbox, you can run the batch scriptby by specifying the path of sanbox, instead of using the .sif file. Pls check the **example.sh** in the parallel-example to see how to run teh script via sandbox.

> singularity build --sandbox singularity-rstan singularity-rstan.sif

## 5. sharing and testing the image file

```bash
sbatch example.sh

srun singularity exec -u singularity-rstan Rscript test.R

srun singularity exec -u sandbox/singularity-rstan Rscript R_cluster_example.R  # (preferred)

singularity exec /crex/proj/evolang2022/yingqi/sandbox/singularity-rstan Rscript -e "id=1; iters = 3000; thins = 5; nchains = 1; rmarkdown::render('script.Rmd', output_format = c('html_document'), output_file = paste('Rout/', 'out-1', '.html', sep=''))"
```

## 6. julia in Ubuntu

### (1) install julia in ubuntu

There is also a bash script inside the repository, and you can download and run the script in the cluster. It will automatically install the julia for you.

```bash
wget https://raw.githubusercontent.com/JakeJing/singularity-containers/master/install-julia-ubuntu.sh
sudo bash install-julia-ubuntu.sh
```

### (2) create julia container and sandbox

```bash
sudo singularity build singularity-juliabase.sif singularity-juliabase.def
singularity build --sandbox singularity-juliabase singularity-juliabase.sif
```

### (3) prepare the bash script and julia script

Note that the **.def** file for julia container uses its own package path, and you need to export the package directory in the bash script (see details in `run-julia.sh`).

```bash
export JULIA_PKGDIR="sandbox/singularity-juliabase/user/.julia"
```

Moreover, to get the task id in julia script you can use `ENV["SLURM_ARRAY_TASK_ID"]` to get access to it (see **intro.jl**).

```julia
ID = parse(Int64, ENV["SLURM_ARRAY_TASK_ID"])
```

## Other useful commands for singularity

(1) Inspect the definition file from a singularity container

```bash
singularity inspect --deffile singularity-rstan.sif
```

(2) bind or mount a folder to a singularity container (see also the [singularity doc](https://sylabs.io/guides/3.0/user-guide/bind_paths_and_mounts.html))

```bash
ls /data
# bar  foo

singularity exec --bind /data:/mnt my_container.sif ls /mnt
# bar  foo

# bind multiple directories
singularity shell --bind /opt,/data:/mnt my_container.sif
```

