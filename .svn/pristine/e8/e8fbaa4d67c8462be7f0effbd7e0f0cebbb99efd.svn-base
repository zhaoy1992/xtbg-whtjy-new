package com.chinacreator.xtbg.pub.jqueryupload.filebuess.service;

import java.util.List;

import com.chinacreator.xtbg.pub.jqueryupload.filebuess.entity.FileInfoBean;
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
	 * 保存文件信息
	 * @param listFileInfoBean 文件信息列表
	 */
	public abstract boolean saveFile(List<FileInfoBean>  listFileInfoBean);
	
	/**
	 * 上传附件文件到服务器的路径中
	 * @param FilePath
	 * @param listFileInfoBean
	 * @return
	 */
	public abstract String[] uploadFileToServer(String FilePath,List<FileInfoBean> listFileInfoBean);
	
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
}
