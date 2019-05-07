package com.chinacreator.xtbg.yimingju.carmanage.dao;



import java.sql.Connection;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageYoukaBean;

/**
 * 油卡管理dao
 * @author 王淑滨
 *
 */
public interface CarManageYoukaDao {
	/**
	 * 得已办结且同意发放的油卡申请列表
	 * @param carmanagecarbean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean getYoukaList(CarManageYoukaBean youkaBean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception ;
	/**
	 * getByID
	 * @param id
	 * @param conn
	 * @return
	 */
	public CarManageYoukaBean getById(String id,Connection conn)throws Exception;
	/**
	 * 油卡发放登记
	 * @param bean
	 * @return
	 * @throws Exception
	 */
	public boolean Update(CarManageYoukaBean bean,Connection conn)throws Exception;
	/**
	 * 得已发放的油卡记录列表
	 * @param youkaBean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean getFafangList(CarManageYoukaBean youkaBean,String sortName,
			String sortOrder,long offset,int maxPagesize) throws Exception;
}
