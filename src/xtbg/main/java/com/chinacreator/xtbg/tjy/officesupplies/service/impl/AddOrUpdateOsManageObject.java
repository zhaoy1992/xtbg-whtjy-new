package com.chinacreator.xtbg.tjy.officesupplies.service.impl;

import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.archive.dao.FlowBusiDataSaveDao;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DaoUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsAccountBean;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsAccountDetails;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsAccountHistoryBean;
import com.chinacreator.xtbg.tjy.officesupplies.service.OsAccountHistoryService;
import com.chinacreator.xtbg.tjy.officesupplies.service.OsAccountManageService;
import com.chinacreator.xtbg.tjy.officesupplies.service.OsAccountService;

/**
 * 固定资产使用管理资产清单处理
 * @author 王淑滨
 *
 */
public class AddOrUpdateOsManageObject extends XtDbBaseDao implements FlowBusiDataSaveDao{
	private static final Log LOG=LogFactory.getLog(AddOrUpdateOsManageObject.class);
	/**
	 * 资产清单处理
	 */
	@Override
	public boolean saveBusiInfo(HttpServletRequest request, Connection conn)
			throws Exception {
		
		String m_id = request.getParameter("m_id");//管理表id
		String m_type = request.getParameter("m_type");//标记是领用登记或借用登记等 /改变资产状态用
		
		String user_id = request.getParameter("user_id");
		String user_name = request.getParameter("user_name");
		String org_id = request.getParameter("org_id");
		String org_name = request.getParameter("org_name");
		String use_date = request.getParameter("use_date");
		
		String[] internal_no_arr = request.getParameterValues("internal_no");//内部编号
		String[] gdzc_num_arr = request.getParameterValues("gdzc_num");//编号
		String[] gdzc_id_arr = request.getParameterValues("gdzc_id");//固定资产id
		String[] gdzc_name_arr = request.getParameterValues("gdzc_name");//名称
		String[] bar_code_arr = request.getParameterValues("bar_code");//条形码
		String[] body_no_arr = request.getParameterValues("body_no");//机身号
		String[] state_arr = request.getParameterValues("state");//状态
		
		if(!StringUtil.nullOrBlank(m_id)){//如果计划表id不为空
			//新增清单service
			OsAccountManageService service = new OsAccountManageServiceImpl();
			//固资service
			OsAccountService accountService = new OsAccountServiceImpl();
			//使用记录service
			OsAccountHistoryService historyService = new OsAccountHistoryServiceImpl();
			
			//删除
			service.deleteManagerDetails(new String[]{m_id});
			
			for(int i=0;i<gdzc_id_arr.length;i++){
				if((!StringUtil.nullOrBlank(gdzc_id_arr[i])) && (!StringUtil.nullOrBlank(gdzc_num_arr[i]))){
					//清单表新增
					OsAccountDetails bean = new OsAccountDetails();
					bean.setId(DaoUtil.getUUID());
					bean.setM_id(m_id);
					bean.setInternal_no(internal_no_arr[i]);
					bean.setGdzc_num(gdzc_num_arr[i]);
					bean.setGdzc_id(gdzc_id_arr[i]);
					bean.setGdzc_name(gdzc_name_arr[i]);
					bean.setBar_code(bar_code_arr[i]);
					bean.setBody_no(body_no_arr[i]);
					bean.setState(state_arr[i]);
					
					service.insertManagerDetails(bean);
					//资产状态改变
					OsAccountBean accountBean = new OsAccountBean();
					if(m_type.equals("借用登记")){
						accountBean.setUser_id(user_id);
						accountBean.setUser_name(user_name);
						accountBean.setUse_date(use_date);
						accountBean.setOrg_id(org_id);
						accountBean.setOrg_name(org_name);
						accountBean.setState("借用");
					}else if(m_type.equals("领用登记")){
						accountBean.setUser_id(user_id);
						accountBean.setUser_name(user_name);
						accountBean.setUse_date(use_date);
						accountBean.setOrg_id(org_id);
						accountBean.setOrg_name(org_name);
						accountBean.setState("领用");
					}else if(m_type.equals("调拨登记")){
						accountBean.setIs_allocation("1");
						accountBean.setAllocation_place(org_name);
						accountBean.setAllocation_date(use_date);
						accountBean.setLocation_id(org_id);
						accountBean.setLocation_name(org_name);
						accountBean.setLocation_org(org_name);
						accountBean.setLocation_org_id(org_id);
						accountBean.setState("在库正常");
					}else if(m_type.equals("出租登记")){
						accountBean.setIs_lease("1");
						accountBean.setLease_place(org_name);
						accountBean.setState("出租");
						accountBean.setUse_date(use_date);
					}else if(m_type.equals("借用归还") || m_type.equals("领用归还") || m_type.equals("出租归还")){
						accountBean.setState("在库正常");
						accountBean.setIs_lease("0");
					}else if(m_type.equals("调拨归还")){
						accountBean.setIs_allocation("0");
						accountBean.setLocation_id(org_id);
						accountBean.setLocation_name(org_name);
						accountBean.setLocation_org(org_name);
						accountBean.setLocation_org_id(org_id);
						accountBean.setState("在库正常");
					}
					accountBean.setId(gdzc_id_arr[i]);
					accountService.changeState(accountBean);
					
					//新增使用记录
					OsAccountHistoryBean historyBean = new OsAccountHistoryBean();
					historyBean.setId(DaoUtil.getUUID());
					historyBean.setGdzc_id(gdzc_id_arr[i]);
					historyBean.setGdzc_name(gdzc_name_arr[i]);
					historyBean.setUser_id(user_id);
					historyBean.setUser_name(user_name);
					historyBean.setOrg_id(org_id);
					historyBean.setOrg_name(org_name);
					historyBean.setUse_type(m_type);
					historyBean.setUser_date(use_date);
					historyBean.setGhdj_id(m_id);
					
					historyService.insertHisetory(historyBean);
					
				}
			}
			
		}
		
		return true;
	}

}
