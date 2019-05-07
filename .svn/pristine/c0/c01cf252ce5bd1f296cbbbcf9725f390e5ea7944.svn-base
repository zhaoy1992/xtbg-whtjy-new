package com.chinacreator.xtbg.core.archive.gwcs.services.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import sun.misc.BASE64Decoder;

import com.chinacreator.xtbg.core.archive.gwcs.bean.GwConstant;
import com.chinacreator.xtbg.core.archive.gwcs.bean.GwreceiveBean;
import com.chinacreator.xtbg.core.archive.gwcs.dao.ReceiveGwDAO;
import com.chinacreator.xtbg.core.archive.gwcs.dao.impl.ReceiveGwDAOImpl;
import com.chinacreator.xtbg.core.archive.gwcs.util.PublicMethod;
import com.chinacreator.xtbg.core.common.fancyuoload.entity.FileInfoBean;
import com.chinacreator.xtbg.core.common.fancyuoload.service.impl.FiletransferServiceImpl;
import com.chinacreator.xtbg.core.common.fancyuoload.util.FileUtils;
import com.chinacreator.xtbg.core.common.util.DateUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.FileUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;

/**
 * 
 *<p>Title:ReceiveFounderArchiveServlet.java</p>
 *<p>Description:接收方正公文传输的数据，解析数据并入库</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author 李畅
 *@version 1.0
 *2013-11-11
 */
public class ReceiveFounderArchiveServlet extends HttpServlet {
	/**
	 * Logger for this class
	 */
	private static final Logger LOG = Logger.getLogger(ReceiveFounderArchiveServlet.class);

	private static final long serialVersionUID = 1L;
	
	private GwConstant gwConstant = new GwConstant();//公文传输常量
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		this.doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		InputStream is = req.getInputStream();
		SAXReader reader = new SAXReader(); 
		Connection conn = null;
		boolean success = true;
		
