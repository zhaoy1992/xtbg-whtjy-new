<%@page contentType="text/html;charset=GBK"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.workflow.shark.*"%>
<%@ page import="com.chinacreator.epp.processmanage.dbmanager.ProcessManage"%>
<%@ page import="com.chinacreator.epp.util.DBKEY"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%> 
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.jawe.JaWEConstants"%>
<%@ page import="com.chinacreator.commonworkflow.ComponentFactory"%>
<%		
	String return_msg = "success";//返回的操作状态
	AccessControl control = AccessControl.getInstance();
	System.out.println(control.getUserName()); 
	//日志管理接口
	LogManager logMgr = SecurityDatabase.getLogManager();
	//用户信息（用户真实名称：用户帐号[用户ID]）
	String userInfo = request.getParameter("userName")+":"+request.getParameter("userAccount")+"["+request.getParameter("userId")+"]";
	//操作的ip地址
	String remoteAddr = request.getRemoteAddr();
	//用户信息
	String operUser = userInfo;
	//日志类型
	String operModule = JaWEConstants.LOG_MODULE_NAME;
	//操作的ip地址
	String operSource = remoteAddr;

	
	String isNew = (String)request.getParameter("isNew");
	//System.out.println("开始保存。。。。。");
	String pkg_id = (String)request.getParameter("pkg_id");
	String pkg_name = (String)request.getParameter("pkg_name");
	//是否保存流程活动数据
	String isSaveActData = (request.getParameter("isSaveActData")!=null)?(String)request.getParameter("isSaveActData"):"0";
	//	add by minghua.guo 090616
	String remark = request.getParameter("remark");
	if(remark==null)remark = "";
	
	String oo_id ="";
	try{
		String file2="";
		String fn=request.getParameter("filename");
		fn = pkg_id;
	  ObjectInputStream in=null;
		in=new ObjectInputStream(request.getInputStream());
		file2=(String)in.readObject();		
		
		//System.out.println("--------------CreatorPlatform接收Applet传回的XPDL--------------");
		 String filePath = request.getRealPath("")+File.separator+"WEB-INF"+File.separator+"repository"+File.separator+"tmp"+File.separator+fn+".xpdl";
		 //System.out.println(filePath);
		 File file = new File(filePath);
		  if(file.exists()){				
				file.delete();
				file.createNewFile();									
			}else{
				file.getParentFile().mkdirs();
				file.createNewFile();						
			}
		 OutputStreamWriter osw = new OutputStreamWriter(new  FileOutputStream(file), "utf-8");    
			osw.write(file2);    
			osw.close();
			in.close();	  
					
		//System.out.println("开始删除文件。。。。");
		RandomAccessFile raf=new RandomAccessFile(file,"r");
         byte[] utf8Bytes=null;
         long noOfBytes=raf.length();
         if (noOfBytes>0) {
            utf8Bytes=new byte[(int)noOfBytes];
            raf.seek(0);
            raf.readFully(utf8Bytes);
         }
        //System.out.println(file.delete());
		//System.out.println("删除文件结束。。。。");
		//System.out.println("shark开始配置。。。。");
		SharkEngine se=SharkEngine.getInstance();
		se.loginWorkflowServer("admin", "enhydra");
		//System.out.println("shark登录。。。。");
		//System.out.println(isNew);
		
		//修改包	
		if((isNew+"").equals("false")) 
		{
			//String pid = (String)request.getParameter("pid");
			Map map = se.updatePackageWithBytes(fn,utf8Bytes);
			ProcessManage pm = new ProcessManage();
			//System.out.println(map);
			//根据返回的结果，判断是否要加并联流程标志
			pm.updateProcess(map);
			//System.out.println("流程修改结束。。。");
			pkg_name = (String)map.get("mgrName");
			//拷贝该流程的相关外围配置到当前版本中 add by luming.tang at 2009-7-6
			ComponentFactory.getProcessConfigManagerInstance().copyToProcCurrentVersion(pkg_name);
			//写入日志
		 	logMgr.log(request.getParameter("userAccount"), userInfo+"修改流程"+pkg_name, operModule, operSource);
		}
		else
		{
			//新增包
			//System.out.println("shark开始上载。。");		
			HashMap map = se.uploadPackage(fn,utf8Bytes,true);
			System.out.println(map);
			//插入tb_process表
		 	//System.out.println("开始插入流程。。。。");
		 	ProcessManage pm = new ProcessManage();
		 	//如果ec_id=0，则认为是并联流程
		 	String ec_id = (String)request.getParameter("ec_id");
		 	String p_type = "0";
		 	//如果是并联流程
		 	if((ec_id+"").equals("0"))
		 	{
		 		p_type = "1";
		 		ec_id = Thread.currentThread().getName().substring(DBKEY.PreAppThreadName.length());
		 	}
		 	//String creator = control.getUserName();
		 	//根据返回的结果，判断是否要加并联流程标志
		 	//String id = pm.addProcess(ec_id,(String)request.getParameter("userAccount"),(String)map.get("oid"),(String)map.get("mgrName"),(String)map.get("procDesc"),p_type,isSaveActData);
		 	//20090616 add remark by minghua.guo
		 	String id = pm.addProcess(ec_id,(String)request.getParameter("userAccount"),(String)map.get("oid"),(String)map.get("mgrName"),remark,p_type,isSaveActData);
		 	if(id==null)
		 	{
		 		return_msg = "error";
		 	}
			//写入日志
		 	logMgr.log(request.getParameter("userAccount"), userInfo+"新增流程"+(String)map.get("mgrName"), operModule, operSource);

		 	//System.out.println("插入流程结束。。。。");
		}
		
		//System.out.println(fn);
	 	se.logoutWorkflowServer();
		}
		catch(Exception e)   
		{
			return_msg = "error";
			System.out.println("11aff出错了！！！");
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
		out.clear();
		out.clearBuffer();
		//System.out.println(return_msg);
		out.print(return_msg);
		out.flush();
%>