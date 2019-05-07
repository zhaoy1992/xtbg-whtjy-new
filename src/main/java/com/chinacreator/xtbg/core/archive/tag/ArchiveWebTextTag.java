package com.chinacreator.xtbg.core.archive.tag;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.security.AccessControl;
import com.chinacreator.xtbg.core.common.cache.OASystemCache;
import com.chinacreator.xtbg.core.common.cache.UserCache;
import com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean;
import com.chinacreator.xtbg.core.common.commonlist.Constant;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.dssave.dao.DsCRUDDao;
import com.chinacreator.xtbg.core.dssave.dao.impl.DsCRUDDaoImpl;
/**
 * 
 *<p>Title:ArchiveTextTag.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-5-24
 */
public class ArchiveWebTextTag extends TagSupport{

	private static final Log LOG = LogFactory.getLog(ArchiveAffixButTag.class);
	
	private static final long serialVersionUID = 1L;

	private String table;//表名
	
	private String column;//字段名
	
	private String height; //控件长度
	
	private String width; //控件宽度
	
	private String defautValue;//默认内容 暂时未使用
	
	public String getDefautValue() {
		return defautValue;
	}

	public void setDefautValue(String defautValue) {
		this.defautValue = defautValue;
	}

	/**
	 * <b>Summary: </b>
	 *     获取height的值
	 * @return height 
	 */
	public String getHeight() {
		return height;
	}

	/** 
	 * <b>Summary: </b>
	 *     设置 height 的值 
	 * @param height 
	 */
	public void setHeight(String height) {
		this.height = height;
	}

	/**
	 * <b>Summary: </b>
	 *     获取width的值
	 * @return width 
	 */
	public String getWidth() {
		return width;
	}

	/** 
	 * <b>Summary: </b>
	 *     设置 width 的值 
	 * @param width 
	 */
	public void setWidth(String width) {
		this.width = width;
	}

	public String getTable() {
		return table;
	}

	public void setTable(String table) {
		this.table = table;
	}

	public String getColumn() {
		return column;
	}

	public void setColumn(String column) {
		this.column = column;
	}
	
