package com.chinacreator.xtbg.pub.exportLoginfo;

import org.python.modules.newmodule;

import com.chinacreator.xtbg.pub.dbbase.dao.XtDbBaseDao;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * 
 *<p>Title:FixedAssetDaoImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 刘为玮
 *@version 1.0
 *2013-8-13
 */
public class ExportlogDaoImpl extends XtDbBaseDao  {

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 queryRoomInfo
	  * @return 
	  * @see com.chinacreator.xtbg.fagaiwei.fixedAssets.dao.FixedAssetDao#queryRoomInfo()
	 */
	public String querylogdate() throws Exception{
		String logdate="";
		PreparedDBUtil pdb=new PreparedDBUtil();
		StringBuffer sql= new StringBuffer();
		sql.append("select to_char(min(l.log_opertime),'yyyy-mm-dd') log_opertime from TD_SM_LOG l");
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared();
		for (int i = 0; i < pdb.size(); i++) {
			logdate=pdb.getString(i, "log_opertime");
		}
		return logdate;
	}
}
