package com.chinacreator.xtbg.core.subsystemmanage.service;

import java.util.Map;

import com.chinacreator.xtbg.core.subsystemmanage.entity.GwcsOrgMappingBean;
import com.chinacreator.xtbg.core.subsystemmanage.entity.OaGwcsConfigBean;
import com.chinacreator.xtbg.core.subsystemmanage.entity.SubsysManageBean;
import com.chinacreator.xtbg.core.subsystemmanage.entity.SubsysUseInfoBean;
import com.chinacreator.xtbg.core.subsystemmanage.entity.SubsysUserImportBean;

public interface SubSystemServiceIfc {
	/**
	 * 插入子系统管理信息
	 * @param regulationsTypeBean
	 * @throws Exception
	 */
	public boolean saveSubSystemManage(SubsysManageBean subsysManageBean);

	/**
	 * 插入子系统使用情况信息
	 * @param regulationsTypeBean
	 * @throws Exception
	 */
	public Map<String,Object> saveSubSystemUseInfo(SubsysUseInfoBean subsysUseInfoBean);
	
	/**
	 * 插入子系统机构映射信息
	 * @param regulationsTypeBean
	 * @throws Exception
	 */
	public Map<String,Object> saveSubSystemOrgMappingInfo(GwcsOrgMappingBean gwcsOrgMappingBean);
	
	/**
	 * 删除子系统管理信息
	 * @param regulationsTypeBean
	 * @throws Exception
	 */
	public boolean deleteSubSystemManage(String sysids);
	
	/**
	 * 删除子系统使用情况信息
	 * @param regulationsTypeBean
	 * @throws Exception
	 */
	public boolean deleteSubSystemUseInfo(String infos);
	
	/**
	*<b>Summary: </b>
	* importUserInfoExcel2DB(把导入的用户信息插入到指定的子系统表中)
	* @param subsysUserImportBean
	* @return
	 */
	public String importUserInfoExcel2DB(SubsysUserImportBean subsysUserImportBean);
	
	/**
	 * 
	*<b>Summary: </b>
	* saveOaGwcsConfigInfo(插入公文，OA机构配置信息)
	* @param oaGwcsConfigBean
	* @return
	 */
	public Map<String,Object> saveOaGwcsConfigInfo(OaGwcsConfigBean oaGwcsConfigBean);
	
	/**
	 * 
	*<b>Summary: </b>
	* delOrgConfig(删除公文传输配置)
	* @param ids
	* @return
	 */
	public boolean delOrgConfig(String ids);
}
