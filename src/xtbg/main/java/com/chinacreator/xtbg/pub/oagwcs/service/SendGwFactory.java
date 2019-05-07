package com.chinacreator.xtbg.pub.oagwcs.service;

import com.chinacreator.business.common.tools.CacheCommonManage;
import com.chinacreator.business.common.tools.CacheCommonManageProxy;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.pub.oagwcs.dao.imploracle.HuaihuaSendGwDaoImpl;
import com.chinacreator.xtbg.pub.oagwcs.dao.imploracle.HuaihuaSignGwDaoImpl;
import com.chinacreator.xtbg.pub.oagwcs.dao.imploracle.JyksySendGwDaoImpl;
import com.chinacreator.xtbg.pub.oagwcs.dao.imploracle.YmjSendGwDaoImpl;
import com.chinacreator.xtbg.pub.oagwcs.service.impl.SendGwImpl;
import com.chinacreator.xtbg.pub.util.StringSplitUtil;

/**
 * 
 *<p>Title:SendGwFactory.java</p>
 *<p>Description:发送公文传输的工厂类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 夏天
 *@version 1.0
 *2013-4-24
 */
public class SendGwFactory {
	/**
	 * 
	*<b>Summary: 根据当前系统的【环节号】获取相应的【当前系统】发文业务层实例</b></br>
	*<b>！此方法主要用于后台流程处理中调用！</b>
	* @param sendArea
	* @return
	 */
	public static SendGwIfc instanceSendGwIfc(String action_defid) {
		//可以发送公文的环节数组，后台流程使用
		String canSendGw_actionDefidArray_backFlow = 
			CacheCommonManageProxy.getSystemParam("canSendGw_actionDefidArray_backFlow");
		//判断是否在配置好的环节集合中，只有在其中才能获取发文公文传输的具体实例进行发送
		if(!StringSplitUtil.isHave(canSendGw_actionDefidArray_backFlow.split(","), action_defid)){
			return null;
		}
		return getSendGwIfcByUserArea();
	}
	
	/**
	 * 
	*<b>Summary: 获取【当前系统】发文业务层实例</b></br>
	*<b>！此方法主要用于前端流程处理中调用！</b>
	* @param sendArea
	* @return
	 */
	public static SendGwIfc instanceSendGwIfc() {
		return getSendGwIfcByUserArea();
	}
	
	/**
	*<b>Summary: 根据当前系统的区域码获取相应的发文业务层实例</b>
	* @return
	 */
	private static SendGwIfc getSendGwIfcByUserArea(){
		String userArea=CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");
		if("421000".equals(userArea)){//移民局
			return new SendGwImpl(new YmjSendGwDaoImpl());
		}else if("421004".equals(userArea)){//怀化
			return new SendGwImpl(new HuaihuaSendGwDaoImpl());
		}else if("410001".equals(userArea)){//教育考试院
			return new SendGwImpl(new JyksySendGwDaoImpl());
		}
		return null;
	}
	
	/**
	 * 
	*<b>Summary: 根据当前系统的【环节号】获取相应的【当前系统】发文业务层实例</b></br>
	*<b>！此方法主要用于后台流程处理中调用！</b>
	* @param sendArea
	* @param 
	* @return
	 */
	public static SendGwIfc instanceSendGwIfc(String action_defid,String classname) {
		return getSendGwIfcByUserArea(classname);
	}
	/**
	*<b>Summary: 根据当前系统的区域码获取相应的发文业务层实例</b>
	* @return
	 */
	private static SendGwIfc getSendGwIfcByUserArea(String classname){
		String userArea=CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");
		if("421000".equals(userArea)){//移民局
			return new SendGwImpl(new YmjSendGwDaoImpl());
		}else if("421004".equals(userArea)){//怀化
			if(StringUtil.nullOrBlank(classname)){
				return new SendGwImpl(new HuaihuaSendGwDaoImpl());
			} else {
				//怀化呈批件
				return new SendGwImpl(new HuaihuaSignGwDaoImpl());
			}
		}else if("410001".equals(userArea)){//教育考试院
			return new SendGwImpl(new JyksySendGwDaoImpl());
		}
		return null;
	}
	
}
