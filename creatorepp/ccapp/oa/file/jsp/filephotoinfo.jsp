<%--
　　描述：档案管理--文件管理--照片文件(照片组)--照片信息
　　作者：邹拓
　　版本：1.0
　　日期：2013-7-22
　　参数:
	f_file_id:照片信息的照片文件ID
	busi_id:照片信息的ID
	isview：查看页面
--%>
<%@page import="com.chinacreator.xtbg.core.common.fancyuoload.service.impl.FiletransferServiceImpl"%>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.commonlist.Constant"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileTypeServiceImpl"%>
<%@ taglib uri="/WEB-INF/archive-taglib.tld" prefix="oa"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	
	String f_file_id = StringUtil.deNull(request.getParameter("f_file_id"));
	String windowId = StringUtil.deNull(request.getParameter("windowId"));
	String busi_id  = StringUtil.deNull(request.getParameter("busi_id"));
	String F_USER_ID = accesscontroler.getUserID();
	UserCacheBean usercachebean=UserCache.getUserCacheBean(F_USER_ID);
	if(usercachebean==null){
		usercachebean = new UserCacheBean();
	}
	String F_UNIT_ID=usercachebean.getUnit_id();
	String F_UNIT_NAME=usercachebean.getUnit_name();
	String F_ORG_ID = usercachebean.getOrg_id();
	String F_ORG_NAME = usercachebean.getOrg_name();
	
	String F_USER_NAME = accesscontroler.getUserName();
	String F_CREATOR_TIME = DateUtil.getCurrentDate();
	String F_TYPE_ID  = StringUtil.deNull(request.getParameter("F_TYPE_ID"));
	String F_TYPE_NAME  = StringUtil.deNull(request.getParameter("F_TYPE_NAME"));
	String isgd = StringUtil.deNull(request.getParameter("isgd"));
	String SEPARATOR = Constant.SEPARATOR;//分隔字符
	
	String mypath = request.getServletPath();
    mypath = mypath.substring(0,mypath.lastIndexOf("/")+1);
    mypath = request.getContextPath()+mypath;
	
	//查询入口参数:isview
	boolean isview = false;//true?查询:编辑
	boolean canRead = false;//true?查询时可读:查询时不可读
	boolean canDownload = false;//true?查询时可下载:查询时不可下载
	String isviewStr = StringUtil.deNull(request.getParameter("isview"));
	if(isviewStr!=null&&isviewStr.length()>0){
		if("isview".equals(isviewStr)){
    		isview = true;
            if(busi_id!=null&&busi_id.length()>0&&F_USER_ID!=null&&F_USER_ID.length()>0){
                Boolean[] roles = new FileTypeServiceImpl().checkFileTypeRoleOfUser(F_USER_ID,busi_id);
                canRead = roles[0];
                canDownload = roles[1];
            }
    	}else if("jieshou".equals(isviewStr)){
    		isview = true;
            if(busi_id!=null&&busi_id.length()>0&&F_USER_ID!=null&&F_USER_ID.length()>0){
                canRead = true;
                canDownload = true;
            }
    	}
	}
	//copy true
	String isCopyStr = request.getParameter("copy");
	boolean isCopy = !StringUtil.nullOrBlank(isCopyStr);
	
	String upload_To_SeverPath = new String(FiletransferServiceImpl.upload_To_SeverPath);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title></title>
<oa:filedocinit>

