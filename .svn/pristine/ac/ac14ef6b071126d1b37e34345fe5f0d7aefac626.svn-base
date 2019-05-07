package com.chinacreator.xtbg.yimingju.officeassets.list;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.pub.common.DataInfoImpl;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.yimingju.officeassets.dao.CollarStockDao;
import com.chinacreator.xtbg.yimingju.officeassets.entity.CollarBean;

import org.apache.log4j.Logger;
/**
 *<p>Title:myAssetsList.java</p>
 *<p>Description:我的资产实例信息list数据显示</p> 
 *<p>Company:湖南科创</p>
 *@author QIULIAN
 *@version 1.0
 *2012-03-01
 */
public class MyAssetsList implements DataInfoImpl,java.io.Serializable{

	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(MyAssetsList.class);
	
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
		
		CollarBean instanceBean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			instanceBean = (CollarBean) JSONObject.parseObject(parmjson, CollarBean.class);
		}
		
		try {
			CollarStockDao daojson = (CollarStockDao)DaoImplClassUtil.getDaoImplClass("collarStockDaoImpl");
			pb = daojson.findTypeList(instanceBean, sortName, sortOrder, offset, maxPagesize);
			
		} catch (Exception e) {
			LOG.error(e);
		}
		return pb;
	}


	public PagingBean getDataList(String parmStr, String sortName, String sortOrder) {
		return null;
	}
}
