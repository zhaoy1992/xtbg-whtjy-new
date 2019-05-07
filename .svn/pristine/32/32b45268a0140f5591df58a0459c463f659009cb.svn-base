package com.chinacreator.xtbg.pub.oagwcs.dao.imploracle;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.oagwcs.dao.ReceiveDao;
import com.chinacreator.xtbg.pub.oagwcs.entity.ReceiveBean;
import com.chinacreator.xtbg.pub.oagwcs.entity.ReceiveGwcsBean;
import com.chinacreator.xtbg.pub.oagwcs.entity.ReceiveGwcsListSearchBean;
import com.chinacreator.xtbg.pub.util.DictDropDownList;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:ReceiveDaoImpl.java</p>
 *<p>Description:来文单位信息实例类</p> 
 *<p>Company:湖南科创</p>
 *@author 刘春元
 *@version 1.0
 *2012-1-31
 */
public class ReceiveDaoImpl implements ReceiveDao {

	private static final Logger LOG = Logger.getLogger(ReceiveDaoImpl.class);
	
	/**
	 * @Description  查询收文列表
	 * 
	 * @param DirectoryBean  //查询参数
	 * @param sortName  //排序字段
	 * @param sortOrder  //排序方式
	 * @param offset  //从第几天开始
	 * @param maxPagesize	//当前页数
	 * @return  List
	 * @exception 
	 */
	@Override
	public PagingBean findUserList(ReceiveBean instanceBean, String sortName, String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<ReceiveBean> list = new ArrayList<ReceiveBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select");
		sql.append(" 		hjid,");
		sql.append(" 		hjmc,");
		sql.append(" 		xh,");
		sql.append(" 		remark1,");
		sql.append(" 		remark2");
		sql.append(" from ta_oa_document_receive_level where 1=1 ");
		
		sql.append(" order by " + sortName + " " + sortOrder);
		
		try {
	    	db.preparedSelect(sql.toString(), offset, maxPagesize);
	    	db.executePrepared();
		    for(int i = 0;i < db.size();i++){
		    	ReceiveBean ub = new ReceiveBean();
//		    	ub.setHjid(db.getString(i, "hjid"));
//		    	ub.setHjmc(db.getString(i, "hjmc"));
//		    	ub.setXh(db.getString(i, "xh"));
//		    	ub.setRemark1(db.getString(i, "remark1"));
//		    	ub.setRemark2(db.getString(i, "remark2"));
		    	list.add(ub);
		    }
	    } catch (SQLException e) {
			LOG.error("执行收文列表查询报错："+e.getMessage());
		}
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}
	
	

