# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit toolchain-funcs

DESCRIPTION="a dockapp cpu monitor with spinning 3d objects"
HOMEPAGE="http://linux-bsd-unix.strefa.pl/index.en.html"
SRC_URI="http://linux-bsd-unix.strefa.pl/${P}.tar.gz -> ${P}.tar"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm"
DEPEND="${RDEPEND}"

DOCS=(
	"${WORKDIR}"/${P}/CHANGES
	"${WORKDIR}"/${P}/README
	)
S="${WORKDIR}/${P}/wmcube"

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_install() {
	dobin ${PN}
	einstalldocs
	doman ${PN}.1

	insinto /usr/share/${PN}
	doins "${WORKDIR}"/${P}/3D-objects/*.wmc
}
