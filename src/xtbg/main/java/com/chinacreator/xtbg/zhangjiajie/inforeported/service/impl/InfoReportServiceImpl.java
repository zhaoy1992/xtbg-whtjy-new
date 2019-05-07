package com.chinacreator.xtbg.zhangjiajie.inforeported.service.impl;

import java.sql.Connection;
import java.util.List;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.zhangjiajie.inforeported.dao.InfoReportManagerDao;
import com.chinacreator.xtbg.zhangjiajie.inforeported.entity.GetInfoUserBean;
import com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoReportAuditIdeaBean;
import com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoReportBaseInfoBean;
import com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoSource;
import com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoType;
import com.chinacreator.xtbg.zhangjiajie.inforeported.service.InfoReportServiceIfc;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.DbconnManager;
import com.chinacreator.xtbg.pub.util.StringUtil;

public class InfoReportServiceImpl implements InfoReportServiceIfc {

	private static final Logger LOG = Logger.getLogger(InfoReportServiceImpl.class);
	/**@Override
	public void InfoAlternate(InfoReportBaseInfoBean infoReportBaseInfoBean,
			InfoReportAuditIdeaBean infoReportAuditIdeaBean) throws Exception {
		Connection con = DbconnManager.getInstance().getTransactionConnection();
		try {
			InfoReportManagerDao infoReportdao = (InfoReportManagerDao)DaoImplClassUtil.getDaoImplClass("infoReportManagerDaoImpl");
			infoReportBaseInfoBean.setIs_alternate("Y");
			String submittedinfoId = infoReportdao.saveInfoReport(infoReportBaseInfoBean, con);
			
			infoReportAuditIdeaBean.setAndit_source(InfoSource.INFORMATION_COLLECTION);
			infoReportAuditIdeaBean.setSubmittedinfo_id(submittedinfoId);
			infoReportAuditIdeaBean.setAndit_state(InfoType.HAS_BE_ALTERNATE);
			
			infoReportdao.saveAuditIdea(infoReportAuditIdeaBean, con);
			con.commit();
			
			con.commit();
		} catch (Exception e) {
			
			LOG.info(e.getMessage());
			DbconnManager.rollback(con);
			throw e;
		}finally {
			DbconnManager.closeConnection(con);
		}
		
	}**/

	@Override
	public void InfoAudit(InfoReportBaseInfoBean infoReportBaseInfoBean,
			InfoReportAuditIdeaBean infoReportAuditIdeaBean)  throws Exception{
		Connection con = DbconnManager.getInstance().getTransactionConnection();
		try {
			InfoReportManagerDao infoReportdao = (InfoReportManagerDao)DaoImplClassUtil.getDaoImplClass("infoReportManagerDaoImpl");
			infoReportBaseInfoBean.setSubmittedinfo_typecode(InfoType.HAS_BE_AUDIT);
			String submittedinfoId = infoReportdao.saveInfoReport(infoReportBaseInfoBean, con);
			
			infoReportAuditIdeaBean.setAndit_source(InfoSource.INFORMATION_COLLECTION);
			infoReportAuditIdeaBean.setSubmittedinfo_id(submittedinfoId);
			infoReportAuditIdeaBean.setAndit_state(InfoType.HAS_BE_AUDIT);
			
			infoReportdao.saveAuditIdea(infoReportAuditIdeaBean, con);
			con.commit();
		} catch (Exception e) {
			
			LOG.info(e.getMessage());
			DbconnManager.rollback(con);
			throw e;
		}finally {
			DbconnManager.closeConnection(con);
		}
		
	}

