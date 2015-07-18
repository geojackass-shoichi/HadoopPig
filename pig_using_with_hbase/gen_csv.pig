register /usr/lib/zookeeper/zookeeper-[version]-cdh[version].jar
register /usr/lib/hbase/hbase-[version]-cdh[version]-security.jar

raw_data = LOAD 'hbase://{tbl_name}' USING
org.apache.pig.backend.hadoop.hbase.HBaseStorage('fish:aji fish:saba fish:shikoiwashi fish:konoshiro fish:shirogisu', '-loadKey true') as (id, aji, saba, shikoiwashi, konoshiro, shirogisu);

--./Hbaseから取得したデータをアジ・サバ・シコイワシ・コノシロ・シロギスにそれぞれ分解する 
aji = FOREACH raw_data GENERATE id, aji;
saba = FOREACH raw_data GENERATE id, saba;
shikoiwashi = FOREACH raw_data GENERATE id, shikoiwashi;
konoshiro = FOREACH raw_data GENERATE id, konoshiro;
shirogisu = FOREACH raw_data GENERATE id, shirogisu;

--./出力確認用
--DUMP aji;
--DESCRIBE raw_data;


--./各魚種ごとにディレクトリを作成してSTORE
STORE raw_data INTO '{dir}/gyosyu5' USING PigStorage(',');
STORE aji INTO '{dir}/aji' USING PigStorage(',');
STORE shikoiwashi INTO '{dir}/shikoiwashi' USING PigStorage(',');
STORE konoshiro INTO '{dir}/konoshiro' USING PigStorage(',');
STORE saba INTO '{dir}/saba' USING PigStorage(',');
STORE shirogisu INTO '{dir}/shirogisu' USING PigStorage(',');
