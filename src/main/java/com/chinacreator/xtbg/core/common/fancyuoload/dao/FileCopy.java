package com.chinacreator.xtbg.core.common.fancyuoload.dao;

import java.util.Map;

public abstract class FileCopy {
		
	/**
	 * 复制附件信息到其他数据表
	 * @param params 相关的数据参数
	 * @return 
	 */
	public abstract boolean copyOtherToFileBean(Map<String,String> params);
}
