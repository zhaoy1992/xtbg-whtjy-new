package com.chinacreator.xtbg.pub.common;

import java.util.List;

/**
 *<p>Title:</p>
 *<p>Description:分页实体BEAN</p>
 *<p>Copyright:Copyright (c) 2011</p>
 *<p>Company:湖南科创</p>
 *@author yiping.huang
 *@version 1.0
 *@date 2012-1-4
 */
public class PagingBean {
	
	private Long records; //总记录数
	
    
	private List<? extends Object> list;  //BEAN对象 List
	
	public Long getRecords() {
		return records;
	}

	public void setRecords(Long records) {
		this.records = records;
	}

	public List<? extends Object> getList() {
		return list;
	}

	public void setList(List<? extends Object> list) {
		this.list = list;
	}

}
