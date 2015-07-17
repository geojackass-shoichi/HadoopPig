register /usr/lib/zookeeper/zookeeper-[version]-cdh[version].jar
register /usr/lib/hbase/hbase-[version]-cdh[version]-security.jar

raw_data = LOAD 'hbase://{tbl_name}' USING
org.apache.pig.backend.hadoop.hbase.HBaseStorage('col:hoge', '-loadKey true') as (id, hoge);

STORE raw_data INTO '{dir pth}' USING PigStorage(',');
