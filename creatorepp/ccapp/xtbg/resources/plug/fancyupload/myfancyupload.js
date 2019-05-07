var MyFancyupload = {
	rootPath : null,	//项目根路径
	onlineEdit : null,  //在线编辑(支持word,excel)  
	init : function(){
		This = this;
	},
	/**
	 * 创建上传插件
	 * @param {} list		上传列表展示ID
	 * @param {} attachs	上传按钮ID
	 * @param {} rootPath	项目根路径
	 * @param {} url		上传路径
	 * @param {} allowDel	是否容许删除
	 * @param {} buessid	业务ID
	 * @return {}			返回上传控件对象
	 * @param () callback   成功时回调方法  
	 * @param () onlineEdit 在线编辑(支持word,excel)         
	 */
	createUpload : function (list, attachs, rootPath, url, allowDel, buessid, typeFilter, callback, onlineEdit,deleteCallback){
		This = this;
		this.rootPath = rootPath;
		this.onlineEdit = onlineEdit;
		var config = {
				path: rootPath+'/ccapp/xtbg/resources/plug/fancyupload/source/Swiff.Uploader.swf',
				url: url,
				fileSizeMax: 50 * 1024 * 1024,
				verbose: true,
				allowDuplicates:true,
				callback: callback,
				onSelectFail: function(files) {//当选择文件不合格事件
					files.each(function(file) {
						new Element('li', {
							'class': 'file-invalid',
							events: {
								click: function() {
									this.destroy();
								}
							}
						}).adopt(
							new Element('span', {html: file.validationErrorMessage || file.validationError})
						).inject(this.list, 'bottom');
					}, this);	
				},
				
				onFileSuccess: function(file, response) {//当文件上传成功事件
					var data = MyFancyupload.evalJSON(response);
					file.ui.element.set('id', data.djsn);
					file.ui.element.set('html', "<a href='javascript:MyFancyupload.downloadFile(\""+data.djsn+"\");'>"+data.filename+"</a>").adopt(
						new Element('span', {
							html: "&nbsp;&nbsp;<span style='cursor:pointer;'><font color='red'>删除<font></span>",
							events: {
								click: function(){
									if(confirm("您确定要删除附件吗？")){
										MyFancyupload.deleteFile(this.getParent().id);
										this.getParent().destroy();
										if(deleteCallback){
											deleteCallback();	
										}
									}
								}
							}
						})
					);
					
					file.ui.element.highlight('#e6efc2');
					if(typeof callback =="function"){
						
						callback();
					}
				},
				
				onFileError: function(file) {//当文件上传错误事件
					file.ui.cancel.set('html', '重试').removeEvents().addEvent('click', function() {
						file.requeue();
						return false;
					});
					
					new Element('span', {
						html: file.errorMessage,
						'class': 'file-error'
					}).inject(file.ui.cancel, 'after');
				},
				
				onFileRequeue: function(file) {//当在文件上传队列中
					file.ui.element.getElement('.file-error').destroy();
					
					file.ui.cancel.set('html', '取消').removeEvents().addEvent('click', function() {
						file.remove();
						return false;
					});
					
					this.start();
				}
			}
		if(typeFilter){
			config.typeFilter = typeFilter;
		}
		var up = new FancyUpload3.Attach(list, attachs, config);
		
		if(buessid){//如果业务ID存在，将数据库中已上传文件进行加载
			var rows = this.getBuessidFiles(buessid);
			for(var i=0; i<rows.length; i++){
				var el = new Element('li', {
					'class': 'file',
					id: rows[i].djsn,
					html: "<a href='#' onclick='MyFancyupload.downloadFile(\""+rows[i].djsn+"\");'>"+rows[i].filename+"</a>"
				}).inject(up.list, 'bottom');
				if(allowDel){
					el.adopt(
						new Element('span', {
							html: "&nbsp;&nbsp;<span style='cursor:pointer;'><font color='red'>删除<font></span>",
							events: {
								click: function(){
									if(confirm("您确定要删除附件吗？")){
										MyFancyupload.deleteFile(this.getParent().id);
										this.getParent().destroy();
									}
								}
							}
						})
					)
				}
			}
		}
		
		return up;
	},
	
	getBuessidFiles : function(buessid){//根据业务ID从数据库中查询已上传的文件
		var html = this.f_async_html(this.rootPath + "/ccapp/xtbg/resources/plug/fancyupload/filedata.jsp?opt=files&buessid="+buessid);
		var data = MyFancyupload.evalJSON(html);
		if(data && data.rows){
			return data.rows;
		}
//		return []; 
		return [{filename:'abc.jpg'},{filename:'bbb.jpg'}];
	},
	
	deleteFile : function (fileid){
		var html = this.f_async_html(this.rootPath + "/ccapp/xtbg/resources/plug/fancyupload/filedata.jsp?opt=delete&fileid="+fileid);
		var data = MyFancyupload.evalJSON(html);
		return (data && data.bSuccess==true);
	},
	
	copyFile : function (newbuessid,buessid){
		var html = this.f_async_html(this.rootPath + "/ccapp/xtbg/resources/plug/fancyupload/filedata.jsp?opt=copy&buessid="+buessid+"&newbuessid="+newbuessid);
		var data = MyFancyupload.evalJSON(html);
		return (data && data.bSuccess==true);
	},
	
	deleteFiles : function (buessid){
		var html = this.f_async_html(this.rootPath + "/ccapp/xtbg/resources/plug/fancyupload/filedata.jsp?opt=deletes&buessid="+buessid);
		var data = MyFancyupload.evalJSON(html);
		return (data && data.bSuccess==true);
	},
	
	downloadFile : function(djsn){
		var iFOnlineEdit = "false";
		jQuery.post(this.rootPath+"/servlet/FileDownload",//调用servlet获取参数
				{
					djsn:djsn,
					onlineEdit:this.onlineEdit,
					getFileData:true
				},
				function(data){
					iFOnlineEdit = data.iFOnlineEdit;
					if("true" == iFOnlineEdit){//If能在线编辑
						This.onlineEditFile(djsn);//则调用在线编辑方法
					}else{
						This.commonDownloadFile(djsn);//否则调用通用下载方法
					}
				}
				,"json");


		
	},
	commonDownloadFile : function(djsn){
		//使用临时创建的超链接对象下载
		var linkGetfileObj = document.createElement("A");
		if(linkGetfileObj && (linkGetfileObj.tagName == "A")){
			linkGetfileObj.style.display = "none";
			document.body.appendChild(linkGetfileObj);
			linkGetfileObj.href = this.rootPath+"/servlet/FileDownload?djsn="+djsn+"&onlineEdit="+this.onlineEdit;
			linkGetfileObj.click();
			document.body.removeChild(linkGetfileObj);
			delete linkGetfileObj;
		}
	},
	onlineEditFile : function(djsn){
		var height = window.screen.availHeight;
		var width = window.screen.availWidth;
		window.open(this.rootPath+"/servlet/FileDownload?djsn="+djsn+"&onlineEdit="+this.onlineEdit,"_blank","width="+width+",height="+height+",left=0px,top=0px");
	},
	
	f_async_html : function(url){//同步获取url内容
		var flag = true;
		var html = jQuery.ajax({
			url: url,
			type: "POST",
			dataType: "html",
			timeout: 90000,
			async: false,
			error:function() {flag = false}
		}).responseText;
		if(flag){
			return html;
		} else {
			return null;
		}
	},
	
	evalJSON : function (strJson){//将JSON转换为JS对象
		try {
			return eval( "(" + strJson + ")");
		} catch(e){
			return "";
		}
	}
}