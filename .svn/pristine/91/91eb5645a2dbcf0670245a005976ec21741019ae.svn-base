package com.chinacreator.xtbg.core.common.note.services.impl;

import java.sql.Connection;
import java.sql.Timestamp;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.note.dao.NoteBufferDao;
import com.chinacreator.xtbg.core.common.note.dao.NoteDetailDao;
import com.chinacreator.xtbg.core.common.note.entity.NoteBufferBean;
import com.chinacreator.xtbg.core.common.note.entity.NoteDetailBean;
import com.chinacreator.xtbg.core.common.note.services.NoteService;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
/**
 *<p>Title:NoteServiceImpl.java</p>
 *<p>Description:业务短信发送API实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-6-17
 */
public class NoteServiceImpl implements NoteService {
	
	private static final Log LOG = LogFactory.getLog(NoteServiceImpl.class);

	/**
	  * <b>Summary: </b>
	  *     复写方法 doNoteSend
	  * @param noteBufferBean
	  * @param detailList
	  * @param conn
	  * @return 
	  * @see com.chinacreator.xtbg.core.common.note.services.NoteService#doNoteSend(com.chinacreator.xtbg.core.common.note.entity.NoteBufferBean, java.util.List, java.sql.Connection)
	 */
	@Override
	public boolean doNoteSend(NoteBufferBean noteBufferBean,
			List<NoteDetailBean> detailList, Connection conn) throws Exception {
		boolean innerConn = false; //是否为内部连接
		boolean success = true;//操作成功
		try{
			if(conn == null){//外部传入连接为null 
				conn = DbManager.getInstance().getTransactionConnection();
				innerConn = true;
			}
			prepNoteBufferBean(noteBufferBean);
			prepDetailList(detailList, noteBufferBean.getBuffer_id());
			
			NoteBufferDao noteBufferDao = (NoteBufferDao) LoadSpringContext.getApplicationContext().getBean("noteBufferDao");
			NoteDetailDao noteDetailDao = (NoteDetailDao) LoadSpringContext.getApplicationContext().getBean("noteDetailDao");
			
			success = noteBufferDao.insertNoteBuffer(noteBufferBean, conn) && noteDetailDao.insertNoteDetail(detailList, conn);
			
		}catch (Exception e) {
			LOG.error(e.getMessage(), e);
			if(innerConn){//内部自己产生的连接  数据回滚
				DbManager.rollBackNoThrow(conn);
			}
			throw e;
		}finally{
			if(innerConn){//内部自己产生的连接  关闭连接
				DbManager.closeConnection(conn);
			}
		}
		return success;
		
	}
	
	/**
	*<b>Summary: </b>
	* prepNoteBufferBean(短信发送内容预处理)
	* @param noteBufferBean
	* @return
	* @throws Exception
	 */
	private void prepNoteBufferBean(NoteBufferBean noteBufferBean) throws Exception{
		String buffer_id = StringUtil.getUUID();//产生短信缓存主键id
		noteBufferBean.setBuffer_id(buffer_id);
		if("".equals(StringUtil.deNull(noteBufferBean.getContent()))){//短信内容不能为空
			throw new Exception("短信内容不能为空");
		}
		
		Timestamp currentTime = new Timestamp(System.currentTimeMillis());
		if(noteBufferBean.getCreate_date() == null){//创建时间为null 则默认为服务器时间
			noteBufferBean.setCreate_date(currentTime);
		}
		if(noteBufferBean.getSend_date() == null){//发生时间为null 则默认为及时发送
			noteBufferBean.setSend_date(currentTime);
		}
		if("".equals(StringUtil.deNull(noteBufferBean.getNeed_status()))){//默认不需要回执
			noteBufferBean.setNeed_status("0");
		}
		if("".equals(StringUtil.deNull(noteBufferBean.getNeed_content()))){//默认不需要回复
			noteBufferBean.setNeed_content("0");
		}
	}

	/**
	*<b>Summary: </b>
	* prepDetailList(短信接收人预处理)
	* @param detailList
	* @param buffer_id
	*/
	private void prepDetailList(List<NoteDetailBean> detailList,String buffer_id){
		if(detailList != null && detailList.size() > 0){
			for(NoteDetailBean bean : detailList){
				if(!"".equals(StringUtil.deNull(bean.getPhone_num()))){//接收人号码不能为空。//TODO待处理  此处可以再添加手机号码的合法验证。
					String recv_id = StringUtil.getUUID();//短信接收人id
					bean.setRecv_id(recv_id);
					bean.setBuffer_id(buffer_id);
				}else{
					LOG.info("短信接收人["+bean.getUser_name()+"]手机号码非法，将不会发送短信");
				}
			}
		}
	}
}
