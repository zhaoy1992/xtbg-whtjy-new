package com.chinacreator.xtbg.caizhengting.ibrary.service.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.caizhengting.ibrary.dao.IbraryBookInfoDao;
import com.chinacreator.xtbg.caizhengting.ibrary.dao.impl.IbraryBookInfoDaoImpl;
import com.chinacreator.xtbg.caizhengting.ibrary.entity.IBraryRegBookInfoBean;
import com.chinacreator.xtbg.caizhengting.ibrary.entity.IbraryBookInfoBean;
import com.chinacreator.xtbg.caizhengting.ibrary.entity.IbraryRegBookBookInfoBean;
import com.chinacreator.xtbg.caizhengting.ibrary.service.IbraryBookInfoService;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.pub.util.DbconnManager;

/**
 *<p>Title:IbraryBookInfoServiceImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 任涛
 *@version 1.0
 *2013-9-3
 */
public class IbraryBookInfoServiceImpl implements IbraryBookInfoService{
	
	private static final Log LOG=LogFactory.getLog(IbraryBookInfoServiceImpl.class);

	@Override
	public String addbookinfo(IbraryBookInfoBean bean) {
		String flag = "操作失败";
		Connection con = null;
		try {
			con = DbconnManager.getInstance().getConnection();
			IbraryBookInfoDao dao = new IbraryBookInfoDaoImpl();
			flag = dao.addbean(bean, con);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DbconnManager.closeConnection(con);
		}
		return flag;
	}

	@Override
	public String delbookinfo(String[] id) {
		String flag = "操作失败";
		Connection con = null;
		try {
			con = DbconnManager.getInstance().getConnection();
			IbraryBookInfoDao dao = new IbraryBookInfoDaoImpl();
			flag = dao.delbean(id, con);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DbconnManager.closeConnection(con);
		}
		return flag;
	}

	@Override
	public String updatebookinfo(IbraryBookInfoBean bean) {
		String flag = "操作失败";
		Connection con = null;
		try {
			con = DbconnManager.getInstance().getConnection();
			IbraryBookInfoDao dao = new IbraryBookInfoDaoImpl();
			flag = dao.updatebean(bean, con);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DbconnManager.closeConnection(con);
		}
		return flag;
	}

	@Override
	public IbraryBookInfoBean getbookinfobyid(String id) {
		IbraryBookInfoBean bean = null;
		Connection con = null;
		try {
			con = DbconnManager.getInstance().getConnection();
			IbraryBookInfoDao dao = new IbraryBookInfoDaoImpl();
			 bean = dao.getbeanbyid(id, con);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DbconnManager.closeConnection(con);
		}
		return bean;
	}

	@Override
	public String copybookinfo(IbraryBookInfoBean bean) {
		String flag = "操作失败";
		Connection con = null;
		try {
			con = DbconnManager.getInstance().getConnection();
			IbraryBookInfoDao dao = new IbraryBookInfoDaoImpl();
			flag = dao.copybookinfo(bean, con);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DbconnManager.closeConnection(con);
		}
		return flag;
	}

	@Override
	public String updatebookstate(IbraryBookInfoBean bean) {
		String flag = "操作失败";
		Connection con = null;
		try {
			con = DbconnManager.getInstance().getConnection();
			IbraryBookInfoDao dao = new IbraryBookInfoDaoImpl();
			flag = dao.updatebookstate(bean, con);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DbconnManager.closeConnection(con);
		}
		return flag;
	}

	@Override
	public String getbookCode(String tree_id) {
		String CodeNo = "";
		Connection con = null;
		try {
			con = DbconnManager.getInstance().getConnection();
			IbraryBookInfoDao dao = new IbraryBookInfoDaoImpl();
			CodeNo = dao.getbookCode(tree_id,con);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DbconnManager.closeConnection(con);
		}
		return CodeNo;
	}

	/**
	 * 
	  * <b>Summary: 增加和更新申请表信息</b>
	  *     复写方法 insertOrUpdateRegBookInfo
	  * @param iBraryRegBookInfoBean
	  * @return 
	  * @see com.chinacreator.xtbg.caizhengting.ibrary.service.IbraryBookInfoService#insertOrUpdateRegBookInfo(com.chinacreator.xtbg.caizhengting.ibrary.entity.IBraryRegBookInfoBean)
	 */
	public String insertOrUpdateRegBookInfo(
			IBraryRegBookInfoBean iBraryRegBookInfoBean) {
		Connection conn = null;
		String beanId = "";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			IbraryBookInfoDao ibraryBookInfoDao = new IbraryBookInfoDaoImpl();
			if (StringUtil.isBlank(iBraryRegBookInfoBean.getT_regb_id())) {
				iBraryRegBookInfoBean.setT_regb_id(UUID.randomUUID().toString());
				ibraryBookInfoDao.insertRegBookInfo(iBraryRegBookInfoBean, conn);
			}else{
				ibraryBookInfoDao.updateRegBookInfo(iBraryRegBookInfoBean, conn);
			}
			beanId = iBraryRegBookInfoBean.getT_regb_id();
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return beanId;
	}

