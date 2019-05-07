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
import com.chinacreator.xtbg.core.file.dao.FileDestroyDao;

/**
 *<p>Title:FileInventoryExport.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 任涛
 *@version 1.0
 *2013-8-23
 */
public class FileInventoryExport extends ExportBean{
	private static final Logger LOG = Logger.getLogger(FileInventoryExport.class);
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
		list.add("f_file_no");
		list.add("f_doc_num");
		list.add("f_doc_name");
		list.add("f_check_username");
		list.add("f_destroy_time");
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
		list.add("档号");
		list.add("文件编号");
		list.add("标题");
		list.add("批准人");
		list.add("销毁日期");
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
			FileDestroyDao dao = (FileDestroyDao)LoadSpringContext.getApplicationContext().getBean("fileDestroyDaoImpl");
			FileDestroyDetalBean model = new FileDestroyDetalBean();
		    model = (FileDestroyDetalBean)RequestBeanUtils.getValuesByRequest(request,model);
		    PagingBean pb = dao.queryFileInventoryList(model, sortName, sortOrder, offset, maxPagesize);
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
		return "销毁清册";
	}

}
