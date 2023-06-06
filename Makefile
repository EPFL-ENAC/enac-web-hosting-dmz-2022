UID := $(shell id -u)
GID := $(shell id -g)

run:
	docker-compose up --build -d

generate-selfsigned-cert:
	cd cert && OWNER="${UID}.${GID}" docker-compose up --remove-orphans

enacit1-load-mysql-db:
	$(MAKE) -C hosts/enacit1.epfl.ch/enacit1-reserv-vehicules/ load-mysql-db

load-db: enacit1-load-mysql-db

backup-dump:
	$(MAKE) -C hosts/enacit1.epfl.ch/enacit1-reserv-vehicules/ backup-dump DEST_FOLDER=${DEST_FOLDER}
