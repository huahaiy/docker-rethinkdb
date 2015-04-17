# docker-rethinkdb

Run RethinkDB in a docker containter. Data are stored in `/data`, a volume expected to be linked to a host directory. 

If an environment variable `BACKUP_INTERVAL` is set, this container will periodically dump the database to a gzip file located in `/backup`, which again is expected to be linked to the host. The value of `BACKUP_INTERVAL` follows the format of bash `sleep` command, i.e. the default unit is second, m for minutes, h for hours and d for days. For example, set `BACKUP_INTERVAL=1h` will backup the database every hour.
