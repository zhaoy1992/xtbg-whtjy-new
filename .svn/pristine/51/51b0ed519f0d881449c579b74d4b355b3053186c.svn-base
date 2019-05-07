package com.chinacreator.xtbg.core.archive.service.impl;

import java.sql.Connection;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.archive.dao.BudgetAttachDao;
import com.chinacreator.xtbg.core.archive.dao.impl.BudgetAttachDaoImpl;
import com.chinacreator.xtbg.core.archive.entity.BudgetAttachBean;
import com.chinacreator.xtbg.core.archive.service.BudgetAttachService;
import com.chinacreator.xtbg.core.common.util.DaoUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.ResultCode;
import com.chinacreator.xtbg.core.common.util.ResultMap;

/**
 * 
 *<p>Title:BudgetAttachServiceImpl.java</p>
 *<p>Description:指标文拆分-附件表服务层接口实现</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *Nov 12, 2013
 */
public class BudgetAttachServiceImpl implements BudgetAttachService {
	private static final Logger LOG = Logger.getLogger(BudgetAttachServiceImpl.class);
	@Override
	public ResultMap<ResultCode, BudgetAttachBean> save(String id,String file_name, String shown_name,String file_path,String file_size) {
		ResultMap<ResultCode, BudgetAttachBean> result = new ResultMap<ResultCode, BudgetAttachBean>();
		result.setCode(ResultCode.FAIL);
		if(id == null || "".equals(id)){
			result.setCode(ResultCode.MISS_ID);
		} else if(shown_name == null || "".equals(shown_name)){
			result.setCode(ResultCode.MISS_SHOWN_NAME);
		} else if(file_path == null || "".equals(file_path)){
			result.setCode(ResultCode.MISS_FILE_PATH);
		} else {
			BudgetAttachDao dao = new BudgetAttachDaoImpl();
			Connection con = null;
			try {
				con = DbManager.getInstance().getConnection();
				BudgetAttachBean bean = new BudgetAttachBean();
				bean.setId(id);
				bean.setShown_name(shown_name);
				bean = dao.getByIdAndShownName(bean,con);
				if(bean != null ){
					bean.setFile_path(file_path);
					bean.setFile_size(file_size);
					dao.update(bean, con);
					result.setCode(ResultCode.OK);
					result.setResult(bean);
				} else {
					bean = new BudgetAttachBean();
					//如果未传主键，则自动生成
					if(bean.getFile_name() == null || "".equals(bean.getFile_name()) ){
						bean.setFile_name(DaoUtil.getUUID());
					}
					bean.setFile_path(file_path);
					bean.setFile_size(file_size);
					bean.setId(id);
					bean.setShown_name(shown_name);
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
		return result;
	}
}
