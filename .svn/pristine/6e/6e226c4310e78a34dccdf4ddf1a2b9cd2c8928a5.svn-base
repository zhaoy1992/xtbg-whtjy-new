-- Add/modify columns 
alter table OA_PERSONWORK_PERSONINFO add is_public char(1) constraint CKC_IS_PUBLIC_OA_PERSO check (is_public is null or (is_public in ('1','0')));
-- Add comments to the columns 
comment on column OA_PERSONWORK_PERSONINFO.is_public
  is '是否是公共通讯录';


-- Add/modify columns 
alter table OA_PERSONWORK_GROUP add is_public_group char(1) constraint CKC_IS_PUBLIC_GROUP_OA_PERSO check (is_public_group is null or (is_public_group in ('1','0')));
-- Add comments to the columns 
comment on column OA_PERSONWORK_GROUP.is_public_group
  is '是否是公共组';
