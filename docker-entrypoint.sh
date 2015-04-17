#!/bin/bash
set -e

if [ "$1" = 'supervisord' ]; then

  cat <<EOF > /etc/supervisor/conf.d/supervisord.conf
[supervisord]
nodaemon=true
childlogdir=/var/log/supervisor
loglevel=debug

[program:rethinkdb]
command=rethinkdb --bind all
redirect_stderr=true

EOF

  if [ -n "$BACKUP_INTERVAL" ]; then
    cat <<EOF >> /etc/supervisor/conf.d/supervisord.conf
[program:backup]
command=/backup.sh 
redirect_stderr=true
EOF
  fi
fi

exec "$@"
