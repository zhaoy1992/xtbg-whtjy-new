package com.chinacreator.xtbg.yimingju.officeassets.list;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.pub.common.DataInfoImpl;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.yimingju.officeassets.dao.PurchaseApprovalRoolDao;
import com.chinacreator.xtbg.yimingju.officeassets.entity.PurchaseApplyBean;

/**
 *<p>Title:PurchaseApprovalRoolList.java</p>
 *<p>Description:采购申请处室审批list数据显示</p> 
 *<p>Company:湖南科创</p>
 *@author 刘春元
 *@version 1.0
 *2012-03-01
 */
public class ApprovalWaitRoomList implements DataInfoImpl,java.io.Serializable{
	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(ApprovalWaitRoomList.class);
	
	/**
	 * @Description  查询类型列表
	 * 
	 * @param request
	 * @param response
	 * @return  返回JOSNOBJECT
	 * @exception 
	 */
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		
		PurchaseApplyBean instanceBean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			instanceBean = (PurchaseApplyBean) JSONObject.parseObject(parmjson, PurchaseApplyBean.class);
		}
		
		try {
			PurchaseApprovalRoolDao daojson = (PurchaseApprovalRoolDao)DaoImplClassUtil.getDaoImplClass("purchaseApprovalRoolDaoImpl");
			pb = daojson.findWaitList(instanceBean, sortName, sortOrder, offset, maxPagesize);
			
		} catch (Exception e) {
			LOG.error(e);
		}
		return pb;
	}


	public PagingBean getDataList(String parmStr, String sortName, String sortOrder) {
		return null;
	}
}
