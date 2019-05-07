package com.chinacreator.xtbg.core.file.service.impl;

import java.sql.Connection;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.note.entity.NoteBufferBean;
import com.chinacreator.xtbg.core.common.note.entity.NoteDetailBean;
import com.chinacreator.xtbg.core.common.note.services.impl.NoteServiceImpl;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.MessageUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.file.dao.FileFilesDevolveDao;
import com.chinacreator.xtbg.core.file.dao.FileLendingDetailDao;
import com.chinacreator.xtbg.core.file.entity.FileFilesDevolveDetailBean;
import com.chinacreator.xtbg.core.file.entity.FileLendingDetailBean;
import com.chinacreator.xtbg.core.file.entity.FilelendingBean;
import com.chinacreator.xtbg.core.file.service.FileLendingServiceIfc;
/**
 * 
 *<p>Title:FileFavoritesServiceImpl.java</p>
 *<p>Description:借阅管理</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Jul 24, 2013
 */
public class FileLendingServiceImpl implements FileLendingServiceIfc {
	
	private static final Log LOG = LogFactory.getLog(FileLendingServiceImpl.class);
	SimpleDateFormat matter1=new SimpleDateFormat("yyyy-MM-dd");
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 delete
	 * @param beanId
	 * @return 
	 * @see com.chinacreator.xtbg.core.file.service.FileFavoritesServiceIfc#delete(java.lang.String[])
	 */
	@Override
	public boolean delete(String[] beanId) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FileLendingDetailDao dao = (FileLendingDetailDao)LoadSpringContext.getApplicationContext().getBean("FileLendingDetailDaoImpl");
			for(String id : beanId){
				((BaseDao)dao).deleteListById(new FileLendingDetailBean(), conn, id);
			}
			conn.commit();
			flag = true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 addFileLendingDetailAfterQueryFileFiles
	 * @param FileDocBeanIds
	 * @param userId
	 * @return 
	 * @see com.chinacreator.xtbg.core.file.service.FileLendingServiceIfc#addFileLendingDetailAfterQueryFileFiles(java.lang.String[], java.lang.String)
	 */
	@Override
	public boolean addFileLendingDetailAfterQueryFileFiles(
			String[] fileDocBeanIds, String userId) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FileLendingDetailDao dao = (FileLendingDetailDao)LoadSpringContext.getApplicationContext().getBean("FileLendingDetailDaoImpl");
			Set<String> set = dao.getDocIdByUserId(userId,conn,true);
			for (String fileDocBeanId : fileDocBeanIds) {
				if(!set.contains(fileDocBeanId)){
					FileLendingDetailBean bean = new FileLendingDetailBean();
					bean.setF_detail_id(StringUtil.getUUID());
					bean.setF_islending(FileLendingDetailBean.F_ISLENDING_NO);//是否已借阅
					bean.setF_lending_userid(userId);
					bean.setF_doc_id(fileDocBeanId);
					((BaseDao)dao).insert(bean, conn);
				}
			}
			conn.commit();
			flag = true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 getFileLendingDetailForJYSQ
	 * @param beanIds
	 * @return 
	 * @see com.chinacreator.xtbg.core.file.service.FileLendingServiceIfc#getFileLendingDetailForJYSQ(java.lang.String[])
	 */
	@Override
	public List<Map<String, String>> getFileLendingDetailForJYSQ(
			String[] beanIds) {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			FileLendingDetailDao dao = (FileLendingDetailDao)LoadSpringContext.getApplicationContext().getBean("FileLendingDetailDaoImpl");
			return dao.getFileLendingDetailForJYSQ(beanIds, conn);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return null;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getFileFondsnoBean
	  * @param f_fonds_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.file.service.FileLendingServiceIfc#getFileFondsnoBean(java.lang.String)
	 */
	@Override
	public Map<String, String> getFileLendingDetailBean(String beanId) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			FileLendingDetailDao dao = (FileLendingDetailDao)LoadSpringContext.getApplicationContext().getBean("FileLendingDetailDaoImpl");
			viewMap = dao.getFileLendingDetailBean(beanId, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
			
		}
		return viewMap;
	}
	@Override
	public boolean addFileFondsno(FilelendingBean lendingbean) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FileLendingDetailDao fleLendingDetailDao = (FileLendingDetailDao)LoadSpringContext.getApplicationContext().getBean("FileLendingDetailDaoImpl");
			lendingbean.setF_creator_time(StringUtil.convertStringToTimestamp(StringUtil
					.deNull(lendingbean.getF_creator_time()), "yyyy-MM-dd HH24:mi:ss"));
			((BaseDao)fleLendingDetailDao).insert(lendingbean, conn);
			conn.commit();
			flag = true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
			
		}
		return flag;
	}
	@Override
	public boolean updatedetalbean(FileLendingDetailBean detailbean) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FileLendingDetailDao fleLendingDetailDao = (FileLendingDetailDao)LoadSpringContext.getApplicationContext().getBean("FileLendingDetailDaoImpl");
			detailbean.setF_lending_time(StringUtil.convertStringToTimestamp(StringUtil
					.deNull(detailbean.getF_lending_time()), "yyyy-MM-dd HH24:mi:ss"));
			((BaseDao)fleLendingDetailDao).update(detailbean, conn);
			conn.commit();
			flag = true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
			
		}
		return flag;
	}
	@Override
	public boolean givebackDetail(FileLendingDetailBean detailbean) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FileLendingDetailDao fleLendingDetailDao = (FileLendingDetailDao)LoadSpringContext.getApplicationContext().getBean("FileLendingDetailDaoImpl");
			detailbean.setF_back_time(StringUtil.convertStringToTimestamp(StringUtil
					.deNull(detailbean.getF_back_time()), "yyyy-MM-dd HH24:mi:ss"));
			((BaseDao)fleLendingDetailDao).update(detailbean, conn);
			conn.commit();
			flag = true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
			
		}
		return flag;
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 getFileLendingDetailByKey
	 * @param key
	 * @return 
	 * @see com.chinacreator.xtbg.core.file.service.FileLendingServiceIfc#getFileLendingDetailByKey(java.lang.String)
	 */
	@Override
	public List<Map<String,String>> getFileLendingDetailByKey(String key) {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			FileLendingDetailDao dao = (FileLendingDetailDao)LoadSpringContext.getApplicationContext().getBean("FileLendingDetailDaoImpl");
			return dao.getFileLendingDetailById(key, conn);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return null;
	}
	@Override
	public String saveFileFondsno(FilelendingBean bean,
			List<FileLendingDetailBean> list) {
		Connection conn = null;
		String flag = "";
		try {
			//1:判断如果list为空则借阅无意义
			if(list==null||list.size()==0){
				flag="借阅登记中找不到任何详情";
				return flag;
			}
			//2:检查是是否所有接触能否满足库存规则
			conn = DbManager.getInstance().getTransactionConnection();
			FileLendingDetailDao fleLendingDetailDao = (FileLendingDetailDao)LoadSpringContext.getApplicationContext().getBean("FileLendingDetailDaoImpl");
			Map<String,String> map = fleLendingDetailDao.checkKC(list, conn);//countt names
			if(map!=null){
				if(!"0".equals(map.get("countt"))){
					DbManager.rollBackNoThrow(conn);
					if(map.get("countt")!=null&&map.get("names")!=null){
						flag="库存不够(文件数量"+map.get("countt")+",文件名:'"+map.get("names")+"')";
						if(flag.length()>23){
							flag=flag.substring(0, 23)+"...";
						}
					}else{
						flag="库存不够";
					}
					return flag;
				}
			}
			
			//3：
			for (FileLendingDetailBean detailBean : list) {
				detailBean.setF_detail_id(StringUtil.getUUID());
				detailBean.setF_reback_time(new Timestamp(new Date().getTime()+Integer.parseInt(detailBean.getF_lending_day())* 24 * 60 * 60 * 1000));
				detailBean.setF_lending_time(new Timestamp(new Date().getTime()));
				((BaseDao)fleLendingDetailDao).insert(detailBean, conn);
			}
			//4:
			bean.setF_creator_time(StringUtil.convertStringToTimestamp(StringUtil
					.deNull(bean.getF_creator_time()), "yyyy-MM-dd HH24:mi:ss"));
			((BaseDao)fleLendingDetailDao).insert(bean, conn);
			//5kc-1
			fleLendingDetailDao.updateKC(list, conn,"-1");
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
			
		}
		return flag;
	}
	/**
	 * 归还
	 * <b>Summary: </b>
	 *     复写方法 givebackDetail
	 * @param list
	 * @return 
	 * @see com.chinacreator.xtbg.core.file.service.FileLendingServiceIfc#givebackDetail(java.util.List)
	 */
	@Override
	public boolean givebackDetail(List<FileLendingDetailBean> list) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FileLendingDetailDao fleLendingDetailDao = (FileLendingDetailDao)LoadSpringContext.getApplicationContext().getBean("FileLendingDetailDaoImpl");
			//1:归还
			for (FileLendingDetailBean detailbean : list) {
				detailbean.setF_back_time(StringUtil.convertStringToTimestamp(StringUtil
						.deNull(detailbean.getF_back_time()), "yyyy-MM-dd HH24:mi:ss"));
				((BaseDao)fleLendingDetailDao).update(detailbean, conn);
			}
			//2:修改库存
			fleLendingDetailDao.updateKC(list, conn, "+1");
			conn.commit();
			flag = true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
			
		}
		return flag;
	}
	/**
	 * 借出(待借出--借出中(审核通过))
	 * <b>Summary: </b>
	 *     复写方法 borrowOut
	 * @param idList
	 * @return 
	 * @see com.chinacreator.xtbg.core.file.service.FileLendingServiceIfc#borrowOut(java.lang.String)
	 */
	@Override
	public String borrowOut(String idList,String docList,String userId,String userName,String dateList){
		Connection conn = null;
		String flagStr = "操作失败";
		try {
			//1:数据整理
			List<FileLendingDetailBean> list = new ArrayList<FileLendingDetailBean>();
			String[] docidArr = docList.split(",");
			String[] idArr = idList.split(",");
			String[] dateArr = dateList.split(",");
			if(idArr.length==docidArr.length&&idArr.length==dateArr.length&&docidArr.length>0){
				int i = 0;
				for (String id : docidArr) {
					FileLendingDetailBean bean = new FileLendingDetailBean();
					bean.setF_doc_id(id);
					bean.setF_lending_day(dateArr[i]);
					bean.setF_detail_id(idArr[i++]);
					bean.setF_lending_type("2");//检查需要借出的文件都是 实体 或者 实体加电子
					list.add(bean);
				}
			}else{
				flagStr = "参数错误";
			}
			
			//2:检查是是否所有接触能否满足库存规则
			conn = DbManager.getInstance().getTransactionConnection();
			FileLendingDetailDao fleLendingDetailDao = (FileLendingDetailDao)LoadSpringContext.getApplicationContext().getBean("FileLendingDetailDaoImpl");
			Map<String,String> map = fleLendingDetailDao.checkKC(list, conn);//countt names
			if(map!=null){
				if(!"0".equals(map.get("countt"))){
					DbManager.rollBackNoThrow(conn);
					if(map.get("countt")!=null&&map.get("names")!=null){
						flagStr="库存不够(文件数量"+map.get("countt")+",文件名:'"+map.get("names")+"')";
						if(flagStr.length()>23){
							flagStr=flagStr.substring(0, 23)+"...";
						}
					}else{
						flagStr="库存不够";
					}
					return flagStr;
				}
			}
			//3:减少库存
			fleLendingDetailDao.updateKC(list, conn,"-1");
			//4：借出
			for (FileLendingDetailBean detailBean : list) {
				detailBean.setF_lending_type(null);
				detailBean.setF_islending("1");
				detailBean.setF_user_id(userId);
				detailBean.setF_user_name(userName);
				detailBean.setF_reback_time(new Timestamp(new Date().getTime()+Integer.parseInt(detailBean.getF_lending_day())* 24 * 60 * 60 * 1000));
				detailBean.setF_lending_time(new Timestamp(new Date().getTime()));
				((BaseDao)fleLendingDetailDao).update(detailBean, conn);
			}
			conn.commit();
			flagStr = "";
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flagStr;
	}
	/**
	 * 带借出--馆内阅读
	 * <b>Summary: </b>
	 *     复写方法 borrowOutAndBack
	 * @param idList
	 * @return 
	 * @see com.chinacreator.xtbg.core.file.service.FileLendingServiceIfc#borrowOutAndBack(java.lang.String)
	 */
	@Override
	public String borrowOutAndBack(String idList,String docList,String userId,String userName) {
		Connection conn = null;
		String flagStr = "操作失败";
		try {
			//1:数据整理
			List<FileLendingDetailBean> list = new ArrayList<FileLendingDetailBean>();
			String[] docidArr = docList.split(",");
			String[] idArr = idList.split(",");
			if(idArr.length==docidArr.length&&docidArr.length>0){
				int i = 0;
				for (String id : docidArr) {
					FileLendingDetailBean bean = new FileLendingDetailBean();
					bean.setF_doc_id(id);
					bean.setF_detail_id(idArr[i++]);
					bean.setF_lending_type("2");//检查需要借出的文件都是 实体 或者 实体加电子
					list.add(bean);
				}
			}else{
				flagStr = "参数错误";
			}
			conn = DbManager.getInstance().getTransactionConnection();
			//4：借出 + 归还
			FileLendingDetailDao fleLendingDetailDao = (FileLendingDetailDao)LoadSpringContext.getApplicationContext().getBean("FileLendingDetailDaoImpl");
			for (FileLendingDetailBean detailBean : list) {
				detailBean.setF_lending_type(null);
				detailBean.setF_islending("1");
				detailBean.setF_isback("1");
				detailBean.setF_lending_time(new Timestamp(new Date().getTime()));
				detailBean.setF_back_time(new Timestamp(new Date().getTime()));
				detailBean.setF_user_id(userId);
				detailBean.setF_user_name(userName);
				detailBean.setF_back_userid(userId);
				detailBean.setF_back_username(userName);
				detailBean.setF_reback_time(new Timestamp(new Date().getTime()));
				((BaseDao)fleLendingDetailDao).update(detailBean, conn);
				
			}
			conn.commit();
			flagStr = "";
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flagStr;
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 callUserForFileBackById
	 * @param ids
	 * @return 
	 * @see com.chinacreator.xtbg.core.file.service.FileLendingServiceIfc#callUserForFileBackById(java.lang.String)
	 */
	@Override
	public boolean callUserForFileBackById(String ids,String contentStr,String sendUserId,String sendUserName,boolean isDX,boolean isXX) {

		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			//1:获得需要发送短信的借阅信息List
			FileLendingDetailDao fleLendingDetailDao = (FileLendingDetailDao)LoadSpringContext.getApplicationContext().getBean("FileLendingDetailDaoImpl");
			List<Map<String,String>> list = fleLendingDetailDao.getFileLendingDetailListByIds(ids, conn);
			//2:去重
			Map<String,Map<String,String>> map = new HashMap<String,Map<String,String>>();
			for (Map<String, String> bean : list) {
				if(!map.containsKey(bean.get("f_lending_userid"))
						&&!StringUtil.nullOrBlank(bean.get("f_tel"))){
					map.put(bean.get("f_lending_userid"), bean);
				}
			}
			//3:发短信
			NoteServiceImpl nsi=new NoteServiceImpl();
			MessageUtil util=new MessageUtil();
			List<NoteDetailBean> listT = new ArrayList<NoteDetailBean>();
			for (String userId : map.keySet()) {
				if(isDX){
					Map<String,String> bean = map.get(userId);
					
					NoteDetailBean smsSendBean = new NoteDetailBean();
					smsSendBean.setPhone_num(bean.get("f_tel"));
					smsSendBean.setUser_name(bean.get("f_lending_username"));
					smsSendBean.setUser_id(bean.get("f_lending_userId"));
					listT.add(smsSendBean);
					
					NoteBufferBean nBean = new NoteBufferBean();
					StringBuffer content = new StringBuffer(contentStr+"("+sendUserName+"发送)");
					nBean.setContent(content.toString());
					nBean.setUser_name(sendUserName);
					nsi.doNoteSend(nBean,listT,conn);
				}
				
				if(isXX){
					List<String> user_list=new ArrayList<String>();
					user_list.add(userId);
					util.sendMsg(contentStr, sendUserId, user_list, conn);
				}
			}
			conn.commit();
			flag = true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	
	}
	/**
	 * 
	 */
	@Override
	public boolean deleteFlow(String ids) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FileLendingDetailDao fleLendingDetailDao = (FileLendingDetailDao)LoadSpringContext.getApplicationContext().getBean("FileLendingDetailDaoImpl");
			flag = fleLendingDetailDao.deleteFlow(ids,conn);
			return flag;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
}
