package com.chinacreator.xtbg.core.common.filter;

import java.io.IOException;
import java.util.regex.Pattern;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/**
 *<p>Title:GZipFilter.java</p>
 *<p>Description:Gzip压缩过滤器</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2012-8-22
 */
public class GZipFilter implements Filter {
	
	private String regEx="*.doc|*.docx|*.xls|*.xlsx"; //不压缩的文档
	
	public void init(FilterConfig config) throws ServletException {
		regEx = config.getInitParameter("regEx");
	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		ServletOutputStream output = null;
		try {
			HttpServletRequest httpRequest = (HttpServletRequest) request;
			HttpServletResponse httpResponse = (HttpServletResponse) response;
			CachedResponseWrapper wrapper = new CachedResponseWrapper(httpResponse);
			String agent = httpRequest.getHeader("user-agent");
			String[] st = agent.split(";");
			
			if (st.length < 2) { //chrome
				chain.doFilter(request, response);
			} else {
			
				String userbroString = st[1];
				
				if(agent.indexOf("MSIE")>0 && Double.parseDouble(userbroString.replace("MSIE", "").trim())<7){//ie7 以下版本ie 浏览器
					chain.doFilter(request, response);
				}else{
					if(Pattern.compile(regEx,Pattern.CASE_INSENSITIVE).matcher(httpRequest.getRequestURI()).find()){//不进行压缩的文档
						chain.doFilter(request, response);
					}else{
						// 写入wrapper:
						chain.doFilter(request, wrapper);
						// 对响应进行处理，这里是进行GZip压缩:
						byte[] data = GZipUtil.gzip(wrapper.getResponseData());
						httpResponse.setHeader("Content-Encoding", "gzip");
						httpResponse.setContentLength(data.length);
						output = response.getOutputStream();
						output.write(data);
						output.flush();
						output.close();
					}
				}
			}
		} catch (Exception e) {
			chain.doFilter(request, response);
		} finally {
			
		}
	}

	public void destroy() {
		
	}
}
