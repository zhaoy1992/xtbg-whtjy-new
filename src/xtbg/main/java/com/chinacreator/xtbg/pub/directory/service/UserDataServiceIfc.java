package com.chinacreator.xtbg.pub.directory.service;

import java.util.List;

import com.chinacreator.xtbg.pub.common.ResultCode;
import com.chinacreator.xtbg.pub.common.ResultMap;
import com.chinacreator.xtbg.pub.directory.entity.UserData;

/**
 * 
 *<p>Title:UserDataServiceIfc.java</p>
 *<p>Description:用户简历数据服务层接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *Jul 25, 2013
 */
public interface UserDataServiceIfc {
	/**
	 * 
	*<b>Summary: 查询用户简历数据列表 </b>
	* list()
	* @param user_id
	* @return
	 */
	public ResultMap<ResultCode, List<UserData>> list(String user_id); 
	
	/**
	 * 
	*<b>Summary: 根据id删除数据</b>
	* delete()
	* @param id
	* @return
	 */
	public ResultMap<ResultCode,UserData> delete(String id);
}
