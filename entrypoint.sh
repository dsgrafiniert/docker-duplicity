#!/bin/bash
envsubst < /opt/duplicity/duplicity_script.sh.template > /opt/duplicity/duplicity_script.sh
chmod +x /opt/duplicity/duplicity_script.sh
