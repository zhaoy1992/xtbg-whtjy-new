package com.chinacreator.xtbg.pub.jqueryupload.upload.core;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

public interface ISwfUploadServlet {
	public void doBeforeUpload(HttpServletRequest request, HttpServletResponse response);
	public void doAfterUpload(MultipartRequest multi);
}
