package com.chinacreator.xtbg.core.personwork.service.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.personwork.dao.PersonInfoDao;
import com.chinacreator.xtbg.core.personwork.dao.PriManageDao;
import com.chinacreator.xtbg.core.personwork.entity.ListShowUtilBean;
import com.chinacreator.xtbg.core.personwork.entity.PGroupBean;
import com.chinacreator.xtbg.core.personwork.entity.PersonExtraInfoBean;
import com.chinacreator.xtbg.core.personwork.entity.PersonExtraShowBean;
import com.chinacreator.xtbg.core.personwork.entity.PersonInfoBean;
import com.chinacreator.xtbg.core.personwork.service.PersonInfoServiceIfc;

/**
 * 
 *<p>
 * Title:PersonInfoServiceIfc.java
 * </p>
 *<p>
 * Description:通讯录处理service实现类
 * </p>
 *<p>
 * Copyright:Copyright (c)2013
 * </p>
 *<p>
 * Company:湖南科创
 * </p>
 * 
 * @author 戴连春
 *@version 1.0 2013-6-7
 */
public class PersonInfoServiceImpl implements PersonInfoServiceIfc {
	public static final Logger LOG = Logger
			.getLogger(PersonInfoServiceImpl.class.getName());

	/**
	 * 
	 * <b>Summary: </b> 复写方法 savePersonInfo
	 * 
	 * @param baseinfoJson
	 * @param phoneVOList
	 * @param foxVOList
	 * @param emailVOList
	 * @param qqVOList
	 * @param birthVOList
	 * @param companyVOList
	 * @param positionVOList
	 * @param addressVOList
	 * @param websiteVOList
	 * @return
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.personwork.service.PersonInfoServiceIfc#savePersonInfo(java.lang.String,
	 *      java.lang.String, java.lang.String, java.lang.String,
	 *      java.lang.String, java.lang.String, java.lang.String,
	 *      java.lang.String, java.lang.String, java.lang.String)
	 */
	@Override
	public String savePersonInfo(String baseinfoJson, String phoneVOList,
			String foxVOList, String emailVOList, String qqVOList,
			String birthVOList, String companyVOList, String positionVOList,
			String addressVOList, String websiteVOList) {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();

			PersonInfoBean personInfoBean = new PersonInfoBean();
			if (!StringUtil.isBlank(baseinfoJson)) {
				baseinfoJson = DataControlUtil.replaceStr(baseinfoJson);
				baseinfoJson = Escape.unescape(baseinfoJson);
				personInfoBean = (PersonInfoBean) JSONObject.parseObject(
						baseinfoJson, PersonInfoBean.class);
			}

			List<PersonExtraInfoBean> phoneList = getPersonExtraList(phoneVOList);
			List<PersonExtraInfoBean> foxList = getPersonExtraList(foxVOList);
			List<PersonExtraInfoBean> emailList = getPersonExtraList(emailVOList);
			List<PersonExtraInfoBean> qqList = getPersonExtraList(qqVOList);
			List<PersonExtraInfoBean> birthList = getPersonExtraList(birthVOList);
			List<PersonExtraInfoBean> companyList = getPersonExtraList(companyVOList);
			List<PersonExtraInfoBean> positionList = getPersonExtraList(positionVOList);
			List<PersonExtraInfoBean> addressList = getPersonExtraList(addressVOList);
			List<PersonExtraInfoBean> websiteList = getPersonExtraList(websiteVOList);

			String person_id = personInfoBean.getPerson_id();

			PersonInfoDao personInfodao = (PersonInfoDao) LoadSpringContext
					.getApplicationContext().getBean("personInfoDaoImpl");
			person_id = personInfodao.savePersonBaseInfo(personInfoBean, conn);
			personInfodao.savePersonExtraInfo(person_id, "1", phoneList, conn);
			personInfodao.savePersonExtraInfo(person_id, "2", foxList, conn);
			personInfodao.savePersonExtraInfo(person_id, "3", emailList, conn);
			personInfodao.savePersonExtraInfo(person_id, "4", qqList, conn);
			personInfodao.savePersonExtraInfo(person_id, "5", birthList, conn);
			personInfodao
					.savePersonExtraInfo(person_id, "6", companyList, conn);
			personInfodao.savePersonExtraInfo(person_id, "7", positionList,
					conn);
			personInfodao
					.savePersonExtraInfo(person_id, "8", addressList, conn);
			personInfodao
					.savePersonExtraInfo(person_id, "9", websiteList, conn);
			DbManager.closeTransactionConnection(conn, true);
			return person_id;
		} catch (Exception e) {
			DbManager.closeTransactionConnection(conn, false);
			LOG.error(e.getMessage(), e);
			return "";
		}
	}

	/**
	 * 
	 *<b>Summary: </b> getPersonExtraList(请用一句话描述这个方法的作用)
	 * 
	 * @param listJson
	 * @return
	 */
	public List<PersonExtraInfoBean> getPersonExtraList(String listJson) {
		listJson = DataControlUtil.replaceStr(listJson);
		List<PersonExtraInfoBean> personextralist = new ArrayList<PersonExtraInfoBean>();
		PersonExtraInfoBean personextraBean = null;
		if (!StringUtil.isBlank(listJson)) {
			int personextraListSize = listJson.split("_____").length;
			for (int i = 0; i < personextraListSize; i++) {
				String personJson = listJson.split("_____")[i];
				personJson = Escape.unescape(personJson);
				personJson = DataControlUtil.replaceStr(personJson);

				personextraBean = (PersonExtraInfoBean) JSONObject.parseObject(
						personJson, PersonExtraInfoBean.class);
				personextralist.add(personextraBean);
			}
		}
		return personextralist;
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 deletePersonInfo
	 * 
	 * @param personids
	 * @param userid
	 * @param directoryids
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.personwork.service.PersonInfoServiceIfc#deletePersonInfo(java.lang.String,
	 *      java.lang.String, java.lang.String)
	 */
	@Override
	public boolean deletePersonInfo(String personids, String userid,
			String directoryids) {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			PersonInfoDao personInfodao = (PersonInfoDao) LoadSpringContext
					.getApplicationContext().getBean("personInfoDaoImpl");
			personInfodao.deletePersonInfo(personids, conn);
			personInfodao.cancelPersonalDirectoryRelationship(userid,
					directoryids, conn);
			DbManager.closeTransactionConnection(conn, true);
			return true;
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			DbManager.closeTransactionConnection(conn, false);
			return false;
		}
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 savePersonGroupInfo
	 * 
	 * @param personids
	 * @param groupids
	 * @throws Exception
	 * @see com.chinacreator.xtbg.core.personwork.service.PersonInfoServiceIfc#savePersonGroupInfo(java.lang.String,
	 *      java.lang.String)
	 */
	@Override
	public boolean savePersonGroupInfo(String personids, String groupids) {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			PersonInfoDao personInfodao = (PersonInfoDao) LoadSpringContext
					.getApplicationContext().getBean("personInfoDaoImpl");
			personInfodao.savePersonGroupInfo(personids, groupids, conn);
			DbManager.closeTransactionConnection(conn, true);
			return true;
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			DbManager.closeTransactionConnection(conn, false);
			return false;
		}

	}

	/**
	 * 
	 *<b>Summary: 根据用户id判断用户是否添加了通讯录分组</b> isGroupExists(请用一句话描述这个方法的作用)
	 * 
	 * @param userId
	 *            用户id
	 * @return 是否存在分组的标志 true：存在，false:不存在
	 * @throws Exception
	 */
	public boolean isGroupExist(String userId,String isPublic) {
		try {
			PersonInfoDao personInfodao = (PersonInfoDao) LoadSpringContext
					.getApplicationContext().getBean("personInfoDaoImpl");

			return personInfodao.isGroupExists(userId,isPublic);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			return false;
		}
	}

	/**
	 * 
	 *<b>Summary: 根据id查询出当前用户所有的分组</b> isGroupExists(请用一句话描述这个方法的作用)
	 * 
	 * @param userId
	 *            用户id
	 * @param is_public
	 *            是否公共通讯录
	 * @return 分组信息bean集合
	 * @throws Exception
	 */
	public List<PGroupBean> queryGroup(String userId, String is_public) {
		try {
			PriManageDao priManageDao = (PriManageDao) LoadSpringContext
					.getApplicationContext().getBean("priManageDaoImpl");

			// 分组信息
			PGroupBean pbGroupBean = new PGroupBean();
			pbGroupBean.setLoginUserID(userId);
			pbGroupBean.setIs_public_group(is_public);

			// 获得当前用户的所有分组信息
			List<PGroupBean> pgBeanList = priManageDao
					.queryGroup4List(pbGroupBean);

			return pgBeanList;
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			return new ArrayList<PGroupBean>();
		}
	}

	/**
	 * 
	 *<b>Summary: 根据id查询存在数据的首字母信息</b> getFirstCodeShowInfo(请用一句话描述这个方法的作用)
	 * 
	 * @param userId
	 *            用户id
	 * @return List<ListShowUtilBean>数据集合
	 */
	public List<ListShowUtilBean> getFirstCodeShowInfo(String userId) {

		try {
			PersonInfoDao personInfodao = (PersonInfoDao) LoadSpringContext
					.getApplicationContext().getBean("personInfoDaoImpl");

			return personInfodao.getFirstCodeShowInfo(userId, "personal");
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			// 代码重构，由于外部很多地方调用没有判断是否为空，故返回一个没有数据的list
			return new ArrayList<ListShowUtilBean>();
		}
	}
	
	/**
	 * 
	 *<b>Summary: 根据id查询存在数据的首字母信息</b> getFirstCodeShowInfo(请用一句话描述这个方法的作用)
	 * 
	 * @param userId
	 *            用户id
	 * @return List<ListShowUtilBean>数据集合
	 */
	public List<ListShowUtilBean> getFirstCodeShowInfo(String userId,String isPublic) {

		try {
			PersonInfoDao personInfodao = (PersonInfoDao) LoadSpringContext
					.getApplicationContext().getBean("personInfoDaoImpl");

			return personInfodao.getFirstCodeShowInfo(userId, "personal",isPublic);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			// 代码重构，由于外部很多地方调用没有判断是否为空，故返回一个没有数据的list
			return new ArrayList<ListShowUtilBean>();
		}
	}

	/**
	 * 
	 * <b>Summary: 查询人员扩展信息集合</b> 复写方法 findPersonExtraInfoList
	 * 
	 * @param personId
	 * @param type
	 * @return
	 * @see com.chinacreator.xtbg.core.personwork.service.PersonInfoServiceIfc#findPersonExtraInfoList(java.lang.String,
	 *      java.lang.String)
	 */
	public List<PersonExtraShowBean> findPersonExtraInfoList(String personId,
			String type) {
		try {
			PersonInfoDao personInfodao = (PersonInfoDao) LoadSpringContext
					.getApplicationContext().getBean("personInfoDaoImpl");

			return personInfodao.findPersonExtraInfoList(personId, type);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			return new ArrayList<PersonExtraShowBean>();
		}

	}

	/**
	 * 
	 *<b>Summary: 获得用户分组下拉框的数据</b> getGroupSelectHtml(请用一句话描述这个方法的作用)
	 * 
	 * @param userid
	 *            用户id
	 * @return
	 * @throws Exception
	 */
	public String getGroupSelectHtml(String userId, String is_public) {
		try {
			PersonInfoDao personInfodao = (PersonInfoDao) LoadSpringContext
					.getApplicationContext().getBean("personInfoDaoImpl");

			return personInfodao.getGroupSelectHtml(userId, is_public);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			return "";
		}
	}

	/**
	 * 
	 * <b>Summary: </b> 复写方法 findPersonBaseInfo
	 * 
	 * @param personId
	 * @return
	 * @see com.chinacreator.xtbg.core.personwork.service.PersonInfoServiceIfc#findPersonBaseInfo(java.lang.String)
	 */
	public PersonInfoBean findPersonBaseInfo(String personId) {
		try {
			PersonInfoDao personInfodao = (PersonInfoDao) LoadSpringContext
					.getApplicationContext().getBean("personInfoDaoImpl");

			return personInfodao.findPersonBaseInfo(personId);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			return new PersonInfoBean();
		}
	}

	/**
	 * 
	 *<b>Summary: 根据分组id查询分组信息</b> queryGroup(请用一句话描述这个方法的作用)
	 * 
	 * @param groupId
	 *            通讯录分组的id
	 * @return 分组对象
	 */
	public PGroupBean queryGroupByGroupId(String groupId) {
		try {
			PriManageDao priManageDao = (PriManageDao) LoadSpringContext
					.getApplicationContext().getBean("priManageDaoImpl");

			// 分组信息
			PGroupBean pbGroupBean = new PGroupBean();
			pbGroupBean.setLoginUserID(groupId);

			// 获得当前用户的所有分组信息
			PGroupBean pgBean = priManageDao.queryGroup(groupId);

			return pgBean;
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			return new PGroupBean();
		}
	}

	/**
	 * 
	 *<b>Summary:查询顶级机构id </b> queryRootOrg(请用一句话描述这个方法的作用)
	 * 
	 * @return
	 * @throws SQLException
	 */
	public String queryRootOrg() {
		try {
			PersonInfoDao personInfodao = (PersonInfoDao) LoadSpringContext
					.getApplicationContext().getBean("personInfoDaoImpl");

			return personInfodao.queryRootOrg();
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			return "";
		}
	}

	/**
	 * 
	 *<b>Summary: </b> queryRootOrg(请用一句话描述这个方法的作用)
	 * 
	 * @param orgId
	 * @return
	 */
	public List<ListShowUtilBean> getFirstCodeShowInfo4PublicAddress(String orgId) {
		try {
			PersonInfoDao personInfodao = (PersonInfoDao) LoadSpringContext
					.getApplicationContext().getBean("personInfoDaoImpl");

			return personInfodao.getFirstCodeShowInfo4PublicAddress(orgId);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			return new ArrayList<ListShowUtilBean>();
		}
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 setPersonalDirectoryRelationship
	  * @param userid
	  * @param directoryids 
	  * @see com.chinacreator.xtbg.core.personwork.service.PersonInfoServiceIfc#setPersonalDirectoryRelationship(java.lang.String, java.lang.String)
	 */
	@Override
	public boolean setPersonalDirectoryRelationship(String userid,
			String directoryids) {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			PersonInfoDao personInfodao = (PersonInfoDao) LoadSpringContext
					.getApplicationContext().getBean("personInfoDaoImpl");

			personInfodao.setPersonalDirectoryRelationship(userid, directoryids,conn);
		    DbManager.closeTransactionConnection(conn, true);
			return true;
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			DbManager.closeTransactionConnection(conn, false);
			return false;
		}
	}
	
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getPersonInfoBeanList
	  * @param person_ids
	  * @return 
	  * @see com.chinacreator.xtbg.core.personwork.service.PersonInfoServiceIfc#getPersonInfoBeanList(java.lang.String) 
	  */
	public List<Map<String, String>> getPersonInfoBeanList(String person_ids) {
		Connection conn = null;
		List<Map<String, String>> personInfoBeanListMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			personInfoBeanListMap = new ArrayList<Map<String, String>>();
			PersonInfoDao personInfodao = (PersonInfoDao) LoadSpringContext
					.getApplicationContext().getBean("personInfoDaoImpl");
			personInfoBeanListMap = personInfodao.getPersonInfoBeanList(
					person_ids, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally {
			if (conn != null) {
				DbManager.closeConnection(conn);
			}
		}
		return personInfoBeanListMap;
	}
}
