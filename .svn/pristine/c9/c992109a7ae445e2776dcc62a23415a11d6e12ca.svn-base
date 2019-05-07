package com.chinacreator.xtbg.core.archive.common;

import java.util.List;

import com.chinacreator.xtbg.core.archive.entity.ExcelBean;

/**
 *<p>Title:SplitExcel.java</p>
 *<p>Description:文件拆分接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *2014-4-16
 */
public interface SplitExcel {
	/**
	*<b>Summary:初始化数据</b>
	* init()
	* @param startNum
	 */
	public void init(int startNum);
	
	/**
	*<b>Summary: 拆分前操作</b>
	* beforSplit()
	* @return
	 */
	public List<ExcelBean> beforSplit(String filename) throws Exception ;
	
	/**
	*<b>Summary: 拆分中</b>
	* spliting()
	* @return
	 */
	public ExcelBean spliting(String sourceUrl,ExcelBean bean) throws Exception ;
	/**
	*<b>Summary: 拆分后</b>
	* afterSplit()
	* @return
	 */
	public ExcelBean afterSplit() throws Exception ;
	
	/**
	*<b>Summary: 拆分</b>
	* split()
	* @param startNum
	* @param sourceFilePath
	* @return
	 */
	public List<ExcelBean> split(int startNum,String sourceFilePath) throws Exception ;
}
