package com.chinacreator.xtbg.core.common.note.services;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.chinacreator.xtbg.core.common.note.dao.NoteBufferDao;
import com.chinacreator.xtbg.core.common.note.dao.NoteBufferHisDao;
import com.chinacreator.xtbg.core.common.note.dao.NoteDetailDao;
import com.chinacreator.xtbg.core.common.note.dao.NoteDetailHisDao;
import com.chinacreator.xtbg.core.common.note.entity.NoteBufferBean;
import com.chinacreator.xtbg.core.common.note.entity.NoteBufferHisBean;
import com.chinacreator.xtbg.core.common.note.entity.NoteDetailBean;
import com.chinacreator.xtbg.core.common.note.entity.NoteDetailHisBean;
import com.chinacreator.xtbg.core.common.note.support.NoteConstants;

/**
 *<p>Title:AbstractNoteService.java</p>
 *<p>Description:短信发送抽象类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-4-16
 */
public abstract class AbstractNoteService {
	
	private NoteBufferDao noteBufferDao = null;
	private NoteDetailDao noteDetailDao = null;
	private NoteBufferHisDao noteBufferHisDao = null;
	private NoteDetailHisDao noteDetailHisDao = null;
	
	public void setNoteBufferDao(NoteBufferDao noteBufferDao) {
		this.noteBufferDao = noteBufferDao;
	}

	public void setNoteDetailDao(NoteDetailDao noteDetailDao) {
		this.noteDetailDao = noteDetailDao;
	}

	public void setNoteBufferHisDao(NoteBufferHisDao noteBufferHisDao) {
		this.noteBufferHisDao = noteBufferHisDao;
	}

	public void setNoteDetailHisDao(NoteDetailHisDao noteDetailHisDao) {
		this.noteDetailHisDao = noteDetailHisDao;
	}

	
	/**
	*<b>Summary: </b>
	* doNoteSend(短信发送)
	* @throws Throwable
	*/
	public abstract void doNoteSend() throws Throwable;
	
	/**
	*<b>Summary: </b>
	* getNoteReport(获取发送短信的回执状态)
	* @throws Throwable
	*/
	public abstract void getNoteReport() throws Throwable;
	
	/**
	*<b>Summary: </b>
	* getNoteReply(获取短信回复内容)
	* @throws Throwable
	*/
	public abstract void getNoteReply() throws Throwable;
	
	/**
	*<b>Summary: </b>
	* query(从缓存表中查询出待发送的短信)
	* @param retry_times 最大重发次数
	* @param conn
	* @return
	* @throws SQLException
	*/
	protected Object[] query(String retry_times,Connection conn) throws SQLException {
		Object[] obj = new Object[2];
		
		NoteBufferBean bean = noteBufferDao.queryBufferBean(retry_times,conn);
		if (bean == null) {//没有要发送的短信
			return null;
		}
		List<NoteDetailBean> list = noteDetailDao.queryNoteDetails(bean.getBuffer_id(), conn);
		if ((list == null) ||(list.size() == 0)) {//垃圾数据，没有短信接收人 ，则删除短信内容
			noteBufferDao.deleteNoteBuffer(bean.getBuffer_id(), conn);
			return null;
		}
		obj[0] = bean;
		obj[1] = list;
		return obj;
	}
	
	/**
	*<b>Summary: </b>
	* noteToHis(短信发送成功，转移到历史表中)
	* @param bean
	* @param list
	* @param response_id 短信发送响应id
	* @param status 短信发送状态
	* @param retry_times 最大重发次数
	* @param conn
	* @throws Exception
	 */
	protected void noteToHis(NoteBufferBean bean,List<NoteDetailBean> list,String response_id,String status,int retry_times, Connection conn) throws Exception {
		String rel_retry_times = bean.getRetry_times();//已经重发的次数
		if(NoteConstants.SEND_FAIL.equals(status) && Integer.parseInt(rel_retry_times) < retry_times ){//短信发送失败 且 还没有达到最大的重复次数
			noteBufferDao.updateAttemptTimes(bean.getBuffer_id(), conn);
		}else{
			NoteBufferHisBean noteBufferHisBean = addNoteBufferHisBean(bean);
			List<NoteDetailHisBean> detailHisList = addDetailHisList(list,response_id,status);
			
			noteDetailDao.deleteNoteDetailByBufferId(bean.getBuffer_id(), conn);
			noteBufferDao.deleteNoteBuffer(bean.getBuffer_id(), conn);
			
			noteBufferHisDao.insertNoteBufferHis(noteBufferHisBean, conn);
			noteDetailHisDao.insertNoteDetailHis(detailHisList, conn);
		}
	}
	
