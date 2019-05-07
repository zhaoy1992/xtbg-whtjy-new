package com.chinacreator.xtbg.pub.upload.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.pub.common.DataInfoImpl;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.jqueryupload.filebuess.dao.FiletransfersSysDao;
import com.chinacreator.xtbg.pub.upload.entity.FileSearchBean;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;

public class FileList implements DataInfoImpl{

	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(FileList.class);
	

	/**
	 * @Description  查询文件列表
	 * 
	 * @param request
	 * @param response
	 * @return  返回JOSNOBJECT
	 * @exception 
	 */
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		FileSearchBean fileSearchBean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			fileSearchBean = (FileSearchBean) JSONObject.parseObject(parmjson, FileSearchBean.class);
		}
		
		try {
			FiletransfersSysDao fsysdao = (FiletransfersSysDao)DaoImplClassUtil.getDaoImplClass("fileDaoImpl");
			pb = fsysdao.getFileInfoList(fileSearchBean.getBuessid(),fileSearchBean.getZj_id(),sortName, sortOrder,  offset,  maxPagesize);
			
		} catch (Exception e) {
			LOG.error(e);
		}
		return pb;
	}


	public PagingBean getDataList(String parmStr, String sortName, String sortOrder) {
		FileSearchBean fileSearchBean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmStr) ) {
			parmStr = DataControlUtil.replaceStr(parmStr);
			fileSearchBean = (FileSearchBean) JSONObject.parseObject(parmStr, FileSearchBean.class);
		}
		
		try {
			FiletransfersSysDao fsysdao = (FiletransfersSysDao)DaoImplClassUtil.getDaoImplClass("fileDaoImpl");
			pb = fsysdao.getFileInfoList(fileSearchBean.getBuessid(),fileSearchBean.getZj_id());
			
		} catch (Exception e) {
			LOG.error(e);
		}
		return pb;
	}


	
}
