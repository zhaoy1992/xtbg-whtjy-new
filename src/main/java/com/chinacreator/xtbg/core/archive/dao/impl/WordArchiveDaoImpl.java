
 /**
 * [Product]
  *     xtbgbase
  * [Copyright]
  *     Copyright © 2013 ICSS All Rights Reserved.
  * [FileName]
  *     WordArchiveDaoImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2013-8-30   Administrator    最初版本
   */
package com.chinacreator.xtbg.core.archive.dao.impl;

import java.io.File;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.archive.dao.WordArchiveDao;
import com.chinacreator.xtbg.core.archive.entity.ArchiveDispatchBean;
import com.chinacreator.xtbg.core.archive.entity.OaWordNumberBean;
import com.chinacreator.xtbg.core.archive.gwcs.bean.ArchiveAddrBean;
import com.chinacreator.xtbg.core.archive.gwcs.bean.ArchiveGwcsXmlBean.Sign;
import com.chinacreator.xtbg.core.archive.gwcs.bean.GwConstant;
import com.chinacreator.xtbg.core.archive.gwcs.bean.UnionArchiveSignBean;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.entity.XtShowInfoHashMap;
import com.chinacreator.xtbg.core.common.fancyuoload.service.FiletransferService;
import com.chinacreator.xtbg.core.common.fancyuoload.service.impl.FiletransferServiceImpl;
import com.chinacreator.xtbg.core.common.fancyuoload.util.FileUtils;
import com.chinacreator.xtbg.core.common.util.DateUtil;
import com.chinacreator.xtbg.core.common.util.FileUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.frameworkset.common.poolman.DBUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:WordArchiveDaoImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-8-30
 */
public class WordArchiveDaoImpl implements WordArchiveDao {
	
	/** 
	 * <b>Summary: </b>
	 *     复写方法 getNumberByBusiId
	 * @param busi_id
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.archive.dao.WordArchiveDao#getNumberByBusiId(java.lang.String) 
	 */
	@Override
	public int getNumberByBusiId(String busi_id,String number_year,String number_type, Connection conn) throws Exception {
		int maxCode = -1;
		if(!StringUtil.nullOrBlank(busi_id)){
			String sql = "select number_code  from oa_word_number where busi_id  = ? and number_year=? and number_type=? ";
			PreparedDBUtil pdb = new PreparedDBUtil();
			pdb.preparedSelect(sql);
			pdb.setString(1, busi_id);
			pdb.setString(2, number_year);
			pdb.setString(3, number_type);
			pdb.executePrepared();
			if(pdb.size()>0){
				maxCode = pdb.getInt(0, "number_code");
			}
		}
		return maxCode;
	}
	public boolean isNumber(String number_year,String number_type, String number_code,Connection conn) throws Exception {
		boolean flag = false;
		if(!StringUtil.nullOrBlank(number_code)){
			String sql = "select count(*) count  from oa_word_number where number_code  = ? and number_year=? and number_type=? ";
			PreparedDBUtil pdb = new PreparedDBUtil();
			pdb.preparedSelect(sql);
			pdb.setString(1, number_code);
			pdb.setString(2, number_year);
			pdb.setString(3, number_type);
			pdb.executePrepared();
			if(pdb.size()>0){
				if(pdb.getInt(0, "count")>0){
					flag=true;
				}
			}
		}
		return flag;
	}
	

