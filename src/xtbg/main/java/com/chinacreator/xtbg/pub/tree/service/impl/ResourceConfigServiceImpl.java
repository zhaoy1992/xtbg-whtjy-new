package com.chinacreator.xtbg.pub.tree.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.RollbackException;

import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.pub.tree.entity.ResourceConfigBean;
import com.chinacreator.xtbg.pub.tree.dao.ResourceConfigDao;
import com.chinacreator.xtbg.pub.tree.entity.TreeBean;
import com.chinacreator.xtbg.pub.tree.service.ResourceConfigServiceIfc;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.frameworkset.orm.transaction.TransactionManager;

public class ResourceConfigServiceImpl implements ResourceConfigServiceIfc{

	@Override
	public Object delResourceConfig(TreeBean treeBean) {
		try {
			ResourceConfigBean resourceConfigBean = new ResourceConfigBean();
			resourceConfigBean.setResources_id(treeBean.getRequestMap().get("resource_ids"));
			resourceConfigBean.setResources_configtypeid(treeBean.getRequestMap().get("orgId"));
			ResourceConfigDao resourceConfigDao = (ResourceConfigDao) DaoImplClassUtil.getDaoImplClass("resourceConfigDaoImpl");

			resourceConfigDao.delResourceConfig(resourceConfigBean);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 1;
		
	}

	@Override
	public Object insertResourceConfigBatch(TreeBean treeBean) {
		TransactionManager tm = new TransactionManager();
		try {
			tm.begin();
			
			String boxvalue = treeBean.getRequestMap().get("boxvalue");
			String orgId = treeBean.getRequestMap().get("orgId");
			
			ResourceConfigDao resourceConfigDao = (ResourceConfigDao) DaoImplClassUtil.getDaoImplClass("resourceConfigDaoImpl");

			// 还原转义
			if (!StringUtil.isBlank(boxvalue))
			{
				boxvalue = DataControlUtil.replaceStr(boxvalue);
				boxvalue = Escape.unescape(boxvalue);
			}
			if (!StringUtil.isBlank(orgId))
			{
				orgId = DataControlUtil.replaceStr(orgId);
				orgId = Escape.unescape(orgId);
			}
			// 数据分离     boxvalue拼装格式为     资源id@用户id,用户id-资源id@用户id,用户id    类似于     25@330,374-37@331,369-38@334,344-46@340,343  
			if (!"".equals(boxvalue))
			{
				String boxvalueArray[] = boxvalue.split("[\\-]");//第一层通过"-"的标示符分离出每个资源各自的数据段
				for (int i = 0; i < boxvalueArray.length; i++)
				{
					String cboxvalue[] = boxvalueArray[i].split("[\\@]");//第二层通过"@"的标示符分离出资源id和用户id拼接串
					ResourceConfigBean resourceConfigBean = new ResourceConfigBean();
					resourceConfigBean.setResources_configtypeid(orgId);
					resourceConfigBean.setResources_id(cboxvalue[0]);//资源id
					resourceConfigDao.delResourceConfig(resourceConfigBean);
					if(cboxvalue.length > 1){
						resourceConfigDao.insertResourceConfig(resourceConfigBean, cboxvalue[1], "2");
					}
				}
			}	

			tm.commit();
		} catch (Exception e) {
			try {
				tm.rollback();
			} catch (RollbackException e1) {
			}
		}
		return 1;
		
	}
	
	/**
	 * 机构配置管理查询资源
	 */
	@Override
	public List<ResourceConfigBean> queryRescource()
	{
		List<ResourceConfigBean> list = new ArrayList<ResourceConfigBean>();
		try
		{
			ResourceConfigDao resourceConfigDao = (ResourceConfigDao) DaoImplClassUtil.getDaoImplClass("resourceConfigDaoImpl");
			list = resourceConfigDao.queryResource();
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		return list;
	}
	
	/**
	 * 查询每个机构下人员
	 * 
	 * @return list
	 */
	@Override
	public List<ResourceConfigBean> queryUserId(String orgId)
	{
		List<ResourceConfigBean> list = new ArrayList<ResourceConfigBean>();
		try
		{
			ResourceConfigDao resourceConfigDao = (ResourceConfigDao) DaoImplClassUtil.getDaoImplClass("resourceConfigDaoImpl");
			list = resourceConfigDao.queryOrgUser(orgId);
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		return list;

	}
	
	/**
	 * 机构配置回选
	 */
	public List<String> backchoose(List<String> resourceIdList, String orgId)
	{
		List<String> boxlist = new ArrayList<String>();
		try
		{
			ResourceConfigDao resourceConfigDao = (ResourceConfigDao) DaoImplClassUtil.getDaoImplClass("resourceConfigDaoImpl");
			for (int i = 0; i < resourceIdList.size(); i++)
			{
				List<String> useridList = new ArrayList<String>();
				useridList = resourceConfigDao.querybackchoose(resourceIdList.get(i), orgId);
				for (int j = 0; j < useridList.size(); j++)
				{
					String boxId = useridList.get(j) + resourceIdList.get(i);
					boxlist.add(boxId);
				}
			}
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		return boxlist;
	}

}
