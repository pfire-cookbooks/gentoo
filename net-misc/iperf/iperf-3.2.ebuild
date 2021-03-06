# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit autotools eutils

DESCRIPTION="A TCP, UDP, and SCTP network bandwidth measurement tool"
HOMEPAGE="https://github.com/esnet/iperf/"
SRC_URI="${HOMEPAGE}archive/${PV/_/}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="3"
KEYWORDS="~amd64 ~arm ~hppa ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~m68k-mint"
IUSE="sctp static-libs"

DEPEND="sctp? ( net-misc/lksctp-tools )"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P/_/}

PATCHES=( "${FILESDIR}"/${PN}-3.0.5-flags.patch )

src_prepare() {
	default

	eautoreconf
}

src_configure() {
	use sctp || export ac_cv_header_netinet_sctp_h=no
	econf $(use_enable static-libs static)
}

src_install() {
	default
	newconfd "${FILESDIR}"/iperf.confd iperf3
	newinitd "${FILESDIR}"/iperf3.initd iperf3
	prune_libtool_files
}
