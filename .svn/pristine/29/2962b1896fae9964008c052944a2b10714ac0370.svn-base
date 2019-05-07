package com.chinacreator.xtbg.core.archive.gwcs.services.impl;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.Reader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.archive.dao.WordArchiveDao;
import com.chinacreator.xtbg.core.archive.entity.ArchiveDispatchBean;
import com.chinacreator.xtbg.core.archive.gwcs.bean.ArchiveGwcsXmlBean;
import com.chinacreator.xtbg.core.archive.gwcs.bean.ArchiveGwcsXmlBean.Sign;
import com.chinacreator.xtbg.core.archive.gwcs.bean.GwConstant;
import com.chinacreator.xtbg.core.archive.gwcs.bean.OA2ExchangerDataBean;
import com.chinacreator.xtbg.core.archive.gwcs.client.ArchiveClientCallGWCSService;
import com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.SendArchiveRequestBean;
import com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.SendArchiveResponseBean;
import com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.SendRequestBean;
import com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.SendResponseBean;
import com.chinacreator.gwcs.oa.service.UnionArchiveResponseBean;
import com.chinacreator.xtbg.core.archive.gwcs.services.OaArchiveHandlerIfc;
import com.chinacreator.xtbg.core.archive.gwcs.services.OaSendArchiveService;
import com.chinacreator.xtbg.core.common.cache.OASystemCache;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.FileUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.common.util.XmlDeclarationXStream;
import com.chinacreator.xtbg.core.common.util.ZipUtil;
import com.thoughtworks.xstream.io.xml.DomDriver;
import com.thoughtworks.xstream.io.xml.XmlFriendlyNameCoder;
/**
 *<p>Title:GwcsOrgSynServiceImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-7-22
 */

public class OaSendArchiveServiceImpl implements OaSendArchiveService {
	
	private static final Log LOG = LogFactory.getLog(OaSendArchiveServiceImpl.class);
	private GwConstant gwConstant = new GwConstant();//公文传输常量

	private OaArchiveHandlerIfc oaArchiveHandlerIfc = null;//oa对于公文传输数据的处理接口
	
	private ArchiveClientCallGWCSService archiveClientCallGWCS = null;//oa发送给公文传输数据的调用接口

	public void setGwConstant(GwConstant gwConstant) {
		this.gwConstant = gwConstant;
	}

	public OaArchiveHandlerIfc getOaArchiveHandlerIfc() {
		return oaArchiveHandlerIfc;
	}

	public void setOaArchiveHandlerIfc(OaArchiveHandlerIfc oaArchiveHandlerIfc) {
		this.oaArchiveHandlerIfc = oaArchiveHandlerIfc;
	}

	/**
	 * <b>Summary: </b>
	 *     获取archiveClientCallGWCS的值
	 * @return archiveClientCallGWCS 
	 */
	public ArchiveClientCallGWCSService getArchiveClientCallGWCS() {
		return archiveClientCallGWCS;
	}


