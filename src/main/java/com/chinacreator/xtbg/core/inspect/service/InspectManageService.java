package com.chinacreator.xtbg.core.inspect.service;

import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PageInfoBean;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.inspect.entity.InspectBaseInfoBean;
import com.chinacreator.xtbg.core.inspect.entity.InspectResponseBean;

/**
 * 
 *<p>Title:InspectManageService.java</p>
 *<p>Description:督察督办管理 service接口</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-10-29
 */
public interface InspectManageService {
	/**
	 * 
	 *<b>Summary: 根据条件查询督查督办任务信息</b>
	 * 
	 * @param bean
	 *            基本信息实例
	 * @param page
	 *            分页信息实例
	 * @return 分页数据
	 * @throws Exception
	 *             数据库操作异常
	 */
	public PagingBean findBaseInfoPageBean(Map<String, String> bean,
			PageInfoBean page);
	/**
	 * 
	*<b>Summary: “任务通知查看”查询任务数据。根据任务接收人来查看数据</b>
	* findBaseInfoPageBean4recept()
	* @param bean
	* @param page
	* @param conn
	* @return
	* @throws Exception
	 */
	public PagingBean findBaseInfoPageBean4recept(Map<String,String> bean,
			PageInfoBean page);
	/**
	 * 
	 *<b>Summary:根据id查询督察督办基本信息 </b> queryToInspectBaseInfoBean()
	 * 
	 * @param id
	 *            基本信息id
	 * @return 基本信息实例
	 */
	public InspectBaseInfoBean queryToInspectBaseInfoBean(String id);

	/**
	 * 
	 *<b>Summary:查询所有分类信息 </b> queryAllType()
	 * 
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, String>> queryAllType();

	/**
	 * 
	 *<b>Summary:保存督察督办数据 </b> saveBaseInfo()
	 * 
	 * @param bean
	 * @return
	 */
	public Boolean saveBaseInfo(InspectBaseInfoBean bean);

	/**
	 * 
	 *<b>Summary:更新操作 </b> updateBaseInfo()
	 * 
	 * @param bean
	 * @return
	 */
	public Boolean updateBaseInfo(InspectBaseInfoBean bean);
	/**
	 * 
	*<b>Summary:删除任务 </b>
	* @param ids 任务id列表
	* @return
	 */
    public Boolean deleteBaseInfo(String ids);
    /**
	 * 
	*<b>Summary:根据任务id，查询各个单位的反馈状况 </b>
	* queryRecept()
	* @param map  查询条件
	* @param conn 数据库连接
	* @return
	* @throws Exception
	*/
	public List<Map<String, String>> queryRecept(String infoId);
	/**
	 * 
	*<b>Summary: 任务办结</b>
	* overInspect()
	* @param bean
	* @return
	 */
	public boolean overInspect(InspectBaseInfoBean bean);
	/**
	 * 
	*<b>Summary:任务催办 </b>
	* hurryInspect()
	* @param bean
	* @param ids
	* @return
	 */
	public boolean hurryInspect(InspectBaseInfoBean bean,String ids);
	
	/**
	 * 
	*<b>Summary: 查询回复信息</b>
	* @param receptId 接收id
	* @param conn
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> queryListResponse(String receptId);
	
	/**
	 *
	 *<b>Summary:反馈 </b>
	 * @param bean
	 * @return
	 */
	public boolean responseInspect(InspectResponseBean bean);

	/**
	 * 
	*<b>Summary:查询发牌的数据列表 </b>
	* @return 发牌数据列表
	 * @throws Exception 
	 */
	public PagingBean queryCardList(Map<String,String> condition,PageInfoBean page);
}