	@Override
	public void InfoPublished(InfoReportBaseInfoBean infoReportBaseInfoBean,
			InfoReportAuditIdeaBean infoReportAuditIdeaBean) throws Exception {
		Connection con = DbconnManager.getInstance().getTransactionConnection();
		try {
			InfoReportManagerDao infoReportdao = (InfoReportManagerDao)DaoImplClassUtil.getDaoImplClass("infoReportManagerDaoImpl");
			infoReportBaseInfoBean.setSubmittedinfo_typecode(InfoType.HAS_BE_PUBLISHED);
			String submittedinfoId = infoReportdao.saveInfoReport(infoReportBaseInfoBean, con);
			
			infoReportdao.saveInfoGetUser(submittedinfoId, infoReportBaseInfoBean.getPartunits(), InfoType.HAS_BE_PUBLISHED, con);
			infoReportAuditIdeaBean.setAndit_source(InfoSource.INFORMATION_COLLECTION);
			infoReportAuditIdeaBean.setSubmittedinfo_id(submittedinfoId);
			infoReportAuditIdeaBean.setAndit_state(InfoType.HAS_BE_PUBLISHED);
			
			if(!StringUtil.nullOrBlank(infoReportAuditIdeaBean.getAndit_opinion()))
				infoReportdao.saveAuditIdea(infoReportAuditIdeaBean, con);
			con.commit();
		} catch (Exception e) {
			LOG.info(e.getMessage());
			DbconnManager.rollback(con);
			throw e;
		}finally {
			DbconnManager.closeConnection(con);
		}
		
	}

	/**@Override
	public void InfoRejection(InfoReportBaseInfoBean infoReportBaseInfoBean,
			InfoReportAuditIdeaBean infoReportAuditIdeaBean) throws Exception {
		Connection con = DbconnManager.getInstance().getTransactionConnection();
		try {
			InfoReportManagerDao infoReportdao = (InfoReportManagerDao)DaoImplClassUtil.getDaoImplClass("infoReportManagerDaoImpl");
			infoReportBaseInfoBean.setSubmittedinfo_typecode(InfoType.HAS_BE_REJECTION);
			String submittedinfoId = infoReportdao.saveInfoReport(infoReportBaseInfoBean, con);
			
			infoReportAuditIdeaBean.setAndit_source(InfoSource.INFORMATION_COLLECTION);
			infoReportAuditIdeaBean.setSubmittedinfo_id(submittedinfoId);
			infoReportAuditIdeaBean.setAndit_state(InfoType.HAS_BE_REJECTION);
			
			infoReportdao.saveAuditIdea(infoReportAuditIdeaBean, con);
			con.commit();
		} catch (Exception e) {
			
			LOG.info(e.getMessage());
			DbconnManager.rollback(con);
			throw e;
		}finally {
			DbconnManager.closeConnection(con);
		}
		
	}**/

	@Override
	public void InfoReport(InfoReportBaseInfoBean infoReportBaseInfoBean) throws Exception {
		Connection con = DbconnManager.getInstance().getTransactionConnection();
		try {
			InfoReportManagerDao infoReportdao = (InfoReportManagerDao)DaoImplClassUtil.getDaoImplClass("infoReportManagerDaoImpl");
			infoReportBaseInfoBean.setSubmittedinfo_typecode(InfoType.HAS_BE_REPORTED);
			String submittedinfoId = infoReportdao.saveInfoReport(infoReportBaseInfoBean, con);
			
			infoReportdao.saveInfoGetUser(submittedinfoId, infoReportBaseInfoBean.getReportunits(), InfoType.HAS_BE_REPORTED, con);
			InfoReportAuditIdeaBean infoReportAuditIdeaBean = new InfoReportAuditIdeaBean();
			infoReportAuditIdeaBean.setAndit_person(infoReportBaseInfoBean.getInputuser_name());
			infoReportAuditIdeaBean.setAndit_person_id(infoReportBaseInfoBean.getInputuser_id());
			infoReportAuditIdeaBean.setAndit_source(InfoSource.INFORMATION_COLLECTION);
			infoReportAuditIdeaBean.setSubmittedinfo_id(submittedinfoId);
			infoReportAuditIdeaBean.setAndit_state(InfoType.HAS_BE_REPORTED);
			
			infoReportdao.saveAuditIdea(infoReportAuditIdeaBean, con);
			con.commit();
		} catch (Exception e) {
			
			LOG.info(e.getMessage());
			DbconnManager.rollback(con);
			throw e;
		}finally {
			DbconnManager.closeConnection(con);
		}
		
	}
	

