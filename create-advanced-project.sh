#!/bin/bash
echo '----------------------------------------------clearcache'
composer clearcache -vvv
echo '-----------------------------------------------g repo.packagist'
composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/ -vvv
#composer config -g --unset repos.packagist  -vvv
echo '----------------------------------------------create-project'
timeout 30 composer create-project yiisoft/yii2-app-advanced advanced -vvv #这命令最多执行30s
echo '----------------------------------------------cd advanced'
cd advanced
echo '----------------------------------------------unset repos.0'
composer config --unset repos.0 -vvv
echo '----------------------------------------------repo.packagist'
composer config repo.packagist composer https://mirrors.aliyun.com/composer/ -vvv
#composer config --unset repos.packagist  -vvv
echo '---------------------------------------------- --dev remove'
composer --no-update --dev remove symfony/browser-kit codeception/verify codeception/module-filesystem codeception/module-yii2 codeception/module-asserts codeception/codeception yiisoft/yii2-faker -vvv
echo '----------------------------------------------require'
composer --no-update require yidas/yii2-bower-asset -vvv
echo '----------------------------------------------install'
composer install -vvv
echo '----------------------------------------------@bower'
sed -i "s/'\@bower/'\@bower' => '\@vendor\/yidas\/yii2-bower-asset\/bower',\n\t\t\/\/'@bower/g" common\\config\\main.php
echo '----------------------------------------------init dev overwrite'
php init --env=Development --overwrite=n
