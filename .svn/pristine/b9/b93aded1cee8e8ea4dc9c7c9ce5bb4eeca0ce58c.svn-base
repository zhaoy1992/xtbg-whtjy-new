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
	sql.append("select Idea_Content,Idea_Content from TA_OA_DOCUMENT_COMIDEA order by idea_id");

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
<!-- 引入jQuery UI -->
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
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
	
	//tab控制
	var ssbtest = {'aa1':'name'};
	jQuery("#sign_titleids").css('display','block');
	jQuery('#sign_tabs1').tabs();
	
	
	var content ="";
	jQuery("select[id*=common_idea]").change(function(){
		if(jQuery("#common_idea").val() == '只签名'){
			jQuery("#idea_info").val(content);
		}else{
			jQuery("#idea_info").val(jQuery("#common_idea").val());
		}
		if(jQuery("#idea_info").val() == content){
			jQuery("#idea_info").attr("disabled",true);
		}else{
			jQuery("#idea_info").attr("disabled",false);
		}
	}); 
	jQuery("#button_submit").bind("click",onsubmit);
	jQuery("#idea_info").focus();
	jQuery("#idea_info").val(deleteIdeaWithFormat(getParentWindow("").jQuery('#action_handeridea').val()));
	jQuery('#userid').val(getParentWindow("").jQuery('#userid').val());
	jQuery('#username').val(getParentWindow("").jQuery('#username').val());
	jQuery('#orgid').val(getParentWindow("").jQuery('#orgid').val())
	jQuery('#orgname').val(getParentWindow("").jQuery('#orgname').val());
	if(!IsSpace(getParentWindow("").jQuery('#orgname').val()) && !IsSpace(getParentWindow("").jQuery('#username').val())){
			jQuery('#userandorg').val(getParentWindow("").jQuery('#username').val()+","+getParentWindow("").jQuery('#orgname').val());
	}else{
		jQuery('#userandorg').val(getParentWindow("").jQuery('#username').val()+getParentWindow("").jQuery('#orgname').val());
	}

	//按钮控制start
	if("<%=action_defid%>" == "jyksyshouwen_wp1_act2"){
		jQuery("#choosbtn").val("会签单位和审批领导");
		jQuery("#choosbtn").click(function() {  
			adddeptanduser_receive();
		});
		//jyksyfawen_wp1_act2
	}else if("<%=action_defid%>" == "jyksyfawen_wp1_act2" || "<%=action_defid%>" == "jyksyfawen_wp1_act4"){
		jQuery("#choosbtn").val("会签单位和审批领导");
		jQuery("#choosbtn").click(function() {  
			adddeptanduser();
			
		});
	}else if("<%=action_defid%>" == "jyksyfawen_wp1_act4"){
		jQuery("#choosbtn").val("会签单位");
		jQuery("#choosbtn").click(function() {  
			adddeptanduser_countersign();
			
		});
	}
	//发文的办公室主任审核
	else if("<%=action_defid%>" == "jyksyfawen_wp1_act6"){
		jQuery("#choosbtn").val("审批领导");
		jQuery("#choosbtn").click(function() {  
			adddeptanduser_send();
			
		});
	//请批件处室意见环节意见
	} else if("<%=action_defid%>" == "jyksyqpj_wp1_act3"||"<%=action_defid%>" == "jyksyqpj_wp1_act4" || "<%=action_defid%>" == "jyksyqpj_wp1_act10"){
		jQuery("#choosbtn").val("会签单位和审批领导");
		jQuery("#choosbtn").click(function() {  
			adddeptanduserSign();
		});
	}//收文领导批示意见环节
	else if("<%=action_defid%>" == "jyksyshouwen_wp1_act3"){
		jQuery("#choosbtn").val("部门和人员");
		jQuery("#choosbtn").click(function() {  
			addLeadUserOrg();
		});
	} else{
		jQuery("#choosbtn").val("会签单位和审批领导");
		jQuery("#choosbtn").click(function() {  
			adddeptanduser();
		});
	}
	//按钮控制end
	
});
	function onsubmit(){
		if(!IsSpace(jQuery("#idea_info").val())){
				if(IsSpace(getParentWindow("").jQuery("#action_handeridea").val())){
					if("jyksyqpj_wp1_act11" == "<%=action_defid%>" ||
					   "jyksyqpj_wp1_act12" == "<%=action_defid%>" ||
					   "jyksyqpj_wp1_act7"  == "<%=action_defid%>" ||
					   "jyksyshouwen_wp1_act3" == "<%=action_defid%>" || 
					   "jyksyfawen_wp1_act7" == "<%=action_defid%>"|| 
					   "jyksyfawen_wp1_act8" =="<%=action_defid%>" ){
						getParentWindow("").jQuery("#action_handeridea").val(createIdeaWithFormat(jQuery("#idea_info").val(),"\n<%=user_name%>   <%=DateUtil.getCurrentDate_Time_Day()%>"));	   
					}else{
						getParentWindow("").jQuery("#action_handeridea").val(createIdeaWithFormat(jQuery("#idea_info").val(),"\n<%=user_orgName%>  <%=user_name%>   <%=DateUtil.getCurrentDate_Time_Day()%>"));
					}
				}else{
					getParentWindow("").jQuery("#"+ideatextid).html("");
					if("jyksyqpj_wp1_act11" == "<%=action_defid%>" ||
							   "jyksyqpj_wp1_act12" == "<%=action_defid%>" ||
							   "jyksyqpj_wp1_act7"  == "<%=action_defid%>" ||
							   "jyksyshouwen_wp1_act3" == "<%=action_defid%>" || 
							   "jyksyfawen_wp1_act7" == "<%=action_defid%>"|| 
							   "jyksyfawen_wp1_act8" =="<%=action_defid%>" ){
						getParentWindow("").jQuery("#action_handeridea").val(createIdeaWithFormat(jQuery("#idea_info").val(),"\n<%=user_name%>  <%=DateUtil.getCurrentDate_Time_Day()%>"));
					}else{
						getParentWindow("").jQuery("#action_handeridea").val(createIdeaWithFormat(jQuery("#idea_info").val(),"\n<%=user_orgName%>  <%=user_name%>  <%=DateUtil.getCurrentDate_Time_Day()%>"));
					}
				}
		} else {
			getParentWindow("").jQuery("#action_handeridea").val("");
		}
		getParentWindow("").jQuery('#userid').val(jQuery('#userid').val());
		getParentWindow("").jQuery('#username').val(jQuery('#username').val());
		getParentWindow("").jQuery('#orgid').val(jQuery('#orgid').val());
		getParentWindow("").jQuery('#orgname').val(jQuery('#orgname').val());
		getParentWindow("").createIdeaInfo();
		removeAlertWindows('',true)
	}

	function createIdeaWithFormat(idea_title,idea_content){
		var idea = '<ol><li class="idea_title">' + idea_title + '</li></ol><ol><li class="idea_content">' + idea_content +'</li></ol>';
		return idea;
	}
	function deleteIdeaWithFormat(idea){
		//var reg=new RegExp("<ol><li.*>(.*)</li></ol><ol><li.*>\n?(.*)</li></ol>"); //创建正则RegExp对象
		var reg=new RegExp('<ol><li class=\"idea_title\">(.*(.\n*.*)*)</li></ol><ol><li class=\"idea_content\">\n?(.*)</li></ol>','g');   
		var idea_temp = idea.replace(reg,'$1');
		//alert(idea);
		return idea_temp;
		//alert(idea)
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
	  				//得到用户职务职称
	  				getUserDuties(orgObj.ps.id);
	  				
	  				jQuery('#orgid').val(orgObj.dept.id);
	  				jQuery('#orgname').val(orgObj.dept.name);
	  				jQuery('#userandorg').val(orgObj.ps.name+orgObj.dept.name);
	  				if(!IsSpace(jQuery('#orgname').val()) && !IsSpace(jQuery('#username').val())){
	  					jQuery('#userandorg').val(orgObj.ps.name+","+orgObj.dept.name);
	  				}
		  				if(!IsSpace(jQuery('#idea_info').val())){
		  					jQuery('#idea_info').val("");
		  				}
		  				
		  				var str1 = jQuery('#username').val();
		  				var Str2 = jQuery('#orgname').val()
		  				if(!IsSpace(jQuery('#orgname').val()) && !IsSpace(jQuery('#username').val())){
			  				var str ='     请'+replac(jQuery('#username').val())+"、"+replac(jQuery('#orgname').val())+'会签，办公室核稿，呈院领导审签。';
		  					jQuery('#idea_info').val('  拟同意。'+jQuery('#idea_info').val()+str);
		  				}else{
		  					var str ='     请'+replac(jQuery('#username').val())+replac(jQuery('#orgname').val())+'会签，办公室核稿，呈院领导审签。';
		  					jQuery('#idea_info').val('  拟同意。'+jQuery('#idea_info').val()+str);
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
	  				//得到用户职务职称
	  				getUserDuties(orgObj.ps.id);
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
		  			
		  				var str ='呈'+replac(jQuery('#username').val())+'阅示，';
	  					jQuery('#idea_info').val(jQuery('#idea_info').val()+str);
		  				var str ='拟'+replac(jQuery('#orgname').val())+'办理。';
	  					jQuery('#idea_info').val('  '+jQuery('#idea_info').val()+str);

	  				
	  				}else{
	
		  				if(!IsSpace(jQuery('#orgname').val())){
		  					if(!IsSpace(jQuery('#idea_info').val())){
			  					jQuery('#idea_info').val("");
			  				}
		  					var str ='  拟'+replac(jQuery('#orgname').val())+'办理。';
		  					jQuery('#idea_info').val('  '+jQuery('#idea_info').val()+str);
		  				}
		  				if(!IsSpace(jQuery('#username').val())){
		  					if(!IsSpace(jQuery('#idea_info').val())){
			  					jQuery('#idea_info').val("");
			  				}
		  					var str ='呈'+replac(jQuery('#username').val())+'阅示，';
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
	  				//得到用户职务职称
	  				getUserDuties(orgObj.ps.id);
	  				
	  				jQuery('#userandorg').val(orgObj.ps.name);
	  				if(!IsSpace(jQuery('#username').val())){
	  					jQuery('#userandorg').val(orgObj.ps.name);
	  				}
	  				if(!IsSpace(jQuery('#username').val()) ){
		  				if(!IsSpace(jQuery('#idea_info').val())){
		  					jQuery('#idea_info').val("");
		  				}
		  				var str ='请'+jQuery('#username').val()+'审签。';
	  					jQuery('#idea_info').val(jQuery('#idea_info').val()+str);
	  				}else{
		  					if(!IsSpace(jQuery('#idea_info').val())){
			  					jQuery('#idea_info').val("");
			  				}
		  					var str ='请'+jQuery('#username').val()+'审签。';
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
		  				var str ='  请'+jQuery('#orgname').val()+'会签 ，';
	  					jQuery('#idea_info').val('  拟同意。'+jQuery('#idea_info').val()+str);

	  				}else{
		  				if(!IsSpace(jQuery('#orgname').val())){
		  					if(!IsSpace(jQuery('#idea_info').val())){
			  					jQuery('#idea_info').val("");
			  				}
		  					var str ='  请'+jQuery('#orgname').val()+'会签 ,办公室核稿,呈院领导审签。';
		  					jQuery('#idea_info').val('  拟同意。'+jQuery('#idea_info').val()+str);
		  				}
	  				}
	  			 }
	  	  }
		    s.init();
	}

	//请批件处室意见环节意见
	function adddeptanduserSign(){
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
	  				
	  			    //获取院领导简称
	  				getUserLead(orgObj.ps.id);
	  				
	  				jQuery('#orgid').val(orgObj.dept.id);
	  				jQuery('#orgname').val(orgObj.dept.name);
	  				jQuery('#userandorg').val(orgObj.ps.name+orgObj.dept.name);
	  				if(!IsSpace(jQuery('#orgname').val()) && !IsSpace(jQuery('#username').val())){
	  					jQuery('#userandorg').val(orgObj.ps.name+","+orgObj.dept.name);
	  				}
		  				if(!IsSpace(jQuery('#idea_info').val())){
		  					jQuery('#idea_info').val("");
		  				}
		  				
		  				var str1 = jQuery('#username').val();
		  				var Str2 = jQuery('#orgname').val();
		  				//最大院领导
						if((!IsSpace(jQuery('#username').val()) ||!IsSpace(jQuery('#orgname').val()))&&!IsSpace(jQuery('#leadUserName').val())&&!IsSpace(jQuery('#leadMaxUserName').val())){
		  					var str ='     请';
								//部门和人员
		  					if(!IsSpace(jQuery('#username').val()) &&!IsSpace(jQuery('#orgname').val())){
								 str +=replac(jQuery('#username').val())+"、"+replac(jQuery('#orgname').val())+'会签，';
								//部门
							} else if(!IsSpace(jQuery('#orgname').val())){
								 str +=replac(jQuery('#orgname').val())+'会签，';
								//人员
							} else if(!IsSpace(jQuery('#username').val())){
								 str +=replac(jQuery('#username').val())+'会签，';
							}
							
		  					str+='请'+replac(jQuery('#leadUserName').val())+'审示，' + "呈"+ jQuery('#leadMaxUserName').val()+"审定。";
		  					jQuery('#idea_info').val('  拟同意。'+jQuery('#idea_info').val()+str);
		  				//只有领导的情况
						} else  if((!IsSpace(jQuery('#username').val()) ||!IsSpace(jQuery('#orgname').val()))&&!IsSpace(jQuery('#leadUserName').val())){
								var str ='     请';
								//部门和人员
			  					if(!IsSpace(jQuery('#username').val()) &&!IsSpace(jQuery('#orgname').val())){
									 str +=replac(jQuery('#username').val())+"、"+replac(jQuery('#orgname').val())+'会签，';
									//部门
								} else if(!IsSpace(jQuery('#orgname').val())){
									 str +=replac(jQuery('#orgname').val())+'会签，';
									//人员
								} else if(!IsSpace(jQuery('#username').val())){
									 str +=replac(jQuery('#username').val())+'会签，';
								}
			  					str+='请'+replac(jQuery('#leadUserName').val())+'审示。';
			  					jQuery('#idea_info').val('  拟同意。'+jQuery('#idea_info').val()+str);
			  			//没有选择领导的情况
						} else if(!IsSpace(jQuery('#username').val()) ||!IsSpace(jQuery('#orgname').val())){
							var str ='     请';
							//部门和人员
		  					if(!IsSpace(jQuery('#username').val()) &&!IsSpace(jQuery('#orgname').val())){
								 str +=replac(jQuery('#username').val())+"、"+replac(jQuery('#orgname').val())+'会签。';
								//部门
							} else if(!IsSpace(jQuery('#orgname').val())){
								 str +=replac(jQuery('#orgname').val())+'会签。';
								//人员
							} else if(!IsSpace(jQuery('#username').val())){
								 str +=replac(jQuery('#username').val())+'会签。';
							}
		  					jQuery('#idea_info').val('  拟同意。'+jQuery('#idea_info').val()+str);
						} 
						else if(!IsSpace(jQuery('#leadUserName').val())||!IsSpace(jQuery('#leadMaxUserName').val())){
							var str ='';
							//选领导的情况和最大院领导
							if(!IsSpace(jQuery('#leadUserName').val())&&!IsSpace(jQuery('#leadMaxUserName').val())){
								str ='请'+replac(jQuery('#leadUserName').val())+'审示，' + "呈"+ jQuery('#leadMaxUserName').val()+"审定。";
							}
							//院领导的情况
							if(!IsSpace(jQuery('#leadUserName').val())&&IsSpace(jQuery('#leadMaxUserName').val())){
								str ='请'+replac(jQuery('#leadUserName').val())+'审示。';
							}
							//最大院领导
							if(IsSpace(jQuery('#leadUserName').val())&&!IsSpace(jQuery('#leadMaxUserName').val())){
								str ="呈"+ jQuery('#leadMaxUserName').val()+"审定。";
							}
		  					jQuery('#idea_info').val('  拟同意。'+jQuery('#idea_info').val()+str);
						} 
	  				}
	  			 }
		    s.init();
	}
	
	//收文领导批示环节 选择人员和部门
	function addLeadUserOrg(){
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
		  			
		  				var str =replac(jQuery('#username').val())+'，';
	  					jQuery('#idea_info').val(jQuery('#idea_info').val()+str);
		  				var str =replac(jQuery('#orgname').val());
	  					jQuery('#idea_info').val('  '+jQuery('#idea_info').val()+str);

	  				
	  				}else{
	
		  				if(!IsSpace(jQuery('#orgname').val())){
		  					if(!IsSpace(jQuery('#idea_info').val())){
			  					jQuery('#idea_info').val("");
			  				}
		  					var str =replac(jQuery('#orgname').val());
		  					jQuery('#idea_info').val('  '+jQuery('#idea_info').val()+str);
		  				}
		  				if(!IsSpace(jQuery('#username').val())){
		  					if(!IsSpace(jQuery('#idea_info').val())){
			  					jQuery('#idea_info').val("");
			  				}
		  					var str =replac(jQuery('#username').val());
		  					jQuery('#idea_info').val('  '+jQuery('#idea_info').val()+str);
		  				}
	  				}
	  			 }
	  	  }
		    s.init();
	}
	function replac(str){
		return str.replaceAll(',','、');  
	}
	
	//加载手写意见
	function changeIndex(index)
	{
		var action_defid = '<%=action_defid%>';
		if(index == 3)
		{
			if (IsSpace(jQuery("#iframe_HWPenSign").attr("src")))
			{
				jQuery("#iframe_HWPenSign").attr("src","../../../public/workflow/jsp/HWPenSign.jsp");
				 
			}
		}
	}
	/*
	函数:   getUserDuties
	说明:   获取用户的职务简称
	参数:   无
	返回值: Json
	*/
	function getUserDuties(){
		var userid = jQuery("#userid").val();
		var url="getUserduties.jsp";
		var params =  {userId:userid};
		jQuery.ajax({
			url: url,
			type: 'POST',
			dataType:'json',
			data: params,
			async:false,
			success: function(data){
				jQuery('#username').val(data.resultStr);
			},
			error: function(jqXHR, textStatus, errorThrown){
			}
		})
	}
	
	/*
	函数:   getUserDuties
	说明:   获取用户的职务简称
	参数:   无
	返回值: Json
	*/
	function getUserLead(){
		var userid = jQuery("#userid").val();
		var url="getUserLead.jsp";
		var params =  {userId:userid};
		jQuery.ajax({
			url: url,
			type: 'POST',
			dataType:'json',
			data: params,
			async:false,
			success: function(data){
				jQuery('#username').val(data.username);
				jQuery('#leadUserName').val(data.leadUserName);
				jQuery('#leadMaxUserName').val(data.leadMaxUserName);
			},
			error: function(jqXHR, textStatus, errorThrown){
			}
		})
	}
