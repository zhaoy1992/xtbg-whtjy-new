package com.chinacreator.xtbg.core.pubconfig.service.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.pubconfig.dao.ColStautsContorlDao;
import com.chinacreator.xtbg.core.pubconfig.entity.ColStautsContorlBean;
import com.chinacreator.xtbg.core.pubconfig.service.ColStautsContorlServiceIfc;
/**
 * 
 *<p>Title:ColStautsContorlServiceImpl.java</p>
 *<p>Description:表单元素状态服务实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-7-31
 */
public class ColStautsContorlServiceImpl implements ColStautsContorlServiceIfc {

	private static Log LOG=LogFactory.getLog(ColStautsContorlServiceImpl.class);
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 saveColStatusForm
	  * @param paramjosn
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.pubconfig.service.ColStautsContorlServiceIfc#saveColStatusForm(java.lang.String)
	 */
	public void saveColStatusForm(String paramjosn){
		if (!StringUtil.isBlank(paramjosn)) {
			paramjosn = DataControlUtil.replaceStr(paramjosn);
			paramjosn = Escape.unescape(paramjosn);
			try {
				List<ColStautsContorlBean> list = (List<ColStautsContorlBean>)JSONObject.parseArray(paramjosn, ColStautsContorlBean.class);
				ColStautsContorlDao dao = (ColStautsContorlDao) LoadSpringContext.getApplicationContext().getBean("colStautsContorlDaoImpl");
				for (ColStautsContorlBean model : list) {
					dao.updateColStatusForm(model);
				}
			} catch (Exception e) {
				LOG.error(e.getMessage(), e);
			}
		}
	}

}