<!-- 打印需要导入的内容、方法 -->
<script language="javascript" src="<%=mypath %>../../resources/plug/Lodop/LodopFuncs.js"></script> 
<object  id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>  
<!-- 是专为 FireFox 浏览器设计的代码  -->
<embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0 pluginspage="<%=path %>/resources/plug/Lodop/Lodopinstall_lodop.exe"></embed>
</object>
<script>
var upload_To_SeverPath ="<%=upload_To_SeverPath.replaceAll("\\\\","/")%>";
var SEPARATOR = "<%=SEPARATOR%>";
var tableName = "OA_FILE_DOC"+SEPARATOR+"";
var isgd="<%=isgd%>";
jQuery(function() {
	var busi_id = '<%=busi_id%>';
	if ("yes"==isgd){//归档操作时
		//显示归档控件，并设置归档人员和归档日期
		jQuery("div[id='gdDiv']").each(function(i, obj) {
			jQuery(this).show();
			//设置人和时间
			jQuery("#"+tableName+"F_FILE_TIME").val("<%=F_CREATOR_TIME%>");
			jQuery("#"+tableName+"F_FILE_USERID").val("<%=F_USER_ID%>");
			jQuery("#"+tableName+"F_FILE_USERNAME").val("<%=F_USER_NAME%>");
		});
	}else{
		if (isSpace(busi_id)){//为空，新增时  
			initFormValues();
		}else{
			
		}
	}
	
	if(!jQuery("#OA_FILE_PHOTO_INFO__F_NO").attr("disabled")){
		jQuery("#OA_FILE_PHOTO_INFO__F_NO").focus();
	}
	
	initFJ();
	<%if(isCopy){%>
	if(getParentWindow('<%=windowId%>').copyData){
		var copyData = getParentWindow('<%=windowId%>').copyData;
		try{
			if(copyData.f_title){
				jQuery("#OA_FILE_PHOTO_INFO__F_TITLE").val(copyData.f_title);
			}
			if(copyData.f_no){
				if(!isNaN(copyData.f_no)){
					jQuery("#OA_FILE_PHOTO_INFO__F_NO").val(""+(parseInt(copyData.f_no)+1));
				}else{
					jQuery("#OA_FILE_PHOTO_INFO__F_NO").val(copyData.f_no);
				}
			}
			if(copyData.f_cj_no){
				jQuery("#OA_FILE_PHOTO_INFO__F_CJ_NO").val(copyData.f_cj_no);
			}
			if(copyData.f_dang_no){
				if(copyData.f_dang_no.lastIndexOf("_")>-1){
					var tmp = copyData.f_dang_no.substring(copyData.f_dang_no.lastIndexOf("_")+1,copyData.f_dang_no.length);
					if(!isNaN(tmp)){
						jQuery("#OA_FILE_PHOTO_INFO__F_DANG_NO").val(copyData.f_dang_no.substring(0,copyData.f_dang_no.lastIndexOf("_")+1)+""+(parseInt(tmp)+1));
					}else{
						jQuery("#OA_FILE_PHOTO_INFO__F_DANG_NO").val(copyData.f_dang_no);
					}
				}else{
					jQuery("#OA_FILE_PHOTO_INFO__F_DANG_NO").val(copyData.f_dang_no);
				}
			}
		}catch(e){}
	}
	<%}%>
});
function initFJ(){
	jQuery("#_fileshow").css("max-height","");
	jQuery("#_fileshow").css("height","");
	jQuery("#_fileshow").parent().css("height","");
}
//关闭弹窗
function closed(){
	try{
		removeAlertWindows('<%=windowId%>',true);
	}catch(e){}
	
}
/**
	函数:  initFormValues
	说明:  新增时初始化相关控件
**/
function initFormValues(){
	jQuery("#"+tableName+"F_CREATOR_TIME").val("<%=F_CREATOR_TIME%>");
}
/**
 * 打印照片说明
 */
