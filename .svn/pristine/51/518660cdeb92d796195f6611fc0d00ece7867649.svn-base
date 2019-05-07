package com.chinacreator.xtbg.caizhengting.ibrary.dao.impl;

import java.sql.Connection;
import java.util.List;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.caizhengting.ibrary.dao.IbraryBorrowInfoDao;
import com.chinacreator.xtbg.caizhengting.ibrary.entity.IbraryBorrowInfoBean;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.SqlUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:IbraryBorrowInfoDaoImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 任涛
 *@version 1.0
 *2013-9-3
 */
public class IbraryBorrowInfoDaoImpl implements IbraryBorrowInfoDao{
	private static final Logger LOG = Logger.getLogger(IbraryBorrowInfoDaoImpl.class);
	/**
	 * 图书归还预警时间(系统参数ID in System_Parameter)
	 */
	private static final String SYSTEM_PARAM_ID_OF_EXPIRE_REMIND="system-parameter-ibrarybookback";
	/**
	 * 默认的预警时间
	 */
	private static final String DEFAULT_EXPIRE_REMIND_TIME="5";
	@Override
	public String addbean(IbraryBorrowInfoBean bean, Connection con)
			throws Exception {
		String flag = "";
		String sql ="insert into CZT_IBRARY_BORROWINFO(borrow_id,book_id,borrow_time,borrow_givetime,boorow_state,phone_number,boorow_user_id,boorow_user_name,boorow_out_user_id) " +
					"values(?, ?, to_date(?,'yyyy-mm-dd hh24:mi'), to_date(?,'yyyy-MM-dd hh24:mi'), ?, ?, ?, ?,?)";
		try {
			SqlUtil<IbraryBorrowInfoBean> sqlUtil = new SqlUtil<IbraryBorrowInfoBean>();
			sqlUtil.executeInsert(sql.toString(), bean, con);
			flag = "操作成功" ;
		} catch (Exception e) {
			flag = "操作失败" ;
			LOG.error(e.getMessage());
		}
		return flag;
	}

	@Override
	public PagingBean list(IbraryBorrowInfoBean bean, String sortName,
			String sortOrder, long offset, int maxPagesize, Connection con)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("select b.borrow_id,b.book_id,info.book_name as book_name ,info.book_no,b.boorow_user_name,b.boorow_user_id,to_char(b.borrow_time,'yyyy-MM-dd hh24:mi') borrow_time,to_char(b.borrow_givetime,'yyyy-MM-dd') borrow_givetime,b.phone_number,to_char(b.boorow_backtime,'yyyy-MM-dd hh24:mi') boorow_backtime " +
					" from CZT_IBRARY_BORROWINFO b left join CZT_IBRARY_BOOKINFO info on b.book_id = info.book_id where 1=1 and b.boorow_state = "+bean.getBoorow_state());
		//如果图书名不为空
		if(!StringUtil.isBlank(bean.getBook_name())){
			sql.append("   and info.book_name like '%"+bean.getBook_name()+"%'");
		}
		//如果图书编号不为空
		if(!StringUtil.isBlank(bean.getBook_no())){
			sql.append("   and info.book_no like '%"+bean.getBook_no()+"%'");
		}
		//如果出版社不为空
		if(!StringUtil.isBlank(bean.getBook_pressname())){
			sql.append("   and info.book_pressname like '%"+bean.getBook_pressname()+"%'");
		}
		//如果借阅开始时间不为空
		if(!StringUtil.isBlank(bean.getBorrow_start_time())){
			//sql.append("   and b.boorow_state >= to_date('"+bean.getBorrow_start_time()+"','yyyy-mm-dd hh24:mi:ss')");
			sql.append("   and b.borrow_time >=to_date('"+bean.getBorrow_start_time()+"', 'yyyy-MM-dd hh24:mi:ss') ");
		}
		//如果借阅结束时间不为空
		if(!StringUtil.isBlank(bean.getBorrow_end_time())){
			//sql.append("   and b.boorow_state <= to_date('"+bean.getBorrow_end_time()+"','yyyy-mm-dd hh24:mi:ss')+ 1");
			//将时间天数加1
			sql.append("   and b.borrow_time <to_date('"+bean.getBorrow_end_time()+"', 'yyyy-MM-dd hh24:mi:ss')+1 ");
		}
		//如果借阅人不为空
		if(!StringUtil.isBlank(bean.getBoorow_user_id())){
			sql.append("   and b.boorow_user_id = ? ");
		}
		//如果作者不为空
		if(!StringUtil.isBlank(bean.getBook_author())){
			sql.append("   and info.book_author like '%"+bean.getBook_author()+"%' ");;
		}
		
