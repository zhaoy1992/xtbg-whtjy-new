package com.chinacreator.xtbg.waitDoWork.dao;

import java.sql.SQLException;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.waitDoWork.entity.ToDoWorkListBean;
import com.chinacreator.xtbg.waitDoWork.entity.ToDoWorkSearchBean;

public interface HomeBusinessDao {
	/**
	 * @Description 查询待办列表信息
	 * @param operType
	 * @return PagingBean
	 * @throws SQLException
	 */
	public PagingBean getToDoWorkList(ToDoWorkSearchBean toDoWorkSearchBean,
			ToDoWorkListBean tdwlBean,String sortName, String sortOrder, long offset, int maxPagesize) throws SQLException;
	
	/**
	 * 获得待办列表的统计数字
	 * @param toDoWorkSearchBean
	 * @return
	 * @throws SQLException
	 */
	public int getToDoWorkListTotal(ToDoWorkSearchBean toDoWorkSearchBean,ToDoWorkListBean tdwlBean) throws SQLException;
	
}