	//特检院OA  查询是否存在公文编号 2014-06-23 start
	/**
	*<b>Summary: </b>
	* isArchiveNumberBybusId(查询是否存在公文编号)
	* @param busi_id
	* @param number_type
	* @param number_year
	* @return
	 */
	public boolean isNumberByBusId(String busi_id,Connection conn) throws Exception{
		boolean flag = false;
		String sql = "select count(*) count  from oa_word_number where busi_id  = ?  ";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql);
		pdb.setString(1, busi_id);
		pdb.executePrepared();
		if(pdb.size()>0){
			if(pdb.getInt(0, "count")>0){
				flag=true;
			}
		}
		return flag;
	}
	/**
	*<b>Summary: </b>
	* isArchivReadyNmuberByBusId(查询公文编号是否已经被占用了)
	* @param busi_id
	* @param number_type
	* @param number_year
	* @param number_year
	* @return
	*/
	public boolean isArchivReadyNmuberByBusId(String busi_id,String number_type,String number_year,String number_code,Connection conn) throws Exception{
		boolean flag = false;
		String sql = "select count(*) count  from oa_word_number where busi_id  = ? and number_type=? and number_year=? and number_code=? ";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql);
		pdb.setString(1, busi_id);
		pdb.setString(2, number_type);
		pdb.setString(3, number_year);
		pdb.setString(4, number_code);
		pdb.executePrepared();
		if(pdb.size()>0){
			if(pdb.getInt(0, "count")>0){
				flag=true;
			}
		}
		return flag;
	}
	//特检院OA  查询是否存在公文编号 2014-06-23 end

	/** 
	 * <b>Summary: </b>
	 *     复写方法 getNumberByTypeYear
	 * @param number_type
	 * @param number_year
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.archive.dao.WordArchiveDao#getNumberByTypeYear(java.lang.String, java.lang.String) 
	 */
	@Override
	public int getNumberByTypeYear(String number_type, String number_year, Connection conn)
			throws Exception {
		int maxCode = 1;
		String sql = "select nvl(max(number_code),0)+1 maxCode  from oa_word_number where number_type = ? and number_year = ? ";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql);
		pdb.setString(1, number_type);
		pdb.setString(2, number_year);
		pdb.executePrepared();
		if(pdb.size()>0){
			maxCode = pdb.getInt(0, "maxCode");
		}
		return maxCode;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 saveNumber
	  * @param oaWordNumberBean
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.dao.WordArchiveDao#saveNumber(com.chinacreator.xtbg.core.archive.entity.OaWordNumberBean) 
	  */
	@Override
	public boolean saveNumber(OaWordNumberBean oaWordNumberBean,Connection conn)throws Exception {
		boolean flag = true;
		//特检院OA 2014-06-13 start 编号可以为空
		StringBuffer sql = new StringBuffer("insert into oa_word_number(busi_id,number_type,number_year,");
		if(!StringUtil.isBlank(oaWordNumberBean.getNumber_code())){
			sql.append(" number_code,");
		}
		sql.append(" archive_user,archive_date, number_title,is_paper,archive_userid,archive_title) values (?,?,?," );
		if(!StringUtil.isBlank(oaWordNumberBean.getNumber_code())){
			sql.append(" ?, ");
		}
		sql.append("  ?,?,?,'0',?,?) ");
		PreparedDBUtil pdb = new PreparedDBUtil();
		int i =1;
		pdb.preparedInsert(sql.toString());
		pdb.setString(i++, oaWordNumberBean.getBusi_id());
		pdb.setString(i++, oaWordNumberBean.getNumber_type());
		pdb.setString(i++, oaWordNumberBean.getNumber_year());
		if(!StringUtil.isBlank(oaWordNumberBean.getNumber_code())){
			pdb.setInt(i++, Integer.parseInt(oaWordNumberBean.getNumber_code()));
		}
		pdb.setString(i++, oaWordNumberBean.getArchive_user());
		pdb.setString(i++, oaWordNumberBean.getArchive_date());
		pdb.setString(i++, oaWordNumberBean.getNumber_title());
		pdb.setString(i++, oaWordNumberBean.getArchive_userid());
		pdb.setString(i++, oaWordNumberBean.getArchive_title());
		//特检院OA 2014-06-13 end 编号可以为空
		pdb.executePrepared();
		return flag;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 updateNumber
	  * @param oaWordNumberBean
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.dao.WordArchiveDao#updateNumber(com.chinacreator.xtbg.core.archive.entity.OaWordNumberBean) 
	  */
	@Override
	public boolean updateNumber(OaWordNumberBean oaWordNumberBean,Connection conn) throws Exception {
		boolean flag = true;
		//特检院OA 2014-06-13 start 编号可以为空
		String sql = "update oa_word_number set number_type = ?, number_year = ?, ";
		if(!StringUtil.isBlank(oaWordNumberBean.getNumber_code())){
			sql+="number_code = ?,";
		}
		sql+=" archive_user = ?,archive_date = ?, number_title = ?,archive_userid = ?  where  busi_id = ?";
		PreparedDBUtil pdb = new PreparedDBUtil();
		int i=1;
		pdb.preparedUpdate(sql);
		pdb.setString(i++, oaWordNumberBean.getNumber_type());
		pdb.setString(i++, oaWordNumberBean.getNumber_year());
		if(!StringUtil.isBlank(oaWordNumberBean.getNumber_code())){
			pdb.setInt(i++, Integer.parseInt(oaWordNumberBean.getNumber_code()));
		}
		pdb.setString(i++, oaWordNumberBean.getArchive_user());
		pdb.setString(i++, oaWordNumberBean.getArchive_date());
		pdb.setString(i++, oaWordNumberBean.getNumber_title());
		pdb.setString(i++, oaWordNumberBean.getArchive_userid());
		pdb.setString(i++, oaWordNumberBean.getBusi_id());
		//特检院OA 2014-06-13 end 编号可以为空
		pdb.executePrepared();
		return flag;
	}

	 /** 
	  * <b>Summary: </b>
	  *     复写方法 delNumber
	  * @param number_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.dao.WordArchiveDao#delNumber(java.lang.String) 
	  */
	@Override
	public boolean delNumber(String busi_id,Connection conn) throws Exception {
		boolean flag = true;
		String sql = "delete from  oa_word_number  where  busi_id = ?";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedDelete(sql);
		pdb.setString(1, busi_id);
		pdb.executePrepared();
		return flag;
	}

	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getNumber
	  * @param busi_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.dao.WordArchiveDao#getNumber(java.lang.String) 
	  */
	@Override
	public OaWordNumberBean getNumber(String busi_id) throws Exception {
		OaWordNumberBean oaWordNumberBean = null;
		String sql = "select busi_id,number_type,number_year,number_code,archive_userid,archive_user,archive_date,number_title from  oa_word_number where  busi_id = ?";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql);
		pdb.setString(1, busi_id);
		pdb.executePrepared();
		if(pdb.size() >0){
			oaWordNumberBean = new OaWordNumberBean();
			oaWordNumberBean.setBusi_id(busi_id);
			oaWordNumberBean.setNumber_type(pdb.getString(0,"number_type"));
			oaWordNumberBean.setNumber_year(pdb.getString(0,"number_year"));
			oaWordNumberBean.setNumber_code(pdb.getString(0,"number_code"));
			oaWordNumberBean.setArchive_userid(pdb.getString(0,"archive_userid"));
			oaWordNumberBean.setArchive_user(pdb.getString(0,"archive_user"));
			oaWordNumberBean.setArchive_date(pdb.getString(0,"archive_date"));
			oaWordNumberBean.setNumber_title(pdb.getString(0,"number_title"));
		}
		return oaWordNumberBean;
	}

	@Override
	public PagingBean findWordNumberList(OaWordNumberBean bean, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<OaWordNumberBean> list = new ArrayList<OaWordNumberBean>();
		StringBuffer sql = new StringBuffer();
		sql.append(" select t.busi_id , ");
		sql.append(" t.archive_date, ");
		sql.append("decode((select inst.ins_name");
		sql.append("                from oa_flow_instance inst");
		sql.append("               where inst.busi_id = t.busi_id),");
		sql.append("              '',");
		sql.append("              t.archive_title,");
		sql.append("              (select inst.ins_name");
		sql.append("                 from oa_flow_instance inst");
		sql.append("                where inst.busi_id = t.busi_id)) archive_title,");
		sql.append(" t.archive_user, ");
		sql.append(" t.number_code, ");
		sql.append(" t.number_title, ");
		sql.append(" f.number_type, ");
		sql.append(" f.number_year, ");
		sql.append(" decode(t.is_paper,'0','否','1','是') as is_paper ");
		sql.append(" from OA_WORD_NUMBER t ");
		sql.append(" left join oa_word_number_def f  on t.number_type = f.number_type and t.number_year=f.number_year   where 1 = 1");
		if(!StringUtil.nullOrBlank(bean.getNumber_type())){
			sql.append(" and t.number_type = '"+bean.getNumber_type()+"'");	
		}
		if(!StringUtil.nullOrBlank(bean.getNumber_year())){
			sql.append(" and t.number_year = '"+bean.getNumber_year()+"'");	
		}
		if(!StringUtil.nullOrBlank(bean.getArchive_title())){
			sql.append(" and t.archive_title like '%"+bean.getArchive_title()+"%'");	
		}
		if(!StringUtil.nullOrBlank(bean.getArchive_date())){
			sql.append(" and to_date(t.archive_date,'yyyy-mm-dd') >= to_date('"+bean.getArchive_date()+"','yyyy-MM-dd')");	
		}
		if(!StringUtil.nullOrBlank(bean.getEnddate())){
			sql.append(" and to_date(t.archive_date,'yyyy-mm-dd') <= to_date('"+bean.getEnddate()+"','yyyy-MM-dd')");
		}
		sql.append(" order by " + sortName + " " + sortOrder);
		try {
			db.preparedSelect(sql.toString(), offset, maxPagesize);
			db.executePrepared();
			for(int i = 0 ; i < db.size() ; i++){
				OaWordNumberBean cBean = new OaWordNumberBean();
				cBean.setBusi_id(db.getString(i,"busi_id"));
				cBean.setArchive_date(db.getString(i,"archive_date"));
				cBean.setArchive_title(db.getString(i,"archive_title"));
				//cBean.setNumber_code(db.getString(i,"dictdata_name")+"["+db.getString(i,"year_name")+"]"+db.getString(i,"number_code"));
				cBean.setNumber_code(db.getString(i,"number_code"));
				cBean.setArchive_user(db.getString(i,"archive_user"));
				cBean.setIs_paper(db.getString(i,"is_paper"));
				cBean.setNumber_title(db.getString(i,"number_title"));
				list.add(cBean);
			}
		} catch (SQLException e) {
			e.getMessage();
		}
		 pb.setList(list);
		 pb.setRecords((long)db.getTotalSize());
		return pb;
	}

	@Override
	public boolean savepaperNumber(OaWordNumberBean oaWordNumberBean,
			Connection conn) throws Exception {
		boolean flag = true;
		String sql = "insert into oa_word_number(busi_id,number_type,number_year,number_code,archive_title," +
					 " archive_date,archive_user,is_paper,archive_type,number_title,archive_userid) values (?,?,?,?,?,to_char(sysdate,'yyyy-mm-dd'),?,?,?,?,?)";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedInsert(sql);
		pdb.setString(1, oaWordNumberBean.getBusi_id());
		pdb.setString(2, oaWordNumberBean.getNumber_type());
		pdb.setString(3, oaWordNumberBean.getNumber_year());
		pdb.setInt(4, Integer.parseInt(oaWordNumberBean.getNumber_code()));
		pdb.setString(5, oaWordNumberBean.getArchive_title());
		pdb.setString(6, oaWordNumberBean.getArchive_user());
		pdb.setString(7, oaWordNumberBean.getIs_paper());
		pdb.setString(8, oaWordNumberBean.getArchive_type());
		pdb.setString(9, oaWordNumberBean.getNumber_title());
		pdb.setString(10, oaWordNumberBean.getArchive_userid());
		pdb.executePrepared();
		return flag;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getWordNumber
	  * @param org_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.dao.WordArchiveDao#getWordNumber(java.lang.String) 
	  */
	@Override
	public List<OaWordNumberBean> getWordNumber(String org_id) throws Exception {
		List<OaWordNumberBean> oaWordNumberBeanList = new ArrayList<OaWordNumberBean>();
		String sql = "select t.number_type,t.number_year from oa_word_number_def t where (INSTR(t.number_org_id, ?) > 0  or t.number_org_id is null) order by t.number_year desc,number_order";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql);
		pdb.setString(1, org_id);
		pdb.executePrepared();
		for(int i=0; i< pdb.size(); i++){
			OaWordNumberBean oaWordNumberBean = new OaWordNumberBean();
			oaWordNumberBean.setNumber_type(pdb.getString(i,"number_type"));
			oaWordNumberBean.setNumber_year(pdb.getString(i,"number_year"));
			oaWordNumberBeanList.add(oaWordNumberBean);
		}
		return oaWordNumberBeanList;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getTextByte
	  * @param mRecordID
	  * @return 
	  * @see com.chinacreator.xtbg.core.archive.dao.WordArchiveDao#getTextByte(java.lang.String) 
	  */
	@Override
	public byte[] getTextByte(String mRecordID)  throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		byte[] fib = null;
		sql.append("select filebody from oa_document_File t where t.recordid = ?");
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, mRecordID);
		pdb.executePrepared();
		if (pdb.size() > 0) {
			Blob blob = pdb.getBlob(0, "filebody");
			if (blob != null) {
				fib = pdb.getByteArray(0, "filebody");
			}
		}
		return fib;
	}
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 saveWordCeb
	  * @param uuid
	  * @param conn 
	  * @see com.chinacreator.xtbg.core.archive.dao.WordArchiveDao#saveWordCeb(java.lang.String, java.sql.Connection) 
	  */
	@Override
	public boolean saveWordCeb(String ins_id, String uuid , Connection conn) throws Exception{
		boolean flag = true;
		String sql = "insert into oa_ceb_word(ins_id,ceb_id) values (?,?)";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedInsert(sql);
		pdb.setString(1, ins_id);
		pdb.setString(2, uuid);
		pdb.executePrepared(conn);
		return flag;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 selWordCeb
	  * @param ins_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.dao.WordArchiveDao#selWordCeb(java.lang.String, java.sql.Connection) 
	  */
	@Override
	public String selWordCeb(String ins_id, Connection conn) throws Exception {
		String uuid = "";
		String sql = "select ceb_id  from oa_ceb_word where ins_id = ? ";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql);
		pdb.setString(1, ins_id);
		pdb.executePrepared(conn);
		if(pdb.size()>0){
			uuid = pdb.getString(0,"ceb_id");
		}else{
			uuid = "-1";//如果不存在，返回-1
		}
		return uuid;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 updateWordCeb
	  * @param ins_id
	  * @param uuid
	  * @param conn
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.dao.WordArchiveDao#updateWordCeb(java.lang.String, java.lang.String, java.sql.Connection) 
	  */
	@Override
	public boolean updateWordCeb(String ins_id, String uuid, Connection conn)
			throws Exception {
		boolean flag = true;
		String sql = "update oa_ceb_word set ceb_id = ? where ins_id = ? ";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql);
		pdb.setString(1, uuid);
		pdb.setString(2, ins_id);
		pdb.executePrepared(conn);
		return flag;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 delArchiveDispatch
	  * @param ins_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.dao.WordArchiveDao#delArchiveDispatch(java.lang.String, java.sql.Connection) 
	  */
	@Override
	public boolean delArchiveDispatch(String ins_id, Connection conn)
			throws Exception {
		boolean flag = true;
		String sql = "delete from oa_archive_dispatch where ins_id = ?";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedDelete(sql);
		pdb.setString(1, ins_id);
		pdb.executePrepared(conn);
		return flag;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 saveArchiveDispatch
	  * @param archiveDispatchBean
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.dao.WordArchiveDao#saveArchiveDispatch(com.chinacreator.xtbg.core.archive.entity.ArchiveDispatchBean, java.sql.Connection) 
	  */
	@Override
	public boolean saveArchiveDispatch(ArchiveDispatchBean archiveDispatchBean,
			Connection conn) throws Exception {
		boolean flag = true;
		String sql = "insert into oa_archive_dispatch(id,busi_id,ins_id,title,caption,urgency_grade,archive_no,dispatch_type,key_word,effect_date,sender,secrecy_grade," +
				"send_org_id,send_org_addr,send_org_name,send_attach_id,create_date,is_sned_attach,isdxtx,msg_txt,union_archive,remark1,archive_returnid,is_send,union_archive_addr,union_archive_msg,send_org_config) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedInsert(sql);
		pdb.setString(1, StringUtil.getUUID());
		pdb.setString(2, archiveDispatchBean.getBusi_id());
		pdb.setString(3, archiveDispatchBean.getIns_id());
		pdb.setString(4, archiveDispatchBean.getTitle());
		pdb.setString(5, archiveDispatchBean.getCaption());
		pdb.setString(6, archiveDispatchBean.getUrgency_grade());
		pdb.setString(7, archiveDispatchBean.getArchive_no());
		pdb.setString(8, archiveDispatchBean.getDispatch_type());
		pdb.setString(9, archiveDispatchBean.getKey_word());
		pdb.setString(10, archiveDispatchBean.getEffect_date());
		pdb.setString(11, archiveDispatchBean.getSender());
		pdb.setString(12, archiveDispatchBean.getSecrecy_grade());
		pdb.setString(13, archiveDispatchBean.getSend_org_id());
		pdb.setString(14, archiveDispatchBean.getSend_org_addr());
		pdb.setString(15, archiveDispatchBean.getSend_org_name());
		pdb.setString(16, archiveDispatchBean.getSend_attach_id());
		pdb.setDate(17, Date.valueOf(archiveDispatchBean.getCreate_date()));
		pdb.setString(18, archiveDispatchBean.getIs_sned_attach());
		pdb.setString(19, archiveDispatchBean.getIsdxtx());
		pdb.setString(20, archiveDispatchBean.getMsg_txt());
		pdb.setString(21, archiveDispatchBean.getUnion_archive());
		pdb.setString(22, archiveDispatchBean.getRemark1());
		pdb.setString(23, archiveDispatchBean.getArchive_returnid());
		pdb.setString(24, archiveDispatchBean.getIs_send());
		pdb.setString(25, archiveDispatchBean.getUnion_archive_addr());
		pdb.setString(26, archiveDispatchBean.getUnion_archive_msg());
		pdb.setString(27, archiveDispatchBean.getSend_org_config());
		pdb.executePrepared(conn);
		return flag;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 wordToTemp
	  * @param string
	  * @param conn
	  * @return 
	  * @see com.chinacreator.xtbg.core.archive.dao.WordArchiveDao#wordToTemp(java.lang.String, java.sql.Connection) 
	  */
	@Override
	public boolean wordToTemp(String mRecordID, String ins_id ,Connection conn) {
		GwConstant gwConstant = new GwConstant();//公文传输常量
		FileUtil.tableTodisk(gwConstant.tmp_zip_attch_path+File.separator+ins_id,mRecordID,"docment",ins_id);
		return true;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 attachToTemp
	  * @param n_attach_id
	  * @param conn
	  * @return 
	  * @see com.chinacreator.xtbg.core.archive.dao.WordArchiveDao#attachToTemp(java.lang.String, java.sql.Connection) 
	  */
	@Override
	public boolean attachToTemp(String n_attach_id, String ins_id , Connection conn) {
		GwConstant gwConstant = new GwConstant();//公文传输常量
		FileUtil.tableTodisk(gwConstant.tmp_zip_attch_path+File.separator+ins_id,n_attach_id,"attach",ins_id);
		return true;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getArchiveDispatch
	  * @param uuid
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.dao.WordArchiveDao#getArchiveDispatch(java.lang.String, java.sql.Connection) 
	  */
	@Override
	public ArchiveDispatchBean getArchiveDispatch(String uuid, Connection conn)
			throws Exception {
		ArchiveDispatchBean archiveDispatchBean = new ArchiveDispatchBean();
		String sql = "select id,busi_id,ins_id,title,caption,urgency_grade,archive_no,dispatch_type,key_word,effect_date,sender,secrecy_grade," +
				"send_org_id,send_org_addr,send_org_name,send_attach_id,to_char(create_date,'YYYY-MM-DD') create_date,is_sned_attach,isdxtx,msg_txt,union_archive,remark1,archive_returnid,is_send,union_archive_addr,union_archive_msg,union_archive_buss_id,union_archive_is_send,send_org_config from oa_archive_dispatch where archive_returnid = ? ";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql);
		pdb.setString(1, uuid);
		pdb.executePrepared(conn);
		if(pdb.size()>0){
			archiveDispatchBean.setBusi_id(pdb.getString(0,"busi_id"));
			archiveDispatchBean.setIns_id(pdb.getString(0,"ins_id"));
			archiveDispatchBean.setTitle(pdb.getString(0,"title"));
			archiveDispatchBean.setCaption(pdb.getString(0,"caption"));
			archiveDispatchBean.setUrgency_grade(pdb.getString(0,"urgency_grade"));
			archiveDispatchBean.setArchive_no(pdb.getString(0,"archive_no"));
			archiveDispatchBean.setDispatch_type(pdb.getString(0,"dispatch_type"));
			archiveDispatchBean.setKey_word(pdb.getString(0,"key_word"));
			archiveDispatchBean.setEffect_date(pdb.getString(0,"effect_date"));
			archiveDispatchBean.setSender(pdb.getString(0,"sender"));
			archiveDispatchBean.setSecrecy_grade(pdb.getString(0,"secrecy_grade"));
			archiveDispatchBean.setSend_org_id(pdb.getString(0,"send_org_id"));
			archiveDispatchBean.setSend_org_addr(pdb.getString(0,"send_org_addr"));
			archiveDispatchBean.setSend_org_name(pdb.getString(0,"send_org_name"));
			archiveDispatchBean.setSend_attach_id(pdb.getString(0,"send_attach_id"));
			archiveDispatchBean.setCreate_date(pdb.getString(0,"create_date"));
			archiveDispatchBean.setIs_sned_attach(pdb.getString(0,"is_sned_attach"));
			archiveDispatchBean.setIsdxtx(pdb.getString(0,"isdxtx"));
			archiveDispatchBean.setMsg_txt(pdb.getString(0,"msg_txt"));
			archiveDispatchBean.setUnion_archive(pdb.getString(0,"union_archive"));
			archiveDispatchBean.setRemark1(pdb.getString(0,"remark1"));
			archiveDispatchBean.setArchive_returnid(pdb.getString(0,"archive_returnid"));
			archiveDispatchBean.setIs_send(pdb.getString(0,"is_send"));
			archiveDispatchBean.setGwcs_address(pdb.getString(0,"remark1"));//公文分发地址字符串保存位置
			archiveDispatchBean.setUnion_archive_addr(pdb.getString(0,"union_archive_addr"));
			archiveDispatchBean.setUnion_archive_msg(pdb.getString(0,"union_archive_msg"));
			archiveDispatchBean.setUnion_archive_buss_id(pdb.getString(0,"union_archive_buss_id"));
			archiveDispatchBean.setUnion_archive_is_send(pdb.getString(0,"union_archive_is_send"));
			archiveDispatchBean.setSend_org_config(pdb.getString(0,"send_org_config"));
		}

		
		return archiveDispatchBean;
	}
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getArchiveDispatchbean
	  * @param uuid
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.dao.WordArchiveDao#getArchiveDispatch(java.lang.String, java.sql.Connection) 
	  */
	@Override
	public ArchiveDispatchBean getArchiveDispatchbean(String ins_id, Connection conn)
			throws Exception {
		ArchiveDispatchBean archiveDispatchBean = new ArchiveDispatchBean();
		String sql = "select id,busi_id,ins_id,title,caption,urgency_grade,archive_no,dispatch_type,key_word,effect_date,sender,secrecy_grade," +
				"send_org_id,send_org_addr,send_org_name,send_attach_id,to_char(create_date,'YYYY-MM-DD') create_date,is_sned_attach,isdxtx,msg_txt,union_archive,remark1,archive_returnid,is_send,union_archive_addr,union_archive_msg,union_archive_buss_id,union_archive_is_send,send_org_config from oa_archive_dispatch where ins_id = ? ";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql);
		pdb.setString(1, ins_id);
		pdb.executePrepared(conn);
		if(pdb.size()>0){
			archiveDispatchBean.setBusi_id(pdb.getString(0,"busi_id"));
			archiveDispatchBean.setIns_id(pdb.getString(0,"ins_id"));
			archiveDispatchBean.setTitle(pdb.getString(0,"title"));
			archiveDispatchBean.setCaption(pdb.getString(0,"caption"));
			archiveDispatchBean.setUrgency_grade(pdb.getString(0,"urgency_grade"));
			archiveDispatchBean.setArchive_no(pdb.getString(0,"archive_no"));
			archiveDispatchBean.setDispatch_type(pdb.getString(0,"dispatch_type"));
			archiveDispatchBean.setKey_word(pdb.getString(0,"key_word"));
			archiveDispatchBean.setEffect_date(pdb.getString(0,"effect_date"));
			archiveDispatchBean.setSender(pdb.getString(0,"sender"));
			archiveDispatchBean.setSecrecy_grade(pdb.getString(0,"secrecy_grade"));
			archiveDispatchBean.setSend_org_id(pdb.getString(0,"send_org_id"));
			archiveDispatchBean.setSend_org_addr(pdb.getString(0,"send_org_addr"));
			archiveDispatchBean.setSend_org_name(pdb.getString(0,"send_org_name"));
			archiveDispatchBean.setSend_attach_id(pdb.getString(0,"send_attach_id"));
			archiveDispatchBean.setCreate_date(pdb.getString(0,"create_date"));
			archiveDispatchBean.setIs_sned_attach(pdb.getString(0,"is_sned_attach"));
			archiveDispatchBean.setIsdxtx(pdb.getString(0,"isdxtx"));
			archiveDispatchBean.setMsg_txt(pdb.getString(0,"msg_txt"));
			archiveDispatchBean.setUnion_archive(pdb.getString(0,"union_archive"));
			archiveDispatchBean.setRemark1(pdb.getString(0,"remark1"));
			archiveDispatchBean.setArchive_returnid(pdb.getString(0,"archive_returnid"));
			archiveDispatchBean.setIs_send(pdb.getString(0,"is_send"));
			archiveDispatchBean.setGwcs_address(pdb.getString(0,"remark1"));//公文分发地址字符串保存位置
			archiveDispatchBean.setUnion_archive_addr(pdb.getString(0,"union_archive_addr"));
			archiveDispatchBean.setUnion_archive_msg(pdb.getString(0,"union_archive_msg"));
			archiveDispatchBean.setUnion_archive_buss_id(pdb.getString(0,"union_archive_buss_id"));
			archiveDispatchBean.setUnion_archive_is_send(pdb.getString(0,"union_archive_is_send"));
			archiveDispatchBean.setSend_org_config(pdb.getString(0,"send_org_config"));
		}

		
		return archiveDispatchBean;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 saveArchiveAddr
	  * @param archiveAddrBeanList
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.dao.WordArchiveDao#saveArchiveAddr(java.util.List, java.sql.Connection) 
	  */
	@Override
	public boolean saveArchiveAddr(List<ArchiveAddrBean> archiveAddrBeanList,Connection conn) throws Exception {

		PreparedDBUtil pdb = new PreparedDBUtil();
		int i = 0;
		for (ArchiveAddrBean archiveAddrBean : archiveAddrBeanList) {
			String insertSql = "insert into oa_archive_addr(ins_id,receiveraddr,receivername,print_num,num,att_path,send_type,is_send,send_count) values (?,?,?,?,?,?,?,?,?)";
			pdb.preparedInsert(insertSql);
			pdb.setString(1, archiveAddrBean.getIns_id());
			pdb.setString(2, archiveAddrBean.getReceiveraddr());
			pdb.setString(3, archiveAddrBean.getReceivername());
			pdb.setString(4, archiveAddrBean.getPrint_num());
			pdb.setString(5, archiveAddrBean.getNum());
			pdb.setString(6, archiveAddrBean.getAtt_path());
			pdb.setString(7, archiveAddrBean.getSend_type());
			pdb.setString(8, archiveAddrBean.getIs_send());
			pdb.setString(9, archiveAddrBean.getSend_count());
			pdb.addPreparedBatch();
			i++;
		}
		// 批处理执行
		if (i > 0) {
			pdb.executePreparedBatch(conn);
		}
		return true;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 delArchiveAddr
	  * @param ins_id
	  * @param conn
	  * @return 
	  * @see com.chinacreator.xtbg.core.archive.dao.WordArchiveDao#delArchiveAddr(java.lang.String, java.sql.Connection) 
	  */
	@Override
	public boolean delArchiveAddr(String ins_id, Connection conn) throws Exception {
		boolean flag = true;
		String sql = "delete from OA_ARCHIVE_ADDR where ins_id = ?";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedDelete(sql);
		pdb.setString(1, ins_id);
		pdb.executePrepared(conn);
		return flag;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getArchiveUUID
	  * @param ins_id
	  * @param object
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.dao.WordArchiveDao#getArchiveUUID(java.lang.String, java.lang.Object) 
	  */
	@Override
	public String getArchiveUUID(String ins_id) throws Exception {
		String uuid = "";
		String sql = "select archive_returnid from Oa_Archive_Dispatch where ins_id = ?";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql);
		pdb.setString(1, ins_id);
		pdb.executePrepared();
		if(pdb.size()>0){
			uuid = pdb.getString(0,"archive_returnid");
		}
		return uuid;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 updateArchiveAddr
	  * @param archiveAddrBean
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.dao.WordArchiveDao#updateArchiveAddr(com.chinacreator.xtbg.core.archive.gwcs.bean.ArchiveAddrBean, java.sql.Connection) 
	  */
	@Override
	public boolean updateArchiveAddr(ArchiveAddrBean archiveAddrBean,
			Connection conn) throws Exception {
		String sql = "update oa_archive_addr set ins_id = ?, receivername = ?, print_num = ?, num = ?, att_path = ?, send_type = ?, is_send = ?, send_count = ? where receiveraddr = ?";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql);
		pdb.setString(1, archiveAddrBean.getIns_id());
		pdb.setString(2, archiveAddrBean.getReceivername());
		pdb.setString(3, archiveAddrBean.getPrint_num());
		pdb.setString(4, archiveAddrBean.getNum());
		pdb.setString(5, archiveAddrBean.getAtt_path());
		pdb.setString(6, archiveAddrBean.getSend_type());
		pdb.setString(7, archiveAddrBean.getIs_send());
		pdb.setString(8, archiveAddrBean.getSend_count());
		pdb.setString(9, archiveAddrBean.getReceiveraddr());
		pdb.executePrepared();
		return true;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 updateArchiveAddr
	  * @param ins_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.dao.WordArchiveDao#updateArchiveAddr(java.lang.String, java.sql.Connection) 
	  */
	@Override
	public boolean updateArchiveAddrIsSend(String ins_id, String is_send, Connection conn)
			throws Exception {
		String sql = "update oa_archive_addr set is_send = ?, send_count = send_count+1 where ins_id = ?, ";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql);
		pdb.setString(1, is_send);
		pdb.setString(2, ins_id);
		pdb.executePrepared();
		return true;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getTempActionId
	  * @param ins_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.dao.WordArchiveDao#getTempActionId(java.lang.String)
	 */
	@Override
	public String getTempActionId(String ins_id) throws Exception {
		String uuid = "";
		String sql = "select max(act_insid) act_insid from oa_flow_inswfaction where ins_id = ?";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql);
		pdb.setString(1, ins_id);
		pdb.executePrepared();
		if(pdb.size()>0){
			uuid = pdb.getString(0,"act_insid");
		}
		return uuid;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findArchiveDispatchBeanList
	  * @param archiveDispatchBean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return 
	  * @see com.chinacreator.xtbg.core.archive.dao.WordArchiveDao#findArchiveDispatchBeanList(com.chinacreator.xtbg.core.archive.entity.ArchiveDispatchBean, java.lang.String, java.lang.String, long, int)
	 */
	@Override
	public PagingBean findArchiveDispatchBeanList( ArchiveDispatchBean archiveDispatchBean1, String sortName, String sortOrder, long offset, int maxPagesize)throws Exception {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  pdb = new PreparedDBUtil ();
		List<ArchiveDispatchBean> list = new ArrayList<ArchiveDispatchBean>();
		StringBuffer sql = new StringBuffer("select id,busi_id,ins_id,title,caption,urgency_grade,archive_no,dispatch_type,key_word,effect_date,sender,secrecy_grade,");
		sql.append("send_org_id,send_org_addr,send_org_name,send_attach_id,to_char(create_date,'YYYY-MM-DD') create_date,is_sned_attach,isdxtx,msg_txt,union_archive,");
		sql.append("remark1,archive_returnid,is_send,union_archive_addr,union_archive_msg,union_archive_buss_id, union_archive_is_send,is_gz,send_org_config from oa_archive_dispatch where 1=1 ");
		//decode(union_archive_is_send,'1','已完成','未完成')
		if(archiveDispatchBean1!=null && !StringUtil.isBlank(archiveDispatchBean1.getUnion_archive())){
			if(!StringUtil.isBlank(archiveDispatchBean1.getIsdxtx())&& "1".equals(archiveDispatchBean1.getIsdxtx())){//用短信提醒来判断是否联合发文
				sql.append(" and union_archive <> "+archiveDispatchBean1.getUnion_archive() );
			}else{
				sql.append(" and union_archive = "+archiveDispatchBean1.getUnion_archive());
			}
		}
		if(archiveDispatchBean1!=null && !StringUtil.isBlank(archiveDispatchBean1.getTitle())){
			sql.append(" and title like '%"+archiveDispatchBean1.getTitle()+"%'");
		}
		if(archiveDispatchBean1!=null && !StringUtil.isBlank(archiveDispatchBean1.getArchive_no())){
			sql.append(" and archive_no like '%"+archiveDispatchBean1.getArchive_no()+"%'");
		}
		if(archiveDispatchBean1!=null && !StringUtil.isBlank(archiveDispatchBean1.getIs_send())){
			sql.append(" and is_send = "+archiveDispatchBean1.getIs_send());
		}
		
		if(archiveDispatchBean1!=null && !StringUtil.isBlank(archiveDispatchBean1.getStartSlTime())){
			sql.append(" and create_date  >= to_date('" + archiveDispatchBean1.getStartSlTime()
					+ " 00:00:00','yyyy-mm-dd hh24:mi:ss') ");
		}
		if(archiveDispatchBean1!=null && !StringUtil.isBlank(archiveDispatchBean1.getEndSlTime())){
			sql.append(" and create_date  <= to_date('" + archiveDispatchBean1.getEndSlTime()
					+ " 23:59:59','yyyy-mm-dd hh24:mi:ss') ");
		}
		sql.append(" order by " + sortName + " " + sortOrder +",id ");
		pdb.preparedSelect(sql.toString(), offset, maxPagesize);
		pdb.executePrepared();
		for(int i = 0 ; i < pdb.size() ; i++){
			ArchiveDispatchBean archiveDispatchBean = new ArchiveDispatchBean();
			archiveDispatchBean.setBusi_id(pdb.getString(i,"busi_id"));
			archiveDispatchBean.setIns_id(pdb.getString(i,"ins_id"));
			archiveDispatchBean.setTitle(pdb.getString(i,"title"));
			archiveDispatchBean.setCaption(pdb.getString(i,"caption"));
			archiveDispatchBean.setUrgency_grade(pdb.getString(i,"urgency_grade"));
			archiveDispatchBean.setArchive_no(pdb.getString(i,"archive_no"));
			archiveDispatchBean.setDispatch_type(pdb.getString(i,"dispatch_type"));
			archiveDispatchBean.setKey_word(pdb.getString(i,"key_word"));
			archiveDispatchBean.setEffect_date(pdb.getString(i,"effect_date"));
			archiveDispatchBean.setSender(pdb.getString(i,"sender"));
			archiveDispatchBean.setSecrecy_grade(pdb.getString(i,"secrecy_grade"));
			archiveDispatchBean.setSend_org_id(pdb.getString(i,"send_org_id"));
			archiveDispatchBean.setSend_org_addr(pdb.getString(i,"send_org_addr"));
			archiveDispatchBean.setSend_org_name(pdb.getString(i,"send_org_name"));
			archiveDispatchBean.setSend_attach_id(pdb.getString(i,"send_attach_id"));
			archiveDispatchBean.setCreate_date(pdb.getString(i,"create_date"));
			archiveDispatchBean.setIs_sned_attach(pdb.getString(i,"is_sned_attach"));
			archiveDispatchBean.setIsdxtx(pdb.getString(i,"isdxtx"));
			archiveDispatchBean.setMsg_txt(pdb.getString(i,"msg_txt"));
			archiveDispatchBean.setUnion_archive(pdb.getString(i,"union_archive"));
			archiveDispatchBean.setRemark1(pdb.getString(i,"remark1"));
			archiveDispatchBean.setArchive_returnid(pdb.getString(i,"archive_returnid"));
			archiveDispatchBean.setIs_gz(pdb.getString(i,"is_gz"));
			archiveDispatchBean.setSend_org_config(pdb.getString(i,"send_org_config"));
			String is_send = pdb.getString(i,"is_send");
			if("1".equals(is_send)){
				archiveDispatchBean.setIs_send("<font color='green'>已完成</font>");
			}else{
				archiveDispatchBean.setIs_send("<font color='red'>未完成</font>");
			}
			archiveDispatchBean.setGwcs_address(pdb.getString(i,"remark1"));//公文分发地址字符串保存位置
			archiveDispatchBean.setUnion_archive_addr(pdb.getString(i,"union_archive_addr"));
			archiveDispatchBean.setUnion_archive_msg(pdb.getString(i,"union_archive_msg"));
			archiveDispatchBean.setUnion_archive_buss_id(pdb.getString(i,"union_archive_buss_id"));
			String union_archive_is_send = pdb.getString(i,"union_archive_is_send");
			if("1".equals(union_archive_is_send)){
				archiveDispatchBean.setUnion_archive_is_send("<font color='green'>已完成</font>");
			}else{
				archiveDispatchBean.setUnion_archive_is_send("<font color='red'>未完成</font>");
			}
			StringBuffer singInfoStr = new StringBuffer("");
			boolean is_sign_complate = false;
			if("1".equals(union_archive_is_send)){//如果盖章发送成功
				if("1".equals(is_send)){//如果发送公文成功
					is_sign_complate = true;
					singInfoStr.append("<font color='green'>发送成功<font color='green'>");
				}else{//如果还未发送公文
					String union_archive_buss_id = pdb.getString(i,"union_archive_buss_id");
					List<UnionArchiveSignBean> signInfoList = this.getSignInfoList(union_archive_buss_id);
					if(signInfoList!=null && signInfoList.size()>0 ){
						is_sign_complate = true;
						for(int j=0;j<signInfoList.size();j++){
							UnionArchiveSignBean signInfo = signInfoList.get(j);
							if(!"1".equals(signInfo.getIssigned())){//如果有一条未完成，那么盖章未完成。
								is_sign_complate = false;
							}
							singInfoStr.append(signInfo.getOrgname()).append("（").append("1".equals(signInfo.getIssigned())?"<font color='green'>已盖章</font>":"1".equals(signInfo.getIsstamping())?"<font color='red'>进行中</font>":"<font color='red'>未盖章</font>").append("）").append("</br>");
						}
					}else{
						singInfoStr.append("<font color='red'>未获取到盖章数据<font color='green'>");
					}
				}
			}else{
				singInfoStr.append("<font color='red'>联合盖章未发送<font color='green'>");
			}
			if(is_sign_complate){
				archiveDispatchBean.setUnion_sign_complate("<font color='green'>已完成</font>");
			}else{
				archiveDispatchBean.setUnion_sign_complate("<font color='red'>未完成</font>");
			}
			archiveDispatchBean.setSign_list(singInfoStr.toString());
			list.add(archiveDispatchBean);
		}
		 pb.setList(list);
		 pb.setRecords((long)pdb.getTotalSize());
		return pb;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 putUnionArchiveInfo
	  * @param businessid
	  * @param uuid
	  * @param conn
	  * @return 
	  * @see com.chinacreator.xtbg.core.archive.dao.WordArchiveDao#putUnionArchiveInfo(java.lang.String, java.lang.String, java.sql.Connection)
	 */
	@Override
	public boolean putUnionArchiveInfo(String businessid, String uuid,String is_send, Connection conn) throws Exception {
		boolean flag = true;
		String sql = "update oa_archive_dispatch set union_archive_buss_id = ?, union_archive_is_send = ? where  archive_returnid = ?";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql);
		pdb.setString(1, businessid);
		pdb.setString(2,is_send);
		pdb.setString(3, uuid);
		pdb.executePrepared(conn);
		return flag;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 addSings
	  * @param signs
	  * @param businessid
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.dao.WordArchiveDao#addSings(java.util.List, java.lang.String, java.sql.Connection)
	 */
	@Override
	public boolean addSings(List<Sign> signs, String businessid, Connection conn) throws Exception {
		boolean flag = true;
		PreparedDBUtil pdb = new PreparedDBUtil();
		for(int i=0;i<signs.size();i++){
			Sign sign = signs.get(i);
			String sql = "insert into oa_union_archive_sign(id,buss_id,orgaddr,signorder,issigned,terminate,isstamping,stampdate,orgname) values (?,?,?,?,?,'0',?,sysdate,?)";
			pdb.preparedInsert(sql);
			pdb.setString(1, StringUtil.getUUID());
			pdb.setString(2, businessid);
			pdb.setString(3, sign.getOrgaddr());
			pdb.setString(4, sign.getSignorder());
			if(i==0){//如果是第一个单位代表是本单位已经盖章。
				pdb.setString(5, "1");	
				pdb.setString(6, "1");
			}else if(i==1){//发送成功后应该到第二个单位去插入记录。
				pdb.setString(5, "0");	
				pdb.setString(6, "1");
			}else{
				pdb.setString(5, "0");	
				pdb.setString(6, "0");
			}
			pdb.setString(7, sign.getOrgname());
			//TODO 在更新公文要素时要将此表删除
			pdb.addPreparedBatch();
		}
		pdb.executePreparedBatch(conn);
		return flag;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getSignInfoList
	  * @param union_archive_buss_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.dao.WordArchiveDao#getSignInfoList(java.lang.String)
	 */
	@Override
	public List<UnionArchiveSignBean> getSignInfoList( String union_archive_buss_id) throws Exception {
		List<UnionArchiveSignBean> unionArchiveSignBeanList = new ArrayList<UnionArchiveSignBean>();
		String sql = "select id,buss_id,orgaddr,orgname,signorder,issigned,terminate,isstamping,stampdate from OA_UNION_ARCHIVE_SIGN where buss_id = ? ";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql);
		pdb.setString(1, union_archive_buss_id);
		pdb.executePrepared();
		for(int i=0; i< pdb.size(); i++){
			UnionArchiveSignBean unionArchiveSignBean = new UnionArchiveSignBean();
			unionArchiveSignBean.setId(pdb.getString(i,"id"));
			unionArchiveSignBean.setBuss_id(pdb.getString(i,"buss_id"));
			unionArchiveSignBean.setOrgaddr(pdb.getString(i,"orgaddr"));
			unionArchiveSignBean.setOrgname(pdb.getString(i,"orgname"));
			unionArchiveSignBean.setSignorder(pdb.getString(i,"signorder"));
			unionArchiveSignBean.setIssigned(pdb.getString(i,"issigned"));
			unionArchiveSignBean.setTerminate(pdb.getString(i,"terminate"));
			unionArchiveSignBean.setIsstamping(pdb.getString(i,"isstamping"));
			//unionArchiveSignBean.setStampdate(pdb.getString(id)stampdate)
			unionArchiveSignBeanList.add(unionArchiveSignBean);
		}
		return unionArchiveSignBeanList;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getArchiveDispatchBeanList
	  * @param archiveDispatchSreachBean
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.dao.WordArchiveDao#getArchiveDispatchBeanList(com.chinacreator.xtbg.core.archive.entity.ArchiveDispatchBean)
	 */
	@Override
	public List<ArchiveDispatchBean> getArchiveDispatchBeanList(ArchiveDispatchBean archiveDispatchSreachBean) throws Exception {
		PreparedDBUtil  pdb = new PreparedDBUtil ();
		List<ArchiveDispatchBean> list = new ArrayList<ArchiveDispatchBean>();
		StringBuffer sql = new StringBuffer("select id,busi_id,ins_id,title,caption,urgency_grade,archive_no,dispatch_type,key_word,effect_date,sender,secrecy_grade,");
		sql.append("send_org_id,send_org_addr,send_org_name,send_attach_id,to_char(create_date,'YYYY-MM-DD') create_date,is_sned_attach,isdxtx,msg_txt,union_archive,");
		sql.append("remark1,archive_returnid,is_send,union_archive_addr,union_archive_msg,union_archive_buss_id, union_archive_is_send,send_org_config from oa_archive_dispatch where 1=1 ");
		//decode(union_archive_is_send,'1','已完成','未完成')
		if(archiveDispatchSreachBean!=null && !StringUtil.isBlank(archiveDispatchSreachBean.getUnion_archive())){
			sql.append(" and union_archive = "+archiveDispatchSreachBean.getUnion_archive());
		}
		if(archiveDispatchSreachBean!=null && !StringUtil.isBlank(archiveDispatchSreachBean.getIs_send())){
			sql.append(" and is_send = "+archiveDispatchSreachBean.getIs_send());
		}
		if(archiveDispatchSreachBean!=null && !StringUtil.isBlank(archiveDispatchSreachBean.getUnion_archive_is_send())){
			sql.append(" and union_archive_is_send = "+archiveDispatchSreachBean.getUnion_archive_is_send());
		}
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared();
		for(int i = 0 ; i < pdb.size() ; i++){
			ArchiveDispatchBean archiveDispatchBean = new ArchiveDispatchBean();
			archiveDispatchBean.setBusi_id(pdb.getString(i,"busi_id"));
			archiveDispatchBean.setIns_id(pdb.getString(i,"ins_id"));
			archiveDispatchBean.setTitle(pdb.getString(i,"title"));
			archiveDispatchBean.setCaption(pdb.getString(i,"caption"));
			archiveDispatchBean.setUrgency_grade(pdb.getString(i,"urgency_grade"));
			archiveDispatchBean.setArchive_no(pdb.getString(i,"archive_no"));
			archiveDispatchBean.setDispatch_type(pdb.getString(i,"dispatch_type"));
			archiveDispatchBean.setKey_word(pdb.getString(i,"key_word"));
			archiveDispatchBean.setEffect_date(pdb.getString(i,"effect_date"));
			archiveDispatchBean.setSender(pdb.getString(i,"sender"));
			archiveDispatchBean.setSecrecy_grade(pdb.getString(i,"secrecy_grade"));
			archiveDispatchBean.setSend_org_id(pdb.getString(i,"send_org_id"));
			archiveDispatchBean.setSend_org_addr(pdb.getString(i,"send_org_addr"));
			archiveDispatchBean.setSend_org_name(pdb.getString(i,"send_org_name"));
			archiveDispatchBean.setSend_attach_id(pdb.getString(i,"send_attach_id"));
			archiveDispatchBean.setCreate_date(pdb.getString(i,"create_date"));
			archiveDispatchBean.setIs_sned_attach(pdb.getString(i,"is_sned_attach"));
			archiveDispatchBean.setIsdxtx(pdb.getString(i,"isdxtx"));
			archiveDispatchBean.setMsg_txt(pdb.getString(i,"msg_txt"));
			archiveDispatchBean.setUnion_archive(pdb.getString(i,"union_archive"));
			archiveDispatchBean.setRemark1(pdb.getString(i,"remark1"));
			archiveDispatchBean.setArchive_returnid(pdb.getString(i,"archive_returnid"));
			String is_send = pdb.getString(i,"is_send");
			archiveDispatchBean.setIs_send(is_send);
			archiveDispatchBean.setGwcs_address(pdb.getString(i,"remark1"));//公文分发地址字符串保存位置
			archiveDispatchBean.setUnion_archive_addr(pdb.getString(i,"union_archive_addr"));
			archiveDispatchBean.setUnion_archive_msg(pdb.getString(i,"union_archive_msg"));
			archiveDispatchBean.setUnion_archive_buss_id(pdb.getString(i,"union_archive_buss_id"));
			String union_archive_is_send = pdb.getString(i,"union_archive_is_send");
			archiveDispatchBean.setUnion_archive_is_send(union_archive_is_send);
			archiveDispatchBean.setSend_org_config(pdb.getString(i,"send_org_config"));
			list.add(archiveDispatchBean);
		}
		return list;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 updateSignInfoList
	  * @param unionArchiveSignBeanList
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.dao.WordArchiveDao#updateSignInfoList(java.util.List, java.sql.Connection)
	 */
	@Override
	public boolean updateSignInfoList(List<UnionArchiveSignBean> unionArchiveSignBeanList, Connection conn) throws Exception {
		boolean flag = true;
		PreparedDBUtil pdb = new PreparedDBUtil();
		for(int i=0;i<unionArchiveSignBeanList.size();i++){
			UnionArchiveSignBean unionArchiveSignBean = unionArchiveSignBeanList.get(i);
			String sql = "update oa_union_archive_sign set signorder = ?, issigned = ?, terminate = ?, isstamping = ?, stampdate = ? where buss_id = ? and orgaddr = ?";
			pdb.preparedInsert(sql);
			pdb.setString(1, unionArchiveSignBean.getSignorder());
			pdb.setString(2, unionArchiveSignBean.getIssigned());
			pdb.setString(3, unionArchiveSignBean.getTerminate());
			pdb.setString(4, unionArchiveSignBean.getIsstamping());
			pdb.setDate(5, DateUtil.getDate(unionArchiveSignBean.getStampdate(), "yyyy-MM-dd HH:mm:ss"));
			pdb.setString(6, unionArchiveSignBean.getBuss_id());
			pdb.setString(7, unionArchiveSignBean.getOrgaddr());

			pdb.addPreparedBatch();
		}
		pdb.executePreparedBatch(conn);
		return flag;
	
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getSendArchiveList
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.dao.WordArchiveDao#getSendArchiveList()
	 */
	@Override
	public List<ArchiveDispatchBean> getSendArchiveList() throws Exception {
		PreparedDBUtil  pdb = new PreparedDBUtil ();
		List<ArchiveDispatchBean> list = new ArrayList<ArchiveDispatchBean>();
		StringBuffer sql = new StringBuffer("select id,busi_id,ins_id,title,caption,urgency_grade,archive_no,dispatch_type,key_word,effect_date,sender,secrecy_grade,");
		sql.append("send_org_id,send_org_addr,send_org_name,send_attach_id,to_char(create_date,'YYYY-MM-DD') create_date,is_sned_attach,isdxtx,msg_txt,union_archive,");
		sql.append("remark1,archive_returnid,is_send,union_archive_addr,union_archive_msg,union_archive_buss_id, union_archive_is_send ,send_org_config from oa_archive_dispatch t ");
		sql.append("where  t.is_send = '0' and t.union_archive = '1' and t.union_archive_is_send = '1'  ");
		//如果还有存在没有盖章完的记录，那么不发送。
		sql.append("and t.union_archive_buss_id not in (select ts.buss_id from oa_union_archive_sign ts where ts.issigned <> '1' and ts.buss_id = t.union_archive_buss_id)");
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared();
		for(int i = 0 ; i < pdb.size() ; i++){
			ArchiveDispatchBean archiveDispatchBean = new ArchiveDispatchBean();
			archiveDispatchBean.setBusi_id(pdb.getString(i,"busi_id"));
			archiveDispatchBean.setIns_id(pdb.getString(i,"ins_id"));
			archiveDispatchBean.setTitle(pdb.getString(i,"title"));
			archiveDispatchBean.setCaption(pdb.getString(i,"caption"));
			archiveDispatchBean.setUrgency_grade(pdb.getString(i,"urgency_grade"));
			archiveDispatchBean.setArchive_no(pdb.getString(i,"archive_no"));
			archiveDispatchBean.setDispatch_type(pdb.getString(i,"dispatch_type"));
			archiveDispatchBean.setKey_word(pdb.getString(i,"key_word"));
			archiveDispatchBean.setEffect_date(pdb.getString(i,"effect_date"));
			archiveDispatchBean.setSender(pdb.getString(i,"sender"));
			archiveDispatchBean.setSecrecy_grade(pdb.getString(i,"secrecy_grade"));
			archiveDispatchBean.setSend_org_id(pdb.getString(i,"send_org_id"));
			archiveDispatchBean.setSend_org_addr(pdb.getString(i,"send_org_addr"));
			archiveDispatchBean.setSend_org_name(pdb.getString(i,"send_org_name"));
			archiveDispatchBean.setSend_attach_id(pdb.getString(i,"send_attach_id"));
			archiveDispatchBean.setCreate_date(pdb.getString(i,"create_date"));
			archiveDispatchBean.setIs_sned_attach(pdb.getString(i,"is_sned_attach"));
			archiveDispatchBean.setIsdxtx(pdb.getString(i,"isdxtx"));
			archiveDispatchBean.setMsg_txt(pdb.getString(i,"msg_txt"));
			archiveDispatchBean.setUnion_archive(pdb.getString(i,"union_archive"));
			archiveDispatchBean.setRemark1(pdb.getString(i,"remark1"));
			archiveDispatchBean.setArchive_returnid(pdb.getString(i,"archive_returnid"));
			String is_send = pdb.getString(i,"is_send");
			archiveDispatchBean.setIs_send(is_send);
			archiveDispatchBean.setGwcs_address(pdb.getString(i,"remark1"));//公文分发地址字符串保存位置
			archiveDispatchBean.setUnion_archive_addr(pdb.getString(i,"union_archive_addr"));
			archiveDispatchBean.setUnion_archive_msg(pdb.getString(i,"union_archive_msg"));
			archiveDispatchBean.setUnion_archive_buss_id(pdb.getString(i,"union_archive_buss_id"));
			String union_archive_is_send = pdb.getString(i,"union_archive_is_send");
			archiveDispatchBean.setUnion_archive_is_send(union_archive_is_send);
			archiveDispatchBean.setSend_org_config(pdb.getString(i,"send_org_config"));
			list.add(archiveDispatchBean);
		}
		return list;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 updateIsSendByBussId
	  * @param uuid
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.dao.WordArchiveDao#updateIsSendByBussId(java.lang.String)
	 */
	@Override
	public boolean updateIsSendByBussId(String uuid,String colName) throws Exception {
		boolean flag = true;
		String sql = "update oa_archive_dispatch set is_send = ? where  "+colName+" = ?";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql);
		pdb.setString(1,"1");
		pdb.setString(2, uuid);
		pdb.executePrepared();
		return flag;
	}
	

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 updateGz
	  * @param gz
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.archive.dao.WordArchiveDao#updateGz(java.lang.String, java.sql.Connection)
	 */
	public boolean updateGz(String gz,String id) throws Exception {
		boolean flag = true;
		String sql = "update oa_archive_dispatch set is_gz = ? where  archive_returnid = ?";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql);
		pdb.setString(1, gz);
		pdb.setString(2, id);
		pdb.executePrepared();
		return flag;
	}
	/**
	 * modify by shuqi.liu　2014-04-22 此处修改了正文面签，的读取模式，根据text_type获取正文，面签内容
	 */
	@Override
	public Map<String, String> copyAttachForNewFlow(Map<String,String> argMap)
			throws Exception {
		String flowTitle = argMap.get("flowTitle");
		if(StringUtil.nullOrBlank(flowTitle)){
			flowTitle = "";
		}else{
			flowTitle = flowTitle.replaceAll("[\\\\]|[/]|[:]|[*]|[?]|[<]|[>]|[|]|[\"]", "_");
		}
		String textIdYW = argMap.get("textIdYW");
		String textIdMQ = argMap.get("textIdMQ");
		String textIdZBD = argMap.get("textIdZBD");
		String attachId = argMap.get("attachId");
		String oldAttachId = argMap.get("oldAttachId");
		String mFilePath = argMap.get("mFilePath");
		String userId = argMap.get("userId");
		
		Map<String,String> messMap = new HashMap<String,String>();
		StringBuffer attachNameList = new StringBuffer();//附件列表
		int countt = 1;
		DBUtil pdb = new DBUtil();
		StringBuffer sql = new StringBuffer();
		//参考  FileUploadServlet
		FiletransferService ft = new FiletransferServiceImpl();
		if(attachId!=null&&oldAttachId!=null){
			//1复制附件s
			sql.append("select djsn,rownum||':'||trim(filename) filename from oa_fc_attach where djbh = '"+oldAttachId+"'");
			pdb.executeSelect(sql.toString());
			
			for (int i = 0; i < pdb.size(); i++) {
				//附件 逐个 复制
				String tmpDJSN = pdb.getString(i, "djsn");
				attachNameList.append(pdb.getString(i, "filename")+"\r\n");
				if(tmpDJSN!=null){
					sql = new StringBuffer();
					String djsn = StringUtil.getUUID();
					String djsnURL = djsn+"_" + FileUtils.getSysTime();
					sql.append("insert into oa_fc_attach");
					sql.append("  (extend,");
					sql.append("   djbh,");
					sql.append("   dj_sn,");
					sql.append("   filename,");
					sql.append("   attachid,");
					sql.append("   bz,");
					sql.append("   djsn,");
					sql.append("   attachcontent,");
					sql.append("   filepos,");
					sql.append("   upload_mode,");
					sql.append("   cc_form_instanceid,");
					sql.append("   creator)");
					sql.append("  select extend,");
					sql.append("         '"+attachId+"',");//关联业务数据的code
					sql.append("         "+i+",");
					sql.append("         filename,");
					sql.append("         '"+ft.getAttachId()+"',");//递增的column
					sql.append("         bz,");
					sql.append("         '"+djsn+"',");//附件ID
					sql.append("         attachcontent,");
					sql.append("         '"+mFilePath+djsnURL+"'||extend,");//url
					sql.append("         upload_mode,");
					sql.append("         cc_form_instanceid,");
					sql.append("         '"+userId+"'");
					sql.append("    from oa_fc_attach");
					sql.append("   where djsn = '"+tmpDJSN+"'");
					pdb.executeInsert(sql.toString());
				}
			}
			countt = pdb.size()+1;
		}
		
		//2
		if(!StringUtil.nullOrBlank(textIdYW)){
			String fileType = ".doc";
			String fileName = (flowTitle.length()>0)?(flowTitle+"(原文)"+fileType):("原文"+fileType);
			String djsn = StringUtil.getUUID();
			String djsnURL = djsn+"_" + FileUtils.getSysTime();
			sql = new StringBuffer();
			sql.append("insert into oa_fc_attach");
			sql.append("  (extend,");
			sql.append("   djbh,");
			sql.append("   dj_sn,");
			sql.append("   filename,");
			sql.append("   attachid,");
			sql.append("   bz,");
			sql.append("   djsn,");
			sql.append("   attachcontent,");
			sql.append("   filepos,");
			sql.append("   upload_mode,");
			sql.append("   cc_form_instanceid,");
			sql.append("   creator)");
			sql.append("values");
			sql.append("  ('"+fileType+"',");
			sql.append("   '"+attachId+"',");
			sql.append("   "+countt+++",");
			sql.append("   '"+fileName+"',");
			sql.append("   '"+ft.getAttachId()+"',");
			sql.append("   null,");
			sql.append("   '"+djsn+"',");
			sql.append("   (select FILEBODY from oa_document_File  where RECORDID = '"+textIdYW+"' and text_type is null ),");
			sql.append("   '"+mFilePath+djsnURL+fileType+"',");
			sql.append("   '1',");//文件存取模式：1-数据库、2-本地磁盘、3-FTP远程服务器
			sql.append("   null,");
			sql.append("   '"+userId+"')");
			pdb.executeInsert(sql.toString());
			attachNameList.append(countt+":"+fileName+"\r\n");
		}
		
		//3
		if(!StringUtil.nullOrBlank(textIdMQ)){
			String fileType = ".doc";
			String fileName = (flowTitle.length()>0)?(flowTitle+"(面签)"+fileType):("面签"+fileType);
			String djsn = StringUtil.getUUID();
			String djsnURL = djsn+"_" + FileUtils.getSysTime();
			sql = new StringBuffer();
			sql.append("insert into oa_fc_attach");
			sql.append("  (extend,");
			sql.append("   djbh,");
			sql.append("   dj_sn,");
			sql.append("   filename,");
			sql.append("   attachid,");
			sql.append("   bz,");
			sql.append("   djsn,");
			sql.append("   attachcontent,");
			sql.append("   filepos,");
			sql.append("   upload_mode,");
			sql.append("   cc_form_instanceid,");
			sql.append("   creator)");
			sql.append("values");
			sql.append("  ('"+fileType+"',");
			sql.append("   '"+attachId+"',");
			sql.append("   "+countt+++",");
			sql.append("   '"+fileName+"',");
			sql.append("   '"+ft.getAttachId()+"',");
			sql.append("   null,");
			sql.append("   '"+djsn+"',");
			sql.append("   (select FILEBODY from oa_document_File  where RECORDID = '"+textIdYW+"' and text_type = 'singn'),");
			sql.append("   '"+mFilePath+djsnURL+fileType+"',");
			sql.append("   '1',");//文件存取模式：1-数据库、2-本地磁盘、3-FTP远程服务器
			sql.append("   null,");
			sql.append("   '"+userId+"')");
			pdb.executeInsert(sql.toString());
			attachNameList.append(countt+":"+fileName+"\r\n");
		}
		
		/*//4 省政府个性化修改，暂时注释。
		if(!StringUtil.nullOrBlank(textIdZBD)){
			String fileType = ".doc";
			String fileName = (flowTitle.length()>0)?(flowTitle+"(转办单)"+fileType):("转办单"+fileType);
			String djsn = StringUtil.getUUID();
			String djsnURL = djsn+"_" + FileUtils.getSysTime();
			sql = new StringBuffer();
			sql.append("insert into oa_fc_attach");
			sql.append("  (extend,");
			sql.append("   djbh,");
			sql.append("   dj_sn,");
			sql.append("   filename,");
			sql.append("   attachid,");
			sql.append("   bz,");
			sql.append("   djsn,");
			sql.append("   attachcontent,");
			sql.append("   filepos,");
			sql.append("   upload_mode,");
			sql.append("   cc_form_instanceid,");
			sql.append("   creator)");
			sql.append("values");
			sql.append("  ('"+fileType+"',");
			sql.append("   '"+attachId+"',");
			sql.append("   "+countt+++",");
			sql.append("   '"+fileName+"',");
			sql.append("   '"+ft.getAttachId()+"',");
			sql.append("   null,");
			sql.append("   '"+djsn+"',");
			sql.append("   (select FILEBODY from oa_document_File  where RECORDID = '"+textIdZBD+"'),");
			sql.append("   '"+mFilePath+djsnURL+fileType+"',");
			sql.append("   '1',");//文件存取模式：1-数据库、2-本地磁盘、3-FTP远程服务器
			sql.append("   null,");
			sql.append("   '"+userId+"')");
			pdb.executeInsert(sql.toString());
			attachNameList.append(countt+":"+fileName+"\r\n");
		}*/
		messMap.put("attachNum", ""+(countt-1));
		messMap.put("attachNameList", attachNameList.toString());
		return messMap;
	}
	
	/**
	 * 
	 *<b>Summary: 将当前行的结果集放入map中</b>
	 * 
	 * @param index
	 *            当前行数
	 * @param isShowNullDate
	 *            是否把空值的date也添加到map中去
	 * @return Map<String,String>
	 * @throws SQLException
	 */
	@SuppressWarnings("static-access")
	public Map<String, String> putResultToMap(int index, boolean isShowNullDate,PreparedDBUtil pdb)
			throws SQLException {
		Map<String, String> viewMap = new XtShowInfoHashMap();
		for (int z = 0; z < pdb.getMeta().getColumnCount(); z++) {
			if (!pdb.getMeta().getColumnName(z + 1).equals("ROWNO_")) {
				String column_string = pdb.getMeta().getColumnName(z + 1)
						.toLowerCase();
				String column_type = pdb.getJavaType(null, pdb.getMeta().getColumnType(z + 1)).toLowerCase();
				if (column_type.equals("date")) {// 如果当前列的数据类型为日期型，则把它转换为
					if (null != pdb.getTimestamp(index, column_string)) {
						viewMap.put(column_string, DateUtil
								.getTimeStringFull(pdb.getTimestamp(index,
										column_string)));
					} else {
						if (isShowNullDate) {// 是否把空值的date也添加到map中去
							viewMap.put(column_string, DateUtil
									.getTimeStringFull(pdb.getTimestamp(index,
											column_string)));
						}
					}
				} else {
					viewMap.put(column_string, pdb.getString(index,
							column_string));
				}
			}
		}
		return viewMap;
	}

	public Map<String, String> queryToSingleMap(String sql, String... values)
			throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();// 初始化数据库连接
		pdb.preparedSelect(sql.toString());
		Map<String, String> viewMap = new XtShowInfoHashMap();
		for (int i = 0; i < values.length; i++) {
			pdb.setString(i + 1, values[i]);
		}
		pdb.executePrepared();
		if (pdb.size() > 0) {
			viewMap = putResultToMap(0, true, pdb);
		}
		return viewMap;
	}
	/**
	 * 
	 * @param values
	 * @param pdb
	 * @return
	 * @throws Exception
	 */
	private List<Map<String, String>> executePreparedAndParseResultToMap(Object[] values, Connection conn, PreparedDBUtil pdb) throws Exception {
		List<Map<String, String>> viewMapList = new ArrayList<Map<String, String>>();
		for (int i = 0; i < values.length; i++) {
			pdb.setString(i + 1, (String) values[i]);
		}
		pdb.executePrepared(conn);
		for (int j = 0; j < pdb.size(); j++) {
			Map<String, String> viewMap = putResultToMap(j, true, pdb);
			viewMapList.add(viewMap);
		}
		return viewMapList;
	}

	public List<Map<String, String>> queryToListMap(String sql,
			Connection conn ,String... values) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();// 初始化数据库连接
		pdb.preparedSelect(sql.toString());
		return executePreparedAndParseResultToMap(values,conn, pdb);
	}
	/**
	 * 
	 */
	@Override
	public List<Map<String,String>> getTemplateList(String id, Connection conn)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("select * from OA_WORD_TEXTINPUT owt");
		sql.append(" where owt.data_come_from_table_id is not null");
		sql.append("  and owt.data_come_from_column_id is not null");
		sql.append("  and (owt.table_cell is not null or textinput_value_type= '3')"); //'配置附件==3' 参见[(kj_lx:wordparam.jsp),(ruleitem_value_type:RuleItemBean.java),(textinput_value_type:OA_WORD_TEXTINPUT(DB))]
		sql.append("  and owt.template_id = ?");
		return queryToListMap(sql.toString(), conn, id);
	}
	/**
	 * 复制附件 返回新附件ID
	 * @param oldAttachId
	 * @param conn
	 * @return
	 */
	@Override
	public String copyAttach(String oldAttachId,String mFilePath,String userId, Connection conn)
			throws Exception {
		DBUtil pdb = new DBUtil();
		StringBuffer sql = new StringBuffer();
		//参考  FileUploadServlet
		FiletransferService ft = new FiletransferServiceImpl();
		//1复制附件s
		sql.append("select djsn,rownum||':'||trim(filename) filename from oa_fc_attach where djbh = '"+oldAttachId+"'");
		pdb.executeSelect(sql.toString());
		if(pdb.size()<1){
			return null;
		}
		String newAttachId = StringUtil.getUUID();
		for (int i = 0; i < pdb.size(); i++) {
			//附件 逐个 复制
			String tmpDJSN = pdb.getString(i, "djsn");
			if(tmpDJSN!=null){
				sql = new StringBuffer();
				String djsn = StringUtil.getUUID();
				String djsnURL = djsn+"_" + FileUtils.getSysTime();
				sql.append("insert into oa_fc_attach");
				sql.append("  (extend,");
				sql.append("   djbh,");
				sql.append("   dj_sn,");
				sql.append("   filename,");
				sql.append("   attachid,");
				sql.append("   bz,");
				sql.append("   djsn,");
				sql.append("   attachcontent,");
				sql.append("   filepos,");
				sql.append("   upload_mode,");
				sql.append("   cc_form_instanceid,");
				sql.append("   creator)");
				sql.append("  select extend,");
				sql.append("         '"+newAttachId+"',");//关联业务数据的code
				sql.append("         "+i+",");
				sql.append("         filename,");
				sql.append("         '"+ft.getAttachId()+"',");//递增的column
				sql.append("         bz,");
				sql.append("         '"+djsn+"',");//附件ID
				sql.append("         attachcontent,");
				sql.append("         '"+mFilePath+djsnURL+"'||extend,");//url
				sql.append("         upload_mode,");
				sql.append("         cc_form_instanceid,");
				sql.append("         '"+userId+"'");
				sql.append("    from oa_fc_attach");
				sql.append("   where djsn = '"+tmpDJSN+"'");
				pdb.executeInsert(sql.toString());
			}
		}
		return newAttachId;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getLastActByIns_id
	  * @param ins_id
	  * @param conn
	  * @return 
	  * @see com.chinacreator.xtbg.core.archive.dao.WordArchiveDao#getLastActByIns_id(java.lang.String, java.sql.Connection)
	 */
	@Override
	public String getLastActByIns_id(String ins_id, Connection conn) throws Exception {
		StringBuffer sql = new StringBuffer();
		String lastActId = "";
		PreparedDBUtil pdb = new PreparedDBUtil();// 初始化数据库连接
		sql.append("select ts.action_defid as action_defid from OA_FLOW_WFACTION TS WHERE TS.ACTIONTYPE_CODE = '03' AND  TS.DEF_ID =");
		sql.append("(SELECT t.def_id FROM OA_FLOW_DEFINFO T WHERE T.DEF_ID =");
		sql.append("  (select def_id  from oa_flow_instance ti where ti.ins_id = ?))");
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, ins_id);
		pdb.executePrepared(conn);
		if(pdb.size()>0){
			lastActId = pdb.getString(0,"action_defid");
		}
		return lastActId;
	
	}
	
	
}
