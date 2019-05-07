package com.chinacreator.xtbg.caizhengting.ibrary.service.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.chinacreator.xtbg.caizhengting.ibrary.dao.IbraryBorrowInfoDao;
import com.chinacreator.xtbg.caizhengting.ibrary.dao.impl.IbraryBorrowInfoDaoImpl;
import com.chinacreator.xtbg.caizhengting.ibrary.entity.IbraryBorrowInfoBean;
import com.chinacreator.xtbg.caizhengting.ibrary.service.IbraryBorrowInfoService;
import com.chinacreator.xtbg.pub.util.DbconnManager;

/**
 *<p>Title:IbraryBorrowInfoServiceImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 任涛
 *@version 1.0
 *2013-9-3
 */
public class IbraryBorrowInfoServiceImpl implements IbraryBorrowInfoService{

	@Override
	public String addbean(IbraryBorrowInfoBean bean) {
		String flag = "操作失败";
		Connection con = null;
		try {
			con = DbconnManager.getInstance().getConnection();
			IbraryBorrowInfoDao dao = new IbraryBorrowInfoDaoImpl();
			flag = dao.addbean(bean, con);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DbconnManager.closeConnection(con);
		}
		return flag;
	}

	@Override
	public IbraryBorrowInfoBean getbeanbyid(String id) {
		IbraryBorrowInfoBean bean = null;
		Connection con = null;
		try {
			con = DbconnManager.getInstance().getConnection();
			IbraryBorrowInfoDao dao = new IbraryBorrowInfoDaoImpl();
			 bean = dao.getbeanbyid(id, con);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DbconnManager.closeConnection(con);
		}
		return bean;
	}

	@Override
	public List<IbraryBorrowInfoBean> getlistbybookid(String id) {
		List<IbraryBorrowInfoBean> list = new ArrayList<IbraryBorrowInfoBean>();
		Connection conn = null;
		try {
			conn = DbconnManager.getInstance().getConnection();
			IbraryBorrowInfoDao dao = new IbraryBorrowInfoDaoImpl();
			list = dao.getlistbybookid(id, conn);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DbconnManager.closeConnection(conn);
		}
		return list;
	}

	@Override
	public String getAgreementExpireRemindTime() {
		Connection con = null;
		String str ="";
		try {
			con = DbconnManager.getInstance().getConnection();
			IbraryBorrowInfoDao dao = new IbraryBorrowInfoDaoImpl();
			str = dao.getAgreementExpireRemindTime(con);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DbconnManager.closeConnection(con);
		}
		return str;
	}

	@Override
	public String updatebean(IbraryBorrowInfoBean bean) {
		String flag = "操作失败";
		Connection con = null;
		try {
			con = DbconnManager.getInstance().getConnection();
			IbraryBorrowInfoDao dao = new IbraryBorrowInfoDaoImpl();
			flag = dao.updatebean(bean, con);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DbconnManager.closeConnection(con);
		}
		return flag;
	}

	@Override
	public String delteBookBorrowinfobyBookId(String id) {
		String flag = "操作失败";
		Connection con = null;
		try {
			con = DbconnManager.getInstance().getTransactionConnection();
			IbraryBorrowInfoDao dao = new IbraryBorrowInfoDaoImpl();
			flag = dao.delteBookBorrowinfobyBookId(id, con);
		} catch (Exception e) {
			e.printStackTrace();
			DbconnManager.closeTransactionConnection( con,false);
		} finally {
			DbconnManager.closeTransactionConnection( con,true);
		}
		return flag;
	}
}
