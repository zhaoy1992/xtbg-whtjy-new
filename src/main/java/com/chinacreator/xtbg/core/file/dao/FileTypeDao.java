package com.chinacreator.xtbg.core.file.dao;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.file.entity.FileTypeBean;

/**
 * 
 *<p>Title:FileTypeDao.java</p>
 *<p>Description:档案分类数据访问接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Jul 16, 2013
 */
public interface FileTypeDao {
	/**
	 * 
	 *<b>Summary: </b>
	 * getFileTypeList(查询档案分类)
	 * @param parmjson
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean getFileTypeList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	/**
	 * 
	 *<b>Summary: </b>
	 * getFileTypeBeanById(通过beanId获得Map形式的行数据集合)
	 * @param conn
	 * @param beanId
	 * @return
	 * @throws Exception
	 */
	public Map<String, String> getFileTypeBeanById(Connection conn,
			String beanId) throws Exception;
	/**
	 * 
	 *<b>Summary: </b>
	 * getAllParentIdsAndNames(获得beanId和beanId所有父类别的id 和 name)
	 * @param conn
	 * @param beanId
	 * @return
	 * @throws Exception
	 */
	public Map<String, String> getAllParentIdsAndNames(Connection conn,
			String beanId) throws Exception;
	/**
	 * 
	 *<b>Summary: </b>
	 * getIsrecursionDataById(通过beanId向上获取可递归的数据,flag:true包括beanId,false:不包括beanId)
	 * @param conn
	 * @param beanId
	 * @param flag
	 * @return
	 * @throws Exception
	 */
	public Map<String, String[]> getIsrecursionDataById(Connection conn,String beanId,boolean flag)
		throws Exception;
	/**
	 * 
	 *<b>Summary: </b>
	 * updateChildrenDataByBean(修改bean的所有直接点的递归数据)
	 * @param bean
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean updateChildrenDataByBean(FileTypeBean bean,Connection conn)
		throws Exception;
	/**
	 * 
	 *<b>Summary: </b>
	 * deleteFileTypeBeansById(通过beanId删除以beanId节点为根节点的树结构数据上的所有FileTypeBean[包含beanId])
	 * @param conn
	 * @param beanId
	 * @return
	 * @throws Exception
	 */
	public boolean deleteFileTypeBeansById(Connection conn,String beanId)
		throws Exception;
	/**
	 * 
	 *<b>Summary: </b>
	 * getBKBAllParam(获得备考表参数集合)
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, String>> getBKBAllParam(Connection conn)
		throws Exception;
	/**
	 * 
	 *<b>Summary: </b>
	 * getBKBAllParam(获得备考表参数集合)
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, String>> getDHAllParam(Connection conn)
		throws Exception;
	/**
	 * 检查某用户访问某档案文件的权限
	 *<b>Summary: </b>
	 * checkFileTypeRoleOfUser
	 * @param userId
	 * @param fileDocBeanId
	 * @param conn
	 * @return Boolean[] 0:读权限;1:下载权限
	 */
	public Boolean[] checkFileTypeRoleOfUser(String userId,String fileDocBeanId,Connection conn);
	/**
	 * 检查某用户访问某档案文件的权限
	 *<b>Summary: </b>
	 * checkFileTypeRoleOfUser
	 * @param userId
	 * @param fileDocBeanId
	 * @param conn
	 * @return Boolean[] 0:读权限;1:下载权限
	 */
	public Boolean[] checkFileTypeRoleOfUserAboutLending(String userId,String fileDocBeanId,Connection conn);
	
	/**
	 * 
	 *<b>Summary: </b>
	 * checkChildrenNode(检查是否存在子节点)
	 * @param deleteArr
	 * @return
	 */
	public boolean checkChildrenNode(String[] deleteArr,Connection conn);
	/**
	 * 
	 *<b>Summary: </b>
	 * checkUsedData(检查节点是否已经被使用)
	 * @param deleteArr
	 * @return
	 */
	public boolean checkUsedData(String[] deleteArr,Connection conn);
	/**
	 * 
	 *<b>Summary: </b>
	 * updateChildrenDataFieldByBean(向下修改所有子节点的F_type_parentname,因为名字可能发生变化)
	 * @param bean
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean updateChildrenDataFieldByBean(FileTypeBean bean,Connection conn) throws Exception;
	/**
	 * 
	 *<b>Summary: </b>
	 * updateChildrenDataAFieldByBean(向下修改所有子节点的F_type_parentid,F_type_parentname,因为父节点可能发生变化)
	 * @param bean
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean updateChildrenDataAFieldByBean(FileTypeBean bean,Connection conn) throws Exception;
	/**
	 * 
	 *<b>Summary: </b>
	 * sortOrg(拖拽 排序)
	 * @param nodes
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean sortOrg(String nodes,Connection conn) throws Exception;
	
	public boolean updateLevelThreeType(String beanId,Connection conn) throws Exception;
	
	/**
	 * 
	 *<b>Summary: </b>
	 * jieshou(部门接收文件)
	 * @param ids
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean jieshou(String[] ids,Connection conn) throws Exception;
	
	/**
	 * 
	 *<b>Summary: </b>
	 * jieshou(部门接收文件)
	 * @param ids
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public boolean tuihui(String[] ids,Connection conn,String mess) throws Exception;
}
