package com.chinacreator.xtbg.zhangjiajie.inforeported.service;

import com.chinacreator.xtbg.zhangjiajie.inforeported.entity.ReleaseunitBean;


/**
 *<p>Title:ReleaseunitServiceIfc.java</p>
 *<p>Description:发布栏目业务服务接口类</p> 
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2011-02-20
 */
public interface ReleaseunitServiceIfc {

	/**
	 * 保存发布栏目信息
	 * @param paramjosn
	 * @return
	 */
	public boolean saveReleaseunit(String paramjosn)  throws Exception;
	
	/**
	 * @Description: 修改发布栏目信息
	 * @throws Exception
	 */
	public boolean updateReleaseunit(String paramjosn)throws Exception;
	
	/**
	 * @Description:删除发布栏目信息
	 * @throws Exception
	 */
	public boolean delReleaseunit(String infotype_ids)throws Exception;
	
	/**
	 * @Description: 查询要修改的发布栏目信息
	 * @throws Exception
	 */
	public ReleaseunitBean getReleaseunitBeanById(String id) throws Exception;
}
