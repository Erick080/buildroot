################################################################################
#
# open62541
#
################################################################################

OPEN62541_VERSION = 1.0
OPEN62541_DL_VERSION = v$(OPEN62541_VERSION)
OPEN62541_SITE_METHOD = git
OPEN62541_SITE = git://github.com/open62541/open62541.git
OPEN62541_GIT_SUBMODULES = YES
OPEN62541_INSTALL_STAGING = YES
OPEN62541_LICENSE = MPL-2.0
OPEN62541_LICENSE_FILES = LICENSE
OPEN62541_CPE_ID_VENDOR = open62541

# Force Release build to remove -Werror.
# Don't use git describe to get the version number.
# Disable hardening options to let Buildroot handle it.
OPEN62541_CONF_OPTS = \
	-DCMAKE_BUILD_TYPE=Release \
	-DGIT_EXECUTABLE=NO \
	-DOPEN62541_VERSION=v$(OPEN62541_VERSION) \
	-DUA_ENABLE_HARDENING=OFF

ifeq ($(BR2_PACKAGE_OPEN62541_UA_NAMESPACE_ZERO_MINIMAL),y)
OPEN62541_CONF_OPTS += -DUA_NAMESPACE_ZERO=MINIMAL
else ifeq ($(BR2_PACKAGE_OPEN62541_UA_NAMESPACE_ZERO_REDUCED),y)
OPEN62541_CONF_OPTS += -DUA_NAMESPACE_ZERO=REDUCED
else ifeq ($(BR2_PACKAGE_OPEN62541_UA_NAMESPACE_ZERO_FULL),y)
OPEN62541_CONF_OPTS +=  -DUA_NAMESPACE_ZERO=FULL
endif

ifeq ($(BR2_PACKAGE_OPEN62541_JSON_ENCODING),y)
OPEN62541_CONF_OPTS += -DUA_ENABLE_JSON_ENCODING=ON
else
OPEN62541_CONF_OPTS += -DUA_ENABLE_JSON_ENCODING=OFF
endif

ifeq ($(BR2_PACKAGE_OPEN62541_PUBSUB),y)
OPEN62541_CONF_OPTS += -DUA_ENABLE_PUBSUB=ON
else
OPEN62541_CONF_OPTS += -DUA_ENABLE_PUBSUB=OFF
endif

ifeq ($(BR2_PACKAGE_OPEN62541_PUBSUB_DELTAFRAMES),y)
OPEN62541_CONF_OPTS += -DUA_ENABLE_PUBSUB_DELTAFRAMES=ON
else
OPEN62541_CONF_OPTS += -DUA_ENABLE_PUBSUB_DELTAFRAMES=OFF
endif

ifeq ($(BR2_PACKAGE_OPEN62541_PUBSUB_INFORMATIONMODEL),y)
OPEN62541_CONF_OPTS += -DUA_ENABLE_PUBSUB_INFORMATIONMODEL=ON
else
OPEN62541_CONF_OPTS += -DUA_ENABLE_PUBSUB_INFORMATIONMODEL=OFF
endif

$(eval $(cmake-package))
