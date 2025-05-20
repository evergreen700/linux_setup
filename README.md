# linux_setup
bashrc and setup scripts for the next time I have to wipe my laptop or set up a vm

## Configure ssh key:
Within the VM, run
```
EMAIL="The email attached to your github"
```
```
NAME="Your name"
```
```
echo "***"
echo "CONFIGURING GIT NAMES"
echo "***"
git config --global user.email "$EMAIL"
git config --global user.name "$NAME"
git config --global core.editor "vim"
```
```
echo "***"
echo "CREATING SSH KEY"
echo "***"
ssh-keygen -t ed25519 -C $EMAIL -f ~/.ssh/id_ed25519 -N ""
eval `ssh-agent -s`
ssh-add ~/.ssh/id_ed25519
echo "Add the following key to github account https://github.com/settings/keys"
cat ~/.ssh/id_ed25519.pub
```
Add the key printed to https://github.com/settings/keys. \
If everything is setup properly, you should be able to clone this repository using the following command:
```
git clone git@github.com:evergreen700/linux_setup.git &&
cd linux_setup
```

## Run setup scripts
With this repository cloned, you can run the scripts from the command line:
- To overwrite current bashrc with "fancier" bashrc
```
./bashrc_setup.sh
```
- To install conda, vim, etc
```
./install_packages.sh
```
