package com.chinacreator.xtbg.pub.oagwcs.dao;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import org.apache.log4j.Logger;
import org.dom4j.Element;
import org.springframework.util.StringUtils;
import com.chinacreator.xtbg.pub.jqueryupload.utils.FileUtils;
import com.chinacreator.xtbg.pub.oagwcs.entity.GwSendBean;
import com.chinacreator.xtbg.pub.oagwcs.oa.service.SendArchiveRequestBean;
import com.chinacreator.xtbg.pub.oagwcs.service.util.GwConstant;
import com.chinacreator.xtbg.pub.oagwcs.service.util.PublicMethod;
import com.chinacreator.xtbg.pub.oagwcs.service.util.XmlBuilder;
import com.chinacreator.xtbg.pub.oagwcs.service.util.ZipUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;

/**
 * 公文发文类别的处理类 -- 抽象类
 * @author tian.xia
 *
 */
public abstract class SendGwDao extends GwDBDataGet {
	private static final Logger logger = Logger.getLogger(GwDBDataGet.class);
	protected final static String DOCFILETYPE = "doc";
	private GwSendBean gwSendBean = null;
	private String gwSendXmlPath = "";

	/**
	 * 根据sendId获取公文发文完整信息bean
	 * @param sendId
	 * @param user_id
	 * @return
	 */
	protected abstract void getGwSendInfoBySendId(String sendId,String user_id);
	
	
	
	/**
	 * 根据发文信息bean构造公文传输要素的xml文件
	 * @return
	 */
	protected void buildGwSendXml(){
		logger.info("gwSendBean==="+gwSendBean);
		if(null == gwSendBean)
			return;
		String url = GwConstant.ARCHIVE_PATH + "/" +GwConstant.ARCHIVE_XML;
		logger.info("url xml==="+url);
		XmlBuilder xBuilder = new XmlBuilder(url);

		xBuilder.addElement("archive");

		Element archive = xBuilder.getElement("archive");
		Element archiveparameters = archive.addElement("archiveparameters");
		archiveparameters.addElement("title").addText(gwSendBean.getTitle());
		Element num = archiveparameters.addElement("num");
		num.addElement("type").addText(gwSendBean.getNum_type());
		num.addElement("prefix").addText(gwSendBean.getPrefix());
		num.addElement("symbol").addText(gwSendBean.getSymbol());
		num.addElement("serial_number").addText(gwSendBean.getSerial_number());
		archiveparameters.addElement("secrecy_grade").addText(gwSendBean.getSecrecy_grade());
		archiveparameters.addElement("effect_date").addText(gwSendBean.getEffect_date());
		archiveparameters.addElement("urgency_grade").addText(gwSendBean.getUrgency_grade());
		archiveparameters.addElement("caption").addText(gwSendBean.getCaption());
		archiveparameters.addElement("keyword").addText(gwSendBean.getKeyword());
		archiveparameters.addElement("dispatch_type").addText(gwSendBean.getDispatch_type());
		archiveparameters.addElement("sender").addText(gwSendBean.getSender());
		archiveparameters.addElement("sendscope").addText(gwSendBean.getSendscope());
		archiveparameters.addElement("create_date").addText(gwSendBean.getCreate_date());
		archiveparameters.addElement("send_org_name").addText(gwSendBean.getSend_org_name());
		archiveparameters.addElement("send_org_addr").addText(gwSendBean.getSend_org_addr());
		archiveparameters.addElement("sendusername").addText(gwSendBean.getSendusername());
		archiveparameters.addElement("issign").addText(gwSendBean.getIssign());
		archiveparameters.addElement("file_type").addText(gwSendBean.getFile_type());
		archiveparameters.addElement("contact_phone").addText(gwSendBean.getContact_phone());
		archiveparameters.addElement("file_name").addText(gwSendBean.getFile_name());
		for(int i = 0 ; i < getAttachList().size() ; i ++){
			archiveparameters.addElement("affix"+(i+1)+"_name").addText(getAttachList().get(i).getFilename());
		}
		Element receivedeptinfor = archive.addElement("receivedeptinfor");
		ArrayList<?> addrinfors = (ArrayList<?>)gwSendBean.getAddrinfor();
		if(addrinfors.size()==0){
			Element addrinfor1 = receivedeptinfor.addElement("addrinfor");
			addrinfor1.addElement("receiveraddr").addText("");
			addrinfor1.addElement("receivername").addText("");
			addrinfor1.addElement("print_num").addText("");
			addrinfor1.addElement("num").addText("");
			addrinfor1.addElement("send_type").addText("");
		} else{
			for(int i=0;i<addrinfors.size();i++){
				Element addrinfor1 = receivedeptinfor.addElement("addrinfor");
				HashMap<String, String> map = (HashMap<String, String>)addrinfors.get(i);
				addrinfor1.addElement("receiveraddr").addText(StringUtil.deNull(map.get("receiveraddr")));
				addrinfor1.addElement("receivername").addText(StringUtil.deNull(map.get("receivername")));
				addrinfor1.addElement("print_num").addText(StringUtil.deNull(map.get("print_num")));
				addrinfor1.addElement("num").addText(StringUtil.deNull(map.get("num")));
				addrinfor1.addElement("send_type").addText(StringUtil.deNull(map.get("send_type")));
			}
		}

		xBuilder.writerXML(url);
		gwSendXmlPath = url;
	}
	
