set pagesize 0
set heading off
set feedback off

select count (*) from v$session where status like 'ACTIVE';

exit;
