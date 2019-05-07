package com.chinacreator.xtbg.core.common.note.services.impl.jingdi.dao.impl;

import java.sql.Connection;

import com.chinacreator.xtbg.core.common.note.services.impl.jingdi.dao.JingdiDoteSendDao;
import com.chinacreator.xtbg.core.common.note.services.impl.jingdi.entity.SendTask;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>Title:JingdiDoteSendDaoImpl.java</p>
 *<p>Description:金迪dao实体处理类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-6-24
 */
public class JingdiDoteSendDaoImpl implements JingdiDoteSendDao {

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 smsSendDao
	  * @param sendTask
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.common.note.services.impl.jingdi.dao.JingdiDoteSendDao#smsSendDao(com.chinacreator.xtbg.core.common.note.services.impl.jingdi.entity.SendTask)
	 */
	public boolean smsSendDao(SendTask sendTask, Connection conn) throws Exception {
		boolean flag = false;
		PreparedDBUtil  pdb = new PreparedDBUtil ();
		StringBuffer sql = new StringBuffer();
		sql.append(" insert into  ");
		sql.append("   T_SendTask (TaskID,DestNumber,Content )");
		sql.append("   values(seq_t_sendtask.nextval,?,?) ");
		
		if(!StringUtil.isBlank(sendTask.getDestnumber())){
			pdb.preparedInsert(sql.toString());
			pdb.setString(1,sendTask.getDestnumber());
			pdb.setString(2,sendTask.getContent());
			pdb.executePrepared(conn);
		}
		flag = true;
		return flag;
	}

}
