update OA_FILE_FONDSNO set f_fondsno='' where f_fondsno is null;
commit;
alter table OA_FILE_FONDSNO modify f_fondsno not null;