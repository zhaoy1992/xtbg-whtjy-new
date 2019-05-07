package com.chinacreator.xtbg.core.dssave.service;

import java.sql.Connection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.chinacreator.xtbg.core.dssave.entity.ViewListBean;


/**
 * 
 *<p>Title:OperArchiveService.java</p>
 *<p>Description:通用保存service接口</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-4-8
 */
public interface DsCRUDService {
	/**
	 * 
	*<b>Summary: </b>
	* saveArchive(通用保存方法)
	* @param request
	* @return
	 */
	public boolean dsSave(HttpServletRequest request,Connection conn) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* updateArchive(通用更新方法)
	* @param request
	* @return
	 */
	public boolean dsUpdate(HttpServletRequest request,Connection conn)throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* DelArchive(通用删除方法)
	* @param id
	* @return
	 */
	public boolean dsDel(String businessType,String busi_id,Connection conn)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getViewListInfo(根据request获取页面意见信息)
	* @param request
	* @param conn
	* @return
	* @throws Exception
	 */
	public List<ViewListBean> getViewListInfo(HttpServletRequest request,Connection conn)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getPublicConfig(查询是否信息公开)
	* @param ins_id
	* @return
	 */
	public String getPublicConfig(String ins_id)throws Exception;
	
	/**
	*<b>Summary: </b>
	* saveIs_open(保存是否信息公开)
	* @param is_open
	* @param conn
	* @return 
	*/
	public boolean updateIs_open(String is_open,String ins_id, Connection conn)throws Exception;
	/**
	*<b>Summary: </b>
	* getInfoTypeConfig(查询信息分类)
	* @param ins_id
	* @return
	* @throws Exception
	 */
	public String getInfoTypeConfig(String ins_id)throws Exception;
	
	/**
	*<b>Summary: </b>
	* saveIs_open(保存是否信息公开)
	* @param is_open
	* @param conn
	* @return 
	*/
	public boolean updateInfoType(String info_type,String ins_id, Connection conn)throws Exception;
	/**
	*<b>Summary: </b>
	* updateChiefEndTime(保存督办时间)
	* @param chief_endtime
	* @param conn
	* @return 
	*/
	public boolean updateChiefEndTime(String chief_endtime,String ins_id, Connection conn)throws Exception;
	/**
	*<b>Summary: </b>
	* getChiefConfig(查询信息分类)
	* @param ins_id
	* @return
	* @throws Exception
	 */
	public String getChiefConfig(String ins_id)throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* hasSign(是否存在面签)
	* @param mRecordID
	* @return
	* @throws Exception
	 */
	public String hasSign(String ins_id,String busi_id);
	/**
	 * 
	*<b>Summary: </b>
	* updateFile(更新正文)
	* @param filebody
	* @param recordid
	* @return
	 */
	public boolean updateFile(String flow_act_id,String recordid);
	
	/**
	 * 
	*<b>Summary: </b>
	* saveAsText(保存备份正文WORD信息)
	* @param ins_id
	* @param action_id
	* @param conn
	* @return
	 */
	public boolean saveAsText(String ins_id, String action_id,String mRecordID, Connection conn) throws Exception;
}
