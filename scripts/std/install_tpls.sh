#!/bin/bash -e

if [ "${TPL_INSTALL_DIR}" == "" ] ; then
  echo -e "***error 1: must define environment variable TPL_INSTALL_DIR \n"
  exit 1
fi

if [ ! -d "${TPL_INSTALL_DIR}" ] ; then
  echo -e "***error 2: must define an existing TPL_INSTALL_DIR"
  echo -e "    --->  could not find ${TPL_INSTALL_DIR} \n"
  exit 2
fi

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
echo "BUILD_LCM = ${BUILD_LCM}"
if [ "${BUILD_LCM}" != "" ] ; then
  ${STD_SCRIPTS_DIR}/lcm.sh
fi
