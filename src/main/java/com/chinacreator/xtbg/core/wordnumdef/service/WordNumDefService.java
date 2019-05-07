package com.chinacreator.xtbg.core.wordnumdef.service;

import java.util.Map;

import com.chinacreator.xtbg.core.wordnumdef.entity.WordNumberDefBean;

/**
 * 
 *<p>Title:WordNumDefService.java</p>
 *<p>Description:文号维护服务接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-10-18
 */
public interface WordNumDefService {


	/**
	 * 
	*<b>Summary: </b>
	* deleteWordNum(删除文号)
	* @param id
	* @return
	 */
	public Boolean deleteWordNum(WordNumberDefBean bean);

	/**
	 * 
	*<b>Summary: </b>
	* addWordNum(添加或修改文号)
	* @param bean
	* @return
	 */
	public boolean addorupdateWordNum(WordNumberDefBean bean,String oldtype,String oldyear);

	
	
	/**
	 * 
	*<b>Summary: </b>
	* getWordNumBean(根据id得到文号信息)
	* @param id
	* @return
	 */
	public Map<String, String> getWordNumBean(String type,String year);
}
