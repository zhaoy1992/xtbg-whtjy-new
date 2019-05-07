package com.frameworkset.common.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CharsetEncodingFilter implements Filter {
  private FilterConfig config;
  private String RequestEncoding;
  private String ResponseEncoding;
  private String mode;

  public CharsetEncodingFilter() {
    this.config = null;
    this.RequestEncoding = null;
    this.ResponseEncoding = null;
    this.mode = "0"; 
  }

  public void init(FilterConfig arg0) throws ServletException {
    this.config = arg0;
    this.RequestEncoding = this.config.getInitParameter("RequestEncoding");
    this.ResponseEncoding = this.config.getInitParameter("ResponseEncoding");
    this.mode = this.config.getInitParameter("mode");
    if (this.mode == null) {
      this.mode = "0";
    }
  }

  public void doFilter(ServletRequest req, ServletResponse res, FilterChain fc) throws IOException, ServletException {
    if (this.config == null) {
      return;
    }

    HttpServletRequest request = (HttpServletRequest)req;

    String filterEnabled = request.getParameter("filterEnabled");

    HttpServletResponse response = (HttpServletResponse)res;
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", -1L);
    response.setDateHeader("max-age", 0L);
    response.setHeader("X-UA-Compatible","IE=EmulateIE8");

    if ((filterEnabled != null) && (!(filterEnabled.trim().equalsIgnoreCase("true")))) {
      fc.doFilter(request, response);
      return;
    }
    CharacterEncodingHttpServletRequestWrapper mrequestw;
    CharacterEncodingHttpServletResponseWrapper wresponsew;
    if (this.mode.equals("0")) {
      String requestUri = request.getRequestURI();
      if(requestUri.indexOf("/ccapp/oa") > -1 && requestUri.endsWith(".jsp")) {
    	  this.RequestEncoding = "utf-8";
    	  this.ResponseEncoding = "utf-8";
	  }else if(requestUri.indexOf("/ccapp/xtbg/tjy/officesupplies/jsp") > -1 && requestUri.endsWith(".jsp")) {
    	  this.RequestEncoding = "utf-8";
    	  this.ResponseEncoding = "utf-8";
	  }else if(requestUri.indexOf("/ccapp/xtbg/tjy/canteenitemssupplies/jsp") > -1 && requestUri.endsWith(".jsp")) {
    	  this.RequestEncoding = "utf-8";
    	  this.ResponseEncoding = "utf-8";
	  }else if(requestUri.indexOf("/ccapp/xtbg/tjy/detectionsupplies/jsp") > -1 && requestUri.endsWith(".jsp")) {
    	  this.RequestEncoding = "utf-8";
    	  this.ResponseEncoding = "utf-8";
	  }else {
		  this.RequestEncoding = "gbk";
    	  this.ResponseEncoding = "gbk"; 
	  }
      mrequestw = new CharacterEncodingHttpServletRequestWrapper(request, this.RequestEncoding);
      wresponsew = new CharacterEncodingHttpServletResponseWrapper(response, this.ResponseEncoding);
      fc.doFilter(mrequestw, wresponsew);
    } else if (this.mode.equals("1")) {
      request.setCharacterEncoding(this.RequestEncoding);
      fc.doFilter(request, response);
    } else {
      mrequestw = new CharacterEncodingHttpServletRequestWrapper(request, this.RequestEncoding);
      wresponsew = new CharacterEncodingHttpServletResponseWrapper(response, this.ResponseEncoding);
      fc.doFilter(mrequestw, wresponsew);
    }
  }

  public void destroy(){
  }
}