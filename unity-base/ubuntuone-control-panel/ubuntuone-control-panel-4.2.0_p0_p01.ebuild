# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
GNOME2_LA_PUNT="yes"

PYTHON_DEPEND="2:2.7"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils ubuntu-versionator

UURL="mirror://ubuntu/pool/main/u/${PN}"
URELEASE="raring"

DESCRIPTION="Ubuntu One control panel for the Unity desktop"
HOMEPAGE="https://launchpad.net/ubuntuone-control-panel"
SRC_URI="${UURL}/${MY_P}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

DEPEND="dev-lang/python
	dev-libs/dbus-glib"
RDEPEND="${DEPEND}
	dev-python/configglue
	dev-python/dbus-python
	dev-python/gnome-keyring-python
	dev-python/httplib2
	dev-python/notify-python
	dev-python/oauth
	<=dev-python/oauthlib-0.3.7
	dev-python/pygtk
	dev-python/dirspec
	dev-python/lazr-restfulclient
	dev-python/pyinotify
	dev-python/pyxdg
	dev-python/simplejson
	>=dev-python/twisted-names-12.2.0
	>=dev-python/twisted-web-12.2.0
	unity-base/ubuntu-sso-client
	unity-base/ubuntuone-storage-protocol
	x11-misc/lndir
	x11-misc/xdg-utils"

src_install() {
	# Delete some files that are only useful on Ubuntu
	rm -rf "${D}"etc/apport "${D}"usr/share/apport

	distutils_src_install
}
