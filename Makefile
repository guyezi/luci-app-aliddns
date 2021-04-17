#
# Copyright (C) 2018 chenhw2 <https://guyezi.com/>
#
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

LUCI_TITLE:=LuCI Support for aliddns
LUCI_DESCRIPTION:=LuCI Support for ALiDDNS.
LUCI_DEPENDS:=+openssl-util +curl
LUCI_PKGARCH:=all

PKG_NAME:=luci-app-aliddns
PKG_VERSION:=0.3.0
PKG_RELEASE:=1

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=guyezi <https://guyezi.com/>

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
