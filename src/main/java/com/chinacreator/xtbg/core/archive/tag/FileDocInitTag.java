package com.chinacreator.xtbg.core.archive.tag;


import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.security.AccessControl;
import com.chinacreator.xtbg.core.common.util.StringUtil;



/**
 * 
 *<p>Title:ArchiveInitTag1.java</p>
 *<p>Description:公文初始化标签。</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-7-15
 */

public class FileDocInitTag extends BaseInitTag {
	
	private static final Log LOG = LogFactory.getLog(FileDocInitTag.class);
	@Override
	public int doStartTag() throws JspException {
		super.setDateList(new HashMap<String,String>());//初始化将日期定义置空
		HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();
		HttpServletResponse response = (HttpServletResponse)pageContext.getResponse();
		AccessControl accesscontroler = AccessControl.getInstance();
		accesscontroler.checkAccess(request, response);
		
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
		String busi_id = StringUtil.deNull(request.getParameter("busi_id")); //业务ID（具体的主键值）
		String busiTypeCode = StringUtil.deNull(request.getParameter("busiTypeCode"));//获取业务类型类型
		if(StringUtil.isBlank(busiTypeCode)){
			return EVAL_BODY_INCLUDE; //表示需要执行标签体
		}
		//String busiTypeCode = "1";//公文类型

		try {
			
			StringBuffer htmlString =  new StringBuffer();
			
			//根据业务引入组件资源文件
				htmlString.append("<base href='"+basePath+"'>");
				htmlString.append("<script type='text/javascript' src='ccapp/oa/resources/plug/jquery1.7/jquery-1.7.1.min.js'></script>");
				htmlString.append("<script type='text/javascript' src='ccapp/oa/resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js'></script>");
				htmlString.append("<script type='text/javascript' src='ccapp/oa/resources/plug/formvalidationvm/jquery.validationEngine.js'></script>");
				htmlString.append("<script type='text/javascript' src='ccapp/oa/resources/plug/formvalidationvm/jquery.validationEngine-cn.js'></script>");
				htmlString.append("<script type='text/javascript'>jQuery.noConflict();</script>");
				htmlString.append("<link rel='stylesheet' href='ccapp/oa/resources/plug/fancyupload/fancyupload.css' type='text/css' />");
				htmlString.append("<script type='text/javascript' src='ccapp/oa/resources/plug/fancyupload/mootools-1.2.5-core-jm.js'></script>");
				htmlString.append("<script type='text/javascript' src='ccapp/oa/resources/plug/fancyupload/source/Fx.ProgressBar.js'></script>");
				htmlString.append("<script type='text/javascript' src='ccapp/oa/resources/plug/fancyupload/source/Swiff.Uploader.js'></script>");
				htmlString.append("<script type='text/javascript' src='ccapp/oa/resources/plug/fancyupload/source/FancyUpload3.Attach.js'></script>");
				htmlString.append("<script type='text/javascript' src='ccapp/oa/resources/plug/fancyupload/myfancyupload.js'></script>");
				htmlString.append("<script type='text/javascript' src='"+basePath+"ccapp/oa/resources/plug/My97DatePicker/WdatePicker.js'></script>");//时间控件组件
				htmlString.append("<script type='text/javascript' src='ccapp/oa/form/resources/gridster.js-master/js/jquery.gridster.js'></script>");
				htmlString.append("<link rel='stylesheet' type='text/css' href='ccapp/oa/form/resources/gridster.js-master/js/jquery.gridster.min.css'>");
				htmlString.append("<script type='text/javascript' src='ccapp/oa/resources/util/uuid.js'></script>");
			
				htmlString.append("<script type='text/javascript' src='ccapp/oa/resources/util/public.js'></script>");
				htmlString.append("<script type='text/javascript' src='ccapp/oa/resources/util/jsonutil.js'></script>");
				htmlString.append("<script type='text/javascript' src='ccapp/oa/resources/plug/ifrom/js/ifrom-min.1.1.js'></script>");
				htmlString.append("<script type='text/javascript' src='ccapp/oa/resources/plug/ifrom/js/ifrom-tools.1.1.js'></script>");
				htmlString.append("<script type='text/javascript' src='ccapp/oa/resources/plug/ifrom/js/ifrom-ui-alert.1.1.js'></script>");
				htmlString.append("<script type='text/javascript' src='ccapp/oa/resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js'></script>");
				htmlString.append("<script type='text/javascript' src='ccapp/oa/resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js'></script>");
				htmlString.append("<script type='text/javascript' src='ccapp/oa/resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js'></script>");
				htmlString.append("<script type='text/javascript' src='ccapp/oa/resources/plug/form/jquery.form.js'></script>");

				//打印需要导入的内容、方法 
				htmlString.append("<script language='javascript'  src='ccapp/oa/resources/plug/Lodop/LodopFuncs.js'></script>");
				htmlString.append("<object id='LODOP' classid='clsid:2105C259-1E0C-4534-8141-A753534CB4CA' width=0 height=0>");
				htmlString.append("<embed id='LODOP_EM' type='application/x-print-lodop' width=0 height=0 ></embed>");
				htmlString.append("</object>");
				
				super.setArchivedata(getarchivedate(busi_id,busiTypeCode)); //加载业务数据
				
				pageContext.getOut().write(htmlString.toString());
				startTagToDo();//调用继承类扩展方法
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		
		return EVAL_BODY_INCLUDE; //表示需要执行标签体
	}

	private static final long serialVersionUID = 1L;
	/**
	 * 
	  * <b>Summary: 在这里实现自己的业务逻辑，将意见信息标签集合封装</b>
	  *     复写方法 doEndTag
	  * @return
	  * @throws JspException 
	  * @see com.chinacreator.xtbg.core.archive.tag.BaseInitTag#doEndTag()
	 */
	@Override
	public void endTagToDo() throws JspException {
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 StartTagToDo
	  * @return
	  * @throws JspException 
	  * @see com.chinacreator.xtbg.core.archive.tag.BaseInitTag#StartTagToDo()
	 */
	@Override
	public void startTagToDo() throws Exception {
	}
	
	
}
