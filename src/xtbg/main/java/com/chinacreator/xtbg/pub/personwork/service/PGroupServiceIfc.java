/**
 * 
 * <p>Title: 标题</p>
 * <p>Description: 类描叙，具体功能</p>
 * <p>Copyright: Copyright (c) 2011</p>
 * <p>Company: chinacreator</p>
 * @author 编写人
 * @version 版本
 * may 1, 2011  日期
 *
 */
package com.chinacreator.xtbg.pub.personwork.service;


/**
 * 
 * <p>Title: 分组管理biz</p>
 * <p>Description: 分组管理biz</p>
 * <p>Copyright: Copyright (c) 2011</p>
 * <p>Company: chinacreator</p>
 * @author 刘为玮
 * @version 1.0
 * Feb 16, 2012  日期
 *
 */
public interface PGroupServiceIfc {
	/**
	 * 该分组是否已存在
	 */
	boolean queryExist(String paramjosn);
	/**
	 * 增加分组
	 */
	boolean pGroupAdd(String paramjosn);
	
	/**
	 * 更新分组
	 */
	boolean pGroupUpdate(String paramjosn);
	/**
	 * 删除分组
	 */
	boolean pGroupDelete(String paramjosn);
}
