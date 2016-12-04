# This script must be sourced!

# LCM
if [ "${LCM_DIR}" == "" ] ; then
  export LCM_VER=1.3.1
  export LCM_VERSION=lcm-${LCM_VER}
  export LCM_DIR=${TPL_INSTALL_DIR}/common/${LCM_VERSION}/lib
fi
