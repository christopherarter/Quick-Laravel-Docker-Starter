## Quick Laravel Docker Starter

This starter repo was born out of frustration of getting docker working with Laravel. Hopefully this will save you some headache!

Prerequisites:

1. **PHP 7.1 (minimum)**
2. **Composer** [install guide](https://getcomposer.org/doc/00-intro.md)
3. **Docker** [install guide](https://docs.docker.com/v17.09/engine/installation/)
4. **Docker Compose** [install guide](https://docs.docker.com/compose/install/)

### Get started

 
1. Clone this repo and navigate to the repo folder. Run `bash ./new_project.sh`
2. Run `docker-compose up`

When you run `docker ps`, you should see your service running locally at `http://localhost:9000`

**To run migrations and commands that interact with the database** you need to be inside the laravel web app container. 

Run `docker ps` and get the id of the laravel web container. Next, run `docker exec -it <container-id> /bin/bash` and you should be at `/var/www/app`. You may now run artisan commands to interact with the database.

### Connecting to your database with a database tool 

To connect with this database using tools like MySQL Workbench, DB Beaver or TablePlus, you can access it with the `3305` port, username and password you specified in your `.env` file.
