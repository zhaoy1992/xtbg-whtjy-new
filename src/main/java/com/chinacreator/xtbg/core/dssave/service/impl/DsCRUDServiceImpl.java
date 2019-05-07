package com.chinacreator.xtbg.core.dssave.service.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.core.archive.entity.FlowDocmentFileBean;
import com.chinacreator.xtbg.core.common.commonlist.Constant;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.dssave.dao.DsCRUDDao;
import com.chinacreator.xtbg.core.dssave.dao.impl.DsCRUDDaoImpl;
import com.chinacreator.xtbg.core.dssave.entity.ViewListBean;
import com.chinacreator.xtbg.core.dssave.service.DsCRUDService;


/**
 * 
 *<p>Title:DsCRUDServiceImpl.java</p>
 *<p>Description:通用保存Service实现类</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-4-22
 */
public class DsCRUDServiceImpl implements DsCRUDService {
	
	/**
	 * 
	  * <b>Summary: </b>
	  * saveArchive(通用保存方法)
	  * @param request
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.dssave.service.DsCRUDService#dsSave(javax.servlet.http.HttpServletRequest, java.sql.Connection)
	 */
	@Override
	public boolean dsSave(HttpServletRequest request,Connection conn) throws Exception {
		DsCRUDDao dao = new DsCRUDDaoImpl();
	     //获取业务封装数据
		 List<Map<String,List<Map<String, String>>>> datalist = dao.getDateList(request);
		//获取日期格式
		 String[] datefmtlist = request.getParameterValues("datelist");		 
		 Map<String,String> dateFmtList = new HashMap<String,String>();
		 if(datefmtlist!=null && datefmtlist.length>0){
			 for(String dateFmtStr:datefmtlist){
				 dateFmtStr =DataControlUtil.replaceStr(dateFmtStr);
				 dateFmtStr = Escape.unescape(dateFmtStr);
				 String[] dateRule = dateFmtStr.split(",");
				 dateFmtList.put(dateRule[0], dateRule[1]);
			 }
		 }
		 //保存业务数据
		return dao.save(datalist,dateFmtList, conn);
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *	update(通用更新方法)
	  * @param request
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.dssave.service.DsCRUDService#dsUpdate(javax.servlet.http.HttpServletRequest, java.sql.Connection)
	 */
	@Override
	public boolean dsUpdate(HttpServletRequest request,Connection conn)throws Exception  {
		DsCRUDDao dao = new DsCRUDDaoImpl();
	    //获取业务封装数据
	    List<Map<String,List<Map<String, String>>>> datalist = dao.getDateList(request);
	    //获取日期格式
		 String[] datefmtlist = request.getParameterValues("datelist");
		 Map<String,String> dateFmtList = new HashMap<String,String>();
		 if(datefmtlist!=null && datefmtlist.length>0){
			 for(String dateFmtStr:datefmtlist){
				 dateFmtStr =DataControlUtil.replaceStr(dateFmtStr);
				 dateFmtStr = Escape.unescape(dateFmtStr);
				 String[] dateRule = dateFmtStr.split(",");
				 dateFmtList.put(dateRule[0], dateRule[1]);
			 }
		 }
	    //保存业务数据
	    String busiTypeCode = request.getParameter("busiTypeCode");
		return dao.update(datalist, conn, busiTypeCode,dateFmtList);
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  * 通用的删除方法
	  * @param id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.dssave.service.DsCRUDService#dsDel(java.lang.String, java.sql.Connection)
	 */
	@Override
	public boolean dsDel(String businessType,String busi_id, Connection conn) throws Exception  {
		DsCRUDDao dao = new DsCRUDDaoImpl();
		//保存业务数据
		//String businessType = request.getParameter("busiTypeCode");//业务类型
		//String busi_id = request.getParameter("busi_id");//业务数据ID
		return dao.del(conn, businessType, busi_id);
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  * 根据request获取页面意见信息
	  * @param request
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.dssave.service.DsCRUDService#getViewListInfo(javax.servlet.http.HttpServletRequest, java.sql.Connection)
	 */
	@Override
	public List<ViewListBean> getViewListInfo(HttpServletRequest request,
			Connection conn) throws Exception {
		String views = request.getParameter("views");
		String[] viewNameList  = views.split(",");
		
		List<ViewListBean> viewList = new ArrayList<ViewListBean>();
		
		for(String vlist:viewNameList){//遍历获取页面的意见信息
			String  viewValue = request.getParameter(vlist);
			if(!StringUtil.isBlank(viewValue)){
				ViewListBean vbean = new ViewListBean();
				vbean.setTable_name(vlist.split(Constant.SEPARATOR)[1]);
				vbean.setColumn_name(vlist.split(Constant.SEPARATOR)[2]);
				vbean.setAction_handeridea(viewValue);
				viewList.add(vbean);
			}
		}
		return viewList;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getPublicConfig
	  * @param ins_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.dssave.service.DsCRUDService#getPublicConfig(java.lang.String) 
	  */
	@Override
	public String getPublicConfig(String ins_id) throws Exception {
		DsCRUDDao dao = new DsCRUDDaoImpl();
		String isPublic = dao.getPublicConfig(ins_id);
		return isPublic;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 saveIs_open
	  * @param is_open
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.dssave.service.DsCRUDService#saveIs_open(java.lang.String, java.sql.Connection) 
	  */
	@Override
	public boolean updateIs_open(String is_open ,String ins_id , Connection conn)
			throws Exception {
		boolean flag = false;
		DsCRUDDao dao = new DsCRUDDaoImpl();
		flag = dao.updatePublicConfig(is_open,ins_id,conn);
		return flag;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getInfoTypeConfig
	  * @param ins_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.dssave.service.DsCRUDService#getInfoTypeConfig(java.lang.String)
	 */
	public String getInfoTypeConfig(String ins_id) throws Exception {
		DsCRUDDao dao = new DsCRUDDaoImpl();
		String isinfotype = dao.getInfoTypeConfig(ins_id);
		return isinfotype;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 updateInfoType
	  * @param is_infotype
	  * @param ins_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.dssave.service.DsCRUDService#updateInfoType(java.lang.String, java.lang.String, java.sql.Connection)
	 */
	public boolean updateInfoType(String info_type, String ins_id,
			Connection conn) throws Exception {
		boolean flag = false;
		DsCRUDDao dao = new DsCRUDDaoImpl();
		flag = dao.updateInfoTypeConfig(info_type, ins_id, conn);
		return flag;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 updateChiefEndTime
	  * @param chief_endtime
	  * @param ins_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.dssave.service.DsCRUDService#updateChiefEndTime(java.lang.String, java.lang.String, java.sql.Connection)
	 */
	public boolean updateChiefEndTime(String chief_endtime, String ins_id,
			Connection conn) throws Exception {
		boolean flag = false;
		DsCRUDDao dao = new DsCRUDDaoImpl();
		flag = dao.updateChiefConfig(chief_endtime, ins_id, conn);
		return flag;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getChiefConfig
	  * @param ins_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.dssave.service.DsCRUDService#getChiefConfig(java.lang.String)
	 */
	public String getChiefConfig(String ins_id) throws Exception {
		DsCRUDDao dao = new DsCRUDDaoImpl();
		String chief_endtime = dao.getChiefConfig(ins_id);
		return chief_endtime;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 hasSign
	  * @param mRecordID
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.dssave.service.DsCRUDService#hasSign(java.lang.String)
	 */
	public String hasSign(String ins_id,String busi_id) {
		DsCRUDDao dao = new DsCRUDDaoImpl();
		Connection conn = null;
		String returnid="";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			Map<String , String> map=dao.findTable(ins_id);
			String table_id=map.get("table_id");
			String column_id=map.get("column_id");
			String recordIDs= dao.findRecordIDs(table_id, column_id,busi_id);
			boolean flag=dao.hasText("singn"+recordIDs);
			if(flag){
				returnid="singn"+recordIDs;
			}else{
				returnid=recordIDs;
			}
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
		}finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		return returnid;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 saveAsText
	  * @param ins_id
	  * @param action_id
	  * @param conn
	  * @return 
	 * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.dssave.service.DsCRUDService#saveAsText(java.lang.String, java.lang.String, java.sql.Connection)
	 */
	@Override
	public boolean saveAsText(String ins_id, String action_id,String mRecordID, Connection conn) throws Exception {
		DsCRUDDao dao = new DsCRUDDaoImpl();
		boolean flag = true;
		FlowDocmentFileBean flowDocmentFileBean = new FlowDocmentFileBean();
		//根据流程实例ID，环节ID，获取当前环节实例ID
		String flow_act_id = dao.getFlowActId(ins_id,action_id,conn);
		//modifu by shuqi.liu 采用seq的形势获取ID，适配表分区
		DbManager dbManager = DbManager.getInstance();
    	String seq_oa_flow_document_file = dbManager.getSequence(null, "SEQ_OA_FLOW_DOCUMENT_FILE");
		flowDocmentFileBean.setId(seq_oa_flow_document_file);
		flowDocmentFileBean.setIns_id(ins_id);
		flowDocmentFileBean.setAction_id(action_id);
		flowDocmentFileBean.setFlow_act_id(flow_act_id);
		flag = dao.saveAsText(mRecordID,flowDocmentFileBean,conn);
		return flag;
	}

	@Override
	public boolean updateFile(String flow_act_id, String recordid) {
		DsCRUDDao dao = new DsCRUDDaoImpl();
		boolean flag = false;
		Connection conn = null;
		FlowDocmentFileBean flowDocmentFileBean = new FlowDocmentFileBean();
		try {
			flowDocmentFileBean.setFlow_act_id(flow_act_id);
			flowDocmentFileBean.setRecordid(recordid);
			flag=dao.updateFile(flowDocmentFileBean, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
		}finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		return flag;
	}
}
