package com.chinacreator.xtbg.core.archive.gwcs.services.impl;

import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.chinacreator.xtbg.core.archive.entity.ArchiveDispatchBean;
import com.chinacreator.xtbg.core.archive.gwcs.bean.GwConstant;
import com.chinacreator.xtbg.core.archive.gwcs.bean.GwreceiveBean;
import com.chinacreator.xtbg.core.archive.gwcs.bean.Organization;
import com.chinacreator.xtbg.core.archive.gwcs.bean.ReceiveGwcsXmlBean;
import com.chinacreator.xtbg.core.archive.gwcs.dao.ReceiveGwDAO;
import com.chinacreator.xtbg.core.archive.gwcs.dao.impl.ReceiveGwDAOImpl;
import com.chinacreator.xtbg.core.archive.gwcs.services.OaArchiveHandlerIfc;
import com.chinacreator.xtbg.core.archive.service.WordArchiveService;
import com.chinacreator.xtbg.core.archive.service.impl.WordArchiveServiceImpl;
import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.fancyuoload.entity.FileInfoBean;
import com.chinacreator.xtbg.core.common.fancyuoload.service.FiletransferService;
import com.chinacreator.xtbg.core.common.fancyuoload.service.impl.FiletransferServiceImpl;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.subsystemmanage.dao.SubSystemOrgConfigDao;
import com.chinacreator.xtbg.core.subsystemmanage.entity.GwcsOrgBean;

/**
 * 
 *<p>Title:OaArchiveHandlerCommonImpl.java</p>
 *<p>Description:通用的公文传输落地数据处理实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 夏天
 *@version 1.0
 *Aug 9, 2013
 */
public class OaArchiveHandlerCommonImpl implements OaArchiveHandlerIfc {
	private SubSystemOrgConfigDao subSystemOrgConfigDao = null;//外部子系统机构配置dao
	private GwConstant gwConstant;//公文传输常量
	
	public void setSubSystemOrgConfigDao(SubSystemOrgConfigDao subSystemOrgConfigDao) {
		this.subSystemOrgConfigDao = subSystemOrgConfigDao;
	}

