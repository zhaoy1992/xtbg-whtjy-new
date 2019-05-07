package com.chinacreator.xtbg.core.common.fancyuoload.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import com.chinacreator.xtbg.core.common.fancyuoload.entity.FileInfoBean;


/**
 *<p>Title:filetranserSystemDao.java</p>
 *<p>Description:附件上传操作</p>
 *<p>Copyright:Copyright (c) 2011</p>
 *<p>Company:湖南科创</p>
 *@author steven.zhu
 *@version 1.0
 *2011-07-06
 */
public interface FiletransfersSysDao {
	
	/**
	*<b>Summary: </b>
	* saveFile(保存文件基本信息到数据库中)
	* @param conn
	* @param listFileInfoBean 文件基本信息
	* @return
	* @throws SQLException
	*/
	public boolean saveFile(Connection conn, List<FileInfoBean> listFileInfoBean) throws SQLException;
	/**
	 * 
	 *<b>Summary: </b>
	 * saveFile(保存文件基本信息到数据库中)
	 * @param conn
	 * @param listFileInfoBean
	 * @param type type:"stream":附件内容放在inputstream中
	 * @return
	 * @throws SQLException
	 */
	public boolean saveFile(Connection conn, List<FileInfoBean> listFileInfoBean,String type) throws SQLException;

	/**
	 * 
	 *<b>Summary: </b>
	 * delFileOnSeverById(通过ID删除File)
	 * @param fileId
	 * @return
	 * @throws Exception
	 */
	public boolean delFileOnSeverById(FileInfoBean bean) throws Exception;

	/**
	*<b>Summary: </b>
	* delFileByDjsn(根据文件唯一编号进行数据库文件删除)
	* @param conn
	* @param djsn
	* @return
	* @throws SQLException
	 */
	public boolean delFileByDjsn(Connection conn,String djsn) throws SQLException;
	
	/**
	*<b>Summary: </b>
	* delFileByDjbh(根据业务id删除业务相关的所有附件信息)
	* @param conn
	* @param djbh
	* @return
	* @throws SQLException
	 */
	public boolean delFileByDjbh(Connection conn,String djbh) throws SQLException;
	

	/**
	*<b>Summary: </b>
	* getFileInfoBeanlist(根据业务id查询出所有的文件信息)
	* @param djbh
	* @return
	* @throws SQLException
	 */
	public List<FileInfoBean> getFileInfoBeanlist(String djbh) throws SQLException;

	/**
	*<b>Summary: </b>
	* getFileCountByDjbh(获取业务相关附件的个数)
	* @param djbh
	* @return
	* @throws SQLException
	*/
	public String getFileCountByDjbh(String djbh) throws SQLException;

	/**
	*<b>Summary: </b>
	* getFileByDjsn(根据文件唯一编号查询文件相关信息)
	* @param djsn
	* @return
	* @throws Exception
	*/
	public FileInfoBean getFileByDjsn(String djsn) throws Exception;
	/**
	 * 人员持证特有
	 * @param djsn
	 * @return
	 * @throws Exception
	 */
	public FileInfoBean getFileByDjsn2(String djsn) throws Exception;


	/**
	*<b>Summary: </b>
	* copyFileInfo(复制文件信息)
	* @param newDjsn
	* @param oldDjsn
	* @return
	 */
	public boolean copyFileInfo(String newDjsn, String oldDjsn)throws SQLException;
	/**
	 * 保证一个文件一个附件
	 * @param djbh
	 * @param djsn
	 * @return
	 * @throws SQLException
	 */
	public boolean del(String djbh,String djsn,Connection conn)throws SQLException;
	
	public List<FileInfoBean> getFileInfoBeanlist(String djbh,String djsn) throws SQLException;

}
