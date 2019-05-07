package com.chinacreator.xtbg.pub.tree.dao.impl.otherResources;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.chinacreator.xtbg.pub.tree.dao.TreeOtherResourcesDao;
import com.chinacreator.xtbg.pub.tree.entity.TreeBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>Title:YuewenFileTypeTreeImpl.java</p>
 *<p>Description: 阅文平台的类别树的实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 夏天
 *@version 1.0
 *2013-4-26
 */
public class YuewenFileTypeTreeImpl implements TreeOtherResourcesDao {
	// 阅文平台类别树的sql
	private static final String TREE_FILE_TYPE = "select o.type_id,o.type_name,o.type_desc,o.parent_type_id,o.type_sn from ymj_oa_document_filetype o connect by prior o.type_id=o.parent_type_id start with o.parent_type_id='0' order by o.type_sn";

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 inqueryTreeOtherResources
	  * @param bean
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.pub.tree.dao.TreeOtherResourcesDao#inqueryTreeOtherResources(com.chinacreator.xtbg.pub.tree.entity.TreeBean)
	 */
	public Object inqueryTreeOtherResources(TreeBean bean) throws SQLException {

		ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(TREE_FILE_TYPE);

		Map<String, String> tempVal = null;
		pdb.executePrepared();

		for (int i = 0; i < pdb.size(); i++) {
			tempVal = new HashMap<String, String>();
			tempVal.put("id", pdb.getString(i, "type_id"));
			tempVal.put("item_id", pdb.getString(i, "type_id"));
			tempVal.put("org_id", pdb.getString(i, "type_id"));
			tempVal.put("name", pdb.getString(i, "type_name"));
			tempVal.put("parent_id", pdb.getString(i, "parent_type_id"));
			tempVal.put("type_desc", pdb.getString(i, "remark"));
			tempVal.put("type_sn", pdb.getString(i, "order_no"));
			list.add(tempVal);
		}
		// 查询出ORG

		return list;
	}

}
