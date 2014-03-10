--input data dir
%default PATH_CHOKA_INPUT 'works/input/choka/processed_data2';
%default PATH_CHOKA_OUTPUT 'works/output/choka/processed_data2';

--1./Data loading as CSV format
choka_input = LOAD '$PATH_CHOKA_INPUT' USING PigStorage(',') AS (
ymd		:int,
kinds	:chararray,
vol		:chararray
);

--1.1./SPLIT NULL
SPLIT choka_input INTO
	choka_error IF ymd is null,
	choka_usable IF ymd is not null
;

--2./Sort by ymd
choka_sorted_ymd = ORDER choka_usable BY $0;

--3./Sort by kinds
choka_sorted_kinds = ORDER choka_sorted_ymd BY $1;

--DUMP
DUMP choka_sorted_kinds;

--STORE as a CSV format
STORE choka_sorted_kinds INTO 'works/output/choka/processed_data2' USING PigStorage(',');