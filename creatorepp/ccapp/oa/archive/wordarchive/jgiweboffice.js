/*	文件：jgiweboffice.js
	描述：金格WORD控件
	作者：shuqi.liu
	日期：2014-1-13
*/
jQuery(function() {
	var webform  ;
	var do_recordID = "";
	Load(); //加载
});

//作用：载入iWebOffice
function Load(){
  try{
	webform = form1;
    //以下属性必须设置，实始化iWebOffice
	webform.WebOffice.WebUrl=jQuery("#mServerUrl").val();			//WebUrl:系统服务器路径，与服务器文件交互操作，如保存、打开文档，重要文件
	do_recordID = jQuery("#mRecordID").val();
	var hasText = jQuery("#hasText").val();//是否有整理后的正文
	webform.WebOffice.RecordID=	do_recordID;//这里的作用是原文。
	if(hasText=="true"){
		webform.WebOffice.EditType = "4,0";//如果整理过后，那么打开是只读
		//这里的作用是text 默认打开整理过后的正文。
		webform.WebOffice.ExtParam="{_DBType:\"<%=_DBType%>\",textType:\"text\"}";   
	}else{
		webform.WebOffice.EditType=jQuery("#mEditType").val();	//EditType:编辑类型  方式一、方式二  <参考技术文档>
		webform.WebOffice.ExtParam="{_DBType:\"<%=_DBType%>\",textType:\"\"}";
	}
	webform.WebOffice.Template=jQuery("#mTemplate").val();	//Template:模板编号
	webform.WebOffice.FileName=jQuery("#mFileName").val();  //FileName:文档名称
	webform.WebOffice.FileType=jQuery("#mFileType").val();  //FileType:文档类型  .doc  .xls  .wps
	webform.WebOffice.UserName=jQuery("#user_name_IP").val();	//UserName:操作用户名，痕迹保留需要,加入IP
	//webform.WebOffice.UserName=jQuery("#mUserName").val();	//UserName:操作用户名，痕迹保留需要
	webform.WebOffice.MaxFileSize = 64 * 1024;			//最大的文档大小控制，默认是64M，现在设置成16M。
    webform.WebOffice.ShowToolBar="0";			//ShowToolBar:是否显示工具栏:1显示,0不显示
    //功能区最大化
	var mStatus = webform.WebOffice.Office2007Ribbon;
	if ((mStatus!=0) && (mStatus!=-1)){
		webform.WebOffice.Office2007Ribbon=0;
	}
    var busiTypeCode = parms.flowParmJson.busiTypeCode
    if(typeof extinitbefor =="function"){
    	extinitbefor(busiTypeCode);//此处加入扩展配置,WebOpen之前
    }
    var flag = webform.WebOffice.WebOpen(true);
    if(typeof extinitafter =="function"){
    	extinitafter(busiTypeCode);//此处加入扩展配置,WebOpen之后
    }
    wordiwebofficeJS.doFlowInFlow.initFlowInFlow(webform, do_recordID);
    var document_recordid = jQuery("#document_recordid").val();
    //个人文件柜正文添加
    if(!IsSpace(document_recordid)){
    	webform.WebOffice.ExtParam="{insertBookMark:'gxmark'}"; //增加正文的插入位置
    	webform.WebOffice.RecordID = document_recordid;
    	webform.WebOffice.WebInsertFile();
    }
    webform.WebOffice.ShowType=1;				//文档显示方式  1:表示文字批注  2:表示手写批注  0:表示文档核稿
    webform.WebOffice.WebToolsVisible("Standard",false);	
	webform.WebOffice.ShowMenu="0";	//不显示下拉菜单
	webform.WebOffice.WebSetRevision(false,true,false,false);//默认打开设置为保留痕迹，不显示痕迹
	setTimeout(function(){
		webform.WebOffice.WebToolsVisible("Standard",false);	
		webform.WebOffice.WebToolsVisible("Standard",true);	
	},1000);
	setTimeout(function(){
		webform.WebOffice.WebToolsVisible("Standard",false);	
		webform.WebOffice.WebToolsVisible("Standard",true);	
	},3000);
  }catch(e){
    alert(e.description);//显示出错误信息
  }		
}

