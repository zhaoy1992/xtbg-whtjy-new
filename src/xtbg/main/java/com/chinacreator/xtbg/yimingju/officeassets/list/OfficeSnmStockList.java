package com.chinacreator.xtbg.yimingju.officeassets.list;

import org.apache.log4j.Logger;
import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.pub.common.DataInfoImpl;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.yimingju.officeassets.dao.ConsumeStockDao;
import com.chinacreator.xtbg.yimingju.officeassets.entity.OfficeConsumStock;

/**
 *<p>Title:DetailWaitList.java</p>
 *<p>Description:实例信息list数据显示</p> 
 *<p>Company:湖南科创</p>
 *@author QIULIAN
 *@version 1.0
 *2012-03-01
 */
public class OfficeSnmStockList implements DataInfoImpl,java.io.Serializable{
	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(OfficeSnmStockList.class);
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
		OfficeConsumStock instanceBean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			instanceBean = (OfficeConsumStock) JSONObject.parseObject(parmjson, OfficeConsumStock.class);
		}
		
		try {
			ConsumeStockDao daojson = (ConsumeStockDao)DaoImplClassUtil.getDaoImplClass("consumeStockDaoImpl");
			pb = daojson.findSnmEqList(instanceBean, sortName, sortOrder, offset, maxPagesize);
			
		} catch (Exception e) {
			LOG.error(e);
		}
		return pb;
	}


	public PagingBean getDataList(String parmStr, String sortName, String sortOrder) {
		return null;
	}
}