	@Override
	public PagingBean findReceiveGwcsList(ReceiveGwcsListSearchBean receiveGwcsListSearchBean,
			String sortName, String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<ReceiveGwcsBean> list = new ArrayList<ReceiveGwcsBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select g.gwreceive_id, ");
		sql.append("       g.title, ");
		sql.append("       g.prefix, ");
		sql.append("       g.symbol, ");
		sql.append("       g.serial_number, ");
		sql.append("       g.secrecy_grade, ");
		sql.append("       g.effect_date, ");
		sql.append("       g.urgency_grade, ");
		sql.append("       g.caption, ");
		sql.append("       g.keyword, ");
		sql.append("       g.dispatch_type, ");
		sql.append("       g.sender, ");
		sql.append("       g.sendscope, ");
		sql.append("       g.create_date, ");
		sql.append("       to_char(to_date(g.send_date,'yyyy-MM-dd hh24:mi:ss'),'yyyy-MM-dd') send_date, ");
		sql.append("       g.sendusername, ");
		sql.append("       g.issign, ");
		sql.append("       g.contact_phone, ");
		//sql.append("       o.oa_orgname recv_org_name, ");
		//sql.append("       o.oa_orgcode recv_org_addr, ");
		sql.append("       g.recv_org_name, ");
		sql.append("       g.recv_org_addr, ");
		sql.append("       g.file_name, ");
		sql.append("       decode(g.is_accept,'Y','已签收','N','未签收') is_accept, ");
		sql.append("       g.attach_id, ");
		sql.append("       g.Send_Org_Name ");
		//sql.append("  from ta_oa_gwreceive g, ta_oa_gwscorg o ");
		sql.append("  from ta_oa_gwreceive g ");
		//怀化针对单位   20130829
		//sql.append("   left join ta_oa_gwscorg gw  ");
		//sql.append("  on g.recv_org_addr=gw.gwcs_orgcode ");
		sql.append("    ,oa_gwcs_org_mapping gw,oa_gwcs_org org  ");
		//END 怀化针对单位   20130829
		sql.append("  where g.is_accept = 'N' and g.recv_org_addr = org.org_addr and org.org_id = gw.gwcs_org_id  ");
		//怀化针对单位   20130829
		//教育考试院 针对单位   20130620
		//if(CacheCommonManageProxy.getBooleanSystemParam("gwcs_ReceiveOrg")){
		//	sql.append("  and gw.oa_orgcode ='"+receiveGwcsListSearchBean.getDeptCode()+"' ");
		//}
		sql.append("  and (gw.oa_org_id ='"+receiveGwcsListSearchBean.getDeptCode()+"' ");
		sql.append("  or gw.oa_org_id = (select t.parent_id from td_sm_organization t ");
		sql.append("where t.org_id = '"+receiveGwcsListSearchBean.getDeptCode()+"')) ");
		//END 怀化针对单位   20130829
		//END 教育考试院 针对单位   20130620
		if(!StringUtil.nullOrBlank(receiveGwcsListSearchBean.getUserid())){
			sql.append("  and  gw.user_id='"+receiveGwcsListSearchBean.getUserid()+"' ");
		}
		//sql.append("  where o.gwcs_orgcode = g.recv_org_addr and g.is_accept = 'N' and o.oa_orgcode = '");
		//sql.append(receiveGwcsListSearchBean.getDeptCode()).append("' ");
		if(!StringUtil.nullOrBlank(receiveGwcsListSearchBean.getTitle())){
			sql.append(" and g.title like ? ");
		}
		if(!StringUtil.nullOrBlank(receiveGwcsListSearchBean.getSecrecy_grade())){
			sql.append(" and g.secrecy_grade = ?");
		}
		if(!StringUtil.nullOrBlank(receiveGwcsListSearchBean.getCaption())){
			sql.append(" and g.caption like ?");
		}
		if(!StringUtil.nullOrBlank(receiveGwcsListSearchBean.getRecv_org_name())){
			sql.append(" and g.send_org_name like ?");
		}
		if(!StringUtil.nullOrBlank(receiveGwcsListSearchBean.getReceive_starttime())){
			sql.append(" and g.create_date > to_date('").append(receiveGwcsListSearchBean.getReceive_starttime()).append("','yyyy-MM-dd')");
		}
		if(!StringUtil.nullOrBlank(receiveGwcsListSearchBean.getReceive_endtime())){
			sql.append(" and g.create_date < to_date('").append(receiveGwcsListSearchBean.getReceive_endtime() + "23:59:59").append("','yyyy-MM-dd hh24:mi:ss')");
		}
		sql.append(" order by " + sortName + " " + sortOrder);
		
		try {
	    	db.preparedSelect(sql.toString(), offset, maxPagesize);
	    	int j = 1;
	    	if(!StringUtil.nullOrBlank(receiveGwcsListSearchBean.getTitle())){
				db.setString(j++, "%" + receiveGwcsListSearchBean.getTitle() + "%");
			}
			if(!StringUtil.nullOrBlank(receiveGwcsListSearchBean.getSecrecy_grade())){
				db.setString(j++, receiveGwcsListSearchBean.getSecrecy_grade());
			}
			if(!StringUtil.nullOrBlank(receiveGwcsListSearchBean.getCaption())){
				db.setString(j++, "%" + receiveGwcsListSearchBean.getCaption() + "%");
			}
			if(!StringUtil.nullOrBlank(receiveGwcsListSearchBean.getRecv_org_name())){
				db.setString(j++, "%" + receiveGwcsListSearchBean.getRecv_org_name()+ "%");
			}

	    	db.executePrepared();
		    for(int i = 0;i < db.size();i++){
		    	ReceiveGwcsBean receiveGwcsBean = new ReceiveGwcsBean();
		    	receiveGwcsBean.setGwreceive_id(db.getString(i, "gwreceive_id"));
		    	receiveGwcsBean.setTitle(db.getString(i, "title"));
				receiveGwcsBean.setPrefix(db.getString(i, "prefix"));
				receiveGwcsBean.setSymbol(db.getString(i, "symbol"));
				receiveGwcsBean.setSerial_number(db.getString(i, "serial_number"));
				receiveGwcsBean.setSecrecy_grade(db.getString(i, "secrecy_grade"));
				receiveGwcsBean.setEffect_date(db.getString(i, "effect_date"));
				receiveGwcsBean.setUrgency_grade(db.getString(i, "urgency_grade"));
				receiveGwcsBean.setCaption(db.getString(i, "caption"));
				receiveGwcsBean.setKeyword(db.getString(i, "keyword"));
				receiveGwcsBean.setDispatch_type(db.getString(i, "dispatch_type"));
				receiveGwcsBean.setSender(db.getString(i, "sender"));
				receiveGwcsBean.setSendscope(db.getString(i, "sendscope"));
				receiveGwcsBean.setCreate_date(db.getString(i, "create_date"));
				receiveGwcsBean.setSend_date(db.getString(i, "send_date"));
				receiveGwcsBean.setSendusername(db.getString(i, "sendusername"));
				receiveGwcsBean.setIssign(db.getString(i, "issign"));
				receiveGwcsBean.setContact_phone(db.getString(i, "contact_phone"));
				receiveGwcsBean.setRecv_org_name(db.getString(i, "recv_org_name"));
				receiveGwcsBean.setRecv_org_addr(db.getString(i, "recv_org_addr"));
				receiveGwcsBean.setFile_name(db.getString(i, "file_name"));
				receiveGwcsBean.setIs_accept(db.getString(i, "is_accept"));
				receiveGwcsBean.setAttach_id(db.getString(i, "attach_id"));
				receiveGwcsBean.setWordcontent_id(db.getString(i, "wordcontent_id"));
				receiveGwcsBean.setSend_org_name(db.getString(i,"Send_Org_Name"));
		    	list.add(receiveGwcsBean);
		    }
	    } catch (SQLException e) {
	    	e.printStackTrace();
			LOG.error("执行收文列表查询报错："+e.getMessage());
		}
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}


