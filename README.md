This repo will help rebuild nas63 in the future if issues occur
 
** when making future changes, if they are made directly to this repo in git, from ubuntu, sync those changes with: git pull origin master
step by step instructions after ubuntu is installed and storage is orgranized.

Root of library is /plex/library
Downloads /plex/downloads
git repo is syncd to /plex/nas63

##Syncing GIT Master to nas63
cd /plex
mkdir nas63 (Set permissions on this folder)
git clone git clone https://github.com/JG0078/nas63.git



###################################################################################################################################################
NAS63 Docker Services:
-All of these are tested and working

Sonarr, Radarr, Jackett, Pihole, Transmission




###################################################################################################################################################
Overall GIT Configuration Steps:
This change was made on ubuntu
to change the repo to a new git branch,  git checkout -b nas63_082822   (Change the name to anything you want)
These changes will be pushed into github by using, git push --set-upstream origin nas63_082822  (This will move the local branch into git)

to complete the Push, follow this link to setup authentication with git from local server
https://docs.github.com/en/authentication/connecting-to-github-with-ssh/working-with-ssh-key-passphrases
https://docs.github.com/en/authentication/connecting-to-github-with-ssh

followed these steps: https://www.theserverside.com/blog/Coffee-Talk-Java-News-Stories-and-Opinions/GitHub-SSH-Key-Setup-Config-Ubuntu-Linux

##This will allow for SSH access with GITHUB
git remote set-url origin git@github.com:JG0078/nas63.git

git push --set-upstream origin nas63_082822  (Specify the branch name)

git diff ##Identifies all of the different files

git add -A && git commit -m "changes from ubuntu"   ##Commits changes from ubuntu into Local Git Branch
git push -u origin nas63_082822   ##Syncs changes to remote git repo online at github

##After cloning Git Master Branch
Create a new local branch on ubuntu
git checkout -b nas63_branch1  (Set the branch name)
git push -u origin <<NewBranchName>> 


Installing Transmission:
- CAn't figure out install via docker at this time.
- Install manually 3.0 to ubunut 20

1. sudo apt update
2. sudo apt upgrade
3. sudo add-apt-repository ppa:transmissionbt/ppa
4. sudo apt update
5. sudo apt install transmission
6. transmission-gtk --version

Transmission:
 # Having trouble with the settings of transmission if its running in a docker file.
Manually using Tranmission Install on Ubuntu 20.04
1. sudo apt-get update
2. sudo apt-get install transmission-cli transmission-common transmission-daemon
3. sudo usermod -a -G debian-transmission grubb

## Performing Install
  
## Adding Aliases to ~/.bashrc
alias tstop='sudo service transmission-daemon stop'
alias tstart='sudo service transmission-daemon start'
alias trestart='sudo service transmission-daemon reload'
alias tstatus='sudo service transmission-daemon status'
alias tsettings='sudo nano /etc/transmission-daemon/settings.json'




Installing Plex
 - Docker Issues:


  531  curl https://downloads.plex.tv/plex-keys/PlexSign.key | sudo apt-key add -
  532  echo deb https://downloads.plex.tv/repo/deb public main | sudo tee /etc/apt/sources.list.d/plexmediaserver.list
  533  sudo apt update
  534  sudo apt install plexmediaserver
  535  sudo systemctl status plexmediaserver
  536  history



Installing PiHole
grubb@nas63:/plex/nas63$ sudo systemctl disable systemd-resolved.service
grubb@nas63:/plex/nas63$ sudo systemctl stop systemd-resolved
grubb@nas63:/plex/nas63$
grubb@nas63:/plex/nas63$
grubb@nas63:/plex/nas63$ sudo nano /etc/resolv.conf
Add NAMESERVER: 8.8.8.8 temporarily
once completed, update NS to 192.168.1.100 


