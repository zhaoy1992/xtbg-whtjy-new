package com.chinacreator.business.common.tools;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.Writer;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Map;
import java.util.Properties;

import org.apache.log4j.Logger;

import com.chinacreator.business.common.bean.ActionBean;
import com.chinacreator.business.common.bean.ActionConfigBean;
import com.chinacreator.business.common.bean.AuthorityConfig;
import com.chinacreator.business.common.bean.FristBean;
import com.chinacreator.business.common.publuc.Dictionary;
import com.chinacreator.business.common.util.StringUtil;
import com.chinacreator.commonworkflow.WorkflowOpertionWrapper;
import com.chinacreator.xtbg.pub.util.StringSplitUtil;
import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.core.util.QuickWriter;
import com.thoughtworks.xstream.io.HierarchicalStreamWriter;
import com.thoughtworks.xstream.io.xml.DomDriver;
import com.thoughtworks.xstream.io.xml.PrettyPrintWriter;
import com.thoughtworks.xstream.io.xml.XppDriver;

/**
 * <p>
 * Title:ScheduleServlet.java
 * </p>
 * <p>
 * Description:读取系统配置文件
 * </p>
 * <p>
 * Company:湖南
 * </p>
 * @author 沈联成
 * @version 1.0 2012-11-20
 */
public class ReaderConfigFile {
	private static final Logger logger = Logger.getLogger(WorkflowOpertionWrapper.class);
	
	
	private static ReaderConfigFile uniqueInstance = null;
    //单例实现
	private ReaderConfigFile() {
		logger.debug("init ReaderConfigFile .....");
	}

	public static ReaderConfigFile getInstance() {
		if (uniqueInstance == null) {
			uniqueInstance = new ReaderConfigFile();
		}
		return uniqueInstance;
	}
	/**
	 * 得到文件路径
	 * @return
	 */
    public String getConfigPath(){ 	
    	return ReaderConfigFile.class.getResource("/").getPath();
    }
    
    /**
     * 
     * @param rootPaht 根路径
     * @param regex 文件目录下的正则匹配
     * @return 所有文件的根路径
     */
    public ArrayList<String> seekAllFilePath(String rootPaht,String regex,ArrayList<String> returnFilePath){
    	   File file = new File(rootPaht);
    	   returnFilePath = null == returnFilePath ?new ArrayList<String>():returnFilePath;
           if (!file.isDirectory()) {
        	      if(null == regex || !"".equals(regex)||StringUtil.stringFilter(file.getName(), regex)){
        	    	  returnFilePath.add(file.getPath());
        	      }
           } else if (file.isDirectory()) {
        	   
                   String[] filelist = file.list();
                   for (int i = 0; i < filelist.length; i++) {
                	        file  = new File(rootPaht + "/" + filelist[i]);
                           if (!file.isDirectory()) {
                        	  
                        	   if(null == regex || "".equals(regex)||StringUtil.stringFilter(file.getName(), regex)){
                     	    	  returnFilePath.add(file.getPath());
                     	      }
                           } else if (file.isDirectory()) {
                                 seekAllFilePath(rootPaht + "/" + filelist[i],regex,returnFilePath);
                           }
                   }

           }


    	return returnFilePath;
    }
    
    /**
     * 读取Properties文件
     * @param path
     * @param map
     */
    public void readerProperties(String path,Map<String,String> map){ 	
    	Properties p = new Properties();
    	try {
    		File pFile = new File(path);
    		FileInputStream pInStream=new FileInputStream(pFile );
    		System.out.println(pFile.getName().split(".properties")[0]+":;:fileNAME@@@@@@@@@@");
			p.load(pInStream);
		} catch (IOException e) {
			logger.error(e);
			return;
		}
    	Enumeration enu = p.propertyNames();
    	while( enu.hasMoreElements()){
    		String key = enu.nextElement().toString();
    		map.put(key,p.getProperty(key));
    	}
    }
    
