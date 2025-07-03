# Variables
DOCKER_COMPOSE = docker-compose -f srcs/docker-compose.yml

# Lancer les services (build + détaché)
up:
	@mkdir -p /home/yanolive/data/mariadb
	@mkdir -p /home/yanolive/data/wordpress
	$(DOCKER_COMPOSE) up --build

# Arrêter et supprimer les containers + volumes anonymes
down:
	$(DOCKER_COMPOSE) down --volumes

# Redémarrer proprement
re:
	$(MAKE) down
	$(MAKE) up

# Afficher les logs en temps réel
logs:
	$(DOCKER_COMPOSE) logs -f

# Stopper les containers sans les supprimer
stop:
	$(DOCKER_COMPOSE) stop

# Supprimer les images construites par docker-compose
clean:
	$(DOCKER_COMPOSE) down --rmi all --volumes
	@rm -rf /home/yanolive/data
