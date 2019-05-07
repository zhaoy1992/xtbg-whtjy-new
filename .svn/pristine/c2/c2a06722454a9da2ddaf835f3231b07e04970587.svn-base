<%@ page contentType="text/html; charset=GBK" %><%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.frameworkset.common.poolman.DBUtil"%>

<%AccessControl accesscontroler = AccessControl.getInstance();
  if(!accesscontroler.checkAccess(request, response)){
  		return;
  }
  String appPath = "app_"+accesscontroler.getCurrentSystemID();
  String appId = accesscontroler.getCurrentSystemID();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html xmlns:fc xmlns:v="urn:schemas-microsoft-com:vml">
	<HEAD>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">		
		<STYLE> .userData{behavior:url(#default#userData);}
	</STYLE>
	<script type="text/javascript" src="../../../cachloader/pre_load.js"></script>	
	<script language="javascript">
		var __dj_win_flag__ = true;
		function load_over(){
			document.getElementById("preloadView").style.display="none";
			document.getElementById("SKbillsheet").style.visibility="visible";
		}
	
		function optmGetUsdatObj()
		{
			if((typeof(eppDataWrObj) != "undefined") && eppDataWrObj.isCanUse()) return eppDataWrObj;
			if((typeof(userDataWrObj) != "undefined") && userDataWrObj.isCanUse()) return userDataWrObj;
			return null;			
		}
		
		function optmGetFlashObj()
		{
			if((typeof(eppDataWrObj) != "undefined") && eppDataWrObj.isCanUse()) return eppDataWrObj;
			if((typeof(flashWrObj) != "undefined") && flashWrObj.isCanUse()) return flashWrObj;
			return null;
		}
		
		function ex_prePageInit()
		{	
			var bSucced = __pre_loadjsFrame();
			if(!bSucced) 
			{
				document.body.innerHTML = "<font color='#ff0000'>preload js frame failure!</font>";
				return;
			}
			
			mtJsFileArray("eformsys/fceform/js/fcpub.js", true, optmGetUsdatObj());
			mtJsFileArray("eformsys/fceform/js/fcvalid.js", true, optmGetUsdatObj());
			mtJsFileArray("eformsys/fceformext/js/usertb.js", true, optmGetUsdatObj());			
			mtJsFileArray("eformsys/fceform/js/ccpub.js", true, optmGetUsdatObj());
			mtJsFileArray("eformsys/fceform/js/fcrundj.js", true, optmGetUsdatObj());
			mtJsFileArray("eformsys/fceform/js/tabpane.js", true, optmGetFlashObj());
			mtJsFileArray("eformsys/fceform/js/fcsavedj.js", true, eppDataWrObj);
					
			mtJsFileArray("eformsys/fceform/js/Ext/ext-base.js", true, eppDataWrObj);
         mtJsFileArray("eformsys/fceform/js/Ext/ext-all.js", true, eppDataWrObj);
         mtJsFileArray("eformsys/fceform/js/Ext/ext-lang-zh_CN.js", true, eppDataWrObj, "UTF-8");
         mtJsFileArray("eformsys/fceform/js/Ext/css/ext-all.css", true, optmGetUsdatObj());
			s=1;
		
			bSucced = prePageInit(false, true);
			if(!bSucced) 
			{
				document.body.innerHTML = "<font color='#ff0000'>preload js file failure!</font>";
				return;
			}
			
			pub_djhtm();
			fcpubdata.creatorStyle='creatorBlue';
		}
		
		//根据应用确定样式的目录
		var stylePath = "../../../ccapp/<%=appPath%>/";			
	</script>
		
	</HEAD>
	<body  onload="load_over();pub_window_onload()"
		onkeydown="RunTabindex()" onbeforeunload="pub_window_onbeforeunload()" onkeypress="pub_window_onkeypress()"
		onresize="pub_window_onresize()">
		<DIV style="Z-INDEX: 1000; BACKGROUND: #e0e0e0; FILTER: alpha(opacity=80); LEFT: 0px; WIDTH: 100%; POSITION: absolute; TOP: 0px; HEIGHT: 100%" id="preloadView">
		   <TABLE style="VERTICAL-ALIGN: middle; WIDTH: 100%; HEIGHT: 100%; TEXT-ALIGN: center">
		      <TBODY>
		         <TR>
		            <TD><DIV style="BORDER-RIGHT: skyblue 2px solid; BORDER-TOP: skyblue 2px solid; FONT-SIZE: 15px; BACKGROUND: #ffffff; BORDER-LEFT: skyblue 2px solid; WIDTH: 150px; PADDING-TOP: 9px; BORDER-BOTTOM: skyblue 2px solid; HEIGHT: 40px; solid: #000000">正在加载……</DIV></TD>
		         </TR>
		      </TBODY>
		   </TABLE>
		</DIV>
		
		<iframe id="_newframe" name="_newframe" height="0" width="0"></iframe>
		<script>
			var pubdjbh=parent.sOpenDjNo;
			var pubEdit=false;
			var pubDataSet=null;
			var pubRequest=parent.oRequest;
			var pubEformEnterStatus="OK"; 
			ex_prePageInit();
		</script>

<!-- 提示：以下为页面的JS&CSS内容 -->
<%
 String iWebOfficeVersion  = com.chinacreator.config.ConfigManager.getInstance().getConfigValue("iWebOfficeVersion", "7,8,0,4");
String strDgMode = com.chinacreator.config.ConfigManager.getInstance().getConfigValue("file.upload.jsdgmode");
boolean bDgMode = !((strDgMode == null) || !strDgMode.equals("1"));
%><script language='javascript'>
<%if(bDgMode){%>  var myhead = document.getElementsByTagName('head')[0];
  var mylink = document.createElement("link");
  mylink.setAttribute("type","text/css");
  mylink.setAttribute("rel","stylesheet");
  mylink.setAttribute('href','../../../ccapp/<%=appPath%>/css//allStyle.css');
  myhead.appendChild(mylink);
<%}else{%>  adv_loadjsfile('ccapp/<%=appPath%>/css//allStyle.css');
<%}%>  fcpubdata.creatorStyle='';
</script>
<%
if(!bDgMode) out.println("<script language='javascript'>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcbasecont.js');");
if(bDgMode) out.println("<script src='../../fceform/js/fcbasecont.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/selectdate.js');");
if(bDgMode) out.println("<script defer src='../../fceform/js/selectdate.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/../fceformext/js/userfunc.js');");
if(bDgMode) out.println("<script src='../../fceform/../fceformext/js/userfunc.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcdate.js');");
if(bDgMode) out.println("<script src='../../fceform/js/fcdate.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/Namespace.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/Namespace.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/nsreg.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/nsreg.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/DateUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/DateUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/DiagnosesVo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/DiagnosesVo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/LajdVo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/LajdVo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/Diagnoses.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/Diagnoses.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/DiagnosesDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/DiagnosesDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/LajdBiz.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/LajdBiz.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/LajdDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/LajdDao.js'></script>");
if(!bDgMode) out.println("</script>");
%>

   <script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script>
   <script >document.styleSheets[0].addRule("fc\\:creatorSubForm","behavior: url(../../fceform/htc/creatorSubForm.htc)",0);</script>
   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/css/Button.css');
adv_loadjsfile('/eformsys/fceform/css/TextStyle.css');
adv_loadjsfile('/eformsys/fceform/js/fcdataset.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/SlidingPager.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/SliderTip.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/PanelResizer.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/XmlTextReader.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/CreatorMemoryProxy.js');
</script>


<!-- 提示：以下为页面自定义JS内容 -->
<script>
var wft_id =creator_getQueryString("wft_id"); //违法实例ID
var pi_id =creator_getQueryString("pi_id"); //事项ID
var ndp_id = "6"; //当前阶段ID
var bu_id =creator_getQueryString("bu_id"); //执法主体ID
var bu_name =creator_getQueryString("bu_name"); //执法主体名称
var flags = creator_getQueryString("eflag"); //菜单还是宗卷进来的值
var user_id = getSysElement("userid");
var readOnlyFlag = "";
//var readOnlyFlag = creator_getQueryString("readOnlyFlag");  

var wfssTitle = "违法事实" ;
var blsjTitle = "办理时间" ;
var ldtId = 1;

//初始化函数
function init(){
    findDcqz(wft_id ,ldtId,wfssTitle,blsjTitle);
    commandBut2() ;
}

//查询调查取证信息函数
function findDcqz(wft_id ,ldtId,wfssTitle,blsjTitle){
    var sql = Diagnoses.findDcqzBiz(wft_id ,ldtId,wfssTitle,blsjTitle);
    dataset6.Open(sql);
}

//控制界面元素的显示(阶段在以调查取证)
function commandBut2(){
    if(flags==0){  //从菜单进去
        $("submitBut").style.display = "none" ;
       /*var num = Diagnoses.findCountNum1Biz(wft_id);//判断该调查取证阶段是否已提交
        if(num>0){//调查取证已提交
             $("updBut").style.display = "none" ;
           $("diaoChaBut").style.display = "none" ;
           var num3 = Diagnoses.findPurviewByWftIdBiz(wft_id);//判断生成处罚决定是否已经提交
             if(num3 > 0){//生成处罚决定已经提交，除返回按钮之外全部影藏
                  //当前界面只读，只留下返回按钮可以操作
                  $("saveBut").style.display = "none" ;
                $("button1").style.display = "none" ;
                readOnlyFlag = "readOnly";
                $("read_only").value = readOnlyFlag;
            }
       }*/
   var num1 = Diagnoses.findCountNumBiz(wft_id);//判断在受理之后调查取证之前
         if(num1>0){//并且在受理之后调查取证之前,只影藏提交按钮
            var num4 = Diagnoses.findCountBYLABiz(wft_id);//判断是否是不予立案或移送
            if(num4>0){
                //当前界面只读，只留下返回按钮可以操作
                   $("saveBut").style.display = "none" ;
                $("updBut").style.display = "none" ;
                $("diaoChaBut").style.display = "none" ;
                readOnlyFlag = "readOnly";
                $("read_only").value = readOnlyFlag ;
          }
          $("submitBut").style.display = "none" ;
      }else{
             var num = Diagnoses.findCountNum1Biz(wft_id);//判断该调查取证阶段是否已提交
                if(num>0){//调查取证已提交
                    var num3 = Diagnoses.findPurviewByWftIdBiz(wft_id);//判断生成处罚决定是否已经提交
                    if(num3 > 0){//生成处罚决定已经提交，除返回按钮之外全部影藏
                        //当前界面只读，只留下返回按钮可以操作
                        $("submitBut").style.display = "none" ;
                    $("saveBut").style.display = "none" ;
                    $("updBut").style.display = "none" ;
                    $("diaoChaBut").style.display = "none" ;
                    readOnlyFlag = "readOnly";
                    $("read_only").value = readOnlyFlag ;
                 }else{//调查取证之后生成处罚决定之前
                         var num = Diagnoses.findCountBYCFBiz(wft_id);
                      if(num>0){//如果案件状态不是撤销，和不予处罚状态
                               //当前界面只读，只留下返回按钮可以操作
                                $("submitBut").style.display = "none" ;
                            $("saveBut").style.display = "none" ;
                            $("updBut").style.display = "none" ;
                            $("diaoChaBut").style.display = "none" ;
                            readOnlyFlag = "readOnly";
                            $("read_only").value = readOnlyFlag ;
                      }else{
                            $("submitBut").style.display = "none" ;
                            $("updBut").style.display = "none" ;
                            $("diaoChaBut").style.display = "none" ;
                      }
                 }       
              }
          }
    } else { //从卷宗进去
        var num2 = Diagnoses.findPurviewByUserIdAndPiIdBiz(user_id,pi_id);//判断当前用户是否具备访问调查取证的权限
         if(num2>0){//如果当前用户有权限
             var num1 = Diagnoses.findCountNumBiz(wft_id);//判断在受理之后调查取证之前
             if(num1>0){//并且在受理之后调查取证之前,只影藏提交按钮
                var num4 = Diagnoses.findCountBYLABiz(wft_id);//判断是否是不予立案或移送
                if(num4>0){
                    //当前界面只读，只留下返回按钮可以操作
                       $("saveBut").style.display = "none" ;
                    $("updBut").style.display = "none" ;
                    $("diaoChaBut").style.display = "none" ;
                    readOnlyFlag = "readOnly";
                    $("read_only").value = readOnlyFlag ;
              }
              $("submitBut").style.display = "none" ;
          }else{
                 var num = Diagnoses.findCountNum1Biz(wft_id);//判断该调查取证阶段是否已提交
                    if(num>0){//调查取证已提交
                        var num3 = Diagnoses.findPurviewByWftIdBiz(wft_id);//判断生成处罚决定是否已经提交
                        if(num3 > 0){//生成处罚决定已经提交，除返回按钮之外全部影藏
                            //当前界面只读，只留下返回按钮可以操作
                            $("submitBut").style.display = "none" ;
                        $("saveBut").style.display = "none" ;
                        $("updBut").style.display = "none" ;
                        $("diaoChaBut").style.display = "none" ;
                        readOnlyFlag = "readOnly";
                        $("read_only").value = readOnlyFlag ;
                     }else{//调查取证之后生成处罚决定之前
                             var num = Diagnoses.findCountBYCFBiz(wft_id);
                          if(num>0){//如果案件状态不是撤销，和不予处罚状态
                                   //当前界面只读，只留下返回按钮可以操作
                                    $("submitBut").style.display = "none" ;
                                $("saveBut").style.display = "none" ;
                                $("updBut").style.display = "none" ;
                                $("diaoChaBut").style.display = "none" ;
                                readOnlyFlag = "readOnly";
                                $("read_only").value = readOnlyFlag ;
                          }else{
                                $("submitBut").style.display = "none" ;
                                $("updBut").style.display = "none" ;
                                $("diaoChaBut").style.display = "none" ;
                          }
                     }       
                  }
             }
        }else{
            //当前界面只读，只留下返回按钮可以操作
             $("submitBut").style.display = "none" ;
            $("saveBut").style.display = "none" ;
            $("updBut").style.display = "none" ;
            $("diaoChaBut").style.display = "none" ;
            readOnlyFlag = "readOnly";
            $("read_only").value = readOnlyFlag ;
        }

    }   
}

//提交函数
function commit(){
    if (confirm("确认结束本阶段?")) {
        //加载执法主体编号，及执法主体名称
         var sql = LajdBiz.findZfjtBhAndMcBiz(wft_id);
        findZfjtDataset.Open(sql);
        //获取执法主体编号，及执法主体名称
         var buId = findZfjtDataset.Fields.Field["bu_id"].Value;//执法主体编号
         var buName = findZfjtDataset.Fields.Field["bu_name"].Value;//执法主体名称
        
         var postilVo= new DiagnosesVo.Postil() ;
        //给批注赋初始化值
         postilVo.WFT_ID = wft_id  ;
        postilVo.NDP_ID = ndp_id ;
        postilVo.TP_END_DATE = FormUtil.getServerDate();//获取服务器上的时间 
         postilVo.TP_POSTIL = "" ;//执法人员意见
         postilVo.TP_IMAGE = "图片" ;
        postilVo.TP_SYS = "" ;
        postilVo.TP_STATUS = 1 ;
        postilVo.TP_EMY = getSysElement("userid");
        postilVo.TP_FW_NAME = "" ;
        postilVo.TP_ES_NAME = "" ;
        postilVo.TP_EMY_SET = getSysElement("userid");//执法人员
         postilVo.ISPLATFORM = 0 ;
        postilVo.SU_ID_INNER = buId ;
        postilVo.TP_SYSUNIT_NAME = buName ;
        postilVo.SEGMENT_ID = "" ;
        postilVo.WORKFLOW_NAME = "调查取证" ;
        postilVo.TP_INFO = 0 ;
        var cfsxslVo = new LajdVo.WorkFlowTicket() ; //处罚事项实例类
         cfsxslVo.WFT_ID= wft_id ; //处罚事项实例编号
         cfsxslVo.PI_ID = pi_id ; //事项编号 
         cfsxslVo.NDP_ID = postilVo.NDP_ID ; //阶段编号
         var vr = Diagnoses.submitDiagnosesBiz(postilVo,cfsxslVo);
        if(vr){
            alert("提交数据信息成功！");
            backBtn();
        }else{
            alert("提交数据信息失败!");
        }
    }
        
}

//修改调查取证信息函数
function updateDcqz(grid, rowIndex, e){
    var row = grid.store.getById(grid.store.data.items[rowIndex].id); 
    var mdEditId= row.get("md_edit_date");
    var wft_id= row.get("wft_id");
    var ldtId= row.get("ldt_id");
    var tempURL="20100919163051506628.jsp?eflag="+flags+"&MD_EDIT_DATE="+mdEditId+"&LDT_ID="+ldtId+"&wft_id="+wft_id+"&pi_id="+pi_id+"&ndp_id="+ndp_id+"&bu_id="+bu_id+"&bu_name="+bu_name+"&readOnlyFlag="+readOnlyFlag ;
    window.location.href(tempURL);
    reloadExtGrid();
}

//新增调查取证信息函数
function loadAddDcqz(){
    var tempPara="dialogWidth:800px;dialogHeight:800px";
    var tempURL="20100919163051506628.jsp?eflag="+flags+"&wft_id="+wft_id+"&pi_id="+pi_id+"&ndp_id="+ndp_id+"&bu_id="+bu_id+"&bu_name="+bu_name+"&readOnlyFlag="+readOnlyFlag;
    window.location.href(tempURL);
    reloadExtGrid();
}

//删除调查取证信息函数
function delDcqz(){
    var grid =  creator_pt_grids[0].obj;
    var rows = grid.getSelectionModel().getSelections();
        var ids = new Array();
        var mdEditId = new Array();
        for(var i=0;i<rows.length;i++){
           var mdDeitDate = rows[i].get("wfss_id");//违法事实对应的提交材料清单流水
            var tempDate = rows[i].get("md_edit_date");//编辑时间
            ids[ids.length] = mdDeitDate; 
           mdEditId[mdEditId.length] = tempDate;                   
        }
        if(ids.length==0){    
           alert("请选择要删除的记录！");
           return false;
        }else{
           var rv = Diagnoses.delDcqzBiz(ids, wft_id, mdEditId);
           if(rv){
              alert("删除数据信息成功！");
           }else{
               alert("删除数据信息失败！");
           }
        }
     reloadExtGrid();
}

//调查终结结果函数
function dczjjg(){
    var grid =  creator_pt_grids[0].obj;
    var rows = grid.getSelectionModel().getSelections();
        var ids = new Array();
        for(var i=0;i<rows.length;i++){
           var mdDeitDate = rows[i].get("md_edit_date");
           ids[ids.length] = mdDeitDate ;                  
        }
        if(ids.length==0){    
           alert("请选择作为终结结果的记录");
           return false;
        }else if(ids.length>1){
            alert("最终信息只能选择一条，请重新选择");
            return false ;
        }else{
            var mdTime = ids[0] ; //时间主键
              Diagnoses.updDcqzssBiz(wft_id,ndp_id,0);//修改在此之前作为最终结果的信息
              Diagnoses.updDcqzsssBiz(mdTime);//以选中的信息作为最终结果
         }
        reloadExtGrid();
}

//返回
function backBtn(){
    if(flags==0){
        parent.window.location.href = "20100918105821975107.jsp";
    }else{
        parent.window.location.href = "20100929153136375631.jsp";
    }
}
</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><div><id>div1</id></div><button><id>saveBut</id><id>updBut</id><id>diaoChaBut</id><id>submitBut</id><id>backBut</id></button><text><id>read_only</id></text><dataset><id>dataset6</id><id>findZfjtDataset</id></dataset><creatorSubForm><id>creatorSubForm2</id></creatorSubForm><ExtGrid><id>ExtGrid12</id></ExtGrid></root>" billtaborder="<root><taborder>saveBut</taborder><taborder>updBut</taborder><taborder>submitBut</taborder><taborder>backBut</taborder><taborder>diaoChaBut</taborder><taborder>read_only</taborder></root>" dj_sn="20100925191216234397" caption="调查取证信息列表" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:1;DsMain_field:0;a:0;button:12;text:1;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:8;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:2;creator_div:0;ExtGrid:12;ExtUpload:0;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181230265751" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Namespace.js&#13;&#10;../../../ccapp/app_xzcf/js/common/nsreg.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/util/WorkflowUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/util/DateUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/DiagnosesVo.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/LajdVo.js&#13;&#10;../../../ccapp/app_xzcf/js/business/Diagnoses.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/DiagnosesDao.js&#13;&#10;../../../ccapp/app_xzcf/js/business/LajdBiz.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/LajdDao.js">

<TABLE cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
   <TBODY>
      <TR>
         <TD><?xml:namespace prefix = fc /><fc:dataset id=dataset6 showtypeXml="<root><showType><name>checkbox</name><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showType></root>" columnHeight1Xml="undefined" columnWidth1Xml="undefined" format="<fields><field><fieldname>checkbox</fieldname><datatype>字符</datatype><displaylabel>选择</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>wfss</fieldname><datatype>字符</datatype><displaylabel>违法事实</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>tp_postil</fieldname><datatype>字符</datatype><displaylabel>执法人员意见</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>tp_emy_set</fieldname><datatype>字符</datatype><displaylabel>执法人员</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>blsj</fieldname><datatype>字符</datatype><displaylabel>办理时间</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>wft_id</fieldname><datatype>字符</datatype><displaylabel>处罚事项编号</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>md_edit_date</fieldname><datatype>字符</datatype><displaylabel>编辑时间（主键）</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>MD_REFER_ATTRI</fieldname><datatype>字符</datatype><displaylabel>调查终结结果</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ldt_id</fieldname><datatype>字符</datatype><displaylabel>列式文档归类编号</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>wfss_id</fieldname><datatype>字符</datatype><displaylabel>违法事实清单流水</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><checkbox></checkbox><wfss></wfss><tp_postil></tp_postil><tp_emy_set></tp_emy_set><blsj></blsj><wft_id></wft_id><md_edit_date></md_edit_date><MD_REFER_ATTRI></MD_REFER_ATTRI><ldt_id></ldt_id><wfss_id></wfss_id></dsid>")' onGetText='bill_ondatasetgettext("<dsid><checkbox></checkbox><wfss></wfss><tp_postil></tp_postil><tp_emy_set></tp_emy_set><blsj></blsj><wft_id></wft_id><md_edit_date></md_edit_date><MD_REFER_ATTRI></MD_REFER_ATTRI><ldt_id></ldt_id><wfss_id></wfss_id></dsid>")' onValid='bill_ondatasetvalid("<dsid><checkbox></checkbox><wfss></wfss><tp_postil></tp_postil><tp_emy_set></tp_emy_set><blsj></blsj><wft_id></wft_id><md_edit_date></md_edit_date><MD_REFER_ATTRI></MD_REFER_ATTRI><ldt_id></ldt_id><wfss_id></wfss_id></dsid>")' opensortno="1" temptable="TMP_DATASET6" multiResult="否"></fc:dataset></TD>
      </TR>
      <TR>
         <TD>
            <TABLE class=Ctable cellSpacing=0 cellPadding=0 width="100%" border=0>
               <TBODY>
                  <TR>
                     <TD class=taobox>调查取证</TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <TR>
         <TD><fc:dataset id=findZfjtDataset format="<fields><field><fieldname>bu_id</fieldname><datatype>字符</datatype><displaylabel>执法主体编号</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>bu_name</fieldname><datatype>字符</datatype><displaylabel>执法主体名称</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><bu_id></bu_id><bu_name></bu_name></dsid>")' onGetText='bill_ondatasetgettext("<dsid><bu_id></bu_id><bu_name></bu_name></dsid>")' onValid='bill_ondatasetvalid("<dsid><bu_id></bu_id><bu_name></bu_name></dsid>")' opensortno="1" temptable="TMP_DATASET2" multiResult="是"></fc:dataset></TD>
      </TR>
      <TR>
         <TD colSpan=2><IMG style="DISPLAY: none" src="undefined"><DIV id=div_ExtGrid12 style="LEFT: 0px; POSITION: static; TOP: 0px"></DIV><SCRIPT type=text/javascript>var ExtGrid12;
Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';
var ExtGrid12_retint = 0;
var ExtGrid12_onReady = function(){ 
 Ext.QuickTips.init();
var dataset = document.getElementById("dataset6");
try{var temp = dataset.Fields.Field.length;}catch(e){if(ExtGrid12_retint==0) ExtGrid12_retint = setInterval(ExtGrid12_onReady,200);dataset =null;return;}finally{if(temp!=null)temp=null;}
clearInterval(ExtGrid12_retint);ExtGrid12_retint = null ;var pagesize =5;
dataset.PageSize = pagesize ;
var mapping = creator_pt_getmapping(dataset);
var store  = new Ext.data.Store({
	proxy: new Ext.data.CreatorMemoryProxy("dataset6"), 
	reader: new Ext.data.XmlStringReader({       record: 'tr',       totalRecords: 'pages'   }, mapping)});
var sm = new Ext.grid.RowSelectionModel({singleSelect: true});
var retcm = creator_pt_getcm(dataset,sm);var cm = new Ext.grid.ColumnModel(retcm);
if(typeof(retcm[0].getCount)!='undefined') sm = retcm[0] ;
 ExtGrid12 = new Ext.grid.GridPanel({
		el: 'div_ExtGrid12',        store: store,
        cm:cm,
		sm: sm,
 			 bodyStyle : 'width:100%',
		viewConfig: {
			forceFit: true		},       loadMask: true,
	width: '100%',
					height: eval(document.body.clientHeight*(parseFloat('40%')))/100,
		split: true,
		region: 'north',
		title:'查询结果列表',
		frame:true
		,plugins: new Ext.ux.PanelResizer({
            minHeight: 100        }),
       bbar: new Ext.PagingToolbar({
            pageSize: pagesize,
            store: store,
            displayInfo: true,
            displayMsg:'当前显示第 {0} - {1} 条，共 {2} 条',            plugins: new Ext.ux.SlidingPager()        })		    });
    var grid=ExtGrid12;
		grid.getStore().on('datachanged', function() {
		var hd_checker = grid.getEl().select('div.x-grid3-hd-checker');
		var hd = hd_checker.first();
		if(hd != null){ 
			hd.removeClass('x-grid3-hd-checker-on');
		}
});

/**
使用说明                      
1.注释不要用 //。
2.可以操作当前Grid的sm、cm、store对象。
3.这里的代码用于一些个性化的需求，如某列的某些特定工作。
**/
cm.setHidden(5,true);
cm.setHidden(6,true);
//cm.setHidden(7,true);
cm.setHidden(8,true);
/**cm.setHidden(9,true);**/
grid.addListener('rowdblclick',updateDcqz);ExtGrid12.render();
store.load({params:{start:0, limit:pagesize}});
if(typeof(creator_pt_grids)=='undefined'){creator_pt_grids=new Array();}
creator_pt_grids.push({id:'ExtGrid12',obj:ExtGrid12,dataset:'dataset6',isEdit:'false'});
if(typeof(onGridPanelLoaded)=='function') setTimeout(onGridPanelLoaded,0);
};
ExtGrid12_onReady();window.onresize=function(){try{ExtGrid12.setWidth(eval(document.body.clientWidth*(parseFloat('95%')))/100);}catch(e){}};</SCRIPT></TD>
      </TR>
      <TR>
         <TD align=middle height=20><INPUT id=read_only style="DISPLAY: none; LEFT: 31px; WIDTH: 5px; POSITION: static; TOP: 277px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"><BUTTON class=button id=saveBut style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("loadAddDcqz();")'>新增调查信息</BUTTON><BUTTON class=button id=updBut style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("delDcqz();")'>删除选中信息</BUTTON><BUTTON class=button id=diaoChaBut style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("dczjjg();")'>调查终结结果</BUTTON><BUTTON class=button id=submitBut style="LEFT: 611px; POSITION: static; TOP: 13px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("commit()")'>提交</BUTTON><BUTTON class=button id=backBut style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("backBtn();")'>返回</BUTTON></TD>
      </TR>
      <TR>
         <TD><DIV id=div1 style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 370px; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="div" NotBg="否"><IFRAME id=creatorSubForm2 style="LEFT: 5px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 367px" onmovestart=moveStart() src="" frameBorder=yes scrolling=no controltype="creatorSubForm" id_load="1" objType="eform" reportname urlargs autoload="yes" autoSetSize="no" url="../../jxc/dj/20100928144328000151.jsp?1=1&amp;name=&amp;"></IFRAME></DIV></TD>
      </TR>
      <TR>
         <TD>
            <TABLE cellSpacing=0 cellPadding=0 width=760 border=0>
               <TBODY>
                  <TR>
                     <TD></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
   </TBODY>
</TABLE>
</DIV>
<div id='grid_tip'></div></body></html>