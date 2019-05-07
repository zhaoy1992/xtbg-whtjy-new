package com.chinacreator.xtbg.caizhengting.ibrary.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.caizhengting.ibrary.dao.IbraryBookInfoDao;
import com.chinacreator.xtbg.caizhengting.ibrary.dao.IbraryBorrowInfoDao;
import com.chinacreator.xtbg.caizhengting.ibrary.entity.IBraryRegBookInfoBean;
import com.chinacreator.xtbg.caizhengting.ibrary.entity.IbraryBookInfoBean;
import com.chinacreator.xtbg.caizhengting.ibrary.entity.IbraryRegBookBookInfoBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.SqlUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:IbraryBookInfoDaoImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 任涛  
 *@version 1.0
 *2013-9-3
 */
public class IbraryBookInfoDaoImpl extends XtDbBaseDao implements IbraryBookInfoDao{
	private static final Logger LOG = Logger.getLogger(IbraryBookInfoDaoImpl.class);
	@Override
	public String addbean(IbraryBookInfoBean bean, Connection con)
			throws Exception {
		String flag = "";
		StringBuffer sql = new StringBuffer();
		sql.append("insert into CZT_IBRARY_BOOKINFO");
		sql.append(" (book_id, tree_id,tree_name, book_name, book_no, book_author, book_pressname, book_pressno,");
		sql.append("  book_pressdate, book_pressbunver, book_page, book_price, book_state, booker_id, booker_date,");
		sql.append("  booker_dept_id, remark, accessory, borrow_id,zdtz,whereform,book_number,booker_dept_name,validstate) ");
		sql.append(" values ");
		sql.append("  (?, ?, ?, ?, ?, ?, ?, ?, to_date(?,'yyyy-MM-dd hh24:mi:ss'), ?, ?, ?, ?, ?, to_date(?,'yyyy-MM-dd hh24:mi:ss'), ?, ?, ?, ?, ?, ?, ?, ?,?)");
		try {
			SqlUtil<IbraryBookInfoBean> sqlUtil = new SqlUtil<IbraryBookInfoBean>();
			sqlUtil.executeInsert(sql.toString(), bean, con);
			flag = "操作成功" ;
		} catch (Exception e) {
			flag = "操作失败" ;
			LOG.error(e.getMessage());
		}
		return flag;
	}

	@Override
	public String delbean(String[] ids, Connection con) throws Exception {
		String flag = "";
		PreparedDBUtil pdb = new PreparedDBUtil();
		String book_name ="";
		try {
			IbraryBorrowInfoDao daodd = new IbraryBorrowInfoDaoImpl();
			for(int i=0;i<ids.length;i++){
				IbraryBookInfoBean bean  = getbookstate(ids[i]);
				//if(!StringUtil.nullOrBlank(bean.getBook_state())){
					if("1".equals(bean.getBook_state())){ //如果是已借出
						book_name += bean.getBook_name()+",";
						book_name = book_name.substring(0, book_name.length()-1);
						flag =book_name+"图书已被借出,不能删除!";
						return flag;
					}else{
						flag = daodd.delteBookBorrowinfobyBookId(ids[i], con);
						if("操作成功".equals(flag)){
							String sql = "delete CZT_IBRARY_BOOKINFO t where t.book_id = "+ids[i];
							pdb.preparedInsert(sql.toString());
							pdb.executePrepared(con);
						}
					}
			//	}
			}
		} catch (Exception e) {
			flag = "操作失败" ;
			LOG.error(e.getMessage());
		}
		return flag;
	}

