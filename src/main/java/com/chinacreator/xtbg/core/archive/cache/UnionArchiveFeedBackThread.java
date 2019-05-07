package com.chinacreator.xtbg.core.archive.cache;

import java.io.File;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.archive.dao.WordArchiveDao;
import com.chinacreator.xtbg.core.archive.entity.ArchiveDispatchBean;
import com.chinacreator.xtbg.core.archive.gwcs.bean.GwConstant;
import com.chinacreator.xtbg.core.archive.gwcs.bean.Union;
import com.chinacreator.xtbg.core.archive.gwcs.bean.Union.Sign;
import com.chinacreator.xtbg.core.archive.gwcs.bean.UnionArchiveSignBean;
import com.chinacreator.gwcs.oa.service.UnionArchiveResponseBean;
import com.chinacreator.xtbg.core.archive.gwcs.services.OaSendArchiveService;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.FileUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.common.util.ZipUtil;
import com.chinacreator.xtbg.core.subsystemmanage.dao.SubSystemOrgConfigDao;
import com.chinacreator.xtbg.core.subsystemmanage.dao.impl.GwcsOrgConfigDaoImpl;
import com.chinacreator.xtbg.core.subsystemmanage.entity.OaGwcsConfigBean;
import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;

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
public class UnionArchiveFeedBackThread{
	private static final Log LOG = LogFactory.getLog(UnionArchiveFeedBackThread.class);
	private WordArchiveDao wordArchiveDaoImpl =  null;
	private OaSendArchiveService oaSendArchiveServiceImpl = null;
	private GwConstant gwConstant = new GwConstant();//公文传输常量
	
	private boolean unionused = true;//是否启动联合发文监控线程 默认为关闭
	
	public void setWordArchiveDaoImpl(WordArchiveDao wordArchiveDaoImpl) {
		this.wordArchiveDaoImpl = wordArchiveDaoImpl;
	}

	public void setOaSendArchiveServiceImpl(
			OaSendArchiveService oaSendArchiveServiceImpl) {
		this.oaSendArchiveServiceImpl = oaSendArchiveServiceImpl;
	}

	public void setUnionused(boolean unionused) {
		this.unionused = unionused;
	}

	public UnionArchiveFeedBackThread(){
		
	}
	
	public boolean feedback(){
		if(unionused){//如果开启
			//hsynchronized (lock) {
			ArchiveDispatchBean archiveDispatchBean = new ArchiveDispatchBean();
				//组装查询参数，将已经盖章发送成功的，没有公文发送的记录查询出来
				archiveDispatchBean.setIs_send("0");
				archiveDispatchBean.setUnion_archive_is_send("1");
				List<ArchiveDispatchBean> archiveDispatchBeanList = null;
				try {
					archiveDispatchBeanList = wordArchiveDaoImpl.getArchiveDispatchBeanList(archiveDispatchBean);
				} catch (Exception e1) {
					LOG.error("获取联合发文监控列表失败！",e1);
				}
				if(archiveDispatchBeanList!=null && archiveDispatchBeanList.size() >0 ){
				
					for(int i=0; i<archiveDispatchBeanList.size();i++){
						ArchiveDispatchBean archiveDispatchBean1 = archiveDispatchBeanList.get(i);
						String archiveXmlFilePath = gwConstant.tmp_zip_attch_path;
						String buss_id = archiveDispatchBean1.getUnion_archive_buss_id();
						try {
							//获取配置的wsdl地址。
							String send_org_config = archiveDispatchBean1.getSend_org_config();
							String unionArchiveSendWsdl = "";
							if(!StringUtil.isBlank(send_org_config)){
								SubSystemOrgConfigDao subSystemOrgConfigDao = (GwcsOrgConfigDaoImpl)LoadSpringContext.getApplicationContext().getBean("gwcsOrgConfigDaoImpl");
								OaGwcsConfigBean oaGwcsConfigBean = subSystemOrgConfigDao.getGwcsConfigByID(send_org_config);
								unionArchiveSendWsdl = oaGwcsConfigBean.getUnionarchivesendwsdl();
							}
							UnionArchiveResponseBean responseBean = oaSendArchiveServiceImpl.callUnionArchiveFeedBack(archiveDispatchBean1.getUnion_archive_buss_id(),unionArchiveSendWsdl);
							System.out.println(responseBean.getXmlName());
							archiveXmlFilePath = archiveXmlFilePath +"\\"+ buss_id;
							if(responseBean!= null){//将包写入磁盘路径
								FileUtil.getFileFromBytes(responseBean.getDh(),archiveXmlFilePath+"\\uniontmp.zip");
							
								//archiveXmlFilePath = new String(responseBean.getDh(),"GBK");
								ZipUtil zipUtil = new ZipUtil();
								zipUtil.unZipFile(archiveXmlFilePath+"\\uniontmp.zip", archiveXmlFilePath+"\\unionzipdir\\");
								String xmlName = responseBean.getXmlName();
								//解析XML
								String xmlPath = archiveXmlFilePath+"\\unionzipdir\\"+xmlName;
								XStream xstream = new XStream(new DomDriver());
								xstream.alias("union", Union.class);
								xstream.alias("signs", ArrayList.class);
								xstream.alias("sign", Union.Sign.class);
								
								Union union = (Union) xstream.fromXML(new FileReader(new File(xmlPath)));
								//更新盖章表
								if(union!=null){
									List<UnionArchiveSignBean> unionArchiveSignBeanList = this.getUnionSignBeanList(buss_id,union);
									wordArchiveDaoImpl.updateSignInfoList(unionArchiveSignBeanList,null);
									LOG.info(archiveDispatchBean1.getTitle()+buss_id+"联合盖章数据更新成功。");
								}else{
									LOG.info("未取到"+buss_id+"联合盖章数据。");
								}
							}
						} catch (Exception e) {
							LOG.error("联合盖章监控失败"+archiveDispatchBean1.getTitle()+buss_id,e);
						}
					}
				}
		//	}
		}
		return true;
	}

	/**
	 * 
	*<b>Summary: </b>
	* getUnionSignBeanList(组装联合签字的BEAN)
	* @param buss_id
	* @param sings
	* @return
	 */
	private List<UnionArchiveSignBean> getUnionSignBeanList(String buss_id, Union union) {
		List<UnionArchiveSignBean> unionArchiveSignBeanList = new ArrayList<UnionArchiveSignBean>();
		List<Sign> signs = union.getSigns();
		for(int i=0; i<signs.size();i++){
			Sign sign = signs.get(i);
			UnionArchiveSignBean unionArchiveSignBean = new UnionArchiveSignBean();
			unionArchiveSignBean.setSignorder(sign.getSignorder());
			unionArchiveSignBean.setIssigned(sign.getIssigned());
			unionArchiveSignBean.setTerminate(sign.getTerminate());
			unionArchiveSignBean.setIsstamping(sign.getIsstamping());
			unionArchiveSignBean.setStampdate(sign.getStampdate());
			unionArchiveSignBean.setBuss_id(buss_id);
			unionArchiveSignBean.setOrgaddr(sign.getOrgaddr());
			unionArchiveSignBeanList.add(unionArchiveSignBean);
		}
		return unionArchiveSignBeanList;
	}
	
}
