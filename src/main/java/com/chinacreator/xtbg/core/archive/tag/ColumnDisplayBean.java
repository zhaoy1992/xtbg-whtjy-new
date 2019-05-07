package com.chinacreator.xtbg.core.archive.tag;

/**
 *<p>Title:ColumnDisplayBean.java</p>
 *<p>Description:公文字段的显示形式</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-3-29
 */
public class ColumnDisplayBean {
	
	//是否只读
	private boolean readonly = false;
	
	//是否隐藏
	private boolean hide = false;
	
	//是否禁用
	private boolean disable = false;
	
	//是否必填
	private boolean required = false;
	
	
	public boolean isRequired() {
		return required;
	}

	public void setRequired(boolean required) {
		this.required = required;
	}

	public boolean isReadonly() {
		return readonly;
	}

	public void setReadonly(boolean readonly) {
		this.readonly = readonly;
	}

	public boolean isHide() {
		return hide;
	}

	public void setHide(boolean hide) {
		this.hide = hide;
	}

	public boolean isDisable() {
		return disable;
	}

	public void setDisable(boolean disable) {
		this.disable = disable;
	}
	
}