	@Override
	public ReceiveGwcsBean findReceiveGwcsBeanById(String gwreceiveId)
			throws Exception {
		StringBuffer buf = new StringBuffer();

		buf.append("select  ");
		buf.append("       title, ");
		buf.append("       prefix, ");
		buf.append("       symbol, ");
		buf.append("       serial_number, ");
		buf.append("       secrecy_grade, ");
		buf.append("       effect_date, ");
		buf.append("       urgency_grade, ");
		buf.append("       caption, ");
		buf.append("       keyword, ");
		buf.append("       dispatch_type, ");
		buf.append("       sender, ");
		buf.append("       sendscope, ");
		buf.append("       create_date, ");
		buf.append("       to_char(to_date(send_date,'yyyy-MM-dd hh24:mi:ss'),'yyyy-MM-dd') send_date, ");
		buf.append("       send_org_name, ");
		buf.append("       send_org_addr, ");
		buf.append("       sendusername, ");
		buf.append("       issign, ");
		buf.append("       contact_phone, ");
		buf.append("       recv_org_name, ");
		buf.append("       recv_org_addr, ");
		buf.append("       file_name, ");
		buf.append("       is_accept, ");
		buf.append("       attach_id ");
		buf.append("  from ta_oa_gwreceive ");
		buf.append("  where gwreceive_id = ? ");

		PreparedDBUtil db = new PreparedDBUtil();
		ReceiveGwcsBean receiveGwcsBean = new ReceiveGwcsBean();
		db.preparedSelect(buf.toString()); 
		db.setString(1, gwreceiveId);
		db.executePrepared();
		if(db.size()>0){
			receiveGwcsBean.setGwreceive_id(gwreceiveId);
			receiveGwcsBean.setTitle(db.getString(0, "title"));
			receiveGwcsBean.setPrefix(db.getString(0, "prefix"));
			receiveGwcsBean.setSymbol(db.getString(0, "symbol"));
			receiveGwcsBean.setSerial_number(db.getString(0, "serial_number"));
			receiveGwcsBean.setSecrecy_grade(db.getString(0, "secrecy_grade"));
			receiveGwcsBean.setEffect_date(db.getString(0, "effect_date"));
			receiveGwcsBean.setUrgency_grade(db.getString(0, "urgency_grade"));
			receiveGwcsBean.setCaption(db.getString(0, "caption"));
			receiveGwcsBean.setKeyword(db.getString(0, "keyword"));
			receiveGwcsBean.setDispatch_type(db.getString(0, "dispatch_type"));
			receiveGwcsBean.setSender(db.getString(0, "sender"));
			receiveGwcsBean.setSendscope(db.getString(0, "sendscope"));
			receiveGwcsBean.setCreate_date(db.getString(0, "create_date"));
			receiveGwcsBean.setSend_date(db.getString(0, "send_date"));
			receiveGwcsBean.setSend_org_name(db.getString(0, "send_org_name"));
			receiveGwcsBean.setSend_org_addr(db.getString(0, "send_org_addr"));
			receiveGwcsBean.setSendusername(db.getString(0, "sendusername"));
			receiveGwcsBean.setIssign(db.getString(0, "issign"));
			receiveGwcsBean.setContact_phone(db.getString(0, "contact_phone"));
			receiveGwcsBean.setRecv_org_name(db.getString(0, "recv_org_name"));
			receiveGwcsBean.setRecv_org_addr(db.getString(0, "recv_org_addr"));
			receiveGwcsBean.setFile_name(db.getString(0, "file_name"));
			receiveGwcsBean.setIs_accept(db.getString(0, "is_accept"));
			receiveGwcsBean.setAttach_id(db.getString(0, "attach_id"));

		}
		return receiveGwcsBean;
	}

	

