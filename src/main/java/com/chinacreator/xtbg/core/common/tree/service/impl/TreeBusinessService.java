package com.chinacreator.xtbg.core.common.tree.service.impl;

import com.chinacreator.xtbg.core.common.tree.dao.impl.CommonTreeDaoImpl;
import com.chinacreator.xtbg.core.common.tree.dao.impl.TreeBusinessDaoImpl;
import com.chinacreator.xtbg.core.common.tree.entity.TreeBean;

/**
 * 
 *<p>Title:TreeBusinessService.java</p>
 *<p>Description:业务树查询</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-5-15
 */
public class TreeBusinessService {
	
	
	/**
	*<b>Summary: </b>
	* inqueryTreeMeetingOrganization(查询所有的机构树--不显示已选的)
	* @param bean
	* @return 
	*/
	public Object inqueryTreeMeetingOrganization(TreeBean bean){
		return CommonTreeDaoImpl.inqueryTreeMeetingOrganization(bean);
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* inqueryTreeOrganization4ids(按机构ids查询过滤机构树的记录集)
	* @param bean
	* @return 
	*/
	public Object inqueryTreeOrganization4ids(TreeBean bean){
		return TreeBusinessDaoImpl.inqueryTreeOrganization4ids(bean);
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* inqueryTreeOrganization(查询所有的机构树)
	* @param bean
	* @return
	 */
	public Object inqueryTreeOrganization(TreeBean bean){
		return CommonTreeDaoImpl.inqueryTreeOrganization(bean);
	}
	/**
	 * 
	*<b>Summary: </b>
	* inqueryTreePerson(查询机构人员树)
	* @param bean
	* @return
	 */
	public Object inqueryTreePerson(TreeBean bean){
		return CommonTreeDaoImpl.inqueryTreePerson(bean);
		 
	}
	
	public Object inqueryTreeShowType(TreeBean bean){	
		return TreeBusinessDaoImpl.inqueryTreeShowType(bean);
	}
	/**
	 * 
	*<b>Summary: 查询得到分组树</b>
	* getTree2JsonValue(请用一句话描述这个方法的作用)
	* @param bean
	* @return
	 */
	public Object getTree2JsonValue(TreeBean bean){
		return TreeBusinessDaoImpl.getTree2JsonValue(bean);
	}

	 /**
	  * 
	 *<b>Summary:保存常用分组信息 </b>
	 * getTreeInsertJsonValue(请用一句话描述这个方法的作用)
	 * @param bean 树的对象
	 * @return
	  */
	 public Object getTreeInsertJsonValue(TreeBean bean){
		 return TreeBusinessDaoImpl.getTreeInsertJsonValue(bean);
	 }
	 
	/**
	 *  
	*<b>Summary: </b>
	* inqueryTreeUser(根据User_id查询机构树)
	* @param bean
	* @return
	 */
	public Object inqueryTreeUser(TreeBean bean){
		return TreeBusinessDaoImpl.inqueryTreeUser(bean);
		 
	}
	/**
	 * 
	*<b>Summary: </b>
	* inqueryTreeReportOrganization(请用一句话描述这个方法的作用)
	* @param bean
	* @return
	 */
	public Object inqueryTreeReportOrganization(TreeBean bean){
		return TreeBusinessDaoImpl.inqueryTreeReportOrganization(bean);
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* selDataResources(查询数据资源数据)
	* @param bean
	* @return
	 */
	public Object selDataResources(TreeBean bean) {
		return TreeBusinessDaoImpl.selDataResources(bean);
		
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* selAllUserrTree(查询机构用户所有的树)
	* @param bean
	* @return
	 */
	public Object selAllUserrTree(TreeBean bean) {
		return TreeBusinessDaoImpl.selAllUserrTree(bean);
		
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* inqueryTreeOrganization(查询所有的单位树)
	* @param bean
	* @return
	 */
	public Object selAllUnit(TreeBean bean){
		return TreeBusinessDaoImpl.selAllUnit(bean);
	}
	
	/**
	 * 
	 *<b>Summary: </b>
	 * selMyUnit(查询用户所在单位，和单位下的所有部门)
	 * @param bean
	 * @return
	 */
	public Object selMyUnit(TreeBean bean){
		return TreeBusinessDaoImpl.selMyUnit(bean);
	}
	/**
	 * 
	*<b>Summary: </b>
	* batchSaveDateResources(保存资源配置)
	* @param bean
	* @return
	 */
	public Object batchSaveDateResources(TreeBean bean){
		return TreeBusinessDaoImpl.batchSaveDateResources(bean);
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* selUserSelectValue(查询用户选中的值)
	* @param bean
	* @return
	 */
	public Object selUserSelectValue(TreeBean bean){
		return TreeBusinessDaoImpl.selUserSelectValue(bean);
	}
	/**
	 * 
	*<b>Summary:查询档案存放位置 </b>
	* queryFileAddress()
	* @param bean
	* @return
	 */
	public Object queryFileAddress(TreeBean bean){
		return TreeBusinessDaoImpl.queryFileAddress(bean);
	}
	/**
	 * 
	*<b>Summary:查询档案类型</b>
	* queryFileAddress()
	* @param bean
	* @return
	 */
	public static Object queryFileType(TreeBean bean) {
		return TreeBusinessDaoImpl.queryFileType(bean);
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * queryUserGroup(查询用户组)
	 * @param bean
	 * @return
	 */
	public Object queryUserGroup(TreeBean bean){
		return TreeBusinessDaoImpl.queryUserGroup(bean);
	}
	
	
	/**
	*<b>Summary: </b>
	* inqueryTreePerson4Other(单位通讯录人员)
	* @param bean
	* @return 
	*/
	public Object inqueryTreePerson4Other(TreeBean bean){
		return TreeBusinessDaoImpl.inqueryTreePerson4Other(bean);
	}
	
	
	/**
	*<b>Summary: </b>
	* inqueryTreeGrtxl(个人通讯录)
	* @param bean
	* @return 
	*/
	public Object inqueryTreeGrtxl (TreeBean bean){
		return TreeBusinessDaoImpl.inqueryTreeGrtxl(bean);
	}
	
	
	/**
	*<b>Summary: </b>
	* publicinqueryTreeGrtxl(公共通讯录)
	* @param bean
	* @return 
	*/
	public Object publicinqueryTreeGrtxl (TreeBean bean){
		return TreeBusinessDaoImpl.publicinqueryTreeGrtxl(bean);
	}
	
	
	/**
	*<b>Summary: </b>
	* queryKbmDocTypeTree(知识分类树)
	* @param bean
	* @return 
	*/
	public static Object queryKbmDocTypeTree(TreeBean bean) {
			return TreeBusinessDaoImpl.queryKbmDocTypeTree(bean);
	}
	
	/**
	*<b>Summary: </b>
	* queryPsdataTypeTree(个人资料分类树)
	* @param bean
	* @return 
	*/
	public static Object queryPsdataTypeTree(TreeBean bean) {
			return TreeBusinessDaoImpl.queryPsdataTypeTree(bean);
	}
	/**
	*<b>Summary: </b>
	* queryPsdataTypeTree(资料分类树)
	* @param bean
	* @return 
	*/
	public static Object queryDataTypeTree(TreeBean bean) {
			return TreeBusinessDaoImpl.queryDataTypeTree(bean);
	}
	/**
	 * 
	 *<b>Summary: </b> inqueryTreeMeetingPerson(查询机构人员树)
	 * 
	 * @param bean
	 * @return
	 */
	public static Object inqueryTreeMeetingPerson(TreeBean bean){
		return TreeBusinessDaoImpl.inqueryTreeMeetingPerson(bean);
	}
	/**
	 * filetypeinfo.jsp专用
	 *<b>Summary: </b>
	 * queryParentFileTypeForUpdateFileType(查询可以修改的父级档案分类)
	 * @param bean
	 * @return
	 */
	public static Object queryParentFileTypeForUpdateFileType(TreeBean bean){
		return TreeBusinessDaoImpl.queryParentFileTypeForUpdateFileType(bean);
	}
	public static Object inqueryTreeFileTreeInOneProgramPage(TreeBean bean){
		return CommonTreeDaoImpl.inqueryTreeFileTreeInOneProgramPage(bean);
	}
	/**
	 * 
	*<b>Summary: 获取公文传输机构树</b>
	* queryGwcsOrgTree()
	* @param bean
	* @return
	 */
	public static Object queryGwcsOrgTree (TreeBean bean){
		return TreeBusinessDaoImpl.queryGwcsOrgTree(bean);
	}
	
	/**
	 * 发改委法律知识库树
	 */
	public static Object queryFgwKbmDocTypeTree(TreeBean bean) {
		return TreeBusinessDaoImpl.queryFgwKbmDocTypeTree(bean);
	}
	/**
	 * 办公用品类型分类树
	 * @return
	 */
	public static Object queryOfficeosupplietype(TreeBean bean){
		return TreeBusinessDaoImpl.queryOfficeosupplietype(bean);
	}
}
