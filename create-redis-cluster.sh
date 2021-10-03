# start redis-cluster in default configuration

# create folder for all redis configuration
mkdir cluster-configuration

# create required directories
for port in 7000 7001 7002 7003 7004 7005; do
  mkdir cluster-configuration/$port
done

# create configuration files - for redis servers
for port in 7000 7001 7002 7003 7004 7005; do
  touch cluster-configuration/$port/redis.conf
done

# add configuration to conf files
for port in 7000 7001 7002 7003 7004 7005; do
  echo "port $port
  cluster-enabled yes
  cluster-config-file nodes.conf
  cluster-node-timeout 5000
  appendonly yes" >cluster-configuration/$port/redis.conf
done

# give required permissions to files to be executed
for port in 7000 7001 7002 7003 7004 7005; do
  chmod +x server/run-server-$port.sh
done

# start server
for port in 7000 7001 7002 7003 7004 7005; do
  ./server/run-server-$port.sh &
done

sleep 5

# start redis cluster
redis-cli --cluster create 127.0.0.1:7000 127.0.0.1:7001 127.0.0.1:7002 127.0.0.1:7003 127.0.0.1:7004 127.0.0.1:7005 --cluster-replicas 1