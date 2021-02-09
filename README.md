# PHP7.4 + Nginx + Mariadb + Adminer : Symfony + Doctrine

## Infra docker :

[docker-compose.yam](docker-compose.yaml)

````
docker-compose build
docker-compose up -d
````

## Installation applicative

### PHP7.4
[composer + extensions](./.docker/php/Dockerfile)

Dossier applicatif `/usr/src/app` : `composer install`
```
# .env
DATABASE_URL="mysql://root:root@127.0.0.1:3306/<db_name>>"
``` 

### Nginx : 
[Config](./.docker/nginx/app.conf)

Webapp accessible sur [http://localhost:8888/](http://localhost:8888/)

### Adminer : 
Adminer accessible sur [http://localhost:8080/](http://localhost:8080/)

Login : 
- serveur : `db`
- login : `root`
- password : `root`
