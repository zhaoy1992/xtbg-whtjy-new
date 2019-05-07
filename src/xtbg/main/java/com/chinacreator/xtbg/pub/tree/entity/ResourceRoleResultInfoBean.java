package com.chinacreator.xtbg.pub.tree.entity;

public class ResourceRoleResultInfoBean {
	private String role_ids;//权限指定能展示的机构id集合
	
	private String canshow_orgids;//权限范围内能显示的所有机构id集合


	public String getRole_ids() {
		return role_ids;
	}

	public void setRole_ids(String roleIds) {
		role_ids = roleIds;
	}

	public String getCanshow_orgids() {
		return canshow_orgids;
	}

	public void setCanshow_orgids(String canshowOrgids) {
		canshow_orgids = canshowOrgids;
	}
	
	
}
