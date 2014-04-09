
touch /opt/cloudezz-config/leave_output.txt

echo ${SERF_TAG_IS_SERVICE} >> leave_output.txt

echo "Member Joining to LB" >> leave_output.txt

rm /tmp/listen.cfg
echo "Python Execution Begin" >> leave_output.txt

exec python serf_haproxy.py > /dev/null 2>&1 &

wait %2

echo "Python Execution End" >> leave_output.txt