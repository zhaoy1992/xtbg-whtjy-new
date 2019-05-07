package com.chinacreator.xtbg.core.archive.gwcs.dao.impl;

import java.sql.Connection;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.chinacreator.xtbg.core.archive.entity.OfficialDocumentRegisterHandleBean;
import com.chinacreator.xtbg.core.archive.service.ArchiveExtService;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * 
 *<p>Title:GwDoWithFlowImpl.java</p>
 *<p>Description:来文处理对流程处理</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-12-15
 */
public class GwDoWithFlowImpl implements ArchiveExtService {

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
		String id=request.getParameter(OfficialDocumentRegisterHandleBean.OFF_DOC_REG_ID);
		if(!StringUtil.isBlank(id)){
			PreparedDBUtil pdb=new PreparedDBUtil();
			String sql="update t_lwgl set is_accept='1' where t_gwreceive_id=? ";
			pdb.preparedUpdate(sql);
			pdb.setString(1, id);
			pdb.executePrepared(conn);
		}
		return true;
	}

}
