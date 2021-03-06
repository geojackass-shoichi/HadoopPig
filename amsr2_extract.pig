/*
AS句を用いて抽出処理する
Using A AS B
この場合先頭2rowsを全ては記述しない。
upLeftLat, upLeftLng, upRightLat ,upRightLng, 
lowLeftLat, lowLeftLng, lowRightLat ,lowRightLng
はGCOM-W1 UserTools指定時に準拠する。

amsr2_input = LOAD 'works/input/amsr2/csv' USING PigStorage(',') AS (
	lat,
	lng,
	sst
);

DUMP amsr2_input;
STORE amsr2_input INTO 'works/output/amsr2/20120701asc';

*/
--0./DataのLOADを行う。今回は紐付けを行わなくていいように、フルpthを記述
amsr2_input = LOAD 'works/input/amsr2/csv';
/*
注記に関しては上記同様、キャストは
([変換後の型]) SUBSTRING($0[カラムの番号], start[開始時点の文字列番号], end[終了時の文字列番号]) 
使える型
int	符号付32bit整数
long		符号付64bit整数
float		32bit浮動小数点
double		64bit浮動小数点
*/
--1./SUBSTRINGでの切り出しを行う

amsr2_extract = FOREACH amsr2_input GENERATE
(double)	SUBSTRING($0, 0, 7) AS lat,
(double)	SUBSTRING($0, 1+7, 13) AS lng,
(double)	SUBSTRING($0, 1+14, 21) AS sst
;

--2./SPLITによるエラー処理を行う sst == -9999.0は正常データから除去する。
SPLIT amsr2_extract INTO
	amsr2_error IF sst == -9999.0,
	amsr2_target IF sst > 0
	;

--3./FILTERによる抽出 ref::https://github.com/chomy/hi-rezclimate/blob/master/trmm/trmmkml.py
--asia_areaを抽出するasia = (x1y0,x1y1)
amsr2_asia = FILTER amsr2_target BY 90.0 < lat and lat < 180.0 and 0.0 < lng and lng < 60.0;

--4./STORE

STORE amsr2_asia INTO 'works/output/amsr2/20120701asc';


--黒子の6番./
DUMP amsr2_asia;