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
					
			s=0;
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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/DBUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/DBUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/DateUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/DateUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/SimplyVo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/SimplyVo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/Simply.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/Simply.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/SimplyDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/SimplyDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/JycxajIndex.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/JycxajIndex.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/JycxajIndexDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/JycxajIndexDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/FormUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/FormUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/EndCase.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/EndCase.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/EndCaseDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/EndCaseDao.js'></script>");
if(!bDgMode) out.println("</script>");
%>

   <script >document.styleSheets[0].addRule(".fcmask","behavior: url(../../fceform/htc/fcmask.htc)",0);</script>
   <script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script>
   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/js/fcmask.vbs');
adv_loadjsfile('/eformsys/fceform/css/Button.css');
adv_loadjsfile('/eformsys/fceform/css/TextStyle.css');
adv_loadjsfile('/eformsys/fceform/js/fcdataset.js');
</script>


<!-- 提示：以下为页面自定义JS内容 -->
<script>
/**
 *模块：简易程序
 *作者：shixing.he
 *时间：2011-01-18
 *状态：update
 **/
var djbh = "<%=request.getParameter("djbh")%>"; 
var wft_id = "<%=request.getParameter("wft_id")%>";
var flag = "<%=request.getParameter("flag")%>";
var thisOneCaseType = "<%=request.getParameter("thisOneCaseType")%>";
var wfxwId = "";//违法行为ID
//var bu_id = creator_getQueryString("bu_id");
var bu_id = parent.bu_id;
var bu_name = creator_getQueryString("bu_name");

//获取当前用户
var orgname = getSysElement("userorgname");
var user = getSysElement("username");
var user_id = getSysElement("userid");

function init(){
   $("orTheLaw").style.display = "none";//隐藏添加执法依据
    $("orRule").style.display = "none";//隐藏添加处罚依据
    wfxwId = JycxajIndex.selectWFXW(wft_id);
    offence_degree();//加载违法行为和违法程度下拉框
    var tepStatus = selectStatus();//查询批注状态
    if(!IsSpace(tepStatus)){
        if(tepStatus == 0){//暂存
            selectPunishInfo();
        } else if (tepStatus == 1){//提交
           selectPunishInfo();
        }
    }

    if(parent.ndp_id == 5){
        selectPunishInfo();
        readOnlyFun();//只读
    }
}

//查询执法主体ID和执法主体名称
function findBuIdAndBuName(){
    var sql = EndCase.findBuIdAndBuName(user_id);
    var arr = DBUtil.getQueryArray(sql, 0, -1);
    return arr;
}

//查询批注状态
function selectStatus(){
    return Simply.findStatus(wft_id,9);//批注状态
}

//查询该处罚事项实例的违法行为
function queryWFXW(){
    return JycxajIndex.selectWFXW(wft_id);
}

function degree(){  //违法情节程度下拉菜单实际初始化函数
    var offence_id = wfxwId;  //得到违法行为名称id 
    var obj=document.getElementById('JD_BRIEF_OF_CASE').options;//清空违法情节和违法程度下拉菜单
    if(obj!=null){
        var j=obj.length;
        var i=0;
        for( i=0;i<j;i++)
            obj.options.remove(0); 
            }
    obj=document.getElementById('JD_LAW_DEGREE').options;
    if(obj!=null){
        j=obj.length;
        for( i=0;i<j;i++)
            obj.options.remove(0); 
            }
    
    var  sql="select t.rdd_illegal_plot from ta_rule_dictionary_detail t where t.rmd_id="+offence_id;
    SqlCombo(document.getElementById('JD_BRIEF_OF_CASE'),sql) ;
    sql="select t.rdd_law_degree from ta_rule_dictionary_detail t  where t.rmd_id="+offence_id;
    SqlCombo(document.getElementById('JD_LAW_DEGREE'),sql) ;
    
}

