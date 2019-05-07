package com.chinacreator.xtbg.core.common.startup;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.cache.OrgCache;
import com.chinacreator.xtbg.core.common.cache.UserCache;

/**
 *<p>Title:ApplicationStartServlet.java</p>
 *<p>Description:应用启动Servlet</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-4-7
 */
public class ApplicationStartServlet extends HttpServlet {

	private static final Log LOG = LogFactory.getLog(ApplicationStartServlet.class);
	 
	private static final long serialVersionUID = 1L;

	@Override
	public void init(ServletConfig config) throws ServletException {
		OrgCache orgCache = new OrgCache();
		UserCache userCache = new UserCache();
		LoadSpringContext.init(config.getServletContext());
		orgCache.init(); //机构缓存
		userCache.init(); //用户缓存
		LOG.info("loading spring context successful");
	}
}
