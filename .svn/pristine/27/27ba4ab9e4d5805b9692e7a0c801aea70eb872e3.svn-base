package com.chinacreator.xtbg.pub.oagwcs.dao;

import java.sql.SQLException;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.oagwcs.entity.ReceiveBean;
import com.chinacreator.xtbg.pub.oagwcs.entity.ReceiveGwcsBean;
import com.chinacreator.xtbg.pub.oagwcs.entity.ReceiveGwcsListSearchBean;






/**
 *<p>Title:ReceiveDao.java</p>
 *<p>Description:来文单位信息dao层接口</p> 
 *<p>Company:湖南科创</p>
 *@author 刘春元
 *@version 1.0
 *2011-12-23
 */
public interface ReceiveDao {

	/**
	 * @Description 根据条件查询用户信息
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findUserList(ReceiveBean receiveBeanJson, String sortName, String sortOrder, long offset, int maxPagesize);
	
	/**
	 * @Description 根据条件查询公文传输的收文信息
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findReceiveGwcsList(ReceiveGwcsListSearchBean receiveGwcsListSearchBean, String sortName, String sortOrder, long offset, int maxPagesize);

	/**
	 * 根据id查询公文传输收文bean
	 * @param gwreceive_id
	 * @return
	 * @throws Exception
	 */
	public ReceiveGwcsBean findReceiveGwcsBeanById(String gwreceive_id) throws Exception;
	
	/**
	 * 设置公文传输数据是否已用
	 * @param gwreceive_id
	 * @param isused
	 * @throws Exception
	 */
	public void setReceiveGwcs2Beused(String gwreceive_id,boolean isused) throws Exception;
	
	/**
	 * @Description 添加来文单位信息
	 * @param receiveBeanJson 来文单位Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public void addReceive(ReceiveBean receivesetBean) throws SQLException;
	
	/**
	 * @Description  删除来文单位信息
	 * @param receiveIds
	 * @return boolean
	 * @throws SQLException 
	 */
	public boolean delReceive(String receiveIds) throws SQLException;
	
	/**
	 * @Description 修改来文单位信息
	 * @param receivesetBean 来文单位Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public void updateReceive(ReceiveBean receivesetBean) throws SQLException;
	
	/**
	 * @Description 根据来文单位ID获得来文单位信息
	 * @param receivesetBean 来文单位Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public ReceiveBean getReceiveBeanById(String id) throws SQLException;
	/**
	 * 获得来文单位下拉框的数据
	 * @param userid
	 * @return
	 */
	public String getOrgSelectHtml()throws Exception ;
	/**
	 * 获得缓急下拉框的数据
	 * @param userid
	 * @return
	 */
	public String getLevelSelectHtml()throws Exception ;
	
}
