package com.chinacreator.xtbg.pub.personwork.dao;

import java.util.List;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.personwork.entity.PGroupBean;
import com.chinacreator.xtbg.pub.personwork.entity.PriManageBean;

public interface PriManageDao {
	
	PagingBean queryGroup(PGroupBean pbGroupBean,String sortName, String sortOrder, long offset, int maxPagesize);
	/**
	 * @Description 根据条件查询流程信息
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findPriManageBeanList(PriManageBean prBean, String sortName, String sortOrder, long offset, int maxPagesize);
	
	/**
	 * 
		 * @Description  插入权限条目
		 * 
		 * @param prBean 实体
		 * @return  boolean
		 * 
	 */
	boolean insertPrivilege(PriManageBean prBean);
	
	/**
	 * 根据条件查询分组集合
	 * @param pbGroupBean
	 * @return
	 */
	public List<PGroupBean> queryGroup4List(PGroupBean pbGroupBean);
}