function printDetail(){
	//ajax方式提交数据
    jQuery.ajax({
        type: "post",
        url: '<%=mypath %>filetypeinfodo.jsp?action=exportPicDetail', 
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data : {
        	"action":"exportPicDetail",
        	"type":"2",//1:照片文件(照片组),2照片信息
        	"id":jQuery("#busi_id").val()
        },
        dataType: "json",
        success: function(data){
            if(data&&data.length){
            	printDetailBack(data);
            }else{
                alert("没有可打印的照片！");
            }
        }, 
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert("出现异常，请稍后再试！");
        }
     });
}
/**
  *生成html
  */
 function getHTML(data){
 	if(data.f_title&&data.f_title.length>12){
 		data.f_title=data.f_title.substring(0,12)+"...";
 	}
 	if(data.f_doc_content_pic&&data.f_doc_content_pic.length>20){
 		data.f_doc_content_pic=data.f_doc_content_pic.substring(0,20)+"...";
 	}
	  var html = [
	        '<table border="0"cellpadding="0" cellspacing="1" width="150px;" style="font-size:12px;display:inline;background: #000;margin:0px;">',
	         '<tr style="background: #FFF;">',
	           '<td align="center" style="width:50px;">',
	           ' 题名',
	           '</td>',
	           '<td align="center" style="width:100px;height: 40px;">',
	              '<div style="vertical-align:middle;height:40px;width:90px;word-wrap:break-wrod;',
	                'word-break:break-all;overflow: hidden;float: left;display: inline;',
	                'line-height:20px;margin-left:5px;">'+data.f_title,
	              '</div>',
	           '</td>',
	         '</tr>',      
	         '<tr style="background: #FFF;">',
	           '<td align="center" >',
	           '照片号',
	           '</td>',
	           '<td align="center" >'+data.f_no,
	           '</td>',
	         '</tr>',	         
	         '<tr style="background: #FFF;">',
	           '<td align="center" >',
	           ' 参见号',
	           '</td>',
	           '<td align="center" >'+data.f_cj_no+'&nbsp;',
	           '</td>',
	         '</tr>',
	          '<tr style="background: #FFF;">',
	           '<td align="center" >',
	           '时间',
	           '</td>',
	           '<td align="center" >'+data.f_file_formtime+"&nbsp;",
	           '</td>',
	         '</tr>',	         
	         '<tr style="background: #FFF;">',
	           '<td align="center" >',
	           '摄影者',
	           '</td>',
	           '<td align="center" >'+data.f_shooting_user+"&nbsp;",
	           '</td>',
	         '</tr>',	         
	         '<tr style="background: #FFF;">',
	           '<td align="center" >',
	           ' 文字<br/>说明',
	           '</td>',
	           '<td style="height:65px;width:100px;">',
	           '<div style="height:65px;width:90px;word-wrap:break-wrod;',
	                'word-break:break-all;overflow: hidden;float: left;display: inline;',
	                'line-height:20px;margin-left:5px;">',
	                data.f_doc_content_pic,
	              '</div>',
	           '</td>',
	         '</tr>',
	      '</table>'
	 ]
	 return html.join(" ");
 }

 /* 打印图片详细信息回调函数 */
 function printDetailBack(data){
     var htmlArray = new Array();
     htmlArray.push('<div id="printPic" style="width:660px;float:left;font-size:12px;">');
     htmlArray.push("<div style='width:100%;height:20px;float:left;margin-bottom:20px;");
     htmlArray.push("border-bottom:1px solid #000;text-align:right;'>第1页</div>");         
     
     var i = 1;
     if(data.length>0){
     	htmlArray.push(getHTML(data[0]));
     }
     htmlArray.push('</div>');
     
      /*判断浏览器的类型并决定采用哪个对象实例，并检测控件是否安装、是否最新版本、并引导安装或升级。  */
      var LODOP=getLodop(document.getElementById('LODOP'),document.getElementById('LODOP_EM'));      
      createPrintHtml(LODOP,htmlArray.join(" "));        
      LODOP.PREVIEW();
 };
 
 /*创建部分打印内容  */
 function createPrintHtml(LODOP,phtml){
    /*初始化运行环境，清理异常打印遗留的系统资源，设定打印任务名。  */
     LODOP.PRINT_INIT("打印");    
     LODOP.SET_PRINT_PAGESIZE(1, 0, 0, "A4") ;
     LODOP.SET_PRINT_STYLE("FontSize", 20);
     LODOP.SET_PRINT_STYLEA(0,"Horient",3);
     LODOP.SET_PRINT_STYLEA(0,"Vorient",3);  
     LODOP.ADD_PRINT_HTM('0%','1.5CM','100%','100%',phtml); 
 };
</script>
<!-- 引入jGrid -->
<link rel="stylesheet" type="text/css" media="screen" href="<%=mypath %>../../resources/plug/jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
<script src="<%=mypath %>../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"  charset="utf-8" type="text/javascript"></script>
<script src="<%=mypath %>../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"  charset="utf-8" type="text/javascript"></script>

