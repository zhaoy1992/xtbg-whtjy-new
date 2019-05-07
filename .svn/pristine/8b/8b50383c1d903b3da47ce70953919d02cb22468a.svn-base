package com.chinacreator.xtbg.core.datasourcemanage.list;

import java.util.ArrayList;
import java.util.List;

import com.chinacreator.epp.datasourcemanage.DatasourceManage;
import com.chinacreator.epp.datasourcemanage.Poolman;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
/**
 * 
 *<p>Title:DatasourceList.java</p>
 *<p>Description:数据源查询列表</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-10-29
 */
public class DatasourceList extends DataInfoImpl {

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getDataList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return 
	  * @see com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl#getDataList(java.lang.String, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		 	DatasourceManage dm = new DatasourceManage();
		 	List<Poolman> poolmanList = dm.getDatasources();
		    PagingBean pb=new PagingBean();
		    List<Poolman> listInfo = pagerList(poolmanList, (int)offset, maxPagesize);
		    pb.setList(listInfo);
		    pb.setRecords((long)poolmanList.size());
		    return pb;
	}

	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder) {
		// TODO Auto-generated method stub
		return null;
	}
	 private List<Poolman> pagerList(List<Poolman> datas, int offset, int pageItems)
	  {
	    if (datas == null)
	      return null;
	    List<Poolman> list = new ArrayList<Poolman>();
	    if (offset >= datas.size())
	    {
	      int temp = datas.size() % pageItems;
	      offset = datas.size() - temp;
	    }
	    for (int i = offset; (i < datas.size()) && (i < offset + pageItems); ++i)
	    {
	      list.add(datas.get(i));
	    }
	    
	    return list;
	  }

}