	/** 
	 * <b>Summary: </b>
	 *     设置 archiveClientCallGWCS 的值 
	 * @param archiveClientCallGWCS 
	 */
	public void setArchiveClientCallGWCS(
			ArchiveClientCallGWCSService archiveClientCallGWCS) {
		this.archiveClientCallGWCS = archiveClientCallGWCS;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 callArchiveSendCeb
	  * @param send_id
	  * @param receiveGwcsXmlBean
	  * @param affixpath
	  * @return 
	 * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.gwcs.services.OaArchiveWebService#callArchiveSendCeb(java.lang.String, com.chinacreator.xtbg.core.archive.gwcs.bean.ReceiveGwcsXmlBean, java.lang.String[])
	 */
	public String callArchiveSendCeb(String[] textpathArry,ArchiveGwcsXmlBean archiveGwcsXmlBean, String[] affixpaths) throws Exception {
		LOG.info("--公文上传!start--");
		
		String xmlName = gwConstant.archive_xml;
		String[] affixName = new String[affixpaths.length];
		List<String> zipFileList = new ArrayList<String>();
		byte[] zipFileBytes = null;
		
		//将xmlbean生成为xml文件
		XmlDeclarationXStream xstream = new XmlDeclarationXStream(new DomDriver("gbk",new XmlFriendlyNameCoder("-_", "_")));
		xstream.setVersion("1.0");
		xstream.setEcoding("gbk");
		xstream.alias("archive", ArchiveGwcsXmlBean.class);
		xstream.alias("num", ArchiveGwcsXmlBean.Archiveparameters.Num.class);
		xstream.alias("affixname", String.class);
		xstream.alias("addrinfor", ArchiveGwcsXmlBean.Addrinfor.class);
		
		OutputStream outputStream;
		
		/*1.将公文要素bean生成xml文件*/
		String temp_xml_path = gwConstant.tmp_zip_dir+xmlName;
		File tempXmlFile = new File(temp_xml_path);
		File tmp_zip_dir = new File(gwConstant.tmp_zip_dir);
		tmp_zip_dir.delete();
		if(!tmp_zip_dir.exists() ){
			tmp_zip_dir.mkdir();
			tempXmlFile.createNewFile();
		}
		outputStream = new FileOutputStream(tempXmlFile);
		xstream.toXML(archiveGwcsXmlBean, outputStream);
		zipFileList.add(temp_xml_path);
		
		/*2.将附件解压到指定路径下*/
		for(int i = 0 , j = 0; i <= affixpaths.length-1 ; i ++){
			File affixFile = new File(affixpaths[i]);
			//将附件复制到指定组装路径
			if(affixFile.exists()){
				String temp_affix_path = gwConstant.tmp_zip_dir+affixFile.getName();
				File movedAffixFile = new File(temp_affix_path);
				FileUtils.copyFile(affixFile, movedAffixFile);
				zipFileList.add(temp_affix_path);
				affixName[j] = movedAffixFile.getName();
				j++;
			}
		}
		
		if(textpathArry!=null){//正文添加
			File affixFile = new File(textpathArry[1]);
			//将附件复制到指定组装路径
			if(affixFile.exists()){
				String temp_affix_path = gwConstant.tmp_zip_dir+affixFile.getName();
				File movedAffixFile = new File(temp_affix_path);
				FileUtils.copyFile(affixFile, movedAffixFile);
				zipFileList.add(temp_affix_path);
			}
		}
		
		/*3.压缩公文要素xml和附件文件*/
		ZipUtil zipUtil = new ZipUtil();
		zipUtil.setEncode(ZipUtil.ENCODE_GBK);
		zipUtil.zipFile(gwConstant.tmp_zip_path, zipFileList.toArray(new String[zipFileList.size()]));
		
		/*4.转换公文压缩文件为byte数组*/
		File zipFile = new File(gwConstant.tmp_zip_path);
		
		zipFileBytes = FileUtil.getBytesFromFile(zipFile);
		SendArchiveRequestBean requestBean = new SendArchiveRequestBean();
		
		requestBean.setFileName(textpathArry[0]);
		requestBean.setXmlName(xmlName);
		requestBean.setAffixName(affixName);
		requestBean.setType("");
		requestBean.setDh(zipFileBytes);
		SendArchiveResponseBean responseBean = archiveClientCallGWCS.callArchiveToGwcs(requestBean);
		
		LOG.info("--公文上传!end--"+("RES000".equals(responseBean.getMessageid())?"成功！":"失败！"));
		if(!"RES000".equals(responseBean.getMessageid())){
			LOG.info("businessid:"+responseBean.getBusinessid());
			LOG.info("summary:"+responseBean.getSummary());
			LOG.info("excepiton:"+responseBean.getException());
		}
		return responseBean.getMessageid();
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 callArchiveSend
	  * @param send_id
	  * @param receiveGwcsXmlBean
	  * @param affixpath
	  * @return 
	 * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.gwcs.services.OaArchiveWebService#callArchiveSend(java.lang.String, com.chinacreator.xtbg.core.archive.gwcs.bean.ReceiveGwcsXmlBean, java.lang.String[])
	 */
	public String callArchiveSend(ArchiveGwcsXmlBean archiveGwcsXmlBean, String[] affixpaths,String uuid) throws Exception {
		LOG.info("--公文上传!start--");
		
		String xmlName = gwConstant.archive_xml;
		String[] affixName = new String[affixpaths.length];
		List<String> zipFileList = new ArrayList<String>();
		byte[] zipFileBytes = null;
		
		
		//将xmlbean生成为xml文件
		XmlDeclarationXStream xstream = new XmlDeclarationXStream(new DomDriver("gbk",new XmlFriendlyNameCoder("-_", "_")));
		xstream.setVersion("1.0");
		xstream.setEcoding("gbk");
		xstream.alias("archive", ArchiveGwcsXmlBean.class);
		xstream.alias("num", ArchiveGwcsXmlBean.Archiveparameters.Num.class);
		xstream.alias("affixname", String.class);
		xstream.alias("addrinfor", ArchiveGwcsXmlBean.Addrinfor.class);
		
		
		
		OutputStream outputStream;
		
		/*1.将公文要素bean生成xml文件*/
		String temp_xml_path = gwConstant.tmp_zip_dir+xmlName;
		File tempXmlFile = new File(temp_xml_path);
		File tmp_zip_dir = new File(gwConstant.tmp_zip_dir);
		tmp_zip_dir.delete();
		if(!tmp_zip_dir.exists() ){
			tmp_zip_dir.mkdir();
			tempXmlFile.createNewFile();
		}
		outputStream = new FileOutputStream(tempXmlFile);
		xstream.toXML(archiveGwcsXmlBean, outputStream);
		zipFileList.add(temp_xml_path);
		
		/*2.将附件解压到指定路径下*/
		for(int i = 0 , j = 0; i <= affixpaths.length-1 ; i ++){
			File affixFile = new File(affixpaths[i]);
			//将附件复制到指定组装路径
			if(affixFile.exists()){
				String temp_affix_path = gwConstant.tmp_zip_dir+affixFile.getName();
				File movedAffixFile = new File(temp_affix_path);
				FileUtils.copyFile(affixFile, movedAffixFile);
				zipFileList.add(temp_affix_path);
				affixName[j] = movedAffixFile.getName();
				j++;
			}
		}
		
		/*3.压缩公文要素xml和附件文件*/
		ZipUtil zipUtil = new ZipUtil();
		zipUtil.setEncode(ZipUtil.ENCODE_GBK);
		zipUtil.zipFile(gwConstant.tmp_zip_path, zipFileList.toArray(new String[zipFileList.size()]));
		
		/*4.转换公文压缩文件为byte数组*/
		File zipFile = new File(gwConstant.tmp_zip_path);
		
		zipFileBytes = FileUtil.getBytesFromFile(zipFile);
		SendRequestBean requestBean = new SendRequestBean();
		
		requestBean.setId(uuid);
		requestBean.setXmlName(xmlName);
		requestBean.setAffixName(affixName);
		requestBean.setType("");
		requestBean.setDh(zipFileBytes);
		SendResponseBean responseBean = archiveClientCallGWCS.callArchiveSend(requestBean);
		
		LOG.info("--公文上传!end--"+("RES000".equals(responseBean.getMessageid())?"成功！":"失败！"));
		if(!"RES000".equals(responseBean.getMessageid())){
			LOG.info("businessid:"+responseBean.getBusinessid());
			LOG.info("summary:"+responseBean.getSummary());
			LOG.info("excepiton:"+responseBean.getException());
		}else{
			WordArchiveDao dao = (WordArchiveDao)LoadSpringContext.getApplicationContext().getBean("wordArchiveDaoImpl");
			boolean flag =dao.updateIsSendByBussId(uuid,"archive_returnid");//将公文要素表的是否发送至为是”1“。
			if(flag){
				LOG.info("公文发送成功，公文返回ID："+uuid);
			}
		}
		return responseBean.getMessageid();
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 sendToFZOA
	  * @param oA2ExchangerDataBean
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.gwcs.services.OaArchiveWebService#sendToFZOA(com.chinacreator.xtbg.core.archive.gwcs.bean.OA2ExchangerDataBean) 
	  */
	@Override
	public String sendToFZOA(OA2ExchangerDataBean oA2ExchangerDataBean,ArchiveDispatchBean archiveDispatchBean)throws Exception {
		LOG.info("--方正公文上传!start--");
		String ins_id = archiveDispatchBean.getIns_id();
		String xmlName = gwConstant.archive_xml;
		
		//将xmlbean生成为xml文件
		XmlDeclarationXStream xstream = new XmlDeclarationXStream(new DomDriver("gbk",new XmlFriendlyNameCoder("-_", "_")));
		xstream.setVersion("1.0");
		xstream.setEcoding("gbk");
		xstream.alias("OA2ExchangerData", OA2ExchangerDataBean.class);
		xstream.alias("Message", OA2ExchangerDataBean.Message.class);
		
		xstream.alias("UnitInfo", OA2ExchangerDataBean.UnitInfo.class);
		xstream.alias("Sends", List.class);
		xstream.alias("Unit", OA2ExchangerDataBean.UnitInfo.Unit.class);
		xstream.useAttributeFor(OA2ExchangerDataBean.UnitInfo.Unit.class, "UnitID");
		xstream.useAttributeFor(OA2ExchangerDataBean.UnitInfo.Unit.class, "UnitName");
		xstream.useAttributeFor(OA2ExchangerDataBean.UnitInfo.Unit.class, "ProcUUID");
		
		xstream.alias("Unites", List.class);
		xstream.alias("Unit", OA2ExchangerDataBean.UnitInfo.Unit.class);
		xstream.useAttributeFor(OA2ExchangerDataBean.UnitInfo.Unit.class, "UnitID");
		xstream.useAttributeFor(OA2ExchangerDataBean.UnitInfo.Unit.class, "UnitName");
		xstream.useAttributeFor(OA2ExchangerDataBean.UnitInfo.Unit.class, "ProcUUID");
		
		xstream.alias("Receives", List.class);
		xstream.alias("Unit", OA2ExchangerDataBean.UnitInfo.Unit.class);
		xstream.useAttributeFor(OA2ExchangerDataBean.UnitInfo.Unit.class, "UnitID");
		xstream.useAttributeFor(OA2ExchangerDataBean.UnitInfo.Unit.class, "UnitName");
		xstream.useAttributeFor(OA2ExchangerDataBean.UnitInfo.Unit.class, "ProcUUID");
		
		
		xstream.alias("StampInfo", OA2ExchangerDataBean.StampInfo.class);
		
		xstream.alias("Item", OA2ExchangerDataBean.StampInfo.Item.class);

		xstream.alias("SndDstrbtInfo", OA2ExchangerDataBean.SndDstrbtInfo.class);
		xstream.alias("DetailXml", OA2ExchangerDataBean.SndDstrbtInfo.DetailXml.class);
		xstream.alias("Template", List.class);
		xstream.useAttributeFor( OA2ExchangerDataBean.SndDstrbtInfo.DetailXml.TemplateMem.class, "version");
		xstream.alias("TemplateMem", OA2ExchangerDataBean.SndDstrbtInfo.DetailXml.TemplateMem.class);
		xstream.useAttributeFor(OA2ExchangerDataBean.SndDstrbtInfo.DetailXml.TemplateMem.class, "RecvUnitID");
		xstream.useAttributeFor(OA2ExchangerDataBean.SndDstrbtInfo.DetailXml.TemplateMem.class, "RecvUnitName");
		xstream.useAttributeFor(OA2ExchangerDataBean.SndDstrbtInfo.DetailXml.TemplateMem.class, "PrnNums");
		xstream.useAttributeFor(OA2ExchangerDataBean.SndDstrbtInfo.DetailXml.TemplateMem.class, "StartNum");
		
		xstream.alias("DataPack", OA2ExchangerDataBean.DataPack.class);
		xstream.alias("CEBFile", OA2ExchangerDataBean.DataPack.CEBFile.class);
		xstream.alias("AttFiles", List.class);
		xstream.alias("Att", OA2ExchangerDataBean.DataPack.Att.class);
		xstream.alias("ArchMetaDatas", OA2ExchangerDataBean.DataPack.ArchMetaDatas.class);
		xstream.alias("AttachmentFiles", List.class);
		xstream.alias("AttachmentFile", String.class);
		
		xstream.alias("BarCodeAttribute", OA2ExchangerDataBean.DataPack.BarCodeAttribute.class);
		
		xstream.alias("Mac", OA2ExchangerDataBean.Mac.class);
		xstream.useAttributeFor(OA2ExchangerDataBean.Mac.class, "MacType");

		OutputStream outputStream;
		
		/*1.将公文要素bean生成xml文件*/
		String temp_xml_path = gwConstant.tmp_zip_attch_path+File.separator+ins_id+File.separator+xmlName;
		File tempXmlFile = new File(temp_xml_path);
		outputStream = new FileOutputStream(tempXmlFile);
		xstream.toXML(oA2ExchangerDataBean, outputStream);
		 URL url = null;
         HttpURLConnection conn = null;
         String fzsendarchiveurl = OASystemCache.getContextProperty("fzsendarchiveurl"); 
         fzsendarchiveurl += "?UserName="+archiveDispatchBean.getSend_user_id()+"&PWD="+archiveDispatchBean.getSend_user_password();   
         url = new URL(fzsendarchiveurl);  
         conn = (HttpURLConnection)url.openConnection();   
         conn.setRequestMethod("POST");                                       
         conn.setDoOutput(true);       //一定要设为true,因为要发送数据 
         conn.setRequestProperty("Content-Type","multipart/form-data; boundary=Bounday"); 
         conn.setRequestProperty("Cache-Control","no-cache");  
           
         OutputStream buf = conn.getOutputStream(); 
         buf = new BufferedOutputStream(buf);  
         
         //发送数据 
         OutputStreamWriter out = new  OutputStreamWriter (buf); 
         out.write( xstream.toXML(oA2ExchangerDataBean)); 
         out.flush(); //这个一定要 
         out.close();  

         //接收数据 
         InputStream in = conn.getInputStream(); 
         //in = new BufferedInputStream(in); 
         Reader rData = new InputStreamReader(in);  
         int c; 
         String returnStr= "";
         while((c=rData.read()) != -1) {
        	 returnStr =returnStr +(char)c; 
         }
         System.out.print(returnStr); 
         in.close(); 
		 return returnStr;
	}

	@Override
	public String callUnionArchiveSend(ArchiveGwcsXmlBean archiveGwcsXmlBean,
			String[] affixpaths, String uuid) throws Exception {
		LOG.info("--联合盖章发送!start--");
		
		String xmlName = gwConstant.archive_xml;
		String[] affixName = new String[affixpaths.length];
		List<String> zipFileList = new ArrayList<String>();
		byte[] zipFileBytes = null;
		
		
		//将xmlbean生成为xml文件
		XmlDeclarationXStream xstream = new XmlDeclarationXStream(new DomDriver("gbk",new XmlFriendlyNameCoder("-_", "_")));
		xstream.setVersion("1.0");
		xstream.setEcoding("gbk");
		xstream.alias("archive", ArchiveGwcsXmlBean.class);
		xstream.alias("num", ArchiveGwcsXmlBean.Archiveparameters.Num.class);
		xstream.alias("affixname", String.class);
		xstream.alias("addrinfor", ArchiveGwcsXmlBean.Addrinfor.class);
		xstream.alias("sign", ArchiveGwcsXmlBean.Sign.class);

		OutputStream outputStream;
		
		/*1.将公文要素bean生成xml文件*/
		String temp_xml_path = gwConstant.tmp_zip_dir+xmlName;
		File tempXmlFile = new File(temp_xml_path);
		File tmp_zip_dir = new File(gwConstant.tmp_zip_dir);
		tmp_zip_dir.delete();
		if(!tmp_zip_dir.exists() ){
			tmp_zip_dir.mkdir();
			tempXmlFile.createNewFile();
		}
		outputStream = new FileOutputStream(tempXmlFile);
		xstream.toXML(archiveGwcsXmlBean, outputStream);
		zipFileList.add(temp_xml_path);
		
		/*2.将附件解压到指定路径下*/
		for(int i = 0 , j = 0; i <= affixpaths.length-1 ; i ++){
			File affixFile = new File(affixpaths[i]);
			//将附件复制到指定组装路径
			if(affixFile.exists()){
				String temp_affix_path = gwConstant.tmp_zip_dir+affixFile.getName();
				File movedAffixFile = new File(temp_affix_path);
				FileUtils.copyFile(affixFile, movedAffixFile);
				zipFileList.add(temp_affix_path);
				affixName[j] = movedAffixFile.getName();
				j++;
			}
		}
		
		/*3.压缩公文要素xml和附件文件*/
		ZipUtil zipUtil = new ZipUtil();
		zipUtil.setEncode(ZipUtil.ENCODE_GBK);
		zipUtil.zipFile(gwConstant.tmp_zip_path, zipFileList.toArray(new String[zipFileList.size()]));
		
		/*4.转换公文压缩文件为byte数组*/
		File zipFile = new File(gwConstant.tmp_zip_path);
		
		zipFileBytes = FileUtil.getBytesFromFile(zipFile);
		SendRequestBean requestBean = new SendRequestBean();
		
		requestBean.setId(uuid);
		requestBean.setXmlName(xmlName);
		requestBean.setAffixName(affixName);
		requestBean.setType("");
		requestBean.setDh(zipFileBytes);
		SendResponseBean responseBean = archiveClientCallGWCS.callUnionArchiveToGwcs(requestBean);
		
		LOG.info("--公文联合盖章!end--"+("RES000".equals(responseBean.getMessageid())?"成功！":"失败！"));
		if(!"RES000".equals(responseBean.getMessageid())){
			LOG.info("businessid:"+responseBean.getBusinessid());
			LOG.info("summary:"+responseBean.getSummary());
			LOG.info("excepiton:"+responseBean.getException());
		}else{//如果发送成功，将返回的业务ID保存到公文要素表
			String businessid = responseBean.getBusinessid();
			if(!StringUtil.isBlank(businessid)){
				WordArchiveDao dao = (WordArchiveDao)LoadSpringContext.getApplicationContext().getBean("wordArchiveDaoImpl");
				boolean flag = dao.putUnionArchiveInfo(businessid,uuid,"1",null);//设置联合盖章成功
				List<Sign> signs = archiveGwcsXmlBean.getSigns();
				flag = flag&&dao.addSings(signs,businessid,null);
				if(flag){
					LOG.info("businessid:"+businessid+"公文联合盖章成功！");
				}
			}
		}
		return responseBean.getMessageid();
	}

	@Override
	public UnionArchiveResponseBean callUnionArchiveFeedBack(String businessid,String unionArchiveSendWsdl)
			throws Exception {
		UnionArchiveResponseBean responseBean = archiveClientCallGWCS.callUnionArchiveFeedBack(businessid,unionArchiveSendWsdl);
		return responseBean;
	}
	
	@Override
	public SendResponseBean doUnionArchiveToGwcs( ArchiveGwcsXmlBean archiveGwcsXmlBean, String[] affixpaths, String uuid) throws Exception {
		LOG.info("--联合公文发送!start--");
		
		String xmlName = gwConstant.archive_xml;
		String[] affixName = new String[affixpaths.length];
		List<String> zipFileList = new ArrayList<String>();
		byte[] zipFileBytes = null;
		
		
		//将xmlbean生成为xml文件
		XmlDeclarationXStream xstream = new XmlDeclarationXStream(new DomDriver("gbk",new XmlFriendlyNameCoder("-_", "_")));
		xstream.setVersion("1.0");
		xstream.setEcoding("gbk");
		xstream.alias("archive", ArchiveGwcsXmlBean.class);
		xstream.alias("num", ArchiveGwcsXmlBean.Archiveparameters.Num.class);
		xstream.alias("affixname", String.class);
		xstream.alias("addrinfor", ArchiveGwcsXmlBean.Addrinfor.class);
		xstream.alias("sign", ArchiveGwcsXmlBean.Sign.class);

		OutputStream outputStream;
		
		/*1.将公文要素bean生成xml文件*/
		String temp_xml_path = gwConstant.tmp_zip_dir+xmlName;
		File tempXmlFile = new File(temp_xml_path);
		File tmp_zip_dir = new File(gwConstant.tmp_zip_dir);
		tmp_zip_dir.delete();
		if(!tmp_zip_dir.exists() ){
			tmp_zip_dir.mkdir();
			tempXmlFile.createNewFile();
		}
		outputStream = new FileOutputStream(tempXmlFile);
		xstream.toXML(archiveGwcsXmlBean, outputStream);
		zipFileList.add(temp_xml_path);
		
		/*2.将附件解压到指定路径下*/
		for(int i = 0 , j = 0; i <= affixpaths.length-1 ; i ++){
			File affixFile = new File(affixpaths[i]);
			//将附件复制到指定组装路径
			if(affixFile.exists()){
				String temp_affix_path = gwConstant.tmp_zip_dir+affixFile.getName();
				File movedAffixFile = new File(temp_affix_path);
				FileUtils.copyFile(affixFile, movedAffixFile);
				zipFileList.add(temp_affix_path);
				affixName[j] = movedAffixFile.getName();
				j++;
			}
		}
		
		/*3.压缩公文要素xml和附件文件*/
		ZipUtil zipUtil = new ZipUtil();
		zipUtil.setEncode(ZipUtil.ENCODE_GBK);
		zipUtil.zipFile(gwConstant.tmp_zip_path, zipFileList.toArray(new String[zipFileList.size()]));
		
		/*4.转换公文压缩文件为byte数组*/
		File zipFile = new File(gwConstant.tmp_zip_path);
		
		zipFileBytes = FileUtil.getBytesFromFile(zipFile);
		SendRequestBean requestBean = new SendRequestBean();
		
		requestBean.setId(uuid);
		requestBean.setXmlName(xmlName);
		requestBean.setAffixName(affixName);
		requestBean.setType("");
		requestBean.setDh(zipFileBytes);
		SendResponseBean responseBean = archiveClientCallGWCS.doUnionArchiveToGwcs(requestBean);
		
		LOG.info("--公文联合发文!end--"+("RES000".equals(responseBean.getMessageid())?"成功！":"失败！"));
		if(!"RES000".equals(responseBean.getMessageid())){
			LOG.info("businessid:"+responseBean.getBusinessid());
			LOG.info("summary:"+responseBean.getSummary());
			LOG.info("excepiton:"+responseBean.getException());
		}else{//如果发送成功，将返回的业务ID保存到公文要素表
				WordArchiveDao dao = (WordArchiveDao)LoadSpringContext.getApplicationContext().getBean("wordArchiveDaoImpl");
				boolean flag =dao.updateIsSendByBussId(uuid,"UNION_ARCHIVE_BUSS_ID");//将公文要素表的是否发送至为是”1“。
				
				if(flag){
					LOG.info("公文联合发文成功：业务ID"+uuid);
				}
		}
		return responseBean;
	}
}
