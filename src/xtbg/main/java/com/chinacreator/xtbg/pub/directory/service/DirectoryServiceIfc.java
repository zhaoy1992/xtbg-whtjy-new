package com.chinacreator.xtbg.pub.directory.service;

import java.sql.SQLException;

import com.chinacreator.sysmgrcore.entity.User;
import com.chinacreator.xtbg.pub.common.ResultCode;
import com.chinacreator.xtbg.pub.common.ResultMap;
import com.chinacreator.xtbg.pub.directory.entity.DirectoryBean;


/**
 *<p>Title:DirectoryServiceIfc.java</p>
 *<p>Description:名录管理服务接口类</p> 
 *<p>Company:湖南科创</p>
 *@author 刘春元
 *@version 1.0
 *2012-2-16
 */
public interface DirectoryServiceIfc {


	
	/**
	 * @Description  保存名录管理信息
	 * 
	 * @param paramjosn  要保存的名录管理
	 * @return  boolean
	 * @exception 
	 */
	public String saveType(String paramjosn);
	
	/**
	 * @Description  根据名录管理ID获得公告名录管理
	 * 
	 * @param id  名录管理ID
	 * @return  ContentBean名录管理对象
	 * @exception 
	 */
	public DirectoryBean getTypeBeanById(String id,String listtype);
	
	/**
	 * @Description  修改名录管理信息
	 * 
	 * @param paramjosn  要修改的名录管理
	 * @return  boolean
	 * @exception 
	 */
	public boolean updateType(String paramjosn);
	
	/**
	 * @Description  删除公告名录管理
	 * 
	 * @param ids  //要删除的名录管理ID
	 * @return  boolean
	 * @exception 
	 */
	public boolean delType(String ids);
	
	/**
	 * @Description  根据名录管理ID获得公告名录管理(望城专用)
	 * 
	 * @param id  名录管理ID
	 * @return  ContentBean名录管理对象
	 * @exception 
	 */
	public User getuserinfo(String id);
	
	/**
	 * 陈建华2013-05-27增加
	*<b>Summary: 根据视图名称，查询出数据，并组装成select 的html</b>
	* createSelectHtml()
	* @param viewName
	* @param selected
	* @param selectName
	* @return
	 */
	public String createSelectHtml(String viewName,String selected,String selectName);
	
	/**
	 * 陈建华2013-05-27 为望城增加
	*<b>Summary:根据系统参数ID，查询出系统参数值（次方法是提供个人简历，家庭成员模板）</b>
	* getSystemParameter()
	* @param paramId
	* @return
	* @throws SQLException
	 */
	public String getSystemParameter(String paramId) throws SQLException;
	
	/**
	 * 陈建华2013-07-25 为望城增加
	*<b>Summary: 更新用户信息 </b>
	* updateUserinfowc()
	* @param user
	* @return
	 */
	public boolean updateUserinfowc (User user,String listStr);
	
}
