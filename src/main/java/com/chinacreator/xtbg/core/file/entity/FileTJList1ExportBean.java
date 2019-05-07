package com.chinacreator.xtbg.core.file.entity;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.util.RequestBeanUtils;
import com.chinacreator.xtbg.core.file.dao.FileTJDao;
import com.chinacreator.xtbg.core.file.dao.imploracle.FileTJDaoImpl;
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
public class FileTJList1ExportBean extends ExportBean{
	
	private static final Logger LOG = Logger.getLogger(FileTJList1ExportBean.class);
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
		list.add("f_type_name");
		list.add("aa");
		list.add("a");
		list.add("b");
		list.add("c");
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
		list.add("档案分类");
		list.add("文档数");
		list.add("阅读人数");
		list.add("借阅次数");
		list.add("其中：外单位借阅次数");
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
			
			FileDocBean model = new FileDocBean();
		    model = (FileDocBean)RequestBeanUtils.getValuesByRequest(request,model);
		    FileTJDao dao = new FileTJDaoImpl();
		    PagingBean pb = dao.queryList1(model, sortName, sortOrder, offset, maxPagesize,"excel");
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
		return "阅读数量统计(按分类)";
	}
}
