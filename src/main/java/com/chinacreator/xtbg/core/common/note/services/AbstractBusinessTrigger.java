package com.chinacreator.xtbg.core.common.note.services;

import java.sql.Connection;
import java.util.List;

import com.chinacreator.xtbg.core.common.note.entity.NoteBufferBean;
import com.chinacreator.xtbg.core.common.note.entity.NoteDetailBean;


/**
 *<p>Title:AbstractBusinessTrigger.java</p>
 *<p>Description:短信回执和回复触发器</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-4-18
 */
public abstract class AbstractBusinessTrigger {
	
	/**
	*<b>Summary: </b>
	* triggerBusiness(短信回执或回复业务触发类)
	* @param bean 短信信息实体
	* @param notedDetailBeans 短信接收人及相关回执或回复信息
	* @param flag	回执或回复标志 
	* @param conn	数据库连接 用于事物处理
	* @return
	* @throws Throwable
	 */
	public abstract boolean triggerBusiness(NoteBufferBean bean,List<NoteDetailBean> notedDetailBeans,String flag,Connection conn) throws Throwable;

}
