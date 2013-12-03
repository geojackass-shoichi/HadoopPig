/*
AS���p���Ē��o��������
Using A AS B
���̏ꍇ�擪2rows��S�Ă͋L�q���Ȃ��B
upLeftLat, upLeftLng, upRightLat ,upRightLng, 
lowLeftLat, lowLeftLng, lowRightLat ,lowRightLng
��GCOM-W1 UserTools�w�莞�ɏ�������B

amsr2_input = LOAD 'works/input/amsr2/csv' USING PigStorage(',') AS (
	lat,
	lng,
	sst
);

DUMP amsr2_input;
STORE amsr2_input INTO 'works/output/amsr2/20120701asc';

*/

amsr2_input = LOAD 'works/input/amsr2/csv';
/*
���L�Ɋւ��Ă͏�L���l�A�L���X�g��
([�ϊ���̌^]) SUBSTRING($0[�J�����̔ԍ�], start[�J�n���_�̕�����ԍ�], end[�I�����̕�����ԍ�]) 
�g����^
int		�����t32bit����
long	�����t64bit����
float	32bit���������_
double	64bit���������_
*/
--1./SUBSTRING�ł̐؂�o�����s��

amsr2_extract = FOREACH amsr2_input GENERATE
(double)	SUBSTRING($0, 0, 7) AS lat,
(double)	SUBSTRING($0, 1+7, 13) AS lng,
(double)	SUBSTRING($0, 1+14, 21) AS sst
;

--2./FILTER�ɂ�钊�o
amsr2_asia = FILTER amsr2_extract BY 90.0 < lat and lat < 180.0;

--3./TODO�@SPLIT error div

--���q��6��./
DUMP amsr2_asia;
