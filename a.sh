#!/bin/bash
tee train.job << JOB
#!/bin/bash
#SBATCH --job-name=llama2-maxtext-train
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2
#SBATCH --partition=g2gpu8
#SBATCH --array=1-10
#SBATCH --output=out_%3A_%3a.txt
#SBATCH --error=err_%3A_%3a.txt

docker run --rm  --privileged --gpus all  --shm-size 2g us-docker.pkg.dev/hpc-test-2-438108/maxtext-base-image/llama2-7b
JOB
