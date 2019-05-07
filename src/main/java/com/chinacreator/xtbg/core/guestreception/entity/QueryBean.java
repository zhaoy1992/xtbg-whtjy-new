package com.chinacreator.xtbg.core.guestreception.entity;

import java.util.List;
/**
 * 
 *<p>Title:QueryBean.java</p>
 *<p>Description:数据列表实体类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-9-5
 */
public class QueryBean {

	//
	private GuestreceptionBean guestreceptionBean;
	//
	List<GuestTravelBean> travelList;
	//
	List<GuestBeanNew> guestList;
	//
	List<GuestReceiveBean> guestReceiveList;
	public GuestreceptionBean getGuestreceptionBean() {
		return guestreceptionBean;
	}
	public void setGuestreceptionBean(GuestreceptionBean guestreceptionBean) {
		this.guestreceptionBean = guestreceptionBean;
	}
	public List<GuestTravelBean> getTravelList() {
		return travelList;
	}
	public void setTravelList(List<GuestTravelBean> travelList) {
		this.travelList = travelList;
	}
	public List<GuestBeanNew> getGuestList() {
		return guestList;
	}
	public void setGuestList(List<GuestBeanNew> guestList) {
		this.guestList = guestList;
	}
	public List<GuestReceiveBean> getGuestReceiveList() {
		return guestReceiveList;
	}
	public void setGuestReceiveList(List<GuestReceiveBean> guestReceiveList) {
		this.guestReceiveList = guestReceiveList;
	}
}
