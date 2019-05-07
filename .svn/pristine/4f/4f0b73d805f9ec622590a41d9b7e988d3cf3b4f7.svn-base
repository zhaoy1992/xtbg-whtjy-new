package com.chinacreator.xtbg.pub.sms.service;

import com.chinacreator.business.common.tools.CacheCommonManage;
import com.chinacreator.xtbg.pub.sms.service.impl.CZSmsServiceImpl;
import com.chinacreator.xtbg.pub.sms.service.impl.CztSmsServiceImpl;
import com.chinacreator.xtbg.pub.sms.service.impl.HhSmsServiceImpl;
import com.chinacreator.xtbg.pub.sms.service.impl.JyksySmsServiceImpl;
import com.chinacreator.xtbg.pub.sms.service.impl.MchSmsServiceImpl;
import com.chinacreator.xtbg.pub.sms.service.impl.SWJSmsServiceImpl;
import com.chinacreator.xtbg.pub.sms.service.impl.SXSmsServiceImpl;
import com.chinacreator.xtbg.pub.sms.service.impl.WcSmsServiceImpl;
import com.chinacreator.xtbg.pub.sms.service.impl.YmjSmsServiceImpl;
import com.chinacreator.xtbg.pub.sms.service.impl.ZhangjiajieSmsServiceImpl;


public class SmsFactory {
	/**
	 * 
	*<b>Summary: 获取【当前系统】发文业务层实例</b></br>
	*<b>！此方法主要用于前端流程处理中调用！</b>
	* @param sendArea
	* @return
	 */
	public static SmsServiceIfc instanceSendGwIfc() {
		return getSendGwIfcByUserArea();
	}
	
	/**
	*<b>Summary: 根据当前系统的区域码获取相应的发文业务层实例</b>
	* @return
	 */
	private static SmsServiceIfc getSendGwIfcByUserArea(){
		String userArea=CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");
		if("410001".equals(userArea)){//教育考试院
			return new JyksySmsServiceImpl();
		}
		if("430800".equals(userArea)){//张家界
			return new ZhangjiajieSmsServiceImpl();
		}
		if("421000".equals(userArea)){//移民局
			return new YmjSmsServiceImpl();
		}
		if("421003".equals(userArea)){//贸促会
			return new MchSmsServiceImpl();
		}
		if("421004".equals(userArea)){//怀化
			return new HhSmsServiceImpl();
		}
		if("431003".equals(userArea)){//苏仙
			return new SXSmsServiceImpl();
		}
		if("421005".equals(userArea)){//望城
			return new WcSmsServiceImpl();
		}
		if("431000".equals(userArea)){//郴州
			return new CZSmsServiceImpl();
		}
		if("421006".equals(userArea)){//郴州
			return new CztSmsServiceImpl();
		}
		if("410004".equals(userArea)){//郴州
			return  new SWJSmsServiceImpl();
		}
		
		return null;
	}
}
