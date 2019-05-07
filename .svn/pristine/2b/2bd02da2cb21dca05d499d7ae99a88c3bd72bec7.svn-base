package com.chinacreator.xtbg.core.common.fancyuoload.service;

import java.io.InputStream;
import java.sql.SQLException;
import java.util.List;

import com.chinacreator.xtbg.core.common.fancyuoload.dao.FiletransfersSysDao;
import com.chinacreator.xtbg.core.common.fancyuoload.dao.impl.FiletransfersSysDaoImpl;
import com.chinacreator.xtbg.core.common.fancyuoload.entity.FileInfoBean;
import com.frameworkset.common.poolman.PreparedDBUtil;


/**
 *<p>Title:FiletransferService.java</p>
 *<p>Description:文件保存业务处理</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author steven.zhu
 *@version 1.0
 *2011-07-06
 */
public abstract class FiletransferService {
	/**
	*<b>Summary: </b>
	* saveFile(保存文件信息 到数据库中)
	* @param listFileInfoBean文件信息列表
	* @return
	*/
	public abstract boolean saveFile(List<FileInfoBean>  listFileInfoBean);
	
	/**
	*<b>Summary: </b>
	* uploadFileToServer(上传附件文件到服务器的路径中)
	* @param FilePath
	* @param listFileInfoBean
	* @return
	*/
	public abstract String[] uploadFileToServer(String FilePath,List<FileInfoBean> listFileInfoBean) throws Exception;
	/**
	*<b>Summary: </b>
	* uploadFileToServer(上传附件文件到服务器的路径中)
	* @param FilePath
	* @param listFileInfoBean
	* @return
	*/
	public abstract boolean uploadFileToServer(String FilePath,FileInfoBean bean) throws Exception;
	/**
	 * 
	*<b>Summary: 上传文件到服务器</b>
	* uploadFileToServer()
	* @param descFile 写入的文件名
	* @param instream 文件流
	* @param convertToTif 是否将文件转换为tif格式  true：是, false: 否
	* @param convertToJpg 是否将上传的文件转换为jpg格式
	* @return 是否写入成功
	* @throws Exception
	 */
	public abstract boolean uploadFileToServer(String descFile, InputStream instream,Boolean convertToTif,Boolean convertToJpg) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* uploadFileToServerConvertToTif(上传文件到服务器的路径中，并将文件转换为tif文件)
	* @param FilePath
	* @param listFileInfoBean
	* @return
	* @throws Exception
	 */
	public abstract String[] uploadFileToServerConvertToTif(String FilePath,List<FileInfoBean> listFileInfoBean) throws Exception;

	/**
	 * 根据djbh将数据库中的文件复制到服务器路径中去
	 * @param FilePath
	 * @param djbh
	 * @return
	 */
	public abstract String[] copyDBFileToServerByDjBh(String FilePath,String djbh);
	
	/**
	 * 获取attachId
	 * @return
	 * @throws Exception
	 */
	public String getAttachId() throws Exception{
		StringBuffer sb = new StringBuffer();
		PreparedDBUtil pdb = new PreparedDBUtil();
		sb.append("select 'UPF'||lpad(t.recnum,8,0) attachid from fc_maxbh t where t.biaoshi='UPF'");
		pdb.executeSelect(sb.toString());
		String attachid ="";
		if(pdb.size() > 0){
			attachid = pdb.getString(0, "attachid");
		}
		sb.setLength(0);
		sb.append("update fc_maxbh t set t.recnum=t.recnum+1 where t.biaoshi='UPF'");
		pdb.executeUpdate(sb.toString());
		return attachid;
	}
	
	/**
	 * 
	 *<b>Summary: </b>
	 * updateAttachUrl(补充附件存储的名称)
	 * @param fib
	 * @throws SQLException 
	 */
	public void updateAttachUrl(FileInfoBean fib) throws SQLException {
		StringBuffer sb = new StringBuffer();
		PreparedDBUtil pdb = new PreparedDBUtil();
		sb.append("update oa_fc_attach set filepos = '"+fib.getFilepos()+"' where djsn = '"+fib.getDjsn()+"'");
		pdb.executeUpdate(sb.toString());
		
	}

	/**
	 * 数据需要 添加到 数据库 和磁盘中，而 request中的流只能读取一次。所以需要通过查询数据库 在存储一次
	 *<b>Summary: </b>
	 * copyFileFromDBToServer(将存储到数据库的文件，转存到服务器磁盘)
	 * @param baseUrl
	 * @param listFileInfoBean
	 * @throws Exception 
	 */
	public void copyFileFromDBToServer(String baseUrl,
			List<FileInfoBean> listFileInfoBean) throws Exception {
		FiletransfersSysDao ft = new FiletransfersSysDaoImpl();
		for(FileInfoBean fib : listFileInfoBean){
			fib = ft.getFileByDjsn(fib.getDjsn());
			this.uploadFileToServer(baseUrl, fib);
		}
		
		
	}
}
