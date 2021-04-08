#!/bin/sh
echo 'building image'
# singularity build lolcow.simg docker://godlovedc/lolcow
singularity pull --force --name lolcow.simg docker://godlovedc/lolcow
echo 'running image'
singularity run lolcow.simg
