UID := $(shell id -u)
GID := $(shell id -g)

run:
	docker compose \
	  -f docker-compose.yml \
	  -f docker-compose-bluecity.yml \
	  -f docker-compose-enacit1.yml \
	  up --build -d

down:
	docker compose \
	  -f docker-compose.yml \
	  -f docker-compose-bluecity.yml \
	  -f docker-compose-enacit1.yml \
	  down

logs:
	docker compose \
	  -f docker-compose.yml \
	  -f docker-compose-bluecity.yml \
	  -f docker-compose-enacit1.yml \
	  logs -f

generate-selfsigned-cert:
	cd cert && OWNER="${UID}.${GID}" docker-compose up --remove-orphans

enacit1-load-mysql-db:
	$(MAKE) -C hosts/enacit1.epfl.ch/enacit1-reserv-vehicules/ load-mysql-db

load-db: enacit1-load-mysql-db

backup-dump:
	$(MAKE) -C hosts/enacit1.epfl.ch/enacit1-reserv-vehicules/ backup-dump DEST_FOLDER=${DEST_FOLDER}
