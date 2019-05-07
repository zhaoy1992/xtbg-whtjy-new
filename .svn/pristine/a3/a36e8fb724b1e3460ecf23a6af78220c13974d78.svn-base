package com.chinacreator.xtbg.pub.common;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.PageUitl;
import com.chinacreator.xtbg.pub.util.ServletClassUtil;

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
    	
    	JSONObject jsonObj = new JSONObject();
    	String page = request.getParameter("page"); //取得当前页
    	int maxPageSize = Integer.parseInt(request.getParameter("rows")); //取得当前显示页数 
    	String sortName = request.getParameter("sidx");  //排序字段
    	String sortOrder = request.getParameter("sord");  //排序方式
    	String paramJson = request.getParameter("search"); //查询参数
    	if(Constant.STATUS_TRUE.equals(paramJson)) {
    		paramJson = DataControlUtil.replaceStr(request.getParameter("paramJson"));
    		paramJson = Escape.unescape(paramJson); //查询参数
    		
    	} else if(Constant.STATUS_FALSE.equals(paramJson)){
    		paramJson = Constant.STATUS_NULL;
    	}else{
    		paramJson = DataControlUtil.replaceStr(paramJson);
    		paramJson = Escape.unescape(paramJson); //查询参数
    	}
		String classNameId = request.getParameter("classNameId"); //调用的类
		boolean isPage = false;//是否分页
		if(Constant.STATUS_FALSE.equals(request.getParameter("isPage"))) {
			isPage = true;
		}
		PagingBean pb = null;
		try {
			DataInfoImpl dataInfoImpl = (DataInfoImpl)ServletClassUtil.getServletClass(classNameId);
			if(isPage) {
				pb = dataInfoImpl.getDataList(paramJson, sortName, sortOrder);
				jsonObj = PageUitl.getJSONObject(pb);
			} else {
				pb = dataInfoImpl.getDataList(paramJson, sortName, sortOrder, PageUitl.getCurPage(page, maxPageSize), maxPageSize);
				jsonObj = PageUitl.getJSONObject(page, maxPageSize, pb);
			}

			// 设置字符编码
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(jsonObj);
		} catch (Exception e) {
			e.printStackTrace();
			LOG.error(e);
		}
    }
    
    public void doPost(HttpServletRequest req, HttpServletResponse resp)
		    throws ServletException, IOException {
		doGet(req,resp);
	}
}
