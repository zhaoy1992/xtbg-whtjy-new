
 /**
 * [Product]
  *     tjy_xtbg168
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     SetElcTime.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-9-2   Administrator    最初版本
   */
package com.chinacreator.xtbg.suxian.electroniccheck.dao.imploracle;
import com.chinacreator.task.Execute;
import java.io.Serializable;
import java.util.Map;

import org.apache.log4j.Logger;
/**
 *<p>Title:SetElcTime.java</p>
 *<p>Description:设置电子考勤中的矿工天数</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-9-2
 */
public class SetElcTime implements Execute, Serializable {
	private static final long serialVersionUID = 1L;

	private static final Logger LOG = Logger.getLogger(SetElcTime.class
			.getName());

	public void execute(Map arg0) {
		LOG.info("[规则引擎]定时处理开始");
		System.out.println("[规则引擎]定时处理开始");
		try {

			ElectDaoImpl electdaoimpl = new ElectDaoImpl();
			electdaoimpl.setEclService();

		} catch (Exception e) {
			e.getStackTrace();
			LOG.error(e.getMessage());
		}
		System.out.println("[规则引擎]定时处理结束");
		LOG.info("[规则引擎]定时处理结束");
	}
}
