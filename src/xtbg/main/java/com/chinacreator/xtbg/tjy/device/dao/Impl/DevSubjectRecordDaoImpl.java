package com.chinacreator.xtbg.tjy.device.dao.Impl;

import com.chinacreator.xtbg.tjy.device.dao.DevSubjectRecordDao;
import com.chinacreator.xtbg.tjy.device.entity.DevSubjectRecordBean;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.util.SqlUtil;
import java.sql.Connection;
import java.util.List;

/**
 *<p>Title:DevSubjectRecordDaoImpl.java</p>
 *<p>Description:仪器设备标对记录表DaoImpl</p>
 *<p>Copyright:Copyright (c) 2014</p>
 *<p>Company:湖南科创</p>
 *@author AutoGenerator
 *@version 1.0
 *Fri Apr 04 14:01:03 CST 2014
 */
public class DevSubjectRecordDaoImpl implements DevSubjectRecordDao { 
    @Override
    public void insert(DevSubjectRecordBean bean,Connection con) throws Exception {
        StringBuffer sql = new StringBuffer();
        sql.append("insert into ta_oa_devsubjectrecord(");
        sql.append(" sub_id,");
        sql.append(" t_sb_id,");
        sql.append(" sub_name,");
        sql.append(" sub_result,");
        sql.append(" creator_time,");
        sql.append(" remark");
        sql.append(") values ");
        sql.append(" ( ?,?,?,?,?,?)" );
        SqlUtil<DevSubjectRecordBean> sqlUtil = new SqlUtil<DevSubjectRecordBean>();
        sqlUtil.executeInsert(sql.toString(), bean, con);
    }
    @Override
    public DevSubjectRecordBean getById(DevSubjectRecordBean bean,Connection con) throws Exception {
        StringBuffer sql = new StringBuffer();
        sql.append("select ");
        sql.append(" sub_id,");
        sql.append(" t_sb_id,");
        sql.append(" info.dev_code as dev_code,");
        sql.append(" info.dev_name as dev_name,");
        sql.append(" sub_name,");
        sql.append(" sub_result,");
        sql.append(" recode.remark as remark ");
        sql.append(" from ta_oa_devsubjectrecord recode ,");
        sql.append("  ta_oa_devaccount info");
        sql.append(" where  recode.t_sb_id = info.id ");
        sql.append("  and sub_id = ? ");
        SqlUtil<DevSubjectRecordBean> sqlUtil = new SqlUtil<DevSubjectRecordBean>();
        DevSubjectRecordBean b = sqlUtil.executeForObject(sql.toString(), bean , con);
        return b;
    }
    @Override
    public void update(DevSubjectRecordBean bean,Connection con) throws Exception {
        StringBuffer sql = new StringBuffer();
        sql.append("update ta_oa_devsubjectrecord set ");
        sql.append(" sub_id = ? ,");
        sql.append(" t_sb_id = ? ,");
        sql.append(" sub_name = ? ,");
        sql.append(" sub_result = ? ,");
        sql.append(" remark = ?, ");
        sql.append(" creator_time = sysdate ");
        sql.append(" where sub_id = ? ");
        SqlUtil<DevSubjectRecordBean> sqlUtil = new SqlUtil<DevSubjectRecordBean>();
        sqlUtil.executeUpdate(sql.toString(), bean, con);
    }
    @Override
    public PagingBean list(DevSubjectRecordBean bean, String sortname, String sortOrder, long offset, int maxPagesize,Connection con)throws Exception {
        StringBuffer sql = new StringBuffer();
        sql.append("select ");
        sql.append(" sub_id,");
        sql.append(" t_sb_id,");
        sql.append(" to_char(creator_time,'yyyy-mm-dd') as creator_time,");
        sql.append(" info.dev_code as dev_code ,");
        sql.append(" info.dev_name as dev_name ,");
        sql.append(" sub_name,");
        sql.append(" sub_result,");
        sql.append(" recode.remark as remark ");
        sql.append(" from ta_oa_devsubjectrecord recode,");
        sql.append("      ta_oa_devaccount info ");
        sql.append("  where recode.t_sb_id = info.id ");
        SqlUtil<DevSubjectRecordBean> sqlUtil = new SqlUtil<DevSubjectRecordBean>();
        PagingBean pb = sqlUtil.executeForListWithPage(sql.toString(), bean, sortname, sortOrder, offset, maxPagesize, con);
        return pb;
    }
    @Override
    public List<DevSubjectRecordBean> list (DevSubjectRecordBean bean,Connection con) throws Exception {
        StringBuffer sql = new StringBuffer();
        sql.append("select ");
        sql.append(" sub_id,");
        sql.append(" t_sb_id,");
        sql.append(" sub_name,");
        sql.append(" sub_result,");
        sql.append(" remark");
        sql.append(" from ta_oa_devsubjectrecord");
        SqlUtil<DevSubjectRecordBean> sqlUtil = new SqlUtil<DevSubjectRecordBean>();
        List<DevSubjectRecordBean> list = sqlUtil.executeForList(sql.toString(), bean, con);
        return list;
    }
    @Override
    public void delete(String ids,Connection con) throws Exception {
        StringBuffer sql = new StringBuffer();
        sql.append("delete ta_oa_devsubjectrecord where sub_id in ("+ ids +")");
        SqlUtil<DevSubjectRecordBean> sqlUtil = new SqlUtil<DevSubjectRecordBean>();
        sqlUtil.executeDelete(sql.toString(), new DevSubjectRecordBean(), con);
    }
}