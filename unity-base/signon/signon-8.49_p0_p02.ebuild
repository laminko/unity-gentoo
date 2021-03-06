# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit base qt4-r2 ubuntu-versionator

UURL="mirror://ubuntu/pool/main/s/${PN}"
URELEASE="raring"

DESCRIPTION="Single Sign On framework for the Unity desktop"
HOMEPAGE="https://launchpad.net/signon"
SRC_URI="${UURL}/${MY_P}.orig.tar.gz
	${UURL}/${MY_P}-${UVER}.debian.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+debug doc"
RESTRICT="mirror"

DEPEND="dev-qt/qtcore:4
	dev-qt/qtdbus:4
	dev-qt/qtgui:4
	dev-qt/qtsql:4
	dev-qt/qtxmlpatterns:4
	doc? ( app-doc/doxygen )"

src_prepare() {
	# Fix remotepluginprocess.cpp missing QDebug include on some systems #
	epatch "${FILESDIR}/remotepluginprocess-QDebug-fix.patch"

	# Ubuntu patchset #
	for patch in $(cat "${WORKDIR}/debian/patches/series" | grep -v \# ); do
		PATCHES+=( "${WORKDIR}/debian/patches/${patch}" )
	done
	base_src_prepare

	use debug && \
		for file in $(grep -r debug * | grep \\.pro | awk -F: '{print $1}' | uniq); do
			sed -e 's:CONFIG -= debug_and_release:CONFIG += debug_and_release:g' \
				-i "${file}"
		done

	use doc || \
		for file in $(grep -r doc/doc.pri * | grep \\.pro | awk -F: '{print $1}'); do
			sed -e '/doc\/doc.pri/d' -i "${file}"
		done
}