	/**
	 * 
	  * <b>Summary: 增加和更新申请图书表信息</b>
	  *     复写方法 insertOrUpdateRegBookBookInfo
	  * @param ibraryRegBookBookInfoBean
	  * @return 
	  * @see com.chinacreator.xtbg.caizhengting.ibrary.service.IbraryBookInfoService#insertOrUpdateRegBookBookInfo(com.chinacreator.xtbg.caizhengting.ibrary.entity.IbraryRegBookBookInfoBean)
	 */
	public String insertOrUpdateRegBookBookInfo(
			IbraryRegBookBookInfoBean ibraryRegBookBookInfoBean) {
		Connection conn = null;
		String beanId = "";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			IbraryBookInfoDao ibraryBookInfoDao = new IbraryBookInfoDaoImpl();
			if (StringUtil.isBlank(ibraryRegBookBookInfoBean.getT_reg_book_id())) {
				ibraryRegBookBookInfoBean.setT_reg_book_id(UUID.randomUUID().toString());
				ibraryBookInfoDao.insertRegBookBookInfo(ibraryRegBookBookInfoBean, conn);
			}else{
				ibraryBookInfoDao.updateRegBookBookInfo(ibraryRegBookBookInfoBean, conn);
			}
			beanId = ibraryRegBookBookInfoBean.getT_reg_book_id();
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return beanId;
	}

