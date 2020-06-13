#!/bin/sh
cd /var/www/codo-task/

#任务系统-task
TASK_DB_DBNAME='codo_task'
sed -i "s#cookie_secret = .*#cookie_secret = '${cookie_secret}'#g" settings.py
sed -i "s#DEFAULT_DB_DBHOST = .*#DEFAULT_DB_DBHOST = os.getenv('DEFAULT_DB_DBHOST', '${DEFAULT_DB_DBHOST}')#g" settings.py
sed -i "s#DEFAULT_DB_DBPORT = .*#DEFAULT_DB_DBPORT = os.getenv('DEFAULT_DB_DBPORT', '${DEFAULT_DB_DBPORT}')#g" settings.py
sed -i "s#DEFAULT_DB_DBUSER = .*#DEFAULT_DB_DBUSER = os.getenv('DEFAULT_DB_DBUSER', '${DEFAULT_DB_DBUSER}')#g" settings.py
sed -i "s#DEFAULT_DB_DBPWD = .*#DEFAULT_DB_DBPWD = os.getenv('DEFAULT_DB_DBPWD', '${DEFAULT_DB_DBPWD}')#g" settings.py
sed -i "s#DEFAULT_DB_DBNAME = .*#DEFAULT_DB_DBNAME = os.getenv('DEFAULT_DB_DBNAME', '${TASK_DB_DBNAME}')#g" settings.py
sed -i "s#READONLY_DB_DBHOST = .*#READONLY_DB_DBHOST = os.getenv('READONLY_DB_DBHOST', '${READONLY_DB_DBHOST}')#g" settings.py
sed -i "s#READONLY_DB_DBPORT = .*#READONLY_DB_DBPORT = os.getenv('READONLY_DB_DBPORT', '${READONLY_DB_DBPORT}')#g" settings.py
sed -i "s#READONLY_DB_DBUSER = .*#READONLY_DB_DBUSER = os.getenv('READONLY_DB_DBUSER', '${READONLY_DB_DBUSER}')#g" settings.py
sed -i "s#READONLY_DB_DBPWD = .*#READONLY_DB_DBPWD = os.getenv('READONLY_DB_DBPWD', '${READONLY_DB_DBPWD}')#g" settings.py
sed -i "s#READONLY_DB_DBNAME = .*#READONLY_DB_DBNAME = os.getenv('READONLY_DB_DBNAME', '${TASK_DB_DBNAME}')#g" settings.py
sed -i "s#DEFAULT_REDIS_HOST = .*#DEFAULT_REDIS_HOST = os.getenv('DEFAULT_REDIS_HOST', '${DEFAULT_REDIS_HOST}')#g" settings.py
sed -i "s#DEFAULT_REDIS_PORT = .*#DEFAULT_REDIS_PORT = os.getenv('DEFAULT_REDIS_PORT', '${DEFAULT_REDIS_PORT}')#g" settings.py
sed -i "s#DEFAULT_REDIS_PASSWORD = .*#DEFAULT_REDIS_PASSWORD = os.getenv('DEFAULT_REDIS_PASSWORD', '${DEFAULT_REDIS_PASSWORD}')#g" settings.py
sed -i "s#DEFAULT_MQ_ADDR = .*#DEFAULT_MQ_ADDR = os.getenv('DEFAULT_MQ_ADDR', '${DEFAULT_MQ_ADDR}')#g" settings.py
sed -i "s#DEFAULT_MQ_USER = .*#DEFAULT_MQ_USER = os.getenv('DEFAULT_MQ_USER', '${DEFAULT_MQ_USER}')#g" settings.py
sed -i "s#DEFAULT_MQ_PWD = .*#DEFAULT_MQ_PWD = os.getenv('DEFAULT_MQ_PWD', '${DEFAULT_MQ_PWD}')#g" settings.py



try_num=0

while [[ $try_num -le 100 ]];
do
     if $(curl  -s ${DEFAULT_DB_DBHOST}:${DEFAULT_DB_DBPORT}  > /dev/null);then
          python3 db_sync.py
          exit 0
     else
          echo 'wait mysql start to do db_sync.py'
     fi
     let try_num+=1
     sleep 6
done