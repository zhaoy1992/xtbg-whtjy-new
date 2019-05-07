package com.chinacreator.xtbg.core.file.entity;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.RequestBeanUtils;
import com.chinacreator.xtbg.core.file.dao.FileDocDao;
/**
 * 文书文件导出-配置文件
 *<p>Title:FileDocExportBean.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Aug 16, 2013
 */
@SuppressWarnings("unchecked")
public class FileDocExportBean extends ExportBean{
	
	private static final Logger LOG = Logger.getLogger(FileDocExportBean.class);
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
		list.add("f_doc_num");
		list.add("f_attach_id");
		list.add("f_doc_fontsize");
		list.add("f_doc_name");
		list.add("f_doc_state_name");
		list.add("f_dept_name");
		list.add("f_file_formtime");
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
		list.add("件号");
		list.add("附件");
		list.add("文号");
		list.add("文件标题");
		list.add("归档状态");
		list.add("所属部门");
		list.add("文件形成日期");
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
		String sortName = request.getParameter("sidx");
	    String sortOrder = request.getParameter("sord");
	    long offset = 0;
	    int maxPagesize = 10000;
		try {
			FileDocDao dao = (FileDocDao)LoadSpringContext.getApplicationContext().getBean("fileDocDaoImpl");
			FileDocBean model = new FileDocBean();
		    model = (FileDocBean)RequestBeanUtils.getValuesByRequest(request,model);
		    PagingBean pb = dao.queryFileDocList(model, sortName, sortOrder, offset, maxPagesize);
			return (List<Map<String,String>>) pb.getList();
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		return new ArrayList<Map<String, String>>();
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
		return "文书档案";
	}
}
