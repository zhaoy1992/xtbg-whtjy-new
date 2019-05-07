package com.chinacreator.xtbg.core.archive.service.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.archive.common.GwcsAddressXmlReader;
import com.chinacreator.xtbg.core.archive.dao.GWCSUnitDao;
import com.chinacreator.xtbg.core.archive.dao.impl.GWCSUnitDaoImpl;
import com.chinacreator.xtbg.core.archive.entity.GWCSUnitBean;
import com.chinacreator.xtbg.core.archive.service.GWCSUnitService;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.ResultCode;
import com.chinacreator.xtbg.core.common.util.ResultMap;
import com.chinacreator.xtbg.core.common.util.SqlUtil;
import com.chinacreator.xtbg.core.subsystemmanage.dao.SubSystemOrgConfigDao;
import com.chinacreator.xtbg.core.subsystemmanage.dao.impl.GwcsOrgConfigDaoImpl;
import com.chinacreator.xtbg.core.subsystemmanage.entity.OaGwcsConfigBean;

/**
 * 
 *<p>Title:SplitLogServiceImpl.java</p>
 *<p>Description:公文传输的地址簿服务层接口实现</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *Sep 16, 2013
 */
public class GWCSUnitServiceImpl implements GWCSUnitService {
	private static final Logger LOG = Logger.getLogger(GWCSUnitServiceImpl.class);

	@Override
	public ResultMap<ResultCode, List<GWCSUnitBean>> list(String parent_id) {
		ResultMap<ResultCode, List<GWCSUnitBean>> result = new ResultMap<ResultCode, List<GWCSUnitBean>>();
		result.setCode(ResultCode.FAIL);
		Connection con = null;
		GWCSUnitBean bean = new GWCSUnitBean();
		try {
			con = DbManager.getInstance().getConnection();
			GWCSUnitDao dao = new GWCSUnitDaoImpl();
			bean.setParent_id(parent_id);
			List<GWCSUnitBean> list = dao.list(bean, con);
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
		return result;
	}

	@Override
	public ResultMap<ResultCode, List<GWCSUnitBean>> listByConfig(String type,String send_org_config) {
		ResultMap<ResultCode, List<GWCSUnitBean>> result = new ResultMap<ResultCode, List<GWCSUnitBean>>();
		result.setCode(ResultCode.FAIL);
		Connection con = null;
		try {
			//根据配置ID，获取该配置的发文单位信息。
			SubSystemOrgConfigDao subSystemOrgConfigDao = (GwcsOrgConfigDaoImpl)LoadSpringContext.getApplicationContext().getBean("gwcsOrgConfigDaoImpl");
			OaGwcsConfigBean oaGwcsConfigBean = subSystemOrgConfigDao.getGwcsConfigByID(send_org_config);
			String gwcs_address_path = "\\coreconfig\\gwcs-address_config.xml";//默认地址
			if(oaGwcsConfigBean!=null){
				gwcs_address_path = oaGwcsConfigBean.getGwcs_address_path();
			}else{
				throw new Exception("无法根据配置ID读取该发文单位的配置，请检查配置信息");
			}
			
			GwcsAddressXmlReader xmlList = new GwcsAddressXmlReader(gwcs_address_path);
			List<GWCSUnitBean> list = xmlList.getAddress();
			if("0".equals(type)){
				if(list != null && list.size() > 0){
					result.setCode(ResultCode.OK);	
					result.setResult(list);
				} else {
					result.setCode(ResultCode.UNEXIST);
				}
			} else {
				List<GWCSUnitBean> childList = new ArrayList<GWCSUnitBean>();
				con = DbManager.getInstance().getConnection();
				for(GWCSUnitBean b : list){
					String sql = b.getConfig_child_sql();
					if(sql != null && !"".equals(sql)){
						SqlUtil<GWCSUnitBean> sqlUtil = new SqlUtil<GWCSUnitBean>();
						List<GWCSUnitBean> _list = sqlUtil.executeForList(sql, b, con);
						childList.addAll(_list);
					}
				}
				if(childList.size() > 0){
					result.setCode(ResultCode.OK);
					result.setResult(childList);
				} else {
					result.setCode(ResultCode.UNEXIST);
				}
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
		} finally {
			DbManager.closeConnection(con);
		}
		return result;
	}
}