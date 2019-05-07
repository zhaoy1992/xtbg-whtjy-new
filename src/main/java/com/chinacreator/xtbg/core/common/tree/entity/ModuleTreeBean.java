/**
 * 
 */
package com.chinacreator.xtbg.core.common.tree.entity;


/**
 * 
 *
 */
public class ModuleTreeBean {
	private String title;
	private String id;
	private String name;
	private String pname;
	private String open;
	private String ppp;
	private String reallyRTypeId;
	private String reallyRId;
	private String isParent;
	private String resLogo;
	private String orgid;
	private String username;
	private String icon;
	private String nocheck;
	private String checked;
	private String click;
	
	
	
	public String getClick() {
		return click;
	}
	public void setClick(String click) {
		this.click = click;
	}
	/**
	 * @return the checked
	 */
	public String getChecked() {
		return checked;
	}
	/**
	 * @param checked the checked to set
	 */
	public void setChecked(String checked) {
		this.checked = checked;
	}
	/**
	 * @return the nocheck
	 */
	public String getNocheck() {
		return nocheck;
	}
	/**
	 * @param nocheck the nocheck to set
	 */
	public void setNocheck(String nocheck) {
		this.nocheck = nocheck;
	}
	/**
	 * @return the icon
	 */
	public String getIcon() {
		return icon;
	}
	/**
	 * @param icon the icon to set
	 */
	public void setIcon(String icon) {
		this.icon = icon;
	}
	/**
	 * @return the orgid
	 */
	public String getOrgid() {
		return orgid;
	}
	/**
	 * @param orgid the orgid to set
	 */
	public void setOrgid(String orgid) {
		this.orgid = orgid;
	}
	/**
	 * @return the username
	 */
	public String getUsername() {
		return username;
	}
	/**
	 * @param username the username to set
	 */
	public void setUsername(String username) {
		this.username = username;
	}
	/**
	 * @return the resLogo
	 */
	public String getResLogo() {
		return resLogo;
	}
	/**
	 * @param resLogo the resLogo to set
	 */
	public void setResLogo(String resLogo) {
		this.resLogo = resLogo;
	}
	/**
	 * @return the isParent
	 */
	public String getIsParent() {
		return isParent;
	}
	/**
	 * @param isParent the isParent to set
	 */
	public void setIsParent(String isParent) {
		this.isParent = isParent;
	}
	/**
	 * @return the reallyRTypeId
	 */
	public String getReallyRTypeId() {
		return reallyRTypeId;
	}
	/**
	 * @param reallyRTypeId the reallyRTypeId to set
	 */
	public void setReallyRTypeId(String reallyRTypeId) {
		this.reallyRTypeId = reallyRTypeId;
	}
	/**
	 * @return the reallyRId
	 */
	public String getReallyRId() {
		return reallyRId;
	}
	/**
	 * @param reallyRId the reallyRId to set
	 */
	public void setReallyRId(String reallyRId) {
		this.reallyRId = reallyRId;
	}
	/**
	 * @return the ppp
	 */
	public String getPpp() {
		return ppp;
	}
	/**
	 * @param ppp the ppp to set
	 */
	public void setPpp(String ppp) {
		this.ppp = ppp;
	}
	/**
	 * @return the open
	 */
	public String getOpen() {
		return open;
	}
	/**
	 * @param open the open to set
	 */
	public void setOpen(String open) {
		this.open = open;
	}
	/**
	 * @return the title
	 */
	public String getTitle() {
		return title;
	}
	/**
	 * @param title the title to set
	 */
	public void setTitle(String title) {
		this.title = title;
	}
	/**
	 * @return the id
	 */
	public String getId() {
		return id;
	}
	/**
	 * @param id the id to set
	 */
	public void setId(String id) {
		this.id = id;
	}
	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}
	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return the pname
	 */
	public String getPname() {
		return pname;
	}
	/**
	 * @param pname the pname to set
	 */
	public void setPname(String pname) {
		this.pname = pname;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ModuleTreeBean other = (ModuleTreeBean) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}
	
	
	
	
	
}
