package com.chinacreator.xtbg.zhangjiajie.inforeported.dao;

import java.sql.Connection;
import java.util.List;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.zhangjiajie.inforeported.entity.GetInfoUserBean;
import com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoReportAuditIdeaBean;
import com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoReportBaseInfoBean;
import com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoReportSearchBean;

public interface InfoReportManagerDao {
	
	
	/**
 	 * @Description 根据条件查询信息全部记录
	 * 分页显示
	 * @param infoReportSearchBean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 */
	public PagingBean findAllReportInfoList(InfoReportSearchBean infoReportSearchBean, String sortName, String sortOrder, long offset, int maxPagesize);
	
	/**
	 * @Description 根据条件查询信息浏览记录
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findOnlyReadList(InfoReportSearchBean infoReportSearchBean, String sortName, String sortOrder, long offset, int maxPagesize);
	
	/**
	 * @Description 根据条件查询我的草稿箱记录
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findMyDraftsList(InfoReportSearchBean infoReportSearchBean, String sortName, String sortOrder, long offset, int maxPagesize);
	
	/**
	 * @Description 根据条件查询已上报记录
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findHasBeenReportedList(InfoReportSearchBean infoReportSearchBean, String sortName, String sortOrder, long offset, int maxPagesize);
	
	/**
	 * @Description 根据条件查询被退稿记录
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findBeRejectionList(InfoReportSearchBean infoReportSearchBean, String sortName, String sortOrder, long offset, int maxPagesize);
	
	/**
	 * @Description 根据条件查询待处理记录
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findPendingList(InfoReportSearchBean infoReportSearchBean, String sortName, String sortOrder, long offset, int maxPagesize);
	
	/**
	 * @Description 根据条件查询已发布记录
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findPublishedList(InfoReportSearchBean infoReportSearchBean, String sortName, String sortOrder, long offset, int maxPagesize);
	
	/**
	 * @Description 根据条件查询推荐信息记录
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findRecommendedList(InfoReportSearchBean infoReportSearchBean, String sortName, String sortOrder, long offset, int maxPagesize);
	
	/**
	 * @Description 根据条件查询备用信息记录
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findAlternateList(InfoReportSearchBean infoReportSearchBean, String sortName, String sortOrder, long offset, int maxPagesize);
	
	/**
	 * 信息上报保存
	 * @param infoReportBaseInfoBean
	 */
	public String saveInfoReport(InfoReportBaseInfoBean infoReportBaseInfoBean,Connection con) throws Exception;
	/**
	 * 信息上报保存
	 * @param infoReportBaseInfoBean
	 */
	public String saveInfoReport(InfoReportBaseInfoBean infoReportBaseInfoBean) throws Exception;
	
	/**
	 * 操作意见通用保存
	 * @param infoReportAuditIdeaBean
	 */
	public void saveAuditIdea(InfoReportAuditIdeaBean infoReportAuditIdeaBean,Connection con) throws Exception;
	
	/**
	 * 操作意见通用保存
	 * @param infoReportAuditIdeaBean
	 */
	public void saveAuditIdea(InfoReportAuditIdeaBean infoReportAuditIdeaBean) throws Exception;
	
	/**
	 * 删除意见信息
	 * @param infoReportAuditIdeaBean
	 * @throws Exception
	 */
	public void deleteAuditIdea(InfoReportAuditIdeaBean infoReportAuditIdeaBean) throws Exception;
	
	/**
	 * 删除意见信息
	 * @param infoReportAuditIdeaBean
	 * @throws Exception
	 */
	public void deleteAuditIdea(InfoReportAuditIdeaBean infoReportAuditIdeaBean,Connection con) throws Exception;
	
	/**
	 * 删除意见信息指定到用户
	 * @param infoReportAuditIdeaBean
	 * @throws Exception
	 */
	public void deleteAuditIdeaByUser(InfoReportAuditIdeaBean infoReportAuditIdeaBean,Connection con) throws Exception;
	
	/**
	 * 设置信息是否为推荐
	 * @param submittedinfo_id
	 * @param isRecommend
	 * @param userid
	 * @param username
	 * @throws Exception
	 */
	public void saveInfoRecommend(String submittedinfo_id,String isRecommend,String userid,String username) throws Exception;
	
	
	/**
	 * 批量设置信息是否为推荐
	 * @param submittedinfo_id
	 * @param isRecommend
	 * @param userid
	 * @param username
	 * @throws Exception
	 */
	public void saveInfoRecommend4List(String submittedinfo_ids,String isRecommend,String userid,String username) throws Exception;
	
	/**
	 * 仅设置信息为上报
	 * @param submittedinfo_id
	 * @throws Exception
	 */
	public void onlyReportInfo(String submittedinfo_ids,String state,Connection con) throws Exception;
	
	/**
	 * 查找信息上报基本信息
	 * @param submittedinfo_id
	 * @return
	 * @throws Exception
	 */
	public InfoReportBaseInfoBean findInfoReportBaseInfo(String submittedinfo_id) throws Exception;
	
	
	/**
	 * 查找信息上报审核信息
	 * @param submittedinfo_id
	 * @param state
	 * @return
	 * @throws Exception
	 */
	public List<InfoReportAuditIdeaBean> findInfoReportAuditList(String submittedinfo_id,String state) throws Exception;
	
	/**
	 * 查找信息上报审核信息指定到用户
	 * @param submittedinfo_id
	 * @param state
	 * @return
	 * @throws Exception
	 */
	public List<InfoReportAuditIdeaBean> findInfoReportAuditListByUser(String submittedinfo_id,String state,String userid) throws Exception;
	
	
	/**
	 * 查找信息上报审核信息指定到用户
	 * @param submittedinfo_id
	 * @param state
	 * @return
	 * @throws Exception
	 */
	public List<InfoReportAuditIdeaBean> findInfoReportAuditListByUserNotinstate(String submittedinfo_id,String state,String userid) throws Exception;

	/**
	 * 设置信息相关接收人
	 * @param submittedinfo_id
	 * @param reportunits
	 * @throws Exception
	 */
	public void saveInfoGetUser(String submittedinfo_id,String getusers, String submittedinfo_typecode,Connection con) throws Exception;
	
	/**
	 * 查找信息接收人集合
	 * @param submittedinfo_id
	 * @param submittedinfo_typecode
	 * @return
	 * @throws Exception
	 */
	public List<GetInfoUserBean> findgetInfoUserList(String submittedinfo_id,String submittedinfo_typecode) throws Exception;
	
	/**
	 * 查找信息上报某条信息某个操作的最终执行人
	 * @param submittedinfo_id
	 * @param submittedinf_typecode
	 * @return
	 * @throws Exception
	 */
	public GetInfoUserBean findUser4InfoReport(String submittedinfo_id,String submittedinf_typecode) throws Exception;
	
	/**
	 * 设置信息相关接收人(批量处理)
	 * @param submittedinfo_id
	 * @param reportunits
	 * @throws Exception
	 */
	public void setInfoGetUser4List(String submittedinfo_id, String submittedinfo_typecode,Connection con) throws Exception;
	
	/**
	 * 删除信息上报草稿信息 退稿回来的信息也允许删除。
	 * @param submittedinfoIds
	 * @param infoReportBaseInfoBean
	 */
	public void DeleteDrafInfo(String submittedinfo_id, InfoReportBaseInfoBean infoReportBaseInfoBean,Connection con) throws Exception;
}
