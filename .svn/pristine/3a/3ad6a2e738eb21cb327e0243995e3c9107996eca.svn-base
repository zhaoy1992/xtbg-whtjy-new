package com.chinacreator.xtbg.core.file.entity;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.file.service.impl.FileFilesDevolveServiceImpl;
/**
 * 档案移交导出-配置文件
 *<p>Title:FileDocExportBean.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Aug 16, 2013
 */
public class FileFilesDevolveExportBean extends ExportBean{
	
	private static final Logger LOG = Logger.getLogger(FileFilesDevolveExportBean.class);
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 getFieldName
	 * @return 
	 * @see com.chinacreator.xtbg.core.file.entity.ExportBean#getFieldName()
	 */
	@Override
	public List<String> getFieldName() {
		List<String> list = new ArrayList<String>();
		list.add("f_fondsno");
		list.add("f_listno");
		list.add("f_filesno");
		list.add("f_type_name");
		list.add("f_files_no");
		list.add("f_start_end_time");
		list.add("f_page_num");
		list.add("f_doc_deadline_name");
		//list.add("f_files_content");
		return list;
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 getColTitleNames
	 * @return 
	 * @see com.chinacreator.xtbg.core.file.entity.ExportBean#getColTitleNames()
	 */
	@Override
	public List<String> getColTitleNames() {
		List<String> list = new ArrayList<String>();
		list.add("全宗号");
		list.add("目录号");
		list.add("卷号");
		list.add("类别");
		list.add("案卷档号");
		list.add("起止时间");
		list.add("页数");
		list.add("保管期限");
		return list;
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 getData
	 * @param request
	 * @param response
	 * @return 
	 * @see com.chinacreator.xtbg.core.file.entity.ExportBean#getData(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	@Override
	public List<Map<String, String>> getData(HttpServletRequest request,
			HttpServletResponse response) {
		//String sortName = request.getParameter("sidx");
	    //String sortOrder = request.getParameter("sord");
	    String beanId = request.getParameter("beanId");
		try {
			FileFilesDevolveServiceImpl s = new FileFilesDevolveServiceImpl();
			return s.getDetailBeanListForExport(beanId);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		return new ArrayList<Map<String, String>>();
	}
	/**
	 * 设置宽度
	 */
	@Override
	public Integer[] getColSize() {
		return new Integer[]{10,10,10,30,30,30,10,10};
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 getTitleName
	 * @return 
	 * @see com.chinacreator.xtbg.core.file.entity.ExportBean#getTitleName()
	 */
	@Override
	public String getTitleName() {
		return "案卷移交清单";
	}
}
