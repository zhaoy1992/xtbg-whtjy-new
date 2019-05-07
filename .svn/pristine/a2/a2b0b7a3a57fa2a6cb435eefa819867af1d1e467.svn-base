package com.chinacreator.xtbg.core.directory.service;

import java.util.List;

import com.chinacreator.xtbg.core.directory.entity.DirectoryBean;
import com.chinacreator.xtbg.core.directory.entity.HeTongBean;
import com.chinacreator.xtbg.core.directory.entity.ListShowUtilBean;
import com.chinacreator.xtbg.core.directory.entity.UserinfoBean;


/**
 *<p>Title:DirectoryServiceIfc.java</p>
 *<p>Description:名录管理服务接口类</p> 
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2012-2-16
 */
public interface DirectoryServiceIfc {
	
	/**
	 * 
	 * <b>Summary: 根据名录管理ID获得公告名录管理</b>
	 * @param id  名录管理ID
	 * @return  ContentBean名录管理对象
	 * @exception 
	 */
	public DirectoryBean getTypeBeanById(String id,String listtype);
	
	/**
	 * 
	*<b>Summary: 根据用户ID获得合同信息</b>
	* getHeTongBeanById(请用一句话描述这个方法的作用)
	* @param id
	* @return
	 */
	public HeTongBean getHeTongBeanById(String id);
		
   /**
	 * 
	 *<b>Summary: 获取公共通讯录首字母查询相关信息</b> getFirstCodeShowInfo(请用一句话描述这个方法的作用)
	 * 
	 * @param orgoruserid
	 * @return
	 * @throws Exception
	 */
	public List<ListShowUtilBean> getFirstCodeShowInfo(String orgoruserid);
	
	/**
	 * 
	 *<b>Summary: 管理员修改用户信息</b> updateUserinfo(请用一句话描述这个方法的作用)
	 * 
	 * @param userinfoBean
	 * @throws Exception
	 */
	public boolean updateUserinfo(UserinfoBean userinfoBean, HeTongBean heTongBean);
	
	/**
	 * 
	*<b>Summary: </b>
	* updateUserXCinfo(管理员修改用户薪酬信息)
	* @param userinfoBean
	* @return
	 */
	public boolean updateUserXCinfo(UserinfoBean userinfoBean);
	
	/**
	 * 
	*<b>Summary: 根据人员id查询其配置的可查看的薪酬人员id</b>
	* getPeizhiUserId(请用一句话描述这个方法的作用)
	* @param id
	* @return
	 */
	public String getPeizhiUserId(String id);

}
