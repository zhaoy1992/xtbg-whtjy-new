package com.chinacreator.xtbg.core.archive.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *<p>Title:ArchiveService.java</p>
 *<p>Description:公文业务处理服务</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-4-20
 */
public interface ArchiveService {

	/**
	*<b>Summary: </b>
	* handler(公文业务处理)
	* @param request
	* @param response
	* @return
	*/
	public 	Map<String,Object> handler(HttpServletRequest request, HttpServletResponse response);
	
}
