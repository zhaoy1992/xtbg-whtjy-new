package com.chinacreator.xtbg.core.common.tree.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.tree.service.impl.TreeDataInfo;
import com.chinacreator.xtbg.core.common.util.StringUtil;
/**
 *<p>Title:</p>
 *<p>Description:公共的servlet树调用</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *@date 2013-5-16
 */
public class CommonTreeServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(CommonTreeServlet.class);
	
	/**
	 * @Description  公共调用的树Servlet方法
	 * 
	 * @param request
	 * @param response
	 * @return  返回JOSNOBJECT
	 * @exception 
	 */
    public void doGet(HttpServletRequest request, HttpServletResponse response)
                    throws ServletException, IOException {
    	String classNameId = StringUtil.deNull(request.getParameter("classNameId")); //tree 实现类
    	Object obj = null;
    	try {
			TreeDataInfo treeDataInfo = (TreeDataInfo)Class.forName(classNameId).newInstance();
			treeDataInfo.init(request, response);
			obj = treeDataInfo.getTreeDateInfo();
			
			String jsons = JSONObject.toJSON(obj).toString();
			
			// 设置字符编码
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(jsons);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
    }
    
    public void doPost(HttpServletRequest req, HttpServletResponse resp)
		    throws ServletException, IOException {
		doGet(req,resp);
	}
}
