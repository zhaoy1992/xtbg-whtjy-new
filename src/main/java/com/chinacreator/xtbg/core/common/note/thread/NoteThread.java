package com.chinacreator.xtbg.core.common.note.thread;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.note.services.AbstractNoteService;

/**
 *<p>Title:NoteSendThread.java</p>
 *<p>Description:短信发送线程</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-4-16
 */
public class NoteThread extends Thread {
	
	private static final Log LOG = LogFactory.getLog(NoteThread.class);
	
	private Object lock = new Object();
	
	private boolean noteused = false;//是否启动短信线程 默认为关闭
	
	private boolean reportused = false;//是否获取短信回执  默认为关闭
	
	private boolean replyused = false;//是否获取回复内容	 默认为关闭

	private long interval;//线程执行间隔时间

	private AbstractNoteService noteService = null;

	public void setNoteused(boolean noteused) {
		this.noteused = noteused;
	}

	public void setReportused(boolean reportused) {
		this.reportused = reportused;
	}

	public void setReplyused(boolean replyused) {
		this.replyused = replyused;
	}

	public void setInterval(long interval) {
		this.interval = interval;
	}

	public void setNoteService(AbstractNoteService noteService) {
		this.noteService = noteService;
	}

	@Override
	public void run() {
		if(noteused){
			LOG.info("note send thread start ok ");
			synchronized (lock) {			
				while(true){
					try{	
						if(noteService == null){
							LOG.error("spring send 注入有误，请检查bean-note.xml配置文件");
						}else{
							noteService.doNoteSend(); 		//短信发送接口
							if(reportused){
								noteService.getNoteReport();
							}
							if(replyused){
								noteService.getNoteReply();
							}
						}
					}catch(Throwable e){
						LOG.error(e.getMessage(),e);
					}finally{
						try {
							lock.wait(interval);
						} catch (Exception e) {
							LOG.error(e.getMessage(),e);
						}
					}
				}			
			}		
		}else{
			LOG.info("note send thread is turn off ");
		}
	}
}
