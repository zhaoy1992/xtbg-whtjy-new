package com.chinacreator.xtbg.pub.oagwcs.service.util;

import org.apache.log4j.*;

/**
 * <p>Title: 科创应用支撑平台系统</p>
 * <p>Description: gwcs</p>
 * <p>Copyright: Copyright (c) 2006</p>
 * <p>Company: 长沙科创计算机系统集成有限公司</p>
 * @author minghua.guo
 * @version 2.1
 */

public class PropBuilder {
    private static final Logger log = Logger.getLogger(PropBuilder.class.getName());
    private static java.util.Properties prop = new java.util.Properties();
    public PropBuilder(){
    }

    public PropBuilder(String propfile){
        try{
            //prop.load(config.ConfigBundle.class.getResourceAsStream(propfile));            
        }
        catch(Exception e){
            log.error(e.getMessage());
        	e.printStackTrace();
        }
    }

    /**@此方法用来从属性文件中得到一个属性值,返回一个对应的属性值
     *@param filename属性文件的名称
     *@param propname属性字段的名称
     *@throw exception
     *@by bo.xu
    */
    public static String getProperty(String filename, String propname) throws Exception{
        String propvalue = "";
        try{
           // prop.load(config.ConfigBundle.class.getResourceAsStream(filename));
            propvalue = prop.getProperty(propname);
        }
        catch(Exception e){
            log.error(e.getMessage());
        	e.printStackTrace();
        }
        return propvalue;
    }

    public String getProperty(String propname){
        String propvalue = prop.getProperty(propname);
        return propvalue;
    }
}