	/**
	 * 
	  * <b>Summary: 根据申请表ID删除申请图书表信息</b>
	  *     复写方法 deleteRegBookBookInfo
	  * @param regBookIds
	  * @return 
	  * @see com.chinacreator.xtbg.caizhengting.ibrary.service.IbraryBookInfoService#deleteRegBookBookInfo(java.lang.String[])
	 */
	public boolean deleteRegBookBookInfo(String[] regBookIds) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			IbraryBookInfoDao ibraryBookInfoDao = new IbraryBookInfoDaoImpl();
			for (String beanId : regBookIds) {
				flag = ibraryBookInfoDao.deleteRegBookBookInfo(beanId, conn);
			}
			conn.commit();
		} catch (Exception e) {
			flag = false;
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}

	/**
	 * 
	  * <b>Summary: 更新图书库存数量</b>
	  *     复写方法 updateBookNumber
	  * @param ibraryBookInfoBean
	  * @return 
	  * @see com.chinacreator.xtbg.caizhengting.ibrary.service.IbraryBookInfoService#updateBookNumber(com.chinacreator.xtbg.caizhengting.ibrary.entity.IbraryBookInfoBean)
	 */
	public boolean updateBookNumber(IbraryBookInfoBean ibraryBookInfoBean) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			IbraryBookInfoDao ibraryBookInfoDao = new IbraryBookInfoDaoImpl();
			flag = ibraryBookInfoDao.updateBookNumber(ibraryBookInfoBean, conn);
			conn.commit();
		} catch (Exception e) {
			flag = false;
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}

	/**
	 * 
	  * <b>Summary: 查询图书信息</b>
	  *     复写方法 queryBookInfo
	  * @param bookIds
	  * @return 
	  * @see com.chinacreator.xtbg.caizhengting.ibrary.service.IbraryBookInfoService#queryBookInfo(java.lang.String)
	 */
	public List<Map<String, String>> queryBookInfo(String bookIds) {
		Connection conn = null;
		List<Map<String, String>> bookInfoList = new ArrayList<Map<String,String>>();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			IbraryBookInfoDao ibraryBookInfoDao = new IbraryBookInfoDaoImpl();
			bookInfoList = ibraryBookInfoDao.queryBookInfo(bookIds, conn);
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return bookInfoList;
	}

	/**
	 * 
	  * <b>Summary: 查询图书申请表信息</b>
	  *     复写方法 queryRegBookInfo
	  * @param bookRegId
	  * @return 
	  * @see com.chinacreator.xtbg.caizhengting.ibrary.service.IbraryBookInfoService#queryRegBookInfo(java.lang.String)
	 */
	public List<Map<String, String>> queryRegBookInfo(String bookRegId) {
		Connection conn = null;
		List<Map<String, String>> bookInfoList = new ArrayList<Map<String,String>>();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			IbraryBookInfoDao ibraryBookInfoDao = new IbraryBookInfoDaoImpl();
			bookInfoList = ibraryBookInfoDao.queryRegBookInfo(bookRegId, conn);
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return bookInfoList;
	}

	/**
	 * 
	  * <b>Summary: 查询申请表申请图书信息</b>
	  *     复写方法 queryRegBookBookInfo
	  * @param bookRegId
	  * @return 
	  * @see com.chinacreator.xtbg.caizhengting.ibrary.service.IbraryBookInfoService#queryRegBookBookInfo(java.lang.String)
	 */
	public List<Map<String, String>> queryRegBookBookInfo(String bookRegId) {
		Connection conn = null;
		List<Map<String, String>> bookInfoList = new ArrayList<Map<String,String>>();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			IbraryBookInfoDao ibraryBookInfoDao = new IbraryBookInfoDaoImpl();
			bookInfoList = ibraryBookInfoDao.queryRegBookBookInfo(bookRegId, conn);
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return bookInfoList;
	}

	/**
	 * 
	  * <b>Summary: 是否存在已超期图书</b>
	  *     复写方法 isHavaYCQBook
	  * @param iBraryRegBookInfoBean
	  * @return 
	  * @see com.chinacreator.xtbg.caizhengting.ibrary.service.IbraryBookInfoService#isHavaYCQBook(com.chinacreator.xtbg.caizhengting.ibrary.entity.IBraryRegBookInfoBean)
	 */
	public boolean isHavaYCQBook(IBraryRegBookInfoBean iBraryRegBookInfoBean) {
		Connection conn = null;
		List<IBraryRegBookInfoBean> list = new ArrayList<IBraryRegBookInfoBean>();
		boolean falg = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			IbraryBookInfoDao ibraryBookInfoDao = new IbraryBookInfoDaoImpl();
			list = ibraryBookInfoDao.findRegBookInfoYJYList(iBraryRegBookInfoBean);   //查询所有借阅的已超期的图书
			if(list.size()>0){                //存在已超期图书
				falg = false;
			}else{
				falg = true;
			}
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return falg;
	}

	/**
	 * 
	  * <b>Summary: 查询用户已借阅图书</b>
	  *     复写方法 queryRegYJYBookBookInfo
	  * @param user_id
	  * @return 
	  * @see com.chinacreator.xtbg.caizhengting.ibrary.service.IbraryBookInfoService#queryRegYJYBookBookInfo(java.lang.String)
	 */
	public List<Map<String, String>> queryRegYJYBookBookInfo(String user_id) {
		Connection conn = null;
		List<Map<String, String>> bookInfoList = new ArrayList<Map<String,String>>();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			IbraryBookInfoDao ibraryBookInfoDao = new IbraryBookInfoDaoImpl();
			bookInfoList = ibraryBookInfoDao.queryRegYJYBookBookInfo(user_id);
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return bookInfoList;
	}

	/**
	 * 
	  * <b>Summary: 查询所有图书分类</b>
	  *     复写方法 findBookInfoTree
	  * @return 
	  * @see com.chinacreator.xtbg.caizhengting.ibrary.service.IbraryBookInfoService#findBookInfoTree()
	 */
	public List<Map<String, String>> findBookInfoTree() {
		Connection conn = null;
		List<Map<String, String>> bookInfoTreeList = new ArrayList<Map<String,String>>();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			IbraryBookInfoDao ibraryBookInfoDao = new IbraryBookInfoDaoImpl();
			bookInfoTreeList = ibraryBookInfoDao.findBookInfoTree();
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return bookInfoTreeList;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 isHavaNoGuiHuanBook
	  * @param book_id
	  * @return 
	  * @see com.chinacreator.xtbg.caizhengting.ibrary.service.IbraryBookInfoService#isHavaNoGuiHuanBook(java.lang.String)
	 */
	public String isHavaNoGuiHuanBook(String book_id) {
		Connection conn = null;
		String num = "0";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			IbraryBookInfoDao ibraryBookInfoDao = new IbraryBookInfoDaoImpl();
			num = ibraryBookInfoDao.queryRegBookInfoByBookId(book_id);
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return num;
	}

	/**
	 * 
	  * <b>Summary: 根据申请表IDs删除申请表信息</b>
	  *     复写方法 deleteRegBookInfo
	  * @param t_regb_id
	  * @return 
	  * @see com.chinacreator.xtbg.caizhengting.ibrary.service.IbraryBookInfoService#deleteRegBookInfo(java.lang.String)
	 */
	public boolean deleteRegBookInfo(String t_regb_id) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			IbraryBookInfoDao ibraryBookInfoDao = new IbraryBookInfoDaoImpl();
		    flag = ibraryBookInfoDao.deleteRegBookInfo(t_regb_id, conn);
			conn.commit();
		} catch (Exception e) {
			flag = false;
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}

}