function offence_degree(){   //违法行为下的违法情节和违法程度选择下拉菜单生成  违法依据和执法依据初始化
     var offence_id = wfxwId;  //得到违法行为名称id 
     if (offence_id==-1) {
         document.getElementById("JD_LAW_DEGREE").options[0].innerText = "--请选择--";
         document.getElementById("JD_LAW_DEGREE").options[0].value = -1;
         document.getElementById("JD_BRIEF_OF_CASE").options[0].innerText = "--请选择--";
         document.getElementById("JD_BRIEF_OF_CASE").options[0].value = -1;
         return false;
     }
     degree();
    
    //执法依据
    sql="select t.rmd_the_law from ta_rule_matter_dictionary t  where t.rmd_id="+offence_id;
    document.getElementById('OR_THE_LAW').value=SqlToField(sql);

    //处罚依据
    sql="select  t.rmd_rule from ta_rule_matter_dictionary t  where t.rmd_id="+offence_id;
    document.getElementById('OR_RULE').value=SqlToField(sql);
}

/**
 *函数：tiJiaoAndBaoCun
 *描述：提交和保存的函数
 *作者：zefeng.yu
**/
function tiJiaoAndBaoCun(status){        
        //包含 “执法依据” 和 “处罚依据” 信息
         var recordVo = new SimplyVo.record(); //违法记录VO
        recordVo.OR_ID = getOrIdByWftId(wft_id);//通过wft_id查询or_id
        recordVo.WFT_ID = wft_id;//处罚事项实例ID      
        recordVo.RMD_ID = wfxwId;//违法行为ID
        recordVo.NDP_ID = 1;//受理阶段
         recordVo.OR_THE_LAW = $('OR_THE_LAW').value.trim();//执法依据
         recordVo.OR_THE_LAW2 = $('OR_THE_LAW2').value.trim();//添加的执法依据
         recordVo.OR_RULE = $('OR_RULE').value.trim();//处罚依据
         recordVo.OR_RULE2 = $('OR_RULE2').value.trim();//添加的处罚依据

         //包含 “处罚决定内容”和 “附件上传” 提交文档清单VO
        var multiVo = new Array();//提交文档清单VO数组
         //处罚决定内容VO
        var multiVo1 = new SimplyVo.multi();
        multiVo1.LDT_ID = 6;//列式文档归类(处罚决定)
        multiVo1.NDP_ID = 9;//生成处罚决定阶段
         multiVo1.MD_TITLE = "处罚决定内容";
        multiVo1.MD_NUM = 1;//份数
         multiVo1.MD_EDIT_DATE = getNowTime();//编辑时间
         multiVo1.MD_DSM = 1;//材料储存方式（数据库）
         multiVo1.MD_BODY = $('punishDetail').value;//处罚决定内容
         multiVo1.MD_BODY_ATTRI = 0;//材料体属性(标准材料)
        multiVo1.MD_ISTEMPLATE = 0;//有模板(没有模板)
        multiVo1.MD_TSM = 1;//模板储存方式(数据库)
        multiVo1.MD_ISACCESSORIES = 0;//有附件（没有附件）
         multiVo1.MD_ASM = 0;//附件存储方式（null）
         multiVo1.ISPLATFORM = 0;//是否是平台节点(不是平台节点)
        multiVo1.WORKFLOW_NAME = "生成处罚决定";//流程名称
         multiVo1.MD_REFER_ATTRI = 0;//可选
         //处罚决定书上传VO(附件)
        var multiVo2 = new SimplyVo.multi();
        multiVo2.LDT_ID = 6;//列式文档归类(处罚决定)
        multiVo2.MT_ID = 4;//材料介质(.doc)
        multiVo2.NDP_ID = 9;//生成处罚决定阶段
         multiVo2.MD_TITLE = "处罚决定书上传";
        multiVo2.MD_NUM = 1;//份数
         multiVo2.MD_EDIT_DATE = multiVo1.MD_EDIT_DATE;//编辑时间
         multiVo2.MD_DSM = 3;//材料储存方式（平台）
         multiVo2.MD_BODY = $('MD_ACCESSORIES_BODY').value;//处罚决定内容
         multiVo2.MD_BODY_ATTRI = 1;//材料体属性(补充信息)
        multiVo2.MD_ISTEMPLATE = 1;//有模板(有模板)
        multiVo2.MD_TSM = 1;//模板储存方式(数据库)
        multiVo2.MD_ISACCESSORIES = 1;//有附件（有附件）
         multiVo2.MD_ASM = 3;//附件存储方式（平台）
         multiVo2.ISPLATFORM = 1;//是否是平台节点(是平台节点)
        multiVo2.WORKFLOW_NAME = "生成处罚决定";//流程名称
         multiVo2.MD_REFER_ATTRI = 0;//可选
         
         multiVo[0] = multiVo1;
        multiVo[1] = multiVo2;

        //罚款金额VO
        var simpleVo = new SimplyVo.simple();
        simpleVo.WFT_PENALTY_SUM = $('WFT_PENALTY_SUM').value;//罚款金额
        
        //裁量细则实例VO
        var detailVo = new SimplyVo.detail();
        detailVo.NDP_ID = 9;//生成处罚决定
         detailVo.JD_EDIT_DATE = multiVo1.MD_EDIT_DATE;//编辑日期
         detailVo.JD_BRIEF_OF_CASE = "111";//违法情节
         detailVo.JD_ISVALUE = 1;//有金额
         detailVo.JD_ATTRI = 1;//取值规则
         detailVo.JD_UPPER = 0;//上限
         detailVo.JD_LOWER = 0;//下限
         detailVo.JD_VALUE_UPPER = 0;//金额上限
         detailVo.JD_VALUE_LOWER = 0;//金额下限
         detailVo.JD_VALUE = $('WFT_PENALTY_SUM').value;//罚款金额
         detailVo.JD_SUM_EXPOSURE = 0;//金额方向（借方）
         detailVo.JD_STATUTE_ITEM = 0;//法规项(否)
        detailVo.ISPLATFORM = 0;//不是平台节点
         detailVo.WORKFLOW_NAME = "生成处罚决定";//流程名称
         
         //执行明细VO
        var listsVo = new SimplyVo.lists();
        listsVo.EL_DATE = $('EL_DATE').value;//处罚决定时间
         listsVo.EL_VOUCHER_NUMBER  = $('EL_VOUCHER_NUMBER').value;//处罚收据编号
         listsVo.EL_SUM = $('WFT_PENALTY_SUM').value;//罚款金额     
         listsVo.EL_SUM_EXPOSURE = 0;//借方
         listsVo.EL_LATE_FEE_ITEM = 0;//不是滞纳金
         
         //批注VO
        var postilVo = new SimplyVo.Postil();
        postilVo.TP_DATE = multiVo1.MD_EDIT_DATE;//批注时间
         postilVo.NDP_ID = 9;//生成处罚决定
         if(status == 1){//提交
            postilVo.TP_END_DATE = multiVo1.MD_EDIT_DATE;//离开时间
         } else {//暂存
           postilVo.TP_END_DATE = null;
        }
        postilVo.TP_STATUS = status; //状态
         postilVo.TP_EMY = user_id;//批注人（当前用户）
         var result = findBuIdAndBuName();//当前用户的执法主体名称
         postilVo.TP_FW_NAME = result[0][1];//归属部门
         postilVo.ISPLATFORM = 0;//是否是平台节点
        postilVo.SU_ID_INNER = bu_id;//业务单位内码（当前处罚事项实例所属执法主体ID）
         postilVo.TP_SYSUNIT_NAME = bu_name;//当前处罚事项实例所属执法主体
         postilVo.WORKFLOW_NAME = "生成处罚决定";//流程名称
         postilVo.TP_INFO = 0;//不是补充资料
         
        //执法人集VO
        var executeMenVo = new SimplyVo.executeMen();
        executeMenVo.TP_DATE = multiVo1.MD_EDIT_DATE;//批注时间
         executeMenVo.EMY_ID = $('userIds').value;//人员内码
         executeMenVo.EMY_NAME = $('userNames').value;//人员名称
 
         //违法事实VO
        var wfssVo = new SimplyVo.multi();
        wfssVo.MD_BODY = $('wfssID').value;
 
 
         var tempStatus = selectStatus();//查询批注状态

         if(IsSpace(tempStatus)){//新增
            if(validate()){
                var v = Simply.insertSimpleCaseInfo(recordVo, multiVo, simpleVo, detailVo, listsVo, postilVo, executeMenVo, wfssVo);
                if(v){
                    alert("保存成功");
                    if(status == 1){
                        parent.window.location.href = "20100916091232930767.jsp";//简易程序查询列表
                       }
                }else{
                    alert("保存失败");
                }
            }
        }else{//修改
            if(validate()){
                var v = Simply.updateSimpleCaseInfo(recordVo, multiVo, simpleVo, detailVo, listsVo, postilVo, executeMenVo, wfssVo);
                if(v){
                    alert("保存成功");
                    if(status == 1){
                        parent.window.location.href = "20100916091232930767.jsp";//简易程序查询列表
                       }
                }else{
                    alert("保存失败");
                }
            }
        }
}

