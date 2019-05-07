package com.chinacreator.xtbg.tjy.device.service;

import com.chinacreator.xtbg.tjy.device.entity.DevSubjectRecordBean;
import com.chinacreator.xtbg.core.common.util.ResultCode;
import com.chinacreator.xtbg.core.common.util.ResultMap;
import java.util.List;

/**
 *<p>Title:DevSubjectRecordService.java</p>
 *<p>Description:仪器设备标对记录表服务层</p>
 *<p>Copyright:Copyright (c) 2014</p>
 *<p>Company:湖南科创</p>
 *@author AutoGenerator
 *@version 1.0
 *Fri Apr 04 14:01:03 CST 2014
 */
public interface DevSubjectRecordService { 
    /**
     * <p>保存数据</p>
     */
    public ResultMap<ResultCode, DevSubjectRecordBean> insert(DevSubjectRecordBean bean);
    /**
     * <p>根据id删除数据</p>
     */
    public ResultMap<ResultCode, DevSubjectRecordBean> delete(String ids);
    /**
     * <p>更新数据</p>
     */
    public ResultMap<ResultCode, DevSubjectRecordBean> update(DevSubjectRecordBean bean);
    /**
    * <p>根据id获取数据</p>
    */
    public ResultMap<ResultCode, DevSubjectRecordBean> getById(DevSubjectRecordBean bean);
    /**
     * <p>查询列表数据</p>
     */
    public ResultMap<ResultCode, List<DevSubjectRecordBean>> list (DevSubjectRecordBean bean);
}