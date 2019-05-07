<%--
描述：查看用户薪酬信息
作者：童佳
日期：2014-03-25
 --%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.directory.entity.HeTongBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.directory.entity.DirectoryBean"%>
<%@page
	import="com.chinacreator.xtbg.core.directory.service.impl.DirectoryServiceImpl"%>
<%@page
	import="com.chinacreator.xtbg.core.directory.service.DirectoryServiceIfc"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>

<title>JGRID</title>

<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	
	String urls = request.getParameter("urls");
	String orgid = request.getParameter("orgid");
	String typeid = request.getParameter("typeid");
    UserCacheBean userCacheBean = UserCache.getUserCacheBean(typeid);
	
	String org_id = userCacheBean.getOrg_id();
	String org_name = userCacheBean.getOrg_name();
	//当前用户ID
	String user_id = accesscontroler.getUserID();
	String orgname = DaoUtil.sqlToField("select org_name from td_sm_organization where org_id = '"+orgid+"'");
	DirectoryServiceIfc directoryServiceIfc = new DirectoryServiceImpl();
	String numberOne = "否";
	DirectoryBean directoryBean = new DirectoryBean();
	String peizhiUserIds = "";
	HeTongBean heTongBean = new HeTongBean();
	if (!StringUtil.isBlank(typeid)) {
		directoryBean = directoryServiceIfc
		.getTypeBeanById(typeid,"view");
		if("是".equals(directoryBean.getNumberone())){
			numberOne ="是";
		}
		heTongBean = directoryServiceIfc.getHeTongBeanById(typeid);
		
		peizhiUserIds = directoryServiceIfc.getPeizhiUserId(user_id);
	}
	if(!StringUtil.isBlank(peizhiUserIds)){
		peizhiUserIds = peizhiUserIds + ",";
	}
	
	
%>
<!-- 公共部分开始 -->
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入jQuery UI -->
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>

<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<!-- 公共部分结束 -->
<script type="text/javascript">
/**
 * 关闭
 */
function closed(){
	removeAlertWindows('',true);
}
</script>
</head>
<body style="overflow-x:hidden;overflow-y:auto;" class="vcenter">
	<form id="form1" action="" method="post"
		class="formular">
		<div >
			<table class="content_02_box_div_table">
				<tr>
					<td class="content_02_box_title_bg">基本资料</td>
				</tr>
			</table>
			<div>
			<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table">
				<tr>
					<th class="content_02_box_div_table_th"> 姓名：</th>
					<td class="content_02_box_div_table_td">
					    <%=StringUtil.deNull(directoryBean.getDirectoryname())%>&nbsp;
					</td>
					<th class="content_02_box_div_table_th">工作部门：</th>
					<td class="content_02_box_div_table_td">
					   <input type="hidden" name="org_id" id="org_id" value="<%=StringUtil.deNull(org_id)%>" />
					   <%=StringUtil.deNull(org_name)%>&nbsp;
					</td>
				</tr>
			</table>
			</div>
			
			<table class="content_02_box_div_table">
				<tr>
					<td class="content_02_box_title_bg">薪酬信息</td>
				</tr>
			</table>
			<div>
			<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table">
				<tr>
					<th class="content_02_box_div_table_th">岗位工资：</th>
					<td class="content_02_box_div_table_td" style="width: 190px;">
                        <%=StringUtil.deNull(directoryBean.getNew_xc_gwgz())%>&nbsp;
                    </td>
					<th class="content_02_box_div_table_th">薪级工资：</th>
					<td class="content_02_box_div_table_td">
						<%=StringUtil.deNull(directoryBean.getNew_xc_xjgz())%>&nbsp;
                    </td>
				</tr>

				<tr>
					<th class="content_02_box_div_table_th">应发合计：</th>
					<td class="content_02_box_div_table_td">
						<%=StringUtil.deNull(directoryBean.getNew_xc_yfgz())%>&nbsp;
                    </td>
					<th class="content_02_box_div_table_th">医保：</th>
					<td class="content_02_box_div_table_td">
						<%=StringUtil.deNull(directoryBean.getNew_xc_yb())%>&nbsp;
                    </td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th">养老保险：</th>
					<td class="content_02_box_div_table_td">
						<%=StringUtil.deNull(directoryBean.getNew_xc_ylbx())%>&nbsp;
                    </td>
					<th class="content_02_box_div_table_th">失业保险：</th>
					<td class="content_02_box_div_table_td">
						<%=StringUtil.deNull(directoryBean.getNew_xc_sybx())%>&nbsp;
                    </td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th">公积金：</th>
					<td class="content_02_box_div_table_td">
						 <%=StringUtil.deNull(directoryBean.getNew_xc_gjj())%>&nbsp;
                    </td>
					<th class="content_02_box_div_table_th">补扣：</th>
					<td class="content_02_box_div_table_td">
						<%=StringUtil.deNull(directoryBean.getNew_xc_cb())%>&nbsp;
                    </td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th">扣款合计：</th>
					<td class="content_02_box_div_table_td">
						<%=StringUtil.deNull(directoryBean.getNew_xc_cbhj())%>&nbsp;
                    </td>
					<th class="content_02_box_div_table_th">实发合计：</th>
					<td class="content_02_box_div_table_td">
						<%=StringUtil.deNull(directoryBean.getNew_xc_sfhj())%>&nbsp;
                    </td>
				</tr>

			</table>
			</div>
			<table class="cue_box_foot" style="display: none;">
				<tr>
					<td><input class="but_h_01" type="reset" id="resert"
						value="关闭" onclick="closed()" /></td>
				</tr>
			</table>
		</div>
	</form>
</body>
</html>