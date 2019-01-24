restart_service:
	sudo rm -f /tmp/audit.log
	sudo systemctl stop camflowd
	sudo rm -f /tmp/audit.log
	sudo systemctl start camflowd
	stat /tmp/audit.log

record_version:
	camflow -v > version.txt

record_config:
	camflow -c > config.txt

record_state:
	camflow -s > state.txt

wget: restart_service
	sudo camflow --track-file /bin/wget true
	wget www.google.com
	sudo camflow --track-file /bin/wget false
	sleep 10
	cp /tmp/audit.log wget.log
	rm index.html

all: record_version record_config record_state wget
