package com.chinacreator.xtbg.core.archive.tag;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.security.AccessControl;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.dssave.dao.DsCRUDDao;
import com.chinacreator.xtbg.core.dssave.dao.impl.DsCRUDDaoImpl;
import com.chinacreator.xtbg.core.dssave.entity.MdTableBean;
/**
 *<p>Title:BaseInitTag.java</p>
 *<p>Description:初始化业务数据标签抽象类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-3-29
 */
public abstract class  BaseInitTag extends TagSupport{
	
	private static final Log LOG = LogFactory.getLog(BaseInitTag.class);

	private static final long serialVersionUID = 1L;
	
	//公文数据    Map<表名,List<Map<字段,值>>>
	private Map<String,List<Map<String,String>>> archivedata;
	
	//字段显示形式  Map<表名,Map<字段,ArchiveColumnDisplayBean>>
	private Map<String,Map<String,ColumnDisplayBean>> columnDisplay;
	
	//扩展属性，在其他标签中可能用到该属性。
	private Map<String,String> examParam;
	
	//日期格式处理，封装成<id,'yyyy-MM-dd'>的格式，在后台保存的时候做日期格式处理。
	private Map<String,String> dateList;
	
	public Map<String, String> getDateList() {
		return dateList;
	}

	public void setDateList(Map<String, String> dateList) {
		this.dateList = dateList;
	}

	public Map<String, String> getExamParam() {
		return examParam;
	}

	public void setExamParam(Map<String, String> examParam) {
		this.examParam = examParam;
	}

	public Map<String, List<Map<String, String>>> getArchivedata() {
		return archivedata;
	}

	public void setArchivedata(Map<String, List<Map<String, String>>> archivedata) {
		this.archivedata = archivedata;
	}

	public Map<String, Map<String, ColumnDisplayBean>> getColumnDisplay() {
		return columnDisplay;
	}

	public void setColumnDisplay(
			Map<String, Map<String, ColumnDisplayBean>> columnDisplay) {
		this.columnDisplay = columnDisplay;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     构造一个 BaseInitTag  
	   * <b>Remarks: </b>
	  *     构造类 BaseInitTag 的构造函数 BaseInitTag
	 */
	public BaseInitTag(){
			this.dateList = new HashMap<String,String>();
	}
	@Override
	public int doStartTag() throws JspException {
		this.dateList = new HashMap<String,String>();//初始化将日期定义置空
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
				//htmlString.append("<script type='text/javascript' src='ccapp/oa/resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js'></script>");
				htmlString.append("<script type='text/javascript' src='ccapp/oa/resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js'></script>");
				htmlString.append("<script type='text/javascript' src='ccapp/oa/resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js'></script>");
				htmlString.append("<script type='text/javascript' src='ccapp/oa/resources/plug/form/jquery.form.js'></script>");

				//打印需要导入的内容、方法 
		/*		htmlString.append("<script language='javascript'  src='ccapp/oa/resources/plug/Lodop/LodopFuncs.js'></script>");
				htmlString.append("<object id='LODOP' classid='clsid:2105C259-1E0C-4534-8141-A753534CB4CA' width=0 height=0>");
				htmlString.append("<embed id='LODOP_EM' type='application/x-print-lodop' width=0 height=0 ></embed>");
				htmlString.append("</object>");*/
				
				this.archivedata = getarchivedate(busi_id,busiTypeCode); //加载业务数据
				
				pageContext.getOut().write(htmlString.toString());
				startTagToDo();//调用继承类扩展方法
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		
		return EVAL_BODY_INCLUDE; //表示需要执行标签体
	}
	
	public int doEndTag() throws JspException{
		try {	
				HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();
				String busi_id = StringUtil.deNull(request.getParameter("busi_id")); //业务ID（具体的主键值）
				String busiTypeCode = StringUtil.deNull(request.getParameter("busiTypeCode"));//获取业务类型类型
				String opt_type = "update";
				if(StringUtil.isBlank(busi_id)){
					busi_id = StringUtil.getUUID();
					opt_type = "save";
				}
				StringBuffer htmlString =  new StringBuffer();
				htmlString.append("<input id=\"datelist\" name=\"datelist\" type=\"hidden\"/>");
				pageContext.getOut().write(htmlString.toString());
				pageContext.getOut().write("<script type='text/javascript'>jQuery(function(){ jQuery('#busi_id').val('"+busi_id+"'); jQuery('#opt_type').val('"+opt_type+"'); jQuery('#busiTypeCode').val('"+busiTypeCode+"'); });</script>");
				endTagToDo();
			} catch (Exception e) {
				LOG.error(e.getMessage(), e);
			}
			return EVAL_PAGE;
	}
	
	/**
	 * 
	  * <b>Summary:在标签结束里需要做的操作，比如某些页面加载完再做的值。也可以不做任何操作 </b>
	  *     复写方法 doEndTag
	  * @return 
	  * @see javax.servlet.jsp.tagext.TagSupport#doEndTag()
	 */
	public abstract void endTagToDo() throws Exception;
	
	/**
	 * 
	  * <b>Summary:在标签结束里需要做的操作，比如某些页面加载完再做的值。也可以不做任何操作 </b>
	  *     复写方法 doEndTag
	  * @return 
	  * @see javax.servlet.jsp.tagext.TagSupport#doEndTag()
	 */
	public abstract void startTagToDo() throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getarchivedate(根据业务主键，业务类型获取业务数据)
	* @param businessid 主键ID
	* @param busiTypeCode 业务类型
	* @return
	* @throws Exception
	 */
	public Map<String, List<Map<String, String>>> getarchivedate(String businessid, String busiTypeCode) throws Exception{
		Map<String, List<Map<String, String>>> dateMap = new HashMap<String, List<Map<String,String>>>();
		
		//Map<String, String> map = new HashMap<String, String>();
		DsCRUDDao dao = new DsCRUDDaoImpl();
		List<MdTableBean> listBean = dao.getMdTableInfo(busiTypeCode);//获取业务类型的配置信息
		//TODO 由于只有一个业务ID，所以当出现多个主表的时候会出现问题，但是满足当前只需要支持一个主表
		for(MdTableBean archiveMdTableBean:listBean){ //循环主表 
			List<Map<String, String>> list = new ArrayList<Map<String,String>>();
			String tableName = archiveMdTableBean.getTable_code();
			String tablePk = archiveMdTableBean.getTable_pk();
			list = dao.getBusinessDada(archiveMdTableBean,tablePk,businessid);
			
			dateMap.put(tableName, list);//set值
			if(archiveMdTableBean.getSonlist().size()>0){
				for(MdTableBean sonArchiveMdTableBean:archiveMdTableBean.getSonlist()){
					List<Map<String, String>> sonList = new ArrayList<Map<String,String>>();
					String sonTableName = sonArchiveMdTableBean.getTable_code();
					String sonTablePk = tablePk;//此处用父表的主键一次性查询出主表的所有数据
					sonList = dao.getBusinessDada(sonArchiveMdTableBean,sonTablePk,businessid);
					dateMap.put(sonTableName, sonList);//set值
				}
			}
		}
		return dateMap;
	}
	
	@Override
	public void release() {
		super.release();
		columnDisplay = null;
	}
}
