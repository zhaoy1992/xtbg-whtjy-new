package com.chinacreator.xtbg.core.common.creatormaker.services;

import javax.jws.WebService;

/**
 *<p>Title:OaVersionService.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-7-2
 */
@WebService
public interface OaVersionService {

	/**
	*<b>Summary: </b>
	* getVersion(获取项目版本)
	* @param project
	* @return
	 */
	public String getVersion(String project);
}
