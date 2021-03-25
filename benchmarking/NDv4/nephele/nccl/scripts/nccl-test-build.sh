#!/bin/bash
  
CONT="nvcr.io#nvidia/pytorch:20.10-py3"
MOUNT="/nfs/azure/benchmarking/NDv4/nephele/nccl:/nccl,/nfs/hpcx-v2.7.4-gcc-MLNX_OFED_LINUX-5.1-0.6.6.0-ubuntu18.04-x86_64:/opt/hpcx"

export OMPI_MCA_pml=ucx
export OMPI_MCA_btl=^openib

srun --ntasks=$SLURM_JOB_NUM_NODES \
    --container-image "${CONT}" \
    --container-name=nccl \
    --container-mounts="${MOUNT}" \
    --ntasks-per-node=1 \
    bash -c 'cd /nccl && git clone https://github.com/NVIDIA/nccl-tests.git && source /opt/hpcx/hpcx-init.sh && hpcx_load && cd nccl-tests && make MPI=1'
