package com.chinacreator.business.common.validation;

import org.apache.log4j.Logger;

import com.chinacreator.business.common.bean.BusinessBean;
import com.chinacreator.business.common.exception.BusinessException;
import com.chinacreator.business.common.exception.DatabaseException;
import com.chinacreator.business.common.exception.FileException;
import com.chinacreator.business.common.exception.InterException;
import com.chinacreator.business.common.exception.SystemException;

/**
 *<p>Title:BusinessAction.java</p>
 *<p>Description:请求处理的分发类</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南</p>
 *@author 沈联成
 *@version 1.0
 *@date 2012-11-20
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
