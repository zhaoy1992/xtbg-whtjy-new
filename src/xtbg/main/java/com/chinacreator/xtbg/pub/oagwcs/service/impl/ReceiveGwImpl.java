package com.chinacreator.xtbg.pub.oagwcs.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.jws.WebService;
import javax.transaction.RollbackException;

import org.apache.commons.io.IOUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.dom4j.Element;

import com.chinacreator.xtbg.core.archive.gwcs.bean.Organization;
import com.chinacreator.xtbg.core.archive.gwcs.services.OaArchiveHandlerIfc;
import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.FileUtil;
import com.chinacreator.xtbg.pub.jqueryupload.filebuess.service.impl.FiletransferServiceImpl;
import com.chinacreator.xtbg.pub.jqueryupload.utils.FileUtils;
import com.chinacreator.xtbg.pub.oagwcs.dao.ReceiveGwDAO;
import com.chinacreator.xtbg.pub.oagwcs.dao.imploracle.ReceiveGwDAOImpl;
import com.chinacreator.xtbg.pub.oagwcs.entity.FileInfoBean;
import com.chinacreator.xtbg.pub.oagwcs.entity.GwreceiveBean;
import com.chinacreator.xtbg.pub.oagwcs.service.util.GwConstant;
import com.chinacreator.xtbg.pub.oagwcs.service.util.PublicMethod;
import com.chinacreator.xtbg.pub.oagwcs.service.util.XmlBuilder;
import com.chinacreator.xtbg.pub.oagwcs.service.util.ZipUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.frameworkset.orm.transaction.TransactionManager;
import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;

/**
 *<p>Title:公文接收</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南科创</p>
 *@author yiping.huang
 *@version 1.0
 *@date 2012-7-3
 */
@WebService(endpointInterface = "com.chinacreator.xtbg.pub.oagwcs.service.impl.ReceiveGwIfc",
        serviceName = "ReceiveGwIfc")
public class ReceiveGwImpl implements ReceiveGwIfc {
	private static final Log LOG = LogFactory.getLog(ReceiveGwImpl.class);
	
	private com.chinacreator.xtbg.core.archive.gwcs.bean.GwConstant gwConstant1;//公文传输常量
	private OaArchiveHandlerIfc oaArchiveHandlerIfc = null;//oa对于公文传输数据的处理接口

	public void setGwConstant(com.chinacreator.xtbg.core.archive.gwcs.bean.GwConstant gwConstant) {
		this.gwConstant1 = gwConstant;
	}

	public OaArchiveHandlerIfc getOaArchiveHandlerIfc() {
		return oaArchiveHandlerIfc;
	}

	public void setOaArchiveHandlerIfc(OaArchiveHandlerIfc oaArchiveHandlerIfc) {
		this.oaArchiveHandlerIfc = oaArchiveHandlerIfc;
	}
	/**
	  * <b>Summary: </b>
	  *     复写方法 gwcsOrgSyn
	  * @param type
	  * @param content
	  * @return 
	  * @see com.chinacreator.xtbg.core.archive.gwcs.services.GwcsOrgSynService#gwcsOrgSyn(int, byte[])
	 */
	@Override
	public String gwcsOrgSyn(int type, byte[] content) {
		String archiveXmlFilePath = "";
		Connection con = null;
		LOG.info("--解析电子公文传输系统传送过来的地址本数据，并返回处理结果给电子公文传输系统!start--");
		String resultCode = gwConstant1.ret_success;
		/*将xml文件转化成相应的list<bean>*/
		XStream xstream = new XStream(new DomDriver());
		
		 try {
			 archiveXmlFilePath = new String(content,"GBK");
			 //IOUtils.write(content, new FileOutputStream(new File("C:/Users/oa/test.xml"))) ;

			 con = DbManager.getInstance().getTransactionConnection();
			 if(0 == type){//0:地址本初始化xml文件;
				 xstream.alias("organizations", ArrayList.class);
				 xstream.alias("organization", Organization.class);
				 ArrayList<Organization> organizations = (ArrayList<Organization>) xstream.fromXML(archiveXmlFilePath);
				 oaArchiveHandlerIfc.gwcsOrgSynInitHandler(content, organizations, con);
			 }else if(1 == type){//1:地址本单条或多条更新xml文件;
				 xstream.alias("organization", Organization.class);
				 Organization organization = (Organization) xstream.fromXML(archiveXmlFilePath);
				 oaArchiveHandlerIfc.gwcsOrgSynSingleOrg2DbHandler(content, organization, con);
			 }
			 
		} catch (Exception e) {
			resultCode = gwConstant1.ret_failed;
			DbManager.rollBackNoThrow(con);
			LOG.error(e.getMessage(), e);
		} finally{
			if(con != null){
				DbManager.closeConnection(con);
			}
		}
		LOG.info("--解析电子公文传输系统传送过来的地址本数据，并返回处理结果给电子公文传输系统!end--"+("0".equals(resultCode)?"成功！":"失败！"));
		return resultCode;
	}

	
	/**
	 * @Description  公文落地接口
	 * 解析gwcs传送过来的公文数据，并返回处理结果给电子公文传输系统
	 * @param filenames 多个公文名称之间用英文逗号隔开
	 * 第一个为 公文*.ceb(此名称与zip包中的文件名称一致,使用英文命名)
	 * 第二个为xml要素文件 (注意此名称与zip包中的文件名称一致,使用英文命名)
	 * 之后的为附件需要包括后缀名(注意此名称与zip包中的文件名称一致,使用英文命名)没有附件时不设置
	 * @param content 公文要素xml文件+脱密后的ceb文件+附件打包为zip文件后，转换为byte[]（大小控制在5M以下）
	 * @return 返回值类型String 处理过程无异常返回0否则返回1
	 * @throws IOException 
	 * @exception 异常说明
	 * 
	 */
	
