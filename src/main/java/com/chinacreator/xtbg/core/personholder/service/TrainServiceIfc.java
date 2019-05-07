
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     TrainServiceIfc.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-2-21   Administrator    最初版本
   */
package com.chinacreator.xtbg.core.personholder.service;

import java.util.Map;
import com.chinacreator.xtbg.core.personholder.entity.TrainBean;

/**
 *<p>Title:TrainServiceIfc.java</p>
 *<p>Description:培训记录管理业务层接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-2-21
 */
public interface TrainServiceIfc {
	/**
	*<b>Summary: </b>
	* getPersonHolderBean(根据资料分类Id查询培训记录)
	* @param tr_id
	* @return
	 */
	public Map<String, String> getTrainBean(String tr_id);
	
	/**
	*<b>Summary: </b>
	* insertOrUpdatePersonHolder(增加和修改培训记录)
	* @param bean
	* @return
	 */
	public String insertOrUpdateTrain(TrainBean bean);
	
	/**
	*<b>Summary: </b>
	* deleteTrainByIds(根据IDs 删除培训记录)
	* @param ids
	* @return
	 */
	public String deleteTrainByIds(String[] ids);
}
