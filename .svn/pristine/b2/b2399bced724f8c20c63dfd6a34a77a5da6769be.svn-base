package com.chinacreator.xtbg.pub.tree.dao;

import java.util.Map;

import com.chinacreator.xtbg.pub.tree.entity.TreeBean;

/**
 *<p>Title:TestZtreeDao.java</p>
 *<p>Description:测试Ztree的dao层接口</p> 
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2012-1-12
 */
public interface ModuleTreeDao {
	/**
	 * 获得机构树
	 * @param map
	 * @return
	 */
	public String getModuleTreeMessage();
	
	/**
	 * 同步全展开人员树
	 * @param map
	 * @return
	 */
	public String getOrgUserTreeMessage();
	
	/**
	 * 同步全展开机构树
	 * @param map
	 * @return
	 */
	public String getOrgTreeMessage();
	
	/**
	 * 根据用户条件指定展开机构树
	 * @param map
	 * @return
	 */
	public String getOrgTreeMessageByUserInfo(Map<String,Object> userInfos);
	
	

	
	public Object getTreeJsonValue(TreeBean bean);
	public Object getTree2JsonValue(TreeBean bean);
	/**
	 * 
	*<b>Summary: </b>
	* getTree3JsonValue(根据admin下配置的用户分组生成常用分组josn字符串)
	* @param bean
	* @return
	 */
	public Object getTree3JsonValue(TreeBean bean);
	public Object getTreeUpdateJsonValue(TreeBean bean);
	public Object getTreeInsertJsonValue(TreeBean bean);
	public Object getcustomTreeJsonValue(TreeBean bean);
	public Object inqueryTreeUserByRange(TreeBean bean);
	/**
	 * 
	*<b>Summary: 传入userid获取按人员树顺序排序后的userid的拼接字符串</b>
	* @param userIds
	* @return
	 */
	public String getUserIdsByTreeUserOrder(String userIds) throws Exception;
	

}