//查询处罚决定信息
function selectPunishInfo(){
    //返回: 执法依据，处罚依据，罚金，收据编号，处罚决定时间
    var result1 = Simply.selectAllPunishInfo(wft_id);
    //返回：处罚决定内容 和 附件ID
    var result2 = Simply.selectPunishInfo(wft_id);
    //返回：   执法人员名称，执法人员ID
    var result3 = Simply.selectExecuteMenAndId(wft_id, 9);
    //返回：    违法事实内容
    var result4 = Simply.selectWfssInfo(wft_id);

    $('wfssID').value = result4;
    $('OR_THE_LAW2').value = result1[0][0];
    $('OR_RULE2').value = result1[0][1];
    $('punishDetail').value = result2[0][0];
    $('WFT_PENALTY_SUM').value = result1[0][2];
    $('EL_VOUCHER_NUMBER').value = result1[0][3];
    $('userNames').value = result3[0][0];
    $('EL_DATE').value = result1[0][4].split(" ")[0];
    $('MD_ACCESSORIES_BODY').value = result2[1][0];
    $('userIds').value = result3[0][1];
}

var flagLaw = 0;//默认为隐藏
function addTheLaw(){ //添加执法依据
    if(flagLaw == 0){//如果为隐藏
        $("orTheLaw").style.display = "";//展开
        flagLaw = 1;
    } else {
       $("orTheLaw").style.display = "none";//隐藏
        flagLaw = 0;
    } 
}