	@Override
	public IbraryBookInfoBean getbeanbyid(String id, Connection con)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("select t1.book_id,");
		sql.append("       t1.tree_id,");
		sql.append("       t1.book_name,");
		sql.append("       t1.book_no,");
		sql.append("       t1.book_author,");
		sql.append("       t1.book_pressname,");
		sql.append("       t1.book_pressno,");
		sql.append("       to_char(t1.book_pressdate,'yyyy-MM-dd')book_pressdate,");
		sql.append("       t1.book_pressbunver,");
		sql.append("       t1.book_page,");
		sql.append("       t1.book_price,");
		sql.append("       t1.book_state,");
		sql.append("       t1.booker_id,");
		sql.append("       t2.user_realname    booker_name,");
		sql.append("       t1.booker_date,");
		sql.append("       t1.booker_dept_id,");
		sql.append("       t3.org_name         booker_dept_name,");
		sql.append("       t1.remark,");
		sql.append("       t1.accessory,");
		sql.append("       t1.borrow_id,");
		sql.append("       t1.zdtz,");
		sql.append("       t1.whereform,");
		sql.append("       t1.book_number,");
		sql.append("       t1.booker_dept_name,");
		sql.append("       t1.tree_name,");
		sql.append("       t1.validstate ");//有效状态
		sql.append("  from czt_ibrary_bookinfo t1");
		sql.append("  left join td_sm_user t2");
		sql.append("    on t1.booker_id = t2.user_id");
		sql.append("  left join td_sm_organization t3");
		sql.append("    on t1.booker_dept_id = t3.org_id");
		sql.append("  where t1.book_id = ?");
		SqlUtil<IbraryBookInfoBean> sqlUtil = new SqlUtil<IbraryBookInfoBean>();
		IbraryBookInfoBean bean = new IbraryBookInfoBean();
		bean.setBook_id(id);
		bean = sqlUtil.executeForObject(sql.toString(), bean,con);
		return bean;
	}

	@Override
	public String updatebean(IbraryBookInfoBean bean, Connection con)
			throws Exception {
		String flag = "";
		String sql ="update CZT_IBRARY_BOOKINFO" +
					" set tree_id =?,tree_name =?,book_name =?," +
					"  book_no =?,book_author =?," +
					"  book_pressname =?,book_pressno =?," +
					"  book_pressdate =to_date(?,'yyyy-MM-dd hh24:mi:ss'),book_pressbunver =?," +
					"  book_page =?,book_price =?," +
					"  book_state =?,booker_id =?," +
					"  validstate=?,"+  //有效状态
					"  booker_date =to_date(?,'yyyy-MM-dd hh24:mi:ss'),booker_dept_id =?," +
					"  remark =?,accessory =?,zdtz=?,whereform=?,book_number=?,booker_dept_name=?," +
					"  borrow_id =? where book_id =?";
		try {
			SqlUtil<IbraryBookInfoBean> sqlUtil = new SqlUtil<IbraryBookInfoBean>();
			sqlUtil.executeUpdate(sql.toString(), bean, con);
			flag = "操作成功" ;
		} catch (Exception e) {
			flag = "操作失败" ;
			LOG.error(e.getMessage());
		}
		return flag;
	}

	@Override
	public String copybookinfo(IbraryBookInfoBean beans, Connection con) throws Exception {
		String flag = "";
		try {
			IbraryBookInfoBean bean = getbeanbyid(beans.getBook_id(), con);
			bean.setBook_id(UUID.randomUUID().toString());
			bean.setBorrow_id(""); //新增加的书没有借阅ID
			bean.setBook_state("0");
			//初始化 复制人的信息
			bean.setBooker_date(beans.getBooker_date());
			bean.setBooker_id(beans.getBooker_id());
			bean.setBooker_dept_id(beans.getBooker_dept_id());
			addbean(bean, con);
			flag = "操作成功" ;
		} catch (Exception e) {
			flag = "操作失败" ;
			LOG.error(e.getMessage());
		}
		return flag;
	}

	@Override
	public PagingBean list(IbraryBookInfoBean bean, String sortName, 
			String sortOrder, long offset, int maxPagesize, Connection con)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		if(!StringUtil.nullOrBlank(bean.getJsp_type())){ //选择添加图书列表LIST
			sql.append("select book_id,tree_id,tree_name,borrow_id,book_name,decode(validstate,'1','正常','2','过期停用','正常') as validstate,zdtz,whereform,book_number,booker_dept_name,book_no,book_pressname,book_author,booker_date,decode(book_state,'0','在库','1','已借出') book_state " +
			   " from CZT_IBRARY_BOOKINFO t  where 1=1");
		}else{
			sql.append("select book_id,tree_id,");
			//sql.append("       (SELECT  REPLACE(REPLACE(TO_CHAR(WM_CONCAT('!@#$%^&*()'||t1.tree_name)),',!@#$%^&*()','\\'),'!@#$%^&*()','')");
			sql.append("(SELECT distinct REPLACE(REPLACE(to_char(wm_concat('!@#$%^&*()'||t1.tree_name)");
			sql.append("                        over(partition by '' order by level desc ");
			sql.append("                             rows between unbounded preceding and unbounded");
			sql.append("                             following)),',!@#$%^&*()','\\'),'!@#$%^&*()','')");
			sql.append("  FROM CZT_IBRARYTREE t1 ");
			sql.append(" START WITH tree_id = t.tree_id ");
			sql.append(" CONNECT BY PRIOR tree_parent_id = tree_id");
			sql.append(") tree_name,");
			sql.append("borrow_id,book_name,decode(validstate,'1','正常','2','过期停用','正常') as validstate,book_no,book_pressname,book_author,booker_date,decode(book_state,'0','在库','1','已借出') book_state,zdtz,whereform,book_number,booker_dept_name " +
					   " from CZT_IBRARY_BOOKINFO t  where 1=1 ");
			if(!StringUtil.nullOrBlank(bean.getTree_id())){
				sql.append(" and t.tree_id in (select tree_id from CZT_IBRARYTREE START WITH " +
						"tree_id = '"+bean.getTree_id()+"' CONNECT BY prior tree_id = tree_parent_id)");
			}
		}
		//如果图书名不为空
		if(!StringUtil.isBlank(bean.getBook_name())){
			sql.append("   and t.book_name like '%"+bean.getBook_name()+"%'");
		}
		//如果图书编号不为空
		if(!StringUtil.isBlank(bean.getBook_no())){
			sql.append("   and t.book_no like '%"+bean.getBook_no()+"%'");
		}
		//如果出版社不为空
		if(!StringUtil.isBlank(bean.getBook_pressname())){
			sql.append("   and t.book_pressname like '%"+bean.getBook_pressname()+"%'");
		}
		//如果登记开始时间不为空
		if(!StringUtil.isBlank(bean.getBooker_start_time())){
			sql.append("   and t.booker_date >=to_date('"+bean.getBooker_start_time()+"','yyyy-MM-dd hh24:mi:ss') ");
		}
		//如果借阅结束时间不为空
		if(!StringUtil.isBlank(bean.getBooker_end_time())){
			//将时间天数加1
			sql.append("   and t.booker_date <to_date('"+bean.getBooker_end_time()+"','yyyy-MM-dd hh24:mi:ss')+1 ");
		}
		//如果内容不为空
		if(!StringUtil.isBlank(bean.getRemark())){
			sql.append("   and t.remark like '%"+bean.getRemark()+"%'");
		}
		//如果作者不为空
		if(!StringUtil.isBlank(bean.getBook_author())){
			sql.append("   and t.book_author like '%"+bean.getBook_author()+"%'");
		}
		//如果所属单位不为空
		if(!StringUtil.isBlank(bean.getBooker_dept_id())){
			sql.append("   and t.booker_dept_id = '"+bean.getBooker_dept_id()+"'");
			//sql.append("   and  to_number(t.book_number) >= 0 ");
		}
		
		if(StringUtil.isBlank(sortName)){
			sql.append("  order by t.booker_date desc");
		} else{
			sql.append("  order by "+sortName+" "+sortOrder);
		}

		SqlUtil<IbraryBookInfoBean> sqlUtil = new SqlUtil<IbraryBookInfoBean>();
		PagingBean pb = sqlUtil.executeForListWithPage(sql.toString(), bean, sortName, sortOrder, offset, maxPagesize, con);
		return pb;
	}

	@Override
	public String updatebookstate(IbraryBookInfoBean bean, Connection con)
			throws Exception {	
		String flag = "";
		String sql ="update CZT_IBRARY_BOOKINFO" +
					" set book_state =?" +
					" where book_id =?";
		try {
			SqlUtil<IbraryBookInfoBean> sqlUtil = new SqlUtil<IbraryBookInfoBean>();
			sqlUtil.executeUpdate(sql.toString(), bean, con);
			flag = "操作成功" ;
		} catch (Exception e) {
			flag = "操作失败" ;
			LOG.error(e.getMessage());
		}
		return flag;
	}
	
	public IbraryBookInfoBean getbookstate(String book_ud)throws Exception{
		String sql = "select t.book_name,t.book_state from czt_ibrary_bookinfo t where t.book_id ="+book_ud+"";
		PreparedDBUtil pdb = new PreparedDBUtil();
		IbraryBookInfoBean  bean  = new IbraryBookInfoBean();
		pdb.preparedSelect(sql);
		pdb.executePrepared();
		if(pdb.size()>0){
			bean.setBook_name(pdb.getString(0,"book_name"));
			bean.setBook_state(pdb.getString(0,"book_state"));
		}
		return bean;
	}

	@Override
	public String getbookCode(String tree_id, Connection con) throws Exception {
		String codeno = "";
		StringBuffer sql = new StringBuffer();
		sql.append("select case");
		sql.append("         when newCol > 999 then");
		sql.append("          '' || newCol");
		sql.append("         when newCol > 99 then");
		sql.append("          '0' || newCol");
		sql.append("         when newCol > 9 then");
		sql.append("          '00' || newCol");
		sql.append("         else");
		sql.append("          '000' || newCol");
		sql.append("       end newCol");
		sql.append("  from (select nvl(max(substr(newCol, 2, length(newCol))), 0) + 1 newCol");
		sql.append("          from (select REGEXP_SUBSTR(t.book_no, '\\]\\d*$') newCol");
		sql.append("                  from czt_ibrary_bookinfo t");
		sql.append("                 where length(REGEXP_SUBSTR(t.book_no, '\\]\\d*$')) > 1");
		sql.append("                   and tree_id = '"+tree_id+"'))");
		sql.append("");		
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared();
		if(pdb.size()>0){
			codeno = pdb.getString(0,"newCol");
		}
		return codeno;
	}

	/**
	 * 
	  * <b>Summary: 插入申请表信息</b>
	  *     复写方法 insertRegBookInfo
	  * @param iBraryRegBookInfoBean
	  * @param con
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.caizhengting.ibrary.dao.IbraryBookInfoDao#insertRegBookInfo(com.chinacreator.xtbg.caizhengting.ibrary.entity.IBraryRegBookInfoBean, java.sql.Connection)
	 */
	public boolean insertRegBookInfo(
			IBraryRegBookInfoBean iBraryRegBookInfoBean, Connection con)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("insert into ta_oa_regbook");
		sql.append(" (t_regb_id,t_regb_user_id,t_regb_user_name,t_regb_date,t_regb_bookids,");
		sql.append("  t_regb_org_id,t_regb_org_name,t_regb_dept_id,t_regb_dept_name,t_regb_state,");
		sql.append("  t_regb_gh_date,t_regb_booknames,t_regb_iskonw,t_regb_jy_date,t_regb_truegh_date,t_regb_isxj,t_regb_sqtype) ");
		sql.append(" values ");
		sql.append("  (?, ?, ?, to_date(?,'yyyy-MM-dd'), ?, ?, ?, ?, ?, ?, to_date(?,'yyyy-MM-dd'), ?, ?, to_date(?,'yyyy-MM-dd'), to_date(?,'yyyy-MM-dd'), ?,?)");
		
		SqlUtil<IBraryRegBookInfoBean> sqlUtil = new SqlUtil<IBraryRegBookInfoBean>();
		sqlUtil.executeInsert(sql.toString(), iBraryRegBookInfoBean, con);
		
		return true;
	}

	/**
	 * 
	  * <b>Summary:更新申请表信息 </b>
	  *     复写方法 updateRegBookInfo
	  * @param iBraryRegBookInfoBean
	  * @param con
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.caizhengting.ibrary.dao.IbraryBookInfoDao#updateRegBookInfo(com.chinacreator.xtbg.caizhengting.ibrary.entity.IBraryRegBookInfoBean, java.sql.Connection)
	 */
	public boolean updateRegBookInfo(
			IBraryRegBookInfoBean iBraryRegBookInfoBean, Connection con)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("update ta_oa_regbook set t_regb_user_id = ?, t_regb_user_name = ?, ");
		sql.append("  t_regb_date = to_date(?,'yyyy-MM-dd'), t_regb_bookids = ?, t_regb_org_id = ?, t_regb_org_name = ?, t_regb_dept_id = ?,");
		sql.append("  t_regb_dept_name = ?, t_regb_state = ?, t_regb_gh_date = to_date(?,'yyyy-MM-dd'), t_regb_booknames = ?,");
		sql.append("  t_regb_iskonw = ?, t_regb_jy_date = to_date(?,'yyyy-MM-dd'), t_regb_truegh_date = to_date(?,'yyyy-MM-dd'), t_regb_isxj = ? ");
		sql.append(" , t_regb_auditopinion = ? ");
		sql.append(" where  t_regb_id = ?");
		
		SqlUtil<IBraryRegBookInfoBean> sqlUtil = new SqlUtil<IBraryRegBookInfoBean>();
		sqlUtil.executeUpdate(sql.toString(), iBraryRegBookInfoBean, con);
		
		return true;
	}

	/**
	 * 
	  * <b>Summary: 插入申请图书表信息</b>
	  *     复写方法 insertRegBookBookInfo
	  * @param ibraryRegBookBookInfoBean
	  * @param con
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.caizhengting.ibrary.dao.IbraryBookInfoDao#insertRegBookBookInfo(com.chinacreator.xtbg.caizhengting.ibrary.entity.IbraryRegBookBookInfoBean, java.sql.Connection)
	 */
	public boolean insertRegBookBookInfo(
			IbraryRegBookBookInfoBean ibraryRegBookBookInfoBean, Connection con)
			throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("insert into ta_oa_regbook_book");
		sql.append(" (t_reg_book_id,t_reg_book_regid,t_reg_book_book_id,t_reg_book_book_name,");
		sql.append("  t_reg_book_book_jg,t_reg_book_book_no,t_reg_book_book_bh,t_reg_book_book_auter)");
		sql.append(" values ");
		sql.append("  (?,?,?,?,?,?,?,?)");
		
		/*SqlUtil<IbraryRegBookBookInfoBean> sqlUtil = new SqlUtil<IbraryRegBookBookInfoBean>();
		sqlUtil.executeInsert(sql.toString(), ibraryRegBookBookInfoBean, con);*/
		pdb.preparedInsert(sql.toString());
		
		int i = 1;
		pdb.setString(i++, ibraryRegBookBookInfoBean.getT_reg_book_id());
		pdb.setString(i++, ibraryRegBookBookInfoBean.getT_reg_book_regid());
		pdb.setString(i++, ibraryRegBookBookInfoBean.getT_reg_book_book_id());
		pdb.setString(i++, ibraryRegBookBookInfoBean.getT_reg_book_book_name());
		pdb.setString(i++, ibraryRegBookBookInfoBean.getT_reg_book_book_jg());
		pdb.setString(i++, ibraryRegBookBookInfoBean.getT_reg_book_book_no());
		pdb.setString(i++, ibraryRegBookBookInfoBean.getT_reg_book_book_bh());
		pdb.setString(i++, ibraryRegBookBookInfoBean.getT_reg_book_book_auter());
		
		pdb.executePrepared();
		
		return true;
	}

	/**
	 * 
	  * <b>Summary: 更新申请图书表信息</b>
	  *     复写方法 updateRegBookBookInfo
	  * @param ibraryRegBookBookInfoBean
	  * @param con
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.caizhengting.ibrary.dao.IbraryBookInfoDao#updateRegBookBookInfo(com.chinacreator.xtbg.caizhengting.ibrary.entity.IbraryRegBookBookInfoBean, java.sql.Connection)
	 */
	public boolean updateRegBookBookInfo(
			IbraryRegBookBookInfoBean ibraryRegBookBookInfoBean, Connection con)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("  update ta_oa_regbook_book set t_reg_book_regid = ?, ");
		sql.append("  t_reg_book_book_id = ?, t_reg_book_book_name = ?, t_reg_book_book_jg = ?, t_reg_book_book_no = ?,");
		sql.append("  t_reg_book_book_bh = ?, t_reg_book_book_auter = ? ");
		sql.append(" where  t_reg_book_id = ?");
		
		SqlUtil<IbraryRegBookBookInfoBean> sqlUtil = new SqlUtil<IbraryRegBookBookInfoBean>();
		sqlUtil.executeUpdate(sql.toString(), ibraryRegBookBookInfoBean, con);
		
		return true;
	}

	/**
	 * 
	  * <b>Summary: 根据申请表ID删除申请图书表信息</b>
	  *     复写方法 deleteRegBookBookInfo
	  * @param regBookBookIds
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.caizhengting.ibrary.dao.IbraryBookInfoDao#deleteRegBookBookInfo(java.lang.String)
	 */
	public boolean deleteRegBookBookInfo(String regBookBookIds,Connection conn)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from ta_oa_regbook_book ");
		sql.append(" where t_reg_book_regid in ");
		sql.append("       (?)");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, regBookBookIds);
		pdb.executePrepared(conn);
		return true;
	}

	/**
	 * 
	  * <b>Summary: 更新图书库存数量</b>
	  *     复写方法 updateBookNumber
	  * @param ibraryBookInfoBean
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.caizhengting.ibrary.dao.IbraryBookInfoDao#updateBookNumber(com.chinacreator.xtbg.caizhengting.ibrary.entity.IbraryBookInfoBean, java.sql.Connection)
	 */
	public boolean updateBookNumber(IbraryBookInfoBean ibraryBookInfoBean,
			Connection conn) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append(" update CZT_IBRARY_BOOKINFO set book_number=? ");
		sql.append(" where book_id = ? ");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, ibraryBookInfoBean.getBook_number());
		pdb.setString(2, ibraryBookInfoBean.getBook_id());
		pdb.executePrepared(conn);
		return true;
	}

	/**
	 * 
	  * <b>Summary: 查询图书信息</b>
	  *     复写方法 queryBookInfo
	  * @param bookIds
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.caizhengting.ibrary.dao.IbraryBookInfoDao#queryBookInfo(java.lang.String, java.sql.Connection)
	 */
	public List<Map<String, String>> queryBookInfo(String bookIds,
			Connection conn) throws Exception {
		bookIds = StringUtil.splitString(bookIds, ",", "'");
		StringBuffer sql = new StringBuffer();
		PreparedDBUtil pdb = new PreparedDBUtil();
		
		List<Map<String, String>> bookInfoList = new ArrayList<Map<String,String>>();
		
		sql.append("select t1.book_id,");
		sql.append("       t1.book_name,");
		sql.append("       t1.book_no,");
		sql.append("       t1.book_author,");
		sql.append("       t1.book_price,");
		sql.append("       t1.book_number, ");
		sql.append("       decode(t1.validstate,'1','正常','2','过期停用','正常') as validstate ");//有效状态
		sql.append("  from czt_ibrary_bookinfo t1");
		sql.append("  where t1.book_id in ("+bookIds+")");
		sql.append("  order by t1.book_name ");
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared(conn);
		
		for (int i = 0; i < pdb.size(); i++) {
			Map<String, String> bookInfoMap = new HashMap<String, String>();
			bookInfoMap.put("book_id", pdb.getString(i, "book_id"));
			bookInfoMap.put("book_name", pdb.getString(i, "book_name"));
			bookInfoMap.put("book_no", pdb.getString(i, "book_no"));
			bookInfoMap.put("book_author", pdb.getString(i, "book_author"));
			bookInfoMap.put("book_price", pdb.getString(i, "book_price"));
			bookInfoMap.put("book_number", pdb.getString(i, "book_number"));
			bookInfoMap.put("validstate", pdb.getString(i, "validstate"));
			
			bookInfoList.add(bookInfoMap);
		}
		
		return bookInfoList;
	}

	/**
	 * 
	  * <b>Summary: 查询图书申请表信息</b>
	  *     复写方法 queryRegBookInfo
	  * @param bookRegIds
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.caizhengting.ibrary.dao.IbraryBookInfoDao#queryRegBookInfo(java.lang.String, java.sql.Connection)
	 */
	public List<Map<String, String>> queryRegBookInfo(String bookRegId,
			Connection conn) throws Exception {
		List<Map<String, String>> regBookInfoList  = new ArrayList<Map<String,String>>();
		StringBuffer sql = new StringBuffer();
		PreparedDBUtil  db = new PreparedDBUtil ();
		sql.append("   select distinct(t.t_regb_id)t_regb_id ,t.t_regb_user_id,t.t_regb_user_name,");
		sql.append("   to_char(t.t_regb_date,'yyyy-MM-dd')t_regb_date,t.t_regb_bookids,t.t_regb_org_id, ");
		sql.append("   t.t_regb_org_name,t.t_regb_dept_id,t.t_regb_dept_name, ");
		sql.append("   t.t_regb_state,to_char(t.t_regb_gh_date,'yyyy-MM-dd')t_regb_gh_date,t.t_regb_booknames, ");
		sql.append("   t.t_regb_iskonw,to_char(t.t_regb_jy_date,'yyyy-MM-dd')t_regb_jy_date,to_char(t.t_regb_truegh_date,'yyyy-MM-dd')t_regb_truegh_date, ");
		sql.append("   t.t_regb_isxj, ");
		sql.append("   t.t_regb_auditopinion ");//审核意见
		sql.append("   from TA_OA_REGBOOK t ");
		sql.append("       where 1=1");
		sql.append("       and  t.t_regb_id = ? ");
		
		db.preparedSelect(sql.toString());
		db.setString(1, bookRegId);
		
		db.executePrepared();
		
		for (int i = 0; i < db.size(); i++) {
			Map<String, String>  regBookInfoMap = new HashMap<String, String>();
			regBookInfoMap.put("t_regb_id", db.getString(i, "t_regb_id"));
			regBookInfoMap.put("t_regb_user_id", db.getString(i, "t_regb_user_id"));
			regBookInfoMap.put("t_regb_user_name", db.getString(i, "t_regb_user_name"));
			regBookInfoMap.put("t_regb_date", db.getString(i, "t_regb_date"));
			regBookInfoMap.put("t_regb_bookids", db.getString(i, "t_regb_bookids"));
			regBookInfoMap.put("t_regb_org_id", db.getString(i, "t_regb_org_id"));
			regBookInfoMap.put("t_regb_org_name", db.getString(i, "t_regb_org_name"));
			regBookInfoMap.put("t_regb_dept_id", db.getString(i, "t_regb_dept_id"));
			regBookInfoMap.put("t_regb_dept_name", db.getString(i, "t_regb_dept_name"));
			regBookInfoMap.put("t_regb_state", db.getString(i, "t_regb_state"));
			regBookInfoMap.put("t_regb_gh_date", db.getString(i, "t_regb_gh_date"));
			regBookInfoMap.put("t_regb_booknames", db.getString(i, "t_regb_booknames"));
			regBookInfoMap.put("t_regb_iskonw", db.getString(i, "t_regb_iskonw"));
			regBookInfoMap.put("t_regb_jy_date", db.getString(i, "t_regb_jy_date"));
			regBookInfoMap.put("t_regb_truegh_date", db.getString(i, "t_regb_truegh_date"));
			regBookInfoMap.put("t_regb_isxj", db.getString(i, "t_regb_isxj"));
			regBookInfoMap.put("t_regb_auditopinion", db.getString(i,"t_regb_auditopinion"));//审核意见
			regBookInfoList.add(regBookInfoMap);
		}
		
		return regBookInfoList;
	}

	/**
	 * 
	  * <b>Summary: 查询申请表申请图书信息</b>
	  *     复写方法 queryRegBookBookInfo
	  * @param bookRegId
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.caizhengting.ibrary.dao.IbraryBookInfoDao#queryRegBookBookInfo(java.lang.String, java.sql.Connection)
	 */
	public List<Map<String, String>> queryRegBookBookInfo(
			String bookRegId, Connection conn) throws Exception {
		List<Map<String, String>> regBookBookInfoList  = new ArrayList<Map<String,String>>();
		StringBuffer sql = new StringBuffer();
		
		sql.append("  select t_reg_book_id,t_reg_book_regid,t_reg_book_book_id,");
		sql.append("  t_reg_book_book_name,t_reg_book_book_jg,t_reg_book_book_no,t_reg_book_book_bh,t_reg_book_book_auter, ");
		sql.append("  decode(info.validstate,'1','正常','2','过期停用','正常') as validstate ");
		sql.append(" from TA_OA_REGBOOK_BOOK t ");
		sql.append(" left join czt_ibrary_bookinfo info on t.t_reg_book_book_id = info.book_id ");
		sql.append("  where t.T_REG_BOOK_REGID = ? ");
		sql.append("  order by  t.t_reg_book_book_name");
		
		regBookBookInfoList  =  queryToListMap(sql.toString(), bookRegId);
		
		return regBookBookInfoList;
	}

	/**
	 * 
	  * <b>Summary: 查询申请表列表</b>
	  *     复写方法 findRegBookInfoList
	  * @param iBraryRegBookInfoBean
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.caizhengting.ibrary.dao.IbraryBookInfoDao#findRegBookInfoList(com.chinacreator.xtbg.caizhengting.ibrary.entity.IBraryRegBookInfoBean, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean findRegBookInfoList(
			IBraryRegBookInfoBean iBraryRegBookInfoBean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<IBraryRegBookInfoBean> list = new ArrayList<IBraryRegBookInfoBean>();
		StringBuffer sql = new StringBuffer();
		//String nowDateString = DateUtil.getCurrentDate();                    //当前日期
		
		sql.append("   select distinct(t.t_regb_id)t_regb_id ,t.t_regb_user_id,t.t_regb_user_name,");
		sql.append("   to_char(t.t_regb_date,'yyyy-MM-dd')t_regb_date,t.t_regb_bookids,t.t_regb_org_id, ");
		sql.append("   t.t_regb_org_name,t.t_regb_dept_id,t.t_regb_dept_name, ");
		sql.append("   t.t_regb_state,to_char(t.t_regb_gh_date,'yyyy-MM-dd')t_regb_gh_date,to_char(t.t_regb_booknames) as t_regb_booknames, ");
		sql.append("   t.t_regb_iskonw,to_char(t.t_regb_jy_date,'yyyy-MM-dd')t_regb_jy_date,to_char(t.t_regb_truegh_date,'yyyy-MM-dd')t_regb_truegh_date, ");
		sql.append("   t.t_regb_isxj,t.t_regb_sqtype ");
		sql.append("   from TA_OA_REGBOOK t ");
		sql.append("       where 1=1");
		if (!StringUtil.isBlank(iBraryRegBookInfoBean.getWhatTabs())) {
			if (iBraryRegBookInfoBean.getWhatTabs().equals("1")) {
				sql.append("    and (t_regb_state = '1' or t_regb_state = '3') ");
			}else if(iBraryRegBookInfoBean.getWhatTabs().equals("2")){
				sql.append("    and (((t_regb_state = '2' ");
				sql.append("    and t_regb_gh_date >= to_date('"+StringUtil.deNull(iBraryRegBookInfoBean.getT_regb_gh_date()) +"','yyyy-MM-dd')) ");
				sql.append("    or t_regb_state = '6') or (t_regb_sqtype = '领用申请' and (t_regb_state = '2' or t_regb_state = '6'))) ");
			}else if (iBraryRegBookInfoBean.getWhatTabs().equals("3")){
				sql.append("    and t_regb_state = '2'");
				sql.append("    and t_regb_gh_date < to_date('"+StringUtil.deNull(iBraryRegBookInfoBean.getT_regb_gh_date()) +"','yyyy-MM-dd')");
			}
		}
		if (!StringUtil.isBlank(iBraryRegBookInfoBean.getT_regb_user_id())) {
			sql.append("    and t_regb_user_id = ? ");
		}
		if (!StringUtil.isBlank(iBraryRegBookInfoBean.getT_regb_dept_id())) {
			sql.append("    and t_regb_dept_id = ? ");
		}
		if (!StringUtil.isBlank(iBraryRegBookInfoBean.getSq_start_time())) {
			sql.append("    and t_regb_date >= to_date(?,'yyyy-MM-dd')");
		}
		if (!StringUtil.isBlank(iBraryRegBookInfoBean.getSq_end_time())) {
			sql.append("    and t_regb_date <= to_date(?,'yyyy-MM-dd')");
		}
		if (!StringUtil.isBlank(iBraryRegBookInfoBean.getJy_start_time())) {
			sql.append("    and t_regb_jy_date >= to_date(?,'yyyy-MM-dd')");
		}
		if (!StringUtil.isBlank(iBraryRegBookInfoBean.getJy_end_time())) {
			sql.append("    and t_regb_jy_date <= to_date(?,'yyyy-MM-dd')");
		}
		
		sql.append(" order by " + sortName + " " + sortOrder);
    	db.preparedSelect(sql.toString(), offset, maxPagesize);
    	
    	int k = 1;
    	if (!StringUtil.isBlank(iBraryRegBookInfoBean.getT_regb_user_id())) {
			db.setString(k++, iBraryRegBookInfoBean.getT_regb_user_id());
		}
		if (!StringUtil.isBlank(iBraryRegBookInfoBean.getT_regb_dept_id())) {
			db.setString(k++, iBraryRegBookInfoBean.getT_regb_dept_id());
		}
		if (!StringUtil.isBlank(iBraryRegBookInfoBean.getSq_start_time())) {
			db.setString(k++, iBraryRegBookInfoBean.getSq_start_time());
		}
		if (!StringUtil.isBlank(iBraryRegBookInfoBean.getSq_end_time())) {
			db.setString(k++, iBraryRegBookInfoBean.getSq_end_time());
		}
		if (!StringUtil.isBlank(iBraryRegBookInfoBean.getJy_start_time())) {
			db.setString(k++, iBraryRegBookInfoBean.getJy_start_time());
		}
		if (!StringUtil.isBlank(iBraryRegBookInfoBean.getJy_end_time())) {
			db.setString(k++, iBraryRegBookInfoBean.getJy_end_time());
		}
    	
    	db.executePrepared();
		for(int i = 0;i < db.size();i++){
			IBraryRegBookInfoBean iBraryRegBookInfoBeanDB = new IBraryRegBookInfoBean();
			iBraryRegBookInfoBeanDB.setT_regb_id(db.getString(i, "t_regb_id"));
			iBraryRegBookInfoBeanDB.setT_regb_user_id(db.getString(i, "t_regb_user_id"));
			iBraryRegBookInfoBeanDB.setT_regb_user_name(db.getString(i, "t_regb_user_name"));
			iBraryRegBookInfoBeanDB.setT_regb_date(db.getString(i, "t_regb_date"));
			iBraryRegBookInfoBeanDB.setT_regb_bookids(db.getString(i, "t_regb_bookids"));
			iBraryRegBookInfoBeanDB.setT_regb_org_id(db.getString(i, "t_regb_org_id"));
			iBraryRegBookInfoBeanDB.setT_regb_org_name(db.getString(i, "t_regb_org_name"));
			iBraryRegBookInfoBeanDB.setT_regb_dept_id(db.getString(i, "t_regb_dept_id"));
			iBraryRegBookInfoBeanDB.setT_regb_dept_name(db.getString(i, "t_regb_dept_name"));
			iBraryRegBookInfoBeanDB.setT_regb_state(db.getString(i, "t_regb_state"));
			iBraryRegBookInfoBeanDB.setT_regb_gh_date(db.getString(i, "t_regb_gh_date"));
			iBraryRegBookInfoBeanDB.setT_regb_booknames(db.getString(i, "t_regb_booknames"));
			iBraryRegBookInfoBeanDB.setT_regb_iskonw(db.getString(i, "t_regb_iskonw"));
			iBraryRegBookInfoBeanDB.setT_regb_jy_date(db.getString(i, "t_regb_jy_date"));
			iBraryRegBookInfoBeanDB.setT_regb_truegh_date(db.getString(i, "t_regb_truegh_date"));
			iBraryRegBookInfoBeanDB.setT_regb_isxj(db.getString(i, "t_regb_isxj"));
			iBraryRegBookInfoBeanDB.setT_regb_sqtype(db.getString(i, "t_regb_sqtype"));
			list.add(iBraryRegBookInfoBeanDB);
	    }
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}

	/**
	 * 
	  * <b>Summary: 查询已超期图书</b>
	  *     复写方法 findRegBookInfoYJYList
	  * @param iBraryRegBookInfoBean
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.caizhengting.ibrary.dao.IbraryBookInfoDao#findRegBookInfoYJYList(com.chinacreator.xtbg.caizhengting.ibrary.entity.IBraryRegBookInfoBean)
	 */
	public List<IBraryRegBookInfoBean> findRegBookInfoYJYList(
			IBraryRegBookInfoBean iBraryRegBookInfoBean) throws Exception {
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<IBraryRegBookInfoBean> list = new ArrayList<IBraryRegBookInfoBean>();
		StringBuffer sql = new StringBuffer();
		//String nowDateString = DateUtil.getCurrentDate();                    //当前日期
		
		sql.append("   select distinct(t.t_regb_id)t_regb_id ,t.t_regb_user_id,t.t_regb_user_name,");
		sql.append("   to_char(t.t_regb_date,'yyyy-MM-dd')t_regb_date,t.t_regb_bookids,t.t_regb_org_id, ");
		sql.append("   t.t_regb_org_name,t.t_regb_dept_id,t.t_regb_dept_name, ");
		sql.append("   t.t_regb_state,to_char(t.t_regb_gh_date,'yyyy-MM-dd')t_regb_gh_date,t.t_regb_booknames, ");
		sql.append("   t.t_regb_iskonw,to_char(t.t_regb_jy_date,'yyyy-MM-dd')t_regb_jy_date,to_char(t.t_regb_truegh_date,'yyyy-MM-dd')t_regb_truegh_date, ");
		sql.append("   t.t_regb_isxj ");
		sql.append("   from TA_OA_REGBOOK t ");
		sql.append("       where 1=1");
		sql.append("   and t_regb_sqtype <> '领用申请'");
		sql.append("    and t_regb_state = '2'");
		sql.append("    and t_regb_gh_date < to_date('"+StringUtil.deNull(iBraryRegBookInfoBean.getT_regb_gh_date()) +"','yyyy-MM-dd')");
		
		if (!StringUtil.isBlank(iBraryRegBookInfoBean.getT_regb_user_id())) {
			sql.append("    and t_regb_user_id = ? ");
		}
	    
		db.preparedSelect(sql.toString());
    	
    	int k = 1;
    	if (!StringUtil.isBlank(iBraryRegBookInfoBean.getT_regb_user_id())) {
			db.setString(k++, iBraryRegBookInfoBean.getT_regb_user_id());
		}
    	
    	db.executePrepared();
		for(int i = 0;i < db.size();i++){
			IBraryRegBookInfoBean iBraryRegBookInfoBeanDB = new IBraryRegBookInfoBean();
			iBraryRegBookInfoBeanDB.setT_regb_id(db.getString(i, "t_regb_id"));
			iBraryRegBookInfoBeanDB.setT_regb_user_id(db.getString(i, "t_regb_user_id"));
			iBraryRegBookInfoBeanDB.setT_regb_user_name(db.getString(i, "t_regb_user_name"));
			iBraryRegBookInfoBeanDB.setT_regb_date(db.getString(i, "t_regb_date"));
			iBraryRegBookInfoBeanDB.setT_regb_bookids(db.getString(i, "t_regb_bookids"));
			iBraryRegBookInfoBeanDB.setT_regb_org_id(db.getString(i, "t_regb_org_id"));
			iBraryRegBookInfoBeanDB.setT_regb_org_name(db.getString(i, "t_regb_org_name"));
			iBraryRegBookInfoBeanDB.setT_regb_dept_id(db.getString(i, "t_regb_dept_id"));
			iBraryRegBookInfoBeanDB.setT_regb_dept_name(db.getString(i, "t_regb_dept_name"));
			iBraryRegBookInfoBeanDB.setT_regb_state(db.getString(i, "t_regb_state"));
			iBraryRegBookInfoBeanDB.setT_regb_gh_date(db.getString(i, "t_regb_gh_date"));
			iBraryRegBookInfoBeanDB.setT_regb_booknames(db.getString(i, "t_regb_booknames"));
			iBraryRegBookInfoBeanDB.setT_regb_iskonw(db.getString(i, "t_regb_iskonw"));
			iBraryRegBookInfoBeanDB.setT_regb_jy_date(db.getString(i, "t_regb_jy_date"));
			iBraryRegBookInfoBeanDB.setT_regb_truegh_date(db.getString(i, "t_regb_truegh_date"));
			iBraryRegBookInfoBeanDB.setT_regb_isxj(db.getString(i, "t_regb_isxj"));
			iBraryRegBookInfoBeanDB.setT_regb_sqtype("t_regb_sqtype");
			list.add(iBraryRegBookInfoBeanDB);
	    }
		return list;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 queryRegYJYBookBookInfo
	  * @param user_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.caizhengting.ibrary.dao.IbraryBookInfoDao#queryRegYJYBookBookInfo(java.lang.String)
	 */
	public List<Map<String, String>> queryRegYJYBookBookInfo(String user_id)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		PreparedDBUtil pdb = new PreparedDBUtil();
		
		List<Map<String, String>> bookInfoList = new ArrayList<Map<String,String>>();
		
		sql.append("select t1.t_reg_book_id,");
		sql.append("       t1.t_reg_book_regid,");
		sql.append("       t1.t_reg_book_book_id,");
		sql.append("       t1.t_reg_book_book_name,");
		sql.append("       t1.t_reg_book_book_jg,");
		sql.append("       t1.t_reg_book_book_no, ");
		sql.append("       t1.t_reg_book_book_bh, ");
		sql.append("       t1.t_reg_book_book_auter, ");
		sql.append("       decode(info.validstate, '1', '正常', '1', '过期停用', '正常') as validstate ");
		sql.append("  from TA_OA_REGBOOK_BOOK t1 left join czt_ibrary_bookinfo info on t1.t_reg_book_book_id = info.book_id");
		sql.append("    ,TA_OA_REGBOOK t ");
		sql.append("  where 1=1 ");
		sql.append("  and t1.T_REG_BOOK_REGID=t.T_REGB_ID ");
		sql.append("  and t.t_regb_state in('2','6') ");
		sql.append("  and t.T_REGB_USER_ID = '"+user_id+"'");
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared();
		
		for (int i = 0; i < pdb.size(); i++) {
			Map<String, String> bookInfoMap = new HashMap<String, String>();
			bookInfoMap.put("t_reg_book_id", pdb.getString(i, "t_reg_book_id"));
			bookInfoMap.put("t_reg_book_regid", pdb.getString(i, "t_reg_book_regid"));
			bookInfoMap.put("t_reg_book_book_id", pdb.getString(i, "t_reg_book_book_id"));
			bookInfoMap.put("t_reg_book_book_name", pdb.getString(i, "t_reg_book_book_name"));
			bookInfoMap.put("t_reg_book_book_jg", pdb.getString(i, "t_reg_book_book_jg"));
			bookInfoMap.put("t_reg_book_book_no", pdb.getString(i, "t_reg_book_book_no"));
			bookInfoMap.put("t_reg_book_book_bh", pdb.getString(i, "t_reg_book_book_bh"));
			bookInfoMap.put("t_reg_book_book_auter", pdb.getString(i, "t_reg_book_book_auter"));
			bookInfoMap.put("validstate", pdb.getString(i, "validstate"));//有效状态
			
			bookInfoList.add(bookInfoMap);
		}
		
		return bookInfoList;
	}

	/**
	 * 
	  * <b>Summary: 查询所有图书分类</b>
	  *     复写方法 findBookInfoTree
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.caizhengting.ibrary.dao.IbraryBookInfoDao#findBookInfoTree()
	 */
	public List<Map<String, String>> findBookInfoTree() throws Exception {
		StringBuffer sql = new StringBuffer();
		PreparedDBUtil pdb = new PreparedDBUtil();
		
		List<Map<String, String>> bookInfoTreeList = new ArrayList<Map<String,String>>();
		
		sql.append("select t.tree_id,");
		sql.append("       t.tree_name ");
		sql.append("  from CZT_IBRARYTREE t");
		sql.append("  where 1=1 ");
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared();
		Map<String, String> bookInfoTreeMap = new HashMap<String, String>();
		for (int i = 0; i < pdb.size(); i++) {
			bookInfoTreeMap.put(pdb.getString(i, "tree_name"), pdb.getString(i, "tree_id"));
			//bookInfoTreeMap.put("tree_name", pdb.getString(i, "tree_name"));
		}
		bookInfoTreeList.add(bookInfoTreeMap);
		return bookInfoTreeList;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 queryRegBookInfoByBookId
	  * @param book_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.caizhengting.ibrary.dao.IbraryBookInfoDao#queryRegBookInfoByBookId(java.lang.String)
	 */
	public String queryRegBookInfoByBookId(String book_id) throws Exception {
		StringBuffer sql = new StringBuffer();
		PreparedDBUtil pdb = new PreparedDBUtil();
		String num = "0";

		sql.append("select count(t1.t_reg_book_id) num");
		sql.append("  from TA_OA_REGBOOK_BOOK t1,TA_OA_REGBOOK t");
		sql.append("  where 1=1 ");
		sql.append("  and t1.T_REG_BOOK_REGID=t.T_REGB_ID ");
		sql.append("  and t.t_regb_state in('2','6') ");
		sql.append("  and t1.t_reg_book_book_id in("+book_id+")");
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared();
		
		num = pdb.getString(0, "num");
		
		return num;
	}

	/**
	 * 
	  * <b>Summary: 根据申请表IDs删除申请表信息</b>
	  *     复写方法 deleteRegBookInfo
	  * @param t_regb_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.caizhengting.ibrary.dao.IbraryBookInfoDao#deleteRegBookInfo(java.lang.String, java.sql.Connection)
	 */
	public boolean deleteRegBookInfo(String t_regb_id,Connection conn) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from TA_OA_REGBOOK ");
		sql.append(" where T_REGB_ID in ("+t_regb_id+")");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.executePrepared(conn);
		return true;
	}
}
