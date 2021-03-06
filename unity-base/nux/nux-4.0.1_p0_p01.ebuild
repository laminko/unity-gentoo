# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit base eutils ubuntu-versionator

UURL="mirror://ubuntu/pool/main/n/${PN}"
URELEASE="raring"
UVER_PREFIX="daily13.04.17~13.04"

DESCRIPTION="Visual rendering toolkit for the Unity desktop"
HOMEPAGE="http://launchpad.net/nux"

SRC_URI="${UURL}/${MY_P}${UVER_PREFIX}.orig.tar.gz
	${UURL}/${MY_P}${UVER_PREFIX}-${UVER}.diff.gz"

LICENSE="GPL-3 LGPL-3"
SLOT="0/4"
KEYWORDS="~amd64 ~x86"
IUSE="debug examples tests"
RESTRICT="mirror"

RDEPEND="!unity-base/utouch-geis"
DEPEND="app-i18n/ibus
	dev-libs/boost
	>=dev-libs/glib-2.32.3
	dev-libs/libsigc++:2
	gnome-base/gnome-common
	<media-libs/glew-1.8
	>=sys-devel/gcc-4.6
	unity-base/geis
	x11-libs/gdk-pixbuf
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXxf86vm
	x11-libs/pango
	x11-proto/dri2proto
	x11-proto/glproto"

S="${WORKDIR}/${PN}-${PV}${UVER_PREFIX}"

src_prepare() {
	if [[ ( $(gcc-major-version) -eq 4 && $(gcc-minor-version) -lt 6 ) ]]; then
		die "${P} requires an active >=gcc:4.6, please consult the output of 'gcc-config -l'"
	fi

	epatch -p1 "${WORKDIR}/${MY_P}${UVER_PREFIX}-${UVER}.diff" # This needs to be applied for the debian/ directory to be present #
	for patch in $(cat "debian/patches/series" | grep -v '#'); do
		PATCHES+=( "debian/patches/${patch}" )
	done
	base_src_prepare
	./autogen.sh ${myconf}

	# Fix building with libgeis #
	sed -e "s:libutouch-geis:libgeis:g" \
		-i configure \
			NuxGraphics/nux-graphics.pc.in
}

src_configure() {
	use debug && \
		myconf="${myconf}
			--enable-debug=yes"
	! use examples && \
		myconf="${myconf}
			--enable-examples=no"
	! use tests && \
		myconf="${myconf}
			--enable-tests=no
			--enable-gputests=no"
	econf ${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die
	dosym /usr/libexec/nux/unity_support_test /usr/lib/nux/unity_support_test

	prune_libtool_files --modules
}
