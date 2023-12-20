# meta-mywebserver/recipes-example/mywebserver/mywebserver.bb

SUMMARY = "Web Server Recipe"
DESCRIPTION = "Recipe to install and configure a simple web server."
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://mywebserver.service \
           file://index.html"

SYSTEMD_AUTO_ENABLE = "enable"
SYSTEMD_SERVICE:${PN} += " mywebserver.service"

inherit systemd

S = "${WORKDIR}"

do_install() {

    install -d ${D}${systemd_system_unitdir}/
    install -m 0644 mywebserver.service ${D}${systemd_system_unitdir}

    install -d ${D}/www/
    install -m 0644 index.html ${D}/www
}

FILES:${PN} += "${systemd_system_unitdir}/* /www/*"

