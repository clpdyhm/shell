#****copyright by lp.chang****#
#****create at 2016/10/17****#
#****division nginx log file to small ones

#!/bin/bash
PRE_FIX=/usr/local/nginx
LOG_PATH=$PRE_FIX/logs/
#file name before
LOG_FILE=error.log
PID_PATH=$PRE_FIX/logs/
PID_FILE=nginx.pid
#date
DATE=`date +"%Y%m%d_%H%M%S"`
#byte to KB(1024), MB(1024*1024)
KB_SIZE=1024
MB_SIZE=1048576


#get file size
FILE_SIZE_BYTE=`ls -l $LOG_PATH$LOG_FILE|awk '{print $5;}'`

#FILE_SIZE_KB=`echo "sclae=2; $FILE_SIZE_BYTE/$KB_SIZE" | bc`
FILE_SIZE_MB=`echo "sclae=2; $FILE_SIZE_BYTE/$MB_SIZE" | bc`
echo "file ${LOG_FILE} size ${FILE_SIZE_MB}M"

if [[ $FILE_SIZE_MB -gt 100 ]]; then
#backup log file
mv ${LOG_PATH}${LOG_FILE} ${LOG_PATH}${LOG_FILE}.$DATE.log
#loadup log file again
kill -USR1 `cat $PID_PATH$PID_FILE`
fi


