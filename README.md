
#NAMD example

##Overview

NAMD is a molecular dynamics program. In this tutorial, we will learn how to run NAMD simulations on open science grid (OSG). We will perform the molecular dynamics simulation of Ubiquitin (pdb ID: 1UBQ) in implicit water.  

##NAMD tutorial files


It is easy to start with the "tutorial" command. In the command prompt, type
```
 $ tutorial namd //Copies input and script files to the directory tutorial-namd.
```
 
This will create a directory “tutorial-namd". Inside the directory, you will see the following files
```
namd_run.submit //Condor job submission script file.
namd_run.sh //Job execution script file.
ubq_gbis_eq.conf //Input configuration for NAMD.
ubq.pdb //Input pdb file for NAMD.
ubq.psf //Input file for NAMD.
par_all27_prot_lipid.inp //Parameter file for NAMD.
```

 
Here, "namd_run.submit" and "namd_run.sh" are the script files related to job submission and the other files are required by the NAMD software. The details regarding the preparation of input files for NAMD is available  external website for NAMD at UIUC. 

##Job execution and submission files

The file “namd_run.submit” is the condor  job submission file. Please refer  OSG connectbook to learn about the key words in the script file. Here, we will discuss the condor file transfer mechanism relevant for NAMD simulations.  The key word “transfer_input_files”  specifies what input files  are transferred from the login machine (Where you login and submit the jobs, here it is login.osgconnect.net) to the remote worker machine (where the jobs are being executed) . In the "namd_run.submit" file, the keyword 
```
transfer_input_files = ubq_gbis_eq.conf, ubq.pdb, ubq.psf, par_all27_prot_lipid.inp //list of input files needs to be transferred to the worker machine before. 
```
means that the listed files are transferred from the login.osgconnect.net to the worker machine.
 
Similarly, we can transfer the output files from the worker machine to login.osgconnect.net by adding the following lines in the condor job submission script file - "namd_run.submit".
```
transfer_output_files = file1.out, file2.out, file3.out ... etc //List of output files separated by commas.
should_transfer_files=Yes //Key word to activate the file transfer
when_to_transfer_output = ON_EXIT //After the job execution is finished
```
However, in the vanilla universe "transfer_output_files" is not necessary as it transfers all the output files by default (the current example runs the job in the vanilla universe).   The other script file “namd_run.sh” has the information about loading the namd module and the job execution commands:
```
#!/bin/bash //Shell interpreter.
module load namd/2.9 //Sets up the environment (such as path of the binary, libraries ..etc) to run NAMD.
namd2 ubq_gbis_eq.conf > ubq_gbis_eq.$1.log //Execution of namd simulation for the input file “ubq_gbis_eq.conf” and redirects the out put file.
```

In essence, the NAMD simulation of a new molecule requires updating line 3 in “namd_run.sh”  that executes the namd2 and the list of file names for the keyword transfer_input_files in “namd_run.submit”.

##Running the simulation
We submit the job using "condor_submit" command as follows
$ condor_submit namd_run.submit //Submit the condor job script "namd_run.submit"
 
Now you have submitted the NAMD simulation of ubiquitin in implicit solvent on the open science grid. The present job should be finished quickly (less than an hour). You can check the status of the submitted job by using the "condor_q" command as follows
```
$ condor_q username //The status of the job is printed on the screen. Here, username is your login name.
```
After the simulation is completed, you will see the output files (including restart and trajectory files) from NAMD in your work directory.

##References
**NAMD tutorial** Tutorials are available to learn the basics of molecular dynamics simulations of biomolecules and chemicals with NAMD package. 
**OSG  QuickStart**  Getting started with the Open Science Grid (OSG).
**Condor Manual**   Manual for the high throughput condor (HTCondor)  software to schedules the jobs on OSG. 
##Help
For further assistance or questions, please email ***connect-support@opensciencegrid.org***



