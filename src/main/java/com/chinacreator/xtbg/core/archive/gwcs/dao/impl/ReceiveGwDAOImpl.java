package com.chinacreator.xtbg.core.archive.gwcs.dao.impl;

import java.io.File;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.archive.gwcs.bean.GwreceiveBean;
import com.chinacreator.xtbg.core.archive.gwcs.bean.OctlDocumentBean;
import com.chinacreator.xtbg.core.archive.gwcs.bean.ReceiveGwHandleBean;
import com.chinacreator.xtbg.core.archive.gwcs.dao.ReceiveGwDAO;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.fancyuoload.entity.FileInfoBean;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
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
public class ReceiveGwDAOImpl extends XtDbBaseDao implements ReceiveGwDAO {
	
	/**
	 * 保存公文基本信息
	 * @param gwreceiveBean
	 * @return
	 */
	@Override
	public boolean saveGwReceiveInfo(GwreceiveBean gwreceiveBean, Connection conn) throws Exception{
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("insert into oa_gwreceive ");
		sql.append("  (gwreceive_id,title,prefix,symbol, ");
		sql.append("   serial_number,secrecy_grade,effect_date,urgency_grade, ");
		sql.append("   caption,keyword,dispatch_type,sender, ");
		sql.append("   sendscope,create_date,send_date,send_org_name, ");
		sql.append("   send_org_addr,sendusername,issign,contact_phone, ");
		sql.append("   recv_org_name,recv_org_addr,file_name,is_accept, ");
		sql.append("   attach_id,creator_time,pss_number) ");
		sql.append("values ");
		sql.append("  ('"+StringUtil.getUUID()+"',?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,sysdate,?) ");
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
		pdb.setString(14,gwreceiveBean.getSend_date().toString());
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
		pdb.setString(25,gwreceiveBean.getPss_number());
		pdb.executePrepared(conn);
		
		return true;
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
	public boolean saveGwReceiveAttach(List<FileInfoBean> fileInfoBeanList, Connection conn) throws Exception{
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("insert into oa_fc_attach ");
		sql.append("  (extend,djbh,filename,attachid, ");
		sql.append("   djsn,attachcontent,filepos,upload_mode, ");
		sql.append("   creator) ");
		sql.append("values ");
		sql.append("  (?, ?, ?, ?, ?, ?, ?, ?, ?) ");
		
		if(fileInfoBeanList.size() > 0) {
			int size = 0;
			for(int i = 0; i < fileInfoBeanList.size(); i++) {
				FileInfoBean fileInfoBean = (FileInfoBean) fileInfoBeanList.get(i);
				try{
					size = fileInfoBean.getFileInput().available();
				}catch(Exception e){
					continue;
				}
				pdb.preparedInsert(sql.toString());
				pdb.setString(1, fileInfoBean.getExtend());
				pdb.setString(2, fileInfoBean.getDjbh());
				pdb.setString(3, fileInfoBean.getFilename());
				pdb.setString(4, fileInfoBean.getAttachid());
				pdb.setString(5, fileInfoBean.getDjsn());
				//File attachfile = new File(fileInfoBean.getAttachcontent().toString());
				//pdb.setBlob(6, attachfile);
				pdb.setBinaryStream(6, fileInfoBean.getFileInput(),size);
				pdb.setString(7, fileInfoBean.getFilepos());
				pdb.setString(8, fileInfoBean.getUpload_mode());
				pdb.setString(9, fileInfoBean.getCreator());
				pdb.addPreparedBatch();
			}
			pdb.executePreparedBatch(conn);
		}
		return true;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findReceiveGwList
	  * @param bean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return 
	  * @see com.chinacreator.xtbg.core.archive.gwcs.dao.ReceiveGwDAO#findReceiveGwList(com.chinacreator.xtbg.core.archive.gwcs.bean.GwreceiveBean, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean findReceiveGwList(GwreceiveBean bean, String sortName,
			String sortOrder, long offset, int maxPagesize)throws Exception {
		Connection conn = null;
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			conn = DbManager.getInstance().getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append(" select gwreceive_id,title, ");
			sql.append(" prefix || symbol || serial_number  serial_number, ");
			sql.append(" caption,keyword,sender,create_date,send_date,send_org_name,file_name, ");
			sql.append(" attach_id,creator_time,is_accept,oa_org_id,o.org_name,g.insert_by_self from oa_gwreceive g left join  td_sm_organization o on g.oa_org_id=o.org_id where 1=1 ");
			
			if(bean!=null){
				if (!StringUtil.nullOrBlank(bean.getOa_org_id())) {
					sql.append(" and oa_org_id= ? ");
					condition.add(bean.getOa_org_id());
				}
				if (!StringUtil.nullOrBlank(bean.getTitle())) {
					sql.append(" and title like '%'||?||'%'");
					condition.add(bean.getTitle());
				}
				if (!StringUtil.nullOrBlank(bean.getSerial_number())) {
					sql.append(" and PSS_NUMBER like '%'||?||'%'");
					condition.add(bean.getSerial_number());
				}
				if(!StringUtil.isBlank(bean.getCreator_time().toString())){
					sql.append(" and creator_time  >= to_date('"+bean.getCreator_time()+" 00:00:00','yyyy-mm-dd hh24:mi:ss') ");
				}
				if(!StringUtil.isBlank(bean.getCreate_date())){
					sql.append(" and creator_time  <= to_date('"+bean.getCreate_date()+" 23:59:59','yyyy-mm-dd hh24:mi:ss') ");
				}
			}
			sql.append(" order by " + sortName + " " + sortOrder);
			
			pb=queryToPagingBean(sql.toString(), offset, maxPagesize, conn, condition);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findAttachid
	  * @param attach_id
	  * @param filename
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.gwcs.dao.ReceiveGwDAO#findAttachid(java.lang.String, java.lang.String, java.sql.Connection)
	 */
	public String findAttachid(String attach_id, String filename,
			Connection conn) throws Exception {
		String id="";
		String sql="select f.djsn from oa_fc_attach f,oa_gwreceive g where f.djbh=g.attach_id and g.attach_id=? and trim(f.filename)=? and 1=1 ";
		PreparedDBUtil db=new PreparedDBUtil();
		db.preparedSelect(sql);
		db.setString(1, StringUtil.deNull(attach_id));
		db.setString(2, StringUtil.deNull(filename));
		db.executePrepared(conn);
		if(db.size()>0){
			id=db.getString(0, "djsn");
		}
		return id;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findReceiveGw
	  * @param id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.gwcs.dao.ReceiveGwDAO#findReceiveGw(java.lang.String, java.sql.Connection)
	 */
	public Map<String, String> findReceiveGw(String id, Connection conn)
			throws Exception {
		String sql="select * from oa_gwreceive where gwreceive_id=? ";
		Map<String, String> map= queryToSingleMap(conn, sql, id);
		return map;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 updateGwReceivezd
	  * @param conn
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.gwcs.dao.ReceiveGwDAO#updateGwReceivezd(java.sql.Connection)
	 */
	public void updateGwReceivezd(String is_accept,String id,Connection conn) throws Exception {
		String sql="update oa_gwreceive set is_accept=? where gwreceive_id=?";
		PreparedDBUtil pdb=new PreparedDBUtil();
		pdb.preparedUpdate(sql);
		pdb.setString(1, is_accept);
		pdb.setString(2, id);
		pdb.executePrepared(conn);
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 updateGwReceivezd
	  * @param conn
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.gwcs.dao.ReceiveGwDAO#updateGwReceivezd(java.sql.Connection)
	 */
	public void updateGwReceivezdOrgId(String org_id,String id,Connection conn) throws Exception {
		String sql="update oa_gwreceive set oa_org_id =? where gwreceive_id=?";
		PreparedDBUtil pdb=new PreparedDBUtil();
		pdb.preparedUpdate(sql);
		pdb.setString(1, org_id);
		pdb.setString(2, id);
		pdb.executePrepared(conn);
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findReceiveGwHandleList
	  * @param bean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.gwcs.dao.ReceiveGwDAO#findReceiveGwHandleList(com.chinacreator.xtbg.core.archive.gwcs.bean.ReceiveGwHandleBean, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean findReceiveGwHandleList(ReceiveGwHandleBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		Connection conn = null;
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			conn = DbManager.getInstance().getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append(" select t_id,t_fj_id,t_zw_id,t_lwdw, ");
			sql.append(" t_lwrq,t_lwbh,t_lwbt,t_clqk, ");
			sql.append(" t_lsh,t_gwreceive_id,t_ins_id ");
			sql.append(" from t_lwgl where 1=1 ");
			
			if(bean!=null){
				
				if (!StringUtil.nullOrBlank(bean.getT_lwbt())) {
					sql.append(" and t_lwbt like '%'||?||'%'");
					condition.add(bean.getT_lwbt());
				}
				if (!StringUtil.nullOrBlank(bean.getT_lwbh())) {
					sql.append(" and t_lwbh like '%'||?||'%'");
					condition.add(bean.getT_lwbh());
				}
				
			}
			sql.append(" order by " + sortName + " " + sortOrder);
			
			pb=queryToPagingBean(sql.toString(), offset, maxPagesize, conn, condition);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	@Override
	public boolean UpdateGwReceiveOrgID(String id, String org_id,Connection conn)throws Exception {
		String sql="update oa_gwreceive set oa_org_id =? where gwreceive_id=?";
		PreparedDBUtil pdb=new PreparedDBUtil();
		pdb.preparedUpdate(sql);
		pdb.setString(1, org_id);
		pdb.setString(2, id);
		pdb.executePrepared(conn);
		return true;
	}

	@Override
	public String queryGwReceiveID(String ins_id, Connection conn) throws Exception{
		String t_gwreceive_id = "";
		String sql="select t_gwreceive_id from T_LWGL where t_ins_id = ? ";
		PreparedDBUtil pdb=new PreparedDBUtil();
		pdb.preparedSelect(sql);
		pdb.setString(1, ins_id);
		pdb.executePrepared(conn);
		if(pdb.size()>0){
			t_gwreceive_id = pdb.getString(0,"t_gwreceive_id");
		}
		return t_gwreceive_id;
	}
	/**
	 * 
	 */
	@Override
	public boolean deleteGwreceiveBeansById(Connection conn, String beanId)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("DELETE FROM oa_gwreceive");
		sql.append(" WHERE gwreceive_id = ?");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, beanId);
		pdb.executePrepared(conn);
		return true;
	}

	@Override
	public String getActDefByActId(String action_id, Connection conn)
			throws Exception {
		String actDefId = "";
		String sql="select * from oa_flow_wfaction t where t.action_id = ?";
		PreparedDBUtil pdb=new PreparedDBUtil();
		pdb.preparedSelect(sql);
		pdb.setString(1, action_id);
		pdb.executePrepared(conn);
		if(pdb.size()>0){
			actDefId = pdb.getString(0,"action_defid");
		}
		return actDefId;
	
	}

}
