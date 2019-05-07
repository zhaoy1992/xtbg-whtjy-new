package com.chinacreator.xtbg.tjy.device.service.impl;

import com.chinacreator.xtbg.tjy.device.dao.DevSubjectRecordDao;
import com.chinacreator.xtbg.tjy.device.dao.Impl.DevSubjectRecordDaoImpl;
import com.chinacreator.xtbg.tjy.device.entity.DevSubjectRecordBean;
import com.chinacreator.xtbg.tjy.device.service.DevSubjectRecordService;
import com.chinacreator.xtbg.core.common.util.DateUtil;
import com.chinacreator.xtbg.core.common.util.ResultCode;
import com.chinacreator.xtbg.core.common.util.ResultMap;
import com.chinacreator.xtbg.core.common.util.DaoUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;

import java.sql.Connection;
import org.apache.log4j.Logger;
import java.util.List;

/**
 *<p>Title:DevSubjectRecordServiceImpl.java</p>
 *<p>Description:仪器设备标对记录表服务层实现</p>
 *<p>Copyright:Copyright (c) 2014</p>
 *<p>Company:湖南科创</p>
 *@author autoGenerator
 *@version 1.0
 *Fri Apr 04 14:01:03 CST 2014
 */
public class DevSubjectRecordServiceImpl implements DevSubjectRecordService { 
    private static final Logger LOG = Logger.getLogger(DevSubjectRecordServiceImpl.class);
	DevSubjectRecordDao dao = new DevSubjectRecordDaoImpl();
    @Override
    public ResultMap<ResultCode, DevSubjectRecordBean> insert(DevSubjectRecordBean bean) {
        ResultMap<ResultCode, DevSubjectRecordBean> result = new ResultMap<ResultCode, DevSubjectRecordBean>();
        result.setCode(ResultCode.FAIL);
        Connection con = null;
        try {
            con = DbManager.getInstance().getConnection();
            bean.setSub_id(DaoUtil.getUUID());
            bean.setCreator_time(StringUtil.convertStringToTimestamp(DateUtil.getCurrentDate(), "yyyy-MM-dd"));
            dao.insert(bean, con);
            result.setCode(ResultCode.OK);
        } catch (Exception e) {
            LOG.error(e.getMessage(),e);
        } finally {
            DbManager.closeConnection(con);
        }
        return result;
    }
    @Override
    public ResultMap<ResultCode, DevSubjectRecordBean> delete(String ids) {
        ResultMap<ResultCode, DevSubjectRecordBean> result = new ResultMap<ResultCode, DevSubjectRecordBean>();
        result.setCode(ResultCode.FAIL);
	     if(ids == null || "".equals(ids)){
	         result.setCode(ResultCode.MISS_ID);
	     } else {
	         Connection con = null;
	         try {
		         con = DbManager.getInstance().getConnection();
		         dao.delete(ids, con);
		         result.setCode(ResultCode.OK);
	         } catch (Exception e) {
		         LOG.error(e.getMessage(),e);
	         } finally {
		         DbManager.closeConnection(con);
	         }
	    }
       return result;
    }
    @Override
    public ResultMap<ResultCode, DevSubjectRecordBean> update(DevSubjectRecordBean bean) {
        ResultMap<ResultCode, DevSubjectRecordBean> result = new ResultMap<ResultCode, DevSubjectRecordBean>();
        result.setCode(ResultCode.FAIL);
        Connection con = null;
        try {
            con = DbManager.getInstance().getConnection();
            dao.update(bean, con);
            result.setCode(ResultCode.OK);
        } catch (Exception e) {
            LOG.error(e.getMessage(),e);
	     } finally {
            DbManager.closeConnection(con);
        }
        return result;
    }
    @Override
    public ResultMap<ResultCode, DevSubjectRecordBean> getById(DevSubjectRecordBean bean) {
        ResultMap<ResultCode, DevSubjectRecordBean> result = new ResultMap<ResultCode, DevSubjectRecordBean>();
        result.setCode(ResultCode.FAIL);
        Connection con = null;
        try {
            con = DbManager.getInstance().getConnection();
            DevSubjectRecordBean b = dao.getById(bean, con);
            if(b != null) {
                result.setCode(ResultCode.OK);
                result.setResult(b);
            } else {
                result.setCode(ResultCode.UNEXIST);
            }
        } catch (Exception e) {
            LOG.error(e.getMessage(),e);
        } finally {
            DbManager.closeConnection(con);
        }
        return result;
    }
    @Override
    public ResultMap<ResultCode, List<DevSubjectRecordBean>> list (DevSubjectRecordBean bean) {
        ResultMap<ResultCode, List<DevSubjectRecordBean>> result = new ResultMap<ResultCode, List<DevSubjectRecordBean>>();
        result.setCode(ResultCode.FAIL);
        Connection con = null;
        try {
            con = DbManager.getInstance().getConnection();
            List<DevSubjectRecordBean> list = dao.list(bean, con);
            if(list != null && list.size() > 0) {
                result.setCode(ResultCode.OK);
                result.setResult(list);
            } else {
                result.setCode(ResultCode.UNEXIST);
            }
        } catch (Exception e) {
            LOG.error(e.getMessage(),e);
        } finally {
            DbManager.closeConnection(con);
        }
        return result;
    }
}