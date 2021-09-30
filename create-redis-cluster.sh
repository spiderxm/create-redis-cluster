mkdir cluster-configuration
mkdir cluster-configuration/7000
mkdir cluster-configuration/7001
mkdir cluster-configuration/7002
mkdir cluster-configuration/7003
mkdir cluster-configuration/7004
mkdir cluster-configuration/7005

touch cluster-configuration/7000/redis.conf
touch cluster-configuration/7001/redis.conf
touch cluster-configuration/7002/redis.conf
touch cluster-configuration/7003/redis.conf
touch cluster-configuration/7004/redis.conf
touch cluster-configuration/7005/redis.conf

echo "port 7000
cluster-enabled yes
cluster-config-file nodes.conf
cluster-node-timeout 5000
appendonly yes" > cluster-configuration/7000/redis.conf

echo "port 7001
cluster-enabled yes
cluster-config-file nodes.conf
cluster-node-timeout 5000
appendonly yes" > cluster-configuration/7001/redis.conf

echo "port 7002
cluster-enabled yes
cluster-config-file nodes.conf
cluster-node-timeout 5000
appendonly yes" > cluster-configuration/7002/redis.conf

echo "port 7003
cluster-enabled yes
cluster-config-file nodes.conf
cluster-node-timeout 5000
appendonly yes" > cluster-configuration/7003/redis.conf

echo "port 7004
cluster-enabled yes
cluster-config-file nodes.conf
cluster-node-timeout 5000
appendonly yes" > cluster-configuration/7004/redis.conf

echo "port 7005
cluster-enabled yes
cluster-config-file nodes.conf
cluster-node-timeout 5000
appendonly yes" > cluster-configuration/7005/redis.conf

chmod +x server/run-server-7000.sh
chmod +x server/run-server-7001.sh
chmod +x server/run-server-7002.sh
chmod +x server/run-server-7003.sh
chmod +x server/run-server-7004.sh
chmod +x server/run-server-7005.sh
./server/run-server-7000.sh &
./server/run-server-7001.sh &
./server/run-server-7002.sh &
./server/run-server-7003.sh &
./server/run-server-7004.sh &
./server/run-server-7005.sh &


sleep 5

redis-cli --cluster create 127.0.0.1:7000 127.0.0.1:7001 127.0.0.1:7002 127.0.0.1:7003 127.0.0.1:7004 127.0.0.1:7005 --cluster-replicas 1

