package com.chinacreator.xtbg.core.file.service;

import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.file.entity.FilePurviewBean;
import com.chinacreator.xtbg.core.file.entity.FileTypeBean;

/**
 * 
 *<p>Title:FileTypeServiceIfc.java</p>
 *<p>Description:档案分类业务逻辑接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Jul 16, 2013
 */
public interface FileTypeServiceIfc {
	/**
	 * 
	 *<b>Summary: </b>
	 * getFileTypeBeanById(通过beanId获得FileTypeBean[Map<String, String>格式])
	 * @param beanId
	 * @return
	 */
	public Map<String, String> getFileTypeBeanById(String beanId);
	/**
	 * 
	 *<b>Summary: </b>
	 * insertOrUpdateFileTypeBean(添加或修改FileTypeBean)
	 * @param bean
	 * @return
	 */
	public String insertOrUpdateFileTypeBean(FileTypeBean bean);
	/**
	 * 
	 *<b>Summary: </b>
	 * getIsrecursionDataForInsert(通过parentId获得可递归到的数据for insert)
	 * @param parentId
	 * @return
	 */
	public FileTypeBean getIsrecursionDataForInsert(String parentId);
	/**
	 * 
	 *<b>Summary: </b>
	 * deleteFileTypeInfoByIds(通过beanId的数组批量删除FileTypeBean)
	 * @param beanIdArr
	 * @return
	 */
	public boolean deleteFileTypeInfoByIds(String[] beanIdArr);
	/**
	 * 
	 *<b>Summary: </b>
	 * insertOrUpdateFilePurviewBean(添加或修改FilePurviewBean)
	 * @param bean
	 * @return
	 */
	public boolean insertOrUpdateFilePurviewBean(FilePurviewBean bean);

	/**
	 * 
	 *<b>Summary: </b>
	 * deleteFilePurviewInfo(通过beanId的数组批量删除FilePurviewBean)
	 * @param beanIdArr
	 * @return
	 */
	public boolean deleteFilePurviewInfoByIds(String[] beanIdArr);
	/**
	 * 
	 *<b>Summary: </b>
	 * getMaxFilePurviewNum(获得密级数量)
	 * @return
	 */
	public int getMaxFilePurviewNum();
	/**
	 * 
	 *<b>Summary: </b>
	 * getFilePurviewBeanById(通过beanId获得FilePurviewBean[Map<String, String>格式])
	 * @param beanId
	 * @return
	 */
	public Map<String, String> getFilePurviewBeanById(String beanId);
	/**
	 * 
	 *<b>Summary: </b>
	 * getBKBParamForFileTypeBean(为档案分类信息编辑获取备考表参数列表)
	 * @return
	 */
	public List<Map<String, String>> getBKBParamForFileTypeBean();
	
	/**
	 * 
	 *<b>Summary: </b>
	 * checkFileTypeRoleOfUser(检查某用户访问某档案文件的权限)
	 * @param userId
	 * @param fileDocBeanId
	 * @return
	 */
	public Boolean[] checkFileTypeRoleOfUser(String userId,String fileDocBeanId);
	/**
	 * 
	 *<b>Summary: </b>
	 * getDADHParamForFileTypeBean(档案档号模板参数查询)
	 * @return
	 */
	public List<Map<String, String>> getDADHParamForFileTypeBean();
	/**
	 * 
	 *<b>Summary: </b>
	 * checkChildrenNode(检查是否存在子节点)
	 * @param deleteArr
	 * @return
	 */
	public boolean checkChildrenNode(String[] deleteArr);
	/**
	 * 
	 *<b>Summary: </b>
	 * checkUsedData(检查节点是否已经被使用)
	 * @param deleteArr
	 * @return
	 */
	public boolean checkUsedData(String[] deleteArr);
	
	public boolean sortOrg(String nodes);
}
