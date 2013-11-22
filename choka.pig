--入出力先の指定
%default PATH_CHOKA_INPUT 'works/input/choka/h2012_01';
--%default PATH_CHOKA_OUTPUT 'works/output/choka/h2012_01';

--1./DATA loading
choka_input = LOAD '$PATH_CHOKA_INPUT' USING TextLoader();

--2./Tokenize into a word
choka_token = FOREACH choka_input GENERATE FLATTEN(TOKENIZE($0));

--3./grouping by choka_token
choka_group = GROUP choka_token BY $0;

--4./count each group
choka_count = FOREACH choka_group GENERATE $0, COUNT($1);

--5./sorted by desc
choka_desc = ORDER choka_count BY $1 DESC;

--DUMP
--DUMP choka_input;

--STORE
--STORE choka_desc INTO 'PATH_CHOKA_OUTPUT';
STORE choka_desc INTO 'works/output/choka/h2012_01/';