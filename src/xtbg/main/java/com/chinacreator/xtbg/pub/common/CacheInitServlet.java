package com.chinacreator.xtbg.pub.common;

import java.io.IOException;
import java.io.Serializable;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

/**
 *<p>Title:CacheInitServlet.java</p>
 *<p>Description:容器启动时初始化数据加载servlet</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2012-1-11
 */
public class CacheInitServlet extends HttpServlet implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private static Logger LOG = Logger.getLogger(CacheInitServlet.class);

	/**
	 * Constructor of the object.
	 */
	public CacheInitServlet() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy();
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	/**
	 * 初始化环境
	 */
	public void init(ServletConfig config) throws ServletException {
		try {
			ReadServletClass.init();//加载servlet实现类信息
			ReadDaoImplClass.init();//加载dao实现类信息
			ReadFlowClass.init();//加载流程实现类信息
			//IndexCacheStart.initIndexCache();//加载首页缓存
		} catch (Exception e) {
			LOG.error(e);
			throw new ServletException();
		}
	}
}
