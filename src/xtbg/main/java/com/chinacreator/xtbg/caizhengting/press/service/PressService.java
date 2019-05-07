package com.chinacreator.xtbg.caizhengting.press.service;

import com.chinacreator.xtbg.caizhengting.press.entity.PressBean;
/**
 * 出版社service接口
 *<p>Title:PressService.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author pingan.liu
 *@version 1.0
 *Sep 10, 2013
 */
public interface PressService {

	/**
	 * 保存出版社，在保存之前会根据名字查询数据库，看数据中是否有相同 名字出版社
	*<b>Summary: </b>
	* save(请用一句话描述这个方法的作用)
	* @param bean
	* @return
	 */
	public String save(PressBean bean);
}
