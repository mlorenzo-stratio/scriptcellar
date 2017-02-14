set pagesize 0
set heading off
set feedback off

select a.TABLESPACE_NAME,round(((a.BYTES-b.BYTES)/a.BYTES)*100,2) percent_used
        from
        (
        select TABLESPACE_NAME,
        sum(BYTES) BYTES
        from dba_data_files
        group by TABLESPACE_NAME
        )
        a,
        (
        select TABLESPACE_NAME,
        sum(BYTES) BYTES ,
        max(BYTES) largest
        from dba_free_space
        group by TABLESPACE_NAME
        )
        b
        where a.TABLESPACE_NAME=b.TABLESPACE_NAME
        order by ((a.BYTES-b.BYTES)/a.BYTES) desc
        ;

exit;