var flagRule = 0;//默认为隐藏
function addRule(){  //添加处罚依据
    if(flagRule == 0){//如果为隐藏
        $("orRule").style.display = "";//展开
        flagRule = 1;   
    } else {
       $("orRule").style.display = "none";//隐藏
        flagRule = 0;
    }
}

function close(){
    parent.window.location.href = "20100916091232930767.jsp";//简易程序查询列表
}

function isdigit(s)//判断金额
{
    var r,re;
    re = /\d*.{0,1}\d{1,2}/;
    r = s.match(re);
    return (r==s)?true:false;
}

function isdate(s)//判断日期格式
{
    var r,re;
    re = /\d{4}-\d{2}-\d{2}/;
    r = s.match(re);
    return (r==s)?true:false;
}

//附件上传按钮函数
/* 打开上传下载页面 */
function openUploadAndDownView(){
    var isAllowDelete = true ;
    var id = $('MD_ACCESSORIES_BODY').value;
    if(IsSpace(id)){
     id = DBUtil.getSeq('SEQ_LITIGANT_RD');
     $('MD_ACCESSORIES_BODY').value = id;
    }
    var allowAdd = true;
    var name = "app_xzcf";
    var viewAddr =getOpenUrlByDjid("20100920113019725484")+"&id="+id+"&allowDelete="+isAllowDelete+
             "&allowAdd="+allowAdd+"&mode_name="+name+"&djbh="+id +
             "&fileCount=10" ;
    var featrues = "dialogWidth:640px;dialogHeight:360px;center:yes;help:no;resizable:no;status:no;scroll:no";
    var rtn = window.showModalDialog(viewAddr,window,featrues); 
    return rtn ;
}

//打开新证据按钮函数
function openNewProof(){
    var tempPara="dialogWidth:800px;dialogHeight:300px;";
    var tempURL="20100928171808109374.jsp?wft_id="+wft_id ;
    showModalDialog(tempURL,"window",tempPara);
    reloadExtGrid();
}

