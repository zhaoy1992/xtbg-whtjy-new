package com.chinacreator.xtbg.core.personwork.list;

import java.util.List;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.personwork.dao.PersonInfoDao;
import com.chinacreator.xtbg.core.personwork.entity.PersonSearchBean;
/**
 * 
 *<p>Title:PublicAddressBook4RoleuserList.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-6-14
 */
public class PublicAddressBook4RoleuserList extends DataInfoImpl {

	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger
			.getLogger(PublicAddressBook4RoleuserList.class);

	/**
	 * 
	 * <b>Summary: 查询个人通讯录人员信息列表</b> 复写方法 getDataList
	 * 
	 * @param parmjson
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @see com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl#getDataList(java.lang.String,
	 *      java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		PersonSearchBean personSearchBean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson)) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			parmjson = Escape.unescape(parmjson);
			personSearchBean = (PersonSearchBean) JSONObject.parseObject(
					parmjson, PersonSearchBean.class);
		}

		try {
			PersonInfoDao personInfodao = (PersonInfoDao) LoadSpringContext
					.getApplicationContext().getBean("personInfoDaoImpl");
			pb = personInfodao.findPublicAddressBook4RoleuserList(
					personSearchBean, sortName, sortOrder, offset, maxPagesize);

		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		return pb;
	}

	public PagingBean getDataList(String parmStr, String sortName,
			String sortOrder) {

		return null;
	}

	/**
	 * 
	*<b>Summary: 递归获得所有的机构ID</b>
	* getOrgidList(请用一句话描述这个方法的作用)
	* @param orgid
	* @return
	 */
	public List<PersonSearchBean> getOrgidList(String orgid) {
		List<PersonSearchBean> list = null;
		try {
			PersonInfoDao personInfodao = (PersonInfoDao) LoadSpringContext
					.getApplicationContext().getBean("personInfoDaoImpl");
			list = personInfodao.findOrgidList(orgid);

		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		return list;
	}
}
