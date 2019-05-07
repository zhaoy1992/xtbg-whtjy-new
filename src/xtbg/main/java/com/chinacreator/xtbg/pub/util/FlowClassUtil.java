package com.chinacreator.xtbg.pub.util;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import com.chinacreator.xtbg.pub.common.FlowClassBean;
import com.chinacreator.xtbg.pub.common.ReadFlowClass;

/**
 *<p>Title:FlowClassUtil.java</p>
 *<p>Description:流程实例bean工具类</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *@date 2012-2-2
 */
public class FlowClassUtil {

	protected static final Logger log = Logger.getLogger(FlowClassUtil.class.getName());
	
	private static FlowClassUtil instance = null;
	
	private FlowClassUtil(){
		
	}
	
	
	public static FlowClassUtil getInstance() {
		synchronized (instance) {
			if(instance == null) {
				instance = new FlowClassUtil();
			}
		}
		return instance;
	}
	
	/**
	 * @Description  获得flow类对象
	 * @param id
	 * @return  Object
	 * @exception IllegalAccessException, InstantiationException, ClassNotFoundException
	 */
	public static Object getFlowClass(String id) throws Exception {
		List<FlowClassBean> list = new ArrayList<FlowClassBean>();
		list = ReadFlowClass.getFlowList();
		String flowClassName = "";
		Object obj = null;
		for(int i = 0; i < list.size(); i++) {
			FlowClassBean flowClassBean = list.get(i);
			if(id.equals(flowClassBean.getId())) {
				flowClassName = flowClassBean.getClassName();
				obj = Class.forName(flowClassName).newInstance();
				break;
			}
		}
		if (StringUtil.isBlank(flowClassName)) {
			log.info("没有找到配置的流程实例类,请检查配置文件");
		}
		return obj;
	}
	
	/**
	 * @Description:产生新instance_code
	 * @param itemCode
	 * @return instance_code
	 * @throws Exception
	 */
	public static synchronized String getNewInstanceCode(String busitype_code)
			throws Exception {
		Date today = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddhhmmssSSS");
		String currentDate = sf.format(today);
		return currentDate + busitype_code;
	}
	
}
