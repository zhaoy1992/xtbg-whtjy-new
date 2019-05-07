
/*==============================================================*/
/* Table: TA_OA_officeaccount                                   */
/*==============================================================*/
create table TA_OA_officeaccount 
(
   id                   varchar2(40)         not null,
   code                 varchar2(200),
   name                 varchar2(200),
   type                 varchar2(200),
   money                number,
   Receive_Day          DATE,
   Receive_username     varchar2(200),
   blame_username       varchar2(200),
   Deposit_place        varchar2(500),
   assetsUse            varchar2(500),
   Wastedisposal        varchar2(500),
   Remarks              varchar2(500),
   org_id               varchar2(50),
   org_name             varchar2(100),
   UNIT_id              varchar2(50),
   UNIT_NAME            varchar2(100),
   constraint PK_TA_OA_OFFICEACCOUNT primary key (id)
);

comment on column TA_OA_officeaccount.id is
'主键ID';

comment on column TA_OA_officeaccount.code is
'标识卡编号';

comment on column TA_OA_officeaccount.name is
'名称';

comment on column TA_OA_officeaccount.type is
'规格\型号';

comment on column TA_OA_officeaccount.money is
'金额';

comment on column TA_OA_officeaccount.Receive_Day is
'领取时间';

comment on column TA_OA_officeaccount.Receive_username is
'领用人';

comment on column TA_OA_officeaccount.blame_username is
'责任人';

comment on column TA_OA_officeaccount.Deposit_place is
'存放位置';

comment on column TA_OA_officeaccount.assetsUse is
'资产用途';

comment on column TA_OA_officeaccount.Wastedisposal is
'报废处置情况';

comment on column TA_OA_officeaccount.Remarks is
'备注';

comment on column TA_OA_officeaccount.org_id is
'机构ID';

comment on column TA_OA_officeaccount.org_name is
'机构名称';

comment on column TA_OA_officeaccount.UNIT_id is
'单位ID';

comment on column TA_OA_officeaccount.UNIT_NAME is
'单位名称';