	@Override
	public String resciveGw(String filenames, byte[] content) {
		//TODO 1.把byte数组生成zip包
		//TODO 2.解压zip包,(filenames文件名称与zip包文件数验证)
		//TODO 3.解析xml文件封装数据(收文单位的映射关系处理)
		//TODO 4.业务入库(业务数据,附件数据)
		TransactionManager tm = new TransactionManager();
		String flag = "0";
		try {
			String cebName = "";//ceb名称
			String xmlName = "";//xml文件名称
			if(!StringUtil.isBlank(filenames) && content != null) {
				String gwfileNames[] = filenames.split(",");
				if(gwfileNames.length >= 2) {
					cebName = gwfileNames[0];//获得ceb名称
					xmlName = gwfileNames[1];//获得xml文件名称
				}
				
				//1.把byte数组生成zip包
				PublicMethod.getFileFromBytes(content,GwConstant.TMP_ZIP_PATH);// 生成临时zip文件
				
				//FileCopyUtils.copy(content,new File(GwConstant.TMP_ZIP_PATH));
				
				ZipUtil zipUtil = new ZipUtil();
				//2.解压zip包,(filenames文件名称与zip包文件数验证)
				zipUtil.unZipFile(GwConstant.TMP_ZIP_PATH, GwConstant.TMP_ZIP_DIR);//解压缩zip文件
				
				String xmlPath = GwConstant.TMP_ZIP_DIR + xmlName;
				String cebPath = GwConstant.TMP_ZIP_DIR + cebName;
				
				
				//3.解析xml文件封装数据(收文单位的映射关系处理)
				XmlBuilder xBuilder = new XmlBuilder(xmlPath);
				
				//***********************************基本信息入库***********************************
				String title = xBuilder.getElementValue("receive/title");//公文标题
				String prefix = xBuilder.getElementValue("receive/num/prefix");//文号前缀
				String symbol = xBuilder.getElementValue("receive/num/symbol");//〔2009〕
				String serial_number = xBuilder.getElementValue("receive/num/serial_number");//1号
				String secrecy_grade = xBuilder.getElementValue("receive/secrecy_grade");//公文密级
				String effect_date = xBuilder.getElementValue("receive/effect_date");//保密期限(秘密)
				String urgency_grade = xBuilder.getElementValue("receive/urgency_grade");//紧急程度(缓急)
				String caption = xBuilder.getElementValue("receive/caption");//主题词
				String keyword = xBuilder.getElementValue("receive/keyword");//关键字
				String dispatch_type = xBuilder.getElementValue("receive/dispatch_type");//文种(决定)
				String sender = xBuilder.getElementValue("receive/sender");//签发人
				String sendscope = xBuilder.getElementValue("receive/sendscope");//发布层次(发市州省直)
				String create_date = xBuilder.getElementValue("receive/create_date");//成文时间(格式如下yyyy-mm-dd)
				String send_date = xBuilder.getElementValue("receive/send_date");//公文发送时间(2009-3-9 09:46:31)
				String send_org_name = xBuilder.getElementValue("receive/send_org_name");//发文单位机构名称(中共湖南省委)
				String send_org_addr = xBuilder.getElementValue("receive/send_org_addr");//发文单位20位地址码(10000000000000000000)
				String sendusername = xBuilder.getElementValue("receive/sendusername");//发文操作的用户名称(省委办公厅)
				String issign = xBuilder.getElementValue("receive/issign");//是否加盖电子印章 是为true,否为false
				String contact_phone = xBuilder.getElementValue("receive/contact_phone");//收文用户可以询问公文相关情况的联系方式
				String recv_org_name = xBuilder.getElementValue("receive/recv_org_name");//收文单位机构名称
				String recv_org_addr = xBuilder.getElementValue("receive/recv_org_addr");//recv_org_addr表示收文单位的20位地址码，20位的数字
				String file_name = xBuilder.getElementValue("receive/file_name");//公文文件名称 后缀为.ceb
				
				
				//解析附件信息并保存
				Element e_affixnames = xBuilder.getElement("receive/affixnames");
				String saveReportPath = "d:/temp/";
				
				tm.begin();
				ReceiveGwDAO receiveGwDAO = new ReceiveGwDAOImpl();
				
				String attach_id = FileUtils.randomUUID();
				FiletransferServiceImpl ft=new FiletransferServiceImpl();
				List<FileInfoBean> listFileInfoBean = new ArrayList<FileInfoBean>();
				
				
				FileInfoBean filebean = new FileInfoBean();
				String uuid = FileUtils.randomUUID();
				String filetype = FileUtils.getFiletype(cebName);
				filebean.setExtend(filetype);
				filebean.setDjbh(attach_id);
				filebean.setDjsn(uuid);
				filebean.setFilename(cebName);
				filebean.setAttachid(ft.getAttachId());
				filebean.setFilepos(cebPath);
				filebean.setUpload_mode("1");
				filebean.setAttachcontent(cebPath);
				listFileInfoBean.add(filebean);
				
				int i = 0;
				if(e_affixnames != null) { 
					for (Iterator i_affixname = e_affixnames.elementIterator(); i_affixname.hasNext();) {
							Element e_affixname = (Element) i_affixname.next();
							String affixname = e_affixname.getTextTrim();//获得附件显示名称
								String fileaffixName = gwfileNames[i + 2]; //获得附件名称
								  
								String affixPath = GwConstant.TMP_ZIP_DIR + fileaffixName; //获得附件路径
								filetype = FileUtils.getFiletype(affixname);
								uuid = FileUtils.randomUUID();
								
								String newFileName = uuid + "_" + FileUtils.getSysTime()
									+ filetype;
								String reportAbsFilePath = saveReportPath + newFileName; // 新文件名文件保存路径
							  
								filebean = new FileInfoBean();
								filebean.setExtend(filetype);
								filebean.setDjbh(attach_id);
								filebean.setDjsn(uuid);
								filebean.setFilename(affixname);
								filebean.setAttachid(ft.getAttachId());
								filebean.setFilepos(reportAbsFilePath);
								filebean.setUpload_mode("1");
								filebean.setAttachcontent(affixPath);
								listFileInfoBean.add(filebean);
						i++;
					 }
				}
				 receiveGwDAO.saveGwReceiveAttach(listFileInfoBean);//保存附件信息
				 
				 
//				 OctlDocumentBean octlDocumentBean = new OctlDocumentBean();
//				 octlDocumentBean.setDocumentid("8");
//				 octlDocumentBean.setRecordid(wordcontent_id);
//				 octlDocumentBean.setFiletype(".doc");
//				 octlDocumentBean.setSubject("请输入主题");
//				 octlDocumentBean.setFiledate(send_date);
//				 octlDocumentBean.setStatus("READ");
//				 octlDocumentBean.setAuthor(sender);
//				 octlDocumentBean.setHtmlpath(cebPath);
//				 
//				 receiveGwDAO.saveGwReceiveWord(octlDocumentBean);//保存word信息
				 
				GwreceiveBean gwreceiveBean = new GwreceiveBean();
				gwreceiveBean.setTitle(title);
				gwreceiveBean.setPrefix(prefix);
				gwreceiveBean.setSymbol(symbol);
				gwreceiveBean.setSerial_number(serial_number);
				gwreceiveBean.setSecrecy_grade(secrecy_grade);
				gwreceiveBean.setEffect_date(effect_date);
				gwreceiveBean.setUrgency_grade(urgency_grade);
				gwreceiveBean.setCaption(caption);
				gwreceiveBean.setKeyword(keyword);
				gwreceiveBean.setDispatch_type(dispatch_type);
				gwreceiveBean.setSendscope(sendscope);
				gwreceiveBean.setSender(sender);
				gwreceiveBean.setSendscope(sendscope);
				gwreceiveBean.setCreate_date(create_date);
				gwreceiveBean.setSend_date(send_date);
				gwreceiveBean.setSend_org_name(send_org_name);
				gwreceiveBean.setSend_org_addr(send_org_addr);
				gwreceiveBean.setSendusername(sendusername);
				gwreceiveBean.setIssign(issign);
				gwreceiveBean.setContact_phone(contact_phone);
				gwreceiveBean.setRecv_org_name(recv_org_name);
				gwreceiveBean.setRecv_org_addr(recv_org_addr);
				gwreceiveBean.setFile_name(file_name);
				
				gwreceiveBean.setIs_accept("N");
				gwreceiveBean.setAttach_id(attach_id);
				
				
				
				receiveGwDAO.saveGwReceiveInfo(gwreceiveBean);//保存公文基本信息
				
				tm.commit();
			}
			PublicMethod.deleteFile("c:\\oa");
		} catch (Exception e) {
			flag = "1";
			e.printStackTrace();
			try {
				tm.rollback();
			} catch (RollbackException e1) {
				e1.printStackTrace();
			}
		}
		
		return flag;
		

	}
	
}
