package com.chinacreator.xtbg.caizhengting.press.dao.imploracle;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.chinacreator.xtbg.caizhengting.press.dao.PressDao;
import com.chinacreator.xtbg.caizhengting.press.entity.PressBean;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

public class PressDaoImpl implements PressDao{

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 delete
	  * @param ids
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.caizhengting.press.dao.PressDao#delete(java.lang.String, java.sql.Connection)
	 */
	@Override
	public boolean delete(String ids, Connection conn) throws Exception {
		boolean flag = false;
		StringBuffer sql = new StringBuffer();
		PreparedDBUtil db = new PreparedDBUtil();
		sql.append("delete czt_press");
		sql.append(" where press_id in("+ids+")");
		db.preparedDelete(sql.toString());
		db.executePrepared(conn);
		flag = true;
		return flag;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findPressBeanByName
	  * @param name
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.caizhengting.press.dao.PressDao#findPressBeanByName(java.lang.String, java.sql.Connection)
	 */
	@Override
	public PressBean findPressBeanByName(String name, Connection conn)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		PreparedDBUtil db = new PreparedDBUtil();
		sql.append("select press_id, press_name, order_no from czt_press where press_name = ? ");
		db.preparedSelect(sql.toString());
		db.setString(1, name);
		db.executePrepared(conn);
		if(db.size() >= 1){
			PressBean bean = new PressBean();
			bean.setPress_id(db.getString(0, "press_id"));
			bean.setPress_name(db.getString(0, "press_name"));
			bean.setOrder_no(db.getString(0, "order_no"));
			return bean;
		}
		return null;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 insert
	  * @param bean
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.caizhengting.press.dao.PressDao#insert(com.chinacreator.xtbg.caizhengting.press.entity.PressBean, java.sql.Connection)
	 */
	@Override
	public String insert(PressBean bean, Connection conn) throws Exception {
		String flag = "操作失败";
		StringBuffer sql = new StringBuffer();
		PreparedDBUtil db = new PreparedDBUtil();
		sql.append("insert into czt_press (press_id, press_name, order_no) values (?, ?, ?)");
		db.preparedInsert(sql.toString());
		int n = 1;
		db.setString(n++, bean.getPress_id());
		db.setString(n++, bean.getPress_name());
		db.setString(n++, bean.getOrder_no());
		db.executePrepared(conn);
		flag = "操作成功";
		return flag;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 update
	  * @param bean
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.caizhengting.press.dao.PressDao#update(com.chinacreator.xtbg.caizhengting.press.entity.PressBean, java.sql.Connection)
	 */
	@Override
	public boolean update(PressBean bean, Connection conn) throws Exception {
		boolean flag = false;
		StringBuffer sql = new StringBuffer();
		PreparedDBUtil db = new PreparedDBUtil();
		sql.append("update czt_press set press_name=?, order_no=? where press_id=?");
		db.preparedUpdate(sql.toString());
		int n = 1;
		db.setString(n++, bean.getPress_name());
		db.setString(n++, bean.getOrder_no());
		db.setString(n++, bean.getPress_id());
		db.executePrepared(conn);
		flag = true;
		return flag;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 list
	  * @param bean
	  * @param sortname
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.caizhengting.press.dao.PressDao#list(com.chinacreator.xtbg.caizhengting.press.entity.PressBean, java.lang.String, java.lang.String, long, int)
	 */
	@Override
	public PagingBean list(PressBean bean, String sortname, String sortOrder,
			long offset, int maxPagesize,Connection conn) throws Exception {
		PagingBean pb = new PagingBean();
		PreparedDBUtil db = new PreparedDBUtil();
		List<PressBean> list = new ArrayList<PressBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select press_id, press_name, order_no from czt_press ");
		db.preparedSelect(sql.toString(), offset, maxPagesize);
		db.executePrepared(conn);
		for (int i = 0; i < db.size(); i++) {
			PressBean pressBean = new PressBean();
			pressBean.setPress_id(db.getString(i, "press_id"));
			pressBean.setPress_name(db.getString(i, "press_name"));
			pressBean.setOrder_no(db.getString(i, "order_no"));
			list.add(pressBean);
		}
		pb.setList(list);
		pb.setRecords((long) db.getTotalSize());
		return pb;
	}

}
