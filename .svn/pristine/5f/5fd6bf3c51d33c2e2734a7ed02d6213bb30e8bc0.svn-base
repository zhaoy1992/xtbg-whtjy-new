package com.chinacreator.xtbg.core.file.entity;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.file.dao.FileDocDao;
import com.chinacreator.xtbg.core.file.service.FileDestroyService;
import com.chinacreator.xtbg.core.file.service.impl.FileDestroyServiceImpl;

/**
 *<p>Title:FileDestroyexportBean.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 任涛
 *@version 1.0
 *2013-8-23
 */
public class FileDestroyexportBean extends ExportBean{
	private static final Logger LOG = Logger.getLogger(FileDestroyexportBean.class);
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
		list.add("f_doc_year");
		list.add("f_file_no");
		list.add("f_doc_name");
		list.add("f_file_time");
		list.add("f_doc_deadline");
		list.add("f_doc_deadlines");
		list.add("f_type_remark");
		list.add("f_isagree_destroy");
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
		list.add("档案年份");
		list.add("档号");
		list.add("标题");
		list.add("归档日期");
		list.add("保管期限");
		list.add("已保管期限");
		list.add("备注");
		list.add("是否销毁");
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
		List<Map<String,String>> list = new ArrayList<Map<String,String>>();
		FileDestroyService service = new FileDestroyServiceImpl();
		String busi_id = request.getParameter("busi_id");
		if(!StringUtil.deNull(busi_id).equals("")){
			list = service.getFiledestoryDetail(busi_id);
			for (Map<String, String> map : list) {
				map.put("f_isagree_destroy", "1".equals(map.get("f_isagree_destroy"))?"同意销毁":("2".equals(map.get("f_isagree_destroy"))?"不同意销毁":""));
			}
		}
		return list;
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
