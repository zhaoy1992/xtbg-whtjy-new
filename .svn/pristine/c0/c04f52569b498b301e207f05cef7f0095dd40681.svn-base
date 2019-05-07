/*
函数:  Ok
说明:  提交添加与修改来文单位
参数:   无
返回值: 无
*/
function Ok() {
	
	//验证设备编号是否已经存在
	var dev_code = jQuery("#dev_code").val();
	var dev_oldcode = jQuery("#dev_oldcode").val();
	var user_orgname = jQuery("#user_orgname").val();
	var custos_username = jQuery("#custos_username").val();
	
	if(dev_code!=dev_oldcode){
		var flag = valiDevCode(dev_code);
		if(flag==true){
			alert("设备编号已存在！");
			return;
		}
	}
	var isFlag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
	if (isFlag){
		if(user_orgname == ""){
			alert("设备保管部门不能为空！");
			return;
		}else{
			if(custos_username == ""){
				alert("保管人不能为空！");
				return;
			}
		}
		jQuery("#hidden_action").val("addInfo");
		jQuery("#form1").attr("target","filetypeinfodoJSPhiddenFrame");
		jQuery("#form1").submit();
	}
}

/*
函数:  valiDevCode
说明:  验证设备编号是否已经存在
参数:   无
返回值: 无
*/
function valiDevCode(dev_code){
	var flag = false;
	//验证设备编号是否已经存在
	var url=path + "/ccapp/xtbg/tjy/device/jsp/checkDev_code.jsp";
	var params =  {dev_code:dev_code};
	jQuery.ajax({
		url: url,
		type: 'POST',
		dataType:'json',
		data: params,
		async:false,
		success: function(data){
			if(data.result==true){
				flag = true;
			} else {
				flag = false;
			}
		},
		error: function(jqXHR, textStatus, errorThrown){
			flag = false;
		}
	})
	return flag;
}

afterSubmitFn=function(result){
	try{
		if(result.indexOf("delete")!=-1){
			alert(result.split(",")[1]);
		}else{
			if(result.split(",").length>1){
					result = result.split(",");
					alert(result[0]);
					removeWindows("windowId", true);
			} else {
				alert(result);
				removeWindows("windowId", true);
			}
			
		}
	}catch(e){alert(e.description);}
};

function closed(){
	var p={
			headerText:'提示',
			okName:'确认',
	        okFunction:function(){
	        	removeWindows('windowId',true);
	        },
	        cancelName:'取消'
		};
		alert("返回后，数据将不会保存，确定返回？",p);
}

/**
 * 选取人员
 */
var chooseUserUnits = function(){
	var s = new jQuery.z_tree();
	  s.treeID='mian';
	  s.treetypestr="radio";
	  s.ischekc="false";
	  s.isShowSeacher=true;
	  s.treeName="选取人员";
	  s.headerName="选取人员";
	  s.type="APERSON";
	  s.selectedIds = jQuery('#custos_userid').val();
	  s.returnFunction=function(orgObj){
		  jQuery('#custos_userid').val(orgObj.id);
		  jQuery('#custos_username').val(orgObj.name);
	  }
  	 s.init();
}	

/**
 * 选取机构
 */
var chooseOrgUnits = function(){
	var s = new jQuery.z_tree();
	  s.treeID='mian';
	  s.treetypestr="radio";
	  s.ischekc="false";
	  s.isShowSeacher=true;
	  s.treeName="选取机构";
	  s.headerName="选取机构";
	  s.isType='dept';
	  s.type="AORG";
	  s.item_id = 'org_id';
	  s.selectedIds = jQuery('#user_orgid').val();
	  s.returnFunction=function(orgObj){
		  jQuery('#user_orgid').val(orgObj.id);
		  jQuery('#user_orgname').val(orgObj.name);
	  }
  	 s.init();
}	

//添加物品
function Add_Row4NewDay1(){
	var firstTr = jQuery("[name=dayrow]").first().clone();
	
	jQuery(firstTr).find("input[type=text]").val("");
	
	jQuery(firstTr).find("input[type=hidden]").val("");
	
	firstTr.find("input[type=text]").val("");
	
	
	var dayTable = jQuery("#dayTable");
	
	firstTr.appendTo(dayTable);
	
	jQuery(firstTr).find(".date_187").each(function(i,e){
		setDataTimeClickShowOrHide($(this).attr("id"),window);
	})
}
//删除物品
function deleteDay(tag,goodsId){
	
	var intable=jQuery(tag).parents("table");
	var tr=jQuery(tag).parents("tr").first();
	var trsize= jQuery(intable).find("tr[name=dayrow]").size();
	if(trsize==1){
		Add_Row4NewDay1();
		jQuery(tr).remove();
	}else{
		jQuery(tr).remove();
	}
}
function viewmypic(a) {
	jQuery("#sshowimg").val(jQuery("#imgfile").val());
   var str = a.value;
   if(/\.(gif|jpg|jpeg|png|GIF|JPG|PNG)$/.test(str))
   {
		var Preview = document.getElementById("Preview");         
		jQuery('#showimg').hide();
		jQuery('#csimg').hide();
		Preview.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = a.value; 
		Preview.style.width = "250px";             
		Preview.style.height = "160px";
   }
   savePic();
}

/*
 * 说明：文件上传事件 参数：无 返回值：无 作者：jichang.long
 */
function savePic(){
	var f=jQuery("sshowimg").val();
	var real =jQuery("#imgfile");// BMP、JPG、JPEG、PNG、GIF
	var cloned = real.clone(true);
	real.hide();
	cloned.insertAfter(real);
	jQuery("#form_up").empty();
	real.appendTo("#form_up");
	if(t_id!=""){
		var okF = function(){
			jQuery("#form_up").submit(); 
		}
	 var p={
			headerText:'提示',
			okName:'确认',
		    okFunction:okF,
		    cancelName:'取消'
		};
	alert('点击确定,以前照片将会丢失.',p);
	}else{
		jQuery("#form1").attr("target","filetypeinfodoJSPhiddenFrame1");
		jQuery("#form_up").submit(); 
	}
}