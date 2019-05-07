package com.chinacreator.xtbg.core.kbm.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 *<p>Title:PendingBean.java</p>
 *<p>Description:首页总统计数据配置信息</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-6-25
 */
public class PendingBean implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String functionSql;//获取统计数据的查询语句
	
	private int total;//待办总数
	
	private List<PendingItemBean> list = new ArrayList<PendingItemBean>();//各小项统计配置信息集合

	public String getFunctionSql() {
		return functionSql;
	}

	public void setFunctionSql(String functionSql) {
		this.functionSql = functionSql;
	}

	public List<PendingItemBean> getList() {
		return list;
	}

	public void setPendingItemBean(PendingItemBean bean) {
		list.add(bean);
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}
}
