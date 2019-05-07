<%@page contentType="text/html; charset=utf-8"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String user_id = accesscontroler.getUserID(); //用户id
	String user_name = accesscontroler.getUserName(); //用户中文名
	String user_orgName =accesscontroler.getChargeOrgName();
	String send_id = request.getParameter("send_id");
	String ideatextid = request.getParameter("ideaid");
	String action_defid = request.getParameter("action_defid");
	
	StringBuffer sql = new StringBuffer();
	sql.append("select Idea_Content,Idea_Content from TA_OA_DOCUMENT_COMIDEA");

	String commonIdeaList = DictDropDownList.buildSelect(sql.toString(),
			"common_idea", "", "", true, "","width:118px");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.DateUtil"%>
<%@page import="com.chinacreator.xtbg.pub.util.DictDropDownList"%>
<%@page import="java.util.List"%>

<head>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery_dialog -->
<script src="../../../resources/plug/jquery_dialog/jquery_dialog.js"></script>
<!-- 引入公共JS -->
<!--<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>-->
<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript">
var ideatextid = '<%=ideatextid%>';
jQuery(function() {
	var content ="";
	jQuery("select[id*=common_idea]").change(function(){
		if(jQuery("#common_idea").val() == '只签名'){
			jQuery("#idea_info").val(content);
		}else{
			jQuery("#idea_info").val(jQuery("#common_idea").val());
			//jQuery("#idea").val(jQuery("#common_idea").val())
		}
		if(jQuery("#idea_info").val() == content){
			jQuery("#idea_info").attr("disabled",true);
		}else{
			jQuery("#idea_info").attr("disabled",false);
		}
	}); 
	jQuery("#button_submit").bind("click",onsubmit);
	//var idea = getParentWindow("").jQuery('#action_handeridea').val().replace(/\n.*/,"");
	jQuery("#idea_info").focus();
	jQuery("#idea_info").val(getParentWindow("").jQuery('#action_handeridea').val().replace(/\n.*/,""));
	
	jQuery('#userid').val(getParentWindow("").jQuery('#userid').val());
	jQuery('#username').val(getParentWindow("").jQuery('#username').val());
	jQuery('#orgid').val(getParentWindow("").jQuery('#orgid').val())
	jQuery('#orgname').val(getParentWindow("").jQuery('#orgname').val());
	//jQuery('#idea').val(getParentWindow("").jQuery('#idea').val());
	if(!IsSpace(getParentWindow("").jQuery('#orgname').val()) && !IsSpace(getParentWindow("").jQuery('#username').val())){
			jQuery('#userandorg').val(getParentWindow("").jQuery('#username').val()+","+getParentWindow("").jQuery('#orgname').val());
	}else{
		jQuery('#userandorg').val(getParentWindow("").jQuery('#username').val()+getParentWindow("").jQuery('#orgname').val());
	}
	if("<%=action_defid%>" == "jyksyshouwen_wp1_act2"){
		jQuery("#choosbtn").val("会签单位和审批领导");
		jQuery("#choosbtn").click(function() {  
			adddeptanduser_receive();
			
			//id="choosbtn" type="button"  value="会签单位和审批领导"
		});
	}else if("<%=action_defid%>" == "jyksyfawen_wp1_act6"){
		jQuery("#choosbtn").val("审批领导");
		jQuery("#choosbtn").click(function() {  
			adddeptanduser_send();
			
		});
	}else if("<%=action_defid%>" == "jyksyfawen_wp1_act4"){
		jQuery("#choosbtn").val("会签单位");
		jQuery("#choosbtn").click(function() {  
			adddeptanduser_countersign();
			
		});
	}
	else{
		jQuery("#choosbtn").val("会签单位和审批领导");
		jQuery("#choosbtn").click(function() {  
			adddeptanduser();
		});
	}
	
});
	function onsubmit(){
		var s = (getParentWindow("").jQuery('#action_handeridea').val().replace("\n<%=user_orgName%>  <%=user_name%>   <%=DateUtil.getCurrentDate_Time_Day()%>",""));
		if(!IsSpace(jQuery("#idea_info").val())){
				if(IsSpace(getParentWindow("").jQuery("action_handeridea").val())){
					getParentWindow("").jQuery("#action_handeridea").val('  '+jQuery("#idea_info").val()+"\n<%=user_orgName%>  <%=user_name%>   <%=DateUtil.getCurrentDate_Time_Day()%>");
				}else{
					getParentWindow("").jQuery("#action_handeridea").val('  '+getParentWindow("").jQuery("#action_handeridea").val()+"\n"+jQuery("#idea_info").val()+"\n<%=user_orgName%>  <%=user_name%>  <%=DateUtil.getCurrentDate_Time_Day()%>");
				}
		}else{
			if(jQuery("#idea_info").val() == ''){
					getParentWindow("").jQuery("#action_handeridea").val('  '+jQuery("#idea_info").val()+"\n<%=user_orgName%>  <%=user_name%>   <%=DateUtil.getCurrentDate_Time_Day()%>");
			}else{
				getParentWindow("").jQuery("#action_handeridea").val(getParentWindow("").jQuery("#action_handeridea").val());
			}
		}
		getParentWindow("").jQuery('#userid').val(jQuery('#userid').val());
		getParentWindow("").jQuery('#username').val(jQuery('#username').val());
		getParentWindow("").jQuery('#orgid').val(jQuery('#orgid').val());
		getParentWindow("").jQuery('#orgname').val(jQuery('#orgname').val());
		getParentWindow("").createIdeaInfo();
		removeAlertWindows('',true)
	}

	function adddeptanduser(){
		 var s = new jQuery.z_tree_leftRigth();
		  s.treeID='button_envelop_username';
		  s.isShowSeacher="aa";
		  s.treeName="选取人员";
		  s.headerName="选取人员";
		  s.titelText = "选择人员";
		  s.rightHeaderText="已添加机构和人员";
		  s.isNewCommonUse=true;
		  s.treeList=[{
			  				'leftHeaderText':'按人员选择',
			  				valueKey:'ps',
			  				selectedIds:jQuery("#userid").val(),
			  				//type:'AORG'},
			  				type:"APERSON"},
					  	{
			  				'leftHeaderText':'按部门选择',
			  				'item_id' :'org_id',
			  				isType:'dept', 
			  				valueKey:'dept',
			  				selectedIds:jQuery("#orgid").val(),
			  				//type:'{"type":"24"}'
			  				type:"AORG"
			  				
			  			}];
		  s.returnFunction=function(orgObj){
	  		  if(IsSpace(orgObj.ps) || null ==orgObj.ps )
	  		  	{
	  			   jQuery('#userid').val('');
	  			   jQuery('#username').val('');
	  			   jQuery('#orgid').val('');
	  			   jQuery('#orgname').val('');
	  			   
	  			 }else{
	  			 
	  				jQuery('#userid').val(orgObj.ps.id);
	  			    jQuery('#username').val(orgObj.ps.name);
	  				
	  				jQuery('#orgid').val(orgObj.dept.id);
	  				jQuery('#orgname').val(orgObj.dept.name);
	  				jQuery('#userandorg').val(orgObj.ps.name+orgObj.dept.name);
	  				if(!IsSpace(jQuery('#orgname').val()) && !IsSpace(jQuery('#username').val())){
	  					jQuery('#userandorg').val(orgObj.ps.name+","+orgObj.dept.name);
	  				}
	  				if(!IsSpace(jQuery('#orgname').val()) && !IsSpace(jQuery('#username').val()) ){
		  				if(!IsSpace(jQuery('#idea_info').val())){
		  					jQuery('#idea_info').val("");
		  				}
		  				var str ='     请'+jQuery('#orgname').val()+'会签 ';
	  					jQuery('#idea_info').val('  拟同意'+jQuery('#idea_info').val()+str);

	  					var str ='     请'+jQuery('#username').val()+'审定';
	  					jQuery('#idea_info').val(jQuery('#idea_info').val()+str);
	  				}else{
		  				if(!IsSpace(jQuery('#username').val())){
		  					if(!IsSpace(jQuery('#idea_info').val())){
			  					jQuery('#idea_info').val("");
			  				}
		  					var str ='     请'+jQuery('#username').val()+'审定';
		  					jQuery('#idea_info').val('  拟同意'+jQuery('#idea_info').val()+str);
		  				}
	
		  				if(!IsSpace(jQuery('#orgname').val())){
		  					if(!IsSpace(jQuery('#idea_info').val())){
			  					jQuery('#idea_info').val("");
			  				}
		  					var str ='     请'+jQuery('#orgname').val()+'会签 ';
		  					jQuery('#idea_info').val('  拟同意'+jQuery('#idea_info').val()+str);
		  				}
	  				}
	  			 }
	  	  }
		    s.init();
	}
	function adddeptanduser_receive(){
		 var s = new jQuery.z_tree_leftRigth();
		  s.treeID='button_envelop_username';
		  s.isShowSeacher="aa";
		  s.treeName="选取人员";
		  s.headerName="选取人员";
		  s.titelText = "选择人员";
		  s.rightHeaderText="已添加机构和人员";
		  s.isNewCommonUse=true;
		  s.treeList=[{
			  				'leftHeaderText':'按人员选择',
			  				valueKey:'ps',
			  				selectedIds:jQuery("#userid").val(),
			  				//type:'AORG'},
			  				type:"APERSON"},
					  	{
			  				'leftHeaderText':'按部门选择',
			  				'item_id' :'org_id',
			  				isType:'dept', 
			  				valueKey:'dept',
			  				selectedIds:jQuery("#orgid").val(),
			  				//type:'{"type":"24"}'
			  				type:"AORG"
			  				
			  			}];
		  s.returnFunction=function(orgObj){
	  		  if(IsSpace(orgObj.ps) || null ==orgObj.ps )
	  		  	{
	  			   jQuery('#userid').val('');
	  			   jQuery('#username').val('');
	  			   jQuery('#orgid').val('');
	  			   jQuery('#orgname').val('');
	  			   
	  			 }else{
	  			 
	  				jQuery('#userid').val(orgObj.ps.id);
	  			    jQuery('#username').val(orgObj.ps.name);
	  				
	  				jQuery('#orgid').val(orgObj.dept.id);
	  				jQuery('#orgname').val(orgObj.dept.name);
	  				jQuery('#userandorg').val(orgObj.ps.name+orgObj.dept.name);
	  				if(!IsSpace(jQuery('#orgname').val()) && !IsSpace(jQuery('#username').val())){
	  					jQuery('#userandorg').val(orgObj.ps.name+","+orgObj.dept.name);
	  				}
	  				if(!IsSpace(jQuery('#orgname').val()) && !IsSpace(jQuery('#username').val()) ){
		  				if(!IsSpace(jQuery('#idea_info').val())){
		  					jQuery('#idea_info').val("");
		  				}
		  				var str ='呈'+jQuery('#username').val()+'阅示,';
	  					jQuery('#idea_info').val(jQuery('#idea_info').val()+str);
		  				var str ='拟'+jQuery('#orgname').val()+'办理';
	  					jQuery('#idea_info').val('  '+jQuery('#idea_info').val()+str);

	  				
	  				}else{
	
		  				if(!IsSpace(jQuery('#orgname').val())){
		  					if(!IsSpace(jQuery('#idea_info').val())){
			  					jQuery('#idea_info').val("");
			  				}
		  					var str ='拟'+jQuery('#orgname').val()+'办理';
		  					jQuery('#idea_info').val('  '+jQuery('#idea_info').val()+str);
		  				}
		  				if(!IsSpace(jQuery('#username').val())){
		  					if(!IsSpace(jQuery('#idea_info').val())){
			  					jQuery('#idea_info').val("");
			  				}
		  					var str ='呈'+jQuery('#username').val()+'阅示';
		  					jQuery('#idea_info').val('  '+jQuery('#idea_info').val()+str);
		  				}
	  				}
	  			 }
	  	  }
		    s.init();
	}
	function adddeptanduser_send(){
		 var s = new jQuery.z_tree_leftRigth();
		  s.treeID='button_envelop_username';
		  s.isShowSeacher="aa";
		  s.treeName="选取人员";
		  s.headerName="选取人员";
		  s.titelText = "选择人员";
		  s.rightHeaderText="已添加机构和人员";
		  s.isNewCommonUse=true;
		  s.treeList=[{
			  				'leftHeaderText':'按人员选择',
			  				valueKey:'ps',
			  				selectedIds:jQuery("#userid").val(),
			  				//type:'AORG'},
			  				type:"APERSON"
			  				
			  			}];
		  s.returnFunction=function(orgObj){
	  		  if(IsSpace(orgObj.ps) || null ==orgObj.ps ){
	  			   jQuery('#userid').val('');
	  			   jQuery('#username').val('');
	  			 }else{
	  			 
	  				jQuery('#userid').val(orgObj.ps.id);
	  			    jQuery('#username').val(orgObj.ps.name);
	  				
	  				
	  				jQuery('#userandorg').val(orgObj.ps.name);
	  				if(!IsSpace(jQuery('#username').val())){
	  					jQuery('#userandorg').val(orgObj.ps.name);
	  				}
	  				if(!IsSpace(jQuery('#username').val()) ){
		  				if(!IsSpace(jQuery('#idea_info').val())){
		  					jQuery('#idea_info').val("");
		  				}
		  				var str ='请'+jQuery('#username').val()+'审签';
	  					jQuery('#idea_info').val(jQuery('#idea_info').val()+str);
	  				}else{
		  					if(!IsSpace(jQuery('#idea_info').val())){
			  					jQuery('#idea_info').val("");
			  				}
		  					var str ='请'+jQuery('#username').val()+'审签';
		  					jQuery('#idea_info').val('  '+jQuery('#idea_info').val()+str);
		  				}
	  				}
	  			 }
		    s.init();
	}

	function adddeptanduser_countersign(){
		 var s = new jQuery.z_tree_leftRigth();
		  s.treeID='button_envelop_username';
		  s.isShowSeacher="aa";
		  s.treeName="选取人员";
		  s.headerName="选取人员";
		  s.titelText = "选择人员";
		  s.rightHeaderText="已添加机构和人员";
		  s.isNewCommonUse=true;
		  s.treeList=[
					  	{
			  				'leftHeaderText':'按部门选择',
			  				'item_id' :'org_id',
			  				isType:'dept', 
			  				valueKey:'dept',
			  				selectedIds:jQuery("#orgid").val(),
			  				type:"AORG"
			  				
			  			}];
		  s.returnFunction=function(orgObj){
			  if(IsSpace(orgObj.dept) || null ==orgObj.dept )
	  		  	{
	  			   jQuery('#userid').val('');
	  			   jQuery('#username').val('');
	  			   jQuery('#orgid').val('');
	  			   jQuery('#orgname').val('');
	  			   
	  			 }else{
	  				jQuery('#orgid').val(orgObj.dept.id);
	  				jQuery('#orgname').val(orgObj.dept.name);
	  				jQuery('#userandorg').val(orgObj.dept.name);
	  				if(!IsSpace(jQuery('#orgname').val()) ){
	  					jQuery('#userandorg').val(orgObj.dept.name);
	  				}
	  				if(!IsSpace(jQuery('#orgname').val()) ){
		  				if(!IsSpace(jQuery('#idea_info').val())){
		  					jQuery('#idea_info').val("");
		  				}
		  				var str ='  请'+jQuery('#orgname').val()+'会签 ,办公室核稿,呈院领导审签';
	  					jQuery('#idea_info').val('  拟同意,'+jQuery('#idea_info').val()+str);

	  				}else{
		  				if(!IsSpace(jQuery('#orgname').val())){
		  					if(!IsSpace(jQuery('#idea_info').val())){
			  					jQuery('#idea_info').val("");
			  				}
		  					var str ='  请'+jQuery('#orgname').val()+'会签 ,办公室核稿,呈院领导审签';
		  					jQuery('#idea_info').val('  拟同意,'+jQuery('#idea_info').val()+str);
		  				}
	  				}
	  			 }
	  	  }
		    s.init();
	}
