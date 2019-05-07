var ts=300;//异步延时控制0.3秒

/*
函数:  chooseFileType
说明:  选择分类
参数：   name 赋值框的id
treetypestr 单选框或者多选框
*/
var chooseFileType = function (typeid,typename,typeno,treetypestr,f){
	var s = new jQuery.z_tree();
	s.treeID = 'mianType';
	s.treetypestr = treetypestr;
	s.isShowSeacher = true;
	s.treeName = "选择分类";
	s.headerName = "选择分类";
	s.type = "KBM_TYPE";
	s.isType="person";
	s.selectedIds = jQuery("#"+typeid).val(),
	s.f_org_id = k_unit;//所属单位id 全局的js变量 引用时注意
	s.returnFunction = function(n,object){    
	    try{
	    	if(IsSpace(object)){
	    		jQuery("#"+typeid).val("");
		    	jQuery("#"+typename).val("");
	    	}else{
	    		if(!IsSpace(typeno)){
	    			for(var i=0 ; i<typeno.length;i++ ){
	    				if(typeno[i] == object[0].id){
	    					alert("该末级分类已有编制文件，请重新选择！");
	    					chooseFileType("k_type_id","k_type_name",typeno,"radio",true);
	    				}else{
	    					jQuery("#"+typeid).val(object[0].id);
	    					jQuery("#"+typename).val(object[0].name);
	    				}
	    			}	
	    		}else{
					jQuery("#"+typeid).val(object[0].id);
					jQuery("#"+typename).val(object[0].name);
	    		}
	    	}
	    }catch(e){
	    }
	}
	s.init();
};

/*
函数:  deleteFn
说明:  删除
参数:  无
返回值: 无
*/
var deleteFn = function (id) {
    var ids = "";
    var selectedIds = jQuery("#gridTable").jqGrid("getGridParam", "selarrrow");
    var ids = new Array();
    jQuery(selectedIds).each(function () {
        var model = jQuery("#gridTable").jqGrid('getRowData', this);
        ids.push(model.k_doc_id);
    });
    if (!ids.length) {
        alert("未选中文件项，请重新选择要删除的文件项！");
    } else {
        var okF = function () {
            jQuery.ajax({
                type: "post",
                url: "kbmdocdetaildo.jsp",
                contentType: "application/x-www-form-urlencoded; charset=utf-8",
                data: {
                    action: "delete",
                    ids: ids.join(",") //要删除的id列表      
                },
                dataType: "json",
                success: function (result) {
                    if (result) {
                        alert("操作成功！");
                        search();
                    } else {
                        alert("操作失败！");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("系统异常，请稍后再试！");
                }
            });
        }
        var p = {
            headerText: '提示',
            okName: '确认',
            okFunction: okF,
            cancelName: '取消'
        };
        alert("删除后将不能恢复，确定删除吗？", p);
    }
}

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
函数:  addSuggest
说明:  添加推荐
参数:  无
返回值: 无
*/
var addSuggest = function (userids,k_doc_id) {
    var okF = function () {
        jQuery.ajax({
            type: "post",
            url: "kbmdocdetaildo.jsp",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            data: {
                action: "addsuggest",
                k_doc_id:k_doc_id,
                userids: userids //要删除的id列表      
            },
            dataType: "json",
            success: function (result) {
                if (result) {
                    alert("操作成功！");
                } else {
                    alert("操作失败！");
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("系统异常，请稍后再试！");
            }
        });
    }
    var p = {
        headerText: '提示',
        okName: '确认',
        okFunction: okF,
        cancelName: '取消'
    };
    alert("确定推荐吗？", p);
}

/*
函数:  根据编码规则是否存在数据 来判断 上传类型 【上传】和【更新】
说明:  改变 上传类型  编码规则  第二个【-】前面相同，或者第二个【-】没有取所有编号
参数:  无
返回值: 无
*/
var changeUploadType = function(){
	var k_code = jQuery("#k_code").val();
	var url="ajaxcheckkbmcode.jsp";
	var params =  {k_code:k_code};
	jQuery.ajax({
		url: url,
		type: 'POST',
		dataType:'json',
		data: params,
		async:false,
		success: function(data){
			if(data.isExits==true){
				jQuery("#k_upload_type option[value='更新']").attr("selected","selected");
			} else {
				jQuery("#k_upload_type option[value='新增']").attr("selected","selected");
			}
		},
		error: function(jqXHR, textStatus, errorThrown){
			jQuery("#k_upload_type option[value='新增']").attr("selected","selected");
		}
	})
}