		sql.append(" order by b.borrow_givetime desc ");
		SqlUtil<IbraryBorrowInfoBean> sqlUtil = new SqlUtil<IbraryBorrowInfoBean>();
		PagingBean pb = sqlUtil.executeForListWithPage(sql.toString(), bean, sortName, sortOrder, offset, maxPagesize, con);
		return pb;
	}

	@Override
	public IbraryBorrowInfoBean getbeanbyid(String id, Connection con)
			throws Exception {
		String sql ="select b.borrow_id, u.user_realname as boorow_out_user_id,u1.user_realname as  boorow_in_user_id,info.book_name as book_name,b.book_id,b.boorow_user_name,info.book_no,b.boorow_user_id,to_char(b.borrow_time,'yyyy-MM-dd hh24:mi') borrow_time,to_char(b.borrow_givetime,'yyyy-MM-dd') borrow_givetime,b.phone_number,to_char(b.boorow_backtime,'yyyy-MM-dd HH24:mi') boorow_backtime" +
					" from CZT_IBRARY_BORROWINFO b left join CZT_IBRARY_BOOKINFO info on b.book_id = info.book_id left join td_sm_user u on b.boorow_out_user_id = u.user_id left join td_sm_user u1 on b.boorow_in_user_id = u1.user_id where b.borrow_id =?";
		SqlUtil<IbraryBorrowInfoBean> sqlUtil = new SqlUtil<IbraryBorrowInfoBean>();
		IbraryBorrowInfoBean bean = new IbraryBorrowInfoBean();
		bean.setBorrow_id(id);
		bean = sqlUtil.executeForObject(sql.toString(), bean,con);
		return bean;
	}

	@Override
	public List<IbraryBorrowInfoBean> getlistbybookid(String id, Connection con)
			throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		String sql ="select t.borrow_id,t.boorow_user_name,to_char(t.borrow_time,'yyyy-MM-dd hh24:mi') borrow_time ,to_char(t.borrow_givetime,'yyyy-MM-dd') borrow_givetime, to_char(t.boorow_backtime,'yyyy-MM-dd hh24:mi') boorow_backtime,decode(t.boorow_state,'1','借阅中','2','已归还') boorow_state,t.phone_number from czt_ibrary_borrowinfo t where t.book_id in('"+id+"') order by t.boorow_state desc";
		pdb.preparedSelect(sql.toString());
		List<IbraryBorrowInfoBean> list = pdb.executePreparedForList(IbraryBorrowInfoBean.class);
		return list;
	}

	@Override
	public String getAgreementExpireRemindTime(Connection conn)
			throws Exception {
		String sql = "SELECT P_CONTENT FROM oa_sys_param WHERE P_CODE = ?";
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedSelect(sql);
		db.setString(1, SYSTEM_PARAM_ID_OF_EXPIRE_REMIND);//remindTime提前预警时间(天)
		db.executePrepared(conn);
		if(db.size()==1){
			return db.getString(0, "P_CONTENT");
		}else{
			return DEFAULT_EXPIRE_REMIND_TIME;
		}
	}

	@Override
	public String updatebean(IbraryBorrowInfoBean bean, Connection con)
			throws Exception {
		String flag = "";
		StringBuffer sql = new StringBuffer();
		sql.append(" update CZT_IBRARY_BORROWINFO");
		if("update".equals(bean.getAction_type())){
			//更新操作
			if(!StringUtil.nullOrBlank(bean.getBorrow_givetime())){
				sql.append(" set borrow_givetime =to_date(?,'yyyy-MM-dd hh24:mi')");
			}
		}else{
			//归还的操作
			if(!StringUtil.nullOrBlank(bean.getBoorow_state())){
				sql.append(" set boorow_state =?,");
			}
			if(!StringUtil.nullOrBlank(bean.getBoorow_in_user_id())){
				sql.append(" boorow_in_user_id = ?,");
			}
				sql.append(" boorow_backtime = Sysdate");
		}
		if(!StringUtil.nullOrBlank(bean.getBorrow_id())){
			sql.append(" where borrow_id =?");
		}
		try {
			SqlUtil<IbraryBorrowInfoBean> sqlUtil = new SqlUtil<IbraryBorrowInfoBean>();
			sqlUtil.executeUpdate(sql.toString(), bean, con);
			flag = "操作成功" ;
		} catch (Exception e) {
			flag = "操作失败" ;
			LOG.error(e.getMessage());
		}
			return flag;
	}

	/**
	 * 我借阅的图书查询
	  * <b>Summary: </b>
	  *     复写方法 myList
	  * @param bean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @param con
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.caizhengting.ibrary.dao.IbraryBorrowInfoDao#mylist(com.chinacreator.xtbg.caizhengting.ibrary.entity.IbraryBorrowInfoBean, java.lang.String, java.lang.String, long, int, java.sql.Connection)
	 */
	@Override
	public PagingBean myList(IbraryBorrowInfoBean bean, String sortName,
			String sortOrder, long offset, int maxPagesize, Connection con)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("select b.borrow_id,");
		sql.append("       b.book_id,");
		sql.append("       info.book_name as book_name,");
		sql.append("       info.book_no,");
		sql.append("       b.boorow_user_name,");
		sql.append("       b.boorow_user_id,");
		sql.append("        to_char(b.borrow_time,'yyyy-MM-dd hh24:mi') borrow_time,");
		sql.append("       to_char(b.borrow_givetime,'yyyy-MM-dd') borrow_givetime,");
		sql.append("       b.phone_number,");
		sql.append("       b.boorow_backtime,");
		sql.append("(select distinct replace(replace(to_char(wm_concat('!@#$%^&*()'||t1.tree_name)");
		sql.append("                        over(partition by '' order by level desc ");
		sql.append("                             rows between unbounded preceding and unbounded");
		sql.append("                             following)),',!@#$%^&*()','\\'),'!@#$%^&*()','')");
		sql.append("  from czt_ibrarytree t1 ");
		sql.append(" start with tree_id = info.tree_id ");
		sql.append(" connect by prior tree_parent_id = tree_id");
		sql.append(") tree_name ");
		sql.append("  from czt_ibrary_borrowinfo b");
		sql.append("  left join czt_ibrary_bookinfo info");
		sql.append("    on b.book_id = info.book_id");
		sql.append(" where b.boorow_user_id = ? ");
		sql.append("   and b.boorow_state = ? ");
		//如果图书名不为空
		if(!StringUtil.isBlank(bean.getBook_name())){
			sql.append("   and info.book_name like '%"+bean.getBook_name()+"%'");
		}
		//如果图书编号不为空
		if(!StringUtil.isBlank(bean.getBook_no())){
			sql.append("   and info.book_no like '%"+bean.getBook_no()+"%'");
		}
		//如果出版社不为空
		if(!StringUtil.isBlank(bean.getBook_pressname())){
			sql.append("   and info.book_pressname like '%"+bean.getBook_pressname()+"%'");
		}
		//如果借阅开始时间不为空
		if(!StringUtil.isBlank(bean.getBorrow_start_time())){
			//sql.append("   and b.boorow_state >= to_date('"+bean.getBorrow_start_time()+"','yyyy-mm-dd hh24:mi:ss')");
			sql.append("   and b.borrow_time >=to_date('"+bean.getBorrow_start_time()+"', 'yyyy-MM-dd hh24:mi:ss') ");
		}
		//如果借阅结束时间不为空
		if(!StringUtil.isBlank(bean.getBorrow_end_time())){
			//sql.append("   and b.boorow_state <= to_date('"+bean.getBorrow_end_time()+"','yyyy-mm-dd hh24:mi:ss')+ 1");
			//将时间天数加1
			sql.append("   and b.borrow_time <to_date('"+bean.getBorrow_end_time()+"', 'yyyy-MM-dd hh24:mi:ss')+1 ");
		}
		sql.append(" order by "+sortName+" "+sortOrder);
		SqlUtil<IbraryBorrowInfoBean> sqlUtil = new SqlUtil<IbraryBorrowInfoBean>();
		PagingBean pb = sqlUtil.executeForListWithPage(sql.toString(), bean, sortName, sortOrder, offset, maxPagesize, con);
		return pb;
	}

	@Override
	public String delteBookBorrowinfobyBookId(String id, Connection con)
			throws Exception {
		String flag = "";
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("delete czt_ibrary_borrowinfo f where f.book_id in("+id+")");
		try {
			pdb.preparedInsert(sql.toString());
			pdb.executePrepared(con);
			flag = "操作成功" ;
		} catch (Exception e) {
			flag = "操作失败" ;
			LOG.error(e.getMessage());
		}
		return flag;
	}
}
