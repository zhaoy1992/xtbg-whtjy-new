package com.chinacreator.xtbg.pub.util;

import com.chinacreator.xtbg.pub.core.entity.ParameterConstants;

/**
	 *<p>Title:</p>
	 *<p>Description:机构编码相关逻辑处理类</p>
	 *<p>Copyright:Copyright (c) 2011</p>
	 *<p>Company:湖南科创</p>
	 *@author yin.liu
	 *@version 1.0
	 *@date Jul 4, 2011
	 */
public class AreaCodeRuleUtil {
	
	private static AreaCodeRuleUtil areaCodeRuleUtil = null;
	
	private AreaCodeRuleUtil () {
		
	}
	/**
	 * 单例方法
	 * @return
	 */
	public static AreaCodeRuleUtil getInstance() {
		if (areaCodeRuleUtil == null) {
			synchronized(AreaCodeRuleUtil.class) {
				areaCodeRuleUtil = new AreaCodeRuleUtil();
			}
		}
		return areaCodeRuleUtil;
	}
	
	
	//method1 
	//TODO 通过机构代码，获取该机构在上级机构代码
	//返回 机构代码
	public String getParentOrgCode(String orgCode){
	 
		return null;
	}
	
	//次实现修改 系统管理
	//TODO 用户登录后，需要把  该机构的  机构代码，机构名称，存储到session
	
	//metdod 2
	//TODO 通过机构代码，获取该机构属于那一级，省 市 县 街道 单位  
	//返回  定义constants常量
	public String getOrgInArea(String orgCode){
		 int params=0;
		 String constants="";
		 if(null!=orgCode){
			 if(orgCode.length()>=12){
			   orgCode=orgCode.substring(0,12);	 
	           for (int i = 0; i < orgCode.length(); i++) {
				  if(!String.valueOf(orgCode.charAt(i)).equals("0")){
					  params=i+1;
				  }
			   }			 
			 }
			 if(params<=2){
				 constants=ParameterConstants.PROVINCE; 
			 }else if(params>2 && params<=4){
				 constants=ParameterConstants.CITY; 
			 }else if(params>4 && params<=6){
				 constants=ParameterConstants.AREA;
			 }else if(params>6 && params<=9){
				 constants=ParameterConstants.STREET;
			 }else if(params>9 && params<=12){
				 constants=ParameterConstants.VILLAGE;
			 }
		 }
		return constants;
	}
}

