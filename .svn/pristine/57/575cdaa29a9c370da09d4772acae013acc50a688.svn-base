package com.chinacreator.xtbg.pub.personwork.service.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.pub.personwork.dao.PersonInfoDao;
import com.chinacreator.xtbg.pub.personwork.entity.PersonExtraInfoBean;
import com.chinacreator.xtbg.pub.personwork.entity.PersonInfoBean;
import com.chinacreator.xtbg.pub.personwork.service.PersonInfoServiceIfc;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.DbconnManager;
import com.chinacreator.xtbg.pub.util.StringUtil;

public class PersonInfoServiceImpl implements PersonInfoServiceIfc {
	public static final Logger logger = Logger.getLogger(PersonInfoServiceImpl.class.getName());
	@Override
	public String  savePersonInfo(String baseinfoJson, String phoneVOList,
			String foxVOList, String emailVOList, String qqVOList,
			String birthVOList, String companyVOList, String positionVOList,
			String addressVOList, String websiteVOList) throws Exception {
		// TODO Auto-generated method stub
		PersonInfoBean personInfoBean  = new PersonInfoBean();
		if (!StringUtil.isBlank(baseinfoJson)) {
			baseinfoJson = DataControlUtil.replaceStr(baseinfoJson);
			baseinfoJson = Escape.unescape(baseinfoJson);
			personInfoBean = (PersonInfoBean) JSONObject.parseObject(baseinfoJson, PersonInfoBean.class);
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
		Connection con = DbconnManager.getInstance().getTransactionConnection();
		String person_id = personInfoBean.getPerson_id();
		try {
			PersonInfoDao personInfodao = (PersonInfoDao)DaoImplClassUtil.getDaoImplClass("personInfoDaoImpl");
			person_id = personInfodao.savePersonBaseInfo(personInfoBean, con);
			personInfodao.savePersonExtraInfo(person_id,"1",phoneList, con);
			personInfodao.savePersonExtraInfo(person_id,"2",foxList, con);
			personInfodao.savePersonExtraInfo(person_id,"3",emailList, con);
			personInfodao.savePersonExtraInfo(person_id,"4",qqList, con);
			personInfodao.savePersonExtraInfo(person_id,"5",birthList, con);
			personInfodao.savePersonExtraInfo(person_id,"6",companyList, con);
			personInfodao.savePersonExtraInfo(person_id,"7",positionList, con);
			personInfodao.savePersonExtraInfo(person_id,"8",addressList, con);
			personInfodao.savePersonExtraInfo(person_id,"9",websiteList, con);
			
			
			con.commit();
		} catch (Exception e) {
			
			logger.info(e.getMessage());
			DbconnManager.rollback(con);
			throw e;
		}finally {
			DbconnManager.closeConnection(con);
		}
		return person_id;
	   
	}
	
	public List<PersonExtraInfoBean> getPersonExtraList(String listJson){
		listJson = DataControlUtil.replaceStr(listJson);
		    List<PersonExtraInfoBean> personextralist = new ArrayList<PersonExtraInfoBean>();
		    PersonExtraInfoBean personextraBean = new PersonExtraInfoBean();
		    if(!StringUtil.isBlank(listJson)) {
		    	int personextraListSize = listJson.split("_____").length;
			    for(int i = 0 ; i < personextraListSize; i++){
			        String personJson = listJson.split("_____")[i];
			        personJson = Escape.unescape(personJson);
			        personJson = DataControlUtil.replaceStr(personJson);
			        
			        personextraBean = (PersonExtraInfoBean) JSONObject.parseObject(personJson, PersonExtraInfoBean.class);
			        personextralist.add(personextraBean);
			    }
		    }
		    return personextralist;
	}

	@Override
	public void deletePersonInfo(String personids,String userid,String directoryids) throws Exception {
		Connection con = DbconnManager.getInstance().getTransactionConnection();
		PersonInfoDao personInfodao = (PersonInfoDao)DaoImplClassUtil.getDaoImplClass("personInfoDaoImpl");
		
		try{
			personInfodao.deletePersonInfo(personids, con);
			personInfodao.cancelPersonalDirectoryRelationship(userid, directoryids, con);
			con.commit();
		}catch(Exception e){
			logger.info(e.getMessage());
			DbconnManager.rollback(con);
			throw e;
		}finally {
			DbconnManager.closeConnection(con);
		}
		
	}

	@Override
	public void savePersonGroupInfo(String personids, String groupids)
			throws Exception {
		Connection con = DbconnManager.getInstance().getTransactionConnection();
		PersonInfoDao personInfodao = (PersonInfoDao)DaoImplClassUtil.getDaoImplClass("personInfoDaoImpl");
		
		try{
			personInfodao.savePersonGroupInfo(personids, groupids, con);
			con.commit();
		}catch(Exception e){
			logger.info(e.getMessage());
			DbconnManager.rollback(con);
			throw e;
		}finally {
			DbconnManager.closeConnection(con);
		}
		
	}
	
	
	
	
}
