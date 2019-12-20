[title]: - "A Simple NAMD Application"

[TOC]
 
## Overview

[NAMD](http://www.ks.uiuc.edu/Research/namd/) is a widely used molecular dynamics simulation program. It lets users specify a molecule in some initial state and then observe its time evolution subject to forces. Essentially, it lets you go from a specific molecular [structure](http://en.wikipedia.org/wiki/Superoxide_dismutase#mediaviewer/File:Superoxide_dismutase_2_PDB_1VAR.png) to a [simulation](https://www.youtube.com/watch?v=mk3cLd9PUPA&list=PL418E1C62DD9FC8BA&index=1) of its behavior in a particular environment.  It has been used to study polio eradication, simulations of graphene, and studies of biofuels.

In this tutorial, we will learn how to run NAMD simulations on the OSG. We will perform the molecular dynamics simulation of Ubiquitin (pdb ID: 1UBQ) in implicit water.  

## NAMD tutorial files


It is easiest to start with the `tutorial` command. In the command prompt, type
	 $ tutorial namd # Copies input and script files to the directory tutorial-namd.
 
This will create a directory `tutorial-namd`. Inside the directory, you will see the following files

	namd_run.submit            # Condor job submission script file.
	namd_run.sh                # Job execution script file.
	ubq_gbis_eq.conf           # Input configuration for NAMD.
	ubq.pdb                    # Input pdb file for NAMD.
	ubq.psf                    # Input file for NAMD.
	par_all27_prot_lipid.inp   # Parameter file for NAMD.


Here, `namd_run.submit` and `namd_run.sh` are the script files related to job submission and the other files are required by the NAMD software. The details regarding the preparation of input files for NAMD is available external website for NAMD at UIUC. 

## Job execution and submission files

The file `namd_run.submit` is the HTCondor job submission file.  Here, we focus on the HTCondor file transfer mechanism relevant for this NAMD simulation example. The key word `transfer_input_files`  specifies which input files  are transferred from the login machine to the remote worker machine (where the jobs are being executed).  In the `namd_run.submit` file, the option

	transfer_input_files = ubq_gbis_eq.conf, ubq.pdb, ubq.psf, par_all27_prot_lipid.inp # list of input files needs to be transferred to the worker machine before. 
	
means that the listed files are transferred from the `login.osgconnect.net` to the worker machine.
 
Similarly, we can transfer the output files from the worker machine to `login.osgconnect.net` by adding the following lines in the HTCondor job submission script file `namd_run.submit`:

	transfer_output_files = file1.out, file2.out, file3.out ... # List of output files separated by commas.
	should_transfer_files=Yes                                   # Key word to activate the file transfer
	when_to_transfer_output = ON_EXIT                           # After the job execution is finished
	
However, in the vanilla universe `transfer_output_files` is not necessary as it transfers all the output files by default (the current example runs the job in the vanilla universe). The other script file `namd_run.sh` has the information about loading the `namd` module and the job execution commands:

	#!/bin/bash                              
	module load namd/2.9                           
	namd2 ubq_gbis_eq.conf > ubq_gbis_eq.$1.log # Here $1 is the argument from HTCondor job file

In essence, the NAMD simulation of a new molecule requires updating line 3 in `namd_run.sh`  that executes the `namd2` program  and the list of file names for the keyword `transfer_input_files` in `namd_run.submit`.

## Running the simulation

We submit the job using `condor_submit` command as follows

	$ condor_submit namd_run.submit //Submit the condor job script "namd_run.submit"

Now you have submitted the NAMD simulation of ubiquitin in implicit solvent on the OSG.  The present job should be finished quickly (less than an hour). You can check the status of the submitted job by using the `condor_q` command as follows

	$ condor_q username  # The status of the job is printed on the screen. Here, username is your login name.
After the simulation is completed, you will see the output files (including restart and trajectory files) from NAMD in your work directory.


## Getting Help
For assistance or questions, please email the OSG User Support team  at [support@opensciencegrid.org](mailto:support@opensciencegrid.org) or visit the [help desk and community forums](http://support.opensciencegrid.org).
