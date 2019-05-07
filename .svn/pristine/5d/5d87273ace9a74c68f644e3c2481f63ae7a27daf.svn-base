package com.chinacreator.xtbg.core.archive.service.impl;

import java.sql.Connection;
import java.util.List;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.archive.dao.SplitUnitDao;
import com.chinacreator.xtbg.core.archive.dao.impl.SplitUnitDaoImpl;
import com.chinacreator.xtbg.core.archive.entity.SplitUnitBean;
import com.chinacreator.xtbg.core.archive.service.SplitUnitService;
import com.chinacreator.xtbg.core.common.util.DaoUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.ResultCode;
import com.chinacreator.xtbg.core.common.util.ResultMap;

/**
 * 
 *<p>Title:SplitUnitServiceImpl.java</p>
 *<p>Description:拆分单位服务层实现</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *Sep 16, 2013
 */
public class SplitUnitServiceImpl implements SplitUnitService {
	private static final Logger LOG = Logger.getLogger(SplitLogServiceImpl.class);
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getById
	  * @param unit_id
	  * @return 
	  * @see com.chinacreator.xtbg.caizhengting.split.service.SplitUnitService#getById(java.lang.String)
	 */
	@Override
	public ResultMap<ResultCode, SplitUnitBean> getById(String unit_id) {
		ResultMap<ResultCode, SplitUnitBean> result = new ResultMap<ResultCode, SplitUnitBean> ();
		result.setCode(ResultCode.FAIL);
		if(unit_id == null || "".equals(unit_id)){
			result.setCode(ResultCode.MISS_ID);
		} else {
			SplitUnitDao dao = new SplitUnitDaoImpl();
			Connection con = null;
			try {
				SplitUnitBean bean = new SplitUnitBean();
				bean.setUnit_id(unit_id);
				con = DbManager.getInstance().getConnection();
				bean = dao.getById(bean, con);
				if(bean != null){
					result.setCode(ResultCode.OK);
					result.setResult(bean);
				} else {
					result.setCode(ResultCode.UNEXIST);
				}
			} catch (Exception e) {
				LOG.error(e.getMessage(),e);
			} finally {
				DbManager.closeConnection(con);
			}
		}
		return result;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 insert
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.caizhengting.split.service.SplitUnitService#insert(com.chinacreator.xtbg.caizhengting.split.entity.SplitUnitBean)
	 */
	@Override
	public ResultMap<ResultCode, SplitUnitBean> insert(SplitUnitBean bean) {
		ResultMap<ResultCode, SplitUnitBean> result = new ResultMap<ResultCode, SplitUnitBean>();
		result.setCode(ResultCode.FAIL);
		if(bean != null ){
			if(bean.getUnit_name() == null || "".equals(bean.getUnit_name())){
				result.setCode(ResultCode.MISS_SPLIT_FILENAME);
			} else {
				SplitUnitDao dao = new SplitUnitDaoImpl();
				Connection con = null;
				SplitUnitBean unitNameBean = new SplitUnitBean(); 
				try {
					con = DbManager.getInstance().getConnection();
					bean.setUnit_id(DaoUtil.getUUID());
					unitNameBean = dao.getByUnitName(bean, con);
					if(unitNameBean == null){
						dao.insert(bean, con);
					}
					result.setCode(ResultCode.OK);
				} catch (Exception e) {
					LOG.error(e.getMessage(),e);
				} finally {
					DbManager.closeConnection(con);
				}
			}
		}
		return result;
	}

	@Override
	public ResultMap<ResultCode, SplitUnitBean> update(SplitUnitBean bean) {
		ResultMap<ResultCode, SplitUnitBean> result = new ResultMap<ResultCode, SplitUnitBean>();
		result.setCode(ResultCode.FAIL);
		if(bean != null ){
			if(bean.getUnit_id() == null || "".equals(bean.getUnit_id())){
				result.setCode(ResultCode.MISS_ID);
			} else if(bean.getUnit_name() == null || "".equals(bean.getUnit_name())){
				result.setCode(ResultCode.MISS_SPLIT_FILENAME);
			} else {
				SplitUnitDao dao = new SplitUnitDaoImpl();
				Connection con = null;
				try {
					con = DbManager.getInstance().getConnection();
					dao.update(bean, con);
					result.setCode(ResultCode.OK);
				} catch (Exception e) {
					LOG.error(e.getMessage(),e);
				} finally {
					DbManager.closeConnection(con);
				}
			}
		}
		return result;
	}

	@Override
	public ResultMap<ResultCode, List<SplitUnitBean>> list(SplitUnitBean bean) {
		ResultMap<ResultCode, List<SplitUnitBean>> result = new ResultMap<ResultCode, List<SplitUnitBean>>();
		result.setCode(ResultCode.FAIL);
		if(bean != null ){
			SplitUnitDao dao = new SplitUnitDaoImpl();
			Connection con = null;
			try {
				con = DbManager.getInstance().getConnection();
				List<SplitUnitBean> list = dao.list(bean, con);
				if(list != null && list.size() > 0){
					result.setCode(ResultCode.OK);					
					result.setResult(list);
				} else {
					result.setCode(ResultCode.UNEXIST);
				}
			} catch (Exception e) {
				LOG.error(e.getMessage(),e);
			} finally {
				DbManager.closeConnection(con);
			}
		}
		return result;
	}

	@Override
	public ResultMap<ResultCode, SplitUnitBean> deleteById(String unit_ids) {
		ResultMap<ResultCode, SplitUnitBean> result = new ResultMap<ResultCode, SplitUnitBean>();
		result.setCode(ResultCode.FAIL);
		if(unit_ids == null || "".equals(unit_ids)){
			result.setCode(ResultCode.MISS_ID);
		} else {
			SplitUnitDao dao = new SplitUnitDaoImpl();
			Connection con = null;
			try {
				con = DbManager.getInstance().getConnection();
				dao.deleteById(unit_ids, con);
				result.setCode(ResultCode.OK);
			} catch (Exception e) {
				LOG.error(e.getMessage(),e);
			} finally {
				DbManager.closeConnection(con);
			}
		}
		return result;
	}

	@Override
	public ResultMap<ResultCode, SplitUnitBean> getByUnitName(String unit_name) {
		ResultMap<ResultCode, SplitUnitBean> result = new ResultMap<ResultCode, SplitUnitBean> ();
		result.setCode(ResultCode.FAIL);
		if(unit_name == null || "".equals(unit_name)){
			result.setCode(ResultCode.MISS_ID);
		} else {
			SplitUnitDao dao = new SplitUnitDaoImpl();
			Connection con = null;
			try {
				SplitUnitBean bean = new SplitUnitBean();
				bean.setUnit_name(unit_name);
				con = DbManager.getInstance().getConnection();
				bean = dao.getByUnitName(bean, con);
				if(bean != null){
					result.setCode(ResultCode.OK);
					result.setResult(bean);
				} else {
					result.setCode(ResultCode.UNEXIST);
				}
			} catch (Exception e) {
				LOG.error(e.getMessage(),e);
			} finally {
				DbManager.closeConnection(con);
			}
		}
		return result;
	}

	@Override
	public ResultMap<ResultCode, SplitUnitBean> getUnitByGwcsOrgId(SplitUnitBean bean) {
		ResultMap<ResultCode, SplitUnitBean> result = new ResultMap<ResultCode, SplitUnitBean> ();
		result.setCode(ResultCode.FAIL);
		if(bean != null){
			if(bean.getGwcs_org_id() == null || "".equals(bean.getGwcs_org_id())){
				result.setCode(ResultCode.MISS_ID);
			} else {
				SplitUnitDao dao = new SplitUnitDaoImpl();
				Connection con = null;
				try {
					con = DbManager.getInstance().getConnection();
					bean = dao.getUnitByGwcsOrgId(bean, con);
					if(bean != null){
						result.setCode(ResultCode.OK);
						result.setResult(bean);
					} else {
						result.setCode(ResultCode.UNEXIST);
					}
				} catch (Exception e) {
					LOG.error(e.getMessage(),e);
				} finally {
					DbManager.closeConnection(con);
				}
			}
		}
		return result;
	}
}
