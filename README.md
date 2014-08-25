Table of Contents

1.	Overview
2.	Setup
3.	Job execution and submission scripts
4.	Running the simulation

------------------------------------------------------------------------

1. Overview

NAMD is a molecular dynamics program. In this tutorial, we will learn how to run NAMD simulations in open science grid (OSG).  As an example, we will perform the molecular dynamics simulation of Ubiquitin (pdb ID: UBQ) in implicit water. 


2. Set up 

In the command prompt, type

$tutorial namd

This will create a directory “OSG_tutorial-namd”. Within this directory you will see the following files.

namd_run.submit  (the condor job submission script)

namd_run.sh  (shell script to run the namd simulation)

ubq_gbis_eq.conf (input file for NAMD)

ubq.pdb (Protein pdb file, NAMD needs this file)

ubq.psf (Protein structure information, NAMD needs this file)

par_all27_prot_lipid.inp (parameter file for NAMD)


The  namd_run.submit and namd_run.sh are the script files related  to job submission and the other files are required by the namd software. Details about the namd input files and how to prepare them can be found in namd website. 

3. Job execution and submission scripts

Script file  “namd_run.submit” is the condor script file that has the basic information about submitting an HTC job.  Please refer connect book to learn about the key words in the script. Here, we will discuss the usage of  “transfer_input_files” relevant to NAMD simulations.  The key word “transfer_input_files” transfers the listed files into the worker machine.  In our example,  

transfer_input_files = ubq_gbis_eq.conf, ubq.pdb, ubq.psf, par_all27_prot_lipid.inp

would transfer the input files to worker machine to run the NAMD simulations. 


The other script file “namd_run.sh” has the information about loading the namd module and the job execution command
source /cvmfs/oasis.opensciencegrid.org/osg/modules/lmod/5.6.2/init/bash
module load namd/2.9
namd2 ubq_gbis_eq.conf  > ubq_gbis_eq.log

line 1:  Reads and executes the bash file located in the init directory

line 2:  Sets up the environment  (such as path of the binary,  libraries ..etc) to run NAMD. 

Line 3:  Execution of  namd  simulation for the input file “ubq_gbis_eq.conf” and redirects the out put file to “ubq_gbis_eq.log”. 

To sum it up, the simulation of new system requires updating line 3 in “namd_run.sh” and the list of file names for the keyword transfer_input_files  in “namd_run.submit”.


4. Running the simulation

To run the simulation, type

$ Condor_submit 

The present job should be finished quickly (less than an hour). Once the simulation is finished successfully, you will see the output file,  trajectory files and restart files that were generated from the NAMD simulation. 

