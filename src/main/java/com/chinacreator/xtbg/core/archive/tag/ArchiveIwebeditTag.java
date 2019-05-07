package com.chinacreator.xtbg.core.archive.tag;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.commonlist.Constant;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.dssave.dao.DsCRUDDao;
import com.chinacreator.xtbg.core.dssave.dao.impl.DsCRUDDaoImpl;
/**
 *<p>Title:ArchiveIwebTag.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 任涛
 *@version 1.0
 *2013-8-22
 */
public class ArchiveIwebeditTag extends TagSupport{
	private static final Log LOG = LogFactory.getLog(ArchiveIwebeditTag.class);
	private static final long serialVersionUID = 1L;
	
	private String table;//表名
	
	private String column;//字段名

	private String id; //正文显示类型ID
	
	private String style; //显示样式
	
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
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getStyle() {
		return style;
	}

	public void setStyle(String style) {
		this.style = style;
	}

	@Override
	public int doEndTag() throws JspException {
		table = table.toUpperCase();
		column = column.toUpperCase();
		id = id.toUpperCase();
		style = style.toUpperCase();
		try {
			HttpServletRequest request = ((HttpServletRequest)pageContext.getRequest());
			
			BaseInitTag data = (BaseInitTag) this.getParent(); // 获得父标签实例
			Map<String, List<Map<String, String>>>  archivedate = data.getArchivedata();//公文数据
			//Map<String, Map<String, ColumnDisplayBean>> columnDisplay =   data.getColumnDisplay();//字段表现形式
			Map<String,String> examParam = data.getExamParam();
			String action_id = examParam.get("action_id"); //父标签中取得环节ID；
			//TODO 根据环节ID，获取改环节的配置信息。
			Map<String,String> textContorlInfo= new HashMap<String,String>();
			if(StringUtil.isBlank(action_id)){
				 textContorlInfo.put("is_red","0");
				 textContorlInfo.put("is_readonly","1");
			}else{
				 textContorlInfo = getContorlInfo(action_id);
				 if(textContorlInfo.isEmpty()){
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
		 	String mServerName = "ewebeditor.htm?";
			//加入控件
		    String url = "http://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
		    StringBuffer inputhtml =    new StringBuffer();
		    inputhtml.append("<div id='webofficDiv' >");
		    inputhtml.append(" 	<textarea style='display: none' name='"+table+Constant.SEPARATOR+column+"' id='n_content'>"+mRecordID+"</textarea> ");
		    inputhtml.append(" 	<iframe id='eWebEditor1' src='"+url+"/ccapp/oa/resources/plug/eWebEditor_V4.60/"+mServerName+"id="+id+"&style="+style+"' frameborder='0' scrolling='no' width='100%' height='400'></iframe> ");
		    inputhtml.append(" </div> ");
			pageContext.getOut().write(inputhtml.toString());	
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		return EVAL_PAGE;
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
}

