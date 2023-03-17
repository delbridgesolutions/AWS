#!/bin/bash
echo "Applying Prod Notes"

echo "NUMA"
sudo grep -q 'vm.zone_reclaim_mode' /etc/sysctl.conf || echo "vm.zone_reclaim_mode=0" | sudo tee --append /etc/sysctl.conf
sudo grep   "vm.zone_reclaim_mode=0" /etc/sysctl.conf || echo "Incorrect value for Zone Reclaim Mode"

echo "Swap"
sudo grep -q 'vm.swappiness' /etc/sysctl.conf || echo "vm.swappiness=1" | sudo tee --append /etc/sysctl.conf
sudo grep "vm.swappiness=1" /etc/sysctl.conf || echo "Incorrect value for VM Swappiness"


echo "ulimits"

for limit in fsize cpu as memlock
do
  grep "mongodb" /etc/security/limits.conf | grep -q $limit || echo -e "mongod     hard   $limit    unlimited\nmongod     soft    $limit   unlimited" | sudo tee --append /etc/security/limits.conf
done

for limit in nofile noproc
do
  grep "mongodb" /etc/security/limits.conf | grep -q $limit || echo -e "mongod     hard   $limit    64000\nmongod     soft    $limit   64000" | sudo tee --append /etc/security/limits.conf
done

echo "THP"

SCRIPT=$(cat << 'ENDSCRIPT'
#!/bin/bash
### BEGIN INIT INFO
# Provides:          disable-transparent-hugepages
# Required-Start:    $local_fs
# Required-Stop:
# X-Start-Before:    mongod mongodb-mms-automation-agent
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Disable Linux transparent huge pages
# Description:       Disable Linux transparent huge pages, to improve
#                    database performance.
### END INIT INFO

case $1 in
  start)
    if [ -d /sys/kernel/mm/transparent_hugepage ]; then
      thp_path=/sys/kernel/mm/transparent_hugepage
    elif [ -d /sys/kernel/mm/redhat_transparent_hugepage ]; then
      thp_path=/sys/kernel/mm/redhat_transparent_hugepage
    else
      return 0
    fi

    echo 'never' > ${thp_path}/enabled
    echo 'never' > ${thp_path}/defrag

    re='^[0-1]+$'
    if [[ $(cat ${thp_path}/khugepaged/defrag) =~ $re ]]
    then
      # RHEL 7
      echo 0  > ${thp_path}/khugepaged/defrag
    else
      # RHEL 6
      echo 'no' > ${thp_path}/khugepaged/defrag
    fi

    unset re
    unset thp_path
    ;;
esac
ENDSCRIPT
)

echo "$SCRIPT" | sudo tee /etc/init.d/disable-transparent-hugepages

sudo chmod 755 /etc/init.d/disable-transparent-hugepages

sudo chkconfig --add disable-transparent-hugepages

echo "$SCRIPT" | sudo tee /etc/init.d/disable-transparent-hugepages
sudo chmod 755 /etc/init.d/disable-transparent-hugepages
sudo chkconfig --add disable-transparent-hugepages
