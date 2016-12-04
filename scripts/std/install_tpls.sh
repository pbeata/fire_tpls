#!/bin/bash -e

# NOTE: THESE FOUR export COMMANDS SHOULD BE DONE IN THE SHELL ONCE ONLY
#export TPL_INSTALL_DIR=some/path
#export MAKE_FLAGS=(not used in current version)
#export METHOD=(not used)
#export BUILD_LCM=(1 or "")

_SCRIPT_DIR=`echo $0 | sed "s/\(.*\)\/scripts\/std\/install_tpls.sh/\1/g"`
echo "_SCRIPT_DIR = $_SCRIPT_DIR"

export PACKAGE_DIR=$(readlink -f ${_SCRIPT_DIR})
echo "PACKAGE_DIR = ${PACKAGE_DIR}"

echo
echo "*******************************"
echo "*** Running install_tpls.sh ***"
echo "*******************************"
echo
echo "PACKAGE_DIR      = ${PACKAGE_DIR}"
echo "TPL_INSTALL_DIR  = ${TPL_INSTALL_DIR}"

#echo "MAKE_FLAGS       = ${MAKE_FLAGS}"
#echo "METHOD           = ${METHOD}"

STD_SCRIPTS_DIR=${PACKAGE_DIR}/scripts/std
echo -e "\nSTD_SCRIPTS_DIR = $STD_SCRIPTS_DIR"

# LCM
echo $BUILD_LCM
if [ "${BUILD_LCM}" != "" ] ; then
  ${STD_SCRIPTS_DIR}/lcm.sh
fi
