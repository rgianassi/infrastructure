# Infrastructure

Infrastructure project.

## VM preparation

Create a new VM and prepare all partitions with GParted ISO. You can use the [sfdisk dump file](files/sda.sfdisk) to recreate Linux partitions faster.
When partitions are ready, start the Regolith Linux installation. Do a standard installation, but remember to create and format the EFI partition firstly and separately from other partitions.
When OS is ready run the virtualization script to prepare execution for a particular environment. For example, for Hyper-V VMs you can use [the Hyper-V Ubuntu post installation script](script/files/hyper-v-ubuntu-post-installation.sh). Hyper-V script needs to be run 2 times (you can restart the VM with `init 6` at end of first script execution) and HvSocket must be enabled on the VM on an administrative PowerShell with `Set-VM -VMName name_of_the_VM -EnhancedSessionTransportType HvSocket` command. Remember to set enhanced session mode in Hyper-V, too.
To make `xrdp` work with Hyper V and Regolith Linux create a `.xsession` file in the home folder containing `regolith-session`.
At this point, you are ready to run [the Bootstrap Salt installation script](script/files/bootstrap-salt.sh): remember to use the `-M` flag on the Salt master to install Salt master components.
Register all minions (including the Salt master itself) with the Salt master.
On Salt master, create a SSH key and upload it to GitHub. Clone the infrastructure repository and run the [bootstrap](script/bootstrap.sh) script.
The VM is ready to go.

## Check pillar data

To check pillar data use the following commands:

```bash
sudo salt '*' saltutil.refresh_pillar
sudo salt '*' pillar.items
```

## Secrets encryption

When saving sensitive data to control version, use one of the following commands:

```bash
echo -n "supersecret" | gpg --armor --batch --trust-model always --encrypt -r 598EC3F324A85B2DFD81F3F488747A7697B4D30A
mkpasswd -m sha-512 | gpg --armor --batch --trust-model always --encrypt -r 598EC3F324A85B2DFD81F3F488747A7697B4D30A
gpg --armor --batch --trust-model always --encrypt -r 598EC3F324A85B2DFD81F3F488747A7697B4D30A < pass.txt
```

To use that, you need the public key [598EC3F324A85B2DFD81F3F488747A7697B4D30A](files/exported_gpg_salt.key). To import it in your system under your account:

```bash
gpg --import files/exported_gpg_salt.key
```

## Commit code

This project uses Python version of [Commitizen](https://github.com/commitizen-tools/commitizen) to create conventional commits.
To create a commit that follows [Conventional commits](https://www.conventionalcommits.org/) run:

```bash
cz commit
```

To check if commits are in the right format run:

```bash
cz check --rev-range HEAD
```

To bump the version and update the CHANGELOG run:

```bash
cz bump --changelog
```

The tool automagically observes [Semantic Versioning](https://semver.org) and [keep a changelog](https://keepachangelog.com/en/1.0.0/).