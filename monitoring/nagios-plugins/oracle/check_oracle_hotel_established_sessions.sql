set pagesize 1
set linesize 300
set lines 300
set heading off
set feedback off
set verify off

select count(*) from v$session where username='HOTELPRD';

exit;

