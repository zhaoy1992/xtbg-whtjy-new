package com.chinacreator.xtbg.core.common.msgcenter.list;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.msgcenter.entity.MessageSendBean;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 *<p>Title:WaitReadList.java</p>
 *<p>Description:用户站内消息列表</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-6-29
 */
public class MsgList extends DataInfoImpl{
	
	private static final Logger LOG = Logger.getLogger(MsgList.class);

	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		PagingBean pagingBean = new PagingBean();
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		try {
			sql.append("select r.msg_id,r.msg_content,r.msg_type,r.msg_url,r.send_userid,r.send_orgid,r.send_date from oa_msg_recv t ")
					.append(" left join oa_msg_send r on t.msg_id = r.msg_id where t.recv_userid = ? ");

			if(sortName != null && !"".equals(sortName)){
				sql.append(" order by t.isread,").append(sortName).append(" ").append(sortOrder);
			}else{
				sql.append(" order by t.isread,r.send_date desc ");
			}
			
			LOG.info("获取用户站内消息列表sql--->"+sql.toString());
			pdb.preparedSelect(sql.toString(),offset,maxPagesize);
			pdb.executePrepared();
			List<MessageSendBean> list = new ArrayList<MessageSendBean>();
			for (int j = 0; j < pdb.size(); j++) {
				MessageSendBean sendBean = new MessageSendBean();
				sendBean.setMsg_id(pdb.getString(j,"msg_id"));
				sendBean.setMsg_content(pdb.getString(j, "msg_content"));
				sendBean.setMsg_type(pdb.getString(j, "msg_type"));
				sendBean.setMsg_url(pdb.getString(j, "msg_url"));
				sendBean.setSend_userid(pdb.getString(j, "send_userid"));
				sendBean.setSend_orgid(pdb.getString(j, "send_orgid"));
				sendBean.setSend_date(pdb.getTimestamp(j, "send_date"));
				list.add(sendBean);
			}
			pagingBean.setList(list);
			pagingBean.setRecords((long)pdb.getTotalSize());
		} catch (Exception e) {
			LOG.error("获取用户站内消息列表异常",e);
			return null;
		}
		return pagingBean;
	}

	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder) {
		// TODO Auto-generated method stub
		return null;
	}

}
