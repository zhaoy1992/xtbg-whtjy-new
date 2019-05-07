package com.chinacreator.xtbg.pub.util;


import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.pub.common.PagingBean;

/**
 *<p>Title:PageUitl.java</p>
 *<p>Description:翻页工具类</p>
 *<p>Copyright:Copyright (c) 2011</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2012-1-4
 */
public class PageUitl {

	/**
	 * @Description  得到当前从那一条数据开始查询
	 * @param page 当前第几页
	 * @param maxPageSize 第页多少条
	 * @return  
	 * @exception Exception
	 */
	public static long getCurPage(String page, int maxPageSize) {
		long offset = 1;
    	if(page.equals("1")) {
    		offset = 0;
    	} else {
    		offset = (Long.parseLong(page) - 1) * maxPageSize; //取得当前页数 
    	}
		return offset;
	}
	
	/**
	 * @Description  获得显示的json对象
	 * @param page 当前第几页
	 * @param maxPageSize 第页多少条
	 * @param PagingBean 查询出的数据对象
	 * @return  
	 * @exception Exception
	 */
	/*public static JSONObject getJSONObject(String page, int maxPageSize, PagingBean pb) {
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("page", page); // 当前页
		if(null == pb){
			jsonObj.put("total", 1); // 总页数
			jsonObj.put("records", 0); // 总记录数
			jsonObj.put("rows", "");  //返回的查询数据
		}else{
			if((pb.getRecords() + 9) / maxPageSize == 0) {
				jsonObj.put("total", 1); // 总页数
			} else {
				jsonObj.put("total", (pb.getRecords() + 9) / maxPageSize); // 总页数	
			}
			jsonObj.put("records", pb.getRecords()); // 总记录数
			jsonObj.put("rows", pb.getList());  //返回的查询数据
		}
		
		return jsonObj;
		
	}
	*/
	public static JSONObject getJSONObject(String page, int maxPageSize,
			PagingBean pb) {
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("page", page); // 当前页
		if (pb == null || pb.getRecords() == null || pb.getList() == null) {
			jsonObj.put("total", 1); // 总页数
			jsonObj.put("records", 0); // 总记录数
			jsonObj.put("rows", ""); // 返回的查询数据
		} else {
			long records = pb.getRecords();
			if (records <= maxPageSize) {
				jsonObj.put("total", 1);
			} else {
				long total = ((records % maxPageSize == 0) ? (records / maxPageSize) : (records / maxPageSize + 1));
				jsonObj.put("total", total);
			}

			jsonObj.put("records", records); // 总记录数
			jsonObj.put("rows", pb.getList()); // 返回的查询数据

		}

		return jsonObj;

	}

	
	
	/**
	 * @Description  获得不分页显示的json对象
	 * @param page 当前第几页
	 * @param maxPageSize 第页多少条
	 * @param PagingBean 查询出的数据对象
	 * @return  
	 * @exception Exception
	 */
	public static JSONObject getJSONObject(PagingBean pb) {
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("records", pb.getRecords()); // 总记录数
		jsonObj.put("rows", pb.getList());  //返回的查询数据
		return jsonObj;
		
	}
}
