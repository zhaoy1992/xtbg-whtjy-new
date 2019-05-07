package com.chinacreator.xtbg.yimingju.officeassets.list;

import org.apache.log4j.Logger;
import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.pub.common.DataInfoImpl;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.yimingju.officeassets.dao.OfficeStockDao;
import com.chinacreator.xtbg.yimingju.officeassets.entity.OfficeStocklistBean;
/**
 *<p>Title:OfficeEquipmentList.java</p>
 *<p>Description:实例信息list数据显示</p> 
 *<p>Company:湖南科创</p>
 *@author QIULIAN
 *@version 1.0
 *2012-03-01
 */
public class SeeStockDetailedList  implements DataInfoImpl,java.io.Serializable{
	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(SeeStockDetailedList.class);
	
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
		
		OfficeStocklistBean instanceBean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			instanceBean = (OfficeStocklistBean) JSONObject.parseObject(parmjson, OfficeStocklistBean.class);
		}
		try {
			OfficeStockDao daojson = (OfficeStockDao)DaoImplClassUtil.getDaoImplClass("officeStockDaoImple");
			pb = daojson.findAllEqList(instanceBean, sortName, sortOrder, offset, maxPagesize);
			
		} catch (Exception e) {
			e.printStackTrace();
			LOG.error(e);
		}
		return pb;
	}


	public PagingBean getDataList(String parmStr, String sortName, String sortOrder) {
		return null;
	}
}
