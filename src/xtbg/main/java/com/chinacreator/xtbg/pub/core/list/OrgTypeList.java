package com.chinacreator.xtbg.pub.core.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.pub.common.DataInfoImpl;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.core.dao.OrgTypeDao;
import com.chinacreator.xtbg.pub.core.entity.OrgTypeBean;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;

/**
 *<p>Title:OrgTypeList.java</p>
 *<p>Description:实例信息list数据显示</p> 
 *<p>Company:湖南科创</p>
 *@author 李义
 *@version 1.0
 *2012-1-31
 */
public class OrgTypeList implements DataInfoImpl{

	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(OrgTypeList.class);
	
	/**
	 * @Description  查询用户列表
	 * 
	 * @param request
	 * @param response
	 * @return  返回JOSNOBJECT
	 * @exception 
	 */
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		
		OrgTypeBean entity = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson)&&!"false".equals(parmjson) ) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			entity = (OrgTypeBean) JSONObject.parseObject(parmjson, OrgTypeBean.class);
			if(!StringUtil.isBlank(entity.getName())){
				entity.setName(Escape.unescape(entity.getName()));
			}
			if(!StringUtil.isBlank(entity.getTypeVal())){
				entity.setTypeVal(Escape.unescape(entity.getTypeVal()));
			}
		}
		
		try {
			OrgTypeDao daojson = (OrgTypeDao)DaoImplClassUtil.getDaoImplClass("orgTypeDaoImpl");
			pb = daojson.findOrgTypeList(entity, sortName, sortOrder, offset, maxPagesize);
			
		} catch (Exception e) {
			e.printStackTrace();
			LOG.error(e);
		}
		return pb;
	}


	public PagingBean getDataList(String parmStr, String sortName, String sortOrder) {
		return null;
	}
}
