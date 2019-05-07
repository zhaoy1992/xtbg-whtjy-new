package com.chinacreator.xtbg.core.common.commonlist;


/**
 * 
 *<p>Title:PageInfoBean.java</p>
 *<p>Description:分页信息类</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-8-2
 */
public class PageInfoBean {	
	private String page;//当前页数
	private String rows;//每页显示的记录条数
	private String sortName;//排序的字段
	private String sortOrder;//排序序列（升序、降序等）
	/**
	 * 
	*<b>Summary: 将页数转换为长整型数据返回，转换失败则返回默认值1L</b>
	* getPage()
	* @return
	 */
	public Long getPage() {
		try{			
			Long newPage = Long.parseLong(this.page);
			return newPage;
		}catch(Exception e){
			return 1L;
		}		
	}
	/**
	 * 
	*<b>Summary:将每页显示的行数转换为长整型数据，失败则返回默认值10 </b>
	* getRows()
	* @return
	 */
	public Integer getRows() {
		try{
			Integer newRows = Integer.parseInt(this.rows);
			return newRows;
		}catch(Exception e){
			return 10;
		}	
	}	
	/**
	 * 
	*<b>Summary: 获得开始查询的记录行</b>
	* getOffset()
	* @return
	 */
	public Long getOffset(){
		long offset = 1;
    	if(getPage()==1L) {
    		offset = 0;
    	} else {
    		offset = (getPage() - 1) * getRows(); //当前页*每页记录数 
    	}
		return offset;
	}
	public void setPage(String page) {
		this.page = page;
	}
	
	public void setRows(String rows) {
		this.rows = rows;
	}
	public String getSortName() {
		return sortName;
	}
	public void setSortName(String sortName) {
		this.sortName = sortName;
	}
	public String getSortOrder() {
		return sortOrder;
	}
	public void setSortOrder(String sortOrder) {
		this.sortOrder = sortOrder;
	}	
}