<script type="text/javascript" src="<%=mypath %>../resources/js/filedoc.js"></script>
<script src="<%=mypath%>../resources/js/UUID.js" type="text/javascript"></script>
<%--注释js引用:通过存两份文件的方式，在页面显示jpg，放开js引用:通过存一份tif的方式,在页面通过插件显示tif
<script type="text/javascript" src="<%=mypath %>../resources/js/htmlshowTIFhelp.js"></script>
--%>
</head>
<body>
<div style="width:1020px;float:left;">
<div class="content_02_top" >
	
	<input value="保存" onclick="savedA()"  type="button" class="but_y_01" id="savedButton"/>
	<input value="打印照片说明" onclick="printDetail()"  type="button" class="but_y_03" id="savedButton" style="width:105px;"/>
	<input value="关闭" onclick="closed()" type="button" class="but_y_01"/>
	<script>
	function savedA(){
	var isFlag = jQuery('#form1').validationEngine('validate');
	if (isFlag){
		var okF = function(){
	    	var fm = document.getElementById("form1");
	        fm.action = getCurrentFilePath()+"filedocdetaildo.jsp";
	        jQuery('#form1').attr("target","filephotoinfoJSPhiddenFrame");
	        jQuery('#form1').submit();
		}
		var p={
			headerText:'提示',
			okName:'确认',
		    okFunction:okF,
		    cancelFunction:function(){
	            jQuery("#form1").resetSubmit(false);   
	        },
		    cancelName:'取消'
		};
		alert('确定保存吗？',p);
	}
}
function afterSubmitFn(){
	window.top.alert("操作成功");
	getParentWindow('<%=windowId%>').searchData();
	jQuery("#form1").resetSubmit(false);
	jQuery("#opt_type").val("update");
}
	</script>
