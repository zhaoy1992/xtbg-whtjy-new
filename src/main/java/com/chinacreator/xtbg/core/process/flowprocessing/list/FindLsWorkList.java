package com.chinacreator.xtbg.core.process.flowprocessing.list;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.DataInfoImpl;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DataControlUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowBusiSearchDao;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.WorkFlowSearchBean;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * 
 *<p>Title:FindLsWorkList.java</p>
 *<p>Description:流程相关历史查看</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-12-16
 */
public class FindLsWorkList extends DataInfoImpl {

	private static final Log LOG=LogFactory.getLog(FindLsWorkList.class);
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
		WorkFlowSearchBean workFlowSearchBean = null;
		PagingBean pb = null;
		if (!StringUtil.isBlank(parmjson) ) {
			parmjson = DataControlUtil.replaceStr(parmjson);
			workFlowSearchBean = (WorkFlowSearchBean) JSONObject.parseObject(parmjson, WorkFlowSearchBean.class);
		}
		
		try {
			FlowBusiSearchDao fInfodao = (FlowBusiSearchDao)LoadSpringContext.getApplicationContext().getBean("flowBusiSearchDaoImpl");
			pb = fInfodao.findLsWorkList(workFlowSearchBean, sortName, sortOrder, offset, maxPagesize);
			List<Map<String, String>> listold= (List<Map<String, String>>)pb.getList();
			//List<Map<String, String>> listnew=new ArrayList<Map<String,String>>();
			String temp_flow_name = "";
			int flow_order = 0;
			for (Map<String, String> map : listold) {
				
				String flow_name = StringUtil.deNull(map.get("flow_name"));
				if(StringUtil.isBlank(temp_flow_name) || !flow_name.equals(temp_flow_name)){//为分组加排序号
					temp_flow_name=flow_name;
					flow_order++;
				}
				String ins_id = StringUtil.deNull(map.get("ins_id"));
				String busi_id = StringUtil.deNull(map.get("busi_id"));

				String ins_name = StringUtil.deNull(map.get("ins_name"));
				if("2".equals(map.get("flow_tyle"))){//2是word,1是表单
					map.put("flow_name_order", flow_order+"："+temp_flow_name+"（"+ins_name+"）  <a  onclick=\"find('"+ins_id+"','"+busi_id+"')\"><font color='red'><u>查看</u></font></a>");
				}else{
					map.put("flow_name_order", flow_order+"："+temp_flow_name+"（"+ins_name+"）");
				}
				//map.put("flow_name_order", flow_order+"："+temp_flow_name+"  <input type=\"button\" calss=\"but_y_01\" value=\"查看\" onclick=\"find('"+ins_id+"','"+busi_id
				//		+"')\" style=\"width: 63px;height: 22px;\">");
				String is_valid=map.get("valid");
				String user_realname=StringUtil.deNull(map.get("user_realname"));
				//特检院OA 自动判断根据环节来判断 待执行 start 
				String action_name = StringUtil.deNull(map.get("action_name"));
				//特检院OA end
				String status="已完成";//是否已经执行
				//1.假如is_valid(valid)为Y并且user_realname为空，则是当前环节
				if("Y".equals(is_valid) && StringUtil.isBlank(user_realname)){
					String sql="select wmsys.wm_concat(distinct user_realname) name from("+
					"select u.user_realname from oa_flow_actionuser a,td_sm_user u where a.user_name=u.user_name  and ins_id='"+StringUtil.deNull(map.get("ins_id"))+"')";
					PreparedDBUtil db=new PreparedDBUtil();
					db.preparedSelect(sql);
					db.executePrepared();
					if(db.size()>0){
						user_realname=db.getString(0, "name");
					}
					map.put("user_realname", user_realname);
					status="待执行";
				}
				//2.假如is_valid(valid)为N并且user_realname为空，则是追回或回退环节
				if("N".equals(is_valid) && StringUtil.isBlank(user_realname)){
					map.put("user_realname", "已取消");
				}
				//3.
				if("自动办结".equals(action_name)){
					 status="已完成";
				}
				map.put("status", status);
				//listnew.add(map);
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		System.out.println(pb.getList().toString());
		System.out.println(pb.getList().size());
		return pb;
	}

	@Override
	public PagingBean getDataList(String parmjson, String sortName,
			String sortOrder) {
		// TODO Auto-generated method stub
		return null;
	}

}