</script>
<title>输入意见信息</title>
</head>
<body >
<form id="form1" name="form1" method="post">
<div id="sign_tabs1" style="width:99%">

	<div id="sign_titleids" style="display: none;">
		<ul>
			<li><a href="#sign_tabs-1" onclick="changeIndex(1)">常用意见</a></li>
			<!-- <li><a href="#sign_tabs-3" title="点击手写意见"
				onclick="changeIndex(3)">手写意见</a></li>
			-->
		</ul>
	</div>
	<div id="sign_tabs-1">
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
			<%if(!action_defid.equals("jyksyfawen_wp1_act8") 
					&&!action_defid.equals("jyksyfawen_wp1_act7")
					&&!action_defid.equals("jyksyqpj_wp1_act11")
					&&!action_defid.equals("jyksyqpj_wp1_act12")
					&&!action_defid.equals("jyksyqpj_wp1_act7")){ %>
			  
				<td class="poptableLable" width="15%" align="center">部门与人员：</td>
				<td width="70%">
				 <INPUT class="validate[required] input_160" onmouseover="this.title=this.value"
							 id="userandorg" name="userandorg" 
							value=""
							readOnly  type="hidden" onclick='' >
						<input name="choosbtn" id="choosbtn" type="button"  value="会签单位和审批领导"  class="but_six" onmouseover="javascript:jQuery(this).attr('class','but_six_02');" onmouseout="javascript:jQuery(this).attr('class','but_six');" style="float:left;" />  
						
						<input type="hidden" id="userid" name="userid"/>
						<input type="hidden" id="username" name="username"/>
						<input type="hidden" id="leadUserName" name="leadUserName"/>
						<input type="hidden" id="leadMaxUserName" name="leadMaxUserName"/>
						
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
  	</div>
  	<!-- 
	 <div id="sign_tabs-3"> <input type="hidden" name="doc_content" id="doc_content" value=""> 
		<iframe id="iframe_HWPenSign" frameborder="0" scrolling="no" width="100%" height="1000"></iframe>
	 </div>
	 -->
</form>
</body>
</html>