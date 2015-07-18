register /usr/lib/zookeeper/zookeeper-[version]-cdh[version].jar
register /usr/lib/hbase/hbase-[version]-cdh[version]-security.jar

raw_data = LOAD 'hbase://{tbl_name}' USING
org.apache.pig.backend.hadoop.hbase.HBaseStorage('fish:aji fish:saba fish:shikoiwashi fish:konoshiro fish:shirogisu', '-loadKey true') as (id, aji, saba, shikoiwashi, konoshiro, shirogisu);

--./Hbase����擾�����f�[�^���A�W�E�T�o�E�V�R�C���V�E�R�m�V���E�V���M�X�ɂ��ꂼ�ꕪ������ 
aji = FOREACH raw_data GENERATE id, aji;
saba = FOREACH raw_data GENERATE id, saba;
shikoiwashi = FOREACH raw_data GENERATE id, shikoiwashi;
konoshiro = FOREACH raw_data GENERATE id, konoshiro;
shirogisu = FOREACH raw_data GENERATE id, shirogisu;

--./�o�͊m�F�p
--DUMP aji;
--DESCRIBE raw_data;


--./�e���킲�ƂɃf�B���N�g�����쐬����STORE
STORE raw_data INTO '{dir}/gyosyu5' USING PigStorage(',');
STORE aji INTO '{dir}/aji' USING PigStorage(',');
STORE shikoiwashi INTO '{dir}/shikoiwashi' USING PigStorage(',');
STORE konoshiro INTO '{dir}/konoshiro' USING PigStorage(',');
STORE saba INTO '{dir}/saba' USING PigStorage(',');
STORE shirogisu INTO '{dir}/shirogisu' USING PigStorage(',');
