#!/bin/bash
LOCKFILE=/tmp/AXgqg0lsoeykp9L9NZjIuaqvu7ANILL4foeqzpJcTs3YkwtiJ0

if [ -e ${LOCKFILE} ] && kill -0 `cat ${LOCKFILE}`; then
    echo "already running"
    exit
fi

trap "rm -f ${LOCKFILE}; exit" INT TERM EXIT
echo $$ > ${LOCKFILE}

PASSPHRASE=$PASS
SIGN_PASSPHRASE=$SIGN_PASS
export PASSPHRASE
export SIGN_PASSPHRASE

gpg --list-keys > /dev/null
gpg --import /certs/gpg-key.asc > /dev/null
gpg --allow-secret-key-import --import /certs/gpg-secret-key.asc > /dev/null
gpg --import-ownertrust /certs/ownertrust.gpg.txt
env PASSPHRASE=$PASS
env SIGN_PASSPHRASE=$SIGN_PASS
duplicity --tempdir=/tmp --volsize=40 --gpg-options "--pinentry-mode loopback --compress-level=$COMPRESS_LEVEL" --asynchronous-upload --archive-dir=/duplicity_archive -v3 --full-if-older-than $FULL_IF_OLDER_THAN --encrypt-key=$ENC_KEY --sign-key=$SIGN_KEY --include-globbing-filelist /config/incexcllist /mnt $TARGET

duplicity remove-all-but-n-full $KEEP_FULL -v3 --tempdir=/tmp --archive-dir=/duplicity_archive  --full-if-older-than 14D --force --encrypt-key=$ENC_KEY --sign-key=$SIGN_KEY $TARGET

rm -f ${LOCKFILE}
