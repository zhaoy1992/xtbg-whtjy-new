package com.chinacreator.xtbg.zhangjiajie.inforeported.service;

import com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoTypeBean;


/**
 *<p>Title:InfoTypeServiceIfc.java</p>
 *<p>Description:信息类型业务服务接口类</p> 
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2011-02-20
 */
public interface InfoTypeServiceIfc {

	/**
	 * 保存信息类型
	 * @param paramjosn
	 * @return
	 */
	public boolean saveInfoType(String paramjosn)  throws Exception;
	
	/**
	 * @Description: 修改信息类型
	 * @throws Exception
	 */
	public boolean updateInfoType(String paramjosn)throws Exception;
	
	/**
	 * @Description:删除信息类型
	 * @throws Exception
	 */
	public boolean delInfoType(String infotype_ids)throws Exception;
	
	/**
	 * @Description: 查询要修改的信息类型
	 * @throws Exception
	 */
	public InfoTypeBean getInfoTypeBeanById(String id) throws Exception;
}