	/**
	 * 
	* @Title: createSendArchiveRequestBeanBySendId 
	* @Description: TODO(封装将要发送的发文请求bean，根据sendId) 
	* @param SendId
	* @param user_id
	* @return SendArchiveRequestBean 发文请求bean
	 */
	public SendArchiveRequestBean createSendArchiveRequestBeanBySendId(String SendId,String user_id){
		SendArchiveRequestBean sendArchiveRequestBean = new SendArchiveRequestBean();
		PublicMethod.deleteFile(GwConstant.ARCHIVE_PATH);
		logger.info("生成XML 文件路径:"+GwConstant.ARCHIVE_PATH);
		getGwSendInfoBySendId(SendId,user_id);//--step 1 获取发文信息bean
		showError("step 1 获取发文信息bean --sucess");
		try {
			getDocumentContent(getGwSendBean().getWordcontent_id(), getGwSendBean().getWordcontent_id());//step 2获取公文正文信息
			showError("step 2 获取公文正文信息  --sucess");
		} catch (SQLException e) {
			showError("step 2 获取公文正文信息报错！！\n"+e.getMessage());
		}
		try {
			getFileInfoBeanlist(getGwSendBean().getAttach_id());//step 3 获取附件信息集合
			showError("step 3 获取附件信息集合   --sucess");
		} catch (SQLException e) {
			showError("step 3 获取附件信息集合报错！！\n"+e.getMessage());
		}
		if(buildGwSendPath()){//构建公文发送的文件夹路径
			buildGwSendXml();//step 4 构建公文发文的公文要素 XML
			showError("step 4 构建公文发文的公文要素 XML --sucess");
			String[] gwSendXmlPath = {getGwSendXmlPath()};
			//step 5 生成附件文件和公文正文文件到指定路径
			String[] attachAndDocFilePath = getAttachAndDocSendFilePath(getDocumentContent(),getGwSendBean().getAttach_id());
			showError("step 5 生成附件文件和公文正文文件到指定路径  --sucess");
			ZipUtil zipUtil = new ZipUtil(ZipUtil.ENCODE_GBK);
			try {
				zipUtil.zipFile(GwConstant.ARCHIVE_ZIP_PATH, StringUtils.
				concatenateStringArrays(gwSendXmlPath,attachAndDocFilePath));// step 6 将 公文正文，附件，公文要素 压缩成zip文件
				showError("step 6 将 公文正文，附件，公文要素 压缩成zip文件   --sucess");
			} catch (IOException e) {
				showError("step 6 将 公文正文，附件，公文要素 压缩成zip文件报错！！\n"+e.getMessage());
			}
			byte[] zipType = {};
			try {
				zipType = FileUtils.getFileBytes(GwConstant.ARCHIVE_ZIP_PATH);//step 7 将zip文件转换成字节数组
			} catch (IOException e) {
				showError("step 7 将zip文件转换成字节数组报错！！\n"+e.getMessage());
			}
			//PublicMethod.deleteFile(GwConstant.OA_PATH);
			
			String[] files = new String[getAttachList().size()];
			for(int j = 0 ; j < getAttachList().size(); j ++){
				files[j] = getAttachList().get(j).getFilename();
			}
			sendArchiveRequestBean.setFileName(getGwSendBean().getWordcontent_id()+"."+DOCFILETYPE);
			sendArchiveRequestBean.setAffixName(files);
			sendArchiveRequestBean.setType("");
			sendArchiveRequestBean.setXmlName(GwConstant.ARCHIVE_XML);
			sendArchiveRequestBean.setDh(zipType);
		}else{
			showError("构建公文发送的文件夹路径失败\n");
		}
		
		
		
		return sendArchiveRequestBean;
		
	}
	private void showError(String error){
		logger.error(error);
	}


	protected String getGwSendXmlPath() {
		return gwSendXmlPath;
	}

	protected void setGwSendXmlPath(String gwSendXmlPath) {
		this.gwSendXmlPath = gwSendXmlPath;
	}

	protected GwSendBean getGwSendBean() {
		return gwSendBean;
	}

	protected void setGwSendBean(GwSendBean gwSendBean) {
		this.gwSendBean = gwSendBean;
	}



	

	
}
