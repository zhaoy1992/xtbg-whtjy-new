package com.chinacreator.xtbg.zhangjiajie.inforeported.service;

import com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoReportAuditIdeaBean;
import com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoReportBaseInfoBean;

public interface InfoReportServiceIfc {
	
	
	/**
	 * 暂存
	 */
	public void InfoTemporary(InfoReportBaseInfoBean infoReportBaseInfoBean) throws Exception;
	
	/**
	 * 上报
	 */
	public void InfoReport(InfoReportBaseInfoBean infoReportBaseInfoBean) throws Exception;
	
	/**
	 * 批量上报
	 */
	public void InfoListReport(String submittedinfoIds,InfoReportBaseInfoBean infoReportBaseInfoBean) throws Exception;
	
	/**
	 * 送审
	 */
	public void InfoSubmitted(InfoReportBaseInfoBean infoReportBaseInfoBean,InfoReportAuditIdeaBean infoReportAuditIdeaBean) throws Exception;
	
	/**
	 * 退稿
	 
	public void InfoRejection(InfoReportBaseInfoBean infoReportBaseInfoBean,InfoReportAuditIdeaBean infoReportAuditIdeaBean) throws Exception;
	*/
	/**
	 * 发布
	 */
	public void InfoPublished(InfoReportBaseInfoBean infoReportBaseInfoBean,InfoReportAuditIdeaBean infoReportAuditIdeaBean) throws Exception;
	
	/**
	 * 备用
	
	public void InfoAlternate(InfoReportBaseInfoBean infoReportBaseInfoBean,InfoReportAuditIdeaBean infoReportAuditIdeaBean) throws Exception;
	 */
	/**
	 * 审核
	 */
	public void InfoAudit(InfoReportBaseInfoBean infoReportBaseInfoBean,InfoReportAuditIdeaBean infoReportAuditIdeaBean) throws Exception;
	
	/**
	 * 信息通用保存方法
	 * @param infoReportBaseInfoBean
	 * @param infoReportAuditIdeaBean
	 * @throws Exception
	 */
	public void InfoCommonSave(InfoReportBaseInfoBean infoReportBaseInfoBean,InfoReportAuditIdeaBean infoReportAuditIdeaBean) throws Exception;
	
	/**
	 * 信息查看保存方法  例如 未查看->已查看
	 * @param infoReportBaseInfoBean
	 * @param infoReportAuditIdeaBean
	 * @throws Excetption
	 */
	public void InfoViewSave(InfoReportBaseInfoBean infoReportBaseInfoBean,InfoReportAuditIdeaBean infoReportAuditIdeaBean) throws Exception;

	/**
	 * 删除信息上报草稿信息 退稿回来的信息也允许删除。
	 * @param submittedinfoIds
	 * @param infoReportBaseInfoBean
	 */
	public void DeleteDrafInfo(String submittedinfoIds,InfoReportBaseInfoBean infoReportBaseInfoBean) throws Exception;
}
