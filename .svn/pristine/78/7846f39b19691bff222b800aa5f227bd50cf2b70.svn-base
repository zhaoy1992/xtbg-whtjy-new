package com.chinacreator.xtbg.caizhengting.ibrary.dao.impl;

import java.sql.Connection;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.caizhengting.ibrary.dao.IbraryTreeDao;
import com.chinacreator.xtbg.caizhengting.ibrary.entity.IbraryTreeBean;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.SqlUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:IbraryTreeDaoImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 任涛
 *@version 1.0
 *2013-9-3
 */
public class IbraryTreeDaoImpl implements IbraryTreeDao{
	private static final Logger LOG = Logger.getLogger(IbraryTreeDaoImpl.class);
	@Override
	public String addIbraryTree(IbraryTreeBean bean, Connection con)
			throws Exception {
		String flag = "";
		StringBuffer sql = new StringBuffer();
		sql.append("insert into CZT_IBRARYTREE");
		sql.append("  (tree_id, tree_parent_id, tree_name, tree_type_code, tree_type_no, order_no, remark, unit_id, unit_name)");
		sql.append(" values ");
		sql.append("  (?, ?, ?, ?, ?, ?, ?, ?, ?)");
		try {
			SqlUtil<IbraryTreeBean> sqlUtil = new SqlUtil<IbraryTreeBean>();
			sqlUtil.executeInsert(sql.toString(), bean, con);
			flag = "操作成功" ;
		} catch (Exception e) {
			flag = "操作失败" ;
			LOG.error(e.getMessage());
		}
		return flag;
	}

	@Override
	public String delIbraryTree(String id,String type,Connection con) throws Exception {
		String flag = "";
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		try {
			int count = 0;
			String msg = "";
			if(!StringUtil.nullOrBlank(type)){
				if("treetype".equals(type)){
					sql.append("delete CZT_IBRARYTREE t where t.tree_id in ("+id+")");
					count = gettreebyid(id); //删除中间层 查询节点是否包含子节点
					if(count>0){
						msg ="请先删除该节点下的所有节点!";
					}
				}else{
					sql.append("delete CZT_IBRARYTREE t where t.tree_id = '"+id+"'");
					count = getbookbytreeid(id); //删除最低曾 查询节点是否包含图书
					if(count>0){
						msg ="请先删除该节点下的所有图书!";
					}
				}
			}
			if(count>0){
				flag = msg;
			}else{
				pdb.preparedInsert(sql.toString());
				pdb.executePrepared(con);
				flag = "操作成功" ;
			}
		} catch (Exception e) {
			flag = "操作失败" ;
			LOG.error(e.getMessage());
		}
		return flag;
	}

	@Override
	public IbraryTreeBean getbeanbyid(String id, Connection con)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append(" select t.tree_id,t1.tree_name as tree_parent_id,t.tree_name,t.tree_type_code,t.tree_type_no,t.order_no,t.remark");
		sql.append(" from CZT_IBRARYTREE t left join CZT_IBRARYTREE t1 on t.tree_parent_id = t1.tree_id where t.tree_id = ?");
		SqlUtil<IbraryTreeBean> sqlUtil = new SqlUtil<IbraryTreeBean>();
		IbraryTreeBean bean = new IbraryTreeBean();
		bean.setTree_id(id);
		bean = sqlUtil.executeForObject(sql.toString(), bean,con);
		return bean;
	}

	@Override
	public PagingBean list(IbraryTreeBean bean, String sortName,
			String sortOrder, long offset, int maxPagesize, Connection con)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("select tree_id,tree_parent_id,tree_name,tree_type_code,DECODE(tree_type_no,'1','中间层','2','最底层','第一层') as tree_type_no    ,order_no,remark from CZT_IBRARYTREE t where 1=1 ");
		if(!StringUtil.nullOrBlank(bean.getTree_parent_id())){
			sql.append(" and tree_parent_id='"+bean.getTree_parent_id()+"'"); //二级分类
		}else{
			sql.append(" and tree_type_no = '1' "); //默认 查所以一级分类
		}
		if(!StringUtil.nullOrBlank(bean.getUnit_id())){
			sql.append(" and unit_id = '"+bean.getUnit_id()+"' ");
		}
		sql.append("  order by order_no ");
		SqlUtil<IbraryTreeBean> sqlUtil = new SqlUtil<IbraryTreeBean>();
		PagingBean pb = sqlUtil.executeForListWithPage(sql.toString(), bean, sortName, sortOrder, offset, maxPagesize, con);
		return pb;
	}

	@Override
	public String updatebean(IbraryTreeBean bean,Connection con)
	throws Exception {
		String flag = "";
		String sql ="update CZT_IBRARYTREE set tree_name =?,tree_type_code =?,order_no =?,remark = ?, unit_id = ?, unit_name = ? where tree_id =? ";
		try {
			SqlUtil<IbraryTreeBean> sqlUtil = new SqlUtil<IbraryTreeBean>();
			sqlUtil.executeUpdate(sql.toString(), bean, con);
			flag = "操作成功" ;
		} catch (Exception e) {
			flag = "操作失败" ;
			LOG.error(e.getMessage());
		}
		return flag;
	}

	@Override
	public int getbookbytreeid(String treeid)
			throws Exception {
		int count =0;
		String rs ="";
		String sql = "select count(*) as count from czt_ibrary_bookinfo f where f.tree_id in('"+treeid+"')";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql);
		pdb.executePrepared();
		if(pdb.size()>0){
			 rs = pdb.getString(0,"count");
		}
		if(!"0".equals(rs)){
			count =1;
		}
		return count;
	}
	
	public int gettreebyid(String tree_id) throws Exception{
		int count =0;
		String rs ="";
		String sql = "select count(*) as count from CZT_IBRARYTREE f where f.tree_parent_id in ("+tree_id+")";
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql);
		pdb.executePrepared();
		if(pdb.size()>0){
			 rs = pdb.getString(0,"count");
		}
		if(!"0".equals(rs)){
			count =1;
		}
		return count;
	}

	@Override
	public String getCodeNo(String id,String type_code,Connection con) throws Exception {
		String codeno = "1";
		String sql = "select c.order_no + 1 as codeno from (select * from czt_ibrarytree order by order_no desc ) c where rownum=1";
		if(!StringUtil.nullOrBlank(id)){
			sql +=" and c.tree_parent_id='"+id+"' and tree_type_no="+type_code;
		}else{
			sql +=" and c.tree_parent_id is null and tree_type_no="+type_code; //查中间层的最大排号l
		}
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql);
		pdb.executePrepared();
		if(pdb.size()>0){
			codeno = pdb.getString(0,"codeno");
		}
		return codeno;
	}
	
}