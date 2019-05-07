package com.chinacreator.xtbg.pub.directory.service.impl;

import java.sql.Connection;
import java.util.List;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.pub.common.ResultCode;
import com.chinacreator.xtbg.pub.common.ResultMap;
import com.chinacreator.xtbg.pub.directory.dao.UserDataDao;
import com.chinacreator.xtbg.pub.directory.dao.imploracle.UserDataDaoImpl;
import com.chinacreator.xtbg.pub.directory.entity.UserData;
import com.chinacreator.xtbg.pub.directory.service.UserDataServiceIfc;
import com.chinacreator.xtbg.pub.util.DbconnManager;

/**
 * 
 *<p>Title:UserDataServiceImpl.java</p>
 *<p>Description:用户简历数据服务层</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *Jul 25, 2013
 */
public class UserDataServiceImpl implements UserDataServiceIfc {
	public static final Logger logger = Logger.getLogger(UserDataServiceImpl.class);
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 list
	  * @param user_id
	  * @return 
	  * @see com.chinacreator.xtbg.pub.directory.service.UserDataServiceIfc#list(java.lang.String)
	 */
	@Override
	public ResultMap<ResultCode, List<UserData>> list(String user_id) {
		ResultMap<ResultCode, List<UserData>> result = new ResultMap<ResultCode, List<UserData>>();
		result.setCode(ResultCode.FAIL);
		if(user_id == null || "".equals(user_id)){
			result.setCode(ResultCode.MISS_ID);
		} else {
			Connection con = null;
			try {
				con = DbconnManager.getInstance().getConnection();
				UserData bean = new UserData();
				bean.setUser_id(user_id);
				
				UserDataDao dao = new UserDataDaoImpl();
				
				List<UserData> list = dao.list(bean, con);
				if(list != null){
					result.setResult(list);
				}
				result.setCode(ResultCode.OK);
			} catch (Exception e) {
				logger.error(e.getMessage(),e);
			} finally {
				DbconnManager.closeConnection(con);
			}
		}
		return result;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 delete
	  * @param id
	  * @return 
	  * @see com.chinacreator.xtbg.pub.directory.service.UserDataServiceIfc#delete(java.lang.String)
	 */
	@Override
	public ResultMap<ResultCode, UserData> delete(String id) {
		ResultMap<ResultCode, UserData> result = new ResultMap<ResultCode, UserData>();
		result.setCode(ResultCode.FAIL);
		if(id == null || "".equals(id)){
			result.setCode(ResultCode.MISS_ID);
		} else {
			Connection con = null;
			try {
				con = DbconnManager.getInstance().getConnection();
				UserData bean = new UserData();
				bean.setId(id);
				
				UserDataDao dao = new UserDataDaoImpl();
				
				dao.delete(bean, con);
				result.setCode(ResultCode.OK);
			} catch (Exception e) {
				logger.error(e.getMessage(),e);
			} finally {
				DbconnManager.closeConnection(con);
			}
		}
		return result;
	}

}
