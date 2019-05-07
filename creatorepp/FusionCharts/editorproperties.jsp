<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.chinacreator.fusionchart.util.FusionUtil"%>
<%
	
	String datasourcetype = FusionUtil.getParameterString(request,"datasourcetype");
	String dataurl = FusionUtil.getParameterString(request,"dataurl");
	String fusionid = request.getParameter("fusionid");
	String fusiontype = request.getParameter("fusiontype");
	String modelType = request.getParameter("modeltype"); //ms,scroll,single
	String modelCode = request.getParameter("modelcode");
	
	String divw = FusionUtil.getParameterString(request,"divw");
	String divh = FusionUtil.getParameterString(request,"divh");
	String divtop = FusionUtil.getParameterString(request,"divtop");
	String divleft = FusionUtil.getParameterString(request,"divleft");
	String flocation = FusionUtil.getParameterString(request,"flocation");
	
	String path = request.getContextPath();
	
	String fidp = "";
	String fid = "";
	if(!StringUtils.isBlank(fusionid)){
		boolean haveId = fusionid.length()>13;
		if(haveId){
			fidp = fusionid.substring(0,13);
			fid = fusionid.substring(13);
		}else{
			fidp = fusionid;
		}
	}else{
		fidp = new Date().getTime()+"";
	}
	
	pageContext.setAttribute("datasourcetype",datasourcetype);
	pageContext.setAttribute("dataurl",dataurl);

	pageContext.setAttribute("modeltype",modelType);
	pageContext.setAttribute("modelcode",modelCode);
	
	pageContext.setAttribute("fidp",fidp);
	pageContext.setAttribute("fid",fid);
	pageContext.setAttribute("path",path);
	pageContext.setAttribute("fusiontype",fusiontype);
	
	pageContext.setAttribute("divw",divw);
	pageContext.setAttribute("divh",divh);
	pageContext.setAttribute("divtop",divtop);
	pageContext.setAttribute("divleft",divleft);
	pageContext.setAttribute("flocation",flocation);
	pageContext.setAttribute("fusionid",fusionid);
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>fusionchart属性配置</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="styles/css/creator.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="jquery-1.2.6.min.js"></script>
		<script type="text/javascript" src="s2u.js"></script>
		<script type="text/javascript">
		
		String.prototype.startWith=function(str){
			if(str==null||str==""||this.length==0||str.length>this.length)
			  return false;
			if(this.substr(0,str.length)==str)
			  return true;
			else
			  return false;
			return true;
		}

		
		function cancelStep(){
		var answer = confirm("你确定退出属性配置吗吗?")
			 if(!answer){
				   		return;
			}
			 window.close();
		}
	
	
		function resetf(){
			$('#f_w').attr('value','');
			$('#f_h').attr('value','');
			$('#f_left').attr('value','');
			$('#f_top').attr('value','');
			$('#f_id').attr('value','');
		}
		
		function nextpage(){
			
			if($('#f_id').val()==''){
				alert('控件ID必须填写');
				return;
			}
			
			if(jQuery.trim($('#f_w').val())=='' || isNaN($('#f_w').val())){
				alert('请输入合法的宽度');
				return;
			}	
			if(jQuery.trim($('#f_h').val())=='' || isNaN($('#f_h').val())){
				alert('请输入合法的高度');
				return;
			}
			
			if($('#f_id').val().search(/[^0-9a-z]/gi)!=-1){
				alert('ID只能为数字或英文字符');
				return;
			}	
		    
		    if('${datasourcetype}' == 'xml'){
		    	var isuserexistmodel = $('#myhidvalue').val(); //2 为使用了模板
		    	var loadedp = $("input[@type=radio][@checked][@name=idname]").val(); 
		    	
		    	if(isuserexistmodel=='2'){
		    		if(loadedp=='' || loadedp == undefined){
		    			alert('你未选择任何模板');
		    			return;
		    		}
		    	}
		    	
		    	loadedp = loadedp == undefined?'':loadedp;
		    	var dataurl = $('#dataurl').val();
		    	if(jQuery.trim(dataurl)==''){
		    		alert('你未填写url地址');
		    		return;
		    	}
		    	var elsePropertiesStr = '&f_w='+$('#f_w').val()+'&f_h='+$('#f_h').val()+'&f_top='+$('#f_top').val()+'&f_left='+$('#f_left').val();
		    	var fusionid = getFieldValues('f_preffix')+''+getFieldValues('f_id');
				var url = 'editFlash.jsp?isuseurl=1&isuseexsit='+loadedp+'&fusionid='+encodeURI(fusionid)+'&dataurl='+encodeURI(dataurl)+'&modeltype=${modeltype}&modelcode=${modelcode}'+elsePropertiesStr;
				location.href = url;
				return;
		    }
		    
			var obj =  parent.parent.dialogArguments[11];
			var valradio = $("input[@type=radio][@checked][@name=datasetr]").val(); 
						
			if(valradio == undefined){
				alert('未找到任何可用dataset数据集');
				return;
			}
			
			var sql = obj.document.getElementById(valradio).opensql;
			if(''==sql){
				alert('在继续进行配置前你需要在dataset中配置sql语句');
				return;
			}
			
			var formatxml = obj.document.getElementById(valradio).formatxml;
			var returnFieldNames = '';
			formatxml = '<xml>'+formatxml+'</xml>';
			var datasetfieldcount = 0;
			$(formatxml).find('root > tr').each(function(){　
					var i = 0;
					$(this).find('td').each(function(){
					if(i==0){
					returnFieldNames += $(this).text();
					returnFieldNames += '$';
					i++;
					datasetfieldcount++;
					}
					});
			 });
			
			 
			var loadedp = $("input[@type=radio][@checked][@name=idname]").val(); 
		
			loadedp = loadedp==undefined?'':loadedp;
			
			var obj1 = parent.parent.pubDataSet[0];
			obj1.fusion_id= getFieldValues('f_preffix')+''+getFieldValues('f_id');
		    obj1.f_id = getFieldValues('f_id');
		    obj1.f_preffix = getFieldValues('f_preffix');
		    obj1.f_location = getFieldValues('f_location');
		    obj1.style.position = obj1.f_location;
		    obj1.f_top=getFieldValues('f_top');
			obj1.f_w=getFieldValues('f_w');
			obj1.f_h=getFieldValues('f_h');
			obj1.f_left=getFieldValues('f_left');
	
			var isuserexistmodel = $('#myhidvalue').val();
			if(isuserexistmodel=='2'){
				//使用已有模板
				if(loadedp == ''){
					alert('你未选择任何模板');
					return;
				}
				
				if($('#f_id').attr('readonly')){
				   var oldtype = '${fusiontype}';
				   var newtype;
				   var index = loadedp.indexOf('_');
				   if(index==-1){
				   		newtype = loadedp;
				   }else{
				   		newtype = loadedp.substring(0,index);
				   }
				   var os = oldtype.startWith('MS')?1:-1;
				   var ns = newtype.startWith('MS')?1:-1;
				   
				   if(os*ns<0){
				   	var answer = confirm("尝试将"+oldtype+"类型属性替换为"+newtype+"属性\n将两个不同类型数据集的属性覆盖可能导致数据不能展示，你确定继续吗？")
					   if(!answer){
					   		return;
					   }
				   }	
				   var answer = confirm("你确定用"+loadedp+"的属性覆盖现有属性吗?")
				   if(!answer){
				   		return;
				   }
	   
				}
				
			}else{
				//未使用模板
				loadedp = '';
				if(datasetfieldcount < 2){
					alert('所选dataset['+valradio+']查询字段不能少于2个！');
					return;
				}
			}
			
			var elsePropertiesStr = '&f_w='+$('#f_w').val()+'&f_h='+$('#f_h').val()+'&f_top='+$('#f_top').val()+'&f_left='+$('#f_left').val();
			var url = 'editFlash.jsp?isuseexsit='+loadedp+'&sql='+encodeURI(sql)+'&fields='+encodeURI(returnFieldNames)+'&fusionid='+encodeURI(obj1.fusion_id)+'&eformDataSetName='+valradio+elsePropertiesStr+'&modeltype=${modeltype}&modelcode=${modelcode}';
			location.href = url;
		}
		
		function getFieldValues(_id){
			return $('#'+_id+'').val();
		}
		
		function doopenlink(){
		var   xMax  =   screen.width;   
     	var   yMax  =   screen.height;
     	var modelw = xMax/1.5;
     	var modelh = yMax/2;
   	 	var dialogLeft  =(xMax - modelw)/2;
   	 	var dialogTop = (yMax - modelh)/4;  
   	 	var url = $('#dataurl').val();
   	 	window.showModalDialog('showlink.jsp?dataurl='+encodeURI(url),null,'dialogWidth='+modelw+'px;dialogHeight='+modelh+'px;dialogLeft='+dialogLeft+';dialogTop='+dialogTop+';scroll:0');   
	}
	</script>

	<script type="text/javascript" defer="defer">
		String.prototype.endWith=function(oString){   
	  		  var reg=new RegExp(oString+"$");   
	  		  return   reg.test(this);   
  		}
  		  
		function getFields(valradio){
		
		var obj =  parent.parent.dialogArguments[11];
		var formatxml = obj.document.getElementById(valradio).formatxml;
		var count = 0;
		var returnFieldNames = '';
			formatxml = '<xml>'+formatxml+'</xml>';
			$(formatxml).find('root > tr').each(function(){　
					var i = 0;
					$(this).find('td').each(function(){
					if(i==0){
					returnFieldNames += $(this).text();
					returnFieldNames += ',';
					i++;
					count++;
					}
					});
			 });
			 if(returnFieldNames.endWith(',')){
			 	returnFieldNames = returnFieldNames.substring(0,returnFieldNames.length-1);
			 }
			 return count+'$'+returnFieldNames;
		}
		function init(){
			
			if('${datasourcetype}' == 'xml'){
				//URL 提供数据集
				beforeInit(1);
				$('#td_1').html('远程url数据集');
				
				var content = "<tr class='table_thead'><td width='80%' class='right_line'>远程url数据集提供</td><td width='20%' class='right_line' align='center'>打开链接</td></tr>";
				
				content+="<tr><td width='80%' class='line_s1'><input id='dataurl' type='text' value='${dataurl}' size='60'/></td><td width='20%' class='line_s2' align='center'><img alt='' src='styles/images/href.png' style='cursor:hand' onclick='doopenlink();'/></td></tr>";
				$('#datatable').html(content);
				$('#tab_1').html($('#pagecontent').html());
				
				return;
			}
			
			var obj = parent.parent.dialogArguments[11];
			
			var selectedDatasetName = beforeInit(0);
			
			//var datasetxml = obj.document.getElementById('SKbillsheet').contxml;
			//alert(datasetxml);
			
			//datasetxml = '<xml>'+datasetxml+'</xml>';
			var trs = $('#datatable').html();
			
			var setC = -1;
			$('IMg[controltype=dataset]',obj.document).each(function(){
			//alert(this.id);
			//});
			//$(datasetxml).find('dataset > id').each(function(){　　　　　　　　　　　　　　　　　　 
　　　　　　　　　　　　　　　 	 var datasetid = this.id;

							 var cked = selectedDatasetName == datasetid?'checked=checked':'';
							 var rs = getFields(datasetid);
							 var sp = rs.split('$');
							 var count = sp[0];
							 var fields = sp.length==1?"":sp[1];
							 if(count < 2){
							 trs+="<tr style='background:#FFA297'>";
						  	 trs+="<td class='line_s0'>";
							 }else{
							 trs+="<tr>";
							 trs+="<td class='line_s1'>";
							 }
						  	 if(setC == -1){
						  	 trs+="<input type='radio' name='datasetr' "+cked+" value='"+datasetid+"'>";
						  	 setC = 1;
						  	 }else{
						  	 trs+="<input type='radio' name='datasetr' "+cked+" value='"+datasetid+"'>";
						  	 }
						  	 trs+="</td>";
						  	 trs+="<td class='line_s2'>";
						  	 trs+=datasetid;
						  	 trs+="</td>";
						  	 trs+="<td class='line_s2'>";
						  	 trs+=fields;
						  	 trs+="</td>";
						  	 trs+="</tr>";
　　　　　　　　　　　　　　　
　　　　　　　　　 });

			$('#datatable').html(trs);
			$('#tab_1').html($('#pagecontent').html());
			
			afterinit();
		}
		
		function afterinit(){
		var obj = parent.parent.pubDataSet[0];
		obj.f_preffix = $('#f_preffix').val();
		obj.f_id = $('#f_id').val();
		
		//FIXME
		//定位未设初始值
    
	    if(obj.f_location=='' || obj.f_location==undefined){
	    	 $('#f_location').attr('value','static');
	 
	    	//_set_FieldValue('f_location','static');
	    }else{
	       	  $('#f_location').attr('f_location',obj.f_location);
	    	//_set_FieldValue('f_location',obj.f_location);
	    }
	    
	   
	    if($('#f_location').val() == "static") {
	    	$('#f_left').attr('disabled',true);
	    	$('#f_top').attr('disabled',true);
		}else{
			$('#f_left').attr('disabled',false);
	    	$('#f_top').attr('disabled',false);
		}
		
		obj.f_top = $('#f_top').val();
		obj.f_w=$('#f_w').val();
		obj.f_h=$('#f_h').val();
		obj.f_left=$('#f_left').val();

		}
		
	function uf_changeVal(){
		if($('#f_location').val() == "static"){
			$('#f_left').attr('value','');
			$('#f_top').attr('value','');
		}	
		
		if($('#f_location').val() == "static") {
			$('#f_left').attr('value','');
			$('#f_top').attr('value','');
			$('#f_left').attr('disabled',true);
	    	$('#f_top').attr('disabled',true);
		}else{
			$('#f_left').attr('disabled',false);
	    	$('#f_top').attr('disabled',false);
		}
	}

		function change_tab(tdidon,tdidoff){
			$('#'+tdidon).attr('class','table_on');
			$('#'+tdidoff).attr('class','table_off');
			var myhidvalue = $('#myhidvalue').val();
			
			if(tdidon == 'td_1'){
				//默认展示
				if(myhidvalue == 1){
					//重复点击，不做处理
				}else{
					var defaulthtml = $('#tab_1').html();
					if(defaulthtml!=''){
						$('#pagecontent').html(defaulthtml);
					}
				}
				
				$('#myhidvalue').attr('value','1');
			}else{
				//展示已使用模板
				if(myhidvalue == 2){
					//重复点击，不做处理
				}else{
					//先判断div是否有值，若有直接加载，若无再重新加载
					var usedhtml = $('#tab_2').html();
					if(usedhtml!=''){
						$('#pagecontent').html(usedhtml);
						$('#myhidvalue').attr('value','2');
					}else{
						var usedmodel = '${path}/FusionCharts/usedmodel.jsp';
							$('#tab_2').load(usedmodel,function (data){
							$('#pagecontent').html(data);
							$('#myhidvalue').attr('value','2');
						});
					}
					
				}
				
			}
		}
		
		function onselect(){
			var type = $('#ctype').val(); 
			reloadTab2(1,type);
		}
		function reloadTab2(pageindex,type){
			
			var usedmodel = '${path}/FusionCharts/usedmodel.jsp?pageindex='+pageindex+'&type='+type;
							$('#tab_2').load(usedmodel,function (data){
							$('#pagecontent').html(data);
							$("#ctype").attr("value",type==''?'all':type);
							$('#myhidvalue').attr('value','2');
			});
		}
		
		function beforeInit(flag){
			//该步骤将现有的ID对应的属性文件或者属性字符串解析成map后保存到session域
			var encodeString = '';
			var isuseurl = 0;
			if(flag==1){
				isuseurl = 1;
			}else{
				//该类型满足是默认通过eform表单设计时的情况
				var obj = parent.parent.pubDataSet[0];
				var propertyStr = obj.returnValue;
				propertyStr = decodeURI(propertyStr);
				if(propertyStr!=undefined && jQuery.trim(propertyStr)!=''){
					encodeString = toUN.on(propertyStr);
				}
				
			    var indexDname = propertyStr.indexOf('eformDataSetName');
			    var substr = propertyStr.substring(indexDname);
			    
			    var eqIndex = substr.indexOf("=");
			    var quIndex = substr.indexOf("`");
			    
			    var selDatasetName = substr.substring(eqIndex+1,quIndex);
			    /*
			    var _datasets = document.getElementsByName("datasetr");
			    alert(selDatasetName);
			    alert(_datasets.length);
			    for(var m=0;m<_datasets.length;m++){
			    	var v = _datasets[m].value;
			    	alert(v);
			    	if(selDatasetName == v){
			    		_datasets[m].checked = 'checked';
			    	}else{
			    		_datasets[m].checked = '';
			    	}
			    }
			   */ 
				if(encodeString==''){
					return;
				}
			}
			
			$.ajax({
	 		url:   "${path}/fusionchar",
	 		type: 'POST',
	 		data: 'chart_action=4&fusiontype=${modelcode}&fusionid=${fusionid}&isuseurl='+isuseurl+'&properties='+encodeString,
	 		async : true,
	 		success: function(data){
	 		},
	 		error : function(){
	 			alert('初始化数据失败');
	 		}   
			});
			return selDatasetName;
		}
		
	</script>
	</head>

	<body bgcolor="#FFFFFF" onload="init();">
		<input type="hidden" value="dasdasd" name="3223" onclick="okme()">
		<table width="80%" border="0" align="center" cellpadding="0"
			cellspacing="0">
			<tr>
				<td>
					&nbsp;
				</td>
			</tr>
		</table>

		<table width="80%" border="0" align="center" cellpadding="0"
			cellspacing="1" bgcolor="#BDD2ED" >
			<tr>
				<td bgcolor="#FFFFFF">

					<table width="40%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td id= "td_1" bgcolor="#FFFFFF" width="55%" class="table_on"
								style="border-right: 1px solid #BDD2ED;" onclick="change_tab('td_1','td_2');">
								选择DataSet数据源
							</td>
							<td id= "td_2" bgcolor="#FFFFFF" width="45%" class="table_off"
								style="border-right: 1px solid #BDD2ED;" onclick="change_tab('td_2','td_1');">
								选择现有主题模板
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
			
				<td valign="top" bgcolor="#FFFFFF" class="space_10" id="pagecontent">
			
					<table width="100%" border="0" cellspacing="0" cellpadding="0"
						style="border: 0px;" >
						<tr>
							<td width="84%" bgcolor="#FFFFFF">
								<table width="98%" border="0" cellspacing="0" cellpadding="0"
									class="table_height">
									<tbody id="datatable">
									<tr class="table_thead">
										<td width="10%" class="right_line">
											选 择
										</td>
										<td width="25%">
											DataSet数据源
										</td>
										<td width="65%">
											字段名
										</td>
										
									</tr>
									
									</tbody>
								</table>
							</td>
							<td width="16%" bgcolor="#FFFFFF" class="space_10">
								<table width="52%" border="0" cellspacing="0" cellpadding="0"
									class="table_right">
									<tr>
										<td>
											<p>
												<img src="styles/images/dian.gif" width="8" height="8" />说明:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											</p>
											<p>
												一个dataset的字段不能少于两个
											</p>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>

				</td>
			</tr>
			
			<tr>
			<td width="84%" bgcolor="#FFFFFF">
			<fieldset>
			<legend>控件基本属性</legend>
			<table width="100%" border="0" cellspacing="0" cellpadding="0"
						style="border: 0px;" >
						<tr style="height:10px"><td colspan="3"></td></tr>
						<tr>
						<td align="left" colspan="3">
						图形ID:<input id="f_preffix" size="13" value="${fidp}" readonly="readonly" style="BACKGROUND-COLOR:#ffffff"/><input id="f_id" value="${fid}" ${fid eq ''?'':'readonly=readonly style="BACKGROUND-COLOR:#ffffff"'}/>
						&nbsp;定位方式:
						<select id="f_location" onchange="uf_changeVal();">
							<OPTION value='absolute' ${flocation=='static'?'':'selected'}>绝对</OPTION>
							<OPTION value='static' ${flocation=='static'?'selected':'' }>静态</OPTION>
						</select> 
						<br />
						</td>
						</tr>
						<tr style="height:8px"><td colspan="3"></td></tr>
						<tr>
							
							<td colspan="3" align="left">
								布&nbsp;局:&nbsp;&nbsp;左<input id="f_left" size="3" value="${divleft}"/> &nbsp; 上<input id="f_top" size="3" value="${divtop}"/> &nbsp;宽<input id="f_w" size="3" value="${divw}"/> &nbsp;高<input id="f_h" size="3" value="${divh}"/> 
								&nbsp;&nbsp;&nbsp;&nbsp;<input value="重置" type="button" onclick="resetf();"/>
							</td>
						</tr>
						</table>
						</fieldset>
						</td>
			</tr>
			<tr style="height:10px"><td colspan="3" bgcolor="#FFFFFF"></td></tr>
		</table>
		<table width="80%" border="0" align="center" cellpadding="0"
			cellspacing="0">
			<tr>
				<td>
					&nbsp;
				</td>
			</tr>
		</table>

		<table width="40%" border="0" align="center" cellpadding="0"
			cellspacing="0">
			<tr align="center">
				<td>
					<input type="submit" name="Submit" value="下一步" class="btn_s1"
						onclick="nextpage()" />
				</td>
				<td>
					<input type="submit" name="Submit2" value="取消" class="btn_s1" onclick="cancelStep();"/>
				</td>
			</tr>
		</table>
		
		
	<div id ="tab_1" style="display:none"></div>
	<div id ="tab_2" style="display:none"></div>
	<input type="hidden" value="1" id="myhidvalue"/>
	</body>
</html>
