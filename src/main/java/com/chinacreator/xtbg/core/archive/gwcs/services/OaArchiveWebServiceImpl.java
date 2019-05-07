package com.chinacreator.xtbg.core.archive.gwcs.services;

import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.jws.WebService;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.dom4j.Element;
import org.springframework.util.FileCopyUtils;

import com.chinacreator.xtbg.core.archive.gwcs.bean.GwConstant;
import com.chinacreator.xtbg.core.archive.gwcs.bean.GwreceiveBean;
import com.chinacreator.xtbg.core.archive.gwcs.bean.Organization;
import com.chinacreator.xtbg.core.archive.gwcs.bean.ReceiveGwcsXmlBean;
import com.chinacreator.xtbg.core.archive.gwcs.bean.XmlBuilder;
import com.chinacreator.xtbg.core.archive.gwcs.dao.ReceiveGwDAO;
import com.chinacreator.xtbg.core.archive.gwcs.dao.impl.ReceiveGwDAOImpl;
import com.chinacreator.xtbg.core.archive.gwcs.util.PublicMethod;
import com.chinacreator.xtbg.core.common.fancyuoload.entity.FileInfoBean;
import com.chinacreator.xtbg.core.common.fancyuoload.service.impl.FiletransferServiceImpl;
import com.chinacreator.xtbg.core.common.fancyuoload.util.FileUtils;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.FileUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.common.util.ZipUtil;
import com.frameworkset.orm.transaction.TransactionManager;
import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;
/**
 *<p>Title:GwcsOrgSynServiceImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-7-22
 */
@WebService(endpointInterface = "com.chinacreator.xtbg.core.archive.gwcs.services.OaArchiveWebService",
        serviceName = "OaArchiveWebService")
public class OaArchiveWebServiceImpl implements OaArchiveWebService {
	private static final Log LOG = LogFactory.getLog(OaArchiveWebServiceImpl.class);
	private GwConstant gwConstant = new GwConstant();//公文传输常量

