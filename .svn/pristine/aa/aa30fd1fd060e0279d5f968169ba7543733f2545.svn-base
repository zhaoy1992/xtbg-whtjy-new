  /*
  函数:  btnClickFn
  说明:  新建上报信息
  */
var btnClickFn = function(btnObj){
	try{
		btnObj.disabled=true;
		flag = btnObj.name;
		//新建
		if(flag =='AddOne'){
			urlTmp="&loadurl=paperlist4reported&actionName=insert";
			toNewPage(urlTmp,btnObj.value);
		}else if(flag==='SendAdd'){
			var ids = "";
		    var selectedIds = jQuery("#gridTable").jqGrid("getGridParam", "selarrrow");
		    var ids = new Array();
		    jQuery(selectedIds).each(function () {
		        var model = jQuery("#gridTable").jqGrid('getRowData', this);
		        ids.push(model.p_manage_id);
		    });
		    if (!ids.length) {
		        alert("未选中信息项，请重新选择要补发的信息项！");
		    } else {
			    openAlertWindows('papersendadd', getCurrentFilePath() +'papersendadd.jsp?p_manage_ids='+ids.join(",")+'&windowId=papersendadd', '选择发送方式' ,780,450,'10%','10%');
		    }
		}else if(flag==='SendMsg'){
			var ids = "";
		    var selectedIds = jQuery("#gridTable").jqGrid("getGridParam", "selarrrow");
		    var ids = new Array();
		    jQuery(selectedIds).each(function () {
		        var model = jQuery("#gridTable").jqGrid('getRowData', this);
		        ids.push(model.p_manage_id);
		    });
		    if (!ids.length) {
		        alert("未选中信息项，请重新选择要发送的信息项！");
		    } else {
			    openAlertWindows('papersendtypechange', getCurrentFilePath() +'papersendtypechange.jsp?p_manage_ids='+ids.join(",")+'&windowId=papersendtypechange', '选择发送方式' ,780,260,'10%','10%');
		    }
		}else if(flag==='AddOne4Acc'){
			urlTmp="&loadurl=paperlist4manageaccepted&actionName=AddOne4Acc";
			toNewPage2(urlTmp,btnObj.value);
		}else if(flag==='AddOne4Published'){
			urlTmp="&loadurl=paperlist4publishok&actionName=AddOne4Published";
			toNewPage2(urlTmp,btnObj.value);
		}else if(flag==='BatchAcc'){//指信息采编
		    var ids = "";
		    var selectedIds = jQuery("#gridTable").jqGrid("getGridParam", "selarrrow");
		    var ids = new Array();
		    jQuery(selectedIds).each(function () {
		        var model = jQuery("#gridTable").jqGrid('getRowData', this);
		        ids.push(model.p_manage_id);
		    });
		    if (!ids.length) {
		        alert("未选中信息项，请重新选择要删除的信息项！");
		    } else {
		        var okF = function () {
		            jQuery.ajax({
		                type: "post",
		                url: "paperlist4reporteddetaildo.jsp",
		                contentType: "application/x-www-form-urlencoded; charset=utf-8",
		                data: {
		                    action: "accpaper4pending",
		                    ids: ids.join(",") //要删除的id列表      
		                },
		                dataType: "json",
		                success: function (result) {
		                    if (result.flag) {
		                        alert("操作成功！");
		                        search();
		                    } else {
		                        alert("操作失败！");
		                    }
		                },
		            });
		        }
		        var p = {
		            headerText: '提示',
		            okName: '确认',
		            okFunction: okF,
		            cancelName: '取消'
		        };
		        alert("确定采编信息吗？", p);
		    }

		}else if(flag==='Delete'){
			var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
			if(selectedIds.length>0){
				deleteList = '';
				for ( var i = 0; i < selectedIds.length; i++){
					model = jQuery("#gridTable").jqGrid('getRowData', selectedIds[i]);
					deleteList+=model.p_manage_id+",";
				}
				var okF = function(){
					$("#hidden_action").val("deletepaperlist4draftdetail");
					$("#hidden_delete").val(deleteList);
					$("#onlyFrom").submit();
				}
				var p={
						headerText:'提示',
						okName:'确认',
				        okFunction:okF,
				        cancelName:'取消'
				};
			    alert("确定要删除该信息吗？",p);
			}else{
				alert("请选择数据");
			}
		//修改
		}
		btnObj.disabled=false;
	}catch(e){
		btnObj.disabled=false;
	}
};
/*
函数:  toNewPage
说明:  页面跳转
*/
var toNewPage = function (urlTmp,pageName){
	pageCode = "paperlist4reporteddetail";
	baseUrl = "paperlist4reporteddetail.jsp?subid="+pageCode;
	if(urlTmp){
		baseUrl = baseUrl+urlTmp;
	}
	openWindows(pageCode,pageName,baseUrl,pageCode,false,window);
};

/*
函数:  toNewPage
说明:  页面跳转
*/
var toNewPage2 = function (urlTmp,pageName){
	pageCode = "paperlist4managedetail";
	baseUrl = "paperlist4managedetail.jsp?subid="+pageCode;
	if(urlTmp){
		baseUrl = baseUrl+urlTmp;
	}
	openWindows(pageCode,pageName,baseUrl,pageCode,false,window);
};


/*
函数:  getWhere4Date
说明:  得到起始日期
*/
var getWhere4Date = function() {
	var bt = jQuery("#begin_time").val();
	var et = jQuery("#end_time").val();
	var re = (isSpace(bt+et))?"":bt+","+et;
	return re;
}

/*
函数:  chooseOrg
说明:  选部门
*/
var chooseOrg = function (){
	var s = new $.z_tree();
	s.treeID='mian';
	s.treetypestr='radio';
	s.isShowSeacher=true;
	s.treeName="选取部门";
	s.isType='dept';
	s.headerName="选取部门";
	s.item_id = 'org_id';
	s.selectedIds=$('#p_rep_unit_id').val();
	s.type='ADEPT';
	s.returnFunction=function(orgObj){
		if(!IsSpace(orgObj)){
		    $('#p_rep_unit_name').val(orgObj.name);
		    $('#p_rep_unit_id').val(orgObj.id);
		}else{
		    $('#p_rep_unit_name').val("");
		    $('#p_rep_unit_id').val("");
		}
	}
	s.init();
}
