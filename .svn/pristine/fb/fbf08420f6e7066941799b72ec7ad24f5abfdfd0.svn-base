package com.chinacreator.xtbg.suxian.electroniccheck.dao;

import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.suxian.electroniccheck.entity.ElectResetBeanXt;




/**
 *<p>Title:BriefsTypeDao.java</p>
 *<p>Description:密集程度信息dao层接口</p> 
 *<p>Company:湖南科创</p>
 *@author 付程
 *@version 1.0
 *2012-2-23
 */
public interface ElectResetDao {
	//添加考勤设置信息
	public void add(ElectResetBeanXt electResetInfoBean) throws Exception;
	//更新考勤设置信息
	public void updateRecord(ElectResetBeanXt electResetInfoBean) throws Exception;
	//查询某个机构是否已经有记录
	public List<Map<String, String>> getContentBean(Map<String, String> map) throws Exception;
	//查询list数据
	public PagingBean querylist(Map<String, String> map,String sortName, String sortOrder, long offset, int maxPagesize)throws Exception;
	//查询详细信息
	public Map<String, String> querydetail(Map<String, String> map)throws Exception;
	//删除
	public void deleteinfo(String ids)throws Exception;
}

