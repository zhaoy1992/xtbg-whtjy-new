package com.chinacreator.xtbg.core.archive.cache;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.archive.dao.WordArchiveDao;
import com.chinacreator.xtbg.core.archive.entity.ArchiveDispatchBean;
import com.chinacreator.xtbg.core.archive.entity.OaWordNumberBean;
import com.chinacreator.xtbg.core.archive.gwcs.bean.ArchiveGwcsXmlBean;
import com.chinacreator.xtbg.core.archive.gwcs.bean.GwConstant;
import com.chinacreator.xtbg.core.archive.gwcs.bean.ArchiveGwcsXmlBean.Addrinfor;
import com.chinacreator.xtbg.core.archive.gwcs.bean.ArchiveGwcsXmlBean.Archiveparameters;
import com.chinacreator.xtbg.core.archive.gwcs.bean.ArchiveGwcsXmlBean.Sign;
import com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.SendResponseBean;
import com.chinacreator.xtbg.core.archive.gwcs.services.OaSendArchiveService;
import com.chinacreator.xtbg.core.archive.service.WordArchiveService;
import com.chinacreator.xtbg.core.archive.service.impl.WordArchiveServiceImpl;
import com.chinacreator.xtbg.core.common.cache.OASystemCache;
import com.chinacreator.xtbg.core.common.fancyuoload.entity.FileInfoBean;
import com.chinacreator.xtbg.core.common.util.BeanUtils;
import com.chinacreator.xtbg.core.common.util.FileUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;

/**
 * 
 *<p>Title:UnionArchiveFeedBackThread.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-12-4
 */
public class UnionArchiveSendCronTrigger{
	private static final Log LOG = LogFactory.getLog(UnionArchiveSendCronTrigger.class);
	private WordArchiveDao wordArchiveDaoImpl =  null;
	private OaSendArchiveService oaSendArchiveServiceImpl = null;
	private String oa_split_file_save_path = OASystemCache.getContextProperty("oa_split_file_save_path");
	
	private boolean sendused = false;//是否启动联合发文监控线程 默认为关闭
	
	public void setWordArchiveDaoImpl(WordArchiveDao wordArchiveDaoImpl) {
		this.wordArchiveDaoImpl = wordArchiveDaoImpl;
	}
	
	public void setSendused(boolean sendused) {
		this.sendused = sendused;
	}

