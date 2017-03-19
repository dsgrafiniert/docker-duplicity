#!/bin/bash
envsubst '$PASS $SIGN_PASS $COMPRESS_LEVEL $FULL_IF_OLDER_THAN $ENC_KEY $SIGN_KEY $TARGET $KEEP_FULL' < /opt/duplicity/duplicity_script.sh.template > /opt/duplicity/duplicity_script.sh
chmod +x /opt/duplicity/duplicity_script.sh