//当前服务器时间
function getNowTime(){
    return FormUtil.getServerDate();
}

//只读
function readOnlyFun(){
    document.getElementById("wfssID").disabled = true;
    document.getElementById("wfssID").style.width = "100%";

    $('OR_THE_LAW').value = $('OR_THE_LAW2').value;
    $('OR_RULE').value = $('OR_RULE2').value;
    document.getElementById("button4").style.display = "none";//隐藏添加执法依据按钮
    document.getElementById("button5").style.display = "none";//隐藏添加处罚依据按钮
    document.getElementById("OR_THE_LAW").style.width = "100%";
    document.getElementById("OR_RULE").style.width = "100%";
    
    $('punishDetail').disabled = true;
    document.getElementById("punishDetail").style.width = "100%";
    $('WFT_PENALTY_SUM').disabled = true;
    $('EL_VOUCHER_NUMBER').disabled = true;
    $('userNames').disabled = true;
    $('EL_DATE').disabled = true;
    $('button12').style.display = "none";
    $('button8').style.display = "none";
    document.getElementById("userNames").style.width = "100%";
}

//界面元素的验证函数
function validate(){
    var flag = true;
        
    //罚款金额
    if(flag){
       flag = SValidator.validate(document.getElementById('wft_penalty_sum').value, {
        CHECK_TYPE : "required",
        ARGUMENT : {placeholders : ["罚款金额"]}
        }, true);
    }
    
    if(flag){
        flag = SValidator.validate(${'WFT_PENALTY_SUM'}.value, {
            CHECK_TYPE : "integer",
            ARGUMENT : {placeholders : ["罚款金额"],length : 0}
        }, false);
    }
    
    //罚款凭证
    if(flag){
       flag = SValidator.validate(document.getElementById('EL_VOUCHER_NUMBER').value, {
        CHECK_TYPE : "required",
        ARGUMENT : {placeholders : ["处罚收据编号"]}
        }, true);
                    
    }
    
    if(flag){
        flag = SValidator.validate(${'EL_VOUCHER_NUMBER'}.value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [20],maxlength : 20},
            MESSAGE : "处罚收据编号最大不能超过{0}字符"
        }, true);
    }

    
    //执法人
    if(flag){
       flag = SValidator.validate(document.getElementById("userIds").value, {
        CHECK_TYPE : "required",
        ARGUMENT : {placeholders : ["执法人员"]}
        }, true);             
    }

    //处罚决定时间
    if(flag){
       flag = SValidator.validate(document.getElementById('EL_DATE').value, {
        CHECK_TYPE : "required",
        ARGUMENT : {placeholders : ["处罚决定时间"]}
        }, true);
    }
    
    if(flag){
        var sysDate = DateUtil.getSysTime();
        var newDate = $('EL_DATE').value ;
        if(flag){
            flag = DateUtil.opinionStartTimeEndTime(newDate,sysDate);
            if(!flag){
                alert("处罚决定时间不能大于系统当前时间");
                return false ;
            }
        }    
    }
    return  flag;
}

//通过wft_id查询违法记录ID
function getOrIdByWftId(t_id){
    return Simply.getOr_IdByWft_Id(t_id);
}

