<%@page import="com.chinacreator.xtbg.caizhengting.ibrary.entity.IbraryRegBookBookInfoBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.caizhengting.ibrary.entity.IBraryRegBookInfoBean"%>
<%@page import="com.chinacreator.xtbg.caizhengting.ibrary.entity.IbraryBookInfoBean"%>
<%@page import="com.chinacreator.xtbg.caizhengting.ibrary.service.IbraryBookInfoService"%>
<%@page import="com.chinacreator.xtbg.caizhengting.ibrary.service.impl.IbraryBorrowInfoServiceImpl"%>
<%@page import="com.chinacreator.xtbg.pub.util.BeanUtil"%>
<%@page import="com.chinacreator.xtbg.caizhengting.ibrary.service.impl.IbraryBookInfoServiceImpl"%>
<%@page import="com.chinacreator.xtbg.caizhengting.ibrary.service.IbraryBorrowInfoService"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
 <title>
 </title>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	String actiontype = request.getParameter("actiontype"); //处理类型
	
	String doWhat = request.getParameter("doWhat"); //操作类型
	
	String t_regb_ids = request.getParameter("t_regb_ids");
	
	String subid = request.getParameter("subid");   //windowID
	
	String T_REGB_ID = request.getParameter("T_REGB_ID");  //申请表主键
	String T_REGB_TRUEGH_DATE = request.getParameter("T_REGB_TRUEGH_DATE");  //实际归还时间
	String T_REGB_USER_ID = request.getParameter("T_REGB_USER_ID");  //借阅人ID
	String T_REGB_USER_NAME = request.getParameter("T_REGB_USER_NAME");  //借阅人名称
	String T_REGB_DATE = request.getParameter("T_REGB_DATE");  //申请时间
	String T_REGB_ORG_NAME = request.getParameter("T_REGB_ORG_NAME");  //申请登记部门名称
	String T_REGB_ORG_ID = request.getParameter("T_REGB_ORG_ID");  //申请登记部门ID
	String T_REGB_DEPT_ID = request.getParameter("T_REGB_DEPT_ID");  //申请登记单位ID
	String T_REGB_DEPT_NAME = request.getParameter("T_REGB_DEPT_NAME");  //申请登记单位名称
	String T_REGB_JY_DATE = request.getParameter("T_REGB_JY_DATE");  //借阅时间
	String T_REGB_GH_DATE = request.getParameter("T_REGB_GH_DATE");  //应归还时间
	String T_REGB_BOOKIDS = request.getParameter("T_REGB_BOOKIDS");  //借阅图书IDS
	String T_REGB_BOOKNAMES = request.getParameter("T_REGB_BOOKNAMES");  //借阅图书名称
	String T_REGB_STATE = request.getParameter("T_REGB_STATE");  //申请状态
	String T_REGB_ISKONW = request.getParameter("T_REGB_ISKONW");  //是否知悉
	String T_REGB_ISXJ = request.getParameter("T_REGB_ISXJ");  //是否续借
	String T_REGB_SQTYPE=request.getParameter("T_REGB_SQTYPE");//申请类型
	String T_REGB_AUDITOPINION = request.getParameter("T_REGB_AUDITOPINION");//审核意见
	
	String[] T_REG_BOOK_ID_Arr = request.getParameterValues("T_REG_BOOK_ID"); //申请图书表ID
	String[] T_REG_BOOK_BOOK_ID_Arr = request.getParameterValues("T_REG_BOOK_BOOK_ID"); //图书ID
	String[] T_REG_BOOK_BOOK_JG_Arr = request.getParameterValues("T_REG_BOOK_BOOK_JG"); //图书价格
	String[] T_REG_BOOK_BOOK_NAME_Arr = request.getParameterValues("T_REG_BOOK_BOOK_NAME"); //图书名称
	String[] T_REG_BOOK_BOOK_BH_Arr = request.getParameterValues("T_REG_BOOK_BOOK_BH"); //图书编号
	String[] T_REG_BOOK_BOOK_NO_Arr = request.getParameterValues("T_REG_BOOK_BOOK_NO"); //图书数量
	String[] T_REG_BOOK_BOOK_AUTER_Arr = request.getParameterValues("T_REG_BOOK_BOOK_AUTER"); //图书作者
	
	T_REGB_BOOKIDS = "";
	T_REGB_BOOKNAMES = "";
	if(T_REG_BOOK_BOOK_ID_Arr != null){
		for(int i = 1; i<T_REG_BOOK_BOOK_ID_Arr.length;i++){
			if(i>1){
				T_REGB_BOOKIDS += ",";
				T_REGB_BOOKNAMES += ",";
			}
			T_REGB_BOOKIDS += T_REG_BOOK_BOOK_ID_Arr[i];
			T_REGB_BOOKNAMES += T_REG_BOOK_BOOK_NAME_Arr[i];
		}
	}
	
	IBraryRegBookInfoBean iBraryRegBookInfoBean = new IBraryRegBookInfoBean();
	iBraryRegBookInfoBean.setT_regb_id(T_REGB_ID);
	iBraryRegBookInfoBean.setT_regb_truegh_date(T_REGB_TRUEGH_DATE);
	iBraryRegBookInfoBean.setT_regb_user_id(T_REGB_USER_ID);
	iBraryRegBookInfoBean.setT_regb_user_name(T_REGB_USER_NAME);
	iBraryRegBookInfoBean.setT_regb_date(T_REGB_DATE);
	iBraryRegBookInfoBean.setT_regb_org_id(T_REGB_ORG_ID);
	iBraryRegBookInfoBean.setT_regb_org_name(T_REGB_ORG_NAME);
	iBraryRegBookInfoBean.setT_regb_dept_id(T_REGB_DEPT_ID);
	iBraryRegBookInfoBean.setT_regb_dept_name(T_REGB_DEPT_NAME);
	iBraryRegBookInfoBean.setT_regb_jy_date(T_REGB_JY_DATE);
	iBraryRegBookInfoBean.setT_regb_gh_date(T_REGB_GH_DATE);
	iBraryRegBookInfoBean.setT_regb_bookids(T_REGB_BOOKIDS);
	iBraryRegBookInfoBean.setT_regb_booknames(T_REGB_BOOKNAMES);
	iBraryRegBookInfoBean.setT_regb_state(T_REGB_STATE);
	iBraryRegBookInfoBean.setT_regb_iskonw(T_REGB_ISKONW);
	iBraryRegBookInfoBean.setT_regb_isxj(T_REGB_ISXJ);
	iBraryRegBookInfoBean.setT_regb_sqtype(T_REGB_SQTYPE);
	iBraryRegBookInfoBean.setT_regb_auditopinion(T_REGB_AUDITOPINION);//审核意见
	IbraryBorrowInfoService service = new IbraryBorrowInfoServiceImpl();
	//更新图书 的borrow_id;
	IbraryBookInfoService bookservice = new IbraryBookInfoServiceImpl();
	IbraryBookInfoBean bookbean = new IbraryBookInfoBean();
	String flag = "操作失败";
	boolean stateBoolean1 = false;
	boolean stateBoolean2 = false;
	List<Map<String, String>> bookInfoList = new ArrayList<Map<String,String>>();
	
	if("save".equals(actiontype)){
		T_REGB_ID = bookservice.insertOrUpdateRegBookInfo(iBraryRegBookInfoBean);                 //申请表信息处理
		stateBoolean1 = bookservice.deleteRegBookBookInfo(new String[]{T_REGB_ID});   //删除申请表对应的申请图书信息
		for(int i = 0;i<T_REG_BOOK_BOOK_ID_Arr.length;i++){                           //添加申请的图书表信息
			if(!StringUtil.isBlank(T_REG_BOOK_BOOK_ID_Arr[i])){
				IbraryRegBookBookInfoBean ibraryRegBookBookInfoBean = new IbraryRegBookBookInfoBean();
				ibraryRegBookBookInfoBean.setT_reg_book_book_id(T_REG_BOOK_BOOK_ID_Arr[i]);
				ibraryRegBookBookInfoBean.setT_reg_book_book_jg(T_REG_BOOK_BOOK_JG_Arr[i]);
				ibraryRegBookBookInfoBean.setT_reg_book_book_bh(T_REG_BOOK_BOOK_BH_Arr[i]);
				ibraryRegBookBookInfoBean.setT_reg_book_book_auter(T_REG_BOOK_BOOK_AUTER_Arr[i]);
				ibraryRegBookBookInfoBean.setT_reg_book_book_name(T_REG_BOOK_BOOK_NAME_Arr[i]);
				ibraryRegBookBookInfoBean.setT_reg_book_book_no(T_REG_BOOK_BOOK_NO_Arr[i]);
				ibraryRegBookBookInfoBean.setT_reg_book_regid(T_REGB_ID);
				bookservice.insertOrUpdateRegBookBookInfo(ibraryRegBookBookInfoBean);   //添加申请的图书表信息
				
				if("giveTY".equals(doWhat)){                              //同意借阅操作
					bookInfoList = bookservice.queryBookInfo(T_REG_BOOK_BOOK_ID_Arr[i]);    //查询图书的库存信息
					long bookNumber = Long.parseLong(bookInfoList.get(0).get("book_number")); //库存的图书数量
					long nowBookNumber = Long.parseLong(T_REG_BOOK_BOOK_NO_Arr[i]);           //申请的图书数量
	                String setBookNumber = ""+(bookNumber-nowBookNumber);				
					bookbean.setBook_id(T_REG_BOOK_BOOK_ID_Arr[i]);
					bookbean.setBook_number(setBookNumber);
					bookservice.updateBookNumber(bookbean);                         //更新图书库存
				}else if("tsGH".equals(doWhat)){                           //归还操作
					bookInfoList = bookservice.queryBookInfo(T_REG_BOOK_BOOK_ID_Arr[i]);    //查询图书的库存信息
					long bookNumber = Long.parseLong(bookInfoList.get(0).get("book_number")); //库存的图书数量
					long nowBookNumber = Long.parseLong(T_REG_BOOK_BOOK_NO_Arr[i]);           //申请的图书数量
	                String setBookNumber = ""+(bookNumber+nowBookNumber);				
					bookbean.setBook_id(T_REG_BOOK_BOOK_ID_Arr[i]);
					bookbean.setBook_number(setBookNumber);
					bookservice.updateBookNumber(bookbean);                         //更新图书库存
				}
			}
		}
		flag = "操作成功";
	}else if("del".equals(actiontype)){   //删除申请表
         boolean isSuss = bookservice.deleteRegBookInfo(t_regb_ids);
         if(isSuss){
        	 flag = "操作成功";
         }
	}
%>
</head>
<body>
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript"
			src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript">
var mes = "<%=flag%>";
var bool = true;
if(mes=="操作失败"){
   bool = false;
}
if(<%="del".equals(actiontype)%>){
	var ok=function(){
		window.parent.location.reload();
	}
}else{
	var ok=function(){
		window.top.getIFrameDOM("_document_body_mian_firstPagerAAAS").location.reload();
		//待办任务进入
		if(<%="main_todowork1".equals(subid)%>){
			removeWindows('<%=subid%>',true);
		} else {
			window.parent.parent.location.reload();
			removeWindows('<%=subid%>',true,false);
		}
	}
}

if(bool){
	window.top.alert(mes,{headerText:'处理结果',okName:'确认',okFunction:ok})
}
else{
	window.top.alert(mes)
}
</script>
</body> 
</html>
