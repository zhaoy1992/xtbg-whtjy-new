<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ taglib uri="/WEB-INF/archive-taglib.tld" prefix="oa"%>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>移民局发文</title>
<oa:init>
	<link rel="stylesheet" href="ccapp/oa/archive/css.css" type="text/css" />
	<style type="text/css">
.but_y_01 {
	float: none;
}

.but_y_02 {
	float: none;
}
</style>
</head>
<body >
	<form id="form1" name="form1" action="" method="post">

	<div id="tabs1" style="width:99%">
	<div id="titleids" style="display:none;">
		<ul>
			<li><a href="#tabs-1" onclick="changeIndex(1)">基本信息</a></li>
			<li><a href="#tabs-3" title="点击加载正文" onclick="changeIndex(3)">正文</a></li>
		</ul>
	</div>
	
	<div id="tabs-1">
		<table width="95%" border="0" cellspacing="1" cellpadding="0"
			style="margin-left: 15px; margin-right: 15px; display: inline;">
			<tr>
				<td><oa:flowcommonstart flowType="1" />
				</td>
			</tr>
			<tr>
				<td style="padding-bottom: 10px;">

					<table width="100%" border="0" align="center" cellpadding="0"
						cellspacing="1" class="f_main">

						<tr>
							<td colspan="3"><span
								style="font-size: 20px; color: #ff0000; padding-left: 53%; line-height: 30px;">
									湖南省水库移民开发管理局发文稿纸 </span></td>
						</tr>

						<tr height="80%">
							<td width="30%" rowspan="4" align="left">签发：

								<oa:view column="SIGN_SEND" table="YMJ_OA_DOCUMENT_SENDYMJ"
									style="border: 1;width:99%; height: 423px; overflow: auto;" />
							</td>
							<td class="hongse">
								<oa:view column="SIGN_SEND" table="YMJ_OA_DOCUMENT_SENDYMJ" 
									style="border: 1;width:99%;overflow: auto;" title="领导意见1："
									other="class='textarea_575'" /> 
							</td>
							<td width="35%">
							<oa:view column="SEND_OFFICE" title="办公室意见："
									table="YMJ_OA_DOCUMENT_SENDYMJ"
									style="border: 1;width:99%;overflow: auto;"
									other="class='textarea_575'" />
							</td>
						</tr>
						<tr>
							<td width="35%"><oa:view column="SEND_VERIFY" table="YMJ_OA_DOCUMENT_SENDYMJ" title="核稿："
									style="border: 1;width:99%;overflow: auto;"
									other="class='textarea_575'" />
							</td>
							<td width="35%">
								<oa:input type="text" column="send_responsible" title="主办处室： "
									table="YMJ_OA_DOCUMENT_SENDYMJ" value="<%=accesscontroler.getChargeOrgName() %>"
									style="border: 0px; height: 30px;" />
							</td>
						</tr>

						<tr>
							<td rowspan="2" class="hongse">会签： 
							 <oa:view column="send_countersign"
									table="YMJ_OA_DOCUMENT_SENDYMJ"
									style="border: 1;width:99%;overflow: auto;"
									other="class='textarea_556'" />
							</td>
							<td>主办处室负责人：
							 <oa:view column="send_sponsor" table="YMJ_OA_DOCUMENT_SENDYMJ"
									style="border: 1;width:99%;overflow: auto;"
									other="class='textarea_575'" />
							</td>
						</tr>
						<tr>
							<td class="hongse" height=70>拟稿人： 
							<oa:input type="text" column="DRAFT_USERNAME" table="YMJ_OA_DOCUMENT_SENDYMJ" value="<%=accesscontroler.getUserName() %>"  style="border: 0px; height: 30px;" />
							<oa:input type="hidden" column="DRAFT_USERID" table="YMJ_OA_DOCUMENT_SENDYMJ" value="<%=accesscontroler.getUserID() %>"	style="border: 0px; height: 30px;" />
							</td>
						</tr>

						<tr>

							<td colspan="3" class="f_td1">
								<table width="100%" border="0" align="center" cellpadding="0"
									cellspacing="1">
									<tr>	
										<td width="50%"
											style="padding-left: 1px; line-height: 30px; height: 30px;">
											<select style="padding-top: "></select>
											<oa:select title="发    文："
												column="SEND_TYPEWORD" table="YMJ_OA_DOCUMENT_SENDYMJ"
												optionsql="select sendtype_name,sendtype_name  from ta_oa_sendno order by sendtype_no asc"></oa:select>
											字 （ <oa:select column="send_year"
												table="YMJ_OA_DOCUMENT_SENDYMJ">
												<oa:option optionName="2012" optionValue="2012" />
												<oa:option optionName="2013" optionValue="2013" />
												<oa:option optionName="2014" optionValue="2014" />
												<oa:option optionName="2015" optionValue="2015" />
											</oa:select> ） 第 <oa:input type="text" column="send_wall" 
												table="YMJ_OA_DOCUMENT_SENDYMJ"
												style="width: 10%;line-height:18px; height:18px;"
												other="class='validate[custom[positiveinteger],maxSize[5]]'" />
											号</td>
										<td width="30%"><oa:select title="机密程度："
												column="SECRETLEVEL_NAME" table="YMJ_OA_DOCUMENT_SENDYMJ"
												style="width: 40%">
												<oa:option optionName="请选择" optionValue="" />
												<oa:option optionName="秘密" optionValue="秘密" />
												<oa:option optionName="机密" optionValue="机密" />
												<oa:option optionName="绝密" optionValue="绝密" />
											</oa:select>
										</td>
										<td width="30%">快慢等级： <oa:select
												column="urgencylevel_name" table="YMJ_OA_DOCUMENT_SENDYMJ"
												style="width: 40%">
												<oa:option optionName="请选择" optionValue="" />
												<oa:option optionName="一般" optionValue="一般" />
												<oa:option optionName="特提" optionValue="特提" />
												<oa:option optionName="特急" optionValue="特急" />
												<oa:option optionName="加急" optionValue="加急" />
												<oa:option optionName="平急" optionValue="平急" />
											</oa:select>
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td colspan="3" class="f_td1"
								style="padding-left: 15px; line-height: 30px; height: 30px;">
								  <oa:input title="标     题："
									type="text" column="send_title" table="YMJ_OA_DOCUMENT_SENDYMJ"
									style="width: 90%;border: 0px;line-height:30px; height:30px;"
									other="class= 'validate[maxSize[200]]'" />
							</td>
						</tr>

						<tr>
							<td colspan="3" class="f_td1"
								style="padding-left: 20px; line-height: 30px; height: 30px;">
								 <oa:input type="text" title="主    送："
									column="send_zs" table="YMJ_OA_DOCUMENT_SENDYMJ"
									style="width: 90%;border: 0px;line-height:30px; height:30px;"
									other="class ='validate[maxSize[50]]' style='123'" />
							</td>
						</tr>

						<tr>
							<td colspan="3" class="f_td1"
								style="padding-left: 20px; line-height: 30px; height: 30px;">
								<oa:input type="text" title="抄    送： "
									column="send_cs" table="YMJ_OA_DOCUMENT_SENDYMJ"
									style="width: 90%;border: 0px;line-height:30px; height:30px;"
									other="class='validate[maxSize[50]]'" />
							</td>
						</tr>

						<tr>
							<td colspan="3" class="f_td1"
								style="padding-left: 15px; line-height: 30px; height: 30px;">
								<oa:input type="text" column="send_word" title=" 主 题 词：  "
									table="YMJ_OA_DOCUMENT_SENDYMJ"
									style="width: 90%;border: 0px;line-height:30px; height:30px;"
									other="class='validate[maxSize[100]]'" />
							</td>
						</tr>
						<tr id=trattach>
							<td colspan="3" class="f_td1" style="padding-left: 20px; line-height: 30px; height: 30px;">
								附&nbsp;&nbsp;&nbsp;&nbsp;件： <oa:affixbut butName="请选择文件"
									column="RECEIVE_AFFIX" table="YMJ_OA_DOCUMENT_SENDYMJ" />
							</td>
						</tr>

						<tr>
							<td colspan="3" class="f_td1"
								style="padding-left: 20px; line-height: 30px;">附件列表：<oa:affixshow />

							</td>
						</tr>

						<tr>
							<td colspan="3" class="f_td1"
								style="padding-left: 10px; line-height: 30px;">
								<table width="100%" border="0" align="center" cellpadding="0"
									cellspacing="1">
									<tr>
										<td style="line-height: 30px; height: 30px;"> <oa:input title="打印份数："
												type="text" column="send_num"
												table="YMJ_OA_DOCUMENT_SENDYMJ"
												style="width: 80%; border: 0px;line-height:30px; height:30px; " />

										</td>
										<td style="line-height: 30px; height: 30px;">
											 <oa:input type="text" title="打    字："
												column="send_typewrite" table="YMJ_OA_DOCUMENT_SENDYMJ"
												style="width: 80%; border: 0px;line-height:30px; height:30px;"
												other="class='validate[maxSize[100]]'" />
										</td>
										<td style="line-height: 30px; height: 30px;">
											 <oa:input type="text" title="校    对："
												column="send_efficacy" table="YMJ_OA_DOCUMENT_SENDYMJ"
												style="width: 80%; border: 0px;line-height:30px; height:30px;"
												other="class='validate[maxSize[100]]'" />
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		</div>
		<div id="tabs-3">
			<oa:webtext column="RECEIVE_CONTENT" table="YMJ_OA_DOCUMENT_SENDYMJ"/>
		</div>
	</div>
	</form>
	<IFRAME name=frame1 width=100% height=0> </IFRAME> 
</body>
</oa:init>
</html>