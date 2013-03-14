EAPI=4
inherit gnome2-utils ubuntu-versionator

URELEASE="raring"
UVER=""

DESCRIPTION="A nice and well polished icon theme"
HOMEPAGE="http://packages.ubuntu.com/raring/human-icon-theme"
SRC_URI="mirror://ubuntu/pool/main/h/${PN}/${PN}_${PV}.tar.gz"

LICENSE="CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="mirror"

RDEPEND="x11-themes/gnome-icon-theme
	x11-themes/tangerine-icon-theme"

src_install() {
	insinto /usr/share/icons
	doins -r Humanity
	doins -r Humanity-Dark
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }