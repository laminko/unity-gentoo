EAPI=4
PYTHON_DEPEND="2:2.7 3:3.2"
SUPPORT_PYTHON_ABIS="1"

inherit bzr distutils gnome2-utils python ubuntu-versionator

DESCRIPTION="Cooking lens for the Unity desktop environment"
HOMEPAGE="https://launchpad.net/lens-cooking"
EBZR_PROJECT="lens-cooking"
EBZR_BRANCH="trunk"
EBZR_REPO_URI="lp:lens-cooking"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-libs/dee
	dev-libs/glib:2
	dev-libs/libunity
	dev-python/pygobject
	unity-base/unity"

src_prepare() {
	epatch "${FILESDIR}/setup.py-install_files-fix.diff"
	distutils_src_prepare
}
