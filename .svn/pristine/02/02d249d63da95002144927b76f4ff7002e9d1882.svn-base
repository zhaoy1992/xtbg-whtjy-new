/*
	文件：extendarchive.js
	描述：公文扩展JS，请在此扩展
	作者：shuqi.liu
	日期：2013-10-27
*/

//自定义加载,WebOpen之前
function extinitbefor(busiTypeCode){
	
}


//自定义加载,WebOpen之后
function extinitafter(busiTypeCode){
	//湖南省政府转办处理
	if(busiTypeCode == "hnsbgt_gwbl"){
		//extzhuanbandan();
	}
	//湖南省政府收文处理机构分配
	if(busiTypeCode == "hnsbgt_lwdj"){
		//extorgselect();
	}
	//财政厅 浏阳单位信息变更流程 公文加载数据
	if(busiTypeCode == "uuid_1029"){
		var parms = jQuery("#extParms").val();
		var p = parms.split(",");
		if(busiTypeCode=="uuid-880606" && parms){//浏阳市财政综合业务系统信息变更流程
			var iWebOffice = document.getElementsByName("WebOffice")[0];
			//url:"<%=path%>"+"/ccapp/xtbg/caizhengting/unitmanager/jsp/queryunituserinfodo.jsp",
			//异步查询单位人员信息
			jQuery.ajax({
				url:jQuery("#path").val()+"/ccapp/xtbg/caizhengting/unitmanager/jsp/queryunituserinfodo.jsp",
				dataType:"text",
				type:"post",
				data:{"busid":p[0]},
				success:function(data){
					var arr = eval(data);
					if(arr){
						for(var i = 0; i < arr.length; i++){
							for(var j = 0; j < 6; j++){
								var tmp = arr[i][j];
								if(tmp!=null&&tmp.length>0)
								setTextValue(iWebOffice,tmp,"1",""+(i+4),""+(j+2));
							}
						}
					}
				}
			});
			jQuery.ajax({
				url:jQuery("#path").val()+"/ccapp/xtbg/caizhengting/unitmanager/jsp/queryChangeutilspdo.jsp",
				dataType:"json",
				type:"post",
				data:{"busid":p[0]},
				success:function(data){
					setTextValue(iWebOffice,data.unitsname,"1","1","2");
					setTextValue(iWebOffice,data.username,"1","11","5");
					setTextValue(iWebOffice,data.change_phone,"1","12","5");
					setTextValue(iWebOffice,data.change_typeid,"1","13","2");
				}
			});
		}
	}
	hubeiext();
}

//湖南省政府收文处理机构分配
function extorgselect(){
	webform.WebOffice.AppendTools("53","收文单位",7);
	  //响应工具栏事件
	webform.WebOffice.attachEvent("OnToolsClick",function(vIndex,vCaption){ 
		if (vIndex==53){
			extgetOrgId();
			
	    };
	}); 
}

//获取保存的OA_ORG_ID
function extgetOrgId(){
	var ajaxurl=jQuery("#path").val()+"/ccapp/oa/archive/wordarchive/extendarchivedo.jsp";
	var ins_id =  parms.flowParmJson.ins_id;
	var gwreceive_id = jQuery("#offDocRegId").val();
	var ajaxurl
	jQuery.ajax({//AJAX将WORD正文上传至公文传输
		url: ajaxurl,
		type: 'POST',
		dataType:'text',
		data: {
			"ins_id":ins_id,
			"gwreceive_id":gwreceive_id,
			"optType":"queryOrgId"
		},
		success: function(data){
			if(data){
				//jQuery("#webofficDiv").hide();
				extchooseOrg(data);
			}
		},
		error: function(jqXHR, textStatus, errorThrown){
		}
	})
}

