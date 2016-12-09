#!/bin/bash -e

echo -e "\n ~ lcm.sh called ~ \n"

source ${PACKAGE_DIR}/scripts/std/std_tpls.sh

echo "Building ${LCM_VERSION} ..."

export LCM_DIR=${TPL_INSTALL_DIR}/common/${LCM_VERSION}
if [ ! -d "${LCM_DIR}" ] ; then
   mkdir -p ${LCM_DIR}
fi

BUILD_LOC=${PACKAGE_DIR}/lcm/${LCM_VERSION}_build
if [ ! -d "${BUILD_LOC}" ] ; then
   mkdir -p ${BUILD_LOC}
fi

echo -e "\nLCM_DIR = ${LCM_DIR}"
echo -e "BUILD_LOC = ${BUILD_LOC}\n"

if [ ! -d "${PACKAGE_DIR}/lcm/${LCM_VERSION}" ] ; then
  wget https://github.com/lcm-proj/lcm/releases/download/v${LCM_VER}/${LCM_VERSION}.zip &> wget_lcm.log
  mv ${LCM_VERSION}.zip ${PACKAGE_DIR}/lcm/
  unzip ${PACKAGE_DIR}/lcm/${LCM_VERSION}.zip -d ${PACKAGE_DIR}/lcm/ &> unzip_lcm.log
  rm -rf ${PACKAGE_DIR}/lcm/${LCM_VERSION}.zip
fi

cd ${BUILD_LOC}
#cp -rf ${PACKAGE_DIR}/lcm/${LCM_VERSION}/* ${BUILD_LOC}



# LCM configure step
echo -e "   START CONFIGURE AND MAKE "
${PACKAGE_DIR}/lcm/${LCM_VERSION}/configure --prefix=$LCM_DIR &> configure_lcm.out
make &> make_lcm.out
make install &> make_install_lcm.out
echo -e "   END CONFIGURE AND MAKE "



# update environment variables
BASH_TPL=.bashrc_lcm
echo '# this is a bash script for the home directory' > $BASH_TPL
echo 'export LCM_DIR=\' >> $BASH_TPL
echo $LCM_DIR >> $BASH_TPL
echo 'export PATH="${LCM_DIR}/bin:$PATH"' >> $BASH_TPL
echo 'export LD_LIBRARY_PATH="${LCM_DIR}/lib:$LD_LIBRARY_PATH"' >> $BASH_TPL
echo 'export LCM_LIB=$LCM_DIR/lib' >> $BASH_TPL
echo 'export LCM_INC=$LCM_DIR/include' >> $BASH_TPL
echo 'export LCM_FLAGS="-I$LCM_INC -L$LCM_LIB -llcm"' >> $BASH_TPL

# copy the new .bashrc_TPL file back to the user's $HOME directory
cp -rf $BASH_TPL $HOME

# only add the "source" command to the main .bashrc if it does not exist
if [ `grep -c "$BASH_TPL" $HOME/.bashrc` -eq "0" ] ; then
  echo '# LCM' >> $HOME/.bashrc
  echo source $HOME/$BASH_TPL >> $HOME/.bashrc
  echo ' ' >> $HOME/.bashrc
  echo -e "\n ***warning: modified $HOME/.bashrc with 2 new lines***"
fi

# source the new environment variables for the current shell
source $HOME/$BASH_TPL

# exit the lcm.sh script once completed! 
echo -e "\n ~ lcm.sh completed ~ \n"