//打开执法人员的选择
function openUserTree(){
    url = "../../../ccapp/app_xzcf/jsp/baseservice/chooseOrgLawUserTree.jsp?bu_id="+bu_id;
    chooseUsers = window.showModalDialog(url,window, "dialogWidth=620px;dialogHeight=500px");
}
</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><textarea><id>wfssID</id><id>OR_THE_LAW</id><id>OR_THE_LAW2</id><id>OR_RULE</id><id>OR_RULE2</id><id>punishDetail</id></textarea><combobox><id>JD_LAW_DEGREE</id><id>JD_BRIEF_OF_CASE</id></combobox><button><id>button4</id><id>button5</id><id>button13</id><id>button11</id><id>button12</id><id>button8</id><id>button10</id></button><text><id>WFT_PENALTY_SUM</id><id>EL_VOUCHER_NUMBER</id><id>userNames</id><id>EL_DATE</id><id>MD_ACCESSORIES_BODY</id><id>WFT_ID</id><id>userIds</id></text><dataset><id>detail</id></dataset></root>" billtaborder="<root><taborder>OR_THE_LAW</taborder><taborder>OR_THE_LAW2</taborder><taborder>OR_RULE</taborder><taborder>OR_RULE2</taborder><taborder>punishDetail</taborder><taborder>JD_LAW_DEGREE</taborder><taborder>JD_BRIEF_OF_CASE</taborder><taborder>button4</taborder><taborder>button5</taborder><taborder>button13</taborder><taborder>button11</taborder><taborder>button12</taborder><taborder>button8</taborder><taborder>button10</taborder><taborder>WFT_PENALTY_SUM</taborder><taborder>EL_VOUCHER_NUMBER</taborder><taborder>userNames</taborder><taborder>EL_DATE</taborder><taborder>MD_ACCESSORIES_BODY</taborder><taborder>WFT_ID</taborder><taborder>userIds</taborder><taborder>wfssID</taborder></root>" dj_sn="20110118163931515096" caption="处罚决定信息" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:0;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181244984828" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Namespace.js&#13;&#10;../../../ccapp/app_xzcf/js/common/nsreg.js&#13;&#10;../../../ccapp/app_xzcf/js/util/DBUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/util/DateUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/SimplyVo.js&#13;&#10;../../../ccapp/app_xzcf/js/business/Simply.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/SimplyDao.js&#13;&#10;../../../ccapp/app_xzcf/js/util/WorkflowUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/business/JycxajIndex.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/JycxajIndexDao.js&#13;&#10;../../../ccapp/app_xzcf/js/util/FormUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/business/EndCase.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/EndCaseDao.js">

