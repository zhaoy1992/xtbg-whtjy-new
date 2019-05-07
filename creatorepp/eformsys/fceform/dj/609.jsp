<%@ page contentType="text/html; charset=GBK" %>
<%@page import="com.chinacreator.security.AccessControl"%>
<%AccessControl accesscontroler = AccessControl.getInstance();
  accesscontroler.checkAccess(request, response);
  String appPath = "app_"+accesscontroler.getCurrentSystemID();
  String appId = accesscontroler.getCurrentSystemID();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html xmlns:fc xmlns:v="urn:schemas-microsoft-com:vml">
	<HEAD>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">		
		<STYLE> .userData{behavior:url(#default#userData);}
	</STYLE>		
		<script src="../../fceform/js/fcpub.js"></script>
		<script src="../../fceform/js/fcrundj.js"></script>
		<script src="../../fceform/js/tabpane.js"></script>
		<script src="../../fceform/js/ccpub.js"></script>
		<script src="../../fceform/js/ccapp_pub.js"></script>		
		<script src="../../../public/gaeditor.js"></script>
		<script src="../../../iWebOffice2006/js/iWebOffice2006.js"></script>
		<script langage="javascript">
			//根据应用确定样式的目录
			var stylePath = "../../../ccapp/<%=appPath%>/"; 
			var mylink = document.createElement("link");
			mylink.setAttribute("type","text/css");
			mylink.setAttribute("rel","stylesheet");
			mylink.setAttribute("href",stylePath+"css/"+fcpubdata.creatorStyle+"/allStyle.css");
			var myhead = document.getElementsByTagName("head")[0];
			myhead.appendChild(mylink);
		</script>
				
		<jsp:include page="../../../iWebOffice2006/js/iWebOffice2006Event.jsp" flush="false"/>
	</HEAD>
	<body background="../../fceform/images/ef_run_background.gif" onload="pub_window_onload()"
		onkeydown="RunTabindex()" onbeforeunload="pub_window_onbeforeunload()" onkeypress="pub_window_onkeypress()"
		onresize="pub_window_onresize()">
		<iframe id="_newframe" name="_newframe" height="0" width="0"></iframe>
		<script>
var pubdjbh=parent.sOpenDjNo;
var pubEdit=false;   			
var pubDataSet=null;
var pubRequest=parent.oRequest;
var pubEformEnterStatus="OK"; 
pub_djhtm();
		</script>
<script src='../../fceform/js/fcopendj.js'></script><script defer src='../../fceform/js/fcsavedj.js'></script><script src='../../fceform/js/fcselfuse.js'></script><script src='../../fceform/js/fcbasecont.js'></script><script defer src='../../fceform/js/fcother.js'></script><script defer src='../../fceform/js/selectdate.js'></script><script src='../../fceform/../fceformext/js/userfunc.js'></script><script src='../../fceform/js/fcdate.js'></script><script src='../../fceform/js/<%=request.getContextPath() %>/validation/validation_cn.js'></script><link href=../../fceform/css/tabstyle.css type=text/css rel=stylesheet><link type='text/css' rel='stylesheet' href='../../fceform/css/Button.css'/><link type='text/css' rel='stylesheet' href='../../fceform/css/TextStyle.css'/><script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script><script src='../../fceform/js/fcdataset.js'></script>
<script><%
     com.chinacreator.security.AccessControl control = com.chinacreator.security.AccessControl.getInstance();
     control.checkAccess(request, response);
     response.setHeader("Pragma","No-cache");
     response.setHeader("Cache-Control","no-cache");
     response.setDateHeader("Expires", 0);
%>
var isUpdate = "<%=request.getParameter("isUpdate")%>";

//打开表单时
function _open()
{
    if(!IsSpace(isUpdate))
    {
        var _id = "<%=request.getParameter("delegateId")%>";
        var sql = "select t.DESIGNATOR_ID,t.DESIGNATOR,t.designee_id,t.designee_name,decode(t.delegate_type,2,'委派他人',1,'上级委派') as delegate_type,to_char(t.DELEGATE_TIME,'yyyy-MM-dd') as DELEGATE_TIME,decode(t.DELEGATE_STAT,1,'等待确认',2,'委派中',3,'委派结束',4,'委派取消') as DELEGATE_STAT,t.Ec_Name,t.ec_id,delegate_id,to_char(DELEGATE_END_TIME,'yyyy-MM-dd') as DELEGATE_END_TIME,to_char(DELEGATE_CANCEL_TIME,'yyyy-MM-dd') as DELEGATE_CANCEL_TIME from tb_delegate t where t.delegate_id="+_id;
        dataset1.Open(sql);
        isDesignee();
        isDesignator();

        var sql_op = "select OP_ID from tb_delegate t where t.delegate_id="+_id;
        //操作人ID
        var opId__ = SqlToField(sql_op);
        if(isManagerDelegate()&&getSysElement("userAccount")==opId__)
        {
            //如果是上级委派，且是上级操作人进来修改
            document.all.button2.style.display="block";      
            document.all.button5.style.display="block";
            document.all.button6.style.display="block";
        }
        
       if(document.all.text_delegate_stat.value=='等待确认')
      {
        //如果还没有确认，可以取消，可以修改
        document.all.button6.disabled=false;
        document.all.button2.disabled=false;
        document.all.button4.disabled=false;
        document.all.button12.disabled=false;
        document.all.text_begin_time.disabled=false;
        document.all.text_end_time.disabled=false;
      }
      else if(document.all.text_delegate_stat.value=='委派中')
      {
        //如果是委派中，可以提前结束
        document.all.button5.disabled=false;
        document.all.button2.disabled=true;
       }
      else
      {
         document.all.button2.disabled=true;
       }
    }
    else
    {
        //如果是新增，允许选择时间
        document.all.text_begin_time.disabled=false;
        document.all.text_end_time.disabled=false;
    }
    if(!isManagerDelegate())
    {
         //如果不是领导给下级委派，不允许指定委派人
         document.all.text_designator_id.value=getSysElement("userAccount");
         document.all.text_designator_name.value=getSysElement("userName");
    }
}

//选择委派人
function select_designator()
{
    var tmp_user_id = $('text_designator_id').value;
    var tmp_user_name = $('text_designator_name').value;
    if(!IsSpace(isUpdate))
    {
        //如果是修改，则打开选择树的时候，要勾选原来选择的
       $('text_designator_id').value = SqlToField("select user_id from td_sm_user where user_name='"+tmp_user_id+"'");
    }
    openTree('user',text_designator_id,text_designator_name,true);
    if(!IsSpace(document.all.text_designator_id.value))
    {
        document.all.text_designator_id.value = SqlToField("select user_name from td_sm_user where user_id="+document.all.text_designator_id.value);
        
        if(IsSpace(document.all.text_designator_id.value))
        {
           $('text_designator_id').value = tmp_user_id;
        }

        if(!hasPartManagePriv(document.all.text_designator_id.value))
        {      
           //如果没有权限，置空
           document.all.text_designator_id.value="";
           document.all.text_designator_name.value="";
        }

        validateDesignatorAndDesignee();
    }
    else
    {
           $('text_designator_id').value = tmp_user_id;
           $('text_designator_name').value = tmp_user_name; 
    }
}

//选择被委派人
function select_designee()
{
    var tmp_user_id = $('text_user_id').value;
    var tmp_user_name = $('text_user_name').value;
    if(!IsSpace(isUpdate))
    {
        //如果是修改，则打开选择树的时候，要勾选原来选择的
        $('text_user_id').value = SqlToField("select user_id from td_sm_user where user_name='"+tmp_user_id+"'");
    }
    openTree('user',text_user_id,text_user_name,true);
    if(!IsSpace(document.all.text_user_id.value))
    {
           document.all.text_user_id.value = SqlToField("select user_name from td_sm_user where  user_id="+document.all.text_user_id.value);
           if(IsSpace(document.all.text_user_id.value))
           {
              $('text_user_id').value = tmp_user_id;
           }
           validateDesignatorAndDesignee();
    }
    else
    {
         $('text_user_id').value = tmp_user_id;
         $('text_user_name').value = tmp_user_name;
    }
}

//选择委派范围
function select_delegate_area()
{
    openTree('business',text_bus_id,text_bus_name,true);
}

//新增或者修改委派信息
function addOrUpdateDelegate()
{
    if(!IsSpace(isUpdate)) updateDelegate();
    else addDelegate();
}

//修改委派信息
function updateDelegate()
{
    var delegateId = "<%=request.getParameter("delegateId")%>";
    var designeeId = document.all.text_user_id.value;
    var designeeName = document.all.text_user_name.value;
    var ec_id = document.all.text_bus_id.value;
    var ec_name = document.all.text_bus_name.value;
    //当前登陆用户ID
    var userAccount = getSysElement("userAccount");
    //当前登陆用户名
    var userName = getSysElement("userName");
    //开始时间
    var beginTime = document.all.text_begin_time.value;
    //结束时间
    var endTime = document.all.text_end_time.value;
    //委派人id
    var designatorId = document.all.text_designator_id.value;
    //委派人名字
    var designatorName = document.all.text_designator_name.value;

    var delegate_type = "1";
    
    if(!isManagerDelegate)
    {
         //如果不是上级委派
         if(IsSpace(isUpdate))
         {
           //如果不是修改状态
           designatorId = userAccount;
           designatorName = userName; 
         }
         delegate_type = "2";
    }

    if((!IsSpace(designatorId ))&&(!IsSpace(designatorName))&&(!IsSpace(designeeId))&&(!IsSpace(designeeName))&&(!IsSpace(ec_id))&&(!IsSpace(ec_name))&&(!IsSpace(beginTime))&&(!IsSpace(endTime)))
    {
       if(valTime())
       {
         //提交
         var url1 = location.protocol+"//"+location.host+fcpubdata.servletPath+"/ProcessTools?op=updateDelegate&designeeId="+designeeId+"&designeeName="+designeeName+"&ec_id="+ec_id+"&ec_name="+ec_name+"&ec_type=class&designatorId="+designatorId+"&designatorName="+designatorName+"&delegate_type="+delegate_type+"&beginTime="+beginTime+"&endTime="+endTime+"&delegateId="+delegateId;
         var retx = SendHttp(url1);
         if(retx=='success')
         {
             alert("操作成功！");
             window.returnValue = true;
             window.close();
         }
         else
         {
             alert("操作失败！");
         }
       }
    }
    else
    {
        alert("请填写全部信息！");
    }
}

//保存委派信息
function addDelegate()
{
    var designeeId = document.all.text_user_id.value;
    //designeeId = SqlToField("select user_name from td_sm_user where user_id="+designeeId);
    var designeeName = document.all.text_user_name.value;
    var ec_id = document.all.text_bus_id.value;
    var ec_name = document.all.text_bus_name.value;
    //当前登陆用户ID
    var userAccount = getSysElement("userAccount");
    //当前登陆用户名
    var userName = getSysElement("userName");
    //开始时间
    var beginTime = document.all.text_begin_time.value;
    //结束时间
    var endTime = document.all.text_end_time.value;

    //委派人id
    var designatorId = document.all.text_designator_id.value;
    //委派人名字
    var designatorName = document.all.text_designator_name.value;

    var delegate_type = "1";
    if(!isManagerDelegate())
    {
         //如果不是上级委派
         if(IsSpace(isUpdate))
         {
            //如果不是修改状态
           designatorId = userAccount;
           designatorName = userName; 
         } 
         delegate_type = "2";
    }


    if((!IsSpace(designatorId))&&(!IsSpace(designatorName))&&(!IsSpace(designeeId))&&(!IsSpace(designeeName))&&(!IsSpace(ec_id))&&(!IsSpace(ec_name))&&(!IsSpace(beginTime))&&(!IsSpace(endTime)))
    {   
       if(valTime())
       {
         //提交
         var url1 = location.protocol+"//"+location.host+fcpubdata.servletPath+"/ProcessTools?op=addDelegate&designeeId="+designeeId+"&designeeName="+designeeName+"&ec_id="+ec_id+"&ec_name="+ec_name+"&ec_type=class&designatorId="+designatorId+"&designatorName="+designatorName+"&delegate_type="+delegate_type+"&beginTime="+beginTime+"&endTime="+endTime;
         var retx = SendHttp(url1);
         if(retx=='success')
         {
             alert("操作成功！");
             window.returnValue = true;
             window.close();
         }
         else
         {
             alert("操作失败！");
         }
       }
    }
    else
    {
        alert("请填写全部信息！");
    }
}

//接受委派任务
function confirmDelegate()
{
    var delegateId = "<%=request.getParameter("delegateId")%>";
    var url1 = location.protocol+"//"+location.host+fcpubdata.servletPath+"/ProcessTools?op=confirmDelegate&delegateId="+delegateId;
     var retx = SendHttp(url1);
         if(retx=='success')
         {
             alert("操作成功！");
             window.returnValue = true;
             window.close();
         }
         else
         {
             alert("操作失败！");
         }
}

//拒绝接受委派任务
function rejectDelegate()
{
    var delegateId = "<%=request.getParameter("delegateId")%>";
    var url1 = location.protocol+"//"+location.host+fcpubdata.servletPath+"/ProcessTools?op=rejectDelegate&delegateId="+delegateId;
     var retx = SendHttp(url1);
         if(retx=='success')
         {
             alert("操作成功！");
             window.returnValue = true;
             window.close();
         }
         else
         {
             alert("操作失败！");
         }
}

//结束任务
function endDelegate()
{
    var delegateId = "<%=request.getParameter("delegateId")%>";
    var url1 = location.protocol+"//"+location.host+fcpubdata.servletPath+"/ProcessTools?op=endDelegate&delegateId="+delegateId;
     var retx = SendHttp(url1);
         if(retx=='success')
         {
             alert("操作成功！");
             window.returnValue = true;
             window.close();
         }
         else
         {
             alert("操作失败！");
         }
}


//取消委派
function cancelDelegate()
{
    var delegateId = "<%=request.getParameter("delegateId")%>";
    var url1 = location.protocol+"//"+location.host+fcpubdata.servletPath+"/ProcessTools?op=cancelDelegate&delegateId="+delegateId;
     var retx = SendHttp(url1);
         if(retx=='success')
         {
             alert("操作成功！");
             window.returnValue = true;
             window.close();
         }
         else
         {
             alert("操作失败！");
         }
}

//是不是委派人
function isDesignator()
{
    if(getSysElement("userAccount")==document.all.text_designator_id.value)
    {
         if(!IsSpace(isUpdate))
         {
             document.all.button2.style.display="block";      
             document.all.button5.style.display="block";
             document.all.button6.style.display="block";
         }
         return true;
    }
    else
    {
         return false;
     }
}

//是不是被委派人
function isDesignee()
{
    if(getSysElement("userAccount")==document.all.text_user_id.value)
    {
        document.all.button4.style.display="block";
        document.all.button12.style.display="block";
        document.all.button1.disabled =true;
        document.all.button3.disabled =true;
        document.all.button7.disabled = true;
        document.all.button2.style.display="none";
        return true;
    }
        return false;
}

//是不是上级委派
function isManagerDelegate()
{
    var isManager= "<%=request.getParameter("isManager")%>";
    if((!IsSpace(isManager)))
    {
        document.all.button7.disabled = false;
        return true;
    }
    else
    {
        //document.all.text_designator_id.style.display ="none";
        //document.all.text_designator_name.style.display ="none";
        document.all.button7.disabled = true;
        return false;
    }
}

//验证开始日期和结束日期
function valTime()
{
    //开始时间
    var beginTime = document.all.text_begin_time.value;
    //结束时间
    var endTime = document.all.text_end_time.value;
    var d1,d2;
    var t1 = beginTime.split("-");
    var t2 = endTime.split("-");
    d1 = new Date(t1[0],parseInt(t1[1]-1),t1[2]);
    d2 = new Date(t2[0],parseInt(t2[1]-1),t2[2]);

    //当前日期
    <%
         java.util.Calendar calendar = java.util.Calendar.getInstance();
         int year = calendar.get(calendar.YEAR);
         int month = calendar.get(calendar.MONTH);
         int day = calendar.get(calendar.DAY_OF_MONTH);
    %>
    var curDate = new Date('<%=year%>','<%=month%>','<%=day%>');   
    if(d1<curDate)
    {
        alert("开始时间不能小于当前日期！");
        return false;
    }
    if(d2>d1)
    {
        return true;
     }
    else
    {
        alert("结束时间必须大于开始时间！");
        return false;
    }
}

//验证是否有用户所在部门管理员的权限
function hasPartManagePriv(userId)
{
    var url1 = location.protocol+"//"+location.host+fcpubdata.servletPath+"/ProcessTools?op=hasPartManagePriv&userId="+userId;
     var retx = SendHttp(url1);
    if(retx=="true") return true;
    else
    {
        alert("没有足够的权限！"); 
        return false;
    }
}

//验证委派人和被委派人是否合法
function validateDesignatorAndDesignee()
{
    //委派人和被委派人不能是同一个人
    if(IsSpace(text_designator_id.value))
    {
        alert("请先选择委派人！");
        $('text_user_id').value="";
        $('text_user_name').value="";
        return false;
    }
    else if(text_designator_id.value==document.all.text_user_id.value)
    {
        alert("委派人和被委派人不能是同一个人！");
        $('text_user_id').value="";
        $('text_user_name').value="";
        return false;
    }
    return true;
}</script><DIV id=SKbillsheet jslib="fcopendj.js&#13;&#10;fcsavedj.js&#13;&#10;fcselfuse.js&#13;&#10;fcbasecont.js&#13;&#10;fcother.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;<%=request.getContextPath() %>/validation/validation_cn.js" creatorType="5680" type="ZW" creator_office_isBindForm="否" creator_showAlert="否" creator_elementAuthoritySwitch="否" contxml="<root><label><id>label1</id><id>label2</id><id>label3</id><id>label4</id><id>label5</id><id>label6</id></label><button><id>button1</id><id>button2</id><id>button3</id><id>button4</id><id>button5</id><id>button6</id><id>button7</id><id>button12</id></button><text><id>text_user_id</id><id>text_user_name</id><id>text_bus_name</id><id>text_bus_id</id><id>text_begin_time</id><id>text_end_time</id><id>text_designator_name</id><id>text_designator_id</id><id>text_delegate_stat</id></text><dataset><id>dataset1</id></dataset></root>" controlno="SKButton:0;SKDBedit:0;checkbox:0;label:6;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:1;DsMain_field:0;a:0;button:12;text:9;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:4;spin:0;excel:0;tree:2;ebshow:0;creatorSubForm:0;creator_div:0" billtaborder="<root><taborder>button1</taborder><taborder>text_user_id</taborder><taborder>text_user_name</taborder><taborder>button2</taborder><taborder>button3</taborder><taborder>text_bus_name</taborder><taborder>text_bus_id</taborder><taborder>text_begin_time</taborder><taborder>text_end_time</taborder><taborder>button4</taborder><taborder>button5</taborder><taborder>button6</taborder><taborder>button7</taborder><taborder>text_designator_name</taborder><taborder>text_designator_id</taborder><taborder>text_delegate_stat</taborder><taborder>button12</taborder></root>" version="1.0" idtype="2" OtherSave="否" isfile="否" posheight poswidth postop posleft isprotect="是" islog="否" hasWorkflowButton="否" creator_remark entertype="修改" window="当前窗口" BLONclose="UnLoadWebOffice();" BLONopen="setAuthority();_open();" keyfield codeheader="BBB" mkbh caption="任务委派" dj_sn="609" toolbar="不带工具栏" creator_pagination><DIV id=label1 style="FONT-SIZE: 20px; LEFT: 213px; WIDTH: 65px; FONT-STYLE: normal; FONT-FAMILY: 宋体; POSITION: absolute; TOP: 26px; HEIGHT: 15px" onmovestart=moveStart() noWrap NotBg="否" controltype="label" value="label1">任务委派</DIV>
<DIV id=label2 style="LEFT: 69px; WIDTH: 65px; POSITION: absolute; TOP: 122px; HEIGHT: 15px" onmovestart=moveStart() noWrap NotBg="否" controltype="label" value="label2">委派给</DIV><INPUT id=text_user_id style="DISPLAY: none; LEFT: 379px; WIDTH: 110px; POSITION: absolute; TOP: 117px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" china="被委派人ID" dataset="dataset1" field="DESIGNEE_ID"><BUTTON id=button1 style="LEFT: 279px; WIDTH: 90px; POSITION: absolute; TOP: 115px; HEIGHT: 25px" onmovestart=moveStart() controltype="button" dropstyle="否" onclick='bill_onclick("select_designee()")'>选择被委派人</BUTTON><INPUT id=text_user_name style="LEFT: 139px; WIDTH: 110px; POSITION: absolute; TOP: 117px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" china="被委派人" dataset="dataset1" field="DESIGNEE_NAME"><BUTTON id=button2 style="LEFT: 66px; WIDTH: 75px; POSITION: absolute; TOP: 268px; HEIGHT: 25px" onmovestart=moveStart() controltype="button" dropstyle="否" onclick='bill_onclick("addOrUpdateDelegate()")'>保存</BUTTON> 
<DIV id=label3 style="LEFT: 69px; WIDTH: 65px; POSITION: absolute; TOP: 158px; HEIGHT: 15px" onmovestart=moveStart() noWrap NotBg="否" controltype="label" value="label3">委派范围</DIV><INPUT id=text_bus_name style="LEFT: 139px; WIDTH: 110px; POSITION: absolute; TOP: 152px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" china="委派范围名" dataset="dataset1" field="EC_NAME"><INPUT id=text_bus_id style="DISPLAY: none; LEFT: 379px; WIDTH: 110px; POSITION: absolute; TOP: 150px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" china="委派范围" dataset="dataset1" field="EC_ID"><BUTTON id=button3 style="LEFT: 279px; WIDTH: 90px; POSITION: absolute; TOP: 146px; HEIGHT: 25px" onmovestart=moveStart() controltype="button" dropstyle="否" onclick='bill_onclick("select_delegate_area()")'>选择委派范围</BUTTON> 
<DIV id=label4 style="LEFT: 69px; WIDTH: 65px; POSITION: absolute; TOP: 234px; HEIGHT: 15px" onmovestart=moveStart() noWrap NotBg="否" controltype="label" value="label4">结束日期</DIV>
<DIV id=label5 style="LEFT: 69px; WIDTH: 65px; POSITION: absolute; TOP: 194px; HEIGHT: 15px" onmovestart=moveStart() noWrap NotBg="否" controltype="label" value="label5">开始日期</DIV><INPUT id=text_begin_time style="LEFT: 139px; WIDTH: 110px; POSITION: absolute; TOP: 192px; HEIGHT: 20px" disabled onmovestart=moveStart() readOnly controltype="text" china="开始时间" dataset="dataset1" field="DELEGATE_TIME" onclick='bill_onclick("if(isManagerDelegate()||isDesignator()){SelectDate();}")'><INPUT id=text_end_time style="LEFT: 139px; WIDTH: 110px; POSITION: absolute; TOP: 230px; HEIGHT: 20px" disabled onmovestart=moveStart() readOnly controltype="text" china="结束时间" dataset="dataset1" field="DELEGATE_END_TIME" onclick='bill_onclick("if(isManagerDelegate()||isDesignator()){SelectDate();}")'><?xml:namespace prefix = fc /><fc:dataset id=dataset1 opensortno="1" temptable="TMP_DATASET4" saveastable="APP_244.tb_delegate" multiResult="是" onValid='bill_ondatasetvalid("<dsid><EC_ID></EC_ID><EC_NAME></EC_NAME><DELEGATE_TIME></DELEGATE_TIME><DELEGATE_END_TIME></DELEGATE_END_TIME><DESIGNEE_ID></DESIGNEE_ID><DESIGNEE_NAME></DESIGNEE_NAME><designator_id></designator_id><designator></designator><delegate_stat></delegate_stat></dsid>")' onGetText='bill_ondatasetgettext("<dsid><EC_ID></EC_ID><EC_NAME></EC_NAME><DELEGATE_TIME></DELEGATE_TIME><DELEGATE_END_TIME></DELEGATE_END_TIME><DESIGNEE_ID></DESIGNEE_ID><DESIGNEE_NAME></DESIGNEE_NAME><designator_id></designator_id><designator></designator><delegate_stat></delegate_stat></dsid>")' onSetText='bill_ondatasetsettext("<dsid><EC_ID></EC_ID><EC_NAME></EC_NAME><DELEGATE_TIME></DELEGATE_TIME><DELEGATE_END_TIME></DELEGATE_END_TIME><DESIGNEE_ID></DESIGNEE_ID><DESIGNEE_NAME></DESIGNEE_NAME><designator_id></designator_id><designator></designator><delegate_stat></delegate_stat></dsid>")' format="<fields><field><fieldname>EC_ID</fieldname><datatype>字符</datatype><displaylabel>委派范围</displaylabel><size>200</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag></field><field><fieldname>EC_NAME</fieldname><datatype>字符</datatype><displaylabel>委派范围名</displaylabel><size>200</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag></field><field><fieldname>DELEGATE_TIME</fieldname><datatype>字符</datatype><displaylabel>开始时间</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat>yyyy-mm-dd</displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag></field><field><fieldname>DELEGATE_END_TIME</fieldname><datatype>字符</datatype><displaylabel>结束时间</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat>yyyy-MM-dd</displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag></field><field><fieldname>DESIGNEE_ID</fieldname><datatype>字符</datatype><displaylabel>被委派人ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag></field><field><fieldname>DESIGNEE_NAME</fieldname><datatype>字符</datatype><displaylabel>被委派人</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag></field><field><fieldname>designator_id</fieldname><datatype>字符</datatype><displaylabel>委派人ID</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag></field><field><fieldname>designator</fieldname><datatype>字符</datatype><displaylabel>委派人名</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag></field><field><fieldname>delegate_stat</fieldname><datatype>字符</datatype><displaylabel>委派状态</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag></field></fields>"></fc:dataset><BUTTON id=button4 style="DISPLAY: none; LEFT: 64px; WIDTH: 75px; POSITION: absolute; TOP: 301px; HEIGHT: 25px" disabled onmovestart=moveStart() controltype="button" dropstyle="否" onclick='bill_onclick("confirmDelegate()")'>接受任务</BUTTON><BUTTON id=button5 style="DISPLAY: none; LEFT: 149px; WIDTH: 75px; POSITION: absolute; TOP: 268px; HEIGHT: 25px" disabled onmovestart=moveStart() controltype="button" dropstyle="否" onclick='bill_onclick("endDelegate()")'>提前结束</BUTTON><BUTTON id=button6 style="DISPLAY: none; LEFT: 232px; WIDTH: 75px; POSITION: absolute; TOP: 267px; HEIGHT: 25px" disabled onmovestart=moveStart() controltype="button" dropstyle="否" onclick='bill_onclick("cancelDelegate()")'>取消委派</BUTTON> 
<DIV id=label6 style="LEFT: 69px; WIDTH: 65px; POSITION: absolute; TOP: 90px; HEIGHT: 15px" onmovestart=moveStart() noWrap NotBg="否" controltype="label" value="label6">委派人</DIV><INPUT id=text_designator_name style="LEFT: 139px; WIDTH: 110px; POSITION: absolute; TOP: 79px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" china="委派人名" dataset="dataset1" field="designator"><INPUT id=text_designator_id style="DISPLAY: none; LEFT: 379px; WIDTH: 110px; POSITION: absolute; TOP: 79px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" china="委派人ID" dataset="dataset1" field="designator_id"><BUTTON id=button7 style="LEFT: 279px; WIDTH: 75px; POSITION: absolute; TOP: 77px; HEIGHT: 25px" onmovestart=moveStart() controltype="button" dropstyle="否" onclick='bill_onclick("select_designator()")'>选择委派人</BUTTON> <INPUT id=text_delegate_stat style="DISPLAY: none; LEFT: 343px; WIDTH: 110px; POSITION: absolute; TOP: 222px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" china="委派状态" dataset="dataset1" field="delegate_stat"><BUTTON id=button12 style="DISPLAY: none; LEFT: 149px; WIDTH: 75px; POSITION: absolute; TOP: 302px; HEIGHT: 25px" disabled onmovestart=moveStart() controltype="button" dropstyle="否" onclick='bill_onclick("rejectDelegate()")'>拒绝接受</BUTTON></DIV></body></html>