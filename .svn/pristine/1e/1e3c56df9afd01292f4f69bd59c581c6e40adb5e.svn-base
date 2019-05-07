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
import com.chinacreator.xtbg.core.file.dao.FileFilesQueryDao;
/**
 * 光盘文件导出-配置文件
 *<p>Title:FileDocPhotoExportBean.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Aug 16, 2013
 */
@SuppressWarnings("unchecked")
public class FileFilesQueryByDeptExportBean extends ExportBean{
	
	private static final Logger LOG = Logger.getLogger(FileFilesQueryByDeptExportBean.class);
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
		list.add("f_filesno");
		list.add("f_doc_year");
		list.add("f_files_no");
		list.add("f_doc_deadline_name");
		list.add("f_secrecy_name");
		list.add("f_file_time");
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
		list.add("案卷号");
		list.add("档案年份");
		list.add("档号");
		list.add("保管期限");
		list.add("密级");
		list.add("归档日期");
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
		String sortName = "f_filesno";
	    String sortOrder = "asc";
	    long offset = 0;
	    int maxPagesize = 10000;
		try {
			//导出copy查询FileFilesQueryByDeptList.getDataList
			FileFilesBean bean = new FileFilesBean();
			bean = (FileFilesBean)RequestBeanUtils.getValuesByRequest(request,bean);
			FileFilesQueryDao dao = (FileFilesQueryDao)LoadSpringContext.getApplicationContext().getBean("FileFilesQueryDaoImpl");
			PagingBean pb = dao.queryFileFilesListByDept(bean, sortName, sortOrder, offset, maxPagesize);
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
		return "档案查询(分部门)";
	}
}
