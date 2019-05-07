package com.chinacreator.xtbg.core.file.entity;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/**
 * 配合exportexcel.jsp做导出,只支持单个sheet1导出
 *<p>Title:ExportBean.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Aug 16, 2013
 */
public abstract class ExportBean {
	/**
	 *
	 *<b>Summary: </b>
	 * getData(获得数据)
	 * @return
	 */
	public abstract List<Map<String,String>> getData(HttpServletRequest request,HttpServletResponse response);
	/**
	 *
	 *<b>Summary: </b>
	 * getData(获得col标题)
	 * @return
	 */
	public abstract List<String> getColTitleNames();
	/**
	 * 
	 *<b>Summary: </b>
	 * getTitleName(获得标题)
	 * @return
	 */
	public abstract String getTitleName();
	/**
	 *
	 *<b>Summary: </b>
	 * getData(获得字段名)
	 * @return
	 */
	public abstract List<String> getFieldName();
	
	/**
	 * 获得列的宽度设置
	 * 防止改动太大 没设置成abstract方法
	 */
	public Integer[] getColSize(){
		return null;
	}
}
