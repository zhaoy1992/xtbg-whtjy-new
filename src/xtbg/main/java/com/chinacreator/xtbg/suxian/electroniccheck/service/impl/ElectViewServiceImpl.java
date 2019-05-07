package com.chinacreator.xtbg.suxian.electroniccheck.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.suxian.electroniccheck.dao.ElectResetDao;
import com.chinacreator.xtbg.suxian.electroniccheck.entity.ElectResetBeanXt;
import com.chinacreator.xtbg.suxian.electroniccheck.service.ElectViewServiceIfc;

public class ElectViewServiceImpl implements ElectViewServiceIfc {

	@Override
	public void saveset(ElectResetBeanXt electResetBean) throws Exception {
		ElectResetDao poeManagerDao = (ElectResetDao)DaoImplClassUtil.getDaoImplClass("electResetDaoImpls");
		Map<String, String> map =new HashMap<String, String>();
		map.put("orgid", electResetBean.getOrgid());
		List<Map<String, String>> listmap =poeManagerDao.getContentBean(map);
		String elect_id="";
		if(listmap.size()>0){
			elect_id= listmap.get(0).get("elect_id");
			electResetBean.setElect_id(elect_id);
			poeManagerDao.updateRecord(electResetBean);
		}else{
			elect_id=UUID.randomUUID().toString();
			electResetBean.setElect_id(elect_id);
			poeManagerDao.add(electResetBean);
		}
		
	}

	@Override
	public void del(String ids) throws Exception {
		ElectResetDao poeManagerDao = (ElectResetDao)DaoImplClassUtil.getDaoImplClass("electResetDaoImpls");
		poeManagerDao.deleteinfo(ids);
	}

}
