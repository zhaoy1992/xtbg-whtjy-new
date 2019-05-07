package com.chinacreator.xtbg.core.common.commonlist;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
/**
 * 
 *<p>Title:PublicAjaxAction.java</p>
 *<p>Description:action处理类的公用父类进行一些公共操作的处理</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-8-2
 */
public class PublicAjaxAction {
	private static final Logger LOG = Logger.getLogger(PublicAjaxAction.class);
	private HttpServletRequest request;
	private HttpServletResponse response;
	private PageInfoBean page;// 分页对象

	public HttpServletRequest getRequest() {
		return request;
	}

	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	public HttpServletResponse getResponse() {
		return response;
	}

	public void setResponse(HttpServletResponse response) {
		this.response = response;
	}

	public PageInfoBean getPage() {
		return page;
	}

	public void setPage(PageInfoBean page) {
		this.page = page;
	}

	/**
	 * 
	 *<b>Summary: 公用的写方法</b> write()
	 * 
	 * @param str
	 */
	public void write(String str) {
		PrintWriter write = null;
		try {
			write = response.getWriter();
			write.write(str);	
		} catch (Exception e) {
			LOG.error("公共action类调用writer时出现异常" + e.getMessage(), e);
		}finally{
			if(null != write){				
				write.flush();
				write.close();
			}
		}
	}
	/**
	 * 
	*<b>Summary: 公用的写方法</b>
	* write()
	* @param pg
	 */
	public void write(PagingBean pg){
		try {
			JSONObject json = PageUitl.getJSONObject(String.valueOf(this.page
					.getPage()), Integer.valueOf(this.page.getRows()), pg);
			write(json.toString());
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
	}
	
	/**
	 * 
	*<b>Summary: 公用的写方法</b>
	* write()
	* @param json
	 */
	public void write(Object json){
		try {
			write(JSONObject.toJSONString(json));
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
	}
	
	/**
	 * 
	 *<b>Summary:将传入的对象转换成json，然后response给客户端 </b> write4Json()
	 * 
	 * @param obj
	 */
	public void write4Json(Object json) {
		try {
			write(JSONObject.toJSONString(json));
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
	}
	/**
	 * 
	 *<b>Summary: grid数据专用</b> write4PagingBeanJson()
	 * 
	 * @param pg
	 */
	public void write4PagingBeanJson(PagingBean pg) {
		try {
			JSONObject json = PageUitl.getJSONObject(String.valueOf(this.page
					.getPage()), Integer.valueOf(this.page.getRows()), pg);
			write(json.toString());
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
	}

	
	
	
}
