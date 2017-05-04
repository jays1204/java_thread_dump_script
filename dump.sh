#!/usr/bin/env bash

# 실행중인 java pid를 가져온다.
JAVA_PIDS=$($JAVA_HOME/bin/jps | grep -v "Jps" | cut -f1 -d' ')

## 가져온 java pid에 대해서 jstack으로 dump를 뜬다.
for JAVA_PID in $JAVA_PIDS
do
  $JAVA_HOME/bin/jstack $JAVA_PID >> ~/jays/${JAVA_PID}.dump
done

# 현재 쓰레드중 많이 쓰이는 것 정보를 담아둔다.
top -n3 -H -b | grep -m2 java >> ./threadInfo.txt

# 프로세스 정보를 담는다.
ps -mo pid,lwp,stime,time,pcpu -C java  >> ~/highUsageThread.txt
echo "done"
