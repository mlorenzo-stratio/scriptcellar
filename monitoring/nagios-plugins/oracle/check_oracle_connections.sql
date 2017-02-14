set pagesize 1
set linesize 300
set lines 300
set heading off
set feedback off
set verify off

select username Usuario_Oracle, count(username) Numero_Sesiones from v$session group by username HAVING count(username) > 0 order by Numero_Sesiones desc;

exit;

