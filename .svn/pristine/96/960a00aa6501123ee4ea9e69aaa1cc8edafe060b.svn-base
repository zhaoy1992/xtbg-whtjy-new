package com.chinacreator.xtbg.core.archive.service.impl;

import java.io.File;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.core.archive.cache.SendArchiveThread;
import com.chinacreator.xtbg.core.archive.cache.SendUnionArchiveThread;
import com.chinacreator.xtbg.core.archive.dao.WordArchiveDao;
import com.chinacreator.xtbg.core.archive.entity.ArchiveDispatchBean;
import com.chinacreator.xtbg.core.archive.entity.OaWordNumberBean;
import com.chinacreator.xtbg.core.archive.gwcs.bean.ArchiveAddrBean;
import com.chinacreator.xtbg.core.archive.gwcs.bean.ArchiveGwcsXmlBean;
import com.chinacreator.xtbg.core.archive.gwcs.bean.ArchiveGwcsXmlBean.Addrinfor;
import com.chinacreator.xtbg.core.archive.gwcs.bean.ArchiveGwcsXmlBean.Archiveparameters;
import com.chinacreator.xtbg.core.archive.gwcs.bean.GwConstant;
import com.chinacreator.xtbg.core.archive.gwcs.bean.OA2ExchangerDataBean;
import com.chinacreator.xtbg.core.archive.gwcs.client.ArchiveClientCallGWCSService;
import com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.WordRequestBean;
import com.chinacreator.xtbg.core.archive.gwcs.services.OaSendArchiveService;
import com.chinacreator.xtbg.core.archive.service.WordArchiveService;
import com.chinacreator.xtbg.core.common.fancyuoload.entity.FileInfoBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.DateUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.FileUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.form.service.impl.FormserviceImpl;
import com.chinacreator.xtbg.core.wordnumdef.dao.WordNumDefDao;
import com.chinacreator.xtbg.core.wordnumdef.entity.SerialNumberBean;

/**
 *<p>Title:WordArchiveServiceImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-8-30
 */
