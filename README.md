# infrastructure

Infrastructure project.

## VM preparation

Create a new VM and prepare all partitions with GParted ISO. You can use the [sfdisk dump file](files/sda.sfdisk) to recreate Linux partitions faster.
When partitions are ready, start the Regolith Linux installation. Do a standard installation, but remember to create and format the EFI partitions firstly and separately from other partitions.
When OS is ready run the virtualization script to prepare execution for a particular environment. For example, for Hyper-V VMs you can use [the Hyper-V Ubuntu post installation script](script/files/hyper-v-ubuntu-post-installation.sh). Hyper-V script needs to be run 2 times (you can restart the VM with `init 6` at end of first script execution) and HvSocket must be enabled on the VM on an administrative PowerShell with `Set-VM -VMName name_of_the_VM -EnhancedSessionTransportType HvSocket` command. Remember to set enhanced session mode in Hyper-V, too.
To make `xrdp` work with Hyper V and Regolith Linux create a `.xsession` file in the home folder containing `regolith-session`.
At this point, you are ready to run [the Bootstrap Salt installation script](script/files/bootstrap-salt.sh): remember to use the `-M` flag on the Salt master to install Salt master components.
On Salt master, create a SSH key and upload it to GitHub. Clone the infrastructure repository and run the [bootstrap](script/bootstrap.sh) script.
