FROM php:8.2-cli

WORKDIR /var/www

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    zip \
    libzip-dev \
    libonig-dev \
    && docker-php-ext-install pdo pdo_mysql zip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

RUN composer create-project --prefer-dist yiisoft/yii2-app-basic yii2-basic

WORKDIR /var/www/yii2-basic

EXPOSE 8080

CMD ["php", "-S", "0.0.0.0:8080", "-t", "web"]

