package com.chinacreator.xtbg.core.archive.service.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.archive.dao.CircularizeDao;
import com.chinacreator.xtbg.core.archive.entity.CircularizeBean;
import com.chinacreator.xtbg.core.archive.service.DispenseService;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
/**
 * 
 *<p>Title:DispenseServiceImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-8-21
 */
public class DispenseServiceImpl implements DispenseService{
	private static final Logger LOG = Logger.getLogger(DispenseServiceImpl.class);
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 dispense
	  * @param busiId
	  * @param sendUserid
	  * @param receiveUserid
	  * @param title
	  * @param actionFrom
	  * @param insId
	  * @param end_type
	  * @return 
	  * @see com.chinacreator.xtbg.pub.dispense.service.DispenseService#dispense(java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String)
	 */
	@Override
	public boolean dispense(String busiId, String sendUserid,
			String receiveUserid, String title, String actionForm, String insId,String busiTypeCode,String template_id) {
		boolean flag = true;
		//String userArea=CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");
		//String end_is_dispense =  CacheCommonManageProxy.getSystemParam("end_is_dispense");
		
		CircularizeDao dao = (CircularizeDao)LoadSpringContext.getApplicationContext().getBean("circularizeDaoImpl");
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			String[] userid = null;
			if(!"".equals(receiveUserid) && null != receiveUserid){
							userid = StringUtil.splitStr(receiveUserid);
							List<CircularizeBean> circularizeBeanList = new ArrayList<CircularizeBean>(); 
							for(int i =0 ; i < userid.length ; i++){
								CircularizeBean bean = setlarizeBean(busiId,sendUserid,receiveUserid,title,actionForm,insId,busiTypeCode,template_id);
								bean.setReceive_userid(userid[i]);
								circularizeBeanList.add(bean);
							}
							flag = flag&&dao.savaCircularize(circularizeBeanList,  conn);
			}
			if(flag){
				conn.commit();
			}else{
				conn.rollback();
			}
		} catch (Exception e) {
			flag = false;
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(),e);
		}finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		return flag;
	}
	/**
	 * 
	*<b>Summary: </b>
	* setlarizeBean(把分发需要的数据从流程中拿出来后封装成bean)
	* @param busiId
	* @param sendUserid
	* @param receiveUserid
	* @param title
	* @param actionFrom
	* @param insId
	* @return
	 */
	public CircularizeBean setlarizeBean(String busiId, String sendUserid,
			String receiveUserid, String title, String actionFrom, String insId,String busiTypeCode,String template_id){
		CircularizeBean bean = new CircularizeBean();
		bean.setBusi_id(busiId);
		bean.setSend_userid(sendUserid);
		bean.setReceive_userid(receiveUserid);
		bean.setCircularize_title(title);
		bean.setAction_form(actionFrom);
		bean.setIns_id(insId);
		bean.setBusitype_code(busiTypeCode);
		bean.setTemplate_id(template_id);
		return bean;
	}

}