	@Override
	public void InfoListReport(String submittedinfoIds,
			InfoReportBaseInfoBean infoReportBaseInfoBean) throws Exception {
		Connection con = DbconnManager.getInstance().getTransactionConnection();
		try {
			if(!StringUtil.nullOrBlank(submittedinfoIds)){
				String[] submittedinfoIdArry = submittedinfoIds.split(",");
				for(String submittedinfoId : submittedinfoIdArry){
					InfoReportManagerDao infoReportdao = (InfoReportManagerDao)DaoImplClassUtil.getDaoImplClass("infoReportManagerDaoImpl");
					List<GetInfoUserBean> list = infoReportdao.findgetInfoUserList(submittedinfoId, infoReportBaseInfoBean.getSubmittedinfo_typecode4getinfouser());
					if(list.size() > 0){
						infoReportdao.onlyReportInfo(submittedinfoId, infoReportBaseInfoBean.getSubmittedinfo_typecode4getinfouser(), con);
						
						
						
						infoReportdao.setInfoGetUser4List(submittedinfoId, infoReportBaseInfoBean.getSubmittedinfo_typecode4getinfouser(), con);//设置信息接收人
						InfoReportAuditIdeaBean infoReportAuditIdeaBean = new InfoReportAuditIdeaBean();
						infoReportAuditIdeaBean.setAndit_source(InfoSource.INFORMATION_COLLECTION);
						infoReportAuditIdeaBean.setSubmittedinfo_id(submittedinfoId);
						
						if(!StringUtil.nullOrBlank(infoReportBaseInfoBean.getSubmittedinfo_typecode2delete())){
							infoReportAuditIdeaBean.setAndit_person_id(infoReportBaseInfoBean.getInputuser_id());
							infoReportAuditIdeaBean.setAndit_state(infoReportBaseInfoBean.getSubmittedinfo_typecode2delete());
							infoReportdao.deleteAuditIdea(infoReportAuditIdeaBean, con);//先清空当前信息该状态的意见记录，避免冲突
						}
						
						
						for(GetInfoUserBean giuBean : list){
							infoReportAuditIdeaBean.setAndit_person(giuBean.getGetinfousername());
							infoReportAuditIdeaBean.setAndit_person_id(giuBean.getGetinfouserid());
							infoReportAuditIdeaBean.setAndit_state(infoReportBaseInfoBean.getSubmittedinfo_typecode4getinfouser());
							infoReportdao.saveAuditIdea(infoReportAuditIdeaBean, con);
						}
						
						infoReportAuditIdeaBean.setAndit_person(infoReportBaseInfoBean.getInputuser_name());
						infoReportAuditIdeaBean.setAndit_person_id(infoReportBaseInfoBean.getInputuser_id());
						infoReportAuditIdeaBean.setAndit_state(infoReportBaseInfoBean.getSubmittedinfo_typecode());
						infoReportdao.saveAuditIdea(infoReportAuditIdeaBean, con);
					}
				}
				
			}
			
			
			con.commit();
		} catch (Exception e) {
			
			LOG.info(e.getMessage());
			DbconnManager.rollback(con);
			throw e;
		}finally {
			DbconnManager.closeConnection(con);
		}
		
	}

	@Override
	public void InfoSubmitted(InfoReportBaseInfoBean infoReportBaseInfoBean,
			InfoReportAuditIdeaBean infoReportAuditIdeaBean) throws Exception {
		Connection con = DbconnManager.getInstance().getTransactionConnection();
		try {
			InfoReportManagerDao infoReportdao = (InfoReportManagerDao)DaoImplClassUtil.getDaoImplClass("infoReportManagerDaoImpl");
			infoReportBaseInfoBean.setSubmittedinfo_typecode(InfoType.HAS_BE_SUBMITTED);
			String submittedinfoId = infoReportdao.saveInfoReport(infoReportBaseInfoBean, con);
			
			//infoReportdao.saveInfoGetUser(submittedinfoId, infoReportBaseInfoBean.getSendauditusers(), InfoType.HAS_BE_SUBMITTED, con);
			infoReportAuditIdeaBean.setAndit_source(InfoSource.INFORMATION_COLLECTION);
			infoReportAuditIdeaBean.setSubmittedinfo_id(submittedinfoId);
			infoReportAuditIdeaBean.setAndit_state(InfoType.HAS_BE_SUBMITTED);
			
			infoReportdao.saveAuditIdea(infoReportAuditIdeaBean, con);
			con.commit();
		} catch (Exception e) {
			
			LOG.info(e.getMessage());
			DbconnManager.rollback(con);
			throw e;
		}finally {
			DbconnManager.closeConnection(con);
		}
		
	}