	public void setGwConstant(GwConstant gwConstant) {
		this.gwConstant = gwConstant;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 gwcsOrgSynInitHandler
	  * @param content
	  * @param organizations
	  * @param con
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.gwcs.services.OaArchiveHandlerIfc#gwcsOrgSynInitHandler(byte[], java.util.ArrayList, java.sql.Connection)
	 */
	public void gwcsOrgSynInitHandler(byte[] content,
			ArrayList<Organization> organizations, Connection con) throws Exception {
		GwcsOrgBean gwcsOrgBean = null;
		List<GwcsOrgBean> gwcsOrgBeanList = new ArrayList<GwcsOrgBean>();
		/*将list<公文传输机构bean>存入数据库*/
		 for(int i = 0 ; i < organizations.size() ; i ++){
			 gwcsOrgBean = new GwcsOrgBean();
			 gwcsOrgBean.setOrg_id(organizations.get(i).getOrg_id());
			 gwcsOrgBean.setOrg_name(organizations.get(i).getOrg_name());
			 gwcsOrgBean.setOrg_addr(organizations.get(i).getOrg_addr());
			 gwcsOrgBean.setParent_id(organizations.get(i).getParent_id());
			 gwcsOrgBean.setIsouter(organizations.get(i).getOuter());
			 gwcsOrgBeanList.add(gwcsOrgBean);
		 }
		 gwcsOrgBean = new GwcsOrgBean();
		 ((BaseDao)subSystemOrgConfigDao).delete(gwcsOrgBean.clearDeleteKey(), con);
		 ((BaseDao)subSystemOrgConfigDao).insertBatch(gwcsOrgBeanList, con);

	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 gwcsOrgSynSingleOrg2DbHandler
	  * @param content
	  * @param organization
	  * @param con
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.gwcs.services.OaArchiveHandlerIfc#gwcsOrgSynSingleOrg2DbHandler(byte[], com.chinacreator.xtbg.core.archive.gwcs.bean.Organization, java.sql.Connection)
	 */
	public void gwcsOrgSynSingleOrg2DbHandler(byte[] content,
			Organization organization, Connection con) throws Exception {
		String operate = "";//操作单个公文传输机构bean的类型
		 GwcsOrgBean gwcsOrgBean = new GwcsOrgBean();
		 gwcsOrgBean.setOrg_id(organization.getOrg_id());
		 gwcsOrgBean.setOrg_name(organization.getOrg_name());
		 gwcsOrgBean.setOrg_addr(organization.getOrg_addr());
		 gwcsOrgBean.setParent_id(organization.getParent_id());
		 gwcsOrgBean.setIsouter(organization.getOuter());
		 operate = organization.getOperate();
		 if(gwConstant.gwcs_org_operate_insert.equals(operate)){//新增
			 ((BaseDao)subSystemOrgConfigDao).delete(gwcsOrgBean, con); 
			 ((BaseDao)subSystemOrgConfigDao).insert(gwcsOrgBean, con); 
		 }else if(gwConstant.gwcs_org_operate_update.equals(operate)){//更新
			 ((BaseDao)subSystemOrgConfigDao).update(gwcsOrgBean, con); 
		 }else if(gwConstant.gwcs_org_operate_delete.equals(operate)){//删除
			 ((BaseDao)subSystemOrgConfigDao).delete(gwcsOrgBean, con); 
		 }

	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 recvArchive
	  * @param filenames
	  * @param content
	  * @param receiveGwcsXmlBean
	  * @param cebFile
	  * @param attachFiles
	  * @param con
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.gwcs.services.OaArchiveHandlerIfc#recvArchive(java.lang.String, byte[], com.chinacreator.xtbg.core.archive.gwcs.bean.ReceiveGwcsXmlBean, java.io.File, java.util.List, java.sql.Connection)
	 */
	public void recvArchive(String filenames, byte[] content,
			ReceiveGwcsXmlBean receiveGwcsXmlBean, File cebFile,
			List<File> attachFiles, Connection con) throws Exception {
		ReceiveGwDAO dao=new ReceiveGwDAOImpl();
		GwreceiveBean gwreceiveBean = new GwreceiveBean();
		//设置公文接收的基本信息
		gwreceiveBean.setPrefix(receiveGwcsXmlBean.getNum().getPrefix());//文号前缀
		gwreceiveBean.setSymbol((receiveGwcsXmlBean.getNum().getSymbol()));//文号年份
		gwreceiveBean.setSerial_number(receiveGwcsXmlBean.getNum().getSerial_number());//文号
		gwreceiveBean.setTitle(receiveGwcsXmlBean.getTitle());//公文标题
		gwreceiveBean.setSecrecy_grade(receiveGwcsXmlBean.getSecrecy_grade());//公文密级
		gwreceiveBean.setEffect_date(receiveGwcsXmlBean.getEffect_date());//保密期限
		gwreceiveBean.setUrgency_grade(receiveGwcsXmlBean.getUrgency_grade());//紧急程度
		gwreceiveBean.setCaption(receiveGwcsXmlBean.getCaption());//主题词
		gwreceiveBean.setKeyword(receiveGwcsXmlBean.getKeyword());//关键词
		gwreceiveBean.setDispatch_type(receiveGwcsXmlBean.getDispatch_type());//文种
		gwreceiveBean.setSender(receiveGwcsXmlBean.getSender());//公签发人
		gwreceiveBean.setSendscope(receiveGwcsXmlBean.getSendscope());//发布层次
		gwreceiveBean.setCreate_date(receiveGwcsXmlBean.getCreate_date());//成文时间
		gwreceiveBean.setSend_date(receiveGwcsXmlBean.getSend_date());//公文发送时间
		gwreceiveBean.setSend_org_name(receiveGwcsXmlBean.getSend_org_name());//发文单位机构名称
		gwreceiveBean.setSend_org_addr(receiveGwcsXmlBean.getSend_org_addr());//发文单位20位地址码
		gwreceiveBean.setSendusername(receiveGwcsXmlBean.getSendusername());//发文操作的用户名称
		gwreceiveBean.setIssign(receiveGwcsXmlBean.getIssign());//是否加盖电子印章
		gwreceiveBean.setContact_phone(receiveGwcsXmlBean.getContact_phone());//如果遇到问题，收文用户可以询问公文相关情况的联系方式
		gwreceiveBean.setRecv_org_name(receiveGwcsXmlBean.getRecv_org_name());//收文单位机构名称
		gwreceiveBean.setRecv_org_addr(receiveGwcsXmlBean.getRecv_org_addr());//recv_org_addr表示收文单位的20位地址码，20位的数字
		gwreceiveBean.setFile_name(receiveGwcsXmlBean.getFile_name());//公文文件名称
		gwreceiveBean.setPss_number(receiveGwcsXmlBean.getNum().getPrefix()+receiveGwcsXmlBean.getNum().getSymbol()+receiveGwcsXmlBean.getNum().getSerial_number());
		gwreceiveBean.setIs_accept("0");//是否已受理
		String attach_id=StringUtil.getUUID();
		gwreceiveBean.setAttach_id(attach_id);//附件
		
		dao.saveGwReceiveInfo(gwreceiveBean,null);//保存公文基本信息
		
		//保存附件
		String mFilePath = gwConstant.tmp_zip_dir;
		File filePath = new File(mFilePath);
		if(!filePath.exists()){
			filePath.mkdirs();
		}
		FiletransferService ft = new FiletransferServiceImpl();
		List<FileInfoBean> listFileInfoBean = new ArrayList<FileInfoBean>();
		
		FileInfoBean filebean1 = new FileInfoBean();
		String reportAbsFilePath1 = mFilePath + cebFile.getName();
		filebean1.setExtend(cebFile.getName().substring(cebFile.getName().lastIndexOf(".")));
		filebean1.setDjbh(attach_id);
		filebean1.setDjsn(StringUtil.getUUID());
		filebean1.setFilename(cebFile.getName());
		filebean1.setAttachid(ft.getAttachId());
		filebean1.setFilepos(reportAbsFilePath1);
		filebean1.setUpload_mode("1");
		filebean1.setFileInput(new FileInputStream(cebFile));
		filebean1.setCreator("zhangsan");
		listFileInfoBean.add(filebean1);
		
		
		for (File file : attachFiles) {
			String reportAbsFilePath = mFilePath + file.getName(); //新文件名文件保存路径
			// 保存数据库业务 到列表
			FileInfoBean filebean = new FileInfoBean();
			filebean.setExtend(file.getName().substring(file.getName().lastIndexOf(".")));
			filebean.setDjbh(attach_id);
			filebean.setDjsn(StringUtil.getUUID());
			filebean.setFilename(file.getName());
			filebean.setAttachid(ft.getAttachId());
			filebean.setFilepos(reportAbsFilePath);
			filebean.setUpload_mode("1");
			filebean.setFileInput(new FileInputStream(file));
			filebean.setCreator("zhangsan");
			listFileInfoBean.add(filebean);
		}
		ft.saveFile(listFileInfoBean);
		//CAB
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 recvCebFileHandler
	  * @param uuid
	  * @param content
	  * @param cebFile
	  * @param con
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.gwcs.services.OaArchiveHandlerIfc#recvCebFileHandler(java.lang.String, byte[], java.io.File, java.sql.Connection)
	 */
	public void recvCebFileHandler(String uuid, byte[] content, File cebFile,
			Connection con) throws Exception {
		//这里调用发送接口
		Connection conn = null;
		WordArchiveService service = new WordArchiveServiceImpl();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			//TODO 根据UUID将公文要素表是否盖章成功置为1.
			if(!StringUtil.isBlank(uuid)){
				//盖章成功置为1
				service.updateGz("1", uuid);
				//根据UUID获取公文要素参数
				ArchiveDispatchBean archiveDispatchBean = service.getArchiveDispatch(uuid);
				//调用公文发送接口
				if(archiveDispatchBean != null){
					if("1".equals(archiveDispatchBean.getUnion_archive())){//如果是联合发文，先调用联合盖章发送
						service.sendUnionArchive(archiveDispatchBean, uuid);
					}else{//普通发文，直接调用发文线程
						service.sendToArchive(archiveDispatchBean, uuid);
					}
				}else{
					throw new Exception("无法根据UUID获取公文要素！");
				}
			}
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
		}finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		
		
		
	}





}