</div>
<div class="vcenter" style="height:460px;width:100%;overflow-y:auto;">
	<form id="form1" name="form1" method="post">
		<input type="hidden" id="busi_id"      name="busi_id"  value="<%=busi_id %>" />
		<input type="hidden" id="opt_type"     name="opt_type" /> 
		<input type="hidden" id="busiTypeCode" name="busiTypeCode" />
		<input type="hidden" id="windowId" name="windowId" value="<%=windowId %>" />
		<div style="float: left; width: 990px;">
			<div class="content_02_box" style="width: 990px;">
				<%--照片信息 begin--%>
				<div class="content_02_box_title_bg" style="width: 98%;">
					<span>照片信息</span>
				</div>
				<div class="content_02_box_div" style="width: 98%;">
					<table border="0" cellspacing="0" cellpadding="0"
						class="content_02_box_div_table" style="width: 100%;">
						<tr><%--row1--%>
							<th class="content_02_box_div_table_th">
								<span class="color_red">*</span>照片/底片号：
							</th>
							<td class="content_02_box_div_table_td">
								<oa:input
									type="text" column="f_no" table="OA_FILE_PHOTO_INFO" 
									other="class='validate[required,maxSize[100],custom[number]] input_cx_title_240'" />
							</td>
							<th class="content_02_box_div_table_th">
								参见号：
							</th>
							<td class="content_02_box_div_table_td">
								<oa:input
									type="text" column="f_cj_no" table="OA_FILE_PHOTO_INFO"
									other="class='validate[maxSize[100]] input_cx_title_240'" />
							</td>
						</tr>
						<tr><%--row2--%>
							<th class="content_02_box_div_table_th">
								<span class="color_red">*</span>题名：<%--照片文件.组号==文书文件.件号--%>
							</th>
							<td class="content_02_box_div_table_td">
								<oa:input
                                       type="text" column="f_title" table="OA_FILE_PHOTO_INFO"
                                       other="class='validate[required,maxSize[60]] input_cx_title_240'" />
							</td>
							<th class="content_02_box_div_table_th">
								<span class="color_red">*</span>介质类型：
							</th>
							<td class="content_02_box_div_table_td">
								<oa:select
                                        column="f_photo_media" table="OA_FILE_PHOTO_INFO" dictType="jzlx"  hiddenName="f_photo_media_NAME"
                                        defautValue="F_DOC_MEDIA" other="style='width:246px'"></oa:select>
							</td>
						</tr>
						<tr><%--row3--%>
							<th class="content_02_box_div_table_th" style="height: 70px">文字说明：</th>
							<td class="content_02_box_div_table_td" colspan=3><oa:textarea
									column="f_explain" table="OA_FILE_PHOTO_INFO"
									other="class='validate[maxSize[1000]]' style='width:733px;'" />
							</td>
						</tr>
						<tr id='fuJianTr'>
                             <th class="content_02_box_div_table_th" style="vertical-align: top">附件：</th>
                             <td class="content_02_box_div_table_td" colspan=3>
									<%if(isview){
										String openType = "000";
										if(canDownload&&canRead){
											openType = "011";
										}else if(!canDownload&&canRead){
											openType = "010";
										}else if(canDownload&&!canRead){
											openType = "001";
										}%>
										<oa:affixbut 
										butName='请选择文件' column='F_ATTACH_ID' table='OA_FILE_PHOTO_INFO'
										title='' operType="<%=openType%>" />
										<%
									}else{%>
									<oa:affixbut
										butName='请选择文件' column='F_ATTACH_ID' table='OA_FILE_PHOTO_INFO'
										title='' operType="111" addCallBackJsFn="callBackJsFn" delCallBackJsFn="afterDeleteFile"
										convertToTif="true" typeFilter="typeFiltera"/>
									<%} %>
								<script>
								var typeFiltera = {'图片 (*.jpg,*.tif)': '*.jpg;*.tif'};
								
								callBackJsFn = function(a,b){
									fetchZPYL();
								};
								
								afterDeleteFile = function (fileid){
									fetchZPYL();
								};
								//本函数用于在图片加载时对图片大小等进行设置
								function changeSize(obj,flag){
						            w=obj.width();
						            obj.width(w>970?970:w);
						            obj.show();
						            if(flag=='error'){
						            	obj.attr('title','上传的JPG文件或受损,或转换未成功,在浏览器中加载失败');
						            }else{
						            	obj.attr('title','部分浏览器不支持显示TIF格式文件,系统为在浏览器中显示,为在浏览器显示,系统同时存储了一份JPG格式文件');
						            }
						        };
						        //先加载图片，加载结束后，在调整大小显示图片
						        function colsoleSize(){
						        	if(jQuery.browser.msie){
							            //IE 6.0
							            if(jQuery.browser.version==6.0){
							                $("#zpylDIV img").each(function(){
						                        if(this.readyState == "complete"||this.readyState=="loaded"){
						                            changeSize($(this));
						                        }
							                })
							            }else{//IE 6.0以上
							            	var countt=0;
							            	var maxTime=4000;//加载时间4秒
							                jQuery("#zpylDIV img").each(function(){
							                	var a = this;
							                    tempTimer=window.setInterval(function(){
							                        if(a.readyState=="complete"){
							                            changeSize(jQuery(a));
							                        }else{
							                        	countt++;
							                        	if(countt>(maxTime/200)){
							                        		window.clearInterval(tempTimer);
							                        		changeSize(jQuery(a),'error');
							                        	}
							                            return;
							                        }
							                    },200);
							                })
							            }  
							        }else{//FF,Chrome
							            jQuery("#zpylDIV img").each(function(){
							                if(this.complete==true){
							                    changeSize($(this));
							                }
							            })
							        }
						        }
								<%--刷新照片预览--%>
								fetchZPYL = function(){
									var i=0;
									jQuery("#zpylDIV").html("");
									if(typeof(htmlshowTIFhelp)=='undefined'){
										jQuery("#_fileshow li").each(function(){
											i++;
											djsnId = this.id;
											if(djsnId){
												fileName = this.firstChild;
												djsnId = this.id;
												fileNameStr = fileName.data;
												srcUrl = "<%=path%>/servlet/pubFileDownload?djsn="+djsnId+"&openType=download&_Custom_Download=pageReadTif&fileName="+fileNameStr;
												//srcUrl = "<%=path%>"+upload_To_SeverPath+djsnId+".jpg";
												imgHTML = "<img id=\"img"+djsnId+"\" src='"+srcUrl+"' style='display:none'/>";
												jQuery("#zpylDIV").append(imgHTML);
											}
										});
										colsoleSize();
									}else{
										if(htmlshowTIFhelp.unNeedCJ){
											jQuery("#_fileshow li").each(function(){
												i++;
												fileName = this.firstChild;
												djsnId = this.id;
												if(fileName&&djsnId){
													fileNameStr = fileName.data;
													srcUrl = "<%=path%>/servlet/pubFileDownload?djsn="+djsnId+"&openType=download&fileName="+fileNameStr;
													imgHTML = "<img id=\"img"+djsnId+"\" src='"+srcUrl+"' style='display:none'></img>";
													jQuery("#zpylDIV").append(imgHTML);
												}
											});
											colsoleSize();
										}else{
											if(htmlshowTIFhelp.hasCJ){
												jQuery("#_fileshow li").each(function(){
													i++;
													fileName = this.firstChild;
													djsnId = this.id;
													if(fileName&&djsnId){
														fileNameStr = fileName.data;
														srcUrl = "<%=path%>/servlet/pubFileDownload?djsn="+djsnId+"&openType=download&fileName="+fileNameStr;
														var sqls=new Array;
														sqls.push("<OBJECT WIDTH='900px;' HEIGHT='600px;' CLASSID='CLSID:106E49CF-797A-11D2-81A2-00E02C015623'>");
														sqls.push(" <embed src='"+srcUrl+"' type='application/x-alternatiff'>");
														sqls.push(" <param name='src' value='"+srcUrl+"'>");
														sqls.push(" <param name='negative' value='no'>");
														sqls.push("</OBJECT>");
														jQuery("#zpylDIV").append(sqls.join(""));
														
													}
												});
											}else{
												jQuery("#zpylDIV").append(htmlshowTIFhelp.noCJmess);
											}
										}
									}
									if(i!=0){
										jQuery("#fuJianTr").hide();
										jQuery(".swiff-uploader-box").hide();
									}else{
										jQuery("#fuJianTr").show();
										jQuery(".swiff-uploader-box").show();
									}
								}
								</script>
							</td>
                         </tr>
                         <tr>
                             <th class="content_02_box_div_table_th" style="vertical-align: top">附件列表：
                             </th>
                             <td class="content_02_box_div_table_td" colspan=3><oa:affixshow title='' /></td>
                         </tr>
						<tr><%--row4--%>
							<th class="content_02_box_div_table_th">档号：</th>
							<td class="content_02_box_div_table_td" colspan=3>
								<oa:input
									type="text" column="f_dang_no" table="OA_FILE_PHOTO_INFO"
									other="class='input_cx_title_240' style='width:733px;'" />
							</td>
						</tr>
						<%--<tr>row5
							<th class="content_02_box_div_table_th" style="height: 70px">存放位置：</th>
							<td class="content_02_box_div_table_td" colspan=3><oa:textarea
									column="f_location" table="OA_FILE_PHOTO_INFO"
									other="style='width:733px;'" />
							</td>--%>
						</tr>
					</table>
					<oa:input type="hidden" column="f_file_id" table="OA_FILE_PHOTO_INFO" value="<%=f_file_id %>"/>
				</div>
				<div class="content_02_box_div" style="width: 98%;" id="checkTIFmessDiv"></div>
						<SCRIPT>if(typeof(htmlshowTIFhelp)!='undefined'){htmlshowTIFhelp.checkTIF("checkTIFmessDiv");}</SCRIPT>
				<div class="content_02_box_div" style="width: 98%;" id="zpylDIV">
				</div>
				
				<%--照片信息 end--%>
			</div>
		</div>
	</form>
</div>


<iframe name="filephotoinfoJSPhiddenFrame" width=0 height=0></iframe>
</div>
</body>
</oa:filedocinit>
<script>
jQuery(function(){
	fetchZPYL();
	<%if(isview){%>
		jQuery("#savedButton").hide();
	   jQuery("#fuJianTr").hide();
	   jQuery(".swiff-uploader-box").hide();
	<%}%>
});
</script>
</html>