<TABLE cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
   <TBODY>
      <TR>
         <TD>
            <TABLE class=Ctable cellSpacing=0 cellPadding=0 width="100%" border=0>
               <TBODY>
                  <TR>
                     <TD class=taobox colSpan=4>处罚决定信息</TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">违法事实<SPAN style="COLOR: red">*</SPAN></TD>
                     <TD width="85%" colSpan=3><TEXTAREA id=wfssID style="LEFT: 0px; WIDTH: 83.5%; POSITION: static; TOP: 0px; HEIGHT: 85px" onmovestart=moveStart() controltype="textarea" value="textarea9" induce="否"></TEXTAREA></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">执法依据</TD>
                     <TD width="85%" colSpan=3><TEXTAREA id=OR_THE_LAW style="LEFT: 0px; WIDTH: 83.5%; POSITION: static; TOP: 0px; HEIGHT: 85px" onmovestart=moveStart() readOnly cols=117 controltype="textarea" field="OR_THE_LAW" china="执法依据" dataset="insertOrUpdateDateset" value="textarea4" induce="否"></TEXTAREA><BUTTON class=button id=button4 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("addTheLaw()")'>添加执法依据</BUTTON></TD>
                  </TR>
                  <TR id=orTheLaw>
                     <TD class=c2 width="15%">&nbsp;</TD>
                     <TD width="85%" colSpan=3><TEXTAREA id=OR_THE_LAW2 style="LEFT: 0px; WIDTH: 83.5%; POSITION: static; TOP: 0px; HEIGHT: 72px" onmovestart=moveStart() rows=1 cols=117 controltype="textarea" value="textarea4" induce="否"></TEXTAREA></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">处罚依据</TD>
                     <TD width="85%" colSpan=3><TEXTAREA id=OR_RULE style="LEFT: 0px; WIDTH: 83.5%; POSITION: static; TOP: 0px; HEIGHT: 83px" onmovestart=moveStart() rows=1 readOnly cols=117 controltype="textarea" field="OR_RULE" china="处罚依据" dataset="insertOrUpdateDateset" value="textarea5" induce="否"></TEXTAREA><BUTTON class=button id=button5 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("addRule()")'>添加处罚依据</BUTTON></TD>
                  </TR>
                  <TR id=orRule>
                     <TD class=c2 width="15%">&nbsp;</TD>
                     <TD width="85%" colSpan=3><TEXTAREA id=OR_RULE2 style="LEFT: 0px; WIDTH: 83.5%; POSITION: static; TOP: 0px; HEIGHT: 56px" onmovestart=moveStart() rows=1 cols=117 controltype="textarea" value="textarea5" induce="否"></TEXTAREA></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">违法程度<SPAN style="COLOR: red">*</SPAN></TD>
                     <TD width="35%"><SELECT id=JD_LAW_DEGREE style="LEFT: 0px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%F2%D6%D6%CC%E0%D6Xr%94%F2%D6%D6%CC%E6%D0%FC%CC%D6%D8%DC%F2%D8%D8Xrn%DA%F2%EC%E8Xrn%B6%90%CC%B2%B8%A6%98%CC%96%A0%94%B6%A0%AC%AA%90%B2%C0%CC%96%98%B6%90%A0%A6" controltype="combobox" field="JD_LAW_DEGREE" china="违法程度" dataset="insertOrUpdateDateset" tempvalue="-1" temptext="--请选择--" sql check="1"><OPTION value=-1 selected>--请选择--</OPTION></SELECT></TD>
                     <TD class=c2 width="15%">违法情节<SPAN style="COLOR: red">*</SPAN></TD>
                     <TD width="35%"><SELECT id=JD_BRIEF_OF_CASE style="LEFT: 0px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%F2%D6%D6%CC%E0%D6Xr%94%F2%D6%D6%CC%E0%E6%E6%D8%DC%D0%E6%CC%EE%E6%EC%F6Xrn%DA%F2%EC%E8Xrn%B6%90%CC%B2%B8%A6%98%CC%96%A0%94%B6%A0%AC%AA%90%B2%C0%CC%96%98%B6%90%A0%A6" controltype="combobox" field="JD_BRIEF_OF_CASE" china="违法情节" dataset="insertOrUpdateDateset" tempvalue="-1" temptext="--请选择--" sql check="1"><OPTION value=-1 selected>--请选择--</OPTION></SELECT></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">处罚决定内容</TD>
                     <TD width="85%" colSpan=3><TEXTAREA id=punishDetail style="LEFT: 0px; WIDTH: 83.5%; POSITION: static; TOP: 0px; HEIGHT: 85px" onmovestart=moveStart() cols=88 controltype="textarea" value="textarea2" induce="否"></TEXTAREA></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">罚款金额<SPAN style="COLOR: red">*</SPAN></TD>
                     <TD width="35%"><INPUT class=input_out id=WFT_PENALTY_SUM style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=28 controltype="text"></TD>
                     <TD class=c2 width="15%">处罚收据编号<SPAN style="COLOR: red">*</SPAN></TD>
                     <TD width="35%"><INPUT class=input_out id=EL_VOUCHER_NUMBER style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=27 controltype="text"></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">执法人员<SPAN style="COLOR: red">*</SPAN></TD>
                     <TD width="35%"><INPUT class=input_image id=userNames style="LEFT: 0px; WIDTH: 90%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" onclick='bill_onclick("openUserTree();")'></TD>
                     <TD class=c2 width="15%">处罚决定时间<SPAN style="COLOR: red">*</SPAN></TD>
                     <TD width="35%"><INPUT class=its_out id=EL_DATE style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=29 controltype="text" onclick='bill_onclick("SelectDate()")'></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">处罚决定书上传</TD>
                     <TD width="85%" colSpan=3><BUTTON class=button id=button13 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("openUploadAndDownView();")'>附件上传</BUTTON><INPUT id=MD_ACCESSORIES_BODY style="DISPLAY: none; LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">添加证据信息</TD>
                     <TD width="85%" colSpan=3><BUTTON class=button id=button11 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("openNewProof();")'>添加证据</BUTTON><INPUT id=WFT_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 57px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=10 controltype="text"><INPUT id=userIds style="DISPLAY: none; LEFT: 0px; WIDTH: 46px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=8 controltype="text"></TD>
                  </TR>
                  <TR>
                     <TD align=middle width="100%" colSpan=4><BUTTON class=button id=button12 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("tiJiaoAndBaoCun(0)")'>暂存</BUTTON><BUTTON class=button id=button8 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("tiJiaoAndBaoCun(1)")'>提交</BUTTON><BUTTON class=button id=button10 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("close()")'>返回</BUTTON></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
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

