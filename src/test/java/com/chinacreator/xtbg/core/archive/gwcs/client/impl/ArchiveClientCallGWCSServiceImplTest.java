package com.chinacreator.xtbg.core.archive.gwcs.client.impl;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import junit.framework.TestCase;

import org.springframework.util.FileCopyUtils;

import com.chinacreator.xtbg.core.archive.gwcs.bean.ArchiveGwcsXmlBean;
import com.chinacreator.xtbg.core.archive.gwcs.bean.ArchiveGwcsXmlBean.Addrinfor;
import com.chinacreator.xtbg.core.archive.gwcs.bean.ArchiveGwcsXmlBean.Archiveparameters;
import com.chinacreator.xtbg.core.archive.gwcs.bean.ArchiveGwcsXmlBean.Archiveparameters.Num;
import com.chinacreator.xtbg.core.archive.gwcs.bean.OA2ExchangerDataBean;
import com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.SendRequestBean;
import com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.SendResponseBean;
import com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.WordRequestBean;
import com.chinacreator.xtbg.core.archive.gwcs.services.OaArchiveWebService;
import com.chinacreator.xtbg.core.archive.gwcs.services.OaArchiveWebServiceImpl;

public class ArchiveClientCallGWCSServiceImplTest extends TestCase {

	public void testCallWordToGWCS(){
		ArchiveClientCallGWCSServiceImpl ss = new ArchiveClientCallGWCSServiceImpl();
		ss.setWordToGwcsWsdl("http://172.16.17.78:6666/gwcs/services/WordToGWCSService");
		WordRequestBean bean = new WordRequestBean();
		bean.setFileName("协同办公系统流程开发规范.doc");
		try {
			bean.setDh(FileCopyUtils.copyToByteArray(new File("D:\\工作\\协同办公系统流程开发规范.doc")));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//assertNotNull(ss.callWordToGWCS(bean));
	}

	public void testCallArchiveSend(){
		ArchiveClientCallGWCSServiceImpl ss = new ArchiveClientCallGWCSServiceImpl();
		ss.setArchiveSendWsdl("http://172.16.17.78:6666/gwcs/services/ArchiveToServerService");
		SendRequestBean bean = new SendRequestBean();
		bean.setId("234324");
		bean.setXmlName("xxx.xml");
		SendResponseBean responseBean  = null;
		try {
			bean.setDh(FileCopyUtils.copyToByteArray(new File("D:\\工作\\协同办公系统流程开发规范.doc")));
			//responseBean = ss.callArchiveSend(bean);
		} catch (IOException e) {
			e.printStackTrace();
		}
		System.out.println(responseBean.getSummary());
	}
	
	
	public void testCallArchiveSend2(){
	
		OaArchiveWebService oaArchiveWebService = new OaArchiveWebServiceImpl();
		ArchiveGwcsXmlBean archiveGwcsXmlBean = new ArchiveGwcsXmlBean();
		Archiveparameters archiveparameters = new ArchiveGwcsXmlBean.Archiveparameters();
		Num num = new ArchiveGwcsXmlBean.Archiveparameters.Num();
		//装填archiveparameters
		archiveparameters.setTitle("公文标题");
			num.setType("2");
			num.setPrefix("文号前缀");
			num.setSymbol("〔2009〕");
			num.setSerial_number("1号");
		archiveparameters.setNum(num);
		archiveparameters.setSecrecy_grade("秘密");
		archiveparameters.setEffect_date("1年");
		archiveparameters.setUrgency_grade("缓急");
		archiveparameters.setCaption("主题词");
		archiveparameters.setKeyword("关键字");
		archiveparameters.setDispatch_type("决定");
		archiveparameters.setSender("签发人");
		archiveparameters.setSendscope("发市州省直");
		archiveparameters.setCreate_date("2008-06-17");
		archiveparameters.setSend_org_name("中共湖南省委");
		archiveparameters.setSend_org_addr("10000000000000000000");
		archiveparameters.setSendusername("省委办公厅");
		archiveparameters.setIssign("false");
		archiveparameters.setContact_phone("询问公文相关问题的联系方式");
		archiveparameters.setMsg("短信内容");
		List<String> affixnames = new ArrayList<String>();
		List<String> affixpaths = new ArrayList<String>();
		affixnames.add("123.log");
		affixpaths.add("E:\\ceb\\123.log");
		affixnames.add("123.ini");
		affixpaths.add("E:\\ceb\\123.log");
		archiveparameters.setAffixnames(affixnames);
		
		//装填receivedeptinfor
		List<Addrinfor> addrinfors = new ArrayList<Addrinfor>();
		Addrinfor addrinfor = new ArchiveGwcsXmlBean.Addrinfor();
		addrinfor.setReceiveraddr("10010060000000000000");
		addrinfor.setReceivername("省委组织部");
		addrinfor.setPrint_num("份数");
		addrinfor.setNum("份号");
		addrinfor.setSend_type("m");
		addrinfors.add(addrinfor);
		
		Addrinfor addrinfor2 = new ArchiveGwcsXmlBean.Addrinfor();
		addrinfor2.setReceiveraddr("11030000000000000000");
		addrinfor2.setReceivername("株洲市委");
		addrinfor2.setPrint_num("份数");
		addrinfor2.setNum("份号");
		addrinfor2.setSend_type("c");
		addrinfors.add(addrinfor2);
		
		archiveGwcsXmlBean.setArchiveparameters(archiveparameters);
		archiveGwcsXmlBean.setReceivedeptinfor(addrinfors);
		
		

		String[] affixpathArry = new String[2]; 
		affixpathArry = (String[])affixpaths.toArray(affixpathArry);
		/*oaArchiveWebService.callArchiveSend("text36431f07-f014-41ff-94ec-bc15ee2d224d", 
				archiveGwcsXmlBean, 
				affixpathArry);*/
		System.out.println();
	}

	
	public void testCallOaArchiveService(){/*
		OaArchiveWebService oaArchiveWebService = new OaArchiveWebServiceImpl();
		OA2ExchangerDataBean oA2ExchangerDataBean = new OA2ExchangerDataBean();
		try {
			//向公文系统发送的数据包消息描述
			OA2ExchangerDataBean.Message message = new OA2ExchangerDataBean.Message();
			message.setType("50");
			message.setStampNums("0");
			oA2ExchangerDataBean.setMessage(message);
			
			//公文的发送单位
			OA2ExchangerDataBean.UnitInfo unitInfo = new OA2ExchangerDataBean.UnitInfo();
			//sends节点
			OA2ExchangerDataBean.UnitInfo.Sends sends = new OA2ExchangerDataBean.UnitInfo.Sends();
			OA2ExchangerDataBean.UnitInfo.Sends.Unit  unit = new OA2ExchangerDataBean.UnitInfo.Sends.Unit(); 
			unit.setUnitID("0001");
			unit.setUnitName("单位");
			unit.setProcUUID("");
			sends.setUnit(unit);
			unitInfo.setSends(sends);
			//unites节点
			OA2ExchangerDataBean.UnitInfo.Unites unites = new OA2ExchangerDataBean.UnitInfo.Unites();
			OA2ExchangerDataBean.UnitInfo.Unites.Unit  unit1 = new OA2ExchangerDataBean.UnitInfo.Unites.Unit(); 
			unit1.setUnitID("0001");
			unit1.setUnitName("单位");
			unit1.setProcUUID("");
			unites.setUnit(unit1);
			unitInfo.setUnites(unites);
			
			OA2ExchangerDataBean.UnitInfo.Receives receives = new OA2ExchangerDataBean.UnitInfo.Receives();
			OA2ExchangerDataBean.UnitInfo.Receives.Unit  unit2 = new OA2ExchangerDataBean.UnitInfo.Receives.Unit(); 
			unit.setUnitID("0001");
			unit.setUnitName("单位");
			unit.setProcUUID("");
			receives.setUnit(unit2);
			unitInfo.setReceives(receives);
			oA2ExchangerDataBean.setUnitInfo(unitInfo);
			
			//本节点Type = 60 时必须有，Item节点数等于StampNums节点的值
			OA2ExchangerDataBean.StampInfo stampInfo = new OA2ExchangerDataBean.StampInfo();
			
			oA2ExchangerDataBean.setStampInfo(stampInfo);
			
			// 本节点Type = 50或者Type = 60 时必须有
			OA2ExchangerDataBean.SndDstrbtInfo sndDstrbtInfo = new OA2ExchangerDataBean.SndDstrbtInfo();
			sndDstrbtInfo.setbTolNumCtrl("0");
			sndDstrbtInfo.setTotalPrnNum("0");
			sndDstrbtInfo.setCreateTime("2013-11-09 11:40:11");
			
			OA2ExchangerDataBean.SndDstrbtInfo.DetailXml  detailXml = new OA2ExchangerDataBean.SndDstrbtInfo.DetailXml();
			OA2ExchangerDataBean.SndDstrbtInfo.DetailXml.Template template = new OA2ExchangerDataBean.SndDstrbtInfo.DetailXml.Template();
			ArrayList<OA2ExchangerDataBean.SndDstrbtInfo.DetailXml.Template.TemplateMem> templateMemList = new ArrayList<OA2ExchangerDataBean.SndDstrbtInfo.DetailXml.Template.TemplateMem>();
			OA2ExchangerDataBean.SndDstrbtInfo.DetailXml.Template.TemplateMem  templateMem = new OA2ExchangerDataBean.SndDstrbtInfo.DetailXml.Template.TemplateMem();
			templateMem.setPrnNums("0002");
			templateMem.setRecvUnitID("部门二");
			templateMem.setRecvUnitName("100");
			templateMem.setStartNum("1");
			templateMemList.add(templateMem);
			template.setTemplateMem(templateMemList);
			detailXml.setTemplate(template);
			sndDstrbtInfo.setDetailXml(detailXml);
			oA2ExchangerDataBean.setSndDstrbtInfo(sndDstrbtInfo);
			
			//数据包，包括CEB文件，附件和元数据
			OA2ExchangerDataBean.DataPack dataPack = new OA2ExchangerDataBean.DataPack();
			//ceb插入
			OA2ExchangerDataBean.DataPack.CEBFile cEBFile = new OA2ExchangerDataBean.DataPack.CEBFile();
			cEBFile.setcEBContent("bmRlciBDRUIAAAADAK");
			cEBFile.setcEBContentLength("16");
			cEBFile.setcEBFileName("OA系统集成方案");
			cEBFile.setcEBFilePathNameInOA("c:\\ OA系统集成方案.ceb");
			dataPack.setcEBFile(cEBFile);
			//AttFiles插入
			OA2ExchangerDataBean.DataPack.AttFiles attFiles = new OA2ExchangerDataBean.DataPack.AttFiles();
			ArrayList<OA2ExchangerDataBean.DataPack.AttFiles.Att> attlist = new ArrayList<OA2ExchangerDataBean.DataPack.AttFiles.Att>();
			//附件1
			OA2ExchangerDataBean.DataPack.AttFiles.Att att = new OA2ExchangerDataBean.DataPack.AttFiles.Att();
			//att.setAttContent("Rm91bmRlci");
			att.setAttContentLength("10");
			att.setAttFileName("abc.doc");
			att.setAttFilePathNameInOA("c:\\abc.doc");
			attlist.add(att);
			//附件2
			OA2ExchangerDataBean.DataPack.AttFiles.Att att1 = new OA2ExchangerDataBean.DataPack.AttFiles.Att();
			//att1.setAttContent("Rm91bmRlci1");
			att1.setAttContentLength("10");
			att1.setAttFileName("abc1.doc");
			att1.setAttFilePathNameInOA("c:\\abc1.doc");
			attlist.add(att1);
			
			attFiles.setAtt(attlist);
			dataPack.setAttFiles(attFiles);
			
			//ArchMetaDatas插入
			OA2ExchangerDataBean.DataPack.ArchMetaDatas archMetaDatas = new OA2ExchangerDataBean.DataPack.ArchMetaDatas();
			OA2ExchangerDataBean.DataPack.ArchMetaDatas.ArchSechma  archSechma = new OA2ExchangerDataBean.DataPack.ArchMetaDatas.ArchSechma ();
			archSechma.setArchSerial("dddeee[2008]2号");
			archSechma.setArchFormTime("2007-02-07");
			archSechma.setExigenceLevel("1");
			archSechma.setSecretLevel("1");
			archSechma.setSecretYear("2");
			archSechma.setArchTitle("tetsss-20080402");
			archSechma.setArchKeyWords("主题字-0402");
			archSechma.setMainReceiver("主送单位-1");
			archSechma.setCopyReceiver("抄送单位-2、");
			archSechma.setDistributeLeader("签发领导-hlg");
			archSechma.setDistributeTime("2008-02-07");
			archSechma.setProcMan("经办人");
			archSechma.setContact("联系方式");
			archSechma.setArchRemark("发文说明");
			archSechma.setoADataID("1101");
			//ArrayList<OA2ExchangerDataBean.DataPack.ArchMetaDatas.ArchSechma.AttachmentFiles> attachmentFileslist = new ArrayList<OA2ExchangerDataBean.DataPack.ArchMetaDatas.ArchSechma.AttachmentFiles>();
			OA2ExchangerDataBean.DataPack.ArchMetaDatas.ArchSechma.AttachmentFiles attachmentFiles = new OA2ExchangerDataBean.DataPack.ArchMetaDatas.ArchSechma.AttachmentFiles();
			
			ArrayList<String> attachmentFileList = new ArrayList<String>();
			String attachmentFile1 = "123.doc";
			attachmentFileList.add(attachmentFile1);
			
			attachmentFiles.setAttachmentFile(attachmentFileList);
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
			
			oaArchiveWebService.sendToFZOA(oA2ExchangerDataBean);
		} catch (Exception e) {
			e.printStackTrace();
		}
	*/}
	
	
}