	@Override
	public void InfoTemporary(InfoReportBaseInfoBean infoReportBaseInfoBean) throws Exception {
		Connection con = DbconnManager.getInstance().getTransactionConnection();
		try {
			InfoReportManagerDao infoReportdao = (InfoReportManagerDao)DaoImplClassUtil.getDaoImplClass("infoReportManagerDaoImpl");
			infoReportBaseInfoBean.setSubmittedinfo_typecode(InfoType.HAS_BE_TEMPORARY);
			String submittedinfo_id =  infoReportdao.saveInfoReport(infoReportBaseInfoBean, con);
			if(!StringUtil.nullOrBlank(infoReportBaseInfoBean.getReportunits())){
				infoReportdao.saveInfoGetUser(submittedinfo_id, infoReportBaseInfoBean.getReportunits(), InfoType.REPORTED_TEMPORARY, con);
			}
		
			con.commit();
		} catch (Exception e) {
			
			LOG.info(e.getMessage());
			DbconnManager.rollback(con);
			throw e;
		}finally {
			DbconnManager.closeConnection(con);
		}
		
	}

	@Override
	public void InfoCommonSave(InfoReportBaseInfoBean infoReportBaseInfoBean,
			InfoReportAuditIdeaBean infoReportAuditIdeaBean) throws Exception {
		Connection con = DbconnManager.getInstance().getTransactionConnection();
		try {
			InfoReportManagerDao infoReportdao = (InfoReportManagerDao)DaoImplClassUtil.getDaoImplClass("infoReportManagerDaoImpl");
			String submittedinfoId = infoReportdao.saveInfoReport(infoReportBaseInfoBean, con);
			
			infoReportAuditIdeaBean.setAndit_source(InfoSource.INFORMATION_COLLECTION);//设置信息来源
			infoReportAuditIdeaBean.setSubmittedinfo_id(submittedinfoId);//设置信息ID
			if(!StringUtil.nullOrBlank(infoReportBaseInfoBean.getSubmittedinfo_typecode2delete())){
				infoReportAuditIdeaBean.setAndit_state(infoReportBaseInfoBean.getSubmittedinfo_typecode2delete());
				infoReportdao.deleteAuditIdea(infoReportAuditIdeaBean, con);//先清空当前信息该状态的意见记录，避免冲突
			}
			
			//如果意见信息bean不为空，则保存意见信息
			if(null != infoReportAuditIdeaBean && !StringUtil.nullOrBlank(infoReportBaseInfoBean.getSubmittedinfo_typecode())){
				String[] idArray = infoReportBaseInfoBean.getSubmittedinfo_typecode().split(",");
				for(int i = 0 ; i < idArray.length ; i++){
					infoReportAuditIdeaBean.setAndit_state(idArray[i]);
					infoReportdao.saveAuditIdea(infoReportAuditIdeaBean, con);
				}
				infoReportAuditIdeaBean.setAndit_opinion("");//后面的接收人都没有意见信息
			}
			
			//如果有信息上报接收人，则保存信息上报接收人
			if(!StringUtil.nullOrBlank(infoReportBaseInfoBean.getReportunits())){
				
				if((StringUtil.nullOrBlank(infoReportBaseInfoBean.getSubmittedinfo_typecode()) 
						&& StringUtil.nullOrBlank(infoReportBaseInfoBean.getSubmittedinfo_typecode4getinfouser())) 
						|| InfoType.HAS_BE_TEMPORARY.equals(infoReportBaseInfoBean.getSubmittedinfo_typecode())
						|| StringUtil.nullOrBlank(infoReportBaseInfoBean.getSubmittedinfo_typecode2delete())){
					//如果没有任何状态传入或者是暂存状态，则视为普通保存状态
					infoReportdao.saveInfoGetUser(submittedinfoId, infoReportBaseInfoBean.getReportunits(), InfoType.REPORTED_TEMPORARY, con);
				}else{
					infoReportdao.saveInfoGetUser(submittedinfoId, infoReportBaseInfoBean.getReportunits(), InfoType.NOT_BE_DEALWITH, con);
				}
				
				//如果意见信息bean不为空，则保存意见信息
				if(null != infoReportAuditIdeaBean 
						&& !StringUtil.nullOrBlank(infoReportBaseInfoBean.getSubmittedinfo_typecode4getinfouser())
						&& !InfoType.HAS_BE_TEMPORARY.equals(infoReportBaseInfoBean.getSubmittedinfo_typecode())
						&& !StringUtil.nullOrBlank(infoReportBaseInfoBean.getSubmittedinfo_typecode2delete())){
					String[] getinfouserArry = infoReportBaseInfoBean.getReportunits().split(",");
					String[] getinfousernameArry = infoReportBaseInfoBean.getReportunitsname().split(",");
					
					infoReportAuditIdeaBean.setAndit_state(infoReportBaseInfoBean.getSubmittedinfo_typecode4getinfouser());
					for(int i = 0 ; i < getinfouserArry.length ; i ++){
						infoReportAuditIdeaBean.setAndit_person_id(getinfouserArry[i]);
						infoReportAuditIdeaBean.setAndit_person(getinfousernameArry[i]);
						infoReportdao.saveAuditIdea(infoReportAuditIdeaBean, con);
					}
					
				}
			}
			//如果有信息送审接收人，则保存信息送审接收人
			if(!StringUtil.nullOrBlank(infoReportBaseInfoBean.getSendauditusers())){
				
				if(((StringUtil.nullOrBlank(infoReportBaseInfoBean.getSubmittedinfo_typecode())
						&& StringUtil.nullOrBlank(infoReportBaseInfoBean.getSubmittedinfo_typecode4getinfouser())) 
						|| InfoType.HAS_BE_TEMPORARY.equals(infoReportBaseInfoBean.getSubmittedinfo_typecode())
						|| StringUtil.nullOrBlank(infoReportBaseInfoBean.getSubmittedinfo_typecode2delete()))){
					//如果没有任何状态传入或者是暂存状态，则视为普通保存状态
					infoReportdao.saveInfoGetUser(submittedinfoId, infoReportBaseInfoBean.getSendauditusers(), InfoType.SENDAUDIT_TEMPORARY, con);
				}else{
					infoReportdao.saveInfoGetUser(submittedinfoId, infoReportBaseInfoBean.getSendauditusers(), InfoType.NOT_BE_DEALWITH_REAUDIT, con);
				}
				
				//如果意见信息bean不为空，则保存意见信息
				if(null != infoReportAuditIdeaBean 
						&& !StringUtil.nullOrBlank(infoReportBaseInfoBean.getSubmittedinfo_typecode4getinfouser())
						&& !InfoType.HAS_BE_TEMPORARY.equals(infoReportBaseInfoBean.getSubmittedinfo_typecode())
						&& !StringUtil.nullOrBlank(infoReportBaseInfoBean.getSubmittedinfo_typecode2delete())){
					String[] getinfouserArry = infoReportBaseInfoBean.getSendauditusers().split(",");
					String[] getinfousernameArry = infoReportBaseInfoBean.getSendauditusersname().split(",");
					infoReportAuditIdeaBean.setAndit_state(infoReportBaseInfoBean.getSubmittedinfo_typecode4getinfouser());
					for(int i = 0 ; i < getinfouserArry.length ; i ++){
						infoReportAuditIdeaBean.setAndit_person_id(getinfouserArry[i]);
						infoReportAuditIdeaBean.setAndit_person(getinfousernameArry[i]);
						infoReportdao.saveAuditIdea(infoReportAuditIdeaBean, con);
					}
				}
			}
			//如果有信息接收人，则保存信息发布接收人
			if(!StringUtil.nullOrBlank(infoReportBaseInfoBean.getPartunits())){
				
				if(((StringUtil.nullOrBlank(infoReportBaseInfoBean.getSubmittedinfo_typecode()) 
						&& StringUtil.nullOrBlank(infoReportBaseInfoBean.getSubmittedinfo_typecode4getinfouser())) 
						|| InfoType.HAS_BE_TEMPORARY.equals(infoReportBaseInfoBean.getSubmittedinfo_typecode())
						|| StringUtil.nullOrBlank(infoReportBaseInfoBean.getSubmittedinfo_typecode2delete()))){
					//如果没有任何状态传入或者是暂存状态，则视为普通保存状态
					infoReportdao.saveInfoGetUser(submittedinfoId, infoReportBaseInfoBean.getPartunits(), InfoType.PUBLISHED_TEMPORARY, con);
				}else{
					infoReportdao.saveInfoGetUser(submittedinfoId, infoReportBaseInfoBean.getPartunits(), InfoType.NOT_BE_VIEW, con);
				}
				
				//如果意见信息bean不为空，则保存意见信息
				if(null != infoReportAuditIdeaBean 
						&& !StringUtil.nullOrBlank(infoReportBaseInfoBean.getSubmittedinfo_typecode4getinfouser())
						&& !InfoType.HAS_BE_TEMPORARY.equals(infoReportBaseInfoBean.getSubmittedinfo_typecode())
						&& !StringUtil.nullOrBlank(infoReportBaseInfoBean.getSubmittedinfo_typecode2delete())){
					String[] getinfouserArry = infoReportBaseInfoBean.getPartunits().split(",");
					String[] getinfousernameArry = infoReportBaseInfoBean.getPartunitsname().split(",");
					infoReportAuditIdeaBean.setAndit_state(infoReportBaseInfoBean.getSubmittedinfo_typecode4getinfouser());
					for(int i = 0 ; i < getinfouserArry.length ; i ++){
						infoReportAuditIdeaBean.setAndit_person_id(getinfouserArry[i]);
						infoReportAuditIdeaBean.setAndit_person(getinfousernameArry[i]);
						infoReportdao.saveAuditIdea(infoReportAuditIdeaBean, con);
					}
				}
			}

			con.commit();
		} catch (Exception e) {
			
			LOG.info(e.getMessage());
			DbconnManager.rollback(con);
			System.out.println(e);
			throw e;
		}finally {
			DbconnManager.closeConnection(con);
		}
		
	}

