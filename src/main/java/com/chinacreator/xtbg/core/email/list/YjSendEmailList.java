package com.chinacreator.xtbg.core.email.list;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.email.dao.EmailDao;
import com.chinacreator.xtbg.core.email.dao.impl.EmailDaoImpl;
import com.chinacreator.xtbg.core.email.entity.EmailBaseBean;
/**
 * 
 *<p>Title:YjSendEmailList.java</p>
 *<p>Description:邮件--已发送、草稿箱邮件分页查询</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-11-19
 */
public class YjSendEmailList extends DataInfoImpl {

	private static final Log LOG=LogFactory.getLog(YjSendEmailList.class);
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getDataList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return 
	  * @see com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl#getDataList(java.lang.String, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		EmailBaseBean mailBean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			parmjson = Escape.unescape(parmjson);
			mailBean = (EmailBaseBean) JSONObject.parseObject(parmjson, EmailBaseBean.class);
			}
		try {
			EmailDao  dao =new EmailDaoImpl();
			pb = dao.findMailInfoListByYjSend(mailBean, sortName, sortOrder, offset, maxPagesize);	
		} catch (Exception e) {
			LOG.error(e);
		}
		return pb;
	}

	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder) {
		// TODO Auto-generated method stub
		return null;
	}

}
