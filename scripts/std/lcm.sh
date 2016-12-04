#!/bin/bash -e

echo -e "\n ~ lcm.sh called ~ \n"

source ${PACKAGE_DIR}/scripts/std/std_tpls.sh

echo "Building ${LCM_VERSION} ..."

export LCM_DIR=${TPL_INSTALL_DIR}/common/${LCM_VERSION}/lib
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
cp -rf ${PACKAGE_DIR}/lcm/${LCM_VERSION}/* ${BUILD_LOC}

# LCM configure step
