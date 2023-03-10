#!/bin/bash
#PBS -l select=1:ncpus=4:mpiprocs=4:ompthreads=1
#PBS -N Mini_GW
#PBS -q ct160
#PBS -P MST110475
#PBS -j oe

cd $PBS_O_WORKDIR

module purge
module load intel/2018_u1
module load cuda/8.0.61
OMP_NUM_THREADS=1

echo "Your LAMMPS job starts at `date`"

echo "Start time:" `date` 2>&1 > time.log
t1=`date +%s`

mpiexec.hydra -PSM2 /pkg/CMS/LAMMPS/lammps-16Mar18/bin/lmp_run_cpu -in ./in.minimize > lammps.log

t2=`date +%s`
echo "Finish time:" `date` 2>&1 >> time.log
echo "Total runtime:" $[$t2-$t1] "seconds" 2>&1 >> time.log

qstat -x -f ${PBS_JOBID} 2>&1 > job.log

echo "Your LAMMPS job completed at  `date` "
