package com.chinacreator.xtbg.core.upload.util;

import javax.servlet.http.*;
/**
 * 大附件上传管理者
 *<p>Title:iWebFileUploadManager.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2014</p>
 *<p>Company:湖南科创</p>
 *@author tuo.zou
 *@version 1.0
 *2014-4-23
 */
public class iWebFileUploadManager {

	/**
	 * 是否续传
	 */
	private boolean isXuChuan;
	/**
	 * 是否成功
	 */
	private boolean isSuccess;
	/**
	 * 注册到session中的id
	 */
	private String id;
	/**
	 * 续传前的Fn
	 */
	private String oldFN;
	/**
	 * 续传前的uuid
	 */
	private String oldUUID;
	/**
	 * 新的Fn
	 */
	private String newFN;
	/**
	 * 新的UUID
	 */
	private String newUUID;
	/**
	 * 续传时候衔接上一次上传结束的mIndex
	 */
	private String oldMFilePoint;
	/**
	 * 状态监控
	 */
	private String state;
	
	public static final String STATE_BEGIN = "1";
	
	public static final String STATE_MIDDLE = "2";
	
	public static final String STATE_END = "3";
	
	
	private iWebFileUploadManager(){
	}
	
	public String getId() {
		return id;
	}
	public boolean isSuccess() {
		return isSuccess;
	}
	public void setOldMFilePoint(String oldMFilePoint) {
		this.oldMFilePoint = oldMFilePoint;
	}
	public String getOldMFilePoint() {
		return oldMFilePoint;
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * begin(创建上传辅助管理者,并绑定到session中)
	 * @param session
	 * @param filerealname
	 * @param newFN
	 */
	public static iWebFileUploadManager begin(HttpSession session,String filerealname,String newFN,String newUUID){
		String id = session.getId()+filerealname;
		iWebFileUploadManager manager = null;
		if(session.getAttribute(id)==null){
			manager = new iWebFileUploadManager();
			manager.id = id;
			manager.oldFN = "";
			manager.oldMFilePoint = "-1";
			manager.isXuChuan = false;
			manager.newFN = newFN;
			manager.state = STATE_BEGIN;
			manager.newUUID = newUUID;
		}else{
			manager = (iWebFileUploadManager)session.getAttribute(id);
			if(manager.state.equals(STATE_MIDDLE)
					&&!"-1".equals(manager.oldMFilePoint)){
				manager.oldFN = manager.getRightFN();
				manager.oldUUID = manager.getRightUUID();
				manager.newFN = newFN;
				manager.state = STATE_BEGIN;
				manager.isXuChuan = true;
				manager.newUUID = newUUID;
			}else{
				manager.id = id;
				manager.oldFN = "";
				manager.oldMFilePoint = "-1";
				manager.isXuChuan = false;
				manager.newFN = newFN;
				manager.state = STATE_BEGIN;
				manager.newUUID = newUUID;
			}
		}
		session.setAttribute(id, manager);
		return manager;
	}
	
	/**
	 * 
	 *<b>Summary: </b>
	 * runCheck(运行过程中检查)
	 * @param session
	 * @param filerealname
	 * @param newFN
	 */
	public static iWebFileUploadManager runCheck(HttpSession session,String filerealname,String newFN,String mIndex){
		String id = session.getId()+filerealname;
		iWebFileUploadManager manager = (iWebFileUploadManager)session.getAttribute(id);
		if(manager.state.equals(STATE_BEGIN)){
			if(manager.isXuChuan){
				if(mIndex.equals("0")){//进入if,说明上传刚进入执行阶段,在开始阶段判定可以作为续传，但是用户点击了不续传，第一次mIndex为0
					manager.isXuChuan = false;
				}
			}
			manager.state = STATE_MIDDLE;
		}
		return manager;
	}
	
	public static iWebFileUploadManager end(HttpSession session,String filerealname){
		String id = session.getId()+filerealname;
		iWebFileUploadManager manager = (iWebFileUploadManager)session.getAttribute(id);
		if(manager.state.equals(STATE_BEGIN)){//在100%上传完成之后，续传的,直接从begin 到了 end
			manager.isSuccess = false;
		}else{
			manager.isSuccess = true;
			manager.state = STATE_END;
		}
		return manager;
	}
	
	public static void removeManager(HttpSession session,String id){
		session.removeAttribute(id);
	}
	

	
	/**
	 * 
	 *<b>Summary: </b>
	 * getRightFN(返回oldFN 或者是 newFN)
	 * 如果是续传就返回oldFN如果不是就返回newFN
	 * @return
	 */
	public String getRightFN(){
		if(this.isXuChuan){
			return this.oldFN;
		}else{
			return this.newFN;
		}
	}
	
	/**
	 * 
	 *<b>Summary: </b>
	 * getRightFN(返回oldFN 或者是 newFN)
	 * 如果是续传就返回oldFN如果不是就返回newFN
	 * @return
	 */
	public String getRightUUID(){
		if(this.isXuChuan){
			return this.oldUUID;
		}else{
			return this.newUUID;
		}
	}
}
