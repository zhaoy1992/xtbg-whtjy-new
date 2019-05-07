package com.chinacreator.xtbg.core.paper.service;

import java.util.Map;

import com.chinacreator.xtbg.core.paper.entity.PaperBean;


/**
 *<p>Title:PaperService.java</p>
 *<p>Description:信息报送Service接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄海
 *@version 1.0
 *2013-9-13
 */
public interface PaperService {

	
	/**
	*<b>Summary: </b>
	* copydoc2pdf(doc另存为一份名字一样pdf)
	* @param p_manage_id
	* @return 
	*/
	public boolean copydoc2pdf(String p_manage_id,String path);

	
	/**
	*<b>Summary: </b>
	* updateLeaderRemark(更新领导指示)
	* @param p_manage_id
	* @param p_leader_remark
	* @return 
	*/
	public boolean updateLeaderRemark(String p_manage_id,String p_leader_remark);
	/**
	*<b>Summary: </b>
	* savePaperSendAdd(信息补发)
	* @param map
	* @return 
	*/
	public boolean savePaperSendAdd(Map<String, String> map);

	/**
	*<b>Summary: </b>
	* savePaperReceiveInfo(保存信息发送的接收方明细)
	* @param map
	* @return 
	*/
	public boolean savePaperReceiveInfo(Map<String, String> map);

	/**
	*<b>Summary: </b>
	* getPaperBeanById(根据 Id查询信息表)
	* @param p_manage_id
	* @return
	 */
	public Map<String, String> getPaperBeanById(String p_manage_id);
	
	/**
	*<b>Summary: </b>
	* insertOrUpdateBean(增加和修改信息表)
	* @param bean
	* @return
	 */
	public String insertOrUpdateBean(PaperBean bean);
	
	/**
	*<b>Summary: </b>
	* deletePaperByIds(根据ids删除信息表)
	* @param ids
	* @return
	 */
	public String  deletePaperByIds(String[] ids);
	
	
	/**
	*<b>Summary: </b>
	* accPaper4PendingByIds(根据ids信息采编设置)
	* @param ids
	* @return 
	*/
	public boolean updatePaper2AccByIds(String[] ids,String flagId,String userId);
	
	
	/**
	*<b>Summary: </b>
	* updateUnAccInfo(退稿并记录退稿原因信息等)
	* @param p_manage_id
	* @param p_unacc_user_id
	* @param p_unacc_user_name
	* @param p_unacc_remark
	* @return 
	*/
	public boolean updateUnAccInfo(String p_manage_id,String p_unacc_user_id,String p_unacc_user_name,String p_unacc_remark);

	
}
