
<%@page import="com.chinacreator.config.ConfigManager"%>
<%@page
	import="com.chinacreator.sysmgrcore.manager.db.OrgAdministratorImpl"%>
<%
	 /**
	 * <p>Title: ɾ����������ҳ��</p>
	 * <p>Description: ɾ����������ҳ��</p>
	 * <p>Copyright: Copyright (c) 2008</p>
	 * <p>Company: chinacreator</p>
	 * @Date 2008-3-17
	 * @author da.wei
	 * @version 1.0
	 **/
%>
<%@ page language="java" contentType="text/html; charset=GBK"%>

<%@ page
	import="com.frameworkset.util.StringUtil,com.chinacreator.security.AccessControl,com.chinacreator.sysmgrcore.entity.Organization,com.frameworkset.common.poolman.DBUtil,com.chinacreator.sysmgrcore.manager.OrgManager,com.chinacreator.sysmgrcore.manager.UserManager,com.chinacreator.sysmgrcore.manager.LogManager,com.chinacreator.sysmgrcore.manager.SecurityDatabase,com.chinacreator.sysmgrcore.manager.LogGetNameById"%>
<%@page
	import="java.util.*,com.chinacreator.sqltransition.api.interfaces.IRecursiveQuery,com.chinacreator.sqltransition.api.factorys.RecursiveQueryFactory"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkManagerAccess(request, response);
	boolean tag = true;
	String notice = "ɾ��ʧ�ܣ�����ϵ����Ա��";

	OrgManager orgManager = SecurityDatabase.getOrgManager();
	String orgId = StringUtil
			.replaceNull(request.getParameter("orgId"));
	Organization org = new Organization();
	org.setOrgId(orgId);
	//Organization org = orgManager.getOrgById(orgId);

	//String orgId = org.getOrgId();
	//String parentId = org.getParentId();
	//request.setAttribute("orgId", orgId);
	//request.setAttribute("parentId", parentId);

	//--����־-----
	String operContent = "";
	String operSource = control.getMachinedID();
	String openModle = "��������";
	String userName = control.getUserName();
	String description = "";
	LogManager logManager = SecurityDatabase.getLogManager();
	operContent = userName + " ɾ���˻��� "
			+ LogGetNameById.getOrgNameByOrgId(orgId);
	description = "";
	//--------

	/**
	 * ��ȡ������ѯ ��ʢ 2010-4-27
	 */
	IRecursiveQuery iRecursiveQuery = RecursiveQueryFactory
			.getIRecursiveQueryInstance();
	List list = new ArrayList();
	list = iRecursiveQuery.query("TD_SM_ORGANIZATION",
			new String[] { "ORG_ID" }, "ORG_ID", "=",
			"'" + orgId + "'", "PARENT_ID", "", IRecursiveQuery.DOWN);

	//��ȡ��ǰ�����µ������û���ID
	//String sql = " select distinct b.USER_ID from TD_SM_USERJOBORG b where b.ORG_ID in ( "
	//		+ "select distinct a.ORG_ID from TD_SM_ORGANIZATION a start with a.ORG_ID = '"
	//		+ orgId + "' connect by prior a.ORG_ID = a.PARENT_ID)";

	StringBuffer sql = new StringBuffer();
	sql
			.append("select distinct b.USER_ID from td_sm_orguser b where b.ORG_ID in ('");
	if (null != list) {
		Map map = new HashMap();
		String temporgid = "";
		for (int i = 0; i < list.size(); i++) {
			map = (Map) list.get(i);
			if (null != map) {
		temporgid = (String) map.get("ORG_ID");
		if (null != temporgid && !temporgid.trim().equals("")) {
			sql.append(temporgid);
			if (i != list.size() - 1) {
				sql.append("','");
			}
		}
			}
		}
	}
	sql.append("')");

	//�����û�IDɾ���û���ӵ�е�һ����Դ(����������Ա��)
	UserManager userManager = SecurityDatabase.getUserManager();

	OrgAdministratorImpl orgAdministratorImpl = new OrgAdministratorImpl();

	try {
		DBUtil db = new DBUtil();
		db.executeSelect(sql.toString());
		//���ʹ������ɢ�û���ɾ������ֻ�������µ��û�����Դ�͹�ϵɾ������Ϊ��ɢ�û������û����ɢ�û��������µ��û�����ɾ��
		boolean islisan = ConfigManager.getInstance()
		.getConfigBooleanValue("enableorgusermove", true);

		//�Ƿ����ɾ��
		boolean isdel = true;
		if (db.size() > 0) {
			String[] userIds = new String[db.size()];
			for (int i = 0; i < db.size(); i++) {
		userIds[i] = String.valueOf(db.getInt(i, "USER_ID"));

		//�����ж��߼�
		//��ʢ 2010-9-28

		//�ж��û��Ƿ�Ϊ��������Ա
		if (control.isAdminByUserid(userIds[i])) {
			notice = "������ɾ���������û���"+userManager.getUserById(userIds[i]).getUserRealname()+"["+userIds[i]+"]  Ϊ��������Ա��";
			isdel = false;
			tag = false;
			break;
		}

		//�ж��û��Ƿ�Ϊ���Ź���Ա
		if (orgAdministratorImpl.isOrgManager(userIds[i])) {
			notice = "������ɾ���������û���"+userManager.getUserById(userIds[i]).getUserRealname()+"["+userIds[i]+"]  Ϊ���Ź���Ա��";
			isdel = false;
			tag = false;
			break;
		}

			}
			if (isdel) {
		if (userIds.length > 0) {
			if (islisan) {
				userManager.deleteBatchUserRes(userIds);
			} else {
				userManager.deleteBatchUser(userIds);
			}
		}
			}
		}
		if(isdel){
			//�ݹ�ɾ������
			tag = orgManager.deleteOrg(org);
		}
	} catch (Exception e) {
		tag = false;
		e.printStackTrace();
	}
	if (tag) {
		logManager.log(control.getUserAccount(), operContent,
		openModle, operSource, description);
%>
<script>
			    alert("ɾ���ɹ���");
			    if(parent.parent.win){
			    	parent.parent.win.close();
			    }else if(parent.win){
			    	parent.win.close();
			    }
			    parent.parent.location.href = parent.parent.location.href;
			    parent.parent.parent.location.reload();
			</script>
<%
} else {
%>
<script>
			    alert("<%=notice%>");
			    if(parent.parent.win){
			    	parent.parent.win.close();
			    }else if(parent.win){
			    	parent.win.close();
			    }
			</script>
<%
}
%>
<script>
    
</script>
