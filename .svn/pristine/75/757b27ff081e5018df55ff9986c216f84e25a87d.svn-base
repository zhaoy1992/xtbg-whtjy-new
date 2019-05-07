package com.chinacreator.xtbg.pub.oagwcs.dao.imploracle;

import java.io.File;
import java.util.List;

import com.chinacreator.xtbg.pub.oagwcs.dao.ReceiveGwDAO;
import com.chinacreator.xtbg.pub.oagwcs.entity.FileInfoBean;
import com.chinacreator.xtbg.pub.oagwcs.entity.GwreceiveBean;
import com.chinacreator.xtbg.pub.oagwcs.entity.OctlDocumentBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:接收公文实现类</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南科创</p>
 *@author yiping.huang
 *@version 1.0
 *@date 2012-7-4
 */
public class ReceiveGwDAOImpl implements ReceiveGwDAO {
	
	/**
	 * 保存公文基本信息
	 * @param gwreceiveBean
	 * @return
	 */
	@Override
	public void saveGwReceiveInfo(GwreceiveBean gwreceiveBean) throws Exception{
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("insert into ta_oa_gwreceive ");
		sql.append("  (gwreceive_id,title,prefix,symbol, ");
		sql.append("   serial_number,secrecy_grade,effect_date,urgency_grade, ");
		sql.append("   caption,keyword,dispatch_type,sender, ");
		sql.append("   sendscope,create_date,send_date,send_org_name, ");
		sql.append("   send_org_addr,sendusername,issign,contact_phone, ");
		sql.append("   recv_org_name,recv_org_addr,file_name,is_accept, ");
		sql.append("   attach_id) ");
		sql.append("values ");
		sql.append("  (SEQ_TA_OA_GWRECEIVE.Nextval,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) ");
		pdb.preparedInsert(sql.toString());
		pdb.setString(1, gwreceiveBean.getTitle());
		pdb.setString(2, gwreceiveBean.getPrefix());
		pdb.setString(3, gwreceiveBean.getSymbol());
		
		pdb.setString(4, gwreceiveBean.getSerial_number());
		pdb.setString(5, gwreceiveBean.getSecrecy_grade());
		pdb.setString(6, gwreceiveBean.getEffect_date());
		pdb.setString(7, gwreceiveBean.getUrgency_grade());
		
		pdb.setString(8, gwreceiveBean.getCaption());
		pdb.setString(9, gwreceiveBean.getKeyword());
		pdb.setString(10, gwreceiveBean.getDispatch_type());
		pdb.setString(11, gwreceiveBean.getSender());
		

		pdb.setString(12,gwreceiveBean.getSendscope());
		pdb.setString(13, gwreceiveBean.getCreate_date());
		pdb.setString(14,gwreceiveBean.getSend_date());
		pdb.setString(15,gwreceiveBean.getSend_org_name());
		
		pdb.setString(16,gwreceiveBean.getSend_org_addr());
		pdb.setString(17, gwreceiveBean.getSendusername());
		pdb.setString(18,gwreceiveBean.getIssign());
		pdb.setString(19,gwreceiveBean.getContact_phone());
		
		pdb.setString(20,gwreceiveBean.getRecv_org_name());
		pdb.setString(21, gwreceiveBean.getRecv_org_addr());
		pdb.setString(22,gwreceiveBean.getFile_name());
		pdb.setString(23,gwreceiveBean.getIs_accept());
		
		pdb.setString(24,gwreceiveBean.getAttach_id());
		pdb.executePrepared();
		

	}
	
	/**
	 * 保存word信息
	 * @param 
	 * @param 
	 * @return
	 */
	@Override
	public void saveGwReceiveWord(OctlDocumentBean octlDocumentBean) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		
		if(octlDocumentBean != null) {
			sql.append("insert into TD_OCTL_Document ");
			sql.append("  (DocumentID,RecordID,Template, ");
			sql.append("   Subject,Author,FileDate, ");
			sql.append("   FileType,HtmlPath,Status) ");
			sql.append("values ");
			sql.append("  (?, ?, ?, ?, ?, to_date(?, 'yyyy-mm-dd hh24:mi:ss'), ?, ?, ?) ");
			pdb.preparedInsert(sql.toString());
			pdb.setString(1, octlDocumentBean.getDocumentid());
			pdb.setString(2, octlDocumentBean.getRecordid());
			pdb.setString(3, octlDocumentBean.getTemplate());
			pdb.setString(4, octlDocumentBean.getSubject());
			pdb.setString(5, octlDocumentBean.getAuthor());
			pdb.setString(6, octlDocumentBean.getFiledate());
			pdb.setString(7, octlDocumentBean.getFiletype());
			pdb.setString(8, octlDocumentBean.getHtmlpath());
			pdb.setString(9, octlDocumentBean.getStatus());
			pdb.addPreparedBatch();
			
			sql = new StringBuffer();
			sql.append("insert into document_file ");
			sql.append("  (fileid, recordid,filename,filetype, ");
			sql.append("   filedate, filebody, filepath,username, ");
			sql.append("   descript) ");
			sql.append("values ");
			sql.append("  (?, ?, ?, ?");
			sql.append(" , to_date(?, 'yyyy-mm-dd hh24:mi:ss'), ?, ?, ?");
			sql.append(" ,?)");
			pdb.preparedInsert(sql.toString());
			pdb.setString(1, "15");
			pdb.setString(2, octlDocumentBean.getRecordid());
			pdb.setString(3, octlDocumentBean.getRecordid() + ".doc");
			pdb.setString(4, octlDocumentBean.getFiletype());
			pdb.setString(5, octlDocumentBean.getFiledate());
			File attachfile = new File(octlDocumentBean.getHtmlpath());
			pdb.setBlob(6, attachfile);
			pdb.setString(7, octlDocumentBean.getHtmlpath());
			pdb.setString(8, octlDocumentBean.getAuthor());
			pdb.setString(9, "通用版本");
			
			pdb.addPreparedBatch();
			
			pdb.executePreparedBatch();
		}

	}
	
	/**
	 * 保存附件信息
	 * @param fileInfoBeanList 
	 * @return
	 */
	@Override
	public void saveGwReceiveAttach(List<FileInfoBean> fileInfoBeanList) throws Exception{
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("insert into fc_attach ");
		sql.append("  (extend,djbh,filename,attachid, ");
		sql.append("   djsn,attachcontent,filepos,upload_mode, ");
		sql.append("   creator) ");
		sql.append("values ");
		sql.append("  (?, ?, ?, ?, ?, ?, ?, ?, ?) ");
		
		if(fileInfoBeanList.size() > 0) {
			for(int i = 0; i < fileInfoBeanList.size(); i++) {
				pdb.preparedInsert(sql.toString());
				FileInfoBean fileInfoBean = (FileInfoBean) fileInfoBeanList.get(i);
				pdb.setString(1, fileInfoBean.getExtend());
				pdb.setString(2, fileInfoBean.getDjbh());
				pdb.setString(3, fileInfoBean.getFilename());
				pdb.setString(4, fileInfoBean.getAttachid());
				pdb.setString(5, fileInfoBean.getDjsn());
				File attachfile = new File(fileInfoBean.getAttachcontent());
				pdb.setBlob(6, attachfile);
				pdb.setString(7, fileInfoBean.getFilepos());
				pdb.setString(8, fileInfoBean.getUpload_mode());
				pdb.setString(9, fileInfoBean.getCreator());
				pdb.addPreparedBatch();
			}
			pdb.executePreparedBatch();
		}

	}

}
