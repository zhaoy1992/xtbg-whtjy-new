
 /**
 * [Product]
  *     tjy_xtbg168
  * [Copyright]
  *     Copyright © 2015 ICSS All Rights Reserved.
  * [FileName]
  *     AnswersFlowDaoImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2015-2-4   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.answers.dao.imp;

import com.chinacreator.xtbg.core.archive.dao.FlowBusiDataSaveDao;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DaoUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.dataresources.util.DataResourcesUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import javax.servlet.http.HttpServletRequest;
/**
 *<p>Title:AnswersFlowDaoImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2015-2-4
 */
public class AnswersFlowDaoImpl extends XtDbBaseDao implements FlowBusiDataSaveDao{

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 saveBusiInfo
	  * @param request
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.dao.FlowBusiDataSaveDao#saveBusiInfo(javax.servlet.http.HttpServletRequest, java.sql.Connection) 
	  */
	@Override
	public boolean saveBusiInfo(HttpServletRequest request, Connection conn)
			throws Exception {
		//当前环节
		String action_defid = request.getParameter("action_defid");
		//业务类型Code
		String busiTypeCode = request.getParameter("busiTypeCode");
		//主键
		String busi_id = request.getParameter("busi_id");
		//最后一个环节办结
		if(action_defid!=null && action_defid.equals("ywbd_wp1_act10")){
			//修改     有问必答的发布状态
			//updateAnswerIspublish(busi_id);
		}
		return true;
	}
	
	
	/**
	*<b>Summary: </b>
	* updateAnswerIspublish(修改有问必答的发布状态)
	* @param t_id
	* @return
	 */
	public boolean updateAnswerIspublish(String t_id) throws Exception{
		boolean result = true;
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		
		sql.append(" update  ta_oa_answers_info ");
		sql.append("  set ispublish ='1' ");
		sql.append("  where  t_id =? ");
		try{
			pdb.preparedUpdate(sql.toString());
			pdb.setString(1, t_id );
			pdb.executePrepared();
		}catch(Exception e){
			result = false;
			e.printStackTrace();
			throw e;
		}
		return result;
	}

}
