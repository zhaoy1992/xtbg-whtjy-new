package com.chinacreator.xtbg.wangcheng.androidversion.service.impl;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.wangcheng.androidversion.dao.AndroidVersionDao;
import com.chinacreator.xtbg.wangcheng.androidversion.dao.imploracle.AndroidVersionDaoImpl;
import com.chinacreator.xtbg.wangcheng.androidversion.entity.AndroidVersionBean;
import com.chinacreator.xtbg.wangcheng.androidversion.service.AndroidVersionService;
import com.chinacreator.xtbg.pub.util.DaoUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
/**
 * 
 *<p>Title:AndroidVersionServiceIfc.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author pingan.liu
 *@version 1.0
 *Jul 5, 2013
 */
public class AndroidVersionServiceIfc implements AndroidVersionService{
	private static final Logger LOG = Logger.getLogger(AndroidVersionServiceIfc.class);
	AndroidVersionDao dao = new AndroidVersionDaoImpl();
	/**
	  * <b>Summary: </b>
	  *     复写方法 deleteAndroidVersion
	  * @param id
	  * @return 
	  * @see com.chinacreator.xtbg.wangcheng.androidversion.service.AndroidVersionService#deleteAndroidVersion(java.lang.String)
	 */
	public String deleteAndroidVersion(String id) {
		// TODO Auto-generated method stub
		String flag = "faild";
		try {
			if(dao.delAndroidVersionBean(id)){
				return "delete_success";
			} else {
				return "faild";
			}
		} catch (Exception e) {
			LOG.error("删除版本控制报错"+e.getMessage());
		}
		return flag;
	}

	/**
	  * <b>Summary: </b>
	  *     复写方法 saveAndroidVersion
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.wangcheng.androidversion.service.AndroidVersionService#saveAndroidVersion(com.chinacreator.xtbg.wangcheng.androidversion.entity.AndroidVersionBean)
	 */
	public String saveAndroidVersion(AndroidVersionBean bean) {
		// TODO Auto-generated method stub
		String flag = "faild";
		if(StringUtil.isBlank(bean.getVersion_id())){
			try {
				bean.setVersion_id(DaoUtil.getUUID());//获得环节信息id
				if(dao.saveAndroidVersionBean(bean)){
					return "save_success";
				} else {
					return "faild";
				}
			} catch (Exception e) {
				LOG.error("插入版本控制报错"+e.getMessage());
			}
		} else {
			try {
				if(dao.updateAndroidVersionBean(bean)){
					return "update_success";
				} else {
					return "faild";
				}
			} catch (Exception e) {
				LOG.error("更新版本控制报错"+e.getMessage());
			}
		}
		return flag;
	}

}