	public void setOaSendArchiveServiceImpl(
			OaSendArchiveService oaSendArchiveServiceImpl) {
		this.oaSendArchiveServiceImpl = oaSendArchiveServiceImpl;
	}

	
	public UnionArchiveSendCronTrigger(){
		
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* sendAllArchive(将所有未发送的联合公文发送)
	* @return
	 */
	public boolean sendAllArchive(){
		if(sendused){//如果开启
				List<ArchiveDispatchBean> archiveDispatchBeanList = null;
				try {
					archiveDispatchBeanList = wordArchiveDaoImpl.getSendArchiveList();
				} catch (Exception e1) {
					LOG.error("获取待发送公文列表失败！",e1);
				}
				if(archiveDispatchBeanList!=null){
				
					for(int i=0; i<archiveDispatchBeanList.size();i++){
						ArchiveDispatchBean archiveDispatchBean = archiveDispatchBeanList.get(i);
						String buss_id = archiveDispatchBean.getUnion_archive_buss_id();
						try {
							Map<String,Object> dataMap = setArchiveGwcsXmlBean(archiveDispatchBean);
							ArchiveGwcsXmlBean archiveGwcsXmlBean = (ArchiveGwcsXmlBean) dataMap.get("archiveGwcsXmlBean");
							@SuppressWarnings("unchecked")
							List<String> affixpaths = (List<String>) dataMap.get("affixpaths");
							String[] affixpathArry = affixpaths.toArray(new String[affixpaths.size()]);
							
							if("指标文".equals(archiveDispatchBean.getDispatch_type())){
								String[] adressArr = archiveDispatchBean.getGwcs_address().split("#");
								for(int j=0; j<adressArr.length; j++){//循环一条记录
									//深克隆
									ArchiveGwcsXmlBean archiveGwcsXmlBeanCopy = BeanUtils.deepCopyBean(archiveGwcsXmlBean);
									List<String> affixnamesCopy = archiveGwcsXmlBeanCopy.getArchiveparameters().getAffixnames();
									List<String> affixpathsCopy = BeanUtils.deepCopyBean(affixpaths);
									List<Addrinfor> addrinfors = new ArrayList<Addrinfor>();
									String[] adressInfo = adressArr[j].split(",");
									if(adressInfo.length!=5){
										throw new Exception("解析地址出错，请确保指标文的地址格式传送正确！");
									}
									//插入地址信息
									Addrinfor addrinfor = new ArchiveGwcsXmlBean.Addrinfor();
									addrinfor.setReceiveraddr(adressInfo[0]);
									addrinfor.setReceivername(adressInfo[1]);
									addrinfor.setPrint_num(adressInfo[2]);
									addrinfor.setNum(adressInfo[3]);
									addrinfor.setSend_type("m");
									addrinfors.add(addrinfor);
									archiveGwcsXmlBeanCopy.setReceivedeptinfor(addrinfors);
									affixnamesCopy.add(FilenameUtils.getName(adressInfo[4]));//将指标文插入附件列表(XML)
									archiveGwcsXmlBeanCopy.getArchiveparameters().setAffixnames(affixnamesCopy);
									affixpathsCopy.add(oa_split_file_save_path+adressInfo[4]);//附件数组
									String[] affixpathArryCopy = affixpathsCopy.toArray(new String[affixpathsCopy.size()]);
									SendResponseBean responseBean = oaSendArchiveServiceImpl.doUnionArchiveToGwcs(archiveGwcsXmlBeanCopy,affixpathArryCopy,archiveDispatchBean.getUnion_archive_buss_id());
									if("1".equals(responseBean.getMessageid())){
										LOG.info("指标文联合公文发送成功！标题:"+archiveDispatchBean.getTitle());
									}
								}
								
							}else{
								SendResponseBean responseBean = oaSendArchiveServiceImpl.doUnionArchiveToGwcs(archiveGwcsXmlBean,affixpathArry,archiveDispatchBean.getUnion_archive_buss_id());
								if("1".equals(responseBean.getMessageid())){
									LOG.info("联合公文发送成功！标题:"+archiveDispatchBean.getTitle());
								}
							}
							
							
						} catch (Exception e) {
							LOG.error("联合公文发送失败"+archiveDispatchBean.getTitle()+buss_id,e);
						}
					}
				}
		}
		return true;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* sendArchive(请用一句话描述这个方法的作用)
	* @param archive_returnid 上传正文公文传输返回的唯一UUID
	* @return
	 */
	public boolean sendArchive(String archive_returnid){
		if(sendused){//如果开启
				ArchiveDispatchBean archiveDispatchBean = null;
				try {
					archiveDispatchBean= wordArchiveDaoImpl.getArchiveDispatch(archive_returnid,null);
				} catch (Exception e1) {
					LOG.error("获取待发送公文列表失败！",e1);
				}
				if(archiveDispatchBean!=null){
					String buss_id = archiveDispatchBean.getUnion_archive_buss_id();
					try {
						Map<String,Object> dataMap = setArchiveGwcsXmlBean(archiveDispatchBean);
						ArchiveGwcsXmlBean archiveGwcsXmlBean = (ArchiveGwcsXmlBean) dataMap.get("archiveGwcsXmlBean");
						@SuppressWarnings("unchecked")
						List<String> affixpaths = (List<String>) dataMap.get("affixpaths");
						String[] affixpathArry = affixpaths.toArray(new String[affixpaths.size()]);
						if("指标文".equals(archiveDispatchBean.getDispatch_type())){
							String[] adressArr = archiveDispatchBean.getGwcs_address().split("#");
							for(int j=0; j<adressArr.length; j++){//循环一条记录
								//深克隆
								ArchiveGwcsXmlBean archiveGwcsXmlBeanCopy = BeanUtils.deepCopyBean(archiveGwcsXmlBean);
								List<String> affixnamesCopy = archiveGwcsXmlBeanCopy.getArchiveparameters().getAffixnames();
								List<String> affixpathsCopy = BeanUtils.deepCopyBean(affixpaths);
								List<Addrinfor> addrinfors = new ArrayList<Addrinfor>();
								String[] adressInfo = adressArr[j].split(",");
								if(adressInfo.length!=5){
									throw new Exception("解析地址出错，请确保指标文的地址格式传送正确！");
								}
								//插入地址信息
								Addrinfor addrinfor = new ArchiveGwcsXmlBean.Addrinfor();
								addrinfor.setReceiveraddr(adressInfo[0]);
								addrinfor.setReceivername(adressInfo[1]);
								addrinfor.setPrint_num(adressInfo[2]);
								addrinfor.setNum(adressInfo[3]);
								addrinfor.setSend_type("m");
								addrinfors.add(addrinfor);
								archiveGwcsXmlBeanCopy.setReceivedeptinfor(addrinfors);
								affixnamesCopy.add(FilenameUtils.getName(adressInfo[4]));//将指标文插入附件列表(XML)
								archiveGwcsXmlBeanCopy.getArchiveparameters().setAffixnames(affixnamesCopy);
								affixpathsCopy.add(oa_split_file_save_path+adressInfo[4]);//附件数组
								String[] affixpathArryCopy = affixpathsCopy.toArray(new String[affixpathsCopy.size()]);
								SendResponseBean responseBean = oaSendArchiveServiceImpl.doUnionArchiveToGwcs(archiveGwcsXmlBeanCopy,affixpathArryCopy,archiveDispatchBean.getUnion_archive_buss_id());
								if("1".equals(responseBean.getMessageid())){
									LOG.info("指标文联合公文发送成功！标题:"+archiveDispatchBean.getTitle());
								}
							}
							
						}else{
							SendResponseBean responseBean = oaSendArchiveServiceImpl.doUnionArchiveToGwcs(archiveGwcsXmlBean,affixpathArry,archiveDispatchBean.getUnion_archive_buss_id());
							if("1".equals(responseBean.getMessageid())){
								LOG.info("联合公文发送成功！标题:"+archiveDispatchBean.getTitle());
							}
						}
					
						
					} catch (Exception e) {
						LOG.error("联合公文发送失败"+archiveDispatchBean.getTitle()+buss_id,e);
					}
				}
		}
		return true;
	}
	/**
	 * 
	*<b>Summary: </b>
	* setArchiveGwcsXmlBean(根据公文要素组装发送公文传输BEAN)
	* @param archiveDispatchBean
	* @return
	* @throws Exception
	 */
	private Map<String,Object> setArchiveGwcsXmlBean(ArchiveDispatchBean archiveDispatchBean) throws Exception {
		Map<String,Object> dataMap = new HashMap<String,Object>();
		ArchiveGwcsXmlBean archiveGwcsXmlBean = new ArchiveGwcsXmlBean();
		Archiveparameters archiveparameters = new ArchiveGwcsXmlBean.Archiveparameters();
		ArchiveGwcsXmlBean.Archiveparameters.Num num = new ArchiveGwcsXmlBean.Archiveparameters.Num();
		List<String> affixpaths = new ArrayList<String>();
			//正文
			GwConstant gwConstant = new GwConstant();//公文传输常量
			String filePath = gwConstant.tmp_zip_attch_path+File.separator+archiveDispatchBean.getIns_id()+File.separator;
			
			//装填archiveparameters
			archiveparameters.setTitle(archiveDispatchBean.getTitle());
			
			WordArchiveService wservice = new WordArchiveServiceImpl();//读取文号信息
			OaWordNumberBean oaWordNumberBean = wservice.getNumber(archiveDispatchBean.getBusi_id());
			num.setType("2");
			num.setPrefix(oaWordNumberBean.getNumber_type());
			num.setSymbol("〔"+oaWordNumberBean.getNumber_year()+"〕");
			num.setSerial_number(oaWordNumberBean.getNumber_code()+"号");
			archiveparameters.setNum(num);
			
			archiveparameters.setSecrecy_grade(archiveDispatchBean.getSecrecy_grade());
			archiveparameters.setEffect_date(archiveDispatchBean.getEffect_date());
			archiveparameters.setUrgency_grade(archiveDispatchBean.getUrgency_grade());
			archiveparameters.setCaption(archiveDispatchBean.getCaption());
			archiveparameters.setKeyword(archiveDispatchBean.getKey_word());
			archiveparameters.setDispatch_type(archiveDispatchBean.getDispatch_type());
			archiveparameters.setSender(archiveDispatchBean.getSender());
			archiveparameters.setSendscope("公开发布");
			archiveparameters.setCreate_date(archiveDispatchBean.getCreate_date());
			archiveparameters.setSend_org_name(archiveDispatchBean.getSend_org_name());
			archiveparameters.setSend_org_addr(archiveDispatchBean.getSend_org_addr());
			archiveparameters.setSendusername(archiveDispatchBean.getSender());
			
			archiveparameters.setContact_phone("");
			archiveparameters.setMsg(archiveDispatchBean.getMsg_txt());
			archiveparameters.setUnionmsg(archiveDispatchBean.getUnion_archive_msg());
			archiveparameters.setIssign("unionsign");//如果是联合发文。(重要！)
			archiveparameters.setIssign("true");
			archiveparameters.setFile_name(archiveDispatchBean.getArchive_returnid());
			archiveparameters.setFile_type("ceb");
	
			List<String> affixnames = new ArrayList<String>();
			//附件信息
			if(!StringUtil.isBlank(archiveDispatchBean.getSend_attach_id())&& "1".equals(archiveDispatchBean.getIs_sned_attach())){//如果附件ID不为空,组装附件
				List<FileInfoBean> fileInfoBeanList = FileUtil.getFileByDjbh(archiveDispatchBean.getSend_attach_id());
				for(int i=0; i<fileInfoBeanList.size();i++){
					affixnames.add(fileInfoBeanList.get(i).getFilename().trim());
					affixpaths.add(filePath+fileInfoBeanList.get(i).getFilename().trim());
				}
			}
			archiveparameters.setAffixnames(affixnames);
			
			List<Addrinfor> addrinfors = new ArrayList<Addrinfor>();
			//装填地址信息
			String[] adressArr = archiveDispatchBean.getGwcs_address().split("#");
			for(int i=0; i<adressArr.length; i++){//循环一条记录
				if(!StringUtil.isBlank(adressArr[i])){
					String[] adressInfo = adressArr[i].split(",");
					if(adressInfo.length!=4 && adressInfo.length!=5){
						throw new Exception("解析地址出错，请确保发文的地址格式传送正确！");
					}
					Addrinfor addrinfor = new ArchiveGwcsXmlBean.Addrinfor();
					addrinfor.setReceiveraddr(adressInfo[0]);
					addrinfor.setReceivername(adressInfo[1]);
					addrinfor.setPrint_num(adressInfo[2]);
					addrinfor.setNum(adressInfo[3]);
					addrinfor.setSend_type("m");
					addrinfors.add(addrinfor);
				}
			}
			
			List<Sign> signs  = new ArrayList<Sign>();
			if(!StringUtil.isBlank(archiveDispatchBean.getUnion_archive_addr())){//如果是联合发文。
				String[] signsStr = archiveDispatchBean.getUnion_archive_addr().split("#");
				
				for(int i=0; i<signsStr.length; i++){//循环一条记录
					String[] signStr = signsStr[i].split(",");
					if(signStr.length!=3){
						throw new Exception("解析联合发文地址出错，请确保联合发文的地址格式传送正确！");
					}
					Sign sign = new Sign();
					sign.setOrgaddr(signStr[0]);
					sign.setOrgname(signStr[1]);
					sign.setSignorder(signStr[2]);
					signs.add(sign);
				}
			}
			archiveGwcsXmlBean.setReceivedeptinfor(addrinfors);
			archiveGwcsXmlBean.setArchiveparameters(archiveparameters);
			archiveGwcsXmlBean.setSigns(signs);
			
			dataMap.put("archiveGwcsXmlBean", archiveGwcsXmlBean);
			dataMap.put("affixpaths", affixpaths);
			return dataMap;
	}
	
}