	@Override
	public void InfoViewSave(InfoReportBaseInfoBean infoReportBaseInfoBean,
			InfoReportAuditIdeaBean infoReportAuditIdeaBean) throws Exception {
		Connection con = DbconnManager.getInstance().getTransactionConnection();
		try {
			InfoReportManagerDao infoReportdao = (InfoReportManagerDao)DaoImplClassUtil.getDaoImplClass("infoReportManagerDaoImpl");
			String submittedinfoId = infoReportdao.saveInfoReport(infoReportBaseInfoBean, con);
			infoReportAuditIdeaBean.setAndit_source(InfoSource.INFORMATION_COLLECTION);
			infoReportAuditIdeaBean.setSubmittedinfo_id(submittedinfoId);
			
			//如果意见信息bean不为空，则保存意见信息
			if(null != infoReportAuditIdeaBean && !StringUtil.nullOrBlank(infoReportBaseInfoBean.getSubmittedinfo_typecode())){
				infoReportAuditIdeaBean.setAndit_state(infoReportBaseInfoBean.getSubmittedinfo_typecode());
				infoReportdao.saveAuditIdea(infoReportAuditIdeaBean, con);
			}
			
			if(null != infoReportBaseInfoBean && !StringUtil.nullOrBlank(infoReportBaseInfoBean.getSubmittedinfo_typecode2delete())){
				infoReportAuditIdeaBean.setAndit_state(infoReportBaseInfoBean.getSubmittedinfo_typecode2delete());
				infoReportdao.deleteAuditIdeaByUser(infoReportAuditIdeaBean, con);//先清空当前信息该状态的意见记录，避免冲突
			}
			con.commit();
		} catch (Exception e) {
			
			LOG.info(e.getMessage());
			DbconnManager.rollback(con);
			throw e;
		}finally {
			DbconnManager.closeConnection(con);
		}
	}
	
	/**
	 * 删除信息上报草稿信息 退稿回来的信息也允许删除。
	 * @param submittedinfoIds
	 * @param infoReportBaseInfoBean
	 */
	public void DeleteDrafInfo(String submittedinfoIds,InfoReportBaseInfoBean infoReportBaseInfoBean) throws Exception{
		Connection con = DbconnManager.getInstance().getTransactionConnection();
		try {
			InfoReportManagerDao infoReportdao = (InfoReportManagerDao)DaoImplClassUtil.getDaoImplClass("infoReportManagerDaoImpl");
			infoReportdao.DeleteDrafInfo(submittedinfoIds, infoReportBaseInfoBean, con);
			con.commit();
		} catch (Exception e) {
			
			LOG.info(e.getMessage());
			DbconnManager.rollback(con);
			throw e;
		}finally {
			DbconnManager.closeConnection(con);
		}
	}

}