</script>
<title>输入意见信息</title>
</head>
<body >
<form id="form1" name="form1" method="post">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" style="padding-top: 10px;">
		<%if(!action_defid.equals("jyksyshouwen_wp1_act2")){ %>
				<tr>
					<td class="poptableLable" width="15%" align="right">常&nbsp;用&nbsp;意&nbsp;见：&nbsp;</td>
					<td><%=commonIdeaList %>
					</td>
				</tr>
		<%} %>
			<tr><td colspan="2" style="height: 5px;"></td></tr>
			<tr>
			<%if(!action_defid.equals("jyksyfawen_wp1_act8")){ %>
			  
				<td class="poptableLable" width="15%" align="center">部门与人员：</td>
				<td width="70%">
				 <INPUT class="validate[required] input_160" onmouseover="this.title=this.value"
							 id="userandorg" name="userandorg" 
							value=""
							readOnly  type="hidden" onclick='' >
						<input name="choosbtn" id="choosbtn" type="button"  value="会签单位和审批领导"  class="but_six" onmouseover="javascript:jQuery(this).attr('class','but_six_02');" onmouseout="javascript:jQuery(this).attr('class','but_six');" style="float:left;" />  
						
						<input type="hidden" id="userid" name="userid"/>
						<input type="hidden" id="username" name="username"/>
						
						<input type="hidden" id="orgid" name="orgid"/>
						<input type="hidden" id="orgname" name="orgname"/>
						
						</td>
						
				</tr>
			<%} %>
			<tr>
			<td colspan="2" style="height: 5px;"></td></tr>
			<tr>
				<td class="poptableLable" width="15%" align="right">意&nbsp;见&nbsp;信&nbsp;息：&nbsp;</td>
				<td  class="tableValue" width="70%" >
				<textarea class="validate[required,maxSize[500]]" rows="5"
				 style="width: 95%;overflow-y:auto; height: 150px;"  name="idea_info"
					id="idea_info"></textarea>
				</td>
			</tr>
		</table>
	<div class="cue_box_foot">
		<input  type="button" class="but_y_01" id="button_submit"  value="确定" /></span>
  	</div>
</form>
</body>
</html>