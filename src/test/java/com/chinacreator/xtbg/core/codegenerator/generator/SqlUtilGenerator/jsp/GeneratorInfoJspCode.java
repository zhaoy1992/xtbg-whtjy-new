package com.chinacreator.xtbg.core.codegenerator.generator.SqlUtilGenerator.jsp;

import com.chinacreator.xtbg.core.codegenerator.entity.ClassProperty;
import com.chinacreator.xtbg.core.codegenerator.entity.ColumnProperty;
import com.chinacreator.xtbg.core.codegenerator.generator.JspPageGenerator;
import com.chinacreator.xtbg.core.codegenerator.util.CodeConstant;


public class GeneratorInfoJspCode implements JspPageGenerator {
	@Override
	public String generateJava(ClassProperty classProperty) {
		StringBuffer code = new StringBuffer();
		code.append("<%@ page language=\"java\" import=\"java.util.*\" pageEncoding=\"UTF-8\"%>\r\n");
		code.append("<%@page import=\"com.chinacreator.xtbg.core.common.util.StringUtil\"%>\r\n");
		code.append("<%@ page import=\"com.chinacreator.security.AccessControl\"%>\r\n");
		code.append("<%\r\n");
		code.append("String path = request.getContextPath();\r\n");
		code.append("AccessControl accesscontroler = AccessControl.getAccessControl();\r\n");
		code.append("accesscontroler.checkAccess(request, response);\r\n");
		code.append("String subid = request.getParameter(\"subid\");\r\n");
		code.append("String "+classProperty.getPrimaryKey()+" = StringUtil.deNull(request.getParameter(\""+classProperty.getPrimaryKey()+"\"));\r\n");
		code.append("%>\r\n");
		return code.toString();
	}
	@Override
	public String generateHeader(ClassProperty classProperty) {
		StringBuffer code = new StringBuffer();
		code.append("<!DOCTYPE HTML>\r\n");
		code.append("<html>\r\n");
		code.append("  <head>\r\n");
		code.append("    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n");
		code.append("    <title>"+classProperty.getTableChiName()+"详情页面</title>\r\n");
		code.append("	 <!-- 引入jQuery -->\r\n");
		code.append("	 <script type=\"text/javascript\" src=\"<%=path%>/ccapp/oa/resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js\"></script>\r\n");
		code.append("	 <!-- 引入my97时间控件 -->\r\n");
		code.append("	 <script src=\"<%=path%>/ccapp/oa/resources/plug/My97DatePicker/WdatePicker.js\" type=\"text/javascript\"></script>\r\n");
		code.append("	 <!-- 引入其它 -->\r\n");
		code.append("	 <script src=\"<%=path%>/ccapp/oa/resources/util/public.js\" type=\"text/javascript\"></script>\r\n");
		code.append("	 <script src=\"<%=path%>/ccapp/oa/resources/plug/formvalidation/jquery.validationEngine-cn.js\" type=\"text/javascript\" charset=\"utf-8\"></script>\r\n");
		code.append("	 <script src=\"<%=path%>/ccapp/oa/resources/plug/formvalidation/jquery.validationEngine.js\" type=\"text/javascript\" charset=\"utf-8\"></script>\r\n");
		code.append("	 <!-- 引入其它 -->\r\n");
		code.append("	 <script type=\"text/javascript\" src=\"<%=path%>/ccapp/oa/resources/plug/ifrom/js/ifrom-min.1.1.js\"></script>\r\n");
		code.append("	 <script type=\"text/javascript\" src=\"<%=path%>/ccapp/oa/resources/plug/ifrom/js/ifrom-tools.1.1.js\" charset=\"utf-8\"></script>\r\n");
		code.append("	 <script type=\"text/javascript\" src=\"<%=path%>/ccapp/oa/resources/plug/ifrom/js/ifrom-ui-alert.1.1.js\"></script>\r\n");
		code.append("	 <!-- 引入自己的js -->\r\n");
		code.append("	 <script type=\"text/javascript\" src=\"<%=path%>/ccapp/oa/resources/plug/form/jquery.form.js\"></script>\r\n");
		code.append("	 <script type=\"text/javascript\" src=\"<%=path%>/ccapp/oa/resources/plug/form/jquery.initForm.js\"></script>\r\n");
		code.append(" </head>\r\n");
		return code.toString();
	}
	@Override
	public String generateScript(ClassProperty classProperty) {
		StringBuffer code = new StringBuffer();
		code.append("<script type=\"text/javascript\">\r\n");
		code.append("var subid = \"<%=subid%>\";\r\n");
		code.append("var "+classProperty.getPrimaryKey()+" = \"<%="+classProperty.getPrimaryKey()+"%>\";\r\n");
		code.append("$(function(){\r\n");
		code.append("	//$(\"#name\").focus();//因为为ajax保存数据，有时页面会失去焦点，这里手动为一个可见元素给焦点\r\n");
		code.append("	if(!IsSpace("+classProperty.getPrimaryKey()+")){\r\n");
		code.append("		$(\"#method\").val(\"update\");\r\n");
		code.append("		$(\"#"+classProperty.getPrimaryKey()+"\").val("+classProperty.getPrimaryKey()+");\r\n");
		code.append("		//初始化表单\r\n");
		code.append("		getById("+classProperty.getPrimaryKey()+",function(code,result){\r\n");
		code.append("			if(code == 0){\r\n");
		code.append("		    	$(\"#myform\").initForm({jsonValue:result,isDebug:false});	//表单初始化方法，用了自己写的插件\r\n");
		code.append("		    }\r\n");
		code.append("		});\r\n");
		code.append("	} \r\n");
		code.append("	$(\"#saveinfo\").on(\"click\",function(){\r\n");
		code.append("		if(validateForm()){\r\n");
		code.append("			$(\"#saveinfo\").attr(\"disabled\",\"disabled\");\r\n");
		code.append("			//用jquery.form进行ajax提交,对于是添加还是更新，这里通过hidden域中的method后台判断\r\n");
		code.append("			$(\"#myform\").ajaxSubmit({dataType:\"json\",type:\"post\",\r\n");
		code.append("				success:function(data){\r\n");
		code.append("					if(data.code.index == 0){\r\n");
		code.append("						alert(\"操作成功！\");\r\n");
		code.append("						backTo();\r\n");
		code.append("					} else {\r\n");
		code.append("						alert(\"操作失败！errorCode[\"+data.code.index+\"]\");\r\n");
		code.append("				    }\r\n");
		code.append("				    $(\"#saveinfo\").removeAttr(\"disabled\");\r\n");
		code.append("				}\r\n");
		code.append("			})\r\n");
		code.append("		}\r\n");
		code.append("	})\r\n");
		code.append("})\r\n");
		code.append("function validateForm(){\r\n");
		code.append("	if(jQuery(\"#myform\").validationEngine(\"validateform\")){\r\n");
		code.append("		return true;\r\n");
		code.append("	}else{\r\n");
		code.append("		return false;\r\n");
		code.append("	}\r\n");
		code.append("}\r\n");
		code.append("//根据ID查询\r\n");
		code.append("function getById(tmp_id,callback){\r\n");
		code.append("	if(!IsSpace(tmp_id)){\r\n");
		code.append("		$.ajax({\r\n");
		code.append("			url:'"+CodeConstant.getClassNameForJspDo(classProperty)+".jsp',\r\n");
		code.append("			type:'post',dataType:'json',contentType:\"application/x-www-form-urlencoded; charset=utf-8\",\r\n");
		code.append("			data:{\"method\":\""+CodeConstant.METHOD_GETBYID+"\",\""+classProperty.getPrimaryKey()+"\":tmp_id},\r\n");
		code.append("			success:function(data){\r\n");
		code.append("				if(data.code.index == 0){\r\n");
		code.append("					//callback(data.code.index,data.result);\r\n");
		code.append("				} else {\r\n");
		code.append("					alert(\"查询数据失败！errorCode[\"+data.code.index+\"]\");\r\n");
		code.append("				}\r\n");
		code.append("				callback(data.code.index,data.result);\r\n");
		code.append("			}\r\n");
		code.append("		})\r\n");
		code.append("	}\r\n");
		code.append("}	\r\n");
		code.append("\r\n");
		code.append("function backTo(){\r\n");
		code.append("	//getParentWindow(subid).objectSearch();\r\n");
		code.append("	//removeAlertWindows(subid,true);\r\n");
		code.append("	removeWindows(subid,true);\r\n");
		code.append("}\r\n");
		code.append("</script>\r\n");
		return code.toString();
	}
	@Override
	public String generateBody(ClassProperty classProperty) {
		StringBuffer code = new StringBuffer();
		code.append("<body style=\"overflow-y:auto;overflow-x:hidden;\">\r\n");
		code.append("	<div class=\"content_02_top\" style=\"width: 100%;\"  >\r\n");
		code.append("		<input class=\"but_y_01\" type=\"button\" value=\"保存\" id=\"saveinfo\"/>\r\n");
		code.append("		<input class=\"but_y_01\" type=\"button\" value=\"返回\" id=\"backto\" onclick=\"backTo()\"/>\r\n");
		code.append("	</div>\r\n");
		code.append("	<!-- 这里的width为整个表单的宽度，如果是弹出窗口 请把这个width设置为100% -->\r\n");
		code.append("	<div class=\"content_02_box_div\" style=\"width:75%\">\r\n");
		code.append("	    <div class=\"content_02_box\" style=\"width:97%\">\r\n");
		code.append("	        <div class=\"content_02_box_title_bg\" style=\"width:100%\"><span>基本信息</span></div>\r\n");
		code.append("		    <form id=\"myform\" action=\""+classProperty.getClassNameByLower()+CodeConstant.CLASS_SUFFIX_JSP_DO+".jsp\">\r\n");
		code.append("			    <input type=\"hidden\" id=\"method\" name=\"method\" value=\""+CodeConstant.METHOD_INSERT+"\"/>\r\n");
		code.append("			    <input type=\"hidden\" id=\""+classProperty.getPrimaryKey()+"\" name=\""+classProperty.getPrimaryKey()+"\"/>\r\n");
		code.append("			    <table style=\"border: none;width:100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\"  class=\"content_02_box_div_table\">\r\n");
		code.append("				    <tr>\r\n");
		int tr_num = 0;//标记行
		for(int i = 0;i<classProperty.getColumnProperty().size();i++){
			ColumnProperty column = classProperty.getColumnProperty().get(i);
			if(column.isPrimarykey()){
				//primarykey不展示在页面
			} else {
				tr_num ++;
				if(tr_num != classProperty.getColumnProperty().size()-1){
					code.append("					    <th class=\"content_02_box_div_table_th\" style=\"width:20%;\">"+column.getComments()+"：</th>\r\n");
					code.append("					    <td class=\"content_02_box_div_table_td\" style=\"width:30%;\">\r\n");
					code.append("						    <input type=\"text\" id=\""+column.getCode()+"\" name=\""+column.getCode()+"\" class=\"input_title_text\"/>\r\n");
					code.append("					    </td>\r\n");
				} else {
					if(i == classProperty.getColumnProperty().size()-1 && (i-1)%2 == 0){	//最后一个 并且 除去主键一个 如果为双数则最后一个td为空
						code.append("					    <th class=\"content_02_box_div_table_th\" style=\"width:20%;\">&nbsp;</th>\r\n");
						code.append("					    <td class=\"content_02_box_div_table_td\" style=\"width:30%;\">\r\n");
						code.append("						    &nbsp;\r\n");
						code.append("					    </td>\r\n");
					} else {
						code.append("					    <th class=\"content_02_box_div_table_th\" style=\"width:20%;\">"+column.getComments()+"：</th>\r\n");
						code.append("					    <td class=\"content_02_box_div_table_td\" style=\"width:30%;\">\r\n");
						code.append("						    <input type=\"text\" id=\""+column.getCode()+"\" name=\""+column.getCode()+"\" class=\"input_title_text\"/>\r\n");
						code.append("					    </td>\r\n");
					}
				}
				//两个td一行
				if(tr_num != 0 && i%2 == 0){
					code.append("				    </tr>\r\n");
					if(i != classProperty.getColumnProperty().size()-1){
						code.append("				    <tr>\r\n");
					}
				}
			}
		}
		code.append("			    </table>\r\n");
		code.append("		    </form>\r\n");
		code.append("	    </div>\r\n");
		code.append("	</div>\r\n");
		code.append("  </body>\r\n");
		code.append("</html>\r\n");
		code.append("<!-- textarea示例 及 校验示例 \r\n");
		code.append("<tr>\r\n");
		code.append("    <th class=\"content_02_box_div_table_th\" style=\"width:40%;\">说明：</th>\r\n");
		code.append("    <td class=\"content_02_box_div_table_td\" style=\"width:60%;\" colspan=\"3\">\r\n");
		code.append("	    <textarea class=\"validate[required,custom[number],maxSize[400]] textarea_575\" id=\"remark\" name=\"remark\" rows=\"2\" style=\"width:98%;border:none; height: 80px;overflow: auto;\"></textarea>\r\n");
		code.append("    </td>\r\n");
		code.append("</tr>\r\n");
		code.append("-->\r\n");
		return code.toString();
	}
}