#!/usr/bin/env bash

set -euo pipefail

readonly run="${1:-}"

should_run=false
if [ "${run}" == "run" ]; then
    should_run=true
fi

build_container() {
    docker build -f Dockerfile.common -t carter-laravel-starter .
    docker run -it --rm -v $(pwd):/var/www/app carter-laravel-starter:latest /bin/bash new_project.sh run
}

run_container() {
    local -r destination=$(mktemp -d)

    composer create-project --prefer-dist laravel/laravel "${destination}"

    sed -i "s/^DB_CONNECTION=.*/DB_CONNECTION=mysql/g" "${destination}/.env"
    sed -i "s/^DB_HOST=.*/DB_HOST=laravel_db/g" "${destination}/.env"
    sed -i "s/^DB_PORT=.*/DB_PORT=3306/g" "${destination}/.env"
    sed -i "s/^DB_DATABASE=.*/DB_DATABASE=laravel/g" "${destination}/.env"
    sed -i "s/^DB_USERNAME=.*/DB_USERNAME=laravel_user/g" "${destination}/.env"
    sed -i "s/^DB_PASSWORD=.*/DB_PASSWORD=myStrongPassword1234/g" "${destination}/.env"

    cp -rT "${destination}" .

    echo
    echo 'Project created successfully! You can now run it with "docker-compose up"'
}

if $should_run; then
    run_container
else
    build_container
fi
