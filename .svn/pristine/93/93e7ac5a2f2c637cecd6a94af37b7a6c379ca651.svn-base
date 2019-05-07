package com.chinacreator.xtbg.core.ajax.common.validation;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.ajax.common.bean.BusinessBean;
import com.chinacreator.xtbg.core.ajax.common.exception.BusinessException;
import com.chinacreator.xtbg.core.ajax.common.exception.DatabaseException;
import com.chinacreator.xtbg.core.ajax.common.exception.FileException;
import com.chinacreator.xtbg.core.ajax.common.exception.InterException;
import com.chinacreator.xtbg.core.ajax.common.exception.SystemException;

/**
 *<p>Title:BusinessAction.java</p>
 *<p>Description:请求处理的分发类</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南</p>
 *@author 夏天
 *@version 1.0
 *@date 2013-07-23
 */
public class ValidationProcess {
	private static final Logger logger = Logger.getLogger(ValidationProcess.class);
	private static ValidationProcess uniqueInstance = null;
    //单例实现
	private ValidationProcess() {
		logger.debug("init ValidationProcess .....");
	}

	public static ValidationProcess getInstance(){
		if (uniqueInstance == null) {
			uniqueInstance = new ValidationProcess();
		}
		return uniqueInstance;
	}
	
	public void valdation(BusinessBean bean)throws SystemException,BusinessException,FileException,InterException,DatabaseException{
		
	}
}
