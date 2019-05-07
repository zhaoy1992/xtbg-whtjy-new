package com.chinacreator.xtbg.core.common.note.services;

import java.sql.Connection;
import java.util.List;

import com.chinacreator.xtbg.core.common.note.entity.NoteBufferBean;
import com.chinacreator.xtbg.core.common.note.entity.NoteDetailBean;

/**
 *<p>Title:NoteService.java</p>
 *<p>Description:业务短信发送API</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-6-17
 */
public interface NoteService {
	/**
	*<b>Summary: </b>
	* doNoteSend(短信发送)
	* @param noteBufferBean 短信内容信息
	* @param detailList	短信接收人信息
	* @param conn
	* @return
	* @throws Exception
	*/
	public boolean doNoteSend(NoteBufferBean noteBufferBean,List<NoteDetailBean> detailList,Connection conn) throws Exception;

}