//选择机构
var extchooseOrg = function (_org_id){
    var s = new jQuery.z_tree();
      s.treeID='mian';
      s.treetypestr='radio';
      s.isShowSeacher=true;
      s.treeName="选取单位";
      s.isType='dept';
      s.headerName="选取单位";
      s.item_id = 'org_id';
      s.selectedIds=trim(_org_id);
      s.type='AORG';
      s.callbackcancel = showWeb;
      s.returnFunction=function(orgObj){
          if(!IsSpace(orgObj)){
        	    var oa_org_id = orgObj.id;
        	  	if(oa_org_id){
        			var ajaxurl=jQuery("#path").val()+"/ccapp/oa/archive/wordarchive/extendarchivedo.jsp";
        			var ins_id =  parms.flowParmJson.ins_id;
        			var gwreceive_id = jQuery("#offDocRegId").val();
        			var ajaxurl
        			jQuery.ajax({//AJAX将WORD正文上传至公文传输
        				url: ajaxurl,
        				type: 'POST',
        				dataType:'text',
        				data: {
        					"ins_id":ins_id,
        					"gwreceive_id":gwreceive_id,
        					"oa_org_id":oa_org_id,
        					"optType":"setOrgId"
        				},
        				success: function(data){
        					if(data){
        						alert("单位设置成功！");
        					}
        				},
        				error: function(jqXHR, textStatus, errorThrown){
        				}
        			})
        		}
               
             }else{
                 
             }
          //jQuery("#webofficDiv").show();
     }
      s.init();
}

//回调函数
function showWeb(){
	if(jQuery("#webofficDiv")){
		//jQuery("#webofficDiv").show();
	}
}

//省政府处理，如果是业务处室环节，添加转办单打印功能。
function extzhuanbandan(){
	webform.WebOffice.AppendTools("52","转办单",7);
	  //响应工具栏事件
	webform.WebOffice.attachEvent("OnToolsClick",function(vIndex,vCaption){ 
		if (vIndex==52){
			var zhuanbanid = "zb_"+do_recordID;
			extqueryWord(zhuanbanid);
	    };
	}); 
}

//打开文档
function extqueryWord(zhuanbanid){
	var mTemplate = "th0965b156-6a67-4fe4-9259-1fad7498a4b3";//转办ID模板，需要配置？
	var height = window.screen.availHeight;
	var width = window.screen.availWidth;
	var url = jQuery("#path").val()+"/ccapp/oa/archive/iwebofficequery.jsp?windowsId=windowId2&RecordID="+zhuanbanid+"&Template="+mTemplate+"&opentype=zhuanbandan";
	openAlertWindows('windowId2',url,'公文转办单',width,height,'0%','0%',closeAlertWindow);
}


//湖北流程转发配置
function hubeiext(){
	var isStartAdd = jQuery("#isStartAdd").val();
	var sign_id = jQuery("#sign_id").val();
	if(isStartAdd=="Y"){//流程发起流程中添加正文，标题
		webform.WebOffice.AppendTools("51","收文面签",7);
		//加入点击事件
		webform.WebOffice.attachEvent("OnToolsClick",function(vIndex,vCaption){
			if (vIndex==51){
			    	showSign(sign_id);
			} 	
		});
	}
}
	
//查看收文环节的会签页面
function showSign(sign_id){
	//var sign_id = "singn9800f3fa-32e9-45c0-855b-05be094a2354";
	var height = window.screen.availHeight;
	var width = window.screen.availWidth;
	var url = jQuery("#path").val()+"/ccapp/oa/archive/iwebofficequery.jsp?windowsId=windowId1&opentype=query&RecordID="+sign_id;
	window.open(url,"_blank","width="+width+",height="+height+",left=0px,top=0px");
}

//根据位置设置值(word对象,值,x=1,y=行,z=列)
function setTextValue(iWebOffice,txtValue,x,y,z) {
	try{
		if(!tables){
			tables = iWebOffice.WebObject.Tables.Item(x);
		}
		tables.Cell(y,z).Range.Text = txtValue;
	}catch(e){}
}
