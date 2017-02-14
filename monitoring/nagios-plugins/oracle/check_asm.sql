set pagesize 0
set heading off
set feedback off
set verify off

select name, group_number, disk_number, total_mb, free_mb
from v$asm_disk
where name='&1';

exit;

