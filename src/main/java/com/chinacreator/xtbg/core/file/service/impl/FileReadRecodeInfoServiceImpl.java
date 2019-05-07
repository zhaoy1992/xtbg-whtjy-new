package com.chinacreator.xtbg.core.file.service.impl;

import java.sql.Connection;
import java.sql.Timestamp;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.chinacreator.security.AccessControl;
import com.chinacreator.xtbg.core.common.cache.UserCache;
import com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.util.DateUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.file.dao.FileReadRecodeInfoDao;
import com.chinacreator.xtbg.core.file.dao.imploracle.FileReadRecodeInfoDaoImpl;
import com.chinacreator.xtbg.core.file.entity.FileReadRecodeInfoBean;
import com.chinacreator.xtbg.core.file.service.FileReadRecodeInfoService;
/**
 * 
 *<p>Title:FileReadRecodeInfoServiceImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Oct 22, 2013
 */
public class FileReadRecodeInfoServiceImpl implements FileReadRecodeInfoService {
	
	private static final Logger LOG = Logger.getLogger(FileReadRecodeInfoServiceImpl.class);
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 insertBean
	 * @param bean
	 * @return 
	 * @see com.chinacreator.xtbg.core.file.service.FileReadRecodeInfoService#insertBean(com.chinacreator.xtbg.core.file.entity.FileReadRecodeInfoBean)
	 */
	@Override
	public Boolean insertBean(HttpServletRequest request,AccessControl ac) {
		Connection con = null;
		try{
			con = DbManager.getInstance().getTransactionConnection();
			FileReadRecodeInfoDao dao = new FileReadRecodeInfoDaoImpl();
			boolean f = checkNeedRecode(request,ac,con,dao);
			if(f){
				Map<String,String> beanMap = dao.getOldRecode(request,ac,con);
				FileReadRecodeInfoBean bean = new FileReadRecodeInfoBean();
				if(beanMap!=null&&beanMap.size()>0){
					String read_count = beanMap.get("read_count");
					
					bean.setF_id(beanMap.get("f_id"));
					bean.setRead_count(StringUtil.nullOrBlank(read_count)?"1":(Integer.parseInt(read_count)+1)+"");
					bean.setF_update_time(new Timestamp(new Date().getTime()));
					((BaseDao)dao).update(bean,con);
				}else{
					String f_user_id = ac.getUserID();
					UserCacheBean usercachebean=UserCache.getUserCacheBean(f_user_id);
			        if(usercachebean!=null){
			        	bean.setF_id(StringUtil.getUUID());
						bean.setF_user_id(f_user_id);
						bean.setF_user_name(ac.getUserName());
						bean.setF_org_id(usercachebean.getUnit_id());
						bean.setF_org_name(usercachebean.getUnit_name());
						bean.setF_dept_id(usercachebean.getOrg_id());
						bean.setF_dept_name(usercachebean.getOrg_name());
						bean.setRecode_type("1");//记录类型:阅读1(当前只有阅读记录)
						bean.setRead_count("1");
						String f_doc_id = StringUtil.deNull(request.getParameter("f_doc_id"));
						bean.setF_doc_id(f_doc_id);
						bean.setF_type_id(request.getParameter("f_type_id"));
						bean.setF_create_time(new Timestamp(new Date().getTime()));
						bean.setF_update_time(bean.getF_create_time());
						bean.setF_date(DateUtil.getFormatDate("yyyyMMdd"));
						((BaseDao)dao).insert(bean,con);
			        }else{
			        	LOG.info("session guoqi");
			        }
				}
			}
			con.commit();
		}catch(Exception e){
			LOG.info("insertBean失败",e);
			DbManager.rollBackNoThrow(con);
		}finally{
			DbManager.closeConnection(con);
		}
		return true;
	}
	
	/**
	 * true 进行阅读次数统计 false  不做阅读统计
	 * @param request
	 * @param ac
	 * @param con
	 * @param dao
	 * @return
	 * @throws Exception
	 */
	public boolean checkNeedRecode(HttpServletRequest request,AccessControl ac, Connection con,FileReadRecodeInfoDao dao) throws Exception{
	    String checktype = request.getParameter("checktype");
	    String isviewStr = StringUtil.deNull(request.getParameter("isview"));
	    //入口是档案查询
	    if(isviewStr!=null&&isviewStr.length()>0){
	    	//检查方式:1:通过是否查询&是否有权限&是否有附件判断;2:通过是否查询判断
	    	if("1".equals(checktype)){
		    	String f_doc_id = StringUtil.deNull(request.getParameter("f_doc_id"));
		        String f_user_id = ac.getUserID();
		       	UserCacheBean usercachebean=UserCache.getUserCacheBean(f_user_id);
		        if(usercachebean!=null){
		        	int attachNum = dao.checkAttachNumOfFileDoc(f_doc_id, con);
		        	if(attachNum==0){//没有附件,当阅读一次
		        		return true;
		        	}else if(attachNum>0){
		        		String hasRole = StringUtil.deNull(request.getParameter("hasRole"));
		        		if("true".equals(hasRole)){
		        			return true;
		        		}
		        	}
		        }
		    }else if("2".equals(checktype)){//照片类
		    	return true;
		    }
	    }
		return false;
	}
}
