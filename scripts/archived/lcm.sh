#!/bin/bash -e

source ${PACKAGE_DIR}/scripts/std/std-tpls.sh

echo "Building ${LCM_VERSION} ..."

export LCM_DIR=${TPL_INSTALL_DIR}/common/${LCM_VERSION}/lib
if [ ! -d "${LCM_DIR}" ] ; then
   mkdir -p ${LCM_DIR}
   echo ${LCM_DIR}
fi

BUILD_LOC=${PACKAGE_DIR}/lcm/${LCM_VERSION}_build
if [ ! -d "${BUILD_LOC}" ] ; then
   mkdir -p ${BUILD_LOC}
fi

# build instructions for LCM:
cd ${BUILD_LOC}
wget https://github.com/lcm-proj/lcm/releases/download/v1.3.1/lcm-1.3.1.zip
unzip lcm-1.3.1.zip
cd lcm-1.3.1
./configure
make

# commands by root user
sudo make install
sudo ldconfig

# copy library to the ${LCM_DIR} like in LAPACK example
cp * ${LCM_DIR}

# (we should not test in here I think, but I will try out LCM like this first)
cp ${PACKAGE_DIR}/lcm/example_t.lcm \
${PACKAGE_DIR}/lcm/${LCM_VERSION}_build/${LCM_VERSION}/examples/cpp

# specifically test if C++ works
cd examples/cpp
lcm-gen -x example_t.lcm
make

# begin example
echo " "
echo " "
echo " "
echo " SEND AND RECV TEST "
echo " "
echo " "
echo " "

# listener runs in the background
(./listener &)
sleep 2

# sender passes 1 test message
./send-message
sleep 2

echo " "
echo " "
echo " "
echo " TESTING COMPLETE "
echo " "
echo " "
echo " "

# end example
echo "Installed: ${LCM_DIR}"

# kill the listener process
ps aux | grep ./listener | awk {'print $2'} | xargs kill
