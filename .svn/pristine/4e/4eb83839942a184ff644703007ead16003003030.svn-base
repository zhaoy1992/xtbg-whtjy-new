package com.chinacreator.xtbg.core.archive.gwcs.dao.impl;

import java.sql.Connection;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.security.AccessControl;
import com.chinacreator.xtbg.core.archive.entity.OfficialDocumentRegisterHandleBean;
import com.chinacreator.xtbg.core.archive.gwcs.dao.ReceiveGwDAO;
import com.chinacreator.xtbg.core.archive.service.ArchiveExtService;
import com.chinacreator.xtbg.core.common.cache.UserCache;
import com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * 
 *<p>Title:ReceiveGwWithFlowDaoImpl.java</p>
 *<p>Description:来文接收对流程的接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-12-14
 */
public class ReceiveGwWithFlowDaoImpl implements ArchiveExtService{
	private static final Log LOG = LogFactory.getLog(ReceiveGwWithFlowDaoImpl.class);
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 doExtFlow
	  * @param request
	  * @param flowData
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.service.ArchiveExtService#doExtFlow(javax.servlet.http.HttpServletRequest, java.util.Map, java.sql.Connection)
	 */
	public boolean doExtFlow(HttpServletRequest request,
			Map<String, String> flowData, Connection conn) throws Exception {
		
		AccessControl accesscontroler = AccessControl.getAccessControl();
		//control.checkAccess(request, response);
		String user_id  = accesscontroler.getUserID();
		UserCacheBean userBean = UserCache.getUserCacheBean(user_id);
		String org_id = userBean.getOrg_id();
		
		
		//先判断流水号是否存在
		String t_id=StringUtil.deNull(request.getParameter("busi_id"));
		String action_id = StringUtil.deNull(flowData.get("action_id"));//流程环节ID
		String ins_id = StringUtil.deNull(flowData.get("ins_id"));//流程环节ID
		ReceiveGwDAO dao = (ReceiveGwDAO)LoadSpringContext.getApplicationContext().getBean("receiveDaoImpl");
		String actionDef = dao.getActDefByActId(action_id,conn);
		if("szfbgtlwdj_wp1_act1".equals(actionDef)){//第一个环节
			String receiveID=StringUtil.deNull(request.getParameter(OfficialDocumentRegisterHandleBean.OFF_DOC_REG_ID));
			String is_accept="1";
			if(!StringUtil.isBlank(receiveID)){
				dao.updateGwReceivezd(is_accept, receiveID, conn);
				//2.更新表T_LWGL的一些数据
				updateLWGL(ins_id, receiveID,t_id ,conn);
			}
		}else if("szfbgtlwdj_wp1_act3".equals(actionDef)){//如果是业务处室环节，将机构ID更新到来文登记表
			String receiveID = dao.queryGwReceiveID(ins_id, conn);
			dao.updateGwReceivezdOrgId(org_id, receiveID, conn);
		}
		return true;
	}
	/**
	 * 
	*<b>Summary: </b>
	* updateLWGL(更新表T_LWGL的相关字段)
	 */
	public void updateLWGL(String ins_id,String id,String t_id,Connection conn)throws Exception{
		/*String sqlselect="select max(t_lsh) t_lsh from T_LWGL";
		PreparedDBUtil pdb=new PreparedDBUtil();
		pdb.preparedSelect(sqlselect);
		pdb.executePrepared();
		int t_lsh=0;
		if(pdb.size()>0){
			t_lsh=pdb.getInt(0, "t_lsh")+1;
		}*/
		
		//String sqlupdate="update t_lwgl set t_lsh=?,t_gwreceive_id=?,t_ins_id=? where  t_id=? ";
		//MODIFY BY shuqi.liu 2013-12-16 更新来文表，现在不需要更新流水号
		String sqlupdate="update t_lwgl set t_gwreceive_id=?,t_ins_id=? where  t_id=? ";
		PreparedDBUtil pdb=new PreparedDBUtil();
		pdb.preparedUpdate(sqlupdate);
		int i=1;
		pdb.setString(i++, id);
		pdb.setString(i++, ins_id);
		pdb.setString(i++, t_id);
		pdb.executePrepared(conn);
		
	}
	/**
	 * 
	*<b>Summary: </b>
	* isLsh(判断来文处理情况的流水号是否已存在)
	* @return
	* @throws Exception
	 */
	public boolean isLsh(String t_id)throws Exception{
		boolean flag=false;
		String sql="select t_lsh from t_lwgl where t_id=? ";
		PreparedDBUtil pdb=new PreparedDBUtil();
		pdb.preparedSelect(sql);
		pdb.setString(1, t_id);
		pdb.executePrepared();
		if(pdb.size()>0){
			flag=true;
		}
		return  flag;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* setGwreceiveOrgId(将OA_ORG_ID回填)
	* @param gwreceive_id
	* @param ins_id
	* @return
	 */
	public boolean setGwreceiveOrgId(String gwreceive_id, String ins_id,String org_id){
		ReceiveGwDAO dao = (ReceiveGwDAO)LoadSpringContext.getApplicationContext().getBean("receiveDaoImpl");
		try {
			if(StringUtil.isBlank(gwreceive_id)){//如果收文表ID为空，那么要根据流程实例ID查询gwreceive_id
				gwreceive_id = dao.queryGwReceiveID(ins_id, null);
			}
			dao.UpdateGwReceiveOrgID(gwreceive_id, org_id, null);
		} catch (Exception e) {
			LOG.error("更新收文表ORG_ID出错",e);
		}
		return true;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* queryGwreceiveOrgId(查询OA_ORG_ID，根据ins_id，gwreceive_id)
	* @param gwreceive_id
	* @param ins_id
	* @param org_id
	* @return
	 */
	public String queryGwreceiveOrgId(String gwreceive_id, String ins_id){
		String oa_org_id = "";
		ReceiveGwDAO dao = (ReceiveGwDAO)LoadSpringContext.getApplicationContext().getBean("receiveDaoImpl");
		try {
			if(StringUtil.isBlank(gwreceive_id)){//如果收文表ID为空，那么要根据流程实例ID查询gwreceive_id
				gwreceive_id = dao.queryGwReceiveID(ins_id, null);
			}
			Map<String,String> dataMap = dao.findReceiveGw(gwreceive_id, null);
			if(dataMap!=null){
				if(!"".equals(dataMap.get("oa_org_id"))){
					oa_org_id = dataMap.get("oa_org_id");
				}
			}
		}catch (Exception e) {
			LOG.error("获取收文表ORG_ID出错",e);
		}
		return oa_org_id;
	}

}