	@Override
	public int doEndTag() throws JspException {
		table = table.toUpperCase();
		column = column.toUpperCase();
		if(StringUtil.isBlank(height)){
			height = "768px";
		}
		if(StringUtil.isBlank(width)){
			width = "98%";
		}
		try {
			HttpServletRequest request = ((HttpServletRequest)pageContext.getRequest());
			HttpServletResponse response = (HttpServletResponse)pageContext.getResponse();
			AccessControl control = AccessControl.getInstance();
			control.checkAccess(request, response);
			String mHttpUrlName=request.getRequestURI();
			BaseInitTag data = (BaseInitTag) this.getParent(); // 获得父标签实例
			Map<String, List<Map<String, String>>>  archivedate = data.getArchivedata();//公文数据
			//Map<String, Map<String, ColumnDisplayBean>> columnDisplay =   data.getColumnDisplay();//字段表现形式
			Map<String,String> examParam = data.getExamParam();
			String action_id = examParam.get("action_id"); //父标签中取得环节ID；
			String initType = examParam.get("initType"); //父标签中取得环节类型 1为初始化环节。
			//TODO 根据环节ID，获取改环节的配置信息。
			Map<String,String> textContorlInfo= new HashMap<String,String>();
			if(StringUtil.isBlank(action_id)){
				 textContorlInfo.put("is_red","0");
				 textContorlInfo.put("is_readonly","1");
			}else{
				 textContorlInfo = getContorlInfo(action_id);
				 if(textContorlInfo.isEmpty()){
					 //pageContext.getOut().write("<script type='text/javascript'> alert('没有根据环节正文，将加载默认配置！')</script>");
					 textContorlInfo.put("is_red","0");
					 textContorlInfo.put("is_readonly","1");
				 }
			}
		
			
			List<Map<String, String>> values = archivedate.get(table);//根据表名获取数据  绝大多数为一条数据，少数情况出现多条数据。
			StringBuffer mRecordID = new StringBuffer(); //默认值为新的uuid
			if(values != null){
				for(Map<String, String> map : values){
					if(map.get(column) != null && !"".equals(map.get(column))){
						mRecordID.append(map.get(column));
					}
				}
			}else{
				LOG.debug(column + "字段  input框没有值");
			}
			
		  	//自动获取OfficeServer和OCX文件完整URL路径
		  	String path  = request.getContextPath();
		 	String mScriptName = request.getServletPath();
		 	String mServerName = "OfficeServer.jsp";
		
		 	String mServerUrl="http://"+request.getServerName()+":"+request.getServerPort()+mHttpUrlName.substring(0,mHttpUrlName.lastIndexOf(mScriptName))+"/ccapp/oa/resources/plug/iWebOffice2009/"+mServerName;//取得OfficeServer文件的完整URL
	
		    //String mRecordID=request.getParameter("RecordID");
		    String mTemplate=request.getParameter("Template");
		    String mFileType=request.getParameter("FileType");
		    String mEditType= getEditType(textContorlInfo,initType);
		    String mShowType=request.getParameter("ShowType");
		    String _DBType=request.getParameter("DBType");
		    String user_id = control.getUserID();
		    UserCacheBean userBean = UserCache.getUserCacheBean(user_id);//获得缓存的机构信息
		    String loginIP = control.getMachinedID();
			//获取用户信息
		    String mUserName = userBean.getUser_realname();//control.getUserName();//request.getParameter("UserName");
		    String user_name_IP = mUserName+" "+loginIP;
		    
		    String submit_flag = request.getParameter("submit_flag");
		    String ShowToolBar = request.getParameter("ShowToolBar");
		    
		    String is_trace = textContorlInfo.get("is_trace"); //是否显示痕迹 1为是
		    String is_red = textContorlInfo.get("is_red"); //是否套红
		    String is_readonly = textContorlInfo.get("is_readonly"); //是否只读
		    //String is_msg = textContorlInfo.get("is_msg"); //是否发送短信
		    //String msg_txt = textContorlInfo.get("msg_txt"); //短信规则
		    String is_sign = textContorlInfo.get("is_sign"); //是否可签名
		    String is_keeptrace = textContorlInfo.get("is_keeptrace"); //是否保留痕迹
		    String is_attachment = textContorlInfo.get("is_attachment"); //是否处理附件
		    String is_serialnumber = textContorlInfo.get("is_serialnumber"); //是否可编号
		    String is_gwzl = textContorlInfo.get("is_gwzl"); //是否可整理
		    String is_ckcg = textContorlInfo.get("is_ckcg"); //是否可以查看草稿
		    String is_ckzw = textContorlInfo.get("is_ckzw"); //是否可以查看正文
		    String is_ckmq = textContorlInfo.get("is_ckmq"); //是否可以查看面签
		    String is_singname = textContorlInfo.get("is_singname"); //是否签名
		    String is_affix = textContorlInfo.get("is_affix"); //是否可以盖章
		    String remark1 = textContorlInfo.get("remark1"); //扩展字段
		    String is_xd = textContorlInfo.get("is_xd"); //是否校对
		    String is_gwff = textContorlInfo.get("is_gwff"); //是否分发公文
		    String is_cd = textContorlInfo.get("is_cd"); //是否存档
		    String is_cklc = textContorlInfo.get("is_cd"); //是否查看流程
		    String is_newflow = textContorlInfo.get("is_newflow"); //是否能发起新的流程
		    String is_gk = textContorlInfo.get("is_gk");//是否公开
		    String is_nbfs = textContorlInfo.get("is_nbfs");//内部分送
		    String is_doback = textContorlInfo.get("is_doback");//是否回退
		    String is_print = textContorlInfo.get("is_print");//是否打印
		    if(StringUtil.nullOrBlank(ShowToolBar)){
			  ShowToolBar = "1";
		    }
		    
		    //取得编号
		    if(StringUtil.isBlank(mRecordID.toString()) ){
		    	//modifu by shuqi.liu 采用seq的形势获取ID，适配表分区
		    	DbManager dbManager = DbManager.getInstance();
		    	String seq_oa_document_file = dbManager.getSequence(null, "SEQ_OA_DOCUMENT_FILE");
		    	mRecordID.append(seq_oa_document_file);
				//mRecordID.append(UUID.randomUUID().toString());
				LOG.info("正文id=="+mRecordID.toString());
			}
		    //mRecordID = new StringBuffer("e8cfd914-6841-4a98-ae62-6e21ef8d159e");
		    //取得模式
		    if (mEditType==null)
		    {
		      mEditType="1,0";	//文档编辑类型  第一位可以为0,1,2,3 其中:0不可编辑;1可以编辑,无痕迹;2可以编辑,有痕迹,不能修订;3可以编辑,有痕迹,能修订；
		                          //第二位可以为0,1 其中:0不可批注,1可以批注。可以参考iWebOffice2006的EditType属性，详细参考技术白皮书
		    }
		    //取得显示模式
		    if (mShowType==null)
		    {
		      mShowType="1";	//文档显示方式  1:表示文字批注  2:表示手写批注  0:表示文档核稿
		    }
		    //取得类型
		    if (mFileType==null)
		    {
		      mFileType=".doc";	// 默认为.doc文档
		    }
		    //取得用户名
		    if (mUserName==null)
		    {
		      mUserName="用户名为空";
		    }
	
		    //取得模板
		    if (mTemplate==null)
		    {
		      mTemplate="";	// 默认没有模板
		     
		    }
		    
		    //流程发起流程中添加正文，标题
		    String isStartAdd = StringUtil.deNull(request.getParameter("isStartAdd"));
		    String archiveTitle = StringUtil.deNull(request.getParameter("archiveTitle"));
		    String addTextId = StringUtil.deNull(request.getParameter("addTextId"));
		    //查看该文档是否有整理过后的正文
		    boolean hasText = this.hasWordText(mRecordID.toString());
			//加入控件
		    StringBuffer inputhtml =    new StringBuffer("<script type='text/javascript' src='ccapp/oa/archive/iweboffice.js'></script>");
		    //加入个性化配置JS
		    inputhtml.append("<div id='dwtcontrolContainer' class='DWTContainer'></div>");
		    inputhtml.append("<script type='text/javascript' src='ccapp/oa/resources/plug/twain/Scripts/dynamsoft.webtwain.initiate.js'></script>");
		    inputhtml.append("<script type='text/javascript' src='ccapp/oa/resources/plug/twain/Scripts/DWTSample_ScanAndUpload.js'></script>");
		    inputhtml.append("<script type='text/javascript' src='ccapp/oa/archive/wordarchive/extendarchive.js'></script>");
		    inputhtml.append("<div id='webofficDiv' >");
		    inputhtml.append(" <input type='hidden' name='"+table+Constant.SEPARATOR+column+"' id='"+table+Constant.SEPARATOR+column+"' value='"+mRecordID+"'> ");
		    String url = "http://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
		    String cebversion = OASystemCache.getContextProperty("cebversion");
		    //inputhtml.append(" <OBJECT id='WebOffice' name ='WebOffice' style='POSITION: absolute;TOP: -19px;' height='"+height+"' width='"+width+"' classid='clsid:8B23EA28-2009-402F-92C4-59BE0E063499' codebase='"+url+"/ccapp/oa/resources/plug/iWebOffice2009/iWebOffice2009.cab#version=10,5,0,0'></OBJECT> ");
		    //inputhtml.append(" <OBJECT id='WebOffice' name ='WebOffice' height='"+height+"' width='"+width+"' classid='clsid:8B23EA28-2009-402F-92C4-59BE0E063499' codebase='"+url+"/ccapp/oa/resources/plug/iWebOffice2009/"+cebversion+"'></OBJECT> ");
		    inputhtml.append(" </div> ");
			String codebase = url+"/ccapp/oa/resources/plug/iWebOffice2009/"+cebversion;
			StringBuffer hiddenhtml = new StringBuffer("<input name='mServerUrl' id='mServerUrl' type='hidden' value='"+ mServerUrl +"' />" );
			
			hiddenhtml.append("<input name='objheight' id='objheight' type='hidden' value='"+ height +"' />");
			hiddenhtml.append("<input name='objwidth' id='objwidth' type='hidden' value='"+ width +"' />");
			hiddenhtml.append("<input name='codebase' id='codebase' type='hidden' value='"+ codebase +"' />");

			
			hiddenhtml.append("<input name='mRecordID' id='mRecordID' type='hidden' value='"+ mRecordID +"' />");
			hiddenhtml.append("<input name='mTemplate' id='mTemplate' type='hidden' value='"+ mTemplate +"' />");
			hiddenhtml.append("<input name='mFileType' id='mFileType' type='hidden' value='"+ mFileType +"' />");
			hiddenhtml.append("<input name='mEditType' id='mEditType' type='hidden' value='"+ mEditType +"' />");
			hiddenhtml.append("<input name='mShowType' id='mShowType' type='hidden' value='"+ mShowType +"' />");
			hiddenhtml.append("<input name='_DBType' id='_DBType' type='hidden' value='"+ _DBType +"' />");
			hiddenhtml.append("<input name='mUserName' id='mUserName' type='hidden' value='"+ mUserName +"' />");
			hiddenhtml.append("<input name='submit_flag' id='submit_flag' type='hidden' value='"+ submit_flag +"' />");
			hiddenhtml.append("<input name='ShowToolBar' id='ShowToolBar' type='hidden' value='"+ ShowToolBar +"' />");
			hiddenhtml.append("<input name='user_id' id='user_id' type='hidden' value='"+ user_id +"' />");
			hiddenhtml.append("<input name='is_trace' id='is_trace' type='hidden' value='"+ is_trace +"' />");
			hiddenhtml.append("<input name='is_red' id='is_red' type='hidden' value='"+ is_red +"' />");
			hiddenhtml.append("<input name='is_readonly' id='is_readonly' type='hidden' value='"+ is_readonly +"' />");
			//短信配置在流程加载头里加载。
			//hiddenhtml.append("<input name='is_msg' id='is_msg' type='hidden' value='"+ is_msg +"' />");
			//hiddenhtml.append("<input name='msg_txt_config' id='msg_txt_config' type='hidden' value='"+ msg_txt +"' />");
			hiddenhtml.append("<input name='is_sign' id='is_sign' type='hidden' value='"+ is_sign +"' />");
			hiddenhtml.append("<input name='is_keeptrace' id='is_keeptrace' type='hidden' value='"+ is_keeptrace +"' />");
			hiddenhtml.append("<input name='is_attachment' id='is_attachment' type='hidden' value='"+ is_attachment +"' />");
			hiddenhtml.append("<input name='is_serialnumber' id='is_serialnumber' type='hidden' value='"+ is_serialnumber +"' />");
			hiddenhtml.append("<input name='path' id='path' type='hidden' value='"+ path +"' />");
			hiddenhtml.append("<input name='text_table_id' id='text_table_id' type='hidden' value='"+table+Constant.SEPARATOR+column+"' />");
			hiddenhtml.append("<input name='is_gwzl' id='is_gwzl' type='hidden' value='"+ is_gwzl +"' />");
			hiddenhtml.append("<input name='is_ckcg' id='is_ckcg' type='hidden' value='"+ is_ckcg +"' />");
			hiddenhtml.append("<input name='is_ckzw' id='is_ckzw' type='hidden' value='"+ is_ckzw +"' />");
			hiddenhtml.append("<input name='is_ckmq' id='is_ckmq' type='hidden' value='"+ is_ckmq +"' />");
			hiddenhtml.append("<input name='is_singname' id='is_singname' type='hidden' value='"+ is_singname +"' />");
			hiddenhtml.append("<input name='is_affix' id='is_affix' type='hidden' value='"+ is_affix +"' />");
			hiddenhtml.append("<input name='remark1' id='remark1' type='hidden' value='"+ remark1 +"' />");
			hiddenhtml.append("<input name='is_xd' id='is_xd' type='hidden' value='"+ is_xd +"' />");
			hiddenhtml.append("<input name='is_gwff' id='is_gwff' type='hidden' value='"+ is_gwff +"' />");
			hiddenhtml.append("<input name='is_cd' id='is_cd' type='hidden' value='"+ is_cd +"' />");
			hiddenhtml.append("<input name='is_cklc' id='is_cklc' type='hidden' value='"+ is_cklc +"' />");
			hiddenhtml.append("<input name='is_newflow' id='is_newflow' type='hidden' value='"+ is_newflow +"' />");
			hiddenhtml.append("<input name='is_gk' id='is_gk' type='hidden' value='"+ is_gk +"' />");
			hiddenhtml.append("<input name='is_print' id='is_print' type='hidden' value='"+ is_print +"' />");
			hiddenhtml.append("<input name='is_nbfs' id='is_nbfs' type='hidden' value='"+ is_nbfs +"' />");
			hiddenhtml.append("<input name='is_doback' id='is_doback' type='hidden' value='"+ is_doback +"' />");
			hiddenhtml.append("<input name='user_name_IP' id='user_name_IP' type='hidden' value='"+ user_name_IP +"' />");
			//流程发起流程中添加正文，标题
			hiddenhtml.append("<input name='isStartAdd' id='isStartAdd' type='hidden' value='"+ isStartAdd +"' />");
			hiddenhtml.append("<input name='archiveTitle' id='archiveTitle' type='hidden' value='"+ archiveTitle +"' />");
			hiddenhtml.append("<input name='addTextId' id='addTextId' type='hidden' value='"+ addTextId +"' />");
			//是否有整理过后的正文
			hiddenhtml.append("<input name='hasText' id='hasText' type='hidden' value='"+ hasText +"' />");

			
			pageContext.getOut().write(inputhtml.toString()+hiddenhtml.toString());
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		
		return EVAL_PAGE;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* getEditType(根据环节配置信息拼装EditType)
	* @param textContorlInfo
	* * @param initType 环节类型
	* @return
	 */
	private String getEditType(Map<String, String> textContorlInfo,String initType) {
		/**
		 *
		 */
		StringBuffer editType  = new StringBuffer("");		
		if(textContorlInfo!= null){
			if("0".equals(textContorlInfo.get("is_readonly")) ){
				//如果不是只读
				if("1".equals(initType)){//如果是初始化环节，那么设置为起草，不保留痕迹
					editType.append("1,0");
				}else{
					editType.append("2,0");
				}
				
			}else {
				editType.append("4,0");//只读，不可批注
			}
		}else{
			editType.append("4,0");//只读，不可批注
		}
		 
		return editType.toString();
	}

	/**
	 * 
	*<b>Summary: </b>
	* getContorlInfo(根据环节ID获取正文的配置信息。)
	* @param action_id
	* @return
	 */
	private Map<String, String> getContorlInfo(String action_id) throws Exception {
		DsCRUDDao dao = new DsCRUDDaoImpl();
		Map<String, String>  textContorl = dao.getTextContorlInfo(action_id, null);
		return textContorl;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* hasText(查看该文档是否有整理过后的正文)
	* @param mRecordID
	* @return
	 * @throws Exception 
	 */
	public boolean hasWordText(String mRecordID) throws Exception{
		boolean flag = false;
		DsCRUDDao dao = new DsCRUDDaoImpl();
		flag= dao.hasText("text"+mRecordID);
		return flag;
	}

}
