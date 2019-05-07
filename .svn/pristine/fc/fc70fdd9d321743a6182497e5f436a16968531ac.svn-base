package com.chinacreator.xtbg.yimingju.officeassets.list;

import org.apache.log4j.Logger;
import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.pub.common.DataInfoImpl;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.yimingju.officeassets.dao.ConsumeStockDao;
import com.chinacreator.xtbg.yimingju.officeassets.entity.ConSumeStockListBean;
/**
 *<p>Title:SeeConSumDetailedList.java</p>
 *<p>Description:实例信息list数据显示</p> 
 *<p>Company:湖南科创</p>
 *@author QIULIAN
 *@version 1.0
 *2012-03-01
 */
public class SeeConSumDetailedList  implements DataInfoImpl,java.io.Serializable{
	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(SeeConSumDetailedList.class);
	
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
		
		ConSumeStockListBean instanceBean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			instanceBean = (ConSumeStockListBean) JSONObject.parseObject(parmjson, ConSumeStockListBean.class);
		}
		try {
			ConsumeStockDao daojson = (ConsumeStockDao)DaoImplClassUtil.getDaoImplClass("consumeStockDaoImpl");
			pb = daojson.findAllList(instanceBean, sortName, sortOrder, offset, maxPagesize);
			
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
