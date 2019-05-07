<%@ page contentType="text/html; charset=gb2312"%>
<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="java.util.Date"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@ page import="java.util.Calendar,java.io.File"%>
<%
	request.setCharacterEncoding("gb2312");
	String attachment_id = request.getParameter("attachment_ids");
	String msg ="";
	try {
		SmartUpload su = new SmartUpload(); /// 上传文件组件 
		long file_max_size = 4000000;
		su.initialize(pageContext);// 上传初始化
		su.upload();
		// 将上传文件全部保存到指定目录
		String temp = "ccapp/xtbg/public/workflow/resources/images";
		//创建文件夹使用绝对路径
		String insertparth = temp;
		String uploadPath = request.getRealPath("/")+temp;
		//如果文件夹不存在，则创建此文件夹
		if (!new File(uploadPath).isDirectory()) {
			new File(uploadPath).mkdirs();
		}
		Files files = su.getFiles();
		//得到上传的文件
		com.jspsmart.upload.File file = su.getFiles().getFile(0);

		if (file.isMissing()) {
			System.out.println("missing");
		}
		String postfix = "." + file.getFileExt();
		//为上传的文件起别名
		System.out.println("后缀名是：" + postfix);
		//这个就是可以得到图片的路径了
		String strtemp = insertparth + "/" + attachment_id + postfix;
		//CarManageCarServiceIfc carManageCarServiceImpl = new CarManageCarServiceImpl();
		//CarManageCarDao carManageCarDao = (CarManageCarDao)DaoImplClassUtil.getDaoImplClass("carManageCarDaoImplymj");
		//msg = carManageCarDao.Insertimg(strtemp,attachment_id);
		System.out.println(strtemp);
		file.saveAs(strtemp); ///参数是路径 (完整)
%>
<!-- 引入其它 -->
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript">
//alert("上传成功");
</script>
<%
	} catch (Exception e) {
		System.out.println(e.getMessage());
		%>
		<script type="text/javascript">
			//alert("上传失败");
		</script>
	<%}
%>