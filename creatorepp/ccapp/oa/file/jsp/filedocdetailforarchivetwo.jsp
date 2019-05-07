<%--
　　描述：档案管理 --待归档管理--公文归档录入界面，嵌套:公文添加页面
　　作者：邹拓
　　版本：1.0
　　日期：2013-10-09
--%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileDocServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.file.entity.FileDocBean"%>
<%@page import="com.chinacreator.xtbg.core.common.fancyuoload.service.impl.FiletransferServiceImpl"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.tree.dao.impl.CommonTreeDaoImpl"%>
<%@page import="com.chinacreator.xtbg.core.file.entity.FileDocBeforeArchiveBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
  	<%
  	String path = request.getContextPath();
  	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String userId = accesscontroler.getUserID();
	UserCacheBean usercachebean=UserCache.getUserCacheBean(userId);
    if(usercachebean==null){
    	usercachebean=new UserCacheBean();
    }
    String F_UNIT_ID=usercachebean.getUnit_id();
    String F_UNIT_NAME=usercachebean.getUnit_name();
    String F_ORG_ID = usercachebean.getOrg_id();
    String F_ORG_NAME = usercachebean.getOrg_name();
    String windowId = StringUtil.deNull(request.getParameter("windowId"));
    if(StringUtil.nullOrBlank(windowId)){
    	windowId = "updateFileDocDetailWindow";
    }
  	//1：
  	String fileDocBeforeArchiveBeanId = request.getParameter("id");
  	String busi_id = fileDocBeforeArchiveBeanId;
  	String initFjDJBHForArchive = request.getParameter("fj");
  	%>
	<jsp:include page="filedocdetail.jsp">
		<jsp:param name="busi_id" value="<%=busi_id%>"/>
		<jsp:param name="busiTypeCode" value="wj-001"/>
		<jsp:param name="windowId" value="<%=windowId%>"/>
		<jsp:param name="isDoGuiDang" value="isDoGuiDang"/>
		<jsp:param name="initFjDJBHForArchive" value="<%=initFjDJBHForArchive%>"/>
		<jsp:param name="openType" value="011"/>
		<jsp:param name="includePage" value="filedocdetailforarchivetwoJSP"/>
	</jsp:include>
	<%
  	//4：通过JS填充数据
  	//5：下拉框修改所属分类
  	//6：重新绑定保存事件,在保存文档的同时,修改归档信息
  	//7: 绑定窗口关闭时间,若直接关闭窗口,删除临时创建的附件信息，避免系统积累垃圾
  	%>
  	<script>
  	jQuery(function(){
  		changeFileTypeMess();
  		
  		//6
  		//updateSumbitEvent();
  		//7 TODO
  		//8.1隐藏新增按钮 
  		jQuery("#xinzeng").attr("value","下载压缩表");
  		//特检院OA 档案管理 隐藏 下载压缩表 按钮 start
  		jQuery("#xinzeng").hide();
  		//特检院OA 档案管理 隐藏下载压缩表 按钮 end
  		jQuery("#xinzeng").removeAttr("onclick");
  		jQuery("#xinzeng").click(function(){
  			//1
  			jQuery("#exportzipFrom").remove();
  			var url = getCurrentFilePath()+"/exportzip.jsp?windowId=windowId_paperTJ"; 
  			var html = new Array();
  			if(jQuery("#exportzip").size()==0){
  				html.push('<iframe id="exportzip" name="exportzip" width=0 height=0></iframe>');
  			}
  		    html.push('<form id="exportzipFrom" name="exportzipFrom" method="post" action="'+url+'" target="exportzip">');
  		    
			html.push("<input type='hidden' name='beanId' value='<%=initFjDJBHForArchive%>' />");
  		    
  		    html.push('</form>');
  		    //2
  		    jQuery(html.join("")).appendTo("body");
  		    jQuery("#exportzipFrom").submit();
  		});
  		
  		jQuery("#createWatermark").attr("value","转TIF").show();
  		//特检院OA 档案管理 隐藏 转TIF 按钮 start
  		jQuery("#createWatermark").attr("value","转TIF").hide();
  		//特检院OA 档案管理 隐藏 转TIF 按钮 end
  		jQuery("#createWatermark").removeAttr("onclick");
  		jQuery("#createWatermark").click(function(){
  			openAlertWindows('changetif', '<%=path%>/ccapp/oa/file/jsp/changetif.jsp?busi_id=<%=busi_id%>&attachId=<%=initFjDJBHForArchive%>&windowId=changetif', '转换成TIF文件' ,600,300,'10%','10%');
  		});
  		
  		
  		//9创建提交按钮
  		createTiJiaoBtn();
  	});
  	createTiJiaoBtn = function(){
  		jQuery("#savedButton").before("<input value=\"提交\" type=\"button\" class=\"but_y_01\" id=\"tijiao\"/>");
  		jQuery("#tijiao").on("click",function(){
  			savedThisTwo();
  		});
  	};
  	changeFileTypeMess = function(){ 
  		if(!jQuery("#OA_FILE_DOC__F_TYPE_NAME").val()){
  			jQuery("#OA_FILE_DOC__F_TYPE_NAME").click(function(){
  				//=============by lian.qiu start 2015-01-14 
  				var lockdivObj = createDiv('', "_lock_div1");
  				jQuery(lockdivObj).css("z-index","9000"); 
  				jQuery(lockdivObj).append('<iframe frameborder="0" id="_DivFrm1" style="position:absolute; visibility:inherit; top:0px; left:0px; width:100%; height:100%; z-index:9000; filter:Alpha(style=0,opacity=0);"></iframe>');
  				jQuery(window.top.document.body).append(jQuery(lockdivObj));
  				//=============by lian.qiu end 2015-01-14 
  			
  				var s = new jQuery.z_tree();
  				s.type = "inqueryTreeFileTreeInOneProgramPage";
  				s.<%=CommonTreeDaoImpl.OA_FILE_PROGRAM_PAGE__F_PROGRAM_ID%> = "<%=FileDocBeforeArchiveBean.F_ARCHIVE_TYPE_ONE_PAGE_ID%>";
  				s.orgId='<%=F_UNIT_ID%>';
  				s.treeID = "TreeFileTreeInOneProgramPage";
  				s.treetypestr = 'radio';
  				s.isShowSeacher = true;
  				s.treeName = "档案分类";
  				s.headerName = s.treeName;
  				s.selectedIds = jQuery('#OA_FILE_DOC__F_TYPE_ID').val(),
  				s.isType = 'dept',<%--关系到selectedIds是否生效--%>
  				s.returnFunction = function(node,nodes) {
  					window.top.$("#_DivFrm1").remove();
  					jQuery(lockdivObj).remove();
  					
  					if(node&&node.id){
  						jQuery('#OA_FILE_DOC__F_TYPE_NAME').val(nodes[0].allName);
  						jQuery('#OA_FILE_DOC__F_TYPE_ID').val(node.id);
  					}else{
  						jQuery('#OA_FILE_DOC__F_TYPE_NAME').val("");
  						jQuery('#OA_FILE_DOC__F_TYPE_ID').val("");
  					}
  				}
  				s.callbackcancel = function(){
  					window.top.$("#_DivFrm1").remove();
  					jQuery(lockdivObj).remove();
  				}
  				s.init();
  	  		});
  		}
  	};
  	updateSumbitEvent = function(){
  		<%--input value="保存" onclick="savedThis()"  type="button" class="but_y_01" id="savedButton"/--%>
  		var savedButton = jQuery("#savedButton");
  		savedButton.attr("onclick","savedThisTwo()");
  	};
  	
  	savedThisTwo = function(){
  		//set data
  		jQuery("#OA_FILE_DOC__F_GONGWEN_ID").val("<%=request.getParameter("gongwen_id")%>");
  		//====================by lian.qiu start 2015-01-14 
  		//jQuery("#OA_FILE_DOC__F_FLOW_STATE").val("2");//已提交
  		jQuery("#OA_FILE_DOC__F_FLOW_STATE").val("3");//文件管理
  		jQuery("#OA_FILE_DOC__F_SUBMIT_USER_ID").val("<%=userId%>");
  		jQuery("#OA_FILE_DOC__F_SUBMIT_USER_NAME").val("<%=usercachebean.getUser_realname()%>");
  		jQuery("#OA_FILE_DOC__F_SUBMIT_TIME").val("<%=DateUtil.getCurrentDate()%>");
  		
  		
  		//create element
  		var html = "<input type='hidden' name ='fileDocBeforeArchiveBeanId' value='<%=fileDocBeforeArchiveBeanId%>'/>";
  		jQuery(html).appendTo('#form1');
  		html = "<input type='hidden' name ='action' value='saveFileDocAndFileDocForArchiveMess'/>";<%--filedocdetailforarchivedo.jsp need--%>
  		jQuery(html).appendTo('#form1');
  		
  		html = "<input type='hidden' name ='contenttype' value='2'/>";<%--filedocdetailforarchivedo.jsp need--%>
  		jQuery(html).appendTo('#form1');
  		
  		html = "<iframe id='filedocdetailforarchiveJSPhiddenFrame' name='filedocdetailforarchiveJSPhiddenFrame' width=0 height=0></iframe>";<%--filedocdetailforarchivedo.jsp need--%>
  		jQuery(html).appendTo('body');
  		//copy savedThis
		var isFlag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
		if (!isFlag){
			return isFlag;
		}
	    var okF = function(){
	    	var fm = document.getElementById("form1");
	    	jQuery('#form1').attr("action",getCurrentFilePath()+"filedocdetailforarchivedo.jsp");
	        jQuery('#form1').attr("target","filedocdetailforarchiveJSPhiddenFrame");
	        fetchFDocFontSize();
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
		alert('确定提交吗？',p);
  	}
  	
  	afterSubmitFn=function(result){
		try{
			alert(result);
			aa=getParentWindow('<%=windowId%>');
			//支持首页
			if(typeof(aa.search)=='function'){
				aa.search();
			}else if(typeof(aa.init)=='function'){
				aa.init();
			}
			removeAlertWindows('<%=windowId%>',true);
		}catch(e){alert(e.description);}
	}
  	
  	
  	fetchAttach = function(){
  		jQuery("#_fileshow").html("");
  		MyFancyupload.createUpload('_fileshow', '#_filebut', '<%=path%>', 
  	            '<%=path%>/servlet/pubFileUpload?buessid=<%=initFjDJBHForArchive%>', true, 
  	            '<%=initFjDJBHForArchive%>','','','011','',false);
  	}
  	</script>

<%--
公文归档成档案文件的接口说明

描述：
公文模块 与 档案模块 数据交互 以 档案模块的待归档信息表(oa_file_before_archive_info)为核心。

公文或其他模块 归档到档案管理模块，即是 向 oa_file_before_archive_info表中添加 待归档记录即可。

表字段说明：
必填 F_ID  is '信息ID';                        
必填 F_TITLE  is '标题';                       
必填 F_FILE_NO  is '文号';                     
必填 F_ARCHIVE_TYPE  is '归档类型1:公文归档';     (目前公文均为 1) 
必填 F_ORG_ID  is '信息所属机构ID';            
必填 F_ORG_NAME  is '信息所属机构名';          
必填 F_DEPT_ID  is '信息所属部门ID';           
必填 F_DEPT_NAME  is '所属部门=归档部门';      
必填 F_OLDFILE_CONTENT  is '原文内容';         
必填 F_OLDFILE_TYPE  is '原文文件类型';        
必填 F_MAINFILE_CONTENT  is '正文内容';        
必填 F_MAINFILE_TYPE  is '正文文件类型';       
必填 F_ATTACH_ID  is '附件ID';                 
必填 F_CREATE_USER_ID  is '创建人';            
必填 F_CREATE_DATE  is '创建时间';             
不填 F_ARCHIVE_USER_ID  is '归档人';           
不填 F_ARCHIVE_DATE  is '归档时间';            
必填 F_IS_ARCHIVED  is '是否已经归档0:否,1:是';    (只填 0) 

2013-10-10
zoutuo
--%>