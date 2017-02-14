set pagesize 1
set heading off
set feedback off
set verify off

select (tablespace_size)*8192/1024/1024 as TOTAL,(used_space)*8192/1024/1024 as USED,((tablespace_size - used_space)*8192/1024/1024) as FREE from  DBA_TABLESPACE_USAGE_METRICS where tablespace_name='&1';

exit;
