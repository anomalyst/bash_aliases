#bash_aliases

bash 2-3 letter aliases to shortcut various commands, variously:

- git commands
- package commands for apt (Ubuntu/Debian), dnf (Fedora/CentOS) & pacman (ARCH)
- octopress blogging
- .mov to .gif conversion (using ffmpeg)
- common DOS command equivalents
- ssh encryption key creation and authorization (especially elliptical curve)
- dns cache flush
- command history
- mysql/mariadb
	+ ls
	+ mkdir/rmdir
	+ vi/vim
	+ dpkg
	+ btrfs
	+ systemctl
	+ journalctl
	+ blkid
	+ mount/umount

##Installation
assuming the git clone directory tree has a conventional layout and looks like
```bash
~/git/
  └── bash_aliases/
      ├── bash_aliases
      ├── LICENSE
      └── README.md
```
### Use the following commands:
```bash
ln -s ~/git/bash_aliases/bash_aliases ~/.bash_aliases 
source ~/.bash_aliases

#
# add bash_aliases login load for everyone
#
BR=bashrc							#run control file name
BA=bash_aliases 					#alias file name
EF=\$EF								#execution file
if [ -e /etc/bash.$BR ]				#?-ubuntu central rc?
then
	BR=/etc/bash.$BR				#y-save for later
else
	BR=/etc/$BR						#n-use fedora style
fi									#@end rc style check

grep "source" $BR  >/dev/null	 	#see if we are already there
if [ $? -eq 1 ]						#?-find us?
then								#n-add the logic
cat <<_EOF >>$BR					#append to /etc RC file
# do alias load for everyone
EF=~/.$BA 
if [ -e $EF ];
then
	source $EF
fi
_EOF
fi									#@-done adding bashrc logic
```
