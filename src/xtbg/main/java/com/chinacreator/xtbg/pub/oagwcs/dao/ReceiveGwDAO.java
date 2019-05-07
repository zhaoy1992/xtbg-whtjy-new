package com.chinacreator.xtbg.pub.oagwcs.dao;

import java.util.List;

import com.chinacreator.xtbg.pub.oagwcs.entity.FileInfoBean;
import com.chinacreator.xtbg.pub.oagwcs.entity.GwreceiveBean;
import com.chinacreator.xtbg.pub.oagwcs.entity.OctlDocumentBean;

/**
 *<p>Title:</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南科创</p>
 *@author yiping.huang
 *@version 1.0
 *@date 2012-7-3
 */
public interface ReceiveGwDAO {

	/**
	 * 保存公文基本信息
	 * @param gwreceiveBean
	 * @return
	 */
	public void saveGwReceiveInfo(GwreceiveBean gwreceiveBean) throws Exception;
	
	/**
	 * 保存word信息
	 * @param 
	 * @param 
	 * @return
	 */
	public void saveGwReceiveWord(OctlDocumentBean octlDocumentBean) throws Exception;
	
	/**
	 * 保存附件信息
	 * @param 
	 * @param 
	 * @return
	 */
	public void saveGwReceiveAttach(List<FileInfoBean> fileInfoBeanList) throws Exception;
}