	private OaArchiveHandlerIfc oaArchiveHandlerIfc = null;//oa对于公文传输数据的处理接口
	

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
	  *     复写方法 gwcsOrgSyn
	  * @param type
	  * @param content
	  * @return 
	  * @see com.chinacreator.xtbg.core.archive.gwcs.services.GwcsOrgSynService#gwcsOrgSyn(int, byte[])
	 */
	@SuppressWarnings("unchecked")
	public String gwcsOrgSyn(int type, byte[] content) {
		String archiveXmlFilePath = "";
		Connection con = null;
		LOG.info("--解析电子公文传输系统传送过来的地址本数据，并返回处理结果给电子公文传输系统!start--");
		String resultCode = gwConstant.ret_success;
		/*将xml文件转化成相应的list<bean>*/
		XStream xstream = new XStream(new DomDriver());
		
		 try {
			 archiveXmlFilePath = new String(content,"GBK");

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
			resultCode = gwConstant.ret_failed;
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
	  * <b>Summary: </b>
	  *     复写方法 recvCebFile
	  * @param uuid
	  * @param content
	  * @return 
	  * @see com.chinacreator.xtbg.core.archive.gwcs.services.OaArchiveWebService#recvCebFile(java.lang.String, byte[])
	 */
	public String recvCebFile(String uuid, byte[] content) {
		Connection con = null;
		System.out.println("--盖章ceb文件回传!start----盖章ceb文件回传!start--");
		LOG.info("--盖章ceb文件回传!start--");
		String resultCode = gwConstant.ret_success;
		try {
			con = DbManager.getInstance().getTransactionConnection();
			File cebFile = FileUtil.getFileFromBytes(content, gwConstant.ceb_path);
			oaArchiveHandlerIfc.recvCebFileHandler(uuid, content, cebFile, con);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(con);
			LOG.error(e.getMessage(), e);
		} finally{
			if(con != null){
				DbManager.closeConnection(con);
			}
		}
		LOG.info("--盖章ceb文件回传!end--"+("0".equals(resultCode)?"成功！":"失败！"));
		return resultCode;
	}

	/**
	  * <b>Summary: </b>
	  *     复写方法 recvArchive
	  * @param filenames
	  * @param content
	  * @return 
	  * @see com.chinacreator.xtbg.core.archive.gwcs.services.OaArchiveWebService#recvArchive(java.lang.String, byte[])
	 */
	public String recvArchive(String filenames, byte[] content) {
		Connection con = null;
		LOG.info("--recvArchive公文落地!start--");
		String resultCode = gwConstant.ret_success;
		try {
			con = DbManager.getInstance().getTransactionConnection();
			String cebName = "";//ceb名称
			String xmlName = "";//xml文件名称
			if(!StringUtil.isBlank(filenames) && content != null) {
				String gwfileNames[] = filenames.split(",");
				if(gwfileNames.length >= 2) {
					cebName = gwfileNames[0];//获得ceb名称
					xmlName = gwfileNames[1];//获得xml文件名称
				}
				/*1.把byte数组生成zip包*/
				PublicMethod.getFileFromBytes(content,gwConstant.tmp_zip_path);
				ZipUtil zipUtil = new ZipUtil();
				
				/*2.解压zip包,(filenames文件名称与zip包文件数验证)*/
				zipUtil.unZipFile(gwConstant.tmp_zip_path, gwConstant.tmp_zip_dir);//解压缩zip文件
				
				String xmlPath = gwConstant.tmp_zip_dir + xmlName;
				String cebPath = gwConstant.tmp_zip_dir + cebName;

				/*3.解析xml*/
				XStream xstream = new XStream(new DomDriver());
				xstream.alias("receive", ReceiveGwcsXmlBean.class);
				xstream.alias("num", ReceiveGwcsXmlBean.Num.class);
				xstream.alias("affixname", String.class);
				ReceiveGwcsXmlBean receiveGwcsXmlBean = (ReceiveGwcsXmlBean) xstream.fromXML(new FileInputStream(xmlPath));
				
				/*4.装载ceb文件*/
				File cebFile = new File(cebPath);
				//装换ceb文件名称为公文要素中的真实文件名
				File renameCebFile = new File(gwConstant.tmp_zip_dir+receiveGwcsXmlBean.getFile_name());
				cebFile.renameTo(renameCebFile);
				
				/*5.装载附件集合*/
				List<File> attachFiles = new ArrayList<File>();
				File attachFile;
				File renameAttachFile;
				if(receiveGwcsXmlBean.getAffixnames()!=null && receiveGwcsXmlBean.getAffixnames().size()>0){
					for(int i = 0 ; i < receiveGwcsXmlBean.getAffixnames().size() ; i++){
						attachFile = new File(gwConstant.tmp_zip_dir+gwfileNames[i+2]);
						//转换附件名称为公文要素中的真实附件名
						renameAttachFile = new File(gwConstant.tmp_zip_dir+receiveGwcsXmlBean.getAffixnames().get(i));
						attachFile.renameTo(renameAttachFile);
						attachFiles.add(renameAttachFile);
					}
				}
				
				/*具体数据处理类--可以修改spring配置，切换成自己需要的实现类*/
				oaArchiveHandlerIfc.recvArchive(filenames, content, receiveGwcsXmlBean, renameCebFile, attachFiles, con);
			}
			
			
		} catch (Exception e) {
			resultCode = gwConstant.ret_failed;
			DbManager.rollBackNoThrow(con);
			LOG.error(e.getMessage(), e);
			e.printStackTrace();
		} finally{
			if(con != null){
				DbManager.closeConnection(con);
			}
		}
		LOG.info("--公文落地!end--"+("0".equals(resultCode)?"成功！":"失败！"));
		return resultCode;
	}

	/**
	  * <b>Summary: </b>
	  *     复写方法 recvArchiveReceipt
	  * @param content
	  * @return 
	  * @see com.chinacreator.xtbg.core.archive.gwcs.services.OaArchiveWebService#recvArchiveReceipt(byte[])
	 */
	@Override
	public String recvArchiveReceipt(byte[] content) {
		// TODO Auto-generated method stub
		return null;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 resciveGw
	  * @param filenames
	  * @param content
	  * @return 
	  * @see com.chinacreator.xtbg.core.archive.gwcs.services.OaArchiveWebService#resciveGw(java.lang.String, byte[])
	 */
	@Override
	public String resciveGw(String filenames, byte[] content) {
		LOG.info("--resciveGw公文落地!start--");
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
				PublicMethod.getFileFromBytes(content,gwConstant.tmp_zip_path);// 生成临时zip文件
				
				FileCopyUtils.copy(content,new File(gwConstant.tmp_zip_path));
				
				ZipUtil zipUtil = new ZipUtil();
				//2.解压zip包,(filenames文件名称与zip包文件数验证)
				zipUtil.unZipFile(gwConstant.tmp_zip_path, gwConstant.tmp_zip_dir);//解压缩zip文件
				
				String xmlPath = gwConstant.tmp_zip_dir + xmlName;
				String cebPath = gwConstant.tmp_zip_dir + cebName;
				
				
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
				List<Element> e_affixnames = new ArrayList<Element>();
				for (int i = 0; i < 10; i++) {
					Element e_affixname = xBuilder.getElement("receive/affix"+(i+1)+"_name");
					if (e_affixname == null) {
						break;
					}
					e_affixnames.add(e_affixname);
				}
				//String saveReportPath = "d:/temp/";
				
				tm.begin();
				ReceiveGwDAO receiveGwDAO = new ReceiveGwDAOImpl();
				
				String attach_id = FileUtils.randomUUID();
				FiletransferServiceImpl ft=new FiletransferServiceImpl();
				List<FileInfoBean> listFileInfoBean = new ArrayList<FileInfoBean>();
				
				
				FileInfoBean filebean1 = new FileInfoBean();
				String uuid1 = FileUtils.randomUUID();
				String filetype1 = FileUtils.getFiletype(cebName);
				filebean1.setExtend(filetype1);
				filebean1.setDjbh(attach_id);
				filebean1.setDjsn(uuid1);
				filebean1.setFilename(cebName);
				filebean1.setAttachid(ft.getAttachId());
				filebean1.setFilepos(cebPath);
				filebean1.setUpload_mode("1");
				filebean1.setFileInput(new FileInputStream(cebPath));
				//filebean.setAttachcontent(cebPath);
				listFileInfoBean.add(filebean1);
				
				int i = 0;
				if (e_affixnames != null) {
					File attachFile;
					if (e_affixnames.size() > 0) {

						for (int j = 0; j < e_affixnames.size(); j++) {
							FileInfoBean filebean = new FileInfoBean();
							Element e_affixname = (Element) e_affixnames.get(j);
							String affixname = e_affixname.getTextTrim();// 获得附件显示名称
							String fileaffixName = gwfileNames[i + 2]; // 获得附件名称

							String affixPath = gwConstant.tmp_zip_dir + fileaffixName; // 获得附件路径
							String filetype = FileUtils.getFiletype(affixname);
							String uuid = FileUtils.randomUUID();

							String newFileName = uuid + "_" + FileUtils.getSysTime() + filetype;
							//String reportAbsFilePath = saveReportPath + newFileName; // 新文件名文件保存路径
							String reportAbsFilePath = newFileName; // 新文件名文件保存路径
							attachFile = new File(affixPath);
							filebean = new FileInfoBean();
							filebean.setExtend(filetype);
							filebean.setDjbh(attach_id);
							filebean.setDjsn(uuid);
							filebean.setFilename(affixname);
							filebean.setAttachid(ft.getAttachId());
							filebean.setFilepos(reportAbsFilePath);
							filebean.setUpload_mode("1");
							filebean.setFileInput(new FileInputStream(attachFile));
							// filebean.setAttachcontent(affixPath);
							listFileInfoBean.add(filebean);
							i++;
						}
					}
				}
				receiveGwDAO.saveGwReceiveAttach(listFileInfoBean,null);// 保存附件信息
				 
				 
// OctlDocumentBean octlDocumentBean = new OctlDocumentBean();
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
				gwreceiveBean.setPss_number(prefix+symbol+serial_number);

				gwreceiveBean.setIs_accept("0");
				gwreceiveBean.setAttach_id(attach_id);
				
				
				
				receiveGwDAO.saveGwReceiveInfo(gwreceiveBean,null);//保存公文基本信息
				
				tm.commit();
			}
			//PublicMethod.deleteFile("c:\\oa");
			PublicMethod.deleteFile(gwConstant.oa_path);//删除临时附件
		} catch (Exception e) {
			flag = "1";
			e.printStackTrace();
			try {
				tm.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		}
		LOG.info("--resciveGw公文落地!end--");
		return flag;
	}
}