	@Override
	public void setReceiveGwcs2Beused(String gwreceiveId, boolean isused)
			throws Exception {

		StringBuffer sql = new StringBuffer();
		PreparedDBUtil pdb = new PreparedDBUtil();
		sql.append("update ta_oa_gwreceive set IS_ACCEPT = ? where gwreceive_id = ?");
		pdb.preparedUpdate(sql.toString());
		if(isused){
			pdb.setString(1, "Y");
		}else{
			pdb.setString(1, "N");
		}
		pdb.setString(2, gwreceiveId);
		pdb.executePrepared();
		
		
	}



	/**
	 * @Description 添加来文单位信息
	 * @param receivesetBean 来文单位Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	@Override
	public void addReceive(ReceiveBean receivesetBean) throws SQLException {
		StringBuffer buf = new StringBuffer();
		 
		buf.append(" insert into ta_oa_document_receive");
		buf.append("        ( receive_id, receive_sn, receive_org, receive_num,");
		buf.append("         receive_date, receive_count, receive_secret, receive_title,");
		buf.append("         receive_nbyj, receive_ldps, receive_cbjg, receive_state,");
		buf.append("         receive_affix, receive_content, remark1, remark2, receive_flowid)");
		buf.append(" values(SEQ_RECEIVE.nextval, ");
		buf.append("	    ?, ?, ?, to_date(?,'yyyy-mm-dd'),?, ?, ?, ?,?, ?, ?, ?,?, ?, ?, ?)");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedInsert(buf.toString());
		db.setString(1, receivesetBean.getReceive_sn());
		db.setString(2, receivesetBean.getReceive_org());
		db.setString(3, receivesetBean.getReceive_num());
		db.setString(4, receivesetBean.getReceive_date());
		db.setString(5, receivesetBean.getReceive_count());
		db.setString(6, receivesetBean.getReceive_secret());
		db.setString(7, receivesetBean.getReceive_title());
		db.setString(8, receivesetBean.getReceive_nbyj());
		db.setString(9, receivesetBean.getReceive_ldps());
		db.setString(10, receivesetBean.getReceive_cbjg());
		db.setString(11, receivesetBean.getReceive_state());
		db.setString(12, receivesetBean.getReceive_affix());
		db.setString(13, receivesetBean.getReceive_content());
		db.setString(14, receivesetBean.getRemark1());
		db.setString(15, receivesetBean.getRemark2());
		db.setString(16, receivesetBean.getReceive_flowid());
		db.executePrepared();
	}

	/**
	 * @Description 修改来文单位信息
	 * @param instanceBean 来文单位Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	@Override
	public void updateReceive(ReceiveBean receiveLevelBean) throws SQLException {
		StringBuffer buf = new StringBuffer();
		
		buf.append(" update ta_oa_document_receive_level ");
		buf.append("        set hjmc = ?, xh = ?, remark1=?, remark2=?");
        buf.append("  where hjid = ? ");
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedUpdate(buf.toString());
//		db.setString(1, receiveLevelBean.getHjmc());
//		db.setString(2, receiveLevelBean.getXh());
//		db.setString(3, receiveLevelBean.getRemark1());
//		db.setString(4, receiveLevelBean.getRemark2());
//		db.setString(5, receiveLevelBean.getHjid());
		db.executePrepared();
	}
	
	/**
	 * @Description  删除来文单位信息
	 * @param receiveIds
	 * @return boolean
	 * @throws SQLException 
	 */
	@Override
	public boolean delReceive(String receiveIds) throws SQLException {
		String sql = "delete from ta_oa_document_receive_level where hjid in ("+ receiveIds + ")";
		PreparedDBUtil db = new PreparedDBUtil();
		db.executeDelete(sql);
		return true;
	}

