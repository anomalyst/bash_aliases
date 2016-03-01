export BAL=bash_aliases
# set vitual machine host to standard if not overridden from env
if [  X$VMH=="X" ]; then export VMH=vmh1 ; fi

# based on  https://gist.github.com/ckorn/4999102
function authme() {
#	AK=authorized keys
#	ET=encryption type
#	KF=Key File
  SSHEE=ecdsa			# Elliptical Encryption
  SSHET=$SSHEE			# Encryption Type
  SSHEB=2048			# Encryption Bits (RSA default)
  SSHAK=.ssh/authorized_keys	# Authorized Keys path
		
  if [ $SSHET == $SSHEE ]	#?-elliptical encryption?
  then
	SSHEB=521		#y-max bits on elliptical is 521
  fi
  SSHKF=~/.ssh/id_$SSHET.pub
# change the above ~/.ssh/*.pub to the path of your public key file.

# make sure local directory is there
  mkdir -p ~/.ssh
#
# create new key with max bits when we need one
  if [ ! -e $SSHKF ]; then ssh-keygen -t $SSHET -b $SSHSZ; fi
  
#	pipe the created key file across to remote host
#	and concatinate it with existing keys on remote host
#	set best practice permissions local and remote
#	
  cat $SSHKF | ssh "$1" "mkdir -p ~/.ssh	\
	&& cat  - >>$SSHAK	\
	&& chmod 700 ~/.ssh	\
	&& chmod 600 $SSHAK"
  chmod 600 ~/.ssh/*
  chmod 700 ~/.ssh
}



function npost() {
cd ~/octopress
rake new_post
vi source/posts/`ls -rt source/_posts | tail --lines=1`
}

function qsvirsh() {
virsh -c qemu+ssh://$USER@$1/system
}

function gital() {
	cd ~/git/$BAL
	cp ~/.$BAL $BAL
	git add .
	git commit
	git push origin source 
}

function gitblog() {
cd ~/octopress
rake generate
rake deploy
git add .
git commit -m 'blog post'
git push origin source 
}

alias flushdns="dscacheutil -flushcache"
alias exit='history -a && exit'
alias umount="sudo umount"
alias shutdown="sudo shutdown"
alias df="df -h"
alias free="free -h"
alias eco="echo"
alias rba='source ~/.bash_aliases'	#reload shell aliases
alias reload='source ~/.bashrc'		#reload shell run control
alias gs="git status" 			#N.B. Overrides ghostscript
alias gb="git branch"
alias gd="git diff"
alias gc="git commit"
alias gl="git log --graph --full-history --all --color"
alias gl="git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gm="git merge"
alias gp="git pull origin "
alias ggm="gp master"			#grab master
alias gpm="git push origin master"
alias gf='git rev-list --all | xargs git grep -F'
alias ga='git add '
alias go='git checkout '
alias gk='gitk --all&'
alias gx='gitx --all'
alias gt='git stash'
alias ge="git config -e"
alias qf="find . -name "
alias h='history | grep '

function workdone(){
    default="1 day ago"
    git log --committer=anomalyst@gmail.com --pretty=format:"%Cgreen%ar (%h)%n%Creset> %s %b%n" --since="${1:-$default}" --no-merges
}

function cdb(){
        echo "CREATE DATABASE $1" | sudo mysql --defaults-extra-file=/etc/mysql/debian.cnf
}

function pull-req() {
   echo publishing $1 into branch pull-req-$2
   git branch pull-req-$2 && git checkout pull-req-$2 && git reset --hard origin/master && git cherry-pick $1 && git push fork -f pull-req-$2:pull-req-$2 && git checkout master && echo sucessfully done
}

function gif-ify(){
  if [ -n "$1" && -n "$2" ]
  then
	ffmpeg -i $1 -pix_fmt rgb24 temp.gif
	convert -layers Optimize temp.gif $2
	rm temp.gif
  else
	echo "proper usage: gif-ify <input_movie.mov> <output_file.gif>. You DO need to include extensions."
  fi
}

alias mkdir='mkdir -p'
alias ls='ls --color=auto --human-readable'
alias lr='ls -R'
alias la='ls -a'
alias lla='ls -la'
alias ll='ls -lF'
alias lrt='ls -rt'
alias llrt='ls -lrt'
alias llr='ll -R'
alias lll='ls -alF'
alias le='ls --sort=extension'
alias lle='ll --sort=extension'
alias lt='ls --sort=time'
alias llt='ll --sort=time'


alias ping='ping -c 4'		# stop after 4
alias copy="cp"			# name file -- dir target
alias del="rm -i"		# delete file
alias dir="ls"			# list of files
alias md="mkdir"		# name of new dir
alias rd="rmdir"		# name of dir
alias rename="mv"		# name file -- dir and new rename file
alias vssh="ssh $VMH"		# connect to virtual machine host 1
alias vial='vi ~/.$BAL'
alias putvs='rsync --links -avu ~/vault/scripts/ $VMH:~/vault/scripts/' 
alias getvs='rsync --links -au $VMH:~/vault/scripts/ ~/vault/scripts/'
alias putal='cp ~/.$BAL ~/$BAL && scp ~/.$BAL vmh1:~/'
alias getal='scp $VMH:~/.$BAL ~/'
alias putrc='scp ~/.bashrc $VMH:~/'
alias getrc='scp $VMH:~/.bashrc ~/'
# Ubuntu package control
alias agi='sudo apt-get install'
alias agr='sudo apt-get remove'
alias agp='sudo apt-get purge'
# alias agu='sudo apt-get update'
alias agu='sudo apt-get update && sudo apt-get upgrade'
alias agfi='sudo apt-get -f install' # try to fix broken dependencies
alias acs='apt-cache search'
alias acsh='apt-cache show'
alias acp='apt-cache policy'
alias clean='sudo apt-get clean && sudo apt-get autoclean && sudo apt-get dist-clean && sudo apt-get autoremove'
alias upgrade='sudo apt-get update && sudo apt-get upgrade && sudo apt-get clean'
alias dpi='sudo dpkg -i'
alias dps='dpkg -S'
alias dpc='dpkg -c'
alias dpl='dpkg -l'
alias dplf='dpkg -L'
alias dpr='sudo dpkg-reconfigure'	# reconfigure installed package
alias ah='less ~/.bash_aliases'		# alias help
alias sc='sudo systemctl'		# Control/inspect
					#	system & service manager
alias sls='systemctl list-units'	# show services, 
					#	mount points, devices

					# systemd journal queries & equivalents
alias jc='journalctl'			# less /var/log/messages
alias jcl='journalctl'			# less /var/log/messages
alias jcb='journalctl -b'		# Shows logs from current boot
alias jcf='journalctl -f'		# tail -f /var/log/messages
alias jcg='jc --unit named.service'	# grep named /var/log/messages
alias jcc='jc -f --catalog --lines=9'
alias v='vim'				#use vim over vi if there
alias sv='sudo vim'			#sudo vim over vi if there
alias subv='sudo btrfs'			#sudo btrfs
alias lsbv='sudo btrfs filesystem show'	#show btrfs volumes
alias dfbv='sudo btrfs filesystem df'	#show btrfs volumes free space

alias lsblk='sudo blkid -s LABEL -s TYPE'	#show partition list
alias rcl='script ~/cmds/CMDS`date +%F`'	#record command line stuf
alias mount='sudo mount'			#mount with correct EID
alias umount='sudo umount'			#unmount with correct EID
alias msd='mount | grep --color=never v/sd'	#show mounted partitions
alias ssdh='systemctl status  dhcpd.service'	#redo dhcp/dns
alias ssdh='systemctl status  named.service'	#redo dhcp/dns
alias srdh='systemctl restart dhcpd.service'	#redo dhcp/dns
alias srdn='systemctl restart named.service'	#redo dhcp/dns
alias scps='sudo systemctl restart privoxy.service'	#redo proxy server
    
