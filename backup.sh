###################
#Website Backup Script
#Alan Smith | smithalan2@gmail.com
# 28/01/2016
###################
#vhkst | bernd@hvkst.de
# 30/04/2022
###################
#!/bin/sh
##You need to change the below values##
#MySQL Username
mysql_user="db_user"
#MySql user password
mysql_pass="db_pass"
#MySql host
mysql_host="localhost"
#Database to backup
mysql_db="db_name"
#Path to website foler/folder to backup
file_dir="/var/www/html/mysite"
#The folder to save the backups in
backupfolder="/var/home/user/backups"
now="$(date +'%d_%m_%Y_%H_%M')"
#Date and time for the new Folder
date="$(date +'%d_%m_%Y')"
time="$(date +'%H_%M')"
#Set the backup filename with todays date/time
filename="backup_$now".tar.gz
#Path for database dump
temp_mysql="$backupfolder"/"db_$now".sql
#Path for file dump
temp_files="$backupfolder"/"backup_$now".tar.gz
#Start MYSQL Dump
echo "Starting mysql dump"
mysqldump --user=$mysql_user --password=$mysql_pass --host=$mysql_host $mysql_db > $temp_mysql
echo "Finished mysql dump, starting file dump"
#Zip all files in specified directory
tar -cvzf $temp_files $file_dir
echo "File Dump Finished."
#Create Folders with date and time
mkdir -p $backupfolder/$date/$time
echo "Backup Folder created"
#Move backups into date/time-Folder
mv $backupfolder/$filename $backupfolder/$date/$time/
mv "$backupfolder"/"db_$now".sql $backupfolder/$date/$time/
echo "Backups moved to $date/$time"
echo "Backup finished. Your backup is located at "$backupfolder/$date/$time/

