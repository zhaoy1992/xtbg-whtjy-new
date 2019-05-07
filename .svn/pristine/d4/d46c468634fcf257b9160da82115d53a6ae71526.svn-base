<%@ page contentType="text/html;charset=GBK" language="java" import="java.util.*" %>
<%@page import="com.chinacreator.cms.documentmanager.*"%>
<%@page import="com.chinacreator.cms.channelmanager.*"%>
<%@page import="com.chinacreator.cms.sitemanager.*"%>
<%@page import="com.chinacreator.cms.container.Template"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.cms.documentmanager.bean.*"%>
<%@page import="com.chinacreator.util.RemoteFileHandle"%>
<%@page import="com.chinacreator.cms.customform.*"%>
<%@page import="com.chinacreator.cms.driver.htmlconverter.*"%>
<%@page import="com.chinacreator.cms.driver.i18n.*"%>
<%@page import="com.chinacreator.cms.docsourcemanager.*"%>
<%@ page import="com.chinacreator.cms.driver.publish.*"%>
<%@ page import="com.chinacreator.cms.driver.publish.impl.*"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%

	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);
	
	
	Document doc= new Document();

	LogManager logManager = null;
	String flagStr = request.getParameter("flagStr");
	
	
	
    //System.out.println(request.getParameter("publishfilename"));
    
	System.out.println(flagStr);
	HashMap map = new HashMap();
	String array[] = flagStr.split(",");
	
	for(int i=0;i<array.length;i++)
	{
		if(array[i].equals("1"))
		{
			//doc.setTitlecolor(request.getParameter("titlecolor"));
			map.put("titlecolor",request.getParameter("titlecolor"));
		}
		
		if(array[i].equals("2"))
		{
		      
		     String docsourceName=request.getParameter("inputdocsource");
		     
		     if(docsourceName != null)
		     {
		     	docsourceName = docsourceName.trim();
		     }
		     
		     DocsourceManagerImpl docsourcemanager=new DocsourceManagerImpl();
		     Docsource docsource=new Docsource();
		     
		     docsource = docsourcemanager.getDsrcListBy(docsourceName) ;
		     
		     if((docsource.getSRCNAME()==null)
		     		||(docsource.getSRCNAME().equals("")))
   			 { 
			       docsource.setSRCNAME(docsourceName);

			       boolean createflag=false;
			       createflag=docsourcemanager.creatorDsrc(docsource);
			       if(createflag)
			       {
		          	  map.put("docsource_name",docsourceName);
			       }
			       else
			       {
			           map.put("docsource_name",docsourcemanager.getDsrcList(1).getSRCNAME());
			       }
   			 }
    		else
    		{
					 map.put("docsource_name",docsourceName);
			}
		}
		
		//java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if(array[i].equals("3"))
		{
			String docwtime = request.getParameter("docwtime");
			//java.util.Date date = formatter.parse(docwtime);
			//doc.setDocwtime(date);
			map.put("docwtime",docwtime);
		}
		
		if(array[i].equals("4"))
		{
		    String ordertime = request.getParameter("ordertime");
			//java.util.Date orderDate = formatter.parse(ordertime);
		    //doc.setOrdertime(orderDate);
		    map.put("ordertime",ordertime);
		}
		if(array[i].equals("5"))
		{
		    if(request.getParameter("author")==null||("".equals(request.getParameter("author")))){
				//doc.setAuthor("不详");
				map.put("author","不详");
			}else{
				//doc.setAuthor(request.getParameter("author"));
				map.put("author",request.getParameter("author"));
			} 
		}
		if(array[i].equals("6"))
		{
		    if(request.getParameter("seq")!=null&&!(request.getParameter("seq").equals("")))
	    	{
		      //doc.setSeq(Integer.parseInt(request.getParameter("seq")));
		      map.put("seq",request.getParameter("seq"));
		    }
		    else
		    {
		      //doc.setSeq(999999);
		      map.put("seq","999999");
		    }
		}
	    if(array[i].equals("7"))
		{
		    if(request.getParameter("isnew") != null)
		    {
		    	//doc.setIsNew(1);
		    	map.put("isnew","1");
		    	if(request.getParameter("newpicpath") == null || "".equals(request.getParameter("newpicpath")))
		    		//doc.setNewPicPath("image/new.gif");//使用默认值
		    		map.put("newpicpath","image/new.gif");
		    	else
		    		//doc.setNewPicPath(request.getParameter("newpicpath"));
		    		map.put("newpicpath",request.getParameter("newpicpath"));
		    }
		    else
		    {
		    	//doc.setIsNew(0);
		    	map.put("isnew","0");
		    	//doc.setNewPicPath(request.getParameter("newpicpath"));
		    	map.put("newpicpath",request.getParameter("newpicpath"));
		    }
		}
	
		if(array[i].equals("8"))
		{
		    //doc.setKeywords(request.getParameter("keywords"));
		    map.put("keywords",request.getParameter("keywords"));
		}
	}
    //doc.setExtColumn(map);
	
	DocumentManager dmi = new DocumentManagerImpl();
	boolean flag = true;
	flag = dmi.updateDocs(map,request.getParameter("docidStr"));
	
	System.out.println("flag:"+flag);
	if(flag)
	{
	//logManager = SecurityDatabase.getLogManager();
	//logManager.log(accesscontroler.getUserAccount(),"批量修改文档.文档标题:【" + site.getName() + " 站点，" + channel.getDisplayName() + " 频道】" + doc.getSubtitle(),"文档管理",request.getRemoteAddr(),"");
	%>
	<script>
		alert("修改成功！");
		var str = parent.window.dialogArguments.location.href;
		var strArray = str.slice(0,str.indexOf("?"));
		parent.window.dialogArguments.location.href = strArray+"?"+parent.window.dialogArguments.document.all.queryString.value;
		//parent.closewin();
		parent.window.close();
	</script>
	<%
	}
	else
	{%>
		<script>
		alert("修改失败！");
	</script>
	<%}
	

%>