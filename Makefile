include ../Makefile
ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
SERVICE_NAME=$(shell basename $(ROOT_DIR))

# --project_name must be in lowercase
SERVICE_NAME_LOWER=$(shell echo "$(SERVICE_NAME)" | sed -e 's/\(.*\)/\L\1/')
# Git Folders
DOCKER_FOLDER=docker/
SECRET_FOLDER=secret/

# Remote Folders
INSTALL_FOLDER=/secret/$(SERVICE_NAME)/

DOCKER_FILE=-f $(DOCKER_FOLDER)docker-compose.yml -f $(INSTALL_FOLDER)secret-compose.yml
DOCKER_COMMAND= $(ENV) docker compose -p $(SERVICE_NAME_LOWER) $(DOCKER_FILE)

install:
	@mkdir -p $(INSTALL_FOLDER)
	@cp -R $(SECRET_FOLDER)/* $(INSTALL_FOLDER)
	@echo "Création network web"
	@docker network create web
	@touch config/acme.json
	@chmod 600 config/acme.json

start:
	$(DOCKER_COMMAND)  up -d --pull always
