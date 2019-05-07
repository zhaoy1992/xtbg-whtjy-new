package com.chinacreator.xtbg.pub.personwork.list;

import java.util.List;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.pub.common.DataInfoImpl;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.personwork.dao.PersonInfoDao;
import com.chinacreator.xtbg.pub.personwork.entity.PersonSearchBean;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;

public class PublicAddressBook4RoleuserList implements DataInfoImpl{

	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(PublicAddressBook4RoleuserList.class);
	

	/**
	 * @Description  查询个人通讯录人员信息列表
	 * 
	 * @param request
	 * @param response
	 * @return  返回JOSNOBJECT
	 * @exception 
	 */
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		PersonSearchBean personSearchBean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			parmjson = Escape.unescape(parmjson);
			personSearchBean = (PersonSearchBean) JSONObject.parseObject(parmjson, PersonSearchBean.class);
		}
		
		try {
			PersonInfoDao personInfodao = (PersonInfoDao)DaoImplClassUtil.getDaoImplClass("personInfoDaoImpl");
			pb = personInfodao.findPublicAddressBook4RoleuserList(personSearchBean, sortName, sortOrder, offset, maxPagesize);
			
		} catch (Exception e) {
			LOG.error(e);
		}
		return pb;
	}


	public PagingBean getDataList(String parmStr, String sortName, String sortOrder) {
		
		return null;
	}

/**
 * 递归获得所有的机构ID
 * @param orgid
 * @return List<PersonSearchBean>
 */
public List<PersonSearchBean> getOrgidList(String orgid) {
		List<PersonSearchBean> list =null;
		try {
			PersonInfoDao personInfodao = (PersonInfoDao)DaoImplClassUtil.getDaoImplClass("personInfoDaoImpl");
			list = personInfodao.findOrgidList(orgid);
			
		} catch (Exception e) {
			LOG.error(e);
		}
		return list;
	}
}
