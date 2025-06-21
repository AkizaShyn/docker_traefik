# Introduction

Le but de cette doc est de vous expliquer comment utiliser ce repos.

# Installation

Pour installer les prérequis faire :

`sudo make install`

Cela va vous créer le network web, créer le fichier config/acme.json et /secret/docker_traefik/secret-compose.yml

# Configuration

Il vous faut modifier le mot de passe dans `/secret/docker_traefik/secret-compose.yml`

Il vous faut également modifier `/config/traefik.toml` pour mettre votre adresse mail.

Il faut également mettre à jour votre nom de domaine dans `docker/docker-compose.yml`

# Lancement 

`sudo make start`

Vous aurez accès au dashboard de traefik via `https://monndd.ext/dashboard` avec l'identifiant et mot de passe définit dans `secret-compose.yml`

# Ajout de conteneur géré par traefik

Dans vos autres projet il vous suffira d'ajouter ces lignes dans votre docker-compose 

```docker-compose
labels:
    - "traefik.enable=true"
    - "traefik.http.routers.blog.rule=Host(`blog.exemple.fr`, `www.blog.example.fr`)"
    - "traefik.http.routers.blog.entrypoints=websecure"

```

# Générer un mot de passe : 

docker run --rm httpd:2.4 htpasswd -nbB admin "motdepasse" | sed 's/[$]/$$$$/g'