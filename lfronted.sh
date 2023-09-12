source common.sh
component=frontend

echo installing nginx
dnf install nginx -y &>>$log_file
echo $?

echo placing expense config file in nginx
cp expense.conf /etc/nginx/default.d/expense.conf &>>$log_file
echo $?

echo removing default content
rm -rf /usr/share/nginx/html/* &>>$log_file
echo $?

cd /usr/share/nginx/html

download_and_extract
echo $?

echo starting Nginx server
systemctl enable nginx &>>$log_file
systemctl restart nginx &>>$log_file
echo $?