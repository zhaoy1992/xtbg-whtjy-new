package com.chinacreator.xtbg.core.archive.cache;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.archive.entity.ArchiveDispatchBean;
import com.chinacreator.xtbg.core.archive.entity.OaWordNumberBean;
import com.chinacreator.xtbg.core.archive.gwcs.bean.ArchiveGwcsXmlBean;
import com.chinacreator.xtbg.core.archive.gwcs.bean.ArchiveGwcsXmlBean.Addrinfor;
import com.chinacreator.xtbg.core.archive.gwcs.bean.ArchiveGwcsXmlBean.Archiveparameters;
import com.chinacreator.xtbg.core.archive.gwcs.bean.ArchiveGwcsXmlBean.Sign;
import com.chinacreator.xtbg.core.archive.gwcs.bean.GwConstant;
import com.chinacreator.xtbg.core.archive.gwcs.services.OaSendArchiveService;
import com.chinacreator.xtbg.core.archive.service.WordArchiveService;
import com.chinacreator.xtbg.core.archive.service.impl.WordArchiveServiceImpl;
import com.chinacreator.xtbg.core.common.fancyuoload.entity.FileInfoBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.FileUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;

/**
 * 
 *<p>Title:SendUnionArchiveThread.java</p>
 *<p>Description:联合发文线程，启动联合发文发送</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-12-5
 */
public class SendUnionArchiveThread extends Thread{
	
	private Object lock = new Object();
	
	private static final Log LOG = LogFactory.getLog(SendUnionArchiveThread.class);
	
	
	private OaSendArchiveService service = (OaSendArchiveService)LoadSpringContext.getApplicationContext().getBean("oaSendArchiveServiceImpl");
	private Archiveparameters archiveparameters; //公文要素
	private String addStr;//地址信息
	private String uuid; //公文UUID
	private List<String> affixpaths; //附件列表
	private ArchiveDispatchBean archiveDispatchBean; //公文要素BEAN
	private String union_archive_addr;//联合发文地址
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     构造一个 SendArchiveThread  
	   * <b>Remarks:将公文要素，地址信息构造 </b>
	  *     构造类 SendArchiveThread 的构造函数 SendArchiveThread
	  * @param archiveparameters
	  * @param addStr
	 */
	@SuppressWarnings("unchecked")
	public SendUnionArchiveThread(ArchiveDispatchBean archiveDispatchBean){
		this.archiveDispatchBean = archiveDispatchBean;
		this.addStr = archiveDispatchBean.getGwcs_address();
		this.uuid = archiveDispatchBean.getArchive_returnid();
		this.archiveparameters = (Archiveparameters) setsArchiveparameters().get("archiveparameters");
		this.affixpaths = (List<String>) setsArchiveparameters().get("affixpaths");
		this.union_archive_addr = archiveDispatchBean.getUnion_archive_addr();
	}
	
	public void run() {
		if (archiveparameters!=null && addStr!= null) {	
			LOG.info(archiveparameters.getTitle()+"联合盖章线程启动成功。");
			synchronized (lock) {
			String[] adressArr = addStr.split("#");
			try {
				ArchiveGwcsXmlBean archiveGwcsXmlBean = new ArchiveGwcsXmlBean();
				List<Addrinfor> addrinfors = new ArrayList<Addrinfor>();
				
				//装填receivedeptinfor
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
					String[] signsStr = union_archive_addr.split("#");
					
					for(int i=0; i<signsStr.length; i++){//循环一条记录
						String[] signStr = signsStr[i].split(",");
						if(signStr.length!=3){
							throw new Exception("解析联合盖章地址出错，请确保联合发文的地址格式传送正确！");
						}
						Sign sign = new Sign();
						sign.setOrgaddr(signStr[0]);
						sign.setOrgname(signStr[1]);
						sign.setSignorder(signStr[2]);
						signs.add(sign);
					}
				
				archiveGwcsXmlBean.setReceivedeptinfor(addrinfors);
				archiveGwcsXmlBean.setArchiveparameters(archiveparameters);
				archiveGwcsXmlBean.setSigns(signs);
				
				//附件
				String[] affixpathArry = affixpaths.toArray(new String[affixpaths.size()]); 
				String returnStr = service.callUnionArchiveSend(archiveGwcsXmlBean, affixpathArry,uuid);
				if("RES000".equals(returnStr)){
					LOG.info(archiveparameters.getTitle()+"联合盖章成功。");
					//dao.UpdateAdressSendByInsID(archiveDispatchBean.getIns_id());//将发文地址薄的发送状态改为1
				}else{
					LOG.info(archiveparameters.getTitle()+"联合盖章失败。"+returnStr);
				}
			} catch (Exception e) {
				LOG.error(archiveparameters.getTitle()+"联合盖章成失败。",e);
			}
				
			}
		} else {
			LOG.info("无法正确的获取联合盖章初始化数据！");
		}
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* setsArchiveparameters(获取参数)
	* @return
	 */
	private Map<String,Object> setsArchiveparameters() {
		Map<String,Object> dateMap = new HashMap<String,Object>();
		Archiveparameters archiveparameters = new ArchiveGwcsXmlBean.Archiveparameters();
		ArchiveGwcsXmlBean.Archiveparameters.Num num = new ArchiveGwcsXmlBean.Archiveparameters.Num();
		List<String> affixpaths = new ArrayList<String>();
		try {	
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
			archiveparameters.setIssign("unionsign");
			archiveparameters.setFile_name(uuid);
			archiveparameters.setFile_type("ceb");
	
			List<String> affixnames = new ArrayList<String>();
			if(!StringUtil.isBlank(archiveDispatchBean.getSend_attach_id())&& "1".equals(archiveDispatchBean.getIs_sned_attach())){//如果附件ID不为空,组装附件
				List<FileInfoBean> fileInfoBeanList = FileUtil.getFileByDjbh(archiveDispatchBean.getSend_attach_id());
				for(int i=0; i<fileInfoBeanList.size();i++){
					affixnames.add(fileInfoBeanList.get(i).getFilename().trim());
					affixpaths.add(filePath+fileInfoBeanList.get(i).getFilename().trim());
				}
			}
			archiveparameters.setAffixnames(affixnames);
		} catch (Exception e) {
			LOG.error(archiveparameters.getTitle()+"组装公文要素失败。",e);
		}
		dateMap.put("archiveparameters", archiveparameters);
		dateMap.put("affixpaths", affixpaths);
		return dateMap;
	}

}
