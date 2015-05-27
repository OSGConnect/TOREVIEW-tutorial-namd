#!/bin/bash
source /cvmfs/oasis.opensciencegrid.org/osg/modules/lmod/current/init/bash
module load namd/2.9
namd2 ubq_gbis_eq.conf > ubq_gbis_eq.$1.log





