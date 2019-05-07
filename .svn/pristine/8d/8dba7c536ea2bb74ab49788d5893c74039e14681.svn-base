package com.chinacreator.business.common.test;

import com.chinacreator.business.common.tools.InitSystemManage;

public class InitTest {
	 public static void main(String[] args){
		 InitSystemManage.getInstance().initSystemProperties();
		 InitSystemManage.getInstance().initActonXml();
		//String path = CacheCommonManage.getInstance().getSystemParam(Dictionary.CONFIG_PATH);
		 //XStream xstream  = null;
		 try {                    
			 // xstream = new XStream(new DomDriver()); 
		 // 需要xpp3 jar      
		 } catch (Exception e) { 
			 //e.printStackTrace();    
		 }
		 
		/* ActionConfigBean con = new ActionConfigBean();
		 ActionBean bean = new ActionBean();
		 bean.setClassID("key1");
		 bean.setClassName("com.aa.cc.bb");
		 con.getActionList().add(bean);
		 bean = new ActionBean();
		 bean.setClassID("key2");
		 bean.setClassName("com.addfsa222a.cc.bb");
		 con.getActionList().add(bean);
		 xstream.alias("action", ActionBean.class);
		 xstream.alias("config-list", ActionConfigBean.class);
		 xstream.useAttributeFor( ActionBean.class, "classID");
		 System.out.println(xstream.toXML(con));

		 try {
			 PrintWriter writer = new PrintWriter(path+"/action_config_system.xml");
			// xstream.
			// ObjectOutputStream out = xstream.createObjectOutputStream(new FileOutputStream(path+"//action_config_system.xml"));
			// XMLEncoderFactory xmle=new XMLEncoder(out);//
			 xstream.toXML(con,writer);
			// writer.flush();
			 writer.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
		
	}
	 
	 //文件测试方法
	   /* public static void main(String[] args) {
	    	ReaderConfigFile f =new  ReaderConfigFile();
	    	String path = f.getConfigPath()+"systemConfig";
	    	ArrayList<String> list= f.seekAllFilePath(path,".+.properties");
	    	Map<String,String> map = new HashMap<String, String>();
	    	
	    	for(String s :list){
	    		f.readerProperties(s,map);
	    	}
		}*/
}
