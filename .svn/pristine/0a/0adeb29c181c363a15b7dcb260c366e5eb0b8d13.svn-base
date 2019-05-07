<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/archive-taglib.tld" prefix="oa"%>
<%@ taglib uri="/WEB-INF/flowprocessing-taglib.tld" prefix="flowprocessing"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<oa:init>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>jsp 演示</title>
</head>
<body>

	<form name="form1" method="post" id="form1" action="">
	<table>
		<tr>
			<td>
				<flowprocessing:flowcommonstart flowType="1"/>
			</td>
		</tr>
		<tr>
			<td>
				<table border="1px" bordercolor="red">
					<tr>
						<td style="border: 1; width: 100px">姓名：</td>
						<td style="border: 1; width: 800px"><oa:input column="name"
								table="user" type="text" /></td>
					</tr>
					<tr>
						<td style="border: 1; width: 100px">时间：</td>
						<td style="border: 1; width: 800px">
						<oa:date column="date" table="user" dateFmt="yyyy-MM-dd" minDate="%y-%M-%d" onpicked="function(){user_date2.focus();}" />
						<oa:date column="date2" table="user" dateFmt="yyyy-MM-dd" minDate="%y-%M-%d" onpicked="function(){user_date.focus();}" />
						</td>
					</tr>
					<tr>
						<td>性别：</td>
						<td><oa:input column="sex" table="user" type="text" /></td>
					</tr>
		
					<tr>
						<td>发文：</td>
						<td><oa:select column="year" table="user"
								optionsql="select sendtype_name,sendtype_name  from ta_oa_sendno order by sendtype_no asc"
								initDefautValue="--请选择--" defautValue="太特殊" /></td>
					</tr>
		
		
					<tr>
						<td>性别：</td>
						<td><oa:select column="year" table="user"
								initDefautValue="--请选择--">
								<oa:option optionName="男" optionValue="M" />
								<oa:option optionName="女" optionValue="F" />
							</oa:select></td>
					</tr>
		
					<tr>
						<td>手机：</td>
						<td><oa:input column="phone" table="user" type="text"
								style="font-weight: bold;border-bottom-color: red;" /></td>
					</tr>
					<tr>
						<td>年龄：</td>
						<td><oa:input column="age" table="user" type="text"
								style="font-weight: bold;border-bottom-color: red;"
								other="align=\"top\" alt=\"\" border=\"\"  onclick=\"alert('点击事件！');\"" />
						</td>
					</tr>
					<tr>
						<td>工作：</td>
						<td><oa:textarea column="work" table="user" cols="100"
								rows="10" /></td>
					</tr>
					<tr id=trattach>
						<td colspan="2" height="30" class="mian_td"
							style="padding-left: 15px; line-height: 30px; height: 30px;">
							<span style="color: red">其他材料：</span> <oa:affixbut butName="请选择文件"
								column="uuid" table="user" /></td>
					</tr>
		
					<tr>
						<td colspan="2" height="30" class="mian_td"
							style="padding-left: 15px; line-height: 30px; height: 30px;">
							<span style="color: red">其他材料列表：</span>
						<oa:affixshow /></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	
		

	</form>
<IFRAME name=frame1 width=100% height=0> </IFRAME> 

</body>
</oa:init>
</html>