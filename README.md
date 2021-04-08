# LSF + Singularity Test Bed

This is a modification of [Morgan Rodgers' lsf-workbench](https://github.com/MorganRodgers/lsf-workbench) code,
to match Curii's needs.

Refer to the link above to see the original README.

## How To Download LSF Community

LSF Community edition version is available for free to IBM community members and may be downloaded from there after login
with a free [IBM community account](https://community.ibm.com/community/user/gettingstarted/home).

To ease this, I uploaded a copy of the package to 9tee4's keep.

You can download it with
```
wget -c https://collections.9tee4.arvadosapi.com/c=9tee4-4zz18-2erdrumx715pt79/t=1fgxq9l2ee3gs05t82djaoibljd7f4jrs2eiqz2hsstuh0jvj5/_/lsfsce10.2.0.6-x86_64.tar.gz

```
- Copy the file `lsfsce10.2.0.6-x86_64.tar.gz` to the root of the `lsf-singularity-test-bed` repo.

## The LSF Installation

This Vagrant setup installs the version of LSF Community edition that the user provides,
but expects version 10.2.0.6.

LSF clients are installed to `head` and `ood`.

`head` is both the batch and the only compute node.

`head` is installed on Debian Buster (as Debian family is what we mostly use) and the `ood` node is a `centos-7` node
(because [Open On Demand](https://openondemand.org/) only packages RPM atm). `head` can also be installed on `centos-7`,
just check the `Vagrantfile` and modify the instance/s as desired. Change the `head.vm.box:` var and the
`install_deps_{apt,yum}!` line in the instance.

## Singularity installation

Singularity is installed in the `head` node using packages. Currently it only manages the Debian packages, as that's our
current requirement. If you plan to use centos instances to test this code, make sure to update the Vagrant script
accordingly.

## Launch the environment

The simplest way to get all up and running is

```
vagrant up
```
and wait for the provisioning scripts to finish.

If you just want to try LSF, the only instance you need is the `head` node:

```
vagrant up head
```

The `ood` node provides a WebUI to manage the LSF cluster, with a webui terminal,
list of jobs run/running, etc., pretty similar to Arvados' webui. To launch this one
individually, run

```
vagrant up ood
```
A proper setup requires that the `head` VM be brought up first.

Once they're up and provisioned, you can stop/resume them using regular vagrant commands.

## Usage & examples

### LSF

There are two examples of how to submit jobs to LSF's queue system: a simple python script
to count to 10 and a singularity lolcow run (it takes a variable amount of time to run and
produces no much output in the meantime, so be patient with it).

The examples have a submit script and they leave 3 files on each run:

* the script run output
* the job's stdout output
* the job's stderr output

To use them

1. Login to the `head` node
```
vagrant ssh head
```
1. Change to the desired *examples* subdir under the `vagrant` shared folder
```
cd /vagrant/examples/singularity
```
1. Submit the job
```
bsub < script.sh
```
   and wait for it to finish.

### OOD

Access to OpenOnDemand is via the `ood` user with password `ood`.
Once the VM is loaded, the Open OnDemand interface can be accessed at localhost:8080

From it, you can access nodes, have a shell to use them, etc. Check the documentation
for more information.

## Documentation

* LSF quick start: https://www.ibm.com/support/knowledgecenter/en/SSWRJV_10.1.0/lsf_offering/lsfce10.1_quick_start.html
* How to run batch jobs using LSF: https://www.hpc.dtu.dk/?page_id=1416
