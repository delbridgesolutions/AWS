#!/bin/bash
echo "Updating Packages"
sudo yum -y update
sudo yum -y install cyrus-sasl cyrus-sasl-gssapi cyrus-sasl-plain krb5-libs libcurl net-snmp openldap openssl xz-libs
