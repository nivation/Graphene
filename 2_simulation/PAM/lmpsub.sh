#!/bin/bash
#PBS -l select=1:ncpus=16:mpiprocs=16:ompthreads=1
#PBS -N GPAM_Pro
#PBS -q ct160
#PBS -P MST111263
#PBS -j oe

cd $PBS_O_WORKDIR

module purge
module load intel/2018_u1
module load cuda/8.0.61
OMP_NUM_THREADS=1

echo "Your LAMMPS job starts at `date`"

echo "Start time:" `date` 2>&1 > time.log
t1=`date +%s`

mkdir restart
mkdir dump
mpiexec.hydra -PSM2 /pkg/CMS/LAMMPS/lammps-16Mar18/bin/lmp_run_cpu -in ./in.eq > lammps.log

t2=`date +%s`
echo "Finish time:" `date` 2>&1 >> time.log
echo "Total runtime:" $[$t2-$t1] "seconds" 2>&1 >> time.log

qstat -x -f ${PBS_JOBID} 2>&1 > job.log

echo "Your LAMMPS job completed at  `date` "
