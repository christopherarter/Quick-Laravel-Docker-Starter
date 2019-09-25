## Quick Laravel Docker Starter

This starter repo was born out of frustration of getting docker working with Laravel. Hopefully this will save you some headache!

Prerequisites:

1. **PHP 7.1 (minimum)**
2. **Composer** [install guide](https://getcomposer.org/doc/00-intro.md)
3. **Docker** [install guide](https://docs.docker.com/v17.09/engine/installation/)
4. **Docker Compose** [install guide](https://docs.docker.com/compose/install/)

###Get started

 
1. Clone this repo and navigate to the repo folder. Run `composer create-project --prefer-dist laravel/laravel my-app`
4. Run `mv my-app/* my-app/.* ./ && rm -rf my-app`
5. Change the values in your `.env` to the values below:

```
DB_CONNECTION=mysql
DB_HOST=laravel_db
DB_PORT=3306
DB_DATABASE=laravel
DB_USERNAME=laravel_user
DB_PASSWORD=myStrongPassword1234
```
 
The last step, run `docker-compose up`

When you run `docker ps`, you should see your service running locally at `http://localhost:9000`

**To run migrations and commands that interact with the database** you need to be inside the laravel web app container. 

Run `docker ps` and get the id of the laravel web container. Next, run `docker exec -it <container-id> /bin/bash` and you should be at `/var/www/app`. You may now run artisan commands to interact with the database.

### Connecting to your database with a database tool 

To connect with this database using tools like MySQL Workbench, DB Beaver or TablePlus, you can access it with the `3305` port, username and password you specified in your `.env` file.