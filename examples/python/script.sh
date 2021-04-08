#BSUB -W 10:00
#BSUB -n 1
#BSUB -e /vagrant/examples/python/%J.err
#BSUB -o /vagrant/examples/python/%J.out

cd /vagrant/examples/python
# execute program
python3 count.py > output_python_count 2>&1
