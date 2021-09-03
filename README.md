# infrastructure

Infrastructure project.

## VM preparation

Create a new VM and prepare all partitions with GParted ISO. You can use the [sfdisk dump file](files/sda.sfdisk) to recreate Linux partitions faster.
When partitions are ready, start the Regolith Linux installation. Do a standard installation, but remember to create and format the EFI partitions firstly and separately from other partitions.
When OS is ready run the virtualization script to prepare execution for a particular environment. For example, for Hyper-V VMs you can use [the Hyper-V Ubuntu post installation script](script/files/hyper-v-ubuntu-post-installation.sh).
At this point, you are ready to run [the Bootstrap Salt installation script](script/files/bootstrap-salt.sh): remember to use the `-M` flag on the Salt master to install Salt master components.