public class WordArchiveServiceImpl implements WordArchiveService {
	private static final Logger LOG = Logger.getLogger(WordArchiveServiceImpl.class);
	/** 
	 * <b>Summary: </b>
	 *     复写方法 getMaxArchiveNumber
	 * @param number_type
	 * @param number_year
	 * @param busi_id
	 * @return 
	 * @see com.chinacreator.xtbg.core.archive.service.WordArchiveService#getMaxArchiveNumber(java.lang.String, java.lang.String, java.lang.String) 
	 */
	@Override
	public String getMaxArchiveNumber(String number_type, String number_year, String busi_id) {
		WordArchiveDao dao = (WordArchiveDao)LoadSpringContext.getApplicationContext().getBean("wordArchiveDaoImpl");
		String maxCode = "";
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
				maxCode  = dao.getNumberByBusiId(busi_id,number_year,number_type,conn)+"";
				//特检院OA 自动编号的处理追加 start
				/*if(maxCode.equals("0")){
					maxCode ="1";
				}*/
				//特检院OA 自动编号的处理追加 end
			if("-1".equals(maxCode)||"0".equals(maxCode)){
				maxCode = dao.getNumberByTypeYear(number_type, number_year,conn)+"";
			}
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(),e);
		}finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		return maxCode;
	}
	public boolean isArchiveNumber(String number_type, String number_year, String number_code) {
		WordArchiveDao dao = (WordArchiveDao)LoadSpringContext.getApplicationContext().getBean("wordArchiveDaoImpl");
		boolean flag = false;
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			flag  = dao.isNumber(number_year, number_type, number_code, conn);
			
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(),e);
		}finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		return flag;
	}
	
	//特检院OA  查询是否存在公文编号 2014-06-23 start
	/**
	*<b>Summary: </b>
	* isArchivReadyNmuberByBusId(查询公文编号是否已经被占用了)
	* @param busi_id
	* @param number_type
	* @param number_year
	* @param number_year
	* @return
	*/
	public boolean isArchivReadyNmuberByBusId(String busi_id,String number_type,String number_year,String number_code){
		WordArchiveDao dao = (WordArchiveDao)LoadSpringContext.getApplicationContext().getBean("wordArchiveDaoImpl");
		boolean flag = false;
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			flag  = dao.isArchivReadyNmuberByBusId(busi_id, number_type, number_year,number_code, conn);
			
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(),e);
		}finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		return flag;
	}
	/**
	*<b>Summary: </b>
	* isArchiveNumberBybusId(查询是否存在公文编号)
	* @param busi_id
	* @param number_type
	* @param number_year
	* @return
	 */
	public boolean isArchiveNumberBybusId(String busi_id){
		WordArchiveDao dao = (WordArchiveDao)LoadSpringContext.getApplicationContext().getBean("wordArchiveDaoImpl");
		boolean flag = false;
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			flag  = dao.isNumberByBusId(busi_id, conn);
			
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(),e);
		}finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		return flag;
	}
	//特检院OA  查询是否存在公文编号 2014-06-23 end
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 saveNumber
	  * @param paramJson
	  * @return 
	  * @see com.chinacreator.xtbg.core.archive.service.WordArchiveService#saveNumber(java.lang.String) 
	  */
	@Override
	public boolean saveNumber(String paramJson) {
		paramJson =DataControlUtil.replaceStr(paramJson);
		paramJson = Escape.unescape(paramJson);
		boolean flag = false;
		WordArchiveDao dao = (WordArchiveDao)LoadSpringContext.getApplicationContext().getBean("wordArchiveDaoImpl");
		OaWordNumberBean oaWordNumberBean = null;
		try {
			if(!StringUtil.isBlank(paramJson)){
				oaWordNumberBean = JSONObject.parseObject(paramJson, OaWordNumberBean.class);
			}
			flag = dao.saveNumber(oaWordNumberBean, null);
			
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
		}
		return flag;
	}
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 updateNumber
	  * @param paramJson
	  * @return 
	  * @see com.chinacreator.xtbg.core.archive.service.WordArchiveService#updateNumber(java.lang.String) 
	  */
	@Override
	public boolean updateNumber(String paramJson) {
		paramJson =DataControlUtil.replaceStr(paramJson);
		paramJson = Escape.unescape(paramJson);
		boolean flag = false;
		WordArchiveDao dao = (WordArchiveDao)LoadSpringContext.getApplicationContext().getBean("wordArchiveDaoImpl");
		OaWordNumberBean oaWordNumberBean = null;
		try {
			if(!StringUtil.isBlank(paramJson)){
				oaWordNumberBean = JSONObject.parseObject(paramJson, OaWordNumberBean.class);
			}
			flag = dao.updateNumber(oaWordNumberBean, null);
			
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
		}
		return flag;
	}
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 delNumber
	  * @param number_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.archive.service.WordArchiveService#delNumber(java.lang.String) 
	  */
	@Override
	public boolean delNumber(String number_id) {
		// TODO Auto-generated method stub
		return false;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getNumber
	  * @param busi_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.archive.service.WordArchiveService#getNumber(java.lang.String) 
	  */
	@Override
	public OaWordNumberBean getNumber(String busi_id) {
		WordArchiveDao dao = (WordArchiveDao)LoadSpringContext.getApplicationContext().getBean("wordArchiveDaoImpl");
		OaWordNumberBean oaWordNumberBean = null;
		try {
			oaWordNumberBean = dao.getNumber(busi_id);
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
		}
		return oaWordNumberBean ;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 savepaperNumber
	  * @param paramJson
	  * @return 
	  * @see com.chinacreator.xtbg.core.archive.service.WordArchiveService#savepaperNumber(java.lang.String)
	 */
	@Override
	public boolean savepaperNumber(String paramJson) {
		paramJson =DataControlUtil.replaceStr(paramJson);
		paramJson = Escape.unescape(paramJson);
		boolean flag = false;
		WordArchiveDao dao = (WordArchiveDao)LoadSpringContext.getApplicationContext().getBean("wordArchiveDaoImpl");
		OaWordNumberBean oaWordNumberBean = null;
		try {
			if(!StringUtil.isBlank(paramJson)){
				oaWordNumberBean = JSONObject.parseObject(paramJson, OaWordNumberBean.class);
			}
			if(StringUtil.isBlank(oaWordNumberBean.getNumber_title())){
				//获取编号规则
				String[] serialnumberchar = StringUtil.getPropertiesChar("serialnumberchar",",");
				if(serialnumberchar==null || serialnumberchar.length!= 2){
					serialnumberchar[0] = "〔";
					serialnumberchar[1] = "〕";
				}
				String title= oaWordNumberBean.getNumber_type()+serialnumberchar[0]+oaWordNumberBean.getNumber_year()+serialnumberchar[1]+oaWordNumberBean.getNumber_code()+"号";
				oaWordNumberBean.setNumber_title(title);
			}
			flag = dao.savepaperNumber(oaWordNumberBean, null);
			
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
		}
		return flag;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getWordNumber
	  * @param org_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.archive.service.WordArchiveService#getWordNumber(java.lang.String) 
	  */
	@Override
	public Map<String, List<OaWordNumberBean>> getWordNumber(String org_id) {
		List<OaWordNumberBean> oaWordNumberBeanList = new ArrayList<OaWordNumberBean>();
		Map<String, List<OaWordNumberBean>> numListMap = new LinkedHashMap<String, List<OaWordNumberBean>>();
		WordArchiveDao dao = (WordArchiveDao)LoadSpringContext.getApplicationContext().getBean("wordArchiveDaoImpl");
		try {
			oaWordNumberBeanList = dao.getWordNumber(org_id);
			//按年号进行分类，排序
			if(oaWordNumberBeanList != null && oaWordNumberBeanList.size()>0){
				for(OaWordNumberBean oaWordNumberBean1:oaWordNumberBeanList){
					if(numListMap.containsKey(oaWordNumberBean1.getNumber_year())){
						numListMap.get(oaWordNumberBean1.getNumber_year()).add(oaWordNumberBean1);
					}else{
						List<OaWordNumberBean> oaWordNumberBeanList1 = new ArrayList<OaWordNumberBean>();
						oaWordNumberBeanList1.add(oaWordNumberBean1);
						numListMap.put(oaWordNumberBean1.getNumber_year(), oaWordNumberBeanList1);
					}
				}
			}
			
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
		}
		return numListMap;
	}

	 /** 
	  * <b>Summary: </b>
	  *     复写方法 wordToGWCS
	  * @param ins_id
	  * @param mRecordID
	  * @param wordToGwcsWsdl
	  * @return 
	  * @see com.chinacreator.xtbg.core.archive.service.WordArchiveService#wordToGWCS(java.lang.String) 
	  */
	@Override
	public String wordToGWCS(String ins_id, String mRecordID,String wordToGwcsWsdl) {
		String uuid = "";//上传成功返回的UUID
		ArchiveClientCallGWCSService service = (ArchiveClientCallGWCSService)LoadSpringContext.getApplicationContext().getBean("archiveClientCallGWCS");
		WordArchiveDao dao = (WordArchiveDao)LoadSpringContext.getApplicationContext().getBean("wordArchiveDaoImpl");
		WordRequestBean bean = new WordRequestBean();
		bean.setFileName(mRecordID+".doc");
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			byte[] textByte = dao.getTextByte(mRecordID);
			bean.setDh(textByte);
			uuid = service.callWordToGWCS(bean,wordToGwcsWsdl);
			if(!StringUtil.isBlank(uuid) && !"erro".equals(uuid)){
				
			}
			/*if(!StringUtil.isBlank(uuid) && !"erro".equals(uuid)){
				String flag  = dao.selWordCeb(ins_id,conn);
				if("-1".equals(flag)){//如果有记录，插入
					dao.saveWordCeb(ins_id,uuid,conn);
				}else{//如果没有记录，更新
					dao.updateWordCeb(ins_id,uuid,conn);
				}
			}*/
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
			DbManager.rollBackNoThrow(conn);
		}finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
	  return uuid;
	}
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 saveOrUpdateArchiveDispatch
	  * @param archiveDispatchBean
	  * @return 
	  * @see com.chinacreator.xtbg.core.archive.service.WordArchiveService#saveOrUpdateArchiveDispatch(com.chinacreator.xtbg.core.archive.entity.ArchiveDispatchBean) 
	  */
	@Override
	public boolean saveOrUpdateArchiveDispatch(ArchiveDispatchBean archiveDispatchBean) {
		boolean flag = true;//上传成功返回的UUID
		WordArchiveDao dao = (WordArchiveDao)LoadSpringContext.getApplicationContext().getBean("wordArchiveDaoImpl");
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			flag = flag && dao.delArchiveDispatch(archiveDispatchBean.getIns_id(),conn);//删除公文要素信息
			flag = flag && dao.saveArchiveDispatch(archiveDispatchBean,conn);//保存公文要素信息
			String gwcs_address =  archiveDispatchBean.getGwcs_address(); //获取公文传输地址串
			String[] adressArr = gwcs_address.split("#");
			List<ArchiveAddrBean> archiveAddrBeanList = new ArrayList<ArchiveAddrBean>();
			for(int i=0; i<adressArr.length; i++){//循环一条记录
				String[] adressInfo = adressArr[i].split(",");
				if(adressInfo.length!=4 && adressInfo.length!=5){
					throw new Exception("地址参数错误，无法获取正确的公文地址参数");
				}
				ArchiveAddrBean archiveAddrBean = new ArchiveAddrBean();
				archiveAddrBean.setIns_id(archiveDispatchBean.getIns_id());
				archiveAddrBean.setReceiveraddr(adressInfo[0]);
				archiveAddrBean.setReceivername(adressInfo[1]);
				archiveAddrBean.setPrint_num(adressInfo[2]);
				archiveAddrBean.setNum(adressInfo[3]);
				if(adressInfo.length==5){
					archiveAddrBean.setAtt_path(adressInfo[4]);
				}else{
					archiveAddrBean.setAtt_path("");
				}
				archiveAddrBean.setSend_type("m");
				archiveAddrBean.setIs_send("0");
				archiveAddrBean.setSend_count("0");
				archiveAddrBeanList.add(archiveAddrBean);
			}
			flag = flag && dao.delArchiveAddr(archiveDispatchBean.getIns_id(),conn);//删除公文地址信息
			flag = flag && dao.saveArchiveAddr(archiveAddrBeanList,conn);//保存公文地址信息
		} catch (Exception e) {
			flag = false;
			LOG.error(e.getMessage(),e);
			DbManager.rollBackNoThrow(conn);
		}finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
	  return flag;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 sendToArchiveCeb
	  * @param ins_id
	  * @param uuid
	  * @return 
	  * @see com.chinacreator.xtbg.core.archive.service.WordArchiveService#sendToArchiveCeb(java.lang.String, java.lang.String) 
	  */
	@Override
	public String sendToArchiveCeb(ArchiveDispatchBean archiveDispatchBean, String uuid) {
		String returnStr = "";
		try {
			OaSendArchiveService service = (OaSendArchiveService)LoadSpringContext.getApplicationContext().getBean("oaSendArchiveServiceImpl");
			ArchiveGwcsXmlBean archiveGwcsXmlBean = new ArchiveGwcsXmlBean();
			Archiveparameters archiveparameters = new ArchiveGwcsXmlBean.Archiveparameters();
			ArchiveGwcsXmlBean.Archiveparameters.Num num = new ArchiveGwcsXmlBean.Archiveparameters.Num();
			//正文
			GwConstant gwConstant = new GwConstant();//公文传输常量
			String filePath = gwConstant.tmp_zip_attch_path+File.separator+archiveDispatchBean.getIns_id()+File.separator;
			String[] textpathArry = new String[2]; 
			textpathArry[0] = archiveDispatchBean.getRecordid()+".doc";
			textpathArry[1] = filePath+textpathArry[0];
			
			//装填archiveparameters
			archiveparameters.setTitle(archiveDispatchBean.getTitle());
			
			WordArchiveService wservice = new WordArchiveServiceImpl();//读取文号信息
			OaWordNumberBean oaWordNumberBean = wservice.getNumber(archiveDispatchBean.getBusi_id());
			num.setType("2");
			num.setPrefix(oaWordNumberBean.getNumber_type());
			//获取编号规则
			String[] serialnumberchar = StringUtil.getPropertiesChar("serialnumberchar",",");
			if(serialnumberchar==null || serialnumberchar.length!= 2){
				serialnumberchar[0] = "〔";
				serialnumberchar[1] = "〕";
			}
			num.setSymbol(serialnumberchar[0]+oaWordNumberBean.getNumber_year()+serialnumberchar[1]);
			num.setSerial_number(oaWordNumberBean.getNumber_code()+"号");
			archiveparameters.setNum(num);
			
			archiveparameters.setSecrecy_grade(archiveDispatchBean.getSecrecy_grade());
			archiveparameters.setEffect_date(archiveDispatchBean.getEffect_date());
			archiveparameters.setUrgency_grade(archiveDispatchBean.getUrgency_grade());
			archiveparameters.setCaption(archiveDispatchBean.getCaption());
			archiveparameters.setKeyword(archiveDispatchBean.getCaption());
			archiveparameters.setDispatch_type(archiveDispatchBean.getDispatch_type());
			archiveparameters.setSender(archiveDispatchBean.getSender());
			archiveparameters.setSendscope("公开发布");
			archiveparameters.setCreate_date(archiveDispatchBean.getCreate_date());
			archiveparameters.setSend_org_name(archiveDispatchBean.getSend_org_name());
			archiveparameters.setSend_org_addr(archiveDispatchBean.getSend_org_addr());
			archiveparameters.setSendusername(archiveDispatchBean.getSender());
			archiveparameters.setIssign("false");
			archiveparameters.setContact_phone("");
			archiveparameters.setMsg(archiveDispatchBean.getMsg_txt());
			archiveparameters.setFile_name(textpathArry[0]);
			archiveparameters.setFile_type("doc");

			List<String> affixnames = new ArrayList<String>();
			List<String> affixpaths = new ArrayList<String>();
			if(!StringUtil.isBlank(archiveDispatchBean.getSend_attach_id())){//如果附件ID不为空,组装附件
				List<FileInfoBean> fileInfoBeanList = FileUtil.getFileByDjbh(archiveDispatchBean.getSend_attach_id());
				
				for(int i=0; i<fileInfoBeanList.size();i++){
					affixnames.add(fileInfoBeanList.get(i).getFilename().trim());
					affixpaths.add(filePath+fileInfoBeanList.get(i).getFilename().trim());
				}
				archiveparameters.setAffixnames(affixnames);
			}
			List<Addrinfor> addrinfors = new ArrayList<Addrinfor>();
			//装填receivedeptinfor
			System.out.println("公文地址串："+archiveDispatchBean.getGwcs_address());
			if(!StringUtil.isBlank(archiveDispatchBean.getGwcs_address())){
				//673afffd-4aff-4e79-aae9-83e693e68e08;望城省,2,11#1211fcf9-cc96-4ff9-9c2d-1db21da5aeb6;浏阳市,3,22#
				String[] adressArr = archiveDispatchBean.getGwcs_address().split("#");
				for(int i=0; i<adressArr.length; i++){//循环一条记录
					if(!StringUtil.isBlank(adressArr[i])){
						String[] adressInfo = adressArr[i].split(",");
						Addrinfor addrinfor = new ArchiveGwcsXmlBean.Addrinfor();
						addrinfor.setReceiveraddr(adressInfo[0]);
						addrinfor.setReceivername(adressInfo[1]);
						addrinfor.setPrint_num(adressInfo[2]);
						addrinfor.setNum(adressInfo[3]);
						addrinfor.setSend_type("m");
						addrinfors.add(addrinfor);
						
					}
				}
			}
			archiveGwcsXmlBean.setArchiveparameters(archiveparameters);
			archiveGwcsXmlBean.setReceivedeptinfor(addrinfors);
			//附件
			String[] affixpathArry = new String[2]; 
			affixpathArry = (String[])affixpaths.toArray(affixpathArry);
			
			returnStr = service.callArchiveSendCeb(textpathArry,archiveGwcsXmlBean, affixpathArry);
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
		}
		return returnStr;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 toTempFile
	  * @param mRecordID
	  * @param ins_id
	  * @param busi_id
	  * @param n_attach_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.archive.service.WordArchiveService#toTempFile(java.lang.String, java.lang.String, java.lang.String, java.lang.String) 
	  */
	@Override
	public boolean toTempFile(String mRecordID, String ins_id, String busi_id,String n_attach_id) {
		boolean flag = true;//上传成功返回的UUID
		WordArchiveDao dao = (WordArchiveDao)LoadSpringContext.getApplicationContext().getBean("wordArchiveDaoImpl");
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			flag = flag && dao.wordToTemp(mRecordID,ins_id,conn);
			flag = flag && dao.attachToTemp(n_attach_id,ins_id,conn);

		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
			DbManager.rollBackNoThrow(conn);
		}finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
	  return flag;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 sendToArchive
	  * @param archiveDispatchBean
	  * @param uuid
	  * @return 
	  * @see com.chinacreator.xtbg.core.archive.service.WordArchiveService#sendToArchive(com.chinacreator.xtbg.core.archive.entity.ArchiveDispatchBean, java.lang.String) 
	  */
	@Override
	public String sendToArchive(ArchiveDispatchBean archiveDispatchBean,String uuid) {
		String returnStr = "";
		try {
			//调用发文线程
			SendArchiveThread sendArchiveThread = new SendArchiveThread(archiveDispatchBean);
			sendArchiveThread.start();
			returnStr = "发送公文成功";
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
		}
		return returnStr;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 sendUnionArchive
	  * @param archiveDispatchBean
	  * @param uuid 
	  * @see com.chinacreator.xtbg.core.archive.service.WordArchiveService#sendUnionArchive(com.chinacreator.xtbg.core.archive.entity.ArchiveDispatchBean, java.lang.String)
	 */
	@Override
	public String sendUnionArchive(ArchiveDispatchBean archiveDispatchBean,
			String uuid) {
		String returnStr = "";
		try {
			//调用联合盖章发送
			SendUnionArchiveThread sendUnionArchiveThread = new SendUnionArchiveThread(archiveDispatchBean);
			sendUnionArchiveThread.start();
			returnStr = "联合盖章发送成功";
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
		}
		return returnStr;
		
	}
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getArchiveDispatch
	  * @param archiveDispatchBean
	  * @return 
	  * @see com.chinacreator.xtbg.core.archive.service.WordArchiveService#getArchiveDispatch(com.chinacreator.xtbg.core.archive.entity.ArchiveDispatchBean) 
	  */
	@Override
	public ArchiveDispatchBean getArchiveDispatch(String uuid) {
		ArchiveDispatchBean archiveDispatchBean = null;
		WordArchiveDao dao = (WordArchiveDao)LoadSpringContext.getApplicationContext().getBean("wordArchiveDaoImpl");
		try {
			archiveDispatchBean = dao.getArchiveDispatch(uuid, null);
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
		}
		return archiveDispatchBean;
	}
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getArchiveDispatchbean
	  * @param archiveDispatchBean
	  * @return 
	  * @see com.chinacreator.xtbg.core.archive.service.WordArchiveService#getArchiveDispatch(com.chinacreator.xtbg.core.archive.entity.ArchiveDispatchBean) 
	  */
	@Override
	public ArchiveDispatchBean getArchiveDispatchbean(String ins_id) {
		ArchiveDispatchBean archiveDispatchBean = null;
		WordArchiveDao dao = (WordArchiveDao)LoadSpringContext.getApplicationContext().getBean("wordArchiveDaoImpl");
		try {
			archiveDispatchBean = dao.getArchiveDispatchbean(ins_id, null);
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
		}
		return archiveDispatchBean;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 sendToArchiveFZ
	  * @param archiveDispatchBean
	  * @return 
	  * @see com.chinacreator.xtbg.core.archive.service.WordArchiveService#sendToArchiveFZ(com.chinacreator.xtbg.core.archive.entity.ArchiveDispatchBean) 
	  */
	@Override
	public String sendToArchiveFZ(ArchiveDispatchBean archiveDispatchBean) {
		OaSendArchiveService service = (OaSendArchiveService)LoadSpringContext.getApplicationContext().getBean("oaSendArchiveServiceImpl");
		OA2ExchangerDataBean oA2ExchangerDataBean = new OA2ExchangerDataBean();
		String returnStr ="";
		try {
			//向公文系统发送的数据包消息描述
			OA2ExchangerDataBean.Message message = new OA2ExchangerDataBean.Message();
			message.setType("40");
			message.setStampNums("0");
			oA2ExchangerDataBean.setMessage(message);
			
			//公文的发送单位
			OA2ExchangerDataBean.UnitInfo unitInfo = new OA2ExchangerDataBean.UnitInfo();
			//sends节点
			List<OA2ExchangerDataBean.UnitInfo.Unit> senedlist = new ArrayList<OA2ExchangerDataBean.UnitInfo.Unit>(); 
			OA2ExchangerDataBean.UnitInfo.Unit unit = new OA2ExchangerDataBean.UnitInfo.Unit();
			unit.setUnitID(archiveDispatchBean.getSend_org_addr());
			unit.setUnitName(archiveDispatchBean.getSend_org_name());
			unit.setProcUUID("");
			senedlist.add(unit);
			unitInfo.setSends(senedlist);
			/*//unites节点
			List<OA2ExchangerDataBean.UnitInfo.Unit> uniteslist = new ArrayList<OA2ExchangerDataBean.UnitInfo.Unit>(); 
			OA2ExchangerDataBean.UnitInfo.Unit unit1 = new OA2ExchangerDataBean.UnitInfo.Unit();
			unit1.setUnitID("0001");
			unit1.setUnitName("单位1");
			unit1.setProcUUID("");
			uniteslist.add(unit1);
			unitInfo.setUnites(uniteslist);*/
			
			// 添加接受单位1
			//receives 添加
			ArrayList<OA2ExchangerDataBean.UnitInfo.Unit> receiveslist = new ArrayList<OA2ExchangerDataBean.UnitInfo.Unit>(); 
			//Template 节点添加
			ArrayList<OA2ExchangerDataBean.SndDstrbtInfo.DetailXml.TemplateMem> templateMemList = new ArrayList<OA2ExchangerDataBean.SndDstrbtInfo.DetailXml.TemplateMem>();
			if(!StringUtil.isBlank(archiveDispatchBean.getGwcs_address())){
				//673afffd-4aff-4e79-aae9-83e693e68e08;望城省,2,11#1211fcf9-cc96-4ff9-9c2d-1db21da5aeb6;浏阳市,3,22#
				String[] adressArr = archiveDispatchBean.getGwcs_address().split("#");
				for(int i=0; i<adressArr.length; i++){//循环一条记录
					if(!StringUtil.isBlank(adressArr[i])){
						String[] adressInfo = adressArr[i].split(",");
						//receives
						OA2ExchangerDataBean.UnitInfo.Unit unit2 = new OA2ExchangerDataBean.UnitInfo.Unit();
						unit2.setUnitID(adressInfo[0]);
						unit2.setUnitName(adressInfo[1]);
						unit2.setProcUUID("");
						receiveslist.add(unit2);
						//Template 
						OA2ExchangerDataBean.SndDstrbtInfo.DetailXml.TemplateMem  templateMem = new OA2ExchangerDataBean.SndDstrbtInfo.DetailXml.TemplateMem();
						templateMem.setPrnNums(adressInfo[2]);
						templateMem.setRecvUnitID(adressInfo[0]);
						templateMem.setRecvUnitName(adressInfo[1]);
						templateMem.setStartNum(adressInfo[3]);
						templateMem.setVersion("1.0");
						templateMemList.add(templateMem);
					}
				}
			}
			unitInfo.setReceives(receiveslist);
			
			//添加接受单位1
			/*OA2ExchangerDataBean.UnitInfo.Unit unit2 = new OA2ExchangerDataBean.UnitInfo.Unit();
			unit2.setUnitID("000000-00-0-001000");
			unit2.setUnitName("中国共产党江苏省委员会办公厅");
			unit2.setProcUUID("");
			receiveslist.add(unit2);
			unitInfo.setReceives(receiveslist);*/
			
			oA2ExchangerDataBean.setUnitInfo(unitInfo);
			
			//本节点Type = 60 时必须有，Item节点数等于StampNums节点的值
			OA2ExchangerDataBean.StampInfo stampInfo = new OA2ExchangerDataBean.StampInfo();
			
			oA2ExchangerDataBean.setStampInfo(stampInfo);
			
			// 本节点Type = 50或者Type = 60 时必须有
			OA2ExchangerDataBean.SndDstrbtInfo sndDstrbtInfo = new OA2ExchangerDataBean.SndDstrbtInfo();
			sndDstrbtInfo.setbTolNumCtrl("0");
			sndDstrbtInfo.setTotalPrnNum("0");
			sndDstrbtInfo.setCreateTime(DateUtil.getCurrentDateTime());
			
	        OA2ExchangerDataBean.SndDstrbtInfo.DetailXml  detailXml = new OA2ExchangerDataBean.SndDstrbtInfo.DetailXml();
			
	        /*ArrayList<OA2ExchangerDataBean.SndDstrbtInfo.DetailXml.TemplateMem> templateMemList = new ArrayList<OA2ExchangerDataBean.SndDstrbtInfo.DetailXml.TemplateMem>();
			//添加部门1
			OA2ExchangerDataBean.SndDstrbtInfo.DetailXml.TemplateMem  templateMem = new OA2ExchangerDataBean.SndDstrbtInfo.DetailXml.TemplateMem();
			templateMem.setPrnNums("5");
			templateMem.setRecvUnitID("000000-00-0-001000");
			templateMem.setRecvUnitName("中国共产党江苏省委员会办公厅");
			templateMem.setStartNum("");
			templateMem.setVersion("1.0");
			templateMemList.add(templateMem);*/
			
			detailXml.setTemplate(templateMemList);
			sndDstrbtInfo.setDetailXml(detailXml);
			oA2ExchangerDataBean.setSndDstrbtInfo(sndDstrbtInfo);
			
			//数据包，包括CEB文件，附件和元数据
			OA2ExchangerDataBean.DataPack dataPack = new OA2ExchangerDataBean.DataPack();
			//ceb插入
			OA2ExchangerDataBean.DataPack.CEBFile cEBFile = new OA2ExchangerDataBean.DataPack.CEBFile();
			/*1.将公文要素bean生成xml文件*/
			GwConstant gwConstant = new GwConstant();//公文传输常量
			String cebName = archiveDispatchBean.getRecordid()+".ceb"; //CEB文件名
			String ceb_path = gwConstant.tmp_zip_attch_path+File.separator+archiveDispatchBean.getIns_id()+File.separator+cebName;
			File cebFile = new File(ceb_path);
			byte[] cbeByte = FileUtil.getBytesFromFile(cebFile);
			cEBFile.setCEBContent(cbeByte);
			cEBFile.setCEBContentLength(cebFile.length()+"");
			cEBFile.setCEBFileName(cebName);
			cEBFile.setCEBFilePathNameInOA(ceb_path);
			dataPack.setCEBFile(cEBFile);
			//AttFiles插入
			List<OA2ExchangerDataBean.DataPack.Att> AttFiles = new ArrayList<OA2ExchangerDataBean.DataPack.Att>();
			List<String> attachmentFiles = new ArrayList<String>();
			if(!StringUtil.isBlank(archiveDispatchBean.getSend_attach_id())){//如果附件ID不为空,组装附件
				List<FileInfoBean> fileInfoBeanList = FileUtil.getFileByDjbh(archiveDispatchBean.getSend_attach_id());
				for(int i=0; i<fileInfoBeanList.size();i++){
					FileInfoBean fileInfoBean = fileInfoBeanList.get(i);
					OA2ExchangerDataBean.DataPack.Att att = new OA2ExchangerDataBean.DataPack.Att();
					att.setAttContent(fileInfoBean.getAttachcontent());
					att.setAttContentLength(fileInfoBean.getFilesize().trim());
					att.setAttFileName(fileInfoBean.getFilename().trim());
					att.setAttFilePathNameInOA(fileInfoBean.getFilepos().trim());
					attachmentFiles.add(fileInfoBean.getFilename().trim());
					AttFiles.add(att);
				}
			}
			dataPack.setAttFiles(AttFiles);
			
			//ArchMetaDatas插入
			OA2ExchangerDataBean.DataPack.ArchMetaDatas archMetaDatas = new OA2ExchangerDataBean.DataPack.ArchMetaDatas();
			OA2ExchangerDataBean.DataPack.ArchMetaDatas.ArchSechma  archSechma = new OA2ExchangerDataBean.DataPack.ArchMetaDatas.ArchSechma ();
			archSechma.setArchSerial(archiveDispatchBean.getArchive_no());
			archSechma.setArchFormTime(archiveDispatchBean.getCreate_date());
			archSechma.setExigenceLevel(archiveDispatchBean.getSecrecy_grade());
			archSechma.setSecretLevel("1");
			archSechma.setSecretYear(archiveDispatchBean.getEffect_date());
			archSechma.setArchTitle(archiveDispatchBean.getTitle());
			archSechma.setArchKeyWords(archiveDispatchBean.getKey_word());
			archSechma.setMainReceiver("主送单位-1");
			archSechma.setCopyReceiver("抄送单位-2、");
			archSechma.setDistributeLeader("签发领导-hlg");
			archSechma.setDistributeTime(archiveDispatchBean.getCreate_date());
			archSechma.setProcMan(archiveDispatchBean.getSender());
			archSechma.setContact("联系方式");
			archSechma.setArchRemark("发文说明");
			archSechma.setOADataID(archiveDispatchBean.getIns_id().trim());
			
			archSechma.setAttachmentFiles(attachmentFiles);
			archMetaDatas.setArchSechma(archSechma);
			dataPack.setArchMetaDatas(archMetaDatas);
			
			//barCodeAttribute插入
			OA2ExchangerDataBean.DataPack.BarCodeAttribute barCodeAttribute = new OA2ExchangerDataBean.DataPack.BarCodeAttribute();
			
			dataPack.setBarCodeAttribute(barCodeAttribute);
			
			oA2ExchangerDataBean.setDataPack(dataPack);
			
			OA2ExchangerDataBean.Mac mac = new OA2ExchangerDataBean.Mac();
			mac.setMacType("1");
			oA2ExchangerDataBean.setMac(mac);
			
			returnStr = service.sendToFZOA(oA2ExchangerDataBean,archiveDispatchBean);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnStr;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getUUID
	  * @param ins_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.archive.service.WordArchiveService#getUUID(java.lang.String) 
	  */
	@Override
	public String getUUID(String ins_id) {
		String uuid = "";
		WordArchiveDao dao = (WordArchiveDao)LoadSpringContext.getApplicationContext().getBean("wordArchiveDaoImpl");
		try {
			uuid = dao.getArchiveUUID(ins_id);
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
		}
		return uuid;
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 getTempActionId
	 * @param ins_id
	 * @return 
	 * @see com.chinacreator.xtbg.core.archive.service.WordArchiveService#getTempActionId(java.lang.String)
	 */
	@Override
	public String getTempActionId(String ins_id) {
		String uuid = "";
		WordArchiveDao dao = (WordArchiveDao)LoadSpringContext.getApplicationContext().getBean("wordArchiveDaoImpl");
		try {
			uuid = dao.getTempActionId(ins_id);
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
		}
		return uuid;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 updateGz
	  * @param gz
	  * @return 
	  * @see com.chinacreator.xtbg.core.archive.service.WordArchiveService#updateGz(java.lang.String)
	 */
	public boolean updateGz(String gz,String id) {
		WordArchiveDao dao = (WordArchiveDao)LoadSpringContext.getApplicationContext().getBean("wordArchiveDaoImpl");
		boolean mess=false;
		try {
			mess = dao.updateGz(gz, id);
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
		}
		return mess;
	}

	@Override
	public Map<String, String> copyAttachForNewFlow(Map<String,String> argMap) {
		Map<String,String> mess = new HashMap<String,String>();
		WordArchiveDao dao = (WordArchiveDao)LoadSpringContext.getApplicationContext().getBean("wordArchiveDaoImpl");
		try {
			mess = dao.copyAttachForNewFlow(argMap);
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
		}
		return mess;
	}
	/**
	 * 公文登记(来文登记)获得数据
	 * @param offDocRegId
	 * @param templateId
	 * @return Object[] [0]:文本数据(type:Map<String,String> like '1,2,3', '标题')
	 *                  [1]:附件数据(type:Map<String,String> like 'TABLE_ID__FJ_ID','UUID—code')
	 * @throws Exception
	 */
	@Override
	public Object[] getOfficialDocumentRegisterMess(
			String offDocRegId, String templateId,String mFilePath,String userId) throws Exception {
		if(templateId==null){
			return getOfficialDocumentRegisterMess(offDocRegId,mFilePath,userId);
		}
		Object[] messArr = new Object[2];
		//key(1,2,3) value(标题)
		Map<String, String> map = new HashMap<String,String>();
		//key(TABLE_ID__FJ_ID) value(UUID—code)
		Map<String, String> mapFJ = new HashMap<String,String>();
		String oldAttachId = null;
		Connection conn = null;
		try {
			//1
			conn = DbManager.getInstance().getTransactionConnection();
			WordArchiveDao dao = (WordArchiveDao)LoadSpringContext.getApplicationContext().getBean("wordArchiveDaoImpl");
			List<Map<String, String>> tmplList = dao.getTemplateList(templateId, conn);
			HashSet<String> tableSet = new HashSet<String>();
			HashMap<String,String> locationMap = new HashMap<String,String>();//检测模板位置是否重复绑定
			HashMap<String,String> locationMapT = new HashMap<String,String>();
			for (Map<String, String> obj : tmplList) {
				String table_cell = obj.get("table_cell");
				if(!StringUtil.nullOrBlank(table_cell)){
					tableSet.add(obj.get("data_come_from_table_id"));
					String tableAndCol = obj.get("data_come_from_table_id")+obj.get("data_come_from_column_id");
					
					if(locationMap.containsKey(table_cell)){
						LOG.info("公文登记:模板位置["+table_cell+"]被绑定多次,需要修改模板");
					}
					locationMapT.put(tableAndCol, table_cell);
					locationMap.put(table_cell, tableAndCol);
				}
				String textinput_value_type = obj.get("textinput_value_type");//配置附件的数据
				if("3".equals(textinput_value_type)){
					String tableAndCol = obj.get("data_come_from_table_id")+obj.get("data_come_from_column_id");
					if(mapFJ.containsKey(tableAndCol)){
						LOG.info("公文登记:公文字段["+tableAndCol+"]被绑定到配置附件上,需要修改模板");
					}else{
						mapFJ.put(tableAndCol,obj.get("table_id")+"__"+obj.get("column_id"));//附件只有一个,配置多个只处理第一个
					}
				}
			}
			for (String tableName : tableSet) {
				StringBuffer sql = new StringBuffer();
				sql.append("SELECT COL.COLUMN_NAME");
				sql.append("  FROM USER_CONSTRAINTS CON, USER_CONS_COLUMNS COL");
				sql.append(" WHERE CON.CONSTRAINT_NAME = COL.CONSTRAINT_NAME");
				sql.append("   AND CON.CONSTRAINT_TYPE = 'P'");
				sql.append("   AND COL.TABLE_NAME = ?");
				sql.append("   AND ROWNUM = '1'");
				Map<String,String> pk = dao.queryToSingleMap(sql.toString(), tableName);
				if(pk.containsKey("column_name")){
					sql = new StringBuffer();
					sql.append("SELECT * FROM "+tableName+" WHERE "+pk.get("column_name")+"=?");
					Map<String,String> dataMap = dao.queryToSingleMap(sql.toString(), offDocRegId);
					for (String colName : dataMap.keySet()) {
						String key = (tableName+colName).toUpperCase();
						if(locationMapT.containsKey(key)){
							map.put(locationMapT.get(key), dataMap.get(colName));
						}
						if(mapFJ.containsKey(key)){
							String tmp = dataMap.get(colName);
							if(tmp!=null&&tmp.length()>0){
								oldAttachId = tmp;
							}else{
								oldAttachId = "";
							}
						}
					}
				}
			}
			messArr[0] = map;
			//2
			if(mapFJ.size()==1){
				if(oldAttachId!=null){
					if(oldAttachId.length()>0){
						//2.1 复制 附件
						String newAttachId = dao.copyAttach(oldAttachId,mFilePath,userId,conn);
						if(newAttachId!=null){
							String key = mapFJ.keySet().iterator().next();
							String val = mapFJ.get(key);
							mapFJ.clear();
							mapFJ.put(val, newAttachId);
							messArr[1] = mapFJ;
						}else{
							LOG.info("公文登记:配置正确,原附件ID["+oldAttachId+"]存在,但无附件!");
						}
					}else{
						LOG.info("公文登记:配置正确,原公文附件ID不存在!");
					}
				}else{
					LOG.info("公文登记:配置过时!");
				}
			}else if(mapFJ.size()==0){
				LOG.info("公文登记:未配置附件!");
			}else{
				LOG.info("公文登记:未知错误!");
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
			DbManager.rollBackNoThrow(conn);
		}finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
	  return messArr;
	}

	/**
	 * form版公文登记
	 * 当前,无法配置 来文表 只能写死为 oa_gwreceive.GWRECEIVE_ID
	 * @param offDocRegId
	 * @param mFilePath
	 * @param userId
	 * @return
	 */
	private Object[] getOfficialDocumentRegisterMess(String offDocRegId,
			String mFilePath, String userId) {
		StringBuffer sql = new StringBuffer();
		String tableName = "oa_gwreceive";//表
		String colIdName = "gwreceive_id";//主键
		String attachColName= "attach_id";//附件
		String titleColName= "title";//标题
		Connection conn = null;
		Object[] messArr = new Object[1];
		try {
			//1
			conn = DbManager.getInstance().getTransactionConnection();
			
			sql.append("SELECT * FROM "+tableName+" WHERE "+colIdName+"=?");
			WordArchiveDao dao = (WordArchiveDao)LoadSpringContext.getApplicationContext().getBean("wordArchiveDaoImpl");
			Map<String,String> dataMap = dao.queryToSingleMap(sql.toString(), offDocRegId);
			
			Map<String, String> map = new HashMap<String,String>();
			//1复制标题
			map.put(FormserviceImpl.DRAG_IN_TITLE, dataMap.get(titleColName));
			//2复制附件
			String oldAttachId = dataMap.get(attachColName);
			if(oldAttachId!=null){
				if(oldAttachId.length()>0){
					//2.1 复制 附件
					String newAttachId = dao.copyAttach(oldAttachId,mFilePath,userId,conn);
					if(newAttachId!=null){
						map.put(FormserviceImpl.DRAG_IN_ATTACH, newAttachId);
					}else{
						LOG.info("公文登记:配置正确,原附件ID["+oldAttachId+"]存在,但无附件!");
					}
				}else{
					LOG.info("公文登记:配置正确,原公文附件ID不存在!");
				}
			}else{
				LOG.info("公文登记:配置过时!"+attachColName+"列不存在");
			}
			messArr[0]= map;
		}catch (Exception e) {
			LOG.error(e.getMessage(),e);
			DbManager.rollBackNoThrow(conn);
		}finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		return messArr;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getLastActByIns_id
	  * @param ins_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.archive.service.WordArchiveService#getLastActByIns_id(java.lang.String)
	 */
	@Override
	public String getLastActByIns_id(String ins_id) {
		String lastActId = "";
		WordArchiveDao dao = (WordArchiveDao)LoadSpringContext.getApplicationContext().getBean("wordArchiveDaoImpl");
		try {
			lastActId =  dao.getLastActByIns_id(ins_id,null);
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
		}
		return lastActId;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findSerialcode
	  * @param scode
	  * @param conn
	  * @return 
	  * @see com.chinacreator.xtbg.core.archive.service.WordArchiveService#findSerialcode(java.lang.String, java.sql.Connection)
	 */
	@Override
	public SerialNumberBean findSerialcode(String scode) {
		SerialNumberBean serialNumberBean = new SerialNumberBean();
		WordNumDefDao dao = (WordNumDefDao)LoadSpringContext.getApplicationContext().getBean("wordNumDefDaoImpl");
		try {
			serialNumberBean = dao.findSerialcode(scode, null);
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
		}
		return serialNumberBean;
	}
	
	/**
	*<b>Summary: </b>
	* deleteWordInfoByIds(删除纸质编号)
	* @param bus_ids
	* @param number_codes
	* @param bean
	* @return
	 */
	public String deleteWordInfoByIds(String[] bus_ids,String[] number_codes,OaWordNumberBean bean){
		Connection conn = null;
		String flag = "false";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			WordNumDefDao dao = (WordNumDefDao)LoadSpringContext.getApplicationContext().getBean("wordNumDefDaoImpl");
			for (int i = 0; i< bus_ids.length; i++) {
				String number_code = number_codes[i];
				String bus_id = bus_ids[i];
				//删除该节点以及子节点
				dao.deleteWordInfoByIds(bus_id, number_code, bean, conn);
			}
			conn.commit();
			flag = "true";
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
}
