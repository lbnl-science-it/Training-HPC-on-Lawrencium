% HPC on Lawrencium Supercluster
% Novermber 10, 2021
% Wei Feinstein


# Introduction

Slides and sample codes can be found on github [https://github.com/lbnl-science-it/Training-HPC-on-Lawrencium](https://github.com/lbnl-science-it/Training-HPC-on-Lawrencium)

Video will be posted

There will be a hands-on session at the end of this training

[Training survey](https://docs.google.com/forms/d/e/1FAIpQLSeeJ2NyE5Fy6jcapfD9x-JbDR_5xrAhVtdrW0Yyg-LzUpckaA/viewform)
 

# Outline

- Overview of Lawrencium supercluster
- Access to the cluster
  - Project types 
  - User accounts
  - login 
  - Storage/compute space (home, scratch, group, condo storage)
- Data transfer 
  - DTN data transfer node
  - Globus
  - GDrive
- Software stack and installation 
  - Software Module Farm
  - Installation of your own software
- Job submission and monitoring
  - Accounts & partitions
  - Basic job submission
  - Interactive jobs
  - GPU job submission
  - Submit serial tasks in parallel
- Open Ondemand Web Service
  - Overview
  - Jupyter notebooks 
  - Customized kernel
  - Remote visualization  
- Hands-on exercises


# Lawrencium Cluster Overview

- A LBNL Condo Cluster Computing program
  - Support researchers in all disciplines at the Lab
  - Significant investment by the IT division
  - Individual PIs buy in compute nodes and storage
  - Computational cycles are shared among all lawrencium users

- Lawrencium compute nodes
  - data center is housed in the building 50B
  - 1238 CPU Compute nodes, more than 37,192 cores
  - 152 GPU cards 
  - 8 partitions, lr3,..., lr6, es1, cm1
  - ~1300 user accounts
  - ~530 groups 

- Standalone clusters


# Conceptual Diagram of Lawrencium

<left><img src="figures/lrc1.png" width="80%"></left>

[Detailed information of Lawrencium](https://sites.google.com/a/lbl.gov/high-performance-computing-services-group/lbnl-supercluster/lawrencium)


# Getting Access to Lawrencium

#### Three types of Project Accounts

- *Primary Investigator (PI) Computing Allowance (PCA) account*: free 300K SUs per year (pc_xxx)
- *Condo account*: PIs buy in compute nodes to be added to the general pool, in exchange for their own priority access and share the Lawrencium infrastructure (lr_xxx)
- *Recharge account*: pay as you go with minimal recharge rate ~ $0.01/SU (ac_xxx)
- Details about project accounts can be found [http://scs.lbl.gov/getting-an-account](http://scs.lbl.gov/getting-an-account)
- [Request project accounts](https://docs.google.com/forms/d/e/1FAIpQLSeAqRcB61J8x3YAuca4QxgMW6OneLbC8wVRbafHNOZDE-h4Fg/viewform) 
- PIs can grant access researchers/students and external collaborators to their PCA/condo/recharge projects

#### User accounts
- PIs sponsor researchers/students and external collaborators for cluster accounts
- [User account request form](https://docs.google.com/forms/d/e/1FAIpQLSf76kbdJd4GwRQX_iVYVgYwo_wBFmKCcsXyqsnWwlmf_JUgNA/viewform)
- [User agreement](https://sites.google.com/a/lbl.gov/high-performance-computing-services-group/useragreement)


# Login to Lawrencium Cluster

- Linux terminal (command-line) session. 
- Mac terminal (see Applications -> Utilities -> Terminal). 
- Windows [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html).
- One-time passwords (OTPs): set up your smartphone or tablet with Google Authenticator with [Instructions here](https://sites.google.com/a/lbl.gov/high-performance-computing-services-group/authentication/linotp-usage) 
- Login:
```
ssh $USER@lrc-login.lbl.gov
password:
```
- Password: your 4-digit PIN followed by the one-time password from which your Google Authenticator app generates on your phone/tablet.

- **DO NOT run jobs on login nodes!!**


# User Space
 
- Home: `/global/home/users/$USER/` 20GB per user, data is backed up
- Global scratch: `/global/scratch/$USER/`, shared, no backup, where to launch jobs
- Shared group project space
   - /global/home/groups-sw/  200GB backup
   - /global/home/group/ 400GB no backup
- Condo storage: 
  - `e.g. /clusterfs/etna/ or /global/scratch/projects/xxx`


# Data Transfer 

#### lrc-xfer.lbl.gov: Data Transfer Node (DTN)
- On Linux: scp/rsync
```
# Transfer data from a local machine to Lawrencium
scp file-xxx $USER@lrc-xfer.lbl.gov:/global/home/users/$USER
scp -r dir-xxx $USER@lrc-xfer.lbl.gov:/global/scratch/$USER

# Transfer from Lawrencium to a local machine
scp $USER@lrc-xfer.lbl.gov:/global/scratch/$USER/file-xxx ~/Desktop

# Transfer from Lawrencium to Another Institute
ssh $USER@lrc-xfer.lbl.gov   # DTN
scp -r $USER@lrc-xfer.lbl.gov:/file-on-lawrencium $USER@other-institute:/destination/path/$USER

rsync: a better data transfer tool as a backup tool
rsync -avpz file-at-local $USER@lrc-xfer.lbl.gov:/global/home/user/$USER
```
- On Window
  - [WinSCP](https://winscp.net/eng/index.php): SFTP client and FTP client for Microsoft Windows
  - [FileZella](https://filezilla-project.org/): multi-platform program via SFTP

# Data Transfer with Globus

- Globus lets you transfer and share data on your storage systems with collaborators 
- Fast data transfer, refer to [instructions](https://sites.google.com/a/lbl.gov/high-performance-computing-services-group/getting-started/data-transfer)
- Berkeley Lab users can use Globus to transfer files in/out of their LBNL Google drive. Details about Google drive via Globus is [here](https://commons.lbl.gov/display/itdivision/GDrive+Access+Via+Globus)
- Possible endpoints include: lbnl#lrc, your laptop/desktop, NERSC, among others.
- Transfer data to/from your laptop (endpoint setup)
   - Create an endpoint on your machine using Globus Connect Personal [https://www.globus.org/globus-connect-personal](https://www.globus.org/globus-connect-personal)
   - Run Globus Connect Pesonal on your local machine 

<left><img src="figures/globus.jpg" width="60%"></left>


# Software Module Farm 

- Software stack, commonly used compiler, software tools provided to all cluster users
- Installed and maintained on a centralized storage device and mounted as read-only NFS file system
   - Compilers: e.g. intel, gcc, MPI compilers, Python
   - Tools: e.g.matlab, singularity, cuda
   - Applications: e.g. machine learning, QChem, MD, cp2k
   - Libraries: e.g. fftw, lapack

```
[@n0000.scs00 ~]$ module avail
---- /global/software/sl-7.x86_64/modfiles/langs ----
gcc/6.3.0  intel/2016.4.072  python/2.7 python/3.5 cuda/9.0 julia/0.5.0 ...

---- /global/software/sl-7.x86_64/modfiles/tools ----
cmake/3.7.2  gnuplot/5.0.5  octave/4.2.0 matlab/r2017b(default)  ...

---- /global/software/sl-7.x86_64/modfiles/apps ----
bio/blast/2.6.0 math/octave/current ml/tensorflow/2.5.0-py37 ... 
...
```

# Environment Modules

- Manage users’ software environment dynamically 
- Properly set up PATH, LD_LIBRARY_PATH…
- Avoid clashes between incompatible software versions

```  
module purge: clear user’s work environment
module available: check available software packages
module load xxx*: load a package
module list: check currently loaded software 
```
- Modules are arranged in a hierarchical fashion, some of the modules become available only after the parent module(s) are loaded 
- e.g., MKL, FFT, and HDF5/NetCDF software is nested within the gcc module
- Example: load an OpenMPI package
```
module available openmpi mkl
module load intel/2016.4.072
module av openmpi
module load mkl/2016.4.072 openmpi/3.0.1-intel
```
- [More environment modules information](https://sites.google.com/a/lbl.gov/high-performance-computing-services-group/getting-started/sl6-module-farm-guide)
- Users are allowed to install software in their home or group space
- Users don't have admin rights, but most software can be installed 
` --prefix=/dir/to/your/path`


# Install Python Packages

- Python modules: abundantly available but cannot be installed in the default location without admin rights.
- `pip install --user package_name`
- `export PYTHONPATH`
```
[wfeinstein@n0000 ~]$ module available python
--------------------- /global/software/sl-7.x86_64/modfiles/langs -----------------------------------
python/2.7          python/3.5          python/3.6(default) python/3.7          python/3.7.6        python/3.8.2-dll
[wfeinstein@n0000 ~]$ module load python/3.7

[wfeinstein@n0000 ~]$ python3 -m site --user-site
/global/home/users/wfeinstein/.local/lib/python3.7/site-packages

[wfeinstein@n0000 ~]$ pip install --user ml-python
...
Successfully built ml-python
Installing collected packages: ml-python
Successfully installed ml-python-2.2

[wfeinstein@n0000 ~]$ export PYTHONPATH=~/.local/lib/python3.7/site-packages:$PYTHONPATH
```
- pip install: `--install-option="--prefix=$HOME/.local" package_name`
- Install from source code: `python setup.py install –home=/home/user/package_dir`
- Creat a virtual environmemt: `python -m venv my_env`
- Isolated Python environment


# SLURM: Resource Manager & Job Scheduler

### Overview

SLURM is the resource manager and job scheduler to managing all the jobs on the cluster

Why is this necessary? 

- Prevent users' jobs running on the same nodes. 
- Allow everyone to fairly share Lawrencium resources.

Basic workflow:

  - login to Lawrencium; you'll end up on one of the login nodes in your home directory
  - cd to the directory from which you want to submit the job (scratch)
  - submit the job using sbatch (or an interactive job using srun, discussed later)
  - SLURM assign compute node(s) to your jobs
  - your jobs will run on a compute node, not the login node 


# Slurm-related environment variables

- Slurm provides global variables
- Can be used in your job submission scripts to adapt the resources being requested in order to avoid hard-code
- Examples of Slurm variables

  - SLURM_WORKDIR
  - SLURM_NTASKS
  - SLURM_CPUS_PER_TASK
  - SLURM_CPUS_ON_NODE
  - SLURM_NODELIST
  - SLURM_NNODES


# Accounts, Partitions, Quality of Service (QOS)

Check slurm association, such as qos, account, partition, the information is required when submitting a job

```
sacctmgr show association user=wfeinstein -p

Cluster|Account|User|Partition|Share|Priority|GrpJobs|GrpTRES|GrpSubmit|GrpWall|GrpTRESMins|MaxJobs|MaxTRES|MaxTRESPerNode|MaxSubmit|MaxWall|MaxTRESMins|QOS|Def QOS|GrpTRESRunMins|
perceus-00|pc_scs|wfeinstein|lr6|1||||||||||||lr_debug,lr_lowprio,lr_normal|||
perceus-00|ac_test|wfeinstein|lr5|1||||||||||||lr_debug,lr_lowprio,lr_normal|||
perceus-00|pc_test|wfeinstein|lr4|1||||||||||||lr_debug,lr_lowprio,lr_normal|||
perceus-00|pc_test|wfeinstein|lr_bigmem|1||||||||||||lr_debug,lr_lowprio,lr_normal|||
perceus-00|lr_test|wfeinstein|lr3|1||||||||||||condo_test|||
perceus-00|scs|wfeinstein|es1|1||||||||||||es_debug,es_lowprio,es_normal|||
...
```
Lawrencium cluster info click [here](https://sites.google.com/a/lbl.gov/high-performance-computing-services-group/lbnl-supercluster/lawrencium)


# Job Submission
### Submit an Interactive Job

Typically used for code debugging, testing, monitoring

- srun: add your resource request to the queue. 
- When the allocation starts, a new bash session will start up on one of the granted nodes

- `srun --account=ac_xxx --nodes=1 --partition=lr5 --qos=lr_normal --time=1:0:0 --pty bash`
- `srun -A ac_xxx -N 1 -p lr5 -q lr_normal -t 1:0:0 --pty bash`
```
[wfeinstein@n0003 ~]$ srun --account=scs --nodes=1 --partition=lr6 --time=1:0:0 --qos=lr_normal --pty bash
srun: Granted job allocation 28755918
srun: Waiting for resource configuration
srun: Nodes n0101.lr6 are ready for job
[wfeinstein@n0101 ~]$ squeue -u wfeinstein
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
          28755918       lr6     bash wfeinste  R       0:14      1 n0101.lr6
```
Once you are on the assigned compute node, start application/commands directly

- salloc: similarly to *srun --pty bash*. 
- a new bash session will start up on the login node


# Node Features 

Compute nodes may have different hardware within a SLURM partition, e.g. LR6

- lr6_sky: Intel Skylak
- lr6_cas: Intel Cascade Lake
- lr6_cas,lr6_m192: lr6_cas + 192GB RAM
- lr6_sky,lr6_m192: lr6_sky + 192GB RAM   

- When a specific type of node is requsted, wait time typically is longer
- Slurm flag: --constrain 
```
[wfeinstein@n0000 ~]$ srun --account=scs --nodes=1 --partition=lr6 --time=1:0:0 --qos=lr_normal --constrain=lr6_sky --pty bash

[wfeinstein@n0081 ~]$ free -h
              total        used        free      shared  buff/cache   available
Mem:            93G        2.2G         83G        3.1G        7.4G         87G
Swap:          8.0G          0B        8.0G
[wfeinstein@n0081 ~]$ exit
exit
[wfeinstein@n0000 ~]$ srun --account=scs --nodes=1 --partition=lr6 --time=1:0:0 --qos=lr_normal --constrain=lr6_sky,lr6_m192 --pty bash
[wfeinstein@n0023 ~]$ free -h
              total        used        free      shared  buff/cache   available
Mem:           187G        2.6G        172G        1.7G         12G        182G
Swap:          8.0G        1.5G        6.5G
```
- Node features can be found [here](https://sites.google.com/a/lbl.gov/high-performance-computing-services-group/lbnl-supercluster/lawrencium)


# Memeory specification 

- Most Lawrencium partitions are exclusive: a compute node allows only one user
- Some condo accounts or partitions, such as ES1 (GPUs), each compute node can be shared by multiple users   

- Slurm flag: --mem (MB) is required when using a shared partition:
- e.g. a compute node with 96GB RAM, 40 core node: 2300 RAM/core
  - --ntaks=1 --mem=2300 (request one core)
  - --ntaks=2 --mem=4600 (request 2 cores) 

- LR6 partition lr_bigmem: two large memory nodes (1.5TB)
- Slurm flag: --partition=lr_bigmem


# Submit a Batch Job

- Get help with the complete command options
`sbatch --help`
- sbatch: submit a job to the batch queue system
`sbatch myjob.sh`

```
#!/bin/bash -l

# Job name:
#SBATCH --job-name=mytest
#
# Partition:
#SBATCH --partition=lr6
#
# Account:
#SBATCH --account=pc_test
#
# qos:
#SBATCH --qos=lr_normal
#
# Wall clock time:
#SBATCH --time=1:00:00
#
# Node count
#SBATCH --nodes=1
#
# Node feature
#SBATCH --constrain=lr6_cas
#
#SBATCH --mail-user=xxx@lbl.gov
# email type
##SBATCH --mail-type=BEGIN/END/FAIL
#SBATCH --mail-type=ALL

# cd to your work directory
cd /your/dir

## Commands to run
module load python/3.7
python my.py >& mypy.out 
````


# Submit jobs to ES1 GPU partition
#### Interactive GPU Jobs

- --gres=gpu:type:GPU#  
- --ntasks=CPU_CORE#
- ratio CPU_CORE#:GPU# = 2:1
```
srun -A your_acct -N 1 -p es1 --gres=gpu:1 --ntasks=2 -q es_normal –t 0:30:0 --pty bash

[wfeinstein@n0000 ~]$ srun -A scs -N 1 -p es1 --gres=gpu:1 --ntasks=2 -q es_normal -t 0:30:0 --pty bash
[wfeinstein@n0019 ~]$ nvidia-smi
Sat Feb  6 10:13:25 2021       
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 440.44       Driver Version: 440.44       CUDA Version: 10.2     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|===============================+======================+======================|
|   0  Tesla V100-SXM2...  Off  | 00000000:62:00.0 Off |                    0 |
| N/A   45C    P0    53W / 300W |      0MiB / 16160MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
|   1  Tesla V100-SXM2...  Off  | 00000000:89:00.0 Off |                    0 |
| N/A   45C    P0    55W / 300W |      0MiB / 16160MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
                                                                               
+-----------------------------------------------------------------------------+
| Processes:                                                       GPU Memory |
|  GPU       PID   Type   Process name                             Usage      |
|=============================================================================|
|  No running processes found                                                 |
+-----------------------------------------------------------------------------+
```

- Specify GPU type
  - GTX1080TI: --gres=gpu:GTX1080TI:1 (decommissioned)
  - GRTX2080TI: --gres=gpu:GRTX2080TI:1
  - V00: --gres=gpu:V100:1 
  - A40: (6 2U A40 coming up)

```
[wfeinstein@n0000 ~]$ srun -A scs -N 1 -p es1 --gres=gpu:V100:2 --ntasks=4 -q es_normal -t 0:30:0 --pty bash

[wfeinstein@n0016 ~]$ nvidia-smi -L
GPU 0: Tesla V100-SXM2-16GB (UUID: GPU-7979861e-e0ad-000f-95fb-371e34593991)
GPU 1: Tesla V100-SXM2-16GB (UUID: GPU-50d24ac9-9eea-f96b-cc8b-db849f9c9427)

[wfeinstein@n0016 ~]$ echo $CUDA_VISIBLE_DEVICES
0,1
```

# Submit A GPU Batch Job 

Job Submission Script Example 

```
#!/bin/bash -l

#SBATCH --job-name=mytest
#SBATCH --partition=es1         ## es1 GPU partition
#SBATCH --account=pc_test
#SBATCH --qos=es_normal         ## qos of es1
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --gres=gpu:V100:2       ## GPUs
#SBATCH --ntasks=4              ## CPU cores
#
cd /your/dir

## Commands to run
module load python/3.7
python my.py >& mypy.out 
````


# Submit A MPI Job

When use multiple nodes, you need to carefully specify the resources. The key flags for use in your job script are:

- --nodes (or -N): number of nodes 
- --ntasks-per-node: number of tasks (i.e., processes) to run on each node, especially useful when your job uses large memory, < Max Core# on a node 
- --cpus-per-task (or -c): number of CPUs to be used for each task
- --ntasks (or -n): total number of tasks and let the scheduler determine how many nodes and tasks per node are needed. 
- In general --cpus-per-task will be 1 except when running threaded code.

```
#!/bin/bash -l

#SBATCH --job-name=myMPI
#SBATCH --partition=lr6
#SBATCH --account=scs
#SBATCH --qos=lr_normal
#SBATCH --time=2:00:00
#SBATCH --nodes=2                ## Nodes count
##SBATCH --ntasks=80             ## Number of total MPI tasks to launch (example):  
##SBATCH --ntasks-per-node=20    ## important with large memory requirement

cd /your/dir

## Commands to run
module load intel/2016.4.072 openmpi/3.0.1-intel
mpirun -np 80 ./my_mpi_exe        ## Launch your MPI application
````


# Submit serial tasks in Parallel (GNU Parallel) 

GNU Parallel is a shell tool for executing jobs in parallel on one or multiple computers. 

- A job can be a single core serial task, multi-core or MPI application. 
- A job can also be a command that reads from a pipe. 
- Typical input:
  - bash script for a single task
  - a list of tasks with parameters 


# Example using GNU Parallel

Bioinformatics tool *blastp* to compare 200 target protein sequences against sequence DB
 
Serial bash script: **run-blast.sh**
```
#!/bin/bash
module load  bio/blast/2.6.0
blastp -query $1 -db ../blast/db/img_v400_PROT.00 -out $2  -outfmt 7 -max_target_seqs 10 -num_threads 1
```
**task.lst**: each line provides one parameter to one task:
```
[user@n0002 ]$ cat task.lst    
 ../blast/data/protein1.faa
 ../blast/data/protein2.faa
 ...
 ../blast/data/protein200.faa
```
Instead submit single core-jobs 200 times, which potentially need 200 nodes, GNU parallel sends single-core jobs in parallel using all the cores available, e.g. 2 compute nodes 32*2=64 parallel tasks. Once a CPU core becomes available, another job will be sent to this resource.   
```
module load parallel/20200222
JOBS_PER_NODE=32
parallel --jobs $JOBS_PER_NODE --slf hostfile --wd $WDIR --joblog task.log --resume --progress \
                -a task.lst sh run-blast.sh {} output/{/.}.blst 
```
Detailed information of how to submit serial tasks in parallel with [GNU parallel](https://sites.google.com/a/lbl.gov/high-performance-computing-services-group/getting-started/faq)


# Monitoring Jobs

- sinfo: check node status of a partition (idle, allocated, drain, down) 
```
[wfeinstein@n0000 ~]$ sinfo –r –p lr5
PARTITION AVAIL  TIMELIMIT  NODES  STATE NODELIST 
lr5          up   infinite      3 drain* n0004.lr5,n0032.lr5,n0169.lr5 
lr5          up   infinite     14   down n0048.lr5,n0050.lr5 
lr5          up   infinite     58  alloc n0000.lr5,n0001.lr5,n0002.lr5,n0003.lr5,n0006.lr5,n0009.lr5
lr5          up   infinite    115   idle n0005.lr5,n0007.lr5,n0008.lr5
...
```
- squeue: check job status in the batch queuing system (R or PD)
```
squeue –u $USER
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON) 
          28757187       lr6     bash wfeinste  R       0:09      1 n0215.lr6 
          28757723       es1     bash wfeinste  R       0:16      1 n0002.es1 
          28759191       lr6     bash wfeinste PD       0:00    120 (QOSMaxNodePerJobLimit)
```
- sacct: check job information or history

```
[wfeinstein@n0002 ~]$ sacct -j 28757723
       JobID    JobName  Partition    Account  AllocCPUS      State ExitCode 
------------ ---------- ---------- ---------- ---------- ---------- -------- 
28757723           bash        es1        scs          2    RUNNING      0:0 

[wfeinstein@n0002 ~]$ sacct -X -o 'jobid,user,partition,nodelist,stat'
       JobID      User  Partition        NodeList      State 
------------ --------- ---------- --------------- ---------- 
28755594     wfeinste+        lr5       n0192.lr5  COMPLETED 
28755597     wfeinste+        lr6       n0101.lr6  COMPLETED 
28755598     wfeinste+        lr5       n0192.lr5  COMPLETED 
28755604     wfeinste+ csd_lr6_s+       n0144.lr6  COMPLETED 
28755693     wfeinste+        lr6       n0101.lr6 CANCELLED+ 
....
28757187     wfeinste+        lr6       n0215.lr6  COMPLETED 
28757386     wfeinste+        es1       n0019.es1     FAILED 
28757389     wfeinste+        es1       n0002.es1    TIMEOUT 
28757723     wfeinste+        es1       n0002.es1    RUNNING 
```
- wwall -j <JOB_ID>: check resouce utilization of an active job from a login node
```
[wfeinstein@n0000 ~]$ wwall -j 28757187
--------------------------------------------------------------------------------
Total CPU utilization: 0%                          
          Total Nodes: 1         
               Living: 1                           Warewulf
          Unavailable: 0                      Cluster Statistics
             Disabled: 0                 http://warewulf.lbl.gov/
                Error: 0         
                 Dead: 0         
--------------------------------------------------------------------------------
 Node      Cluster        CPU       Memory (MB)      Swap (MB)      Current
 Name       Name       [util/num] [% used/total]   [% used/total]   Status
n0215.lr6               0%   (40) % 3473/192058    % 1655/8191      READY
```

- `scancel <jobID>` : scancel a job 

More information of [slurm usage](https://sites.google.com/a/lbl.gov/high-performance-computing-services-group/scheduler/slurm-usage-instructions)


# Open Ondemand 

- Single web point of entry to the Lawrencium Supercluster
- Allow access to Lawrencium compute resources  					
  - File browser: file editing, data transfer
  - Shell command line access - terminal
- Monitor jobs
- Interactive applications: Jupyter notebooks, MatLab, RStudio...
- Jupyter server  
   - Interactive mode: debugging code, light-weight visulization with 4 CPU nodes and 1 GPU node
   - Compute mode: Access to all Lawrencium partitions via submitting batch jobs
- Sever: [https://lrc-ondemand.lbl.gov/](https://lrc-ondemand.lbl.gov/)
  - Intel Xeon Gold processor with 32 cores, 96 GB RAM


# Open Ondemand 

<left><img src="figures/ood.png" width="70%"></left>


# Jupyter Notebook

- Create user kernels
```  
python -m venv --system-site-packages ./mykernel
source ./mykernel/bin/activate
python -m ipykernel install --user --name=mykernel
```
```
[wfeinstein@n0000 ~]$ module load python/3.7
[wfeinstein@n0000 ~]$ module list
Currently Loaded Modulefiles:
  1) emacs/25.1   2) python/3.7
[wfeinstein@n0000 ~]$ python -m venv --system-site-packages ./mykernel
[wfeinstein@n0000 ~]$ source ./mykernel/bin/activate
(mykernel) [wfeinstein@n0000 ~]$ python -m ipykernel install --user --name=mykernel
Installed kernelspec mykernel in /global/home/users/wfeinstein/.local/share/jupyter/kernels/mykernel
(mykernel) [wfeinstein@n0000 ~]$    

# Now you should be able to choose the virtual environment "mykernel" as a kernel in Jupyter
```

# One-Minute Demo Launching Jupyter Notebooks 

[https://lrc-ondemand.lbl.gov/](https://lrc-ondemand.lbl.gov/)


# Remote Visulization 

- Allow users to run a real desktop within the cluster environment 
- Allow applications with a GUI, commercial applications, debugger or visualization applications to render results. 

  - Remote Desktop launched within Open OnDemand - **coming up, stay tuned**
  
  - viz node lrc-viz.lbl.gov
  - RealVNC is provided as the remote desktop service with local VNC Viewer  
  - Start VNC service on viz node lrc-viz.lbl.gov
  - Connect to the VNC server with VNC Viewer locally
  - Start applications: Firefox, Jupyter notebooks, paraview ...


# Getting help

- Virtual Office Hours:
    - Time: 10:30am - noon (Wednesdays)
    - Online [request](https://docs.google.com/forms/d/e/1FAIpQLScBbNcr0CbhWs8oyrQ0pKLmLObQMFmYseHtrvyLfOAoIInyVA/viewform)
- Sending us tickets at hpcshelp@lbl.gov
- More information, documents, tips of how to use LBNL Supercluster [http://scs.lbl.gov/](http://scs.lbl.gov)
- New Science IT website will be launched Nov 15th, 2021
- Please fill out [Training Survey](https://docs.google.com/forms/d/e/1FAIpQLSeeJ2NyE5Fy6jcapfD9x-JbDR_5xrAhVtdrW0Yyg-LzUpckaA/viewform)


# Hands-on Exercise

1) Login and data transfer
2) Set up work environment using module commands
3) Edit files
4) Submit jobs
5) Monitor jobs

# Login and Data Transfer

Objective: transfer data to/from LRC 

1) Download test data [here]( data.sample) 

2) Open two linux terminals on Mac or Window via Putty 

3) Transfer local data.sample to LRC on terminal 1 
```
scp -r data.sample $USER@lrc-xfer.lbl.gov:/global/home/users/$USER 
scp -r data.sample $USER@lrc-xfer.lbl.gov:~
``` 
4) On terminal 2, login to LRC
``` 
ssh $USER@lrc-login.lbl.gov 
pwd 
cat data.sample
cp data.sample data.bak
``` 
5) Transfer data from LRC DTN to your local machine on terminal 1
```
scp -r $USER@lrc-xfer.lbl.gov:/global/home/users/$USER/data.bak .
ls data.*
```


# Module Commands

- Display software packages on LRC
` module available`
- Check modules in your env
` module list`
- Clear your env
` module purge`
- Load a module
```
 module available openmpi mkl
 module load intel/2016.4.072
 module list
 module av openmpi mkl
 module load mkl/2016.4.072 openmpi/3.0.1-intel
```

# Editing files

Linux editor: vim and emacs installed. Just start the editor from a login node.
```
## To use vim
vim myfile.txt
## To use emacs
emacs myfile.txt
```


# Job Submission

- Check your account slurm association
```
sacctmgr show association -p user=$USER

Cluster|Account|User|Partition|Share|Priority|GrpJobs|GrpTRES|GrpSubmit|GrpWall|GrpTRESMins|MaxJobs|MaxTRES|MaxTRESPerNode|MaxSubmit|MaxWall|MaxTRESMins|QOS|Def QOS|GrpTRESRunMins|
perceus-00|scs|wfeinstein|lr6|1|||||||||||||lr6_lowprio,lr_debug,lr_normal|||
perceus-00|scs|wfeinstein|es1|1|||||||||||||es_debug,es_lowprio,es_normal|||

```

### Request an interactive node

Note: Use your account, partition, qos

srun --account=ac_xxx --nodes=1 --partition=xxx --time=1:0:0 --qos=xxx --pty bash


# Submit a batch job

Download a sample [job submission script](my_submit.sh) and [python sample](my.py)

Note: Use your account, partition, qos
```
#!/bin/bash -l

# Job name:
#SBATCH --job-name=mytest
#
# Partition:
#SBATCH --partition=lr6
#
# Account:
#SBATCH --account=your_account
#
# qos:
#SBATCH --qos=lr_normal
#
# Wall clock time:
#SBATCH --time=1:00:00
#
# Node count
#SBATCH --nodes=1
#
# Node feature
##SBATCH --constrain=lr6_cas
#
# cd to your work directory
cd /global/scratch/$USER

## Commands to run
module load python/3.7
python my.py >& mypy.out 
````

# Monitor jobs

`squeu -u $USER`

`sacct -j <JOBID>`

`wwall -j <JOBID>`

