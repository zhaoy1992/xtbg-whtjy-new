package com.chinacreator.xtbg.core.archive.service.impl;

import java.io.File;
import java.sql.Connection;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.archive.dao.BudgetDetailDao;
import com.chinacreator.xtbg.core.archive.dao.BudgetDetailInfoDao;
import com.chinacreator.xtbg.core.archive.dao.impl.BudgetDetailDaoImpl;
import com.chinacreator.xtbg.core.archive.dao.impl.BudgetDetailInfoDaoImpl;
import com.chinacreator.xtbg.core.archive.entity.BudgetDetailBean;
import com.chinacreator.xtbg.core.archive.service.BudgetDetailService;
import com.chinacreator.xtbg.core.common.cache.OASystemCache;
import com.chinacreator.xtbg.core.common.util.DaoUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.ResultCode;
import com.chinacreator.xtbg.core.common.util.ResultMap;

/**
 * 
 *<p>Title:BudgetDetailServiceImpl.java</p>
 *<p>Description:指标文拆分-拆分详细信息服务层接口实现</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *Nov 12, 2013
 */
public class BudgetDetailServiceImpl implements BudgetDetailService {
	private static final Logger LOG = Logger.getLogger(BudgetDetailServiceImpl.class);
	@Override
	public ResultMap<ResultCode, BudgetDetailBean> save(BudgetDetailBean bean) {
		ResultMap<ResultCode, BudgetDetailBean> result = new ResultMap<ResultCode, BudgetDetailBean>();
		result.setCode(ResultCode.FAIL);
		if(bean != null){
			if(bean.getBudget_file_id() == null || "".equals(bean.getBudget_file_id())){
				result.setCode(ResultCode.MISS_ID);
			} else if(bean.getUnit_id() == null || "".equals(bean.getUnit_id())){
				result.setCode(ResultCode.MISS_UNIT_ID);
			} else {
				BudgetDetailDao dao = new BudgetDetailDaoImpl();
				Connection con = null;
				try {
					con = DbManager.getInstance().getConnection();
					BudgetDetailBean queryBean = dao.getByFileIdAndUnitId(bean,con);
					if(queryBean != null ){
						bean.setDetail_id(queryBean.getDetail_id());
						dao.update(bean, con);
						result.setCode(ResultCode.OK);
						result.setResult(bean);
					} else {
						if(bean.getDetail_id() == null || "".equals(bean.getDetail_id())){
							bean.setDetail_id(DaoUtil.getUUID());
						}
						dao.insert(bean, con);
						result.setCode(ResultCode.OK);
						result.setResult(bean);
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
	@Override
	public ResultMap<ResultCode, BudgetDetailBean> save(String detail_id,
			String budget_file_id, String unit_id, String shown_name,
			String file_path, String file_size, String remark) {
		BudgetDetailBean bean = new BudgetDetailBean();
		bean.setBudget_file_id(budget_file_id);
		bean.setDetail_id(detail_id);
		bean.setFile_path(file_path);
		bean.setFile_size(file_size);
		bean.setRemark(remark);
		bean.setShown_name(shown_name);
		bean.setUnit_id(unit_id);
		return save(bean);
	}
	@Override
	public ResultMap<ResultCode, BudgetDetailBean> deleteByIds(String ids) {
		ResultMap<ResultCode, BudgetDetailBean> result = new ResultMap<ResultCode, BudgetDetailBean>();
		result.setCode(ResultCode.FAIL);
		if(ids == null || "".equals(ids)){
			result.setCode(ResultCode.MISS_ID);
		} else {
			String[] id = ids.split(",");
			for(String s : id ){
				deleteById(s);
			}
			result.setCode(ResultCode.OK);
		}
		return result;
	}
	@Override
	public ResultMap<ResultCode, BudgetDetailBean> deleteById(String id) {
		ResultMap<ResultCode, BudgetDetailBean> result = new ResultMap<ResultCode, BudgetDetailBean>();
		result.setCode(ResultCode.FAIL);
		if(id == null || "".equals(id)){
			result.setCode(ResultCode.MISS_ID);
		} else {
			BudgetDetailDao dao = new BudgetDetailDaoImpl();
			Connection con = null;
			try {
				con = DbManager.getInstance().getTransactionConnection();
				BudgetDetailBean bean = new BudgetDetailBean();
				bean.setDetail_id(id);
				bean = dao.getByDetailId(bean, con);
				if(bean != null ){
					BudgetDetailInfoDao detailInfoDao = new BudgetDetailInfoDaoImpl();
					detailInfoDao.deleteByDetailId(id, con);
					dao.deleteByDetailId(id, con);
					String file_url = OASystemCache.getContextProperty("oa_split_file_save_path");
					if(file_url != null && !"".equals(file_url)){
						String url = file_url + bean.getFile_path();
						File file = new File(url);
						file.delete();
					}
				}
				DbManager.closeTransactionConnection(con, true);
			} catch (Exception e) {
				LOG.error(e.getMessage(),e);
				DbManager.closeTransactionConnection(con, false);
			}
		}
		return result;
	}
}
