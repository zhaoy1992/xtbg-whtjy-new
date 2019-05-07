package com.chinacreator.xtbg.tjy.device.list;

import com.chinacreator.xtbg.tjy.device.dao.DevSubjectRecordDao;
import com.chinacreator.xtbg.tjy.device.dao.Impl.DevSubjectRecordDaoImpl;
import com.chinacreator.xtbg.tjy.device.entity.DevSubjectRecordBean;
import java.sql.Connection;
import org.apache.log4j.Logger;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;

/**
 *<p>Title:DevSubjectRecordList.java</p>
 *<p>Description:仪器设备标对记录表List</p>
 *<p>Copyright:Copyright (c) 2014</p>
 *<p>Company:湖南科创</p>
 *@author AutoGenerator
 *@version 1.0
 *Fri Apr 04 14:01:03 CST 2014
 */
public class DevSubjectRecordList extends DataInfoImpl { 
   private static final Logger LOG = Logger.getLogger(DevSubjectRecordBean.class);
	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		DevSubjectRecordBean bean = new DevSubjectRecordBean();
		PagingBean pb = null;
		bean =  StringUtil.convertStringToBean(parmjson, DevSubjectRecordBean.class);
		DevSubjectRecordDao dao = new DevSubjectRecordDaoImpl();
		Connection con = null;
		try {
			con = DbManager.getInstance().getConnection();
			pb = dao.list(bean, sortName, sortOrder, offset, maxPagesize, con);
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
		} finally {
			DbManager.closeConnection(con);
		}
		return pb;
	}

	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder) {
		return null;
	}
}