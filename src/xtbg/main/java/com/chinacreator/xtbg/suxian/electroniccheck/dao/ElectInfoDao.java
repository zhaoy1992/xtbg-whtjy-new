package com.chinacreator.xtbg.suxian.electroniccheck.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.suxian.electroniccheck.entity.AttendanceLeaveBean;
import com.chinacreator.xtbg.suxian.electroniccheck.entity.ElectInfoBean;
import com.chinacreator.xtbg.suxian.electroniccheck.entity.ElectInfoCountSearchBean;
import com.chinacreator.xtbg.suxian.electroniccheck.entity.ElectResetBean;
import com.chinacreator.xtbg.core.directory.entity.WorkIPBean;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.WorkFlowSearchBean;
import com.chinacreator.xtbg.pub.common.PagingBean;




/**
 *<p>Title:ElectInfoDao.java</p>
 *<p>Description:电子考勤信息dao层接口</p> 
 *<p>Company:湖南科创</p>
 *@author 付程
 *@version 1.0
 *2012-2-23
 */
public interface ElectInfoDao {
    
	public PagingBean findInfoList(ElectInfoBean contentBean, String sortName, String sortOrder, long offset, int maxPagesize);
	//查询当前日期的考勤数据
	public ElectInfoBean isAddOrUpdate(ElectInfoBean electInfoBean) throws Exception;
	
	public boolean isAddOrUpdate1(ElectResetBean electResetInfoBean,String isuse,String reset_id,String start_time,String end_time,String isauto) throws Exception;
	//添加考勤基本信息
	public void addInfos(ElectInfoBean electResetInfoBean) throws Exception;
	
	public void updateStartTime(ElectInfoBean electResetInfoBean) throws Exception;
	//更新上班状态
	public void updateEndTime(ElectInfoBean electResetInfoBean) throws Exception;
	//更新半天假上班状态
	public void updateHalfTime(ElectInfoBean electResetInfoBean) throws Exception;
	//查询考勤设置中所选的作息时间基本信息
	public ElectResetBean getContentBean() throws SQLException;
	//判断上下班按钮是否置灰
	public boolean findButtonState(String datetime,String userid) throws Exception;
	//给电子考勤控制按钮表添加数据
	public void addButtonState(String datetime,String userid) throws Exception;
	//查询按钮控制表中当前用户在当天是否有数据
	public ElectInfoBean getButtonStateInfo(String datetime,String userid) throws Exception;
	
	public void updateButtonState(String userid,String work_sys,String end_sys) throws Exception;
	
	//修改考勤基本信息
	public void updateElectInfoBean(ElectInfoBean electInfoBean) throws Exception;
	
	//查询考勤统计
	public PagingBean findInfoCountList(ElectInfoCountSearchBean contentBean, String sortName, String sortOrder, long offset, int maxPagesize) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* insertWorkIPBean(新增办公IP)
	* @param workIPBean
	* @throws Exception
	 */
	public void insertWorkIPBean(WorkIPBean workIPBean) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* updateWorkIPBean(更新办公IP)
	* @param workIPBean
	* @throws Exception
	 */
	public void updateWorkIPBean(WorkIPBean workIPBean) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* deleteWorkIPBean(删除办公IP)
	* @param ids
	* @return
	* @throws Exception
	 */
	public boolean deleteWorkIPBean(String ids) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* findWorkIPInfoList(查询办公IP列表)
	* @param contentBean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	 */
	public PagingBean findWorkIPInfoList(ElectInfoBean contentBean, String sortName, String sortOrder, long offset, int maxPagesize);
	
	/**
	 * 
	*<b>Summary: </b>
	* findWorkIPInfo(根据ID查询办公IP信息)
	* @param workip_id
	* @return
	* @throws Exception
	 */
	public WorkIPBean findWorkIPInfo(String workip_id) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* findWorkIPList(查询出所有办公IP段)
	* @return
	* @throws Exception
	 */
	public List<WorkIPBean> findWorkIPList() throws Exception;
	
	/**
	*<b>Summary: </b>
	* findElectInfoBeanById(根据主键ID 查询当天的考勤信息)
	* @param elect_id 
	* @return
	* @throws Exception
	 */
	public ElectInfoBean findElectInfoBeanById(String elect_id) throws Exception;
	
	/**
	*<b>Summary: </b>
	* queryHolidayTimes(查询节假日日期)
	* @param startTime
	* @param endTime
	* @return
	* @throws Exception
	* @author jia.tong   2013-08-30
	 */
	public List<String> queryHolidayTimes(String startTime,String endTime) throws Exception;
	
	/**
	 * 查询当前登陆人员有处于【销假申请】环节的请假单，
	 * 且请假单的状态为在办中请假结束日期  早于或等于当前系统日期，
	 * 则【上班打卡】、【下班打卡】按钮都被禁用无法点击
	 */
	public boolean queryflowleave(String username) throws Exception;
	
	/**
	 * 判断是否为半天假
	 * @param username
	 * @return
	 */
	public Map<String,String> ishalfDay(String username) throws Exception;
	/**
	 * 得到请假详情列表
	 * @param bean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean getDetails (AttendanceLeaveBean bean, String sortName, String sortOrder, long offset, int maxPagesize) throws Exception;
	/**
	 * 得到后台管理列表
	 * @param bean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean getManageList(WorkFlowSearchBean bean,String sortName, String sortOrder, long offset, int maxPagesize) throws Exception;
	/**
	 * 删除请假信息
	 * @param ins_id
	 * @return
	 * @throws Exception
	 */
	public boolean del(String ins_id,Connection conn)throws Exception;
}

