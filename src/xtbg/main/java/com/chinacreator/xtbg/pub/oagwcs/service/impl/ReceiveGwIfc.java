package com.chinacreator.xtbg.pub.oagwcs.service.impl;

import javax.jws.WebService;

@WebService
public interface ReceiveGwIfc {
	/**
	*<b>Summary: </b>
	* gwcsOrgSyn(解析电子公文传输系统传送过来的地址本数据，并返回处理结果给电子公文传输系统)
	* @param type	地址本xml文件类型,0：地址本初始化xml文件;1：地址本单条或多条更新xml文件
	* @param content 地址本 xml文件，转换为byte[]
	* @return 处理过程无异常返回0否则返回1
	*/
	public String gwcsOrgSyn(int type,byte[] content);
	
	public String resciveGw(String filenames, byte[] content);

}
