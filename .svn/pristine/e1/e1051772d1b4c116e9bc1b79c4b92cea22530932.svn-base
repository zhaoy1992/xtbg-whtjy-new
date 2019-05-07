package com.chinacreator.xtbg.core.guestreception.service;

import java.util.List;

import com.chinacreator.xtbg.core.guestreception.entity.GuestBeanNew;
import com.chinacreator.xtbg.core.guestreception.entity.GuestReceiveBean;
import com.chinacreator.xtbg.core.guestreception.entity.GuestTravelBean;
import com.chinacreator.xtbg.core.guestreception.entity.GuestreceptionBean;
/**
 * 
 *<p>Title:GuestreceptionServiceIfc.java</p>
 *<p>Description:接待管理的服务接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-9-5
 */
public interface GuestreceptionServiceIfc {

	/**
	 * 
	*<b>Summary: </b>
	* saveGuestInfo(添加和更新)
	* @param guestreceptionBean
	* @param travelList
	* @param guestList
	* @param guestReceiveList
	* @throws Exception
	 */
	public String saveGuestInfo(GuestreceptionBean guestreceptionBean,List<GuestTravelBean> travelList, List<GuestBeanNew> guestList,List<GuestReceiveBean> guestReceiveList)throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* deleteGuestInfo(删除接待管理)
	* @param grinfoId
	* @throws Exception
	 */
	public String deleteGuestInfo(String grinfoId)throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* updatestatus(暂存状态的发布)
	* @param grinfoId
	* @param stateValue
	* @throws Exception
	 */
	public String updatestatus(String grinfoId,String stateValue)throws Exception;
}
