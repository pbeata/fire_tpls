#!/bin/bash -e

BASH_TPL=.bashrc_lcm

# only add the "source" command to the main .bashrc if it does not exist
if [ `grep -c "$BASH_TPL" $HOME/.bashrc` -eq "0" ] ; then
  echo '# LCM' >> $HOME/.bashrc
  echo source $HOME/$BASH_TPL >> $HOME/.bashrc
  echo ' ' >> $HOME/.bashrc
  echo -e "\n ***warning: modified $HOME/.bashrc with 2 new lines***"
fi

# exit the lcm.sh script once completed! 
echo -e "\n ~ lcm.sh completed ~ \n"