	/**
	 * @Description 根据来文单位ID获得来文单位信息
	 * @param id 来文单位id
	 * @return receivesetBean来文单位Bean
	 * @throws SQLException 
	 */
	@Override
	public ReceiveBean getReceiveBeanById(String id) throws SQLException {
		StringBuffer buf = new StringBuffer();
		buf.append(" select ");
		buf.append(" 		receive_id, receive_sn, receive_org, receive_num,");
		buf.append(" 		to_char(receive_date,'yyyy-mm-dd') receive_date, receive_count, receive_secret, receive_title,");
		buf.append(" 		receive_nbyj, receive_ldps, receive_cbjg, receive_state,");
		buf.append(" 		receive_affix, receive_content, remark1, remark2, receive_flowid");		
		buf.append(" from ta_oa_document_receive ");
		buf.append("      where receive_id = ?");
		PreparedDBUtil db = new PreparedDBUtil();
		ReceiveBean receivesetBean = new ReceiveBean();
		db.preparedSelect(buf.toString()); 
		db.setString(1, id);
		db.executePrepared();
		for (int i = 0; i < db.size(); i++) {  
			receivesetBean.setReceive_id(db.getString(i , "receive_id"));
			receivesetBean.setReceive_sn(db.getString(i , "receive_sn"));
			receivesetBean.setReceive_org(db.getString(i , "receive_org"));
			receivesetBean.setReceive_num(db.getString(i , "receive_num"));
			
			receivesetBean.setReceive_date(db.getString(i , "receive_date"));
			receivesetBean.setReceive_count(db.getString(i , "receive_count"));
			receivesetBean.setReceive_secret(db.getString(i , "receive_secret"));
			receivesetBean.setReceive_title(db.getString(i , "receive_title"));
			
			receivesetBean.setReceive_nbyj(db.getString(i , "receive_nbyj"));
			receivesetBean.setReceive_ldps(db.getString(i , "receive_ldps"));
			receivesetBean.setReceive_cbjg(db.getString(i , "receive_cbjg"));
			receivesetBean.setReceive_state(db.getString(i , "receive_state"));
			receivesetBean.setReceive_affix(db.getString(i , "receive_affix"));
			receivesetBean.setReceive_content(db.getString(i , "receive_content"));
			receivesetBean.setRemark1(db.getString(i , "remark1"));
			receivesetBean.setRemark2(db.getString(i , "remark2"));
			receivesetBean.setReceive_flowid(db.getString(i , "receive_flowid"));
		}
		return receivesetBean;
	}

	@Override
	public String getOrgSelectHtml() throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("select lwdwid, dwmc from ta_oa_document_receive_set");
		String sceneOrgList = DictDropDownList.buildSelect(sql
				.toString(), "receive_org", "", "", true, "---请选择---");
		return sceneOrgList;
	}

	@Override
	public String getLevelSelectHtml() throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("select hjid, hjmc from ta_oa_document_receive_level");
		String sceneLevelList = DictDropDownList.buildSelect(sql
				.toString(), "receive_secret", "", "", true, "---请选择---");
		return sceneLevelList;
	}

}
