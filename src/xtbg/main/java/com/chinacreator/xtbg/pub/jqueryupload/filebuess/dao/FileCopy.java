package com.chinacreator.xtbg.pub.jqueryupload.filebuess.dao;

import java.util.Map;

import com.chinacreator.xtbg.pub.jqueryupload.filebuess.dao.impl.FiletransfersSysDaoImpl;

public abstract class FileCopy {
	protected FiletransfersSysDao filetransfersSysDao = new FiletransfersSysDaoImpl();
	
	/**
	 * 复制附件信息到其他数据表
	 * @param params 相关的数据参数
	 * @return 
	 */
	public abstract boolean copyOtherToFileBean(Map<String,String> params);
}
