package com.chinacreator.xtbg.caizhengting.ibrary.service.impl;

import java.sql.Connection;

import com.chinacreator.xtbg.caizhengting.ibrary.dao.IbraryTreeDao;
import com.chinacreator.xtbg.caizhengting.ibrary.dao.impl.IbraryTreeDaoImpl;
import com.chinacreator.xtbg.caizhengting.ibrary.entity.IbraryTreeBean;
import com.chinacreator.xtbg.caizhengting.ibrary.service.IbraryTreeService;
import com.chinacreator.xtbg.pub.util.DbconnManager;

/**
 *<p>Title:IbraryTreeService.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 任涛
 *@version 1.0
 *2013-9-3
 */
public class IbraryTreeServiceImpl implements IbraryTreeService{

	@Override
	public String addIbraryTree(IbraryTreeBean bean) {
		String flag = "操作失败";
		Connection con = null;
		try {
			con = DbconnManager.getInstance().getConnection();
			IbraryTreeDao dao = new IbraryTreeDaoImpl();
			flag = dao.addIbraryTree(bean,con);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DbconnManager.closeConnection(con);
		}
		return flag;
	}

	@Override
	public String delIbraryTree(String id,String type) {
		String flag = "操作失败";
		Connection con = null;
		try {
			con = DbconnManager.getInstance().getConnection();
			IbraryTreeDao dao = new IbraryTreeDaoImpl();
			flag = dao.delIbraryTree(id,type,con);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DbconnManager.closeConnection(con);
		}
		return flag;

	}

	@Override
	public IbraryTreeBean getbeanbyid(String id) {
		IbraryTreeBean bean = null;
		Connection con = null;
		try {
			con = DbconnManager.getInstance().getConnection();
			IbraryTreeDao dao = new IbraryTreeDaoImpl();
			 bean = dao.getbeanbyid(id, con);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DbconnManager.closeConnection(con);
		}
		return bean;
	}

	@Override
	public String updatebean(IbraryTreeBean bean) {
		String flag = "操作失败";
		Connection con = null;
		try {
			con = DbconnManager.getInstance().getConnection();
			IbraryTreeDao dao = new IbraryTreeDaoImpl();
			flag = dao.updatebean(bean,con);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DbconnManager.closeConnection(con);
		}
		return flag;
	}

	@Override
	public int getbookbytreeid(String treeid) {
		int count = 0;
		Connection con = null;
		try {
			con = DbconnManager.getInstance().getConnection();
			IbraryTreeDao dao = new IbraryTreeDaoImpl();
			count = dao.getbookbytreeid(treeid);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DbconnManager.closeConnection(con);
		}
		return count;
	}

	@Override
	public String getCodeNo(String id,String type_code) {
		String CodeNo = "";
		Connection con = null;
		try {
			con = DbconnManager.getInstance().getConnection();
			IbraryTreeDao dao = new IbraryTreeDaoImpl();
			CodeNo = dao.getCodeNo(id,type_code,con);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DbconnManager.closeConnection(con);
		}
		return CodeNo;
	}
}