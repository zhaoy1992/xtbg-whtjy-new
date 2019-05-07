package com.chinacreator.xtbg.pub.tree.servlet;


import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.security.AccessControl;
import com.chinacreator.sysmgrcoreext.manager.IOrgManagerExt;
import com.chinacreator.sysmgrcoreext.manager.bean.UserOrgStatusBean;
import com.chinacreator.sysmgrcoreext.manager.db.OrgManagerExtImpl;
import com.chinacreator.xtbg.core.common.tree.dao.impl.CommonTreeDaoImpl;
import com.chinacreator.xtbg.pub.tree.entity.TreeBean;
import com.chinacreator.xtbg.pub.tree.service.impl.ResourceConfigServiceImpl;
import com.chinacreator.xtbg.pub.tree.service.impl.TreeBusinessService;
import com.chinacreator.xtbg.pub.tree.service.impl.TreeService;


/**
 * <p>
 * Title:ScheduleServlet.java
 * </p>
 * <p>
 * Description:领导日程管理
 * </p>
 * <p>
 * Company:湖南科创
 * </p>
 * 
 * @author 沈联成
 * @version 1.0 2012-9-18
 */
public class TreeServlet extends HttpServlet {
	private static final Map<String, Object> CLASSES = new HashMap<String, Object>();
	static {
		CLASSES.put("find", new TreeService());
		CLASSES.put("config", new TreeBusinessService());
		CLASSES.put("orgresource", new ResourceConfigServiceImpl());
	}
	private static final long serialVersionUID = -9887767666665L;

	/**
	 * @Description 根据条件查询个人文件记录 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("utf-8");
		String data = req.getParameter("data");
		String classID = req.getParameter("classID");
		String methodName = req.getParameter("method");
		Map map = JSONObject.parseObject(data, Map.class);
		String path = req.getContextPath();
		AccessControl accesscontroler = AccessControl.getInstance();
		accesscontroler.checkAccess(req, resp);
		String userId = accesscontroler.getUserID();
		String userKey = accesscontroler.getUserAccount();
		String userName = accesscontroler.getUserName();
		String orgId=accesscontroler.getChargeOrgId();
		/*获取用户所有的机构，包括主机构和隶属机构*/
		IOrgManagerExt om = new OrgManagerExtImpl();
		List<UserOrgStatusBean> orglist = om.getCurrentOrg(userId);
		
		String orgParent ="";
		if(null != accesscontroler.getChargeOrg())
		   orgParent = accesscontroler.getChargeOrg().getParentId();
		
		String orgName = accesscontroler.getChargeOrgName();
		Object obj = CLASSES.get(classID);
		Object errobj = "''";
		try {
			Method method = obj.getClass().getDeclaredMethod(methodName,
					TreeBean.class);
			TreeBean entity = new TreeBean();
			entity.setRequest(req);
			entity.setResponse(resp);
			if(null != map){
				map.put("current_org_id", orgId);
				map.put("current_org_name", orgName);
			}
			entity.setRequestMap(map);
			entity.setUserID(userId);
			entity.setUserKey(userKey);
			entity.setUserName(userName);
			entity.setOrgID(orgId);
			entity.setOrgName(orgName);
			entity.setAllOrgList(orglist);
			obj = method.invoke(obj, new Object[] { entity });
		} catch (Exception e) {
			e.printStackTrace();
			errobj = "'" + e.getMessage() + "'";
		}
		resp.setContentType("text/plain; charset=UTF-8");
		resp.setHeader("Pragma", "No-cache");
		resp.setHeader("Cache-Control", "no-cache");
		resp.setDateHeader("Expires", 0);
		PrintWriter write = resp.getWriter();
		String jsons = JSONObject.toJSON(obj).toString();
		String s = "var json={returnValue:" + jsons + ",orgId:'" + orgId +","+orgParent+ "',error:" + errobj + "};";
		write.print(s);
		write.close();
	}

}
