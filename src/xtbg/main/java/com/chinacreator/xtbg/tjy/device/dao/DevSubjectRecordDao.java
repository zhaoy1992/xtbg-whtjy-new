package com.chinacreator.xtbg.tjy.device.dao;

import java.sql.Connection;
import com.chinacreator.xtbg.tjy.device.entity.DevSubjectRecordBean;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import java.util.List;

/**
 *<p>Title:DevSubjectRecordDao.java</p>
 *<p>Description:仪器设备标对记录表Dao</p>
 *<p>Copyright:Copyright (c) 2014</p>
 *<p>Company:湖南科创</p>
 *@author AutoGenerator
 *@version 1.0
 *Fri Apr 04 14:01:03 CST 2014
 */
public interface DevSubjectRecordDao { 
    /**
     * <p>保存数据</p>
     */
    public void insert(DevSubjectRecordBean bean,Connection con) throws Exception;
    /**
    * <p>根据id获取数据</p>
    */
    public DevSubjectRecordBean getById(DevSubjectRecordBean bean,Connection con) throws Exception;
    /**
     * <p>更新数据</p>
     */
    public void update(DevSubjectRecordBean bean,Connection con) throws Exception;
    /**
     * <p>分页查询列表数据</p>
     */
    public PagingBean list(DevSubjectRecordBean bean, String sortname, String sortOrder, long offset, int maxPagesize,Connection con)throws Exception;
    /**
     * <p>查询列表数据</p>
     */
    public List<DevSubjectRecordBean> list (DevSubjectRecordBean bean,Connection con) throws Exception;
    /**
     * <p>根据id删除数据</p>
     */
    public void delete(String ids,Connection con) throws Exception;
}