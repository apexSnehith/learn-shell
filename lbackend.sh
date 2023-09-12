source common.sh
component=backend

echo Install NodeJS Repos
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$log_file
echo $?

echo install NodeJS
dnf install nodejs -y &>>$log_file
echo $?

echo Copy Backend Service File
cp backend.service /etc/systemd/system/backend.service &>>$log_file
echo $?

echo Add Application User
useradd expense &>>$log_file
echo $?

echo Clean App Content
rm -rf /app &>>$log_file
mkdir /app
cd /app

download_and_extract
echo $?

echo Download Dependencies
npm install &>>$log_file
echo $?

echo Start Backend Service
systemctl daemon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl restart backend &>>$log_file
echo $?

echo Install MySql Client
dnf install mysql -y &>>$log_file
echo $?

echo Load Schema
mysql -h mysql.snehithdops.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$log_file
echo $?