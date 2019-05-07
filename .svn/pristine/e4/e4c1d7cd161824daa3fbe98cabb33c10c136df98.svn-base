package com.chinacreator.xtbg.pub.tree.service;

import java.util.List;

import com.chinacreator.xtbg.pub.tree.entity.ResourceConfigBean;
import com.chinacreator.xtbg.pub.tree.entity.TreeBean;


public interface ResourceConfigServiceIfc {
	/**
	 * @Description  删除资源配置信息
	 * 
	 * @param ResourceConfigBean
	 * resources_id 资源ID
	 * resources_configtypeid  用户ID (单个或多个)
	 * configType 配置类型  3:批量配置,2:单个配置
	 * @return  空
	 * @exception 异常说明
	 */
	public Object delResourceConfig(TreeBean treeBean);
	
	
	/**
	 * insertResourceConfig 插入资源配置信息
	 * 
	 * @param ResourceConfigBean
	 * resources_id 资源ID
	 * resources_configtypeid  用户ID (单个或多个)
	 * configType 配置类型  3:批量配置,2:单个配置
	 * configContent 配置的内容
	 * configType 配置类型   1：单位,2:人员,3..
	 */
	public Object insertResourceConfigBatch(TreeBean treeBean);
	
	
	/**
	 * 机构配置管理查询资源
	 */
	List<ResourceConfigBean> queryRescource();
	
	
	/**
	 * 查询每个机构下人员
	 * @return list
	 */
	List<ResourceConfigBean> queryUserId(String orgId);
	
	/**
	 * 机构配置回选
	 */
	List<String> backchoose(List<String> resourceIdList,String orgId);
}
