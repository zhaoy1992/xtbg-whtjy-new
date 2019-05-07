package com.chinacreator.xtbg.pub.tree.service.impl;


//import com.chinacreator.xtbg.directory.dao.imploracle.DirectoryDaoImpl;
//import com.chinacreator.xtbg.directory.entity.DirectoryBean;
import com.chinacreator.xtbg.pub.tree.dao.impl.TreeBusinessDaoImpl;
import com.chinacreator.xtbg.pub.tree.entity.TreeBean;

public class TreeBusinessService {
	/**
	 * 缓存控制
	 */
	public Object inqueryTreeOtherResources(TreeBean bean){
		return TreeBusinessDaoImpl.inqueryTreeOtherResources(bean);
	}
	
	public Object inqueryTreePurview(TreeBean bean){
		return TreeBusinessDaoImpl.inqueryTreePurview(bean);
	}
	
	public Object inqueryTreeOrganization(TreeBean bean){
		return TreeBusinessDaoImpl.inqueryTreeOrganization(bean);
	}
	
	public Object inqueryTreePerson(TreeBean bean){
		return TreeBusinessDaoImpl.inqueryTreePerson(bean);
		 
	}
	public Object publicinqueryTreeGrtxl(TreeBean bean){
		return TreeBusinessDaoImpl.publicinqueryTreeGrtxl(bean);
		
	}
	public Object inqueryTreeGrtxl(TreeBean bean){
		return TreeBusinessDaoImpl.inqueryTreeGrtxl(bean);
		
	}
	public Object inqueryPersonSelectValue(TreeBean bean){
		return TreeBusinessDaoImpl.inqueryPersonSelectValue(bean);
	}
	
	public Object batchSave(TreeBean bean){
		return TreeBusinessDaoImpl.batchSave(bean);
	}
	
	public Object inqueryTreeReportPerson(TreeBean bean){
		return TreeBusinessDaoImpl.inqueryTreeReportPerson(bean);
	}
	
	public Object inqueryTreeReportOrganization(TreeBean bean){
		return TreeBusinessDaoImpl.inqueryTreeReportOrganization(bean);
	}
	
	public Object inqueryTreeReportAUNIT(TreeBean bean){
		return TreeBusinessDaoImpl.inqueryTreeReportUNIT(bean);
	}
	//add by 李星  当机构数加载出来时，点击确定后只选择叶子节点机构
	public Object inqueryTreeReportOrganizationChild(TreeBean bean){
		return TreeBusinessDaoImpl.inqueryTreeReportOrganizationChild(bean);
	}
	public Object inqueryTreeUserByRange(TreeBean bean){
		return TreeBusinessDaoImpl.inqueryTreeReportOrganization(bean);
	}
	
//	public Object insertUserOrderBy(TreeBean bean){
//		Map<String,String> req =bean.getRequestMap();
//		return DirectoryDaoImpl.insertUserOrderBy(req.get("orgid"), req.get("userids"), req.get("orderBys"));
//	}
//	
//	public Object findTypeList(TreeBean bean) throws Exception{
//		Map<String,String> req =bean.getRequestMap();
//		Object resp = "'none'";
//		DirectoryDaoImpl imp = new DirectoryDaoImpl();
//		DirectoryBean typeBean = new DirectoryBean();
//		typeBean.setOrgid(req.get("orgid"));
//		PagingBean ss = imp.findTypeList(typeBean, "", "", 0, -1);
//		resp = ss.getList();
//		return resp;
//	}
	
	public Object inqueryTreeBriefs(TreeBean bean){
		return TreeBusinessDaoImpl.inqueryTreeBriefs(bean);
	}
	
	public Object inqueryTreeShowType(TreeBean bean){	
		return TreeBusinessDaoImpl.inqueryTreeShowType(bean);
	}
	/**
	 * 
	*<b>Summary:望城短信发送的个性化的机构树</b>
	* inqueryTreePersonForSmsSend()
	* @param bean
	* @return
	 */
	public Object inqueryTreePersonForSmsSend(TreeBean bean){	
		return TreeBusinessDaoImpl.inqueryTreePersonForSmsSend(bean);
	}
	/**
	 * 
	*<b>Summary: 望城短信中的外部单位树</b>
	* inqueryTreeGrtxlForOut()
	* @param bean
	* @return
	 */
	public Object inqueryTreeGrtxlForOut(TreeBean bean){	
		return TreeBusinessDaoImpl.inqueryTreeGrtxlForOut(bean);
	}
	
	public Object queryTop10(TreeBean bean){
		return TreeBusinessDaoImpl.queryTop10(bean);
	}
	
//	public Object inqueryBriefs(TreeBean bean){
//		return BriefsEditorDaoImpl.inqueryBriefs(bean);
//	}
}
