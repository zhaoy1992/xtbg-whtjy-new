package com.chinacreator.xtbg.core.notice.dao.imploracle;

import java.sql.Connection;

import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.notice.dao.NoticeReceiverUserDao;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>Title:NoticeReceiverUserDaoImpl.java</p>
 *<p>Description:通知公告用户接收Dao实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-6-20
 */
public class NoticeReceiverUserDaoImpl extends XtDbBaseDao implements NoticeReceiverUserDao {

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getNoticeViewState
	  * @param n_receiverid
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.notice.dao.NoticeBaseInfoDao#getNoticeViewState(java.lang.String, java.sql.Connection)
	 */
	public String getNoticeViewState(String n_receiverid, Connection conn)
			throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		String n_isview = "";
		StringBuffer sql = new StringBuffer();
		sql.append("select r.n_isview from oa_notice_receiver_user r where r.n_receiverid = ?");
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, n_receiverid);
		pdb.executePrepared(conn);
		if (pdb.size() > 0) {
			n_isview = pdb.getString(0, "n_isview");
		}
		return n_isview;
	}

}