    /**
     * <b>读取配置文件，并在key后面自动增加对应配置文件名后面的扩展名</b></br>
     * 重载这个读取配置文件的方法，key后面会自动补上该配置文件名后面的扩展名，</br>
     * <b>注意：</b>目前只是用于oacommon开头的文件</br>
     * 例如：配置文件oacommon_410001,则key也会自动增加_410001，即为key_410001
     * 读取Properties文件
     * @param path
     * @param map
     */
    public void readerPropertiesKeyAddExtraName(String path,Map<String,String> map){ 	
    	Properties p = new Properties();
    	String fileExtraName = "";
    	String filterFileName = "oacommon";//可以扩展，各个名称中间用,号隔开
    	String middle_char = Dictionary.SYSTEM_COMMON_CONFIG_MIDDLE_CHAR;//通用配置文件中间的隔开符
    	try {
    		File pFile = new File(path);
    		FileInputStream pInStream=new FileInputStream(pFile );
    		String fileNoExtraName = pFile.getName().split(".properties")[0];//排除掉文件的真实后缀名
    		if(fileNoExtraName.split(middle_char).length >= 2){//判断当前文件名中，是否含有 通用配置文件中间的隔开符
    			if(StringSplitUtil.isHave(filterFileName.split(","), fileNoExtraName.split(middle_char)[0])){//判断去掉隔开符后的文件名称是否在指定【通用配置文件名集合】中
        			fileExtraName = middle_char+fileNoExtraName.split(middle_char)[fileNoExtraName.split(middle_char).length - 1];//组装key所有带有的扩展名
        		}
    		}
    		
			p.load(pInStream);
		} catch (IOException e) {
			logger.error(e);
			return;
		}
    	Enumeration enu = p.propertyNames();
    	while( enu.hasMoreElements()){
    		String key = enu.nextElement().toString();
    		map.put(key+fileExtraName,p.getProperty(key));
    	}
    }
    
    public void readerActionConfig(String path,Map<String,Object> map) throws FileNotFoundException, InstantiationException, IllegalAccessException, ClassNotFoundException{
    	 XStream xstream = new XStream(new DomDriver());       
    	 xstream.alias("action", ActionBean.class);
		 xstream.alias("config-list", ActionConfigBean.class);
		 xstream.useAttributeFor( ActionBean.class, "classID");
	     ActionConfigBean list = (ActionConfigBean)xstream.fromXML(new FileInputStream(path));
		 
		 for(ActionBean bean : list.getActionList()){
			 map.put(bean.getClassID(), Class.forName(bean.getClassName()).newInstance());
			 map.put(bean.getClassID()+"RULE",bean.getOpenRule());
		 }
    }
    
    public FristBean readerFristConfig(String path) throws FileNotFoundException, InstantiationException, IllegalAccessException, ClassNotFoundException{
   	 XStream xstream = new XStream(new DomDriver());       
	 xstream.useAttributeFor(FristBean.PendingItem.class, "name");
	 xstream.useAttributeFor(FristBean.PendingItem.class, "id");
	 xstream.useAttributeFor(FristBean.PendingItem.class, "urlParam");
	 xstream.useAttributeFor(FristBean.PendingItem.class, "clickType");
	 xstream.alias("frist-config", FristBean.class);
	 xstream.alias("show-item", FristBean.ShowItem.class);
	 xstream.alias("pending-item", FristBean.PendingItem.class);
	 xstream.useAttributeFor(FristBean.ShowItem.class, "urlParam");
	 xstream.useAttributeFor(FristBean.ShowItem.class, "showType");
	 xstream.useAttributeFor(FristBean.ShowItem.class, "name");
	 xstream.useAttributeFor(FristBean.ShowItem.class, "viewType");
	 xstream.useAttributeFor(FristBean.ShowItem.class, "clickType");
	 xstream.useAttributeFor(FristBean.ShowItem.class, "id");
	 xstream.alias("dataClass", FristBean.PendingItem.DataClass.class);
	 xstream.alias("params", FristBean.PendingItem.DataClass.MethodParams.class);
	 xstream.useAttributeFor(FristBean.PendingItem.DataClass.MethodParams.class, "name");
	 xstream.useAttributeFor(FristBean.PendingItem.DataClass.MethodParams.class, "value");

	 
	 
	 FristBean bean = (FristBean) xstream.fromXML(new FileInputStream(path));
	 
	return bean;
   }
    protected static String PREFIX_CDATA = "http://qingwei201314.iteye.com/blog/<![CDATA[";
	protected static String SUFFIX_CDATA = "http://qingwei201314.iteye.com/blog/]]>";
	
	public Map<String, AuthorityConfig> readerAuthConfig(String path)
			throws FileNotFoundException, InstantiationException,
			IllegalAccessException, ClassNotFoundException {
		XStream xstream = new XStream(new DomDriver() {
			public HierarchicalStreamWriter createWriter(Writer out) {
				return new PrettyPrintWriter(out) {
					protected void writeText(QuickWriter writer, String text) {
						if (text.startsWith(PREFIX_CDATA)
								&& text.endsWith(SUFFIX_CDATA)) {
							writer.write(text);
						} else {
							super.writeText(writer, text);
						}
					}
				};
			};
		});
		xstream.alias("config-map", Map.class);
		xstream.alias("config", Map.Entry.class);
		xstream.alias("type", String.class);
		xstream.alias("auth", AuthorityConfig.class);
		Map<String, AuthorityConfig> m = (Map<String, AuthorityConfig>) xstream
				.fromXML(new FileInputStream(path));
		return m;

	}
    

}
