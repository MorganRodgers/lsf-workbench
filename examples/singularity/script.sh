#BSUB -W 10:00
#BSUB -n 1
#BSUB -e /vagrant/examples/singularity/%J.err
#BSUB -o /vagrant/examples/singularity/%J.out

cd /vagrant/examples/singularity
# execute program
./singularity.sh > output_singularity 2>&1
