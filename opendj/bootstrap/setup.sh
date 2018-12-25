#!/usr/bin/env bash
# Default setup script

echo "Setting up default OpenDJ instance"

# If any optional LDIF files are present load them

/opt/opendj/setup --cli -p $PORT --ldapsPort $LDAPS_PORT --enableStartTLS --generateSelfSignedCertificate \
  --baseDN $BASE_DN -h localhost --rootUserPassword "$ROOT_PASSWORD" \
  --acceptLicense --no-prompt --sampleData 1


if [ -d /opt/opendj/bootstrap/ldif/99-user.ldif ]; then
  echo "loading initial schema for openam"
  /opt/opendj/bin/ldapmodify -D "$ROOT_USER_DN" -h localhost -p $PORT -w $ROOT_PASSWORD -f /opt/opendj/bootstrap/ldif/99-user.ldif

fi