<?xml:namespace prefix = fc />

<fc:dataset id=detail format="<fields><field><fieldname>RDD_ID</fieldname><datatype>字符</datatype><displaylabel>RDD_ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>OL_ID</fieldname><datatype>字符</datatype><displaylabel>OL_ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RDD_ILLEGAL_PLOT</fieldname><datatype>字符</datatype><displaylabel>RDD_ILLEGAL_PLOT</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RDD_LAW_DEGREE</fieldname><datatype>字符</datatype><displaylabel>RDD_LAW_DEGREE</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RDD_ISVALUE</fieldname><datatype>字符</datatype><displaylabel>RDD_ISVALUE</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RDD_ATTRI</fieldname><datatype>字符</datatype><displaylabel>RDD_ATTRI</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RDD_UPPER</fieldname><datatype>字符</datatype><displaylabel>RDD_UPPER</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RDD_LOWER</fieldname><datatype>字符</datatype><displaylabel>RDD_LOWER</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RDD_BASEUNIT_DESC</fieldname><datatype>字符</datatype><displaylabel>RDD_BASEUNIT_DESC</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RDD_VALUE_UPPER</fieldname><datatype>字符</datatype><displaylabel>RDD_VALUE_UPPER</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RDD_VALUE_LOWER</fieldname><datatype>字符</datatype><displaylabel>RDD_VALUE_LOWER</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>JDD_BASEUNIT</fieldname><datatype>字符</datatype><displaylabel>JDD_BASEUNIT</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><RDD_ID></RDD_ID><OL_ID></OL_ID><RDD_ILLEGAL_PLOT></RDD_ILLEGAL_PLOT><RDD_LAW_DEGREE></RDD_LAW_DEGREE><RDD_ISVALUE></RDD_ISVALUE><RDD_ATTRI></RDD_ATTRI><RDD_UPPER></RDD_UPPER><RDD_LOWER></RDD_LOWER><RDD_BASEUNIT_DESC></RDD_BASEUNIT_DESC><RDD_VALUE_UPPER></RDD_VALUE_UPPER><RDD_VALUE_LOWER></RDD_VALUE_LOWER><JDD_BASEUNIT></JDD_BASEUNIT></dsid>")' onGetText='bill_ondatasetgettext("<dsid><RDD_ID></RDD_ID><OL_ID></OL_ID><RDD_ILLEGAL_PLOT></RDD_ILLEGAL_PLOT><RDD_LAW_DEGREE></RDD_LAW_DEGREE><RDD_ISVALUE></RDD_ISVALUE><RDD_ATTRI></RDD_ATTRI><RDD_UPPER></RDD_UPPER><RDD_LOWER></RDD_LOWER><RDD_BASEUNIT_DESC></RDD_BASEUNIT_DESC><RDD_VALUE_UPPER></RDD_VALUE_UPPER><RDD_VALUE_LOWER></RDD_VALUE_LOWER><JDD_BASEUNIT></JDD_BASEUNIT></dsid>")' onValid='bill_ondatasetvalid("<dsid><RDD_ID></RDD_ID><OL_ID></OL_ID><RDD_ILLEGAL_PLOT></RDD_ILLEGAL_PLOT><RDD_LAW_DEGREE></RDD_LAW_DEGREE><RDD_ISVALUE></RDD_ISVALUE><RDD_ATTRI></RDD_ATTRI><RDD_UPPER></RDD_UPPER><RDD_LOWER></RDD_LOWER><RDD_BASEUNIT_DESC></RDD_BASEUNIT_DESC><RDD_VALUE_UPPER></RDD_VALUE_UPPER><RDD_VALUE_LOWER></RDD_VALUE_LOWER><JDD_BASEUNIT></JDD_BASEUNIT></dsid>")' opensortno="1" temptable="TMP_DATASET2" multiResult="否"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>