	/**
	*<b>Summary: </b>
	* addNoteBufferHisBean(封装短信历史表数据)
	* @param bean
	* @return
	* @throws SQLException
	*/
	private NoteBufferHisBean addNoteBufferHisBean(NoteBufferBean bean) throws SQLException {
		NoteBufferHisBean noteBufferHisBean = new NoteBufferHisBean();
		noteBufferHisBean.setBuffer_id(bean.getBuffer_id());
		noteBufferHisBean.setBusiness_id(bean.getBusiness_id());
		noteBufferHisBean.setBusiness_type(bean.getBusiness_type());
		noteBufferHisBean.setContent(bean.getContent());
		noteBufferHisBean.setCreate_date(bean.getCreate_date());
		noteBufferHisBean.setNeed_content(bean.getNeed_content());
		noteBufferHisBean.setNeed_status(bean.getNeed_status());
		noteBufferHisBean.setOrg_id(bean.getOrg_id());
		noteBufferHisBean.setOrg_name(bean.getOrg_name());
		noteBufferHisBean.setRetry_times(bean.getRetry_times());
		noteBufferHisBean.setSend_date(bean.getSend_date());
		noteBufferHisBean.setSubject(bean.getSubject());
		noteBufferHisBean.setTag(bean.getTag());
		noteBufferHisBean.setUser_id(bean.getUser_id());
		noteBufferHisBean.setUser_name(bean.getUser_name());
		return noteBufferHisBean;
	}
	
	/**
	*<b>Summary: </b>
	* addDetailHisList(封装短信接收历史数据)
	* @param list
	* @param response_id
	* @param status
	* @return
	*/
	private List<NoteDetailHisBean> addDetailHisList(List<NoteDetailBean> list,String response_id,String status) {
		List<NoteDetailHisBean> detailHisList = null;
		if(list != null && list.size() > 0){
			detailHisList = new ArrayList<NoteDetailHisBean>();
			for(NoteDetailBean bean : list){
				NoteDetailHisBean noteDetailHisBean = new NoteDetailHisBean();
				noteDetailHisBean.setRecv_id(bean.getRecv_id());
				noteDetailHisBean.setBuffer_id(bean.getBuffer_id());
				noteDetailHisBean.setPhone_num(bean.getPhone_num());
				noteDetailHisBean.setUser_id(bean.getUser_id());
				noteDetailHisBean.setUser_name(bean.getUser_name());
				noteDetailHisBean.setOrg_id(bean.getOrg_id());
				noteDetailHisBean.setOrg_name(bean.getOrg_name());
				noteDetailHisBean.setResponse_id(response_id);
				noteDetailHisBean.setResponse_status(status);
				detailHisList.add(noteDetailHisBean);
			}
		}
		return detailHisList;
	}
	
	/**
	*<b>Summary: </b>
	* updateReport(更新短信回执)
	* @param detailHisList
	* @param conn
	* @throws SQLException
	*/
	protected void updateReport(List<NoteDetailHisBean> detailHisList, Connection conn) throws SQLException{
		noteDetailHisDao.updateReport(detailHisList, conn);
	}
	
	/**
	*<b>Summary: </b>
	* updateupdateResponseContent(更新短信回执)
	* @param detailHisList
	* @param conn
	* @throws SQLException
	*/
	protected void updateupdateResponseContent(List<NoteDetailHisBean> detailHisList,Connection conn) throws SQLException{
		noteDetailHisDao.updateResponseContent(detailHisList, conn);
	}
	
	/**
	*<b>Summary: </b>
	* release(对象清空)
	* @param obj
	 */
	protected void release(Object... obj){
		for(@SuppressWarnings("unused")Object o : obj){
			o = null;
		}
	}

}