		resp.setCharacterEncoding("GBK");
		//is = new FileInputStream(new File("d:/archivefounder.xml"));
		//FileCopyUtils.copy(is, new FileOutputStream(new File("d:/test.xml")));
		String successMsg = "<result><code>100</code><description>文件接收成功!</description></result>";
		String errorMsg = "<result><code>0</code><description>文件接收失败</description></result>";
		PrintWriter out = resp.getWriter();
		//清除缓存
		resp.setHeader( "Pragma ", "No-cache "); 
		resp.setHeader( "Cache-Control ", "no-cache "); 
		resp.setDateHeader( "Expires ",   0); 
		try {
			Document document = reader.read(is);
			Element root = document.getRootElement();
			Element dataPack = root.element("DataPack");
			Element unitInfo = root.element("UnitInfo");
			Element archMetaDatas = dataPack.element("ArchMetaDatas");
			Element archSechma = archMetaDatas.element("ArchSechma");
			//Element barCodeAttribute = dataPack.element("BarCodeAttribute");
			Element cebFile = dataPack.element("CEBFile");
			Element attFiles = dataPack.element("AttFiles");
			
			
			conn = DbManager.getInstance().getTransactionConnection();
			String attach_id = StringUtil.getUUID();
			String tmp_Path = gwConstant.tmp_zip_dir;
			File file = new File(tmp_Path);
			if(!file.exists()){
				file.mkdirs();
			}
			
			//  String issueLevel = barCodeAttribute.element("IssueLevel").getText(); //发布层次
			//	String archType = barCodeAttribute.element("ArchType").getText(); //文种
			//	String time = new SimpleDateFormat("HH:mm:ss").format(new Date(System.currentTimeMillis()));// 规范日期格式
			
			GwreceiveBean gwreceiveBean = this.getDispatchBean(archSechma, unitInfo);
			gwreceiveBean = getArchiveNumBean(archSechma, gwreceiveBean);
			gwreceiveBean.setAttach_id(attach_id);//将附件ID置入公文接受表。
			List<FileInfoBean> fileInfoBeanList = new ArrayList<FileInfoBean>();
			
			//获取正文
			FileInfoBean cebFileInfoBean = getCebBean(cebFile,attach_id);
			if(cebFileInfoBean!=null){
				fileInfoBeanList.add(cebFileInfoBean);
				gwreceiveBean.setFile_name(cebFileInfoBean.getFilename());
			}
			//获取附件
			List<FileInfoBean> attFileInfoBeanList = getAffixBeanList(attFiles,attach_id);
			if(attFileInfoBeanList!=null&&attFileInfoBeanList.size()>0){
				fileInfoBeanList.addAll(attFileInfoBeanList);
			}
			ReceiveGwDAO receiveGwDAO = new ReceiveGwDAOImpl();
			
			success = success&&receiveGwDAO.saveGwReceiveInfo(gwreceiveBean,conn);//保存公文基本信息
			success =  success&&receiveGwDAO.saveGwReceiveAttach(fileInfoBeanList,conn);// 保存附件信息
			
			
			//入库操作
			//oaArchiveHandlerIfc.recvArchive(filenames, content, gwreceiveBean, renameCebFile, attachFiles, con);
			
			if(success){
		    	out.print(successMsg);
		    }else{
				LOG.warn("ReceiveFounderArchiveServlet.doPost(HttpServletRequest, HttpServletResponse) - 数据入库异常,操作回退!", null);
				out.print(errorMsg);
		    }
			out.flush();
		} catch (DocumentException e) {
			success = false;
			LOG.error("解析公文传输的数据异常:"+e.getMessage(), e);
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} catch (SQLException e) {
			LOG.error("数据入库异常,操作回退:"+e.getMessage(), e);
			DbManager.rollBackNoThrow(conn);
			out.print(errorMsg);
		} catch (Exception e) {
			LOG.error("公文落地异常:"+e.getMessage(), e);
			DbManager.rollBackNoThrow(conn);
		} finally{
			PublicMethod.deleteFile(gwConstant.tmp_zip_dir);//删除临时附件
			if(conn != null){
				DbManager.closeConnection(conn);
			}
			if(null != out){
				out.close(); 
			}
		}
		
	}

	@Override
	public void destroy() {
		super.destroy();
	}

	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
	}

	/**
	 * 
	*<b>Summary: </b>
	* getDispatchBean(公文基本要素构造)
	* @param archSechma
	* @param UnitInfo
	* @param dispatchid
	* @return
	 */
	private GwreceiveBean getDispatchBean(Element archSechma,Element UnitInfo){
		//TODO 此分发里的公文要素请根据实际情况组装
		GwreceiveBean gwreceiveBean = new GwreceiveBean();
		//1、解析xml文件封装公文基本要素
		String archTitle = archSechma.element("ArchTitle").getText(); //标题
		String archKeyWords = archSechma.element("ArchKeyWords").getText(); //主题词
		String secretLevel = archSechma.element("SecretLevel").getText(); //密级
		String distributeLeader = archSechma.element("DistributeLeader").getText(); //签发领导
		String secretYear = archSechma.element("SecretYear").getText(); //保密期限
		//String archRemark = archSechma.element("ArchRemark").getText(); //备注
		//String rchFormTime = archSechma.element("ArchFormTime").getText(); //成文日期
		String exigenceLevel = archSechma.element("ExigenceLevel").getText(); //紧急程序
		String contact = archSechma.element("Contact").getText(); //紧急程序
		
		//String unitID = UnitInfo.element("UnitID").getText(); //单位代号
		//String unitName = UnitInfo.element("UnitName").getText(); //单位名称
		
		//gwreceiveBean.setId(dispatchid);
		//gwreceiveBean.setArchive_origin("1");  //1表示从外部系统导入的公文来源
		//gwreceiveBean.setBack_date(null);
		gwreceiveBean.setCaption(archKeyWords);
		gwreceiveBean.setContact_phone(contact);
		gwreceiveBean.setCreate_date("2013-12-30");
		//gwreceiveBean.setDispatch_type(archType);
		gwreceiveBean.setDispatch_type("");
		gwreceiveBean.setEffect_date(secretYear);
		gwreceiveBean.setIssign("false");
		gwreceiveBean.setKeyword("");
		gwreceiveBean.setSecrecy_grade(secretLevel);
		gwreceiveBean.setSend_org_addr("10000000000000000000");
		//gwreceiveBean.setSend_org_id(unitID);
		//gwreceiveBean.setSend_org_name(unitName);
		//gwreceiveBean.setSend_type("1");
		//gwreceiveBean.setSend_userid("70");
		//gwreceiveBean.setSend_userrealname(unitName);
		gwreceiveBean.setSender(distributeLeader);
		//gwreceiveBean.setSendscope(sendscope);
		gwreceiveBean.setTitle(archTitle);
		gwreceiveBean.setUrgency_grade(exigenceLevel);
		//gwreceiveBean.setCebid(ceb_id);
		//gwreceiveBean.setFile_type("ceb");//起草公文都是ceb
		gwreceiveBean.setSend_date(DateUtil.getCurrentDate());
		
		return gwreceiveBean;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* getArchiveNumBean(公文文号构造)
	* @param archSechma
	* @param dispatchid
	* @return
	 */
	private GwreceiveBean getArchiveNumBean(Element archSechma,GwreceiveBean gwreceiveBean){
		String archSerial = archSechma.element("ArchSerial").getText(); //文号:a[2008]11号
		
		gwreceiveBean.setPrefix(archSerial.substring(0, archSerial.indexOf("[")));
		//获取编号规则
		String[] serialnumberchar = StringUtil.getPropertiesChar("serialnumberchar",",");
		if(serialnumberchar==null || serialnumberchar.length!= 2){
			serialnumberchar[0] = "〔";
			serialnumberchar[1] = "〕";
		}
		gwreceiveBean.setSymbol(serialnumberchar[0]+archSerial.substring(archSerial.indexOf("[")+1, archSerial.indexOf("]"))+serialnumberchar[1]);
		gwreceiveBean.setSerial_number(archSerial.substring(archSerial.indexOf("]")+1, archSerial.length()-1));
		return gwreceiveBean;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* getAffixBean(返回公文正文BEAN)
	* @param cebFile
	* @param dispatchid
	* @return
	 * @throws Exception 
	 */
	private FileInfoBean getCebBean(Element cebFile,String attach_id) throws Exception{
		
		String cebFileName = cebFile.element("CEBFileName").getText();
		String cebContentLength = cebFile.element("CEBContentLength").getText();
		String cebContent = cebFile.element("CEBContent").getText();
		byte[] cebContent64 = this.getDecodeBase64byte(cebContent);
		String cebPath = gwConstant.tmp_zip_dir + cebFileName;
		FiletransferServiceImpl ft=new FiletransferServiceImpl();
		
		FileInfoBean filebean1 = new FileInfoBean();
		String uuid1 = FileUtils.randomUUID();
		String filetype1 = FileUtils.getFiletype(cebFileName);
		FileUtil.getFileFromBytes(cebContent64,cebPath);
		filebean1.setExtend(filetype1);
		filebean1.setDjbh(attach_id);
		filebean1.setDjsn(uuid1);
		filebean1.setFilename(cebFileName);
		filebean1.setAttachid(ft.getAttachId());
		filebean1.setFilepos(cebPath);
		filebean1.setUpload_mode("1");
		filebean1.setFileInput(new FileInputStream(cebPath));
		//filebean1.setAttachcontent(cebContent64);
		filebean1.setFilesize(cebContentLength);
		
		return filebean1;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* getAffixBean(返回公文附件BEAN)
	* @param cebFile
	* @param dispatchid
	* @return
	 * @throws Exception 
	 */
	private List<FileInfoBean> getAffixBeanList(Element affFile,String attach_id) throws Exception{
		List<FileInfoBean> fileInfoBeanList = new ArrayList<FileInfoBean>();
		@SuppressWarnings("unchecked")
		Iterator<Element> iter = affFile.elementIterator("Att") ;
		while(iter.hasNext()){
			Element att = (Element) iter.next();
			String attFileName = att.element("AttFileName").getText();
			String attContentLength = att.element("AttContentLength").getText();
			String attFilePath= att.element("AttFilePathNameInOA").getText();
			String attContent = att.element("AttContent").getText();
			String attPath = gwConstant.tmp_zip_dir + attFileName;
			byte[] attContent64 = this.getDecodeBase64byte(attContent);
			
			FiletransferServiceImpl ft=new FiletransferServiceImpl();
			
			
			FileInfoBean filebean1 = new FileInfoBean();
			String uuid1 = FileUtils.randomUUID();
			String filetype1 = FileUtils.getFiletype(attFileName);
			FileUtil.getFileFromBytes(attContent64,attPath);
			filebean1.setExtend(filetype1);
			filebean1.setDjbh(attach_id);
			filebean1.setDjsn(uuid1);
			filebean1.setFilename(attFileName);
			filebean1.setAttachid(ft.getAttachId());
			filebean1.setFilepos(attFilePath);
			filebean1.setUpload_mode("1");
			filebean1.setFileInput(new FileInputStream(attPath));
			//filebean1.setAttachcontent(attContent64);
			filebean1.setFilesize(attContentLength);
			
			fileInfoBeanList.add(filebean1);
		}
		return fileInfoBeanList;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* getDecodeBase64byte(base64解密成字节数组)
	* @param s
	* @return
	* @author chaun.lee
	 */
	public  byte[] getDecodeBase64byte(String s) {
		  if (s == null) return null;
		  BASE64Decoder decoder = new BASE64Decoder();
		  try {
		    byte[] b = decoder.decodeBuffer(s);
		    return b;
		  } catch (Exception e) {
		    return null;
		  }
	} 
}
