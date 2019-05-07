package com.chinacreator.xtbg.core.common.commonlist;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;

/**
 *<p>Title:</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *@date 2012-1-13
 */
public class CommonListServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(CommonListServlet.class);
	
	
	/**
	 * @Description  公共调用的列表Servlet方法
	 * 
	 * @param request
	 * @param response
	 * @return  返回JOSNOBJECT
	 * @exception 
	 */
    public void doGet(HttpServletRequest request, HttpServletResponse response)
                    throws ServletException, IOException {
    	
    	String page = StringUtil.deNull(request.getParameter("page")); //取得当前页
    	String rows = StringUtil.deNull(request.getParameter("rows"));//取得当前显示页数 
    	String sortName = StringUtil.deNull(request.getParameter("sidx"));  //排序字段
    	String sortOrder = StringUtil.deNull(request.getParameter("sord"));  //排序方式
    	String classNameId = StringUtil.deNull(request.getParameter("classNameId")); //list 实现类
    	String paramJson = StringUtil.deNull(request.getParameter("search")); //是否做查询的标志
    	
    	int maxPageSize = 10;
    	try{
    		maxPageSize = ("".equals(rows)) ? 10 : Integer.parseInt(rows);
    	}catch (NumberFormatException e) {
			LOG.error(classNameId+"-->"+rows+"--->"+e.getMessage(),e);
		}
    	
    	if(Constant.STATUS_TRUE.equals(paramJson)) {
    		paramJson = DataControlUtil.replaceStr(request.getParameter("paramJson"));
    		paramJson = Escape.unescape(paramJson); 
    	} else if(Constant.STATUS_FALSE.equals(paramJson)){
    		paramJson = Constant.STATUS_NULL;
    	}else{
    		paramJson = DataControlUtil.replaceStr(paramJson);
    		paramJson = Escape.unescape(paramJson);
    	}
		
		boolean isPage = false;//是否分页
		if(Constant.STATUS_FALSE.equals(StringUtil.deNull(request.getParameter("isPage")))) {
			isPage = true;
		}
		
		PagingBean pb = null;
		try {
			JSONObject jsonObj = null;
			//DataInfoImpl dataInfoImpl = (DataInfoImpl)LoadSpringContext.getApplicationContext().getBean(classNameId);
			DataInfoImpl dataInfoImpl =(DataInfoImpl) Class.forName(classNameId).newInstance();//反射获取list实现类实例
			dataInfoImpl.init(request, response);
			if(isPage) {//不分页查询
				pb = dataInfoImpl.getDataList(paramJson, sortName, sortOrder);
				jsonObj = PageUitl.getJSONObject(pb);
			} else {//分页查询
				pb = dataInfoImpl.getDataList(paramJson, sortName, sortOrder, PageUitl.getCurPage(page, maxPageSize), maxPageSize);
				jsonObj = PageUitl.getJSONObject(page, maxPageSize, pb);
			}
			//LOG.info(classNameId+"-->"+jsonObj);
			// 设置字符编码
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(jsonObj);
		} catch (Exception e) {
			LOG.error(classNameId+"-->"+e.getMessage(),e);
		}
    }
    
    public void doPost(HttpServletRequest req, HttpServletResponse resp)
		    throws ServletException, IOException {
		doGet(req,resp);
	}
}
