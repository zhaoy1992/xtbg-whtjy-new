<%@page contentType="text/html;charset=GBK"%>
<%@page import="com.chinacreator.lucene.IndexFields, com.chinacreator.lucene.search.SearchOptions" %>
<%
	String officeFileTypes = "rtf"+SearchOptions.Separate
						    +"doc"+SearchOptions.Separate
						    +"docx"+SearchOptions.Separate
						    +"xls"+SearchOptions.Separate
						    +"xlsx"+SearchOptions.Separate
						    +"ppt"+SearchOptions.Separate
						    +"pptx"+SearchOptions.Separate;
	String htmlFileTypes = "html"+SearchOptions.Separate+"htm"+SearchOptions.Separate;
	String pdfFileTypes = "pdf"+SearchOptions.Separate;
	String txtFileTypes = "txt"+SearchOptions.Separate;
%>
<html>
<head>
	<title>全文检索</title>
	<meta content="text/html;charset=GBK">
	<style>
		*,body{
			font-size:12px;
		}
	</style>
	<link  href="main.css" rel="stylesheet"  type="text/css"/>
	<script language="javascript" src="./js/calender_date.js"></script>
	<script language="javascript">
		function $(id){
			return document.getElementById(id);
		}
		function doSearch(){
			if(valid()){
				try{
					var filetypes = getCheckboxValue($("searchForm")["cfiletypes"]);
					$("filetypes").value = filetypes;
					
					var fields = getCheckboxValue($("searchForm")["cfields"], "<%=SearchOptions.Separate%>");
					if(fields==""){
						alert("请选择查询范围");
						return false;
					}
					$("fields").value = fields;
					$("searchForm").submit();
				}catch(e){
					alert(e.description);
				}
			}
		}
		//获取checkBox的值
		function getCheckboxValue(obj, separate){
			
			var sep= (separate==null)?"":separate;
			var v = [];
			for(var i=0;i<obj.length;i++){
				if(obj[i].checked) v.push(obj[i].value);
			}
			return v.join(sep);
		}
		
		function valid(){
			if($("querystr").value == ""){
				alert("请填写查询内容");
				$("querystr").focus();
				return false;
			}
			return true;
		}
	</script>
</head>
<body>
<div style="width:100%;text-align;center;border:1px solid #000">
	<div style="width:450px;text-align:left;border:1px solid red">
	<form action="search.jsp" method="post" name="searchForm" id="searchForm">
	<input type="hidden" name="filetypes"/><input type="hidden" name="fields"/>
		 <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td><table width="1000" height="500" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="870" height="26" valign="top" style="padding-left:35px; padding-top:10px;"><table width="100%" border="0" cellspacing="2" cellpadding="0">
            <tr>
              <td height="33" background="images/bar.jpg" style=" background-repeat:repeat-x">&nbsp;&nbsp; <img src="images/n_13.jpg" width="8" height="9" /> 全文搜索</td>
            </tr>
          </table>
                <table width="750" border="0">
                  <tr>
                    <td width="700" valign="top"><table width="750" border="0" align="center" cellpadding="0" cellspacing="0" style="border:1px solid  #CCCCCC">
                        <tr>
                          <td><table width="750" border="0" align="center">
                              <tr>
                                <td height="26">&nbsp;</td>
                                <td height="26">查询内容</td>
                                <td height="26" colspan="2" valign="middle"><input name="querystr" type="text" class="input_text" size="50"/></td>
                                <td height="26" valign="top">&nbsp;</td>
								 <tr>
                                <td width="6%" valign="top">&nbsp;</td>
                                <td width="18%" valign="top"><div align="left">文件大小</div></td>
                                <td width="27%" valign="top"><input name="sizemin" type="text" class="input_text" />
                                (KB)<span id="searchForm:j_id465"></span></td>
                                <td colspan="2" valign="top">至
                                  <input name="sizemax" type="text" class="input_text" />(KB)</td>
                              </tr>
							 <tr>
                                <td valign="top">&nbsp;</td>
                                <td valign="top">最后修改时间</td>
                                <td valign="top"><input name="datefrom" type="text" class="input_text" readonly="readonly" />
                                <img src="images/date.gif" width="13" height="12" onclick="showdate(document.all('datefrom'))"></td>
                                <td colspan="2" valign="top">至
                                  <input name="dateto" type="text" class="input_text" readonly="readonly" />
                                <img src="images/date.gif" width="13" height="12"  onclick="showdate(document.all('dateto'))"></td>
                              </tr>

                                <tr>
                                <td height="11" valign="top"></td>
                                <td height="11" colspan="4" valign="top" align="left"><hr width="600"></td>
                              </tr>
                              <tr>
                                <td valign="top">&nbsp;</td>
                                <td valign="top" colspan=4>文件类型
                               <input type="checkbox" name="cfiletypes" id="ftOffice" value="<%=officeFileTypes %>"/><label for="ftOffice">Office文档</label>
		<input type="checkbox" name="cfiletypes" id="ftPDF" value="<%=pdfFileTypes %>"/><label for="ftPDF">PDF文档</label>
		<input type="checkbox" name="cfiletypes" id="ftHTML" value="<%=htmlFileTypes %>"/><label for="ftHTML">网页文档</label>
		<input type="checkbox" name="cfiletypes" id="ftTxt" value="<%=txtFileTypes %>"/><label for="ftTxt">文本文档</label></td>
                              </tr>
                                  <tr>
                                <td valign="top">&nbsp;</td>
                                <td valign="top" colspan=4>查询范围
                             <input type="checkbox" name="cfields" value="<%=IndexFields.FIELD_CREATOR%>" id="field4creator"/><label for="field4creator">创建人</label>
		<input type="checkbox" name="cfields" checked="checked" value="<%=IndexFields.FIELD_CONTENT%>" id="field4content"/><label for="field4content">文档内容</label>
		<input type="checkbox" name="cfields" checked="checked" value="<%=IndexFields.FIELD_NAME%>" id="field4name"/><label for="field4name">文档名称</label></td>
                              </tr>
                              <tr>
                                <td height="12" colspan="5" valign="top"></td>
                              </tr>
                              <tr>
                                <td valign="top">&nbsp;</td>
                                <td colspan="4" valign="top"><input type="button" name="Submit" onclick="doSearch()" value="搜索"  class="common_button"/>
                                <!--input type="button" onClick="history.back();" name="Submit2" value="返回"  class="common_backbutton"/--></td>
                              </tr>
                              <tr>
                                <td height="12" colspan="5" valign="top"></td>
                              </tr>
                          </table></td>
                        </tr>
                    </table></td>
                  </tr>
              </table></td>
        </tr>
      </table></td>
    </tr>
  </table>
	</form>
	</div>
	</div>
</body>
</html>