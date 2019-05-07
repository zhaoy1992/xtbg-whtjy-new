package com.chinacreator.xtbg.core.common.iweboffice.action;

import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.iweboffice.service.WordTemplateServiceIfc;
import com.chinacreator.xtbg.core.common.iweboffice.service.impl.WordTemplateServiceImpl;

public class TextInputAction {

	private static final Logger LOG = Logger.getLogger(TextInputAction.class);
	private String textinput_id;

	private HttpServletResponse response;

	public String getTextinput_id() {
		return textinput_id;
	}

	public void setTextinput_id(String textinput_id) {
		this.textinput_id = textinput_id;
	}
	
	public HttpServletResponse getResponse() {
		return response;
	}



	public void setResponse(HttpServletResponse response) {
		this.response = response;
	}
	
	/**
	 * 
	 * <b>Summary:批量修改档案 </b>
	 * updateListFiles()
	 */
	public void delTextInput() {
		boolean flag = false;
		try {
			WordTemplateServiceIfc wordTemplateServiceIfc = new WordTemplateServiceImpl();
			flag = wordTemplateServiceIfc.deleteWordParam(getTextinput_id());
			if(flag){
				response.getWriter().write("{\"flag\":\"true\",\"msg\":\"操作成功\"}");
			}else{
				response.getWriter().write("{\"flag\":\"false\",\"msg\":\"操作失败\"}");
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			try {
				response.getWriter().write("{\"flag\":\"false\",\"msg\":\"操作失败\"}");
			} catch (Exception ex) {
				LOG.error(ex.getMessage(), ex);
			}
		}
	}
	
	
}
