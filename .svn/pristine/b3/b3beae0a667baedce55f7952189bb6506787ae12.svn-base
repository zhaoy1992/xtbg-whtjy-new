package com.chinacreator.xtbg.pub.tree.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSON;
import com.chinacreator.business.common.bean.AuthorityConfig;
import com.chinacreator.business.common.tools.CacheCommonManage;
import com.chinacreator.sysmgrcoreext.manager.IOrgManagerExt;
import com.chinacreator.sysmgrcoreext.manager.bean.UserOrgStatusBean;
import com.chinacreator.sysmgrcoreext.manager.db.OrgManagerExtImpl;
import com.chinacreator.xtbg.core.common.cache.UserCache;
import com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean;
import com.chinacreator.xtbg.pub.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.pub.tree.dao.ModuleTreeDao;
import com.chinacreator.xtbg.pub.tree.entity.ModuleTreeBean;
import com.chinacreator.xtbg.pub.tree.entity.TreeBean;
import com.chinacreator.xtbg.pub.tree.entity.TreeHashMap;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.frameworkset.common.poolman.DBUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:模块树</p>
 *<p>Description:模块树</p> 
 *<p>Company:湖南科创</p>
 *@author weiwei.liu
 *@version 1.0
 *2012-3-13
 */
public class ModuleTreeDaoImpl extends XtDbBaseDao implements ModuleTreeDao {

	private static final Logger LOG = Logger.getLogger(ModuleTreeDaoImpl.class);
	/**
	 * @Description  获得机构树的信息
	 * 
	 * @param map 
	 * @return  
	 * @exception 
	 */
	@Override
	public String getModuleTreeMessage() {
		StringBuffer sql = new StringBuffer();
		StringBuffer sql1 = new StringBuffer();
		sql.append("select t.resources_typeid,");
		sql.append(" r.resources_id, ");
		sql.append(" r.resources_name, ");
		sql.append(" r.resources_logo ");
		sql.append(" from ta_oa_resources_type t ");
		sql.append(" inner join ta_oa_resources r ");
		sql.append(" on r.resources_typeid = t.resources_typeid");
		sql.append(" where  r.resources_typeid= ? ");
		sql.append(" and r.resources_type='1' ");
		sql1.append("select ");
		sql1.append("t.resources_typeid, t.resources_typename ");
		sql1.append("from ta_oa_resources_type t ");
		String str = "";
		List<ModuleTreeBean> moduleList = new ArrayList<ModuleTreeBean>();
		DBUtil dbUtil1 = new DBUtil();
		PreparedDBUtil  db = new PreparedDBUtil ();

		try {
			dbUtil1.executeSelect(sql1.toString());
			for (int i = 0; i < dbUtil1.size(); i++) {
				
				ModuleTreeBean moduleTreeBean1 = new ModuleTreeBean();
				moduleTreeBean1.setName(dbUtil1.getString(i, "resources_typename"));
				moduleTreeBean1.setId(dbUtil1.getString(i, "resources_typeid"));
				moduleTreeBean1.setPpp(Integer.toString(0));
				moduleTreeBean1.setIsParent("true");
				moduleTreeBean1.setOpen("true");
				if(dbUtil1.getString(i, "resources_typeid").equals("1")) {
					moduleTreeBean1.setChecked("true");
				}
//				moduleTreeBean1.setOpen("ture");
				moduleList.add(moduleTreeBean1);
				db.preparedSelect(sql.toString());
				db.setString(1, moduleTreeBean1.getId());
				db.executePrepared();
				for (int j = 0; j < db.size(); j++)  {
					ModuleTreeBean moduleTreeBean = new ModuleTreeBean();
					//moduleTreeBean.setId(moduleTreeBean1.getId()+j);
					moduleTreeBean.setReallyRId(db.getString(j, "resources_id"));
					moduleTreeBean.setName(db.getString(j, "resources_name"));
					moduleTreeBean.setPpp(db.getString(j, "resources_typeid"));
					moduleTreeBean.setResLogo(db.getString(j,"resources_logo"));
					moduleList.add(moduleTreeBean);
				}
			}
			
				str = JSON.toJSONString(moduleList).toString();
		} catch (SQLException e) {
			LOG.error(e);
		}
		return str;
	}
	/**
	 *  同步全展开人员树
	 */
	@Override
	public String getOrgUserTreeMessage() {
		StringBuffer sql = new StringBuffer();
		StringBuffer sql1 = new StringBuffer();
		StringBuffer sql2= new StringBuffer();
		PreparedDBUtil pdb=new PreparedDBUtil();
		PreparedDBUtil pdb1=new PreparedDBUtil();
		PreparedDBUtil pdb2=new PreparedDBUtil();
		String parentId="";
		String str="";
		sql.append(" select a.org_id, a.parent_id, a.org_name ");
		sql.append(" from td_sm_organization a ");
		sql.append(" connect by prior a.org_id = a.parent_id");
		sql.append(" start with a.org_id = ? order by a.org_sn");
		sql1.append(" select u.user_id, t.org_id, u.user_realname, u.user_name");
		sql1.append(" from td_sm_user u ");
		sql1.append(" inner join td_sm_orguser t on t.user_id = u.user_id ");
		sql1.append(" where t.org_id = ? order by u.user_sn");
		sql2.append(" select t.org_id from td_sm_organization t ");
		sql2.append(" where t.parent_id='0' order by t.org_sn");
		List<ModuleTreeBean> orgUserList = new ArrayList<ModuleTreeBean>();
			try {
				pdb2.preparedSelect(sql2.toString());
				pdb2.executePrepared();
				for (int i = 0; i < pdb2.size(); i++) {
					parentId=pdb2.getString(i, "org_id");
				}
				pdb.preparedSelect(sql.toString());
				pdb.setString(1, parentId);
				pdb.executePrepared();
			for (int i = 0; i<pdb.size(); i++) {
				ModuleTreeBean moduleTreeBean=new ModuleTreeBean();
				moduleTreeBean.setName(pdb.getString(i, "org_name"));
				moduleTreeBean.setId(pdb.getString(i, "org_id"));
				moduleTreeBean.setPpp(pdb.getString(i, "parent_id"));
				moduleTreeBean.setOpen("true");
				moduleTreeBean.setIsParent("true");
				orgUserList.add(moduleTreeBean);
				String orgid = moduleTreeBean.getId();
				pdb1.preparedSelect(sql1.toString());
				pdb1.setString(1, orgid);
				pdb1.executePrepared();
				for (int j = 0; j < pdb1.size(); j++) {
					ModuleTreeBean moduleTreeBean1= new ModuleTreeBean();
					moduleTreeBean1.setId(pdb1.getString(j, "user_id"));
					moduleTreeBean1.setPpp(pdb1.getString(j, "org_id"));
					moduleTreeBean1.setName(pdb1.getString(j, "user_realname"));
					moduleTreeBean1.setIcon("../../../resources/images/user_nonFolder.gif");
					orgUserList.add(moduleTreeBean1);
				}
			}
			str = JSON.toJSONString(orgUserList).toString();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		return str;
	}
	
	/**
	 * 机构树
	 */
	public String getOrgTreeMessage() {
		
		List<ModuleTreeBean> list= new ArrayList<ModuleTreeBean>();
		StringBuffer sql = new StringBuffer();
		StringBuffer sql1 = new StringBuffer();
		PreparedDBUtil pdb=new PreparedDBUtil();
		PreparedDBUtil pdb1=new PreparedDBUtil();
		String str="";
		String rootId="";
		 sql.append(" select a.org_id, a.parent_id, a.org_name ");
		 sql.append(" from td_sm_organization a ");
		 sql.append(" connect by prior a.org_id=a.parent_id ");
		 sql.append(" start with a.org_id= ? order by a.org_sn");
		 sql1.append(" select t.org_id from td_sm_organization t ");
		 sql1.append(" where t.parent_id='0' order by t.org_sn");
		try {
			pdb1.preparedSelect(sql1.toString());
			pdb1.executePrepared();
			for (int i = 0; i < pdb1.size(); i++) {
				rootId = pdb1.getString(i, "org_id");
			}
			pdb.preparedSelect(sql.toString());
			pdb.setString(1, rootId);
			pdb.executePrepared();
			for (int i = 0; i < pdb.size(); i++) {
				ModuleTreeBean mTreeBean=new ModuleTreeBean();
				mTreeBean.setId(pdb.getString(i, "org_id"));
				mTreeBean.setPpp(pdb.getString(i, "parent_id"));
				mTreeBean.setName(pdb.getString(i, "org_name"));
				mTreeBean.setOpen("true");
				list.add(mTreeBean);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		str = JSON.toJSONString(list).toString();
		return str;
	}
	

	public String getOrgTreeMessageByUserInfo(Map<String,Object> userInfos) {
		List<ModuleTreeBean> list= new ArrayList<ModuleTreeBean>();
		PreparedDBUtil pdb=new PreparedDBUtil();
		String str="";
		
		try {
			list = getOrgTreeNodesByUserInfos(userInfos, pdb);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		str = JSON.toJSONString(list).toString();
		return str;
	}
	
	/**
	 * 根据用户信息来获取机构树节点集合
	 * @param userInfos
	 */
	public List<ModuleTreeBean> getOrgTreeNodesByUserInfos(Map<String,Object> userInfos,PreparedDBUtil pdb) throws SQLException{
		
		 if("true".equals(userInfos.get("isOrgManager"))){//若果是机构管理员
			 List<UserOrgStatusBean> list = (List<UserOrgStatusBean>)userInfos.get("allOrgList");
			return selectTreeNodesIfOrgManager(userInfos,list,pdb);
		 }else{
			return selectTreeNodesNotOrgManager(pdb);
		 }
	}

	
	
	//private static final String SELECT_RES_ORG_IFMANAGER = "select * from td_sm_organization r connect by prior r.parent_id = r.org_id start with r.org_id = ? order by r.org_sn";
    private static final String SELECT_RES_ORG_IFMANAGER = "select * from td_sm_organization r  connect by prior r.org_id = r.parent_id  start with r.org_id = ?  order by r.org_sn";
	/**
	 * 如果是机构管理员，则传入用户信息进行此查询查询
	 * @param userInfos
	 * @param pdb
	 * @throws SQLException
	 */
	public List<ModuleTreeBean> selectTreeNodesIfOrgManager(Map<String,Object> userInfos,List<UserOrgStatusBean> uOSlist,PreparedDBUtil pdb) throws SQLException{
		List<ModuleTreeBean> list= new ArrayList<ModuleTreeBean>();
		IOrgManagerExt om = new OrgManagerExtImpl();

		 for(UserOrgStatusBean uosBean : uOSlist){
			 /*
 			 * 是否为当前机构管理员
 			 */
			 boolean isCurOrgManager = om.isCurOrgManager(uosBean.getOrgID(),(String)userInfos.get("userId"));
			 if(isCurOrgManager){//判断用户在指定的机构中是否为管理员
					
					pdb.preparedSelect(SELECT_RES_ORG_IFMANAGER);
					int p = 1;
					pdb.setString(p++, uosBean.getOrgID());
					pdb.executePrepared();
					for (int i = 0; i < pdb.size(); i++) {
						ModuleTreeBean mTreeBean=new ModuleTreeBean();
						mTreeBean.setId(pdb.getString(i, "org_id"));
						mTreeBean.setPpp(pdb.getString(i, "parent_id"));
						mTreeBean.setName(pdb.getString(i, "org_name"));
						mTreeBean.setOpen("true");
						list.add(mTreeBean);
					}
			}
		 }
		/*《如果需要向上遍历展开树的所有根节点，则要做排重处理》 
        list = (ArrayList<ModuleTreeBean>)ListUtil.removeDuplicateWithOrder(list);*/
		
		return list;
	}
	
	/**
	 * 如果不是机构管理员，则传入用户信息进行此查询查询
	 * @param pdb
	 * @throws SQLException
	 */
	public List<ModuleTreeBean> selectTreeNodesNotOrgManager(PreparedDBUtil pdb) throws SQLException{
		List<ModuleTreeBean> list= new ArrayList<ModuleTreeBean>();
		StringBuffer sql = new StringBuffer();
		sql.append(" select t.org_id from td_sm_organization t ");
		 sql.append(" where t.parent_id='0' order by t.org_sn");
		 String rootId = "";
		 pdb.preparedSelect(sql.toString());
		 pdb.executePrepared();
		 if(pdb.size() > 0){
			 rootId = pdb.getString(0,0);
		 }
		 sql.setLength(0);
		 sql.append(" select a.org_id, a.parent_id, a.org_name ");
		 sql.append(" from td_sm_organization a ");
		 sql.append(" connect by prior a.org_id=a.parent_id ");
		 sql.append(" start with a.org_id= ? order by a.org_sn");
		 
		 pdb.preparedSelect(sql.toString());
		 pdb.setString(1, rootId);
		 pdb.executePrepared();
		 
		 for (int i = 0; i < pdb.size(); i++) {
				ModuleTreeBean mTreeBean=new ModuleTreeBean();
				mTreeBean.setId(pdb.getString(i, "org_id"));
				mTreeBean.setPpp(pdb.getString(i, "parent_id"));
				mTreeBean.setName(pdb.getString(i, "org_name"));
				mTreeBean.setOpen("true");
				list.add(mTreeBean);
			}
		return list;
	}
	
	private static final String TREE_JSONSQL="select t.tree_jsondata  from ta_oa_resources_config t where t.resources_id=? and t.resources_configtype='2' and t.resources_configtypeid=?";
	private static final String TREE_TYPE_ID = "select tree_type from ta_oa_resources t where t.resources_id=?";
	private static final String TREE_USER="select o.org_id, t.user_id, t.user_name, t.user_realname from (select rownum index_sn, org.org_id, org.org_name from td_sm_organization org start with org.org_id in (select org_id from td_sm_organization cd where cd.parent_id = '0')  connect by prior org.org_id = org.parent_id order siblings by org.org_sn) o left join td_sm_orguser ou on ou.org_id = o.org_id left join td_sm_user t on t.user_id = ou.user_id left join td_sm_userjoborg a  on a.user_id = ou.user_id and ou.org_id = a.org_id where t.user_id is not null and instr((select ',' || ids || ','  from ta_oa_resources_config  where resources_id = ? and resources_configtypeid = ?  and rownum = 1), ',' || t.user_id || ',') > 0 order by to_number(o.index_sn), a.same_job_user_sn, t.user_sn";
	private static final String TREE_ORG ="select * from td_sm_organization org where instr(( select ','||ids||',' from ta_oa_resources_config  where resources_id =? and resources_configtypeid=? and rownum =1),org.org_id)>0 or instr(( select ','||c.tree_jsondata||',' from ta_oa_resources_config c where resources_id =? and resources_configtypeid=? and rownum =1),org.org_id)>0 order by org.org_sn";
	private static final String TREE_DIR_USER="select m.directoryid user_id, m.directoryname user_name,  m.eng_name user_realname, m.orgid org_id, o.org_name from (select rownum index_sn, org.org_id, org.org_name from td_sm_organization org  start with org.org_id in (select org_id  from td_sm_organization b where b.parent_id = '0' and rownum = 1) connect by prior org.org_id = org.parent_id order siblings by org.org_sn) o  left join ta_oa_directory_manage m on m.orgid = o.org_id left join ta_oa_userorderby a on a.user_id = m.directoryid and (o.org_id = a.dept_id) where m.directoryname is not null  and instr((select ',' || ids || ','  from ta_oa_resources_config  where resources_id = ?  and resources_configtypeid = ? and rownum = 1), ','||m.directoryid||',') > 0  order by to_number(o.index_sn), a.orderby, m.directory_sn";
	private static final String TREE_FILE_TYPE="select o.type_id,o.type_name,o.type_desc,o.parent_type_id,o.type_sn from ymj_oa_document_filetype o connect by prior o.type_id=o.parent_type_id start with o.parent_type_id='0' order by o.type_sn";
	//项目阶段 add by shixing.he
	private static final String PROJECT_PHASE ="select project_phase_id, project_phase_name, parent_id, remark, order_no from (select a.project_type_id project_phase_id, a.project_type_name project_phase_name, '' parent_id, a.remark remark, a.order_no order_no from v_wc_project_type a union select b.project_phase_id, b.project_phase_name, b.project_type_id parent_id, b.remark remark, b.order_no order_no from WC_PROJECT_PHASE b where b.is_valid = '1') order by order_no";
	//项目栏目分类 add by shixing.he
	private static final String COLUMN_TYPE ="select column_type_id, column_type_name, parent_id, remark, order_no from (select a.project_type_id column_type_id, a.project_type_name column_type_name, '' parent_id, a.remark remark, a.order_no order_no from v_wc_project_type a union select b.column_type_id, b.column_type_name, b.project_type_id parent_id, b.remark remark, b.order_no order_no from WC_PROJECT_COLUMN_TYPE b where b.is_valid = '1') order by order_no";
	//知识库知识分类   add by jie.xiao
	private static final String ZSK_FLGL ="select o.zsfl_id,o.zsfl_name,o.bz,o.fl_id,o.type_sn from zsfl o where o.zsfl_id not in('5','85','86','83','84','87','21') connect by prior o.zsfl_id=o.fl_id start with o.fl_id='0' order by o.type_sn,o.zsfl_name";
	// 规章制度分类树
	private static final String TREE_REGU_TYPE ="select * from (select type_id, type_name, type_desc, parent_type_id, type_sn, org_id, release_userid, release_username, isshowin_firstpage, keyword from cz_oa_regulations_type r connect	by prior r.type_id = r.parent_type_id start with	r.parent_type_id = '0')	tt #where_condition# order by tt.type_sn";
	//档案类型分类   add by jia.tong
	private static final String TREE_FILES_SORT ="select o.sort_id,o.sort_name,o.sort_notes,o.sort_parent_id,o.sort_sn from files_sort o connect by prior o.sort_id=o.sort_parent_id start with o.sort_parent_id='0' order by to_number(o.sort_sn)";
	private static final String TREE_PERIO_SORT ="select t.periosort_id,t.periosort_name from ta_oa_periosort t where instr(t.periosort_tgorg_id,?)>0";
	
	//培训资料分类   add by jie.xiao
	private static final String TRAINDATA_TYPE="select o.data_type_id,o.data_type_name,o.remark,o.parent_id,o.type_sn from traindata_type o connect by prior o.data_type_id=o.parent_id start with o.parent_id='0' order by o.type_sn";
	//字典分类树 add by jianhua.chen1(陈建华)
	private static final String TREE_DICT_SQL = "select dict_type_id, parent_id, dict_type_name, remark, order_no, is_valid from wc_dict_type where is_valid='1' order by order_no asc, dict_type_name desc";
	//公文传输机构树
	private static final String TREE_GWORG_SQL = "select * from (select o.org_id, o.org_sn, o.org_name, o.parent_id, decode(o.org_name,'地市考试院','remark',o.org_addr) as org_addr from TD_OA_Gw_ORGANIZATION o union select 'gw_orgid',1,'各地市考试院','f9eac58f-52dd-4fbe-bab6-6b61b3e4f975','00000000000000000000' from dual union select r.org_id, r.org_sn, decode(r.remark4, 'A0', '院内部门', r.org_name) org_name, r.parent_id, decode(r.remark4, 'A0', 'remark', r.remark4) from td_sm_organization r union select '1',0,'院内各部门','0802576c-a2fb-4e35-a8e8-79d8e16b79ac','A1' from dual union select '2' as org_id, 2 as org_sn, '各地方高校' as org_name, '0' as parent_id, 'A0' as org_addr from dual) t order by t.org_sn";
	//望城OA-合同管理-合同分类管理 tuo.zou
	private static final String TREE_WC_CONTRACT_TYPE="SELECT CONTRACT_TYPE_ID,DECODE(PARENT_ID,NULL,'HELLO WORLD!','','HELLO WORLD!',PARENT_ID) PARENT_ID,DECODE(D.DICT_NAME ,NULL,CONTRACT_TYPE_NAME,CONTRACT_TYPE_NAME||'('||D.DICT_NAME||')') CONTRACT_TYPE_NAME,  T.REMARK,T.ORDER_NO FROM WC_CONTRACT_TYPE T LEFT JOIN WC_DICT D ON T.FLOW_TYPE=D.DICT_ID ORDER BY ORDER_NO, CONTRACT_TYPE_NAME DESC";
	private static final String TREE_WC_CONTRACT_TYPE_A="SELECT CONTRACT_TYPE_ID,DECODE(PARENT_ID,NULL,'HELLO WORLD!','','HELLO WORLD!',PARENT_ID) PARENT_ID, CONTRACT_TYPE_NAME, REMARK, ORDER_NO FROM WC_CONTRACT_TYPE ORDER BY ORDER_NO, CONTRACT_TYPE_NAME DESC";
	private static final String TREE_WC_CONTRACT_TYPE_FLAG="agreementtypetreeJSP";
	//望城OA-合同管理-对方单位树
	private static final String TREE_WC_TYPE_UNC= "select dict_id business_id,null sup_business_id,dict_name business_name,'' as phone_number,'' as linkman,to_date(sysdate+order_no) as log_time from wc_dict wc where dict_type_id = 'e8fc46c7-1f89-4c12-8c21-6d63f306a6d9' union all  select t.CONTRACT_COMPANY_ID, t.contract_com_type_id, t.CONTRACT_COMPANY_NAME,t.phone_number,t.link_man, t.log_time from WC_CONTRACT_COMPANY t order by log_time desc    ";
	private static final String TREE_WC_CONTRACT_UNC_FLAG="dfdwtreeeJSF";
	//望城城投 工程设计变更与现场签证管理 施工单位树
	public static final String PROJECT_CHANGES_VISA_INFO_SQL_FLAG = "projectchangesvisainfoJSP";
	//贸促会综合办公 短信 选择单位树
	private static final String TREE_MCH_TYPE="select '-1' business_id,'0' sup_business_id,'单位' business_name,'' phone from dual  union all select t.business_id, '-1' sup_business_id,t.business_name,t.phone from MCH_OA_FOREIGN_MERCHANT t where length(t.phone) = '11' and substr(t.phone,0,1)='1' order by business_id";
	//贸促会综合办公 国际商会
	private static final String TREE_MCH_GJSH_TYPE="select '-1' business_id, '0' sup_business_id,'单位' business_name, '' phone  from dual union all select t.organ_id, '-1' sup_business_id, t.organ_name, t.phone  from MCH_OA_INTERNATIONAL_COMMERCE T  where length(t.phone) = '11' and substr(t.phone, 0, 1) = '1' order by business_id";
	//贸促会综合办公  
	private static final String TREE_MCH_HYDW_TYPE="select '-1' business_id, '0' sup_business_id,'单位' business_name, '' phone  from dual union all select T.UNIT_ID, '-1' sup_business_id, t.unit_name, t.phone from MCH_OA_MEMBER_UNIT T where length(t.phone) = '11'  and substr(t.phone, 0, 1) = '1' order by business_id";
	//望城城投 项目阶段环节树
	private static final String PROJECT_PHASE_LINK_SQL = "select t.project_link_id, t.project_link_name, t.parent_id, t.remark, t.order_no from (select a.project_phase_id project_link_id, a.project_phase_name project_link_name, '' parent_id, a.project_phase_name remark, a.order_no order_no from WC_PROJECT_PHASE a where a.project_type_id = ? and a.is_valid = '1' union select b.project_link_id, b.project_link_name, nvl(b.parent_link_id, b.project_phase_id) parent_id, b.project_link_name remark, b.order_no order_no from WC_PROJECT_LINK b, WC_PROJECT_PHASE c where b.project_phase_id = c.project_phase_id and c.project_type_id = ? and b.is_valid = '1' and c.is_valid = '1') t order by t.order_no";
	//望城城投 项目扩展信息树
	private static final String PROJECT_ELSE_COLUMN_SQL = "select t.project_column_id, t.column_name, t.parent_id, t.remark, t.order_no from (select c.column_type_id project_column_id, c.column_type_name column_name, '' parent_id, c.column_type_name remark, c.order_no order_no from WC_PROJECT_COLUMN_TYPE c where c.project_type_id = ? and c.is_valid = '1' union select a.project_column_id, a.column_name, a.column_type_id    parent_id, a.column_name       remark, a.order_no          order_no from WC_PROJECT_COLUMN a, WC_PROJECT_COLUMN_TYPE b where a.column_type_id = b.column_type_id and a.related_year = '0' and b.project_type_id = ? and a.is_valid = '1' and b.is_valid = '1') t order by t.order_no";
	//望城城投 项目年度相关信息树
	private static final String PROJECT_YEAR_COLUMN_SQL = "select t.project_column_id, t.column_name, t.parent_id, t.remark, t.order_no from (select c.column_type_id project_column_id, c.column_type_name column_name, '' parent_id, c.column_type_name remark, c.order_no order_no from WC_PROJECT_COLUMN_TYPE c where c.project_type_id = ? and c.is_valid = '1' union select a.project_column_id, a.column_name, a.column_type_id    parent_id, a.column_name       remark, a.order_no          order_no from WC_PROJECT_COLUMN a, WC_PROJECT_COLUMN_TYPE b where a.column_type_id = b.column_type_id and a.related_year = '1' and b.project_type_id = ? and a.is_valid = '1' and b.is_valid = '1') t order by t.order_no";
	//望城城投 项目年度相关信息树
	private static final String PROJECT_BASE_INFO_SQL = "select t.english_name, t.chinese_name, '' parent_id, t.chinese_name remark, '' order_no from wc_report_project_column t";
	//望城城投 前置工作环节树
	//private static final String PRE_LINK_SQL = "select project_link_id, project_link_name, parent_link_id, order_no from (select t2.project_phase_id project_link_id, t2.project_phase_name project_link_name, '' parent_link_id, t2.order_no from wc_project_phase t, wc_project_phase t2 where t.project_phase_id = ? and t.project_type_id = t2.project_type_id and t2.is_valid = '1' union select a.project_link_id, a.project_link_name, a.project_phase_id, a.order_no from wc_project_link a, wc_project_phase p1, wc_project_phase p2 where p1.project_type_id = p2.project_type_id and a.project_phase_id = p1.project_phase_id and p2.project_phase_id = ? and a.project_link_id != ? and a.parent_link_id is null and a.is_valid = '1' and p1.is_valid = '1' union select a.project_link_id, a.project_link_name, a.parent_link_id, a.order_no from wc_project_link a, wc_project_phase p1, wc_project_phase p2 where p1.project_type_id = p2.project_type_id and a.project_phase_id = p1.project_phase_id and p2.project_phase_id = ? and a.project_link_id != ? and a.parent_link_id is not null and a.is_valid = '1' and p1.is_valid = '1') tt order by tt.order_no";
	private static final String PRE_LINK_SQL = "select project_link_id, project_link_name, parent_link_id, order_no from (select t2.project_phase_id project_link_id, t2.project_phase_name project_link_name, '' parent_link_id, t2.order_no from wc_project_phase t, wc_project_phase t2 where t.project_phase_id = ? and t.project_type_id = t2.project_type_id and t2.is_valid = '1' union select a.project_link_id, a.project_link_name, a.project_phase_id, a.order_no from wc_project_link a, wc_project_phase p1, wc_project_phase p2 where p1.project_type_id = p2.project_type_id and a.project_phase_id = p1.project_phase_id and p2.project_phase_id = ? and a.parent_link_id is null and a.is_valid = '1' and p1.is_valid = '1' union select a.project_link_id, a.project_link_name, a.parent_link_id, a.order_no from wc_project_link a, wc_project_phase p1, wc_project_phase p2 where p1.project_type_id = p2.project_type_id and a.project_phase_id = p1.project_phase_id and p2.project_phase_id = ? and a.parent_link_id is not null and a.is_valid = '1' and p1.is_valid = '1') tt order by tt.order_no";
	//望城城投 实时监督 举报项目树
	private static final String REPORT_PROJECT_SQL = "select t.project_ins_id, t.project_ins_name, 'REPORT_PROJECT_SQL' parent_id from WC_PROJECT_INSTANCE t";
	//望城城投 实时监督 举报项目环节树
	private static final String REPORT_PROJECT_LINK_SQL = "select t.project_type_id link_id,       t.project_type_name link_name,       '' parent_id,       t.order_no  from v_project_type t union select t1.project_phase_id   link_id,       t1.project_phase_name link_name,       t1.project_type_id    parent_id,       t1.order_no  from WC_PROJECT_PHASE t1 where t1.is_valid = '1' union select a.project_link_id   link_id,       a.project_link_name link_name,       a.project_phase_id  parent_id,       a.order_no  from wc_project_link a, wc_project_phase p1, wc_project_phase p2 where p1.project_type_id = p2.project_type_id   and a.project_phase_id = p1.project_phase_id   and a.parent_link_id is null   and a.is_valid = '1'   and p1.is_valid = '1'union select a.project_link_id   link_id,       a.project_link_name link_name,       a.parent_link_id    parent_id,       a.order_no  from wc_project_link a, wc_project_phase p1, wc_project_phase p2 where p1.project_type_id = p2.project_type_id   and a.project_phase_id = p1.project_phase_id   and a.parent_link_id is not null   and a.is_valid = '1'   and p1.is_valid = '1' ";
	//望城城投 风险点  环节树
	private static final String WC_RISK_POINT_LINK="select * from (select t.project_type_id link_id,       t.project_type_name link_name,       '' parent_id,       'project_type' type_num,       t.order_no  from v_project_type t where t.is_valid = '1' union  select t1.project_phase_id   link_id,       t1.project_phase_name link_name,       t1.project_type_id    parent_id,       'project_phase_type' type_num,       t1.order_no  from WC_PROJECT_PHASE t1 where t1.is_valid = '1' union  select a.project_link_id   link_id,       a.project_link_name link_name,       a.project_phase_id  parent_id,       'project_link_type' type_num,       a.order_no  from WC_PROJECT_LINK a, wc_project_phase p1 where a.project_phase_id = p1.project_phase_id   and a.parent_link_id is null   and a.is_valid = '1'   and p1.is_valid = '1' union  select a.project_link_id   link_id,       a.project_link_name link_name,       a.parent_link_id    parent_id,       'project_link_type' type_num,       a.order_no  from wc_project_link a, wc_project_phase p1 where a.project_phase_id = p1.project_phase_id   and a.parent_link_id is not null   and a.is_valid = '1'   and p1.is_valid = '1'  )  tt1 where tt1.link_id not in(select tt2.link_id from wc_risk_point_link tt2 where tt2.risk_point_id <> ? ) order by tt1.order_no";
	
	//怀化公文传输树
	private static final String TREE_HH_GWORG_SQL = "select *   from (select o.org_id, o.org_sn, o.org_name, o.parent_id, o.org_addr    from TD_OA_Gw_ORGANIZATION o   ) t  order by t.org_sn";
	//财政厅公共信息分类树——干教中心(add by 陈建华)
	private static final String TREE_CZT_INFOSORT_SQL = "select sort_id, sort_name, sort_code, decode(parent_id,'0','',null,'',parent_id) parent_id, order_no from czt_info_sort where sort_type = ? and is_valid ='1' order by order_no asc";
	//财政厅 图书管理 分类树
	private static final String TREE_CZT_IBRARY_SQL="select t.tree_id,DECODE(t.tree_parent_id, null, 'HELLO WORLD!', '', 'HELLO WORLD!',t.tree_parent_id) tree_parent_id,t.tree_name,t.remark,tree_type_no,t.tree_type_code,t.order_no,(SELECT COUNT(1) FROM CZT_IBRARYTREE tt WHERE tt.tree_parent_id=t.tree_id ) COUNTTA from CZT_IBRARYTREE t where t.unit_id = ? order by t.tree_type_no,t.order_no";
	//财政厅 出版社树
	private static final String TREE_CZT_PRESS_SQL="select press_id, 'press_id' parent_id,press_name, order_no from czt_press";
	private static final String TREE_CZT_INFO_PULIC_TYPE ="select t.dictdata_name id, t.dictdata_name name,'' parent_id from oa_dict_data t where t.dict_id = ? ";
	//财政厅 模板类型树
	//private static final String TREE_CZT_MODEL_TYPE_SQL="select press_id, 'press_id' parent_id,press_name, order_no from czt_press";
	
	//财政厅资金性质
	private static final String TREE_CZT_CAPITAL_SQL="select t.capital_type, 'capital_type' parent_id,t.capital_name, rownum order_no from tb_capital_type t";
	//财政厅功能分类
	private static final String TREE_CZT_FUN_SQL="select t.fun_class, t.parent_code parent_id,t.fun_name, rownum order_no from tb_fun_class t";
	//财政厅经济分类
	private static final String TREE_CZT_ECO_SQL="select t.e_class, t.parent_code parent_id,t.e_name, rownum order_no from tb_e_class t";
	//财政厅归口处室
	private static final String TREE_CZT_DEPT_SQL="select t.org_id,'org_id' parent_id,t.org_name ,rownum order_no from td_sm_organization t,OA_BUDGET_ORG_USER p where t.org_id = p.org_id and p.user_id = ? ";
	//财政厅拆分单位
	private static final String TREE_CZT_SPLITUNIT_SQL="select t.unit_id, 'unit_id' parent_id,t.unit_name, rownum order_no from oa_split_unit t";
	
	
	//private static final String INFO_PERSON_TREE ="";
	//信息权限机构
	private static final String SELECT_RES_ORG_TYPE = "select * from td_sm_organization order by org_sn";
	//信息权限人员 infopersontree
	private static final String TREE_SELECT_USER_IFMANAGER = " select o.org_id , t.user_id, t.user_name, t.user_realname,t.user_mobiletel1  from (select rownum index_sn, org.org_id, org.org_name from td_sm_organization org  start with org.org_id in (select org_id from td_sm_organization cd  where cd.parent_id = '0') connect by prior org.org_id = org.parent_id order siblings by org.org_sn) o left join td_sm_orguser ou on ou.org_id = o.org_id  left join td_sm_user t on t.user_id=ou.user_id left join td_sm_userjoborg a on a.user_id = ou.user_id and ou.org_id = a.org_id where (t.user_name is not null) and t.user_isvalid != '3' and o.org_id = ? order by to_number(o.index_sn), a.same_job_user_sn, t.user_sn";
	
	//信息人员机构//外部单位idb2fa23cc-9754-4cbe-9627-52d5c74bf9f2
	private static final String SELECT_RES_ORG_PROJECT_INFO_STORAGE = "select distinct tt5.org_id,tt5.org_sn,tt5.org_name,tt5.parent_id from td_sm_organization tt5 start with tt5.parent_id = 'b2fa23cc-9754-4cbe-9627-52d5c74bf9f2' or tt5.org_id = 'b2fa23cc-9754-4cbe-9627-52d5c74bf9f2' connect by prior tt5.org_id = tt5.parent_id order by org_sn";
	//项目信息库 人员机构树projectinfostoragetree
	private static final String TREE_SELECT_USER_PROJECT_INFO_STORAGE = " select distinct * from (select distinct o.org_id , t.user_id, t.user_name, t.user_realname,t.user_mobiletel1,o.org_name  from (select distinct rownum index_sn, org.org_id, org.org_name,org.org_sn from td_sm_organization org  start with org.org_id in (select distinct org_id from td_sm_organization cd  where cd.parent_id = 'b2fa23cc-9754-4cbe-9627-52d5c74bf9f2' or cd.org_id ='b2fa23cc-9754-4cbe-9627-52d5c74bf9f2' )connect by prior org.org_id = org.parent_id order siblings by org.org_sn) o left join td_sm_orguser ou on ou.org_id = o.org_id  left join td_sm_user t on t.user_id=ou.user_id left join td_sm_userjoborg a on a.user_id = ou.user_id and ou.org_id = a.org_id where (t.user_name is not null) and t.user_isvalid != '3' and o.org_id = ? order by to_number(o.index_sn), a.same_job_user_sn, t.user_sn) ";
	//工资基本信息树
	private static final String WC_SALARY_USER_INFO = "select t.english_name, t.chinese_name, '' parent_id, t.chinese_name remark, '' order_no from wc_user_base_info t order by t.ORDER_NO";
	//工资扩展信息树
	private static final String WC_SALARY_BASE_INFO = "select t.english_name, t.chinese_name, '' parent_id, t.chinese_name remark, '' order_no from wc_salary_base_info t order by t.ORDER_NO";
	//工资栏目定义树
	private static final String WC_SALARY_COLUMN = "select column_eng_name, column_chi_name, parent_id, remark, order_no from (select 'ORDER' column_eng_name, '序号' column_chi_name, '' parent_id, '序号' remark, 0 order_no from dual union select t.column_eng_name, t.column_chi_name, '' parent_id, t.column_chi_name remark, t.order_no order_no from wc_salary_column t, wc_salary_column_template t2 where t.TEMPLATE_ID = t2.TEMPLATE_ID and t2.IS_VALID = '1')order by order_no";
	
	//五险一金增加人员机构树
	private static final String SELECT_WXYJ_ORG_TYPE = "select * from td_sm_organization order by org_sn";
	//五险一金增加人员机构树
	private static final String TREE_SELECT_USER_WXYJ_TREE = " select o.org_id , t.user_id, t.user_name, t.user_realname,t.user_mobiletel1  from (select rownum index_sn, org.org_id, org.org_name from td_sm_organization org  start with org.org_id in (select org_id from td_sm_organization cd  where cd.parent_id = '0') connect by prior org.org_id = org.parent_id order siblings by org.org_sn) o left join td_sm_orguser ou on ou.org_id = o.org_id  left join td_sm_user t on t.user_id=ou.user_id left join td_sm_userjoborg a on a.user_id = ou.user_id and ou.org_id = a.org_id where (t.user_name is not null) and t.user_isvalid != '3'    and to_char(t.user_id) not in (select wxyj.user_id from wc_wxyj_info wxyj where wxyj.wxyj_id = ? ) and o.org_id = ? order by to_number(o.index_sn), a.same_job_user_sn, t.user_sn";
	//望城工资编制增加人员机构树
	private static final String SELECT_GZBZ_ORG_TYPE = "select * from td_sm_organization order by org_sn";
	//望城工资编制增加人员机构树
	private static final String TREE_SELECT_USER_GZBZ_TREE = " select o.org_id , t.user_id, t.user_name, t.user_realname,t.user_mobiletel1  from (select rownum index_sn, org.org_id, org.org_name from td_sm_organization org  start with org.org_id in (select org_id from td_sm_organization cd  where cd.parent_id = '0') connect by prior org.org_id = org.parent_id order siblings by org.org_sn) o left join td_sm_orguser ou on ou.org_id = o.org_id  left join td_sm_user t on t.user_id=ou.user_id left join td_sm_userjoborg a on a.user_id = ou.user_id and ou.org_id = a.org_id where (t.user_name is not null) and t.user_isvalid != '3'    and to_char(t.user_id) not in (select i.user_id from wc_salary_info i where i.salary_month_id = ?) and o.org_id = ? order by to_number(o.index_sn), a.same_job_user_sn, t.user_sn";
	
	//特检院    【评审管理】专家人员树 start
	private static final String TREE_SELECT_USER_TJY_REVIEW= "select o.org_id, t.user_id, t.user_name, t.user_realname||'【'||tvm.ru_type||'】'||'【'||tvm.ru_profess||'】' as user_realname, t.user_mobiletel1 from (select rownum index_sn, org.org_id, org.org_name from td_sm_organization org start with org.org_id in (select org_id from td_sm_organization cd where cd.parent_id = '0') connect by prior org.org_id = org.parent_id order siblings by org.org_sn) o left join td_sm_orguser ou on ou.org_id = o.org_id left join td_sm_user t on t.user_id = ou.user_id left join td_sm_userjoborg a on a.user_id = ou.user_id and ou.org_id = a.org_id inner join ta_oa_review_user tvm on t.user_id=tvm.ru_userid where (t.user_name is not null) and o.org_id = ? order by to_number(o.index_sn), a.same_job_user_sn, t.user_sn";
	private static final String TREE_SELECT_ORG_TJY_REVIEW= " select * from td_sm_organization order by org_sn";
	//特检院    【评审管理】专家人员树 end
	
	//特检院    【电子考勤】外部考勤人员树 start
	private static final String TREE_SELECT_USER_TJY_WORKSIDE= "select o.org_id,o.org_name , t.user_id, t.user_name, t.user_realname,t.user_mobiletel1  from (select rownum index_sn, org.org_id, org.org_name from td_sm_organization org  start with org.org_id in (select org_id from td_sm_organization cd  where cd.parent_id = '0')connect by prior org.org_id = org.parent_id order siblings by org.org_sn) o left join td_sm_orguser ou on ou.org_id = o.org_id  left join td_sm_user t on t.user_id=ou.user_id left join td_sm_userjoborg a on a.user_id = ou.user_id and ou.org_id = a.org_id where (t.user_name is not null) and t.user_isvalid != '3' and o.org_id = ? order by to_number(o.index_sn), a.same_job_user_sn, t.user_sn";
	private static final String TREE_SELECT_ORG_TJY_WORKSIDE= " select *   from td_sm_organization r connect by prior r.org_id = r.parent_id  start with r.org_id = ?  order by r.org_sn ";
	//特检院    【电子考勤】外部考勤人员树 end
	
	@Override
	public  Object getTreeJsonValue(TreeBean bean) {

		Map<String, String> request = bean.getRequestMap();
		String type = request.get("type");

		ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
		PreparedDBUtil pdb = new PreparedDBUtil();
		try {
			if(type.indexOf("filetype") != -1){
				//查询出ORG
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
					tempVal.put("type_desc", pdb.getString(i, "type_desc"));
					tempVal.put("type_sn", pdb.getString(i, "type_sn"));
					list.add(tempVal);
				}
			//特检院  当前机构人员树
		} else if(type.indexOf("tree_tjy_workside") != -1){
			pdb.preparedSelect(TREE_SELECT_ORG_TJY_WORKSIDE);
			pdb.setString(1, bean.getOrgID());
			Map<String, String> tempVal = null;
			PreparedDBUtil pdb1 = new PreparedDBUtil();
			pdb.executePrepared();
			for(int i=0; i < pdb.size(); i++){
				tempVal = new HashMap<String, String>();
				tempVal.put("id", pdb.getString(i, "ORG_ID"));
				tempVal.put("item_id", pdb.getString(i, "ORG_ID"));
				tempVal.put("org_id", pdb.getString(i, "ORG_ID"));
				tempVal.put("name", pdb.getString(i, "ORG_NAME"));
				tempVal.put("parent_id", pdb.getString(i, "PARENT_ID"));
				tempVal.put("deptType", pdb.getString(i, "remark4"));
				tempVal.put("open", "true");
				list.add(tempVal);
				pdb1.preparedSelect(TREE_SELECT_USER_TJY_WORKSIDE);
				pdb1.setString(1, pdb.getString(i, "ORG_ID"));
				pdb1.executePrepared();
				for(int j = 0; j < pdb1.size(); j++){
					tempVal = new TreeHashMap<String, String>();
					tempVal.put("id", pdb1.getString(j, "user_id"));
					tempVal.put("user_id", pdb1.getString(j, "user_id"));
					tempVal.put("item_id", pdb1.getString(j, "user_id"));
					tempVal.put("item_code", pdb1.getString(j, "user_name"));
					tempVal.put("name", pdb1.getString(j, "user_realname"));
					tempVal.put("org_id", pdb.getString(i, "org_id"));
					tempVal.put("parent_id", pdb.getString(i, "org_id"));
					tempVal.put("type_desc", pdb1.getString(j, "user_realname"));
					tempVal.put("icon", "ccapp/xtbg/resources/images/user_nonFolder.gif");
					list.add(tempVal);
				}
				
			}
		//公文传输机构树	
		} else if(type.indexOf("gw_organization") != -1){
				//查询出ORG
				pdb.preparedSelect(TREE_GWORG_SQL);
	
				Map<String, String> tempVal = null;
				pdb.executePrepared();
				
				for (int i = 0; i < pdb.size(); i++) {
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "org_id"));
					tempVal.put("item_id", pdb.getString(i, "org_id"));
					tempVal.put("org_id", pdb.getString(i, "org_id"));
					tempVal.put("name", pdb.getString(i, "org_name"));
					tempVal.put("parent_id", pdb.getString(i, "parent_id"));
					tempVal.put("org_addr", pdb.getString(i, "org_addr"));
					tempVal.put("org_sn", pdb.getString(i, "org_sn"));
					String remark = pdb.getString(i, "org_addr");
					if(StringUtil.deNull(remark).equals("remark")){
						tempVal.put("nocheck","true");
					}else {
						tempVal.put("open","true");
					}
					list.add(tempVal);
				}
			}
			//怀化公文传输机构树
			else if(type.indexOf("hh_gworganization") != -1){
				//查询出ORG
				pdb.preparedSelect(TREE_HH_GWORG_SQL);
	
				Map<String, String> tempVal = null;
				pdb.executePrepared();
				
				for (int i = 0; i < pdb.size(); i++) {
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "org_id"));
					tempVal.put("item_id", pdb.getString(i, "org_id"));
					tempVal.put("org_id", pdb.getString(i, "org_id"));
					tempVal.put("name", pdb.getString(i, "org_name"));
					tempVal.put("parent_id", pdb.getString(i, "parent_id"));
					tempVal.put("org_addr", pdb.getString(i, "org_addr"));
					tempVal.put("org_sn", pdb.getString(i, "org_sn"));
					list.add(tempVal);
				}
			}
			else if(type.indexOf("regutype") != -1){ //规章制度类别树
				String userArea=CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");  //获取项目编号
				//查询出ORG
				String isAllShow = request.get("isAllShow");
				if("admin".equals(bean.getUserKey()) || "true".equals(isAllShow)){
					pdb.preparedSelect(TREE_REGU_TYPE.replace("#where_condition#", ""));
				}else{
					//郴州需求，规章制度类别不做权限控制
					if("431000".equals(StringUtil.deNull(userArea))){
						pdb.preparedSelect(TREE_REGU_TYPE.replace("#where_condition#", ""));
					}else{
						pdb.preparedSelect(TREE_REGU_TYPE.replace("#where_condition#", "where tt.release_userid = '"+bean.getUserID()+"'"));
					}
				}
				
				
	
				Map<String, String> tempVal = null;
				pdb.executePrepared();
				
				for (int i = 0; i < pdb.size(); i++) {
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "type_id"));
					tempVal.put("item_id", pdb.getString(i, "type_id"));
					tempVal.put("org_id", pdb.getString(i, "type_id"));
					tempVal.put("name", pdb.getString(i, "type_name"));
					tempVal.put("parent_id", pdb.getString(i, "parent_type_id"));
					tempVal.put("type_desc", pdb.getString(i, "type_desc"));
					tempVal.put("type_sn", pdb.getString(i, "type_sn"));
					tempVal.put("release_userid", pdb.getString(i, "release_userid"));
					tempVal.put("release_username", pdb.getString(i, "release_username"));
					tempVal.put("isshowin_firstpage", pdb.getString(i, "isshowin_firstpage"));
					tempVal.put("keyword", pdb.getString(i, "keyword"));
					list.add(tempVal);
				}
			
			} else if(type.indexOf("files") != -1){ //档案分类树
			
				//查询出ORG
				pdb.preparedSelect(TREE_FILES_SORT);
	
				Map<String, String> tempVal = null;
				pdb.executePrepared();
				
				for (int i = 0; i < pdb.size(); i++) {
					tempVal = new HashMap<String, String>();
					
					tempVal.put("id", pdb.getString(i, "sort_id"));
					tempVal.put("item_id", pdb.getString(i, "sort_id"));
					tempVal.put("org_id", pdb.getString(i, "sort_id"));
					tempVal.put("name", pdb.getString(i, "sort_name"));
					tempVal.put("parent_id", pdb.getString(i, "sort_parent_id"));
					tempVal.put("type_desc", pdb.getString(i, "sort_notes"));
					tempVal.put("type_sn", pdb.getString(i, "sort_sn"));
					//tempVal.put("open","true");
					list.add(tempVal);
				}
				
			} else if(type.indexOf("periosort") != -1){ //期刊类型树
				String orgId = request.get("org_id");
				
				//查询出ORG
				pdb.preparedSelect(TREE_PERIO_SORT);
	            pdb.setString(1, orgId);
				Map<String, String> tempVal = null;
				pdb.executePrepared();
				
				for (int i = 0; i < pdb.size(); i++) {
					tempVal = new HashMap<String, String>();
					
					tempVal.put("id", pdb.getString(i, "periosort_id"));
					tempVal.put("item_id", pdb.getString(i, "periosort_id"));
					tempVal.put("org_id", pdb.getString(i, "periosort_id"));
					tempVal.put("name", pdb.getString(i, "periosort_name"));
					tempVal.put("parent_id", pdb.getString(i, "periosort_id"));
					//tempVal.put("open","true");
					list.add(tempVal);
				}
				
			} else if (type.indexOf("projectphase") != -1){//add by shixing.he 项目管理阶段树
				//查询出ORG
				pdb.preparedSelect(PROJECT_PHASE);
	
				Map<String, String> tempVal = null;
				pdb.executePrepared();
				
				for (int i = 0; i < pdb.size(); i++) {
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "project_phase_id"));
					tempVal.put("item_id", pdb.getString(i, "project_phase_id"));
					tempVal.put("org_id", pdb.getString(i, "project_phase_id"));
					tempVal.put("name", pdb.getString(i, "project_phase_name"));
					tempVal.put("parent_id", pdb.getString(i, "parent_id"));
					tempVal.put("type_desc", pdb.getString(i, "remark"));
					tempVal.put("type_sn", pdb.getString(i, "order_no"));
					list.add(tempVal);
				}
			} else if (type.indexOf("columntype") != -1){//add by shixing.he 项目栏目类型树
				//查询出ORG
				pdb.preparedSelect(COLUMN_TYPE);
	
				Map<String, String> tempVal = null;
				pdb.executePrepared();
				
				for (int i = 0; i < pdb.size(); i++) {
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "column_type_id"));
					tempVal.put("item_id", pdb.getString(i, "column_type_id"));
					tempVal.put("org_id", pdb.getString(i, "column_type_id"));
					tempVal.put("name", pdb.getString(i, "column_type_name"));
					tempVal.put("parent_id", pdb.getString(i, "parent_id"));
					tempVal.put("type_desc", pdb.getString(i, "remark"));
					tempVal.put("type_sn", pdb.getString(i, "order_no"));
					list.add(tempVal);
				}
			} else if (type.indexOf("datatype") != -1){//add by jie.xiao 培训资料分类阶段树
				//查询出ORG
				pdb.preparedSelect(TRAINDATA_TYPE);
	
				Map<String, String> tempVal = null;
				pdb.executePrepared();
				
				for (int i = 0; i < pdb.size(); i++) {
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "data_type_id"));
					tempVal.put("item_id", pdb.getString(i, "data_type_id"));
					tempVal.put("org_id", pdb.getString(i, "data_type_id"));
					tempVal.put("name", pdb.getString(i, "data_type_name"));
					tempVal.put("parent_id", pdb.getString(i, "parent_id"));
					tempVal.put("type_desc", pdb.getString(i, "remark"));
					tempVal.put("type_sn", pdb.getString(i, "type_sn"));
					tempVal.put("open", "true");
					list.add(tempVal);
				}
			}else if (type.indexOf("zskflgl") != -1){//add by jie.xiao 知识库管理阶段树
				//查询出ORG
				pdb.preparedSelect(ZSK_FLGL);
	
				Map<String, String> tempVal = null;
				pdb.executePrepared();
				
				for (int i = 0; i < pdb.size(); i++) {
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "zsfl_id"));
					tempVal.put("item_id", pdb.getString(i, "zsfl_id"));
					tempVal.put("org_id", pdb.getString(i, "zsfl_id"));
					tempVal.put("name", pdb.getString(i, "zsfl_name"));
					tempVal.put("parent_id", pdb.getString(i, "fl_id"));
					tempVal.put("type_desc", pdb.getString(i, "bz"));
					tempVal.put("type_sn", pdb.getString(i, "type_sn"));
				//	if( StringUtil.deNull(pdb.getString(i, "fl_id")).equals("0")){
					//	tempVal.put("open", "true");
					//} else {
						tempVal.put("open", "false");
					//}
					list.add(tempVal);
				}
			} else if(type.indexOf("wc_dict") != -1){ //add by jianhua.chen,数据字典类型树
				pdb.preparedSelect(TREE_DICT_SQL);
	
				Map<String, String> tempVal = null;
				pdb.executePrepared();
				
				for(int i=0; i < pdb.size(); i++){
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "dict_type_id"));
					tempVal.put("item_id", pdb.getString(i, "dict_type_id"));
					tempVal.put("org_id", pdb.getString(i, "dict_type_id"));
					tempVal.put("name", pdb.getString(i, "dict_type_name"));
					tempVal.put("parent_id", pdb.getString(i, "parent_id"));
					tempVal.put("type_desc", pdb.getString(i, "remark"));
					tempVal.put("type_sn", pdb.getString(i, "order_no"));
					tempVal.put("open", "true");
					list.add(tempVal);
				}
			} else if(type.indexOf("czt_press") != -1){ //出版社
				pdb.preparedSelect(TREE_CZT_PRESS_SQL);
				Map<String, String> tempVal = null;
				pdb.executePrepared();
				for(int i=0; i < pdb.size(); i++){
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "press_id"));
					tempVal.put("item_id", pdb.getString(i, "press_id"));
					tempVal.put("org_id", pdb.getString(i, "press_id"));
					tempVal.put("name", pdb.getString(i, "press_name"));
					tempVal.put("parent_id", pdb.getString(i, "parent_id"));
					tempVal.put("type_desc", pdb.getString(i, "press_name"));
					tempVal.put("type_sn", pdb.getString(i, "order_no"));
					tempVal.put("open", "true");
					list.add(tempVal);
				}
				//模拟根节点
				tempVal = new HashMap<String, String>();
				tempVal.put("id", "press_id");
				tempVal.put("item_id", "press_id");
				tempVal.put("org_id", "press_id");
				tempVal.put("name", "出版社");
				tempVal.put("parent_id", "");
				tempVal.put("type_desc", "");
				tempVal.put("nocheck", "true");
				tempVal.put("type_sn", "");
				tempVal.put("open", "true");
				list.add(tempVal);
			}else if(type.indexOf("info_pulic_type_tree") != -1){ //信息公开类型树
				pdb.preparedSelect(TREE_CZT_INFO_PULIC_TYPE);
				Map<String, String> tempVal = null;
				String[] arr = type.split(",");//
				pdb.setString(1, arr[1]);
				pdb.executePrepared();
				for(int i=0; i < pdb.size(); i++){
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "id"));
					tempVal.put("item_id", pdb.getString(i, "id"));
					tempVal.put("org_id", pdb.getString(i, "id"));
					tempVal.put("name", pdb.getString(i, "name"));
					tempVal.put("parent_id", pdb.getString(i, "parent_id"));
					tempVal.put("type_desc", pdb.getString(i, "name"));
					tempVal.put("type_sn", pdb.getString(i, "order_no"));
					tempVal.put("open", "true");
					list.add(tempVal);
				}
				//模拟根节点
				tempVal = new HashMap<String, String>();
				tempVal.put("id", "");
				tempVal.put("item_id", "");
				tempVal.put("org_id", "");
				tempVal.put("name", "信息公开类型");
				tempVal.put("parent_id", "");
				tempVal.put("type_desc", "");
				tempVal.put("nocheck", "true");
				tempVal.put("type_sn", "");
				tempVal.put("open", "true");
				list.add(tempVal);
			}else if(type.indexOf("czt_capital") != -1){ //资金性质
				pdb.preparedSelect(TREE_CZT_CAPITAL_SQL);
				Map<String, String> tempVal = null;
				pdb.executePrepared();
				for(int i=0; i < pdb.size(); i++){
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "capital_type"));
					tempVal.put("item_id", pdb.getString(i, "capital_type"));
					tempVal.put("org_id", pdb.getString(i, "capital_type"));
					tempVal.put("name", pdb.getString(i, "capital_name"));
					tempVal.put("parent_id", pdb.getString(i, "parent_id"));
					tempVal.put("type_desc", pdb.getString(i, "capital_name"));
					tempVal.put("type_sn", pdb.getString(i, "order_no"));
					tempVal.put("open", "true");
					list.add(tempVal);
				}
				//模拟根节点
				tempVal = new HashMap<String, String>();
				tempVal.put("id", "capital_type");
				tempVal.put("item_id", "capital_type");
				tempVal.put("org_id", "capital_type");
				tempVal.put("name", "资金性质");
				tempVal.put("parent_id", "");
				tempVal.put("type_desc", "");
				tempVal.put("nocheck", "true");
				tempVal.put("type_sn", "");
				tempVal.put("open", "true");
				list.add(tempVal);
			}else if(type.indexOf("czt_fun") != -1){ //功能分类
				pdb.preparedSelect(TREE_CZT_FUN_SQL);
				Map<String, String> tempVal = null;
				pdb.executePrepared();
				for(int i=0; i < pdb.size(); i++){
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "fun_class"));
					tempVal.put("item_id", pdb.getString(i, "fun_class"));
					tempVal.put("org_id", pdb.getString(i, "fun_class"));
					tempVal.put("name", pdb.getString(i, "fun_name"));
					tempVal.put("parent_id", pdb.getString(i, "parent_id"));
					tempVal.put("type_desc", pdb.getString(i, "fun_name"));
					tempVal.put("open", "false");
					tempVal.put("type_sn", pdb.getString(i, "order_no"));
					tempVal.put("open", "false");
					list.add(tempVal);
				}
				//模拟根节点
				/*
				tempVal = new HashMap<String, String>();
				tempVal.put("id", "fun_class");
				tempVal.put("item_id", "fun_class");
				tempVal.put("org_id", "fun_class");
				tempVal.put("name", "功能分类");
				tempVal.put("parent_id", "");
				tempVal.put("type_desc", "");
				tempVal.put("nocheck", "true");
				tempVal.put("type_sn", "");
				tempVal.put("open", "true");
				list.add(tempVal);
				*/
			}else if(type.indexOf("czt_eco") != -1){ //经济分类
				pdb.preparedSelect(TREE_CZT_ECO_SQL);
				Map<String, String> tempVal = null;
				pdb.executePrepared();
				for(int i=0; i < pdb.size(); i++){
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "e_class"));
					tempVal.put("item_id", pdb.getString(i, "e_class"));
					tempVal.put("org_id", pdb.getString(i, "e_class"));
					tempVal.put("name", pdb.getString(i, "e_name"));
					tempVal.put("parent_id", pdb.getString(i, "parent_id"));
					tempVal.put("type_desc", pdb.getString(i, "e_name"));
					tempVal.put("type_sn", pdb.getString(i, "order_no"));
					tempVal.put("open", "true");
					list.add(tempVal);
				}
				
			}else if(type.indexOf("czt_dept") != -1){ //归口处室
				String temparr[] = type.split(",");
				
				pdb.preparedSelect(TREE_CZT_DEPT_SQL);
				Map<String, String> tempVal = null;
				pdb.setString(1, temparr[1]);
				pdb.executePrepared();
				for(int i=0; i < pdb.size(); i++){
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "org_id"));
					tempVal.put("item_id", pdb.getString(i, "org_id"));
					tempVal.put("org_id", pdb.getString(i, "org_id"));
					tempVal.put("name", pdb.getString(i, "org_name"));
					tempVal.put("parent_id", pdb.getString(i, "parent_id"));
					tempVal.put("type_desc", pdb.getString(i, "org_name"));
					tempVal.put("type_sn", pdb.getString(i, "order_no"));
					tempVal.put("open", "true");
					list.add(tempVal);
				}
				//模拟根节点
				tempVal = new HashMap<String, String>();
				tempVal.put("id", "org_id");
				tempVal.put("item_id", "org_id");
				tempVal.put("org_id", "org_id");
				tempVal.put("name", "归口处室");
				tempVal.put("parent_id", "");
				tempVal.put("type_desc", "");
				tempVal.put("nocheck", "true");
				tempVal.put("type_sn", "");
				tempVal.put("open", "true");
				list.add(tempVal);
			}else if(type.indexOf("czt_splitunit") != -1){ //拆分单位
				pdb.preparedSelect(TREE_CZT_SPLITUNIT_SQL);
				Map<String, String> tempVal = null;
				pdb.executePrepared();
				for(int i=0; i < pdb.size(); i++){
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "unit_id"));
					tempVal.put("item_id", pdb.getString(i, "unit_id"));
					tempVal.put("org_id", pdb.getString(i, "unit_id"));
					tempVal.put("name", pdb.getString(i, "unit_name"));
					tempVal.put("parent_id", pdb.getString(i, "parent_id"));
					tempVal.put("type_desc", pdb.getString(i, "unit_name"));
					tempVal.put("type_sn", pdb.getString(i, "order_no"));
					tempVal.put("open", "true");
					list.add(tempVal);
				}
				
				tempVal = new HashMap<String, String>();
				tempVal.put("id", "unit_id");
				tempVal.put("item_id", "unit_id");
				tempVal.put("org_id", "unit_id");
				tempVal.put("name", "拆分单位");
				tempVal.put("parent_id", "");
				tempVal.put("type_desc", "");
				tempVal.put("nocheck", "true");
				tempVal.put("type_sn", "");
				tempVal.put("open", "true");
				list.add(tempVal);
				
			}else if(type.indexOf("infopersontree") != -1){ //信息权限人员机构树
				pdb.preparedSelect(SELECT_RES_ORG_TYPE);
				Map<String, String> tempVal = null;
				PreparedDBUtil pdb1 = new PreparedDBUtil();
				pdb.executePrepared();
				for(int i=0; i < pdb.size(); i++){
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "ORG_ID"));
					tempVal.put("item_id", pdb.getString(i, "ORG_ID"));
					tempVal.put("org_id", pdb.getString(i, "ORG_ID"));
					tempVal.put("name", pdb.getString(i, "ORG_NAME"));
					tempVal.put("parent_id", pdb.getString(i, "PARENT_ID"));
					tempVal.put("type_desc", pdb.getString(i, "ORG_NAME"));
					tempVal.put("type_sn", pdb.getString(i, "order_no"));
					tempVal.put("open", "false");
					list.add(tempVal);
					pdb1.preparedSelect(TREE_SELECT_USER_IFMANAGER);
					pdb1.setString(1, pdb.getString(i, "ORG_ID"));
					pdb1.executePrepared();
    				for(int j = 0; j < pdb1.size(); j++){
    					tempVal = new TreeHashMap<String, String>();
    					tempVal.put("id", pdb1.getString(j, "user_id"));
    					tempVal.put("org_id", pdb1.getString(j, "user_id"));
    					tempVal.put("item_id", pdb1.getString(j, "user_id"));
    					tempVal.put("item_code", pdb1.getString(j, "user_name"));
    					tempVal.put("name", pdb1.getString(j, "user_realname"));
    					tempVal.put("parent_id", pdb1.getString(j, "org_id"));
    					tempVal.put("phone_number", pdb1.getString(j, "user_mobiletel1"));
    					tempVal.put("icon", "../../../resources/images/user_nonFolder.gif");
    					list.add(tempVal);
    				}
				}
			} else if(type.indexOf("wxyjtree") != -1){ //五险一金机构树
				pdb.preparedSelect(SELECT_WXYJ_ORG_TYPE);
				Map<String, String> tempVal = null;
				PreparedDBUtil pdb1 = new PreparedDBUtil();
				pdb.executePrepared();
				for(int i=0; i < pdb.size(); i++){
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "ORG_ID"));
					tempVal.put("item_id", pdb.getString(i, "ORG_ID"));
					tempVal.put("org_id", pdb.getString(i, "ORG_ID"));
					tempVal.put("name", pdb.getString(i, "ORG_NAME"));
					tempVal.put("parent_id", pdb.getString(i, "PARENT_ID"));
					tempVal.put("type_desc", pdb.getString(i, "ORG_NAME"));
					tempVal.put("type_sn", pdb.getString(i, "order_no"));
					tempVal.put("is_user", "0");//0不是
					tempVal.put("open", "false");
					list.add(tempVal);
					pdb1.preparedSelect(TREE_SELECT_USER_WXYJ_TREE);
					pdb1.setString(1, type.split(",")[1]);//设置参数，去除已经添加的人员
					pdb1.setString(2, pdb.getString(i, "ORG_ID"));
					pdb1.executePrepared();
    				for(int j = 0; j < pdb1.size(); j++){
    					tempVal = new TreeHashMap<String, String>();
    					tempVal.put("id", pdb1.getString(j, "user_id"));
    					tempVal.put("org_id", pdb1.getString(j, "user_id"));
    					tempVal.put("item_id", pdb1.getString(j, "user_id"));
    					tempVal.put("item_code", pdb1.getString(j, "user_name"));
    					tempVal.put("name", pdb1.getString(j, "user_realname"));
    					tempVal.put("parent_id", pdb.getString(i, "org_id"));
    					tempVal.put("parent_name", pdb.getString(i, "org_name"));
    					tempVal.put("is_user", "1");//1是
    					tempVal.put("phone_number", pdb1.getString(j, "user_mobiletel1"));
    					tempVal.put("icon", "../../../resources/images/user_nonFolder.gif");
    					list.add(tempVal);
    				}
				}
			} else if(type.indexOf("gzbztree") != -1){ //工资编制机构树
				pdb.preparedSelect(SELECT_GZBZ_ORG_TYPE);
				Map<String, String> tempVal = null;
				PreparedDBUtil pdb1 = new PreparedDBUtil();
				pdb.executePrepared();
				for(int i=0; i < pdb.size(); i++){
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "ORG_ID"));
					tempVal.put("item_id", pdb.getString(i, "ORG_ID"));
					tempVal.put("org_id", pdb.getString(i, "ORG_ID"));
					tempVal.put("name", pdb.getString(i, "ORG_NAME"));
					tempVal.put("parent_id", pdb.getString(i, "PARENT_ID"));
					tempVal.put("type_desc", pdb.getString(i, "ORG_NAME"));
					tempVal.put("type_sn", pdb.getString(i, "order_no"));
					tempVal.put("is_user", "0");//0不是
					tempVal.put("open", "false");
					list.add(tempVal);
					pdb1.preparedSelect(TREE_SELECT_USER_GZBZ_TREE);
					pdb1.setString(1, type.split(",")[1]);//设置参数，去除已经添加的人员
					pdb1.setString(2, pdb.getString(i, "ORG_ID"));
					pdb1.executePrepared();
    				for(int j = 0; j < pdb1.size(); j++){
    					tempVal = new TreeHashMap<String, String>();
    					tempVal.put("id", pdb1.getString(j, "user_id"));
    					tempVal.put("org_id", pdb1.getString(j, "user_id"));
    					tempVal.put("item_id", pdb1.getString(j, "user_id"));
    					tempVal.put("item_code", pdb1.getString(j, "user_name"));
    					tempVal.put("name", pdb1.getString(j, "user_realname"));
    					tempVal.put("parent_id", pdb.getString(i, "org_id"));
    					tempVal.put("parent_name", pdb.getString(i, "org_name"));
    					tempVal.put("is_user", "1");//1是
    					tempVal.put("phone_number", pdb1.getString(j, "user_mobiletel1"));
    					tempVal.put("icon", "../../../resources/images/user_nonFolder.gif");
    					list.add(tempVal);
    				}
				}
			} else if(type.indexOf("projectinfostoragetree") != -1){ //项目信息库负责人员机构树
				pdb.preparedSelect(SELECT_RES_ORG_PROJECT_INFO_STORAGE);
				Map<String, String> tempVal = null;
				PreparedDBUtil pdb1 = new PreparedDBUtil();
				pdb.executePrepared();
				for(int i=0; i < pdb.size(); i++){
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "ORG_ID"));
					tempVal.put("item_id", pdb.getString(i, "ORG_ID"));
					tempVal.put("org_id", pdb.getString(i, "ORG_ID"));
					tempVal.put("name", pdb.getString(i, "ORG_NAME"));
					tempVal.put("parent_id", pdb.getString(i, "PARENT_ID"));
					tempVal.put("flag", pdb.getString(i, "org"));//区分机构与人员
					tempVal.put("type_desc", pdb.getString(i, "ORG_NAME"));
					tempVal.put("type_sn", pdb.getString(i, "order_no"));
					tempVal.put("nocheck", "true");
					tempVal.put("open", "false");
					list.add(tempVal);
					pdb1.preparedSelect(TREE_SELECT_USER_PROJECT_INFO_STORAGE);
					pdb1.setString(1, pdb.getString(i, "ORG_ID"));
					pdb1.executePrepared();
    				for(int j = 0; j < pdb1.size(); j++){
    					tempVal = new TreeHashMap<String, String>();
    					tempVal.put("id", pdb1.getString(j, "user_id"));
    					tempVal.put("org_id", pdb1.getString(j, "user_id"));
    					tempVal.put("item_id", pdb1.getString(j, "user_id"));
    					tempVal.put("item_code", pdb1.getString(j, "user_name"));
    					tempVal.put("flag", pdb1.getString(j, "personnel"));//区分机构与人员
    					tempVal.put("name", pdb1.getString(j, "user_realname"));
    					tempVal.put("parent_id", pdb1.getString(j, "org_id"));
    					tempVal.put("phone_number", pdb1.getString(j, "user_mobiletel1"));
    					tempVal.put("linkman", pdb1.getString(j, "org_name")); //linkman 用来存放单位名称
    					tempVal.put("icon", "../../../resources/images/user_nonFolder.gif");
    					list.add(tempVal);
    				}
				}
			}else if(type.indexOf("czt_model_type") != -1){ //财政厅模板类型树
				StringBuffer sql = new StringBuffer();
				sql.append("select t1.model_type_id, t1.model_type_name, t1.order_no, 'model_type' parent_id");
				sql.append("  from czt_model_type t1");
				sql.append(" where t1.is_valid = '1'");
				sql.append(" order by t1.order_no");
				pdb.preparedSelect(sql.toString());
	
				Map<String, String> tempVal = null;
				pdb.executePrepared();
				for(int i=0; i < pdb.size(); i++){
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "model_type_id"));
					tempVal.put("item_id", pdb.getString(i, "model_type_id"));
					tempVal.put("org_id", pdb.getString(i, "model_type_id"));
					tempVal.put("name", pdb.getString(i, "model_type_name"));
					tempVal.put("parent_id", pdb.getString(i, "parent_id"));
					tempVal.put("type_desc", pdb.getString(i, "model_type_name"));
					tempVal.put("type_sn", pdb.getString(i, "order_no"));
					tempVal.put("open", "true");
					list.add(tempVal);
				}
				//模拟根节点
				tempVal = new HashMap<String, String>();
				tempVal.put("id", "model_type");
				tempVal.put("item_id", "model_type");
				tempVal.put("org_id", "model_type");
				tempVal.put("name", "模板类型");
				tempVal.put("parent_id", "");
				tempVal.put("type_desc", "");
				tempVal.put("nocheck", "true");
				tempVal.put("type_sn", "");
				tempVal.put("open", "true");
				list.add(tempVal);
			}else if(type.indexOf("czt_video_type") != -1){ //财政厅视频分类
				StringBuffer sql= new StringBuffer();
				String[] arr = type.split(",");//
				sql.append("select *");
				sql.append("  from oa_video_type  where 1=1  ");
				if("parent".equals(arr[1])){
					sql.append("  and d_type_level='1'  ");
				}else{
					sql.append("  and d_type_level='2'  ");
				}
				//所属机构
				if(!StringUtil.isBlank(arr[2])){
					
					sql.append(" and d_type_unit_id = '"+arr[2]+"'");
				}
				sql.append(" order by d_type_order");
				pdb.preparedSelect(sql.toString());
				pdb.executePrepared();
				Map<String, String> tempVal = null;
				for (int i = 0; i < pdb.size(); i++) {
					tempVal = new HashMap<String, String>();
					//树需要的
					tempVal.put("id", pdb.getString(i, "d_type_id"));
					tempVal.put("org_id", pdb.getString(i, "d_type_id"));
					tempVal.put("item_code", pdb.getString(i, "d_type_id"));
					tempVal.put("p_type_id", pdb.getString(i, "d_type_id"));
					tempVal.put("name", pdb.getString(i, "d_type_name"));
					tempVal.put("parent_id", pdb.getString(i, "d_type_parent_id"));	
					tempVal.put("open", "true");
					tempVal.put("item_id",  pdb.getString(i, "d_type_id"));	
					tempVal.put("deptType", pdb.getString(i, "d_type_id"));	
					
					list.add(tempVal);
				}
				//模拟根节点
				if (0 == list.size()) {
					return "'none'";
				}
				//return list;
			}else if(type.startsWith(TREE_WC_CONTRACT_TYPE_FLAG)){ //add by tuo.zou
				if(type.equals(TREE_WC_CONTRACT_TYPE_FLAG+"1"))
				{ 
					pdb.preparedSelect(TREE_WC_CONTRACT_TYPE_A);
					pdb.executePrepared();
				}else{
					pdb.preparedSelect(TREE_WC_CONTRACT_TYPE);
					pdb.executePrepared();
				}
				for(int i=0; i < pdb.size(); i++){
					Map<String, String> tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "CONTRACT_TYPE_ID"));
					tempVal.put("item_id", pdb.getString(i, "CONTRACT_TYPE_ID"));
					if("HELLO WORLD!".equals(pdb.getString(i, "PARENT_ID"))){
						tempVal.put("org_id","");
					}else{
						tempVal.put("org_id", pdb.getString(i, "CONTRACT_TYPE_ID"));
					}
					tempVal.put("name", pdb.getString(i, "CONTRACT_TYPE_NAME"));
					tempVal.put("parent_id", pdb.getString(i, "PARENT_ID"));
					tempVal.put("type_desc", pdb.getString(i, "REMARK"));
					tempVal.put("type_sn", pdb.getString(i, "ORDER_NO"));
					tempVal.put("open", "true");
					list.add(tempVal);
				}
				//模拟根节点
				Map<String, String> tempVal = new HashMap<String, String>();
				tempVal.put("id", "HELLO WORLD!");
				tempVal.put("item_id", "HELLO WORLD!");
				tempVal.put("org_id", "");
				tempVal.put("name", "合同分类");
				tempVal.put("parent_id", "");
				tempVal.put("type_desc", "");
				tempVal.put("type_sn","");
				tempVal.put("open", "true");
				list.add(tempVal);
			}else if(type.startsWith("TREE_CZT_IBRARY_TYPE")){ 
				String userId = bean.getUserID();
				UserCacheBean userCacheBean = UserCache.getUserCacheBean(userId);
				String unit_id = userCacheBean.getUnit_id();
				pdb.preparedSelect(TREE_CZT_IBRARY_SQL);
				pdb.setString(1, unit_id);
				pdb.executePrepared();
				for(int i=0; i < pdb.size(); i++){
					Map<String, String> tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "tree_id"));
					tempVal.put("item_id", pdb.getString(i, "tree_id"));
					if(!"2".equals(pdb.getString(i, "tree_type_no"))){
						//tempVal.put("nocheck", "true");
						tempVal.put("org_id","");
					}else{
						tempVal.put("org_id", pdb.getString(i, "tree_id"));
					}
					tempVal.put("name", pdb.getString(i, "tree_name"));
					tempVal.put("parent_id", pdb.getString(i, "tree_parent_id"));
					tempVal.put("type_desc", pdb.getString(i, "REMARK"));
					tempVal.put("type_sn", pdb.getString(i, "order_no"));
					tempVal.put("tree_type_no", pdb.getString(i, "tree_type_no"));
					tempVal.put("tree_type_code", pdb.getString(i, "tree_type_code"));
					tempVal.put("open", "true");
					
					if(pdb.getString(i, "COUNTTA").equals("0")&&!pdb.getString(i, "tree_type_no").equals("2")){
						//tempVal.put("icon","../../../../../ccapp/oa/resources/style/blue/images/filetypetree_open.gif");
					}
					list.add(tempVal);
				}
				//模拟根节点
				Map<String, String> tempVal = new HashMap<String, String>();
				tempVal.put("id", "HELLO WORLD!");
				tempVal.put("item_id", "HELLO WORLD!");
				tempVal.put("org_id", "");
				tempVal.put("name", "图书分类");
				tempVal.put("nocheck", "true");
				tempVal.put("parent_id", "");
				tempVal.put("type_desc", "");
				tempVal.put("type_sn","");
				tempVal.put("tree_type_no","0");
				tempVal.put("open", "true");
				list.add(tempVal);
			}else if(type.equals((TREE_WC_CONTRACT_UNC_FLAG))){ //add by tuo.zou
				pdb.preparedSelect(TREE_WC_TYPE_UNC);
				pdb.executePrepared();
				for(int i=0; i < pdb.size(); i++){
					Map<String, String> tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "business_id"));
					tempVal.put("item_id", pdb.getString(i, "business_id"));
					if(StringUtil.nullOrBlank(pdb.getString(i, "sup_business_id"))){
						tempVal.put("org_id","");
					}else{
						tempVal.put("org_id", pdb.getString(i, "business_id"));
					}
					
					tempVal.put("phone_number", pdb.getString(i, "phone_number"));
					tempVal.put("linkman", pdb.getString(i, "linkman"));
					tempVal.put("name", pdb.getString(i, "business_name"));
					tempVal.put("parent_id", pdb.getString(i, "sup_business_id"));
					//tempVal.put("open", "true");
					list.add(tempVal);
				}
			}else if(type.startsWith("mch_zhbg")){ //贸促会综合办公 短信  选择单位树
				String sbutype = type.substring(8);
				if(sbutype.equals("1"))
				{
					pdb.preparedSelect(TREE_MCH_TYPE);
					pdb.executePrepared();
				}else if(sbutype.equals("2")){
					pdb.preparedSelect(TREE_MCH_GJSH_TYPE);
					pdb.executePrepared();
				}else if(sbutype.equals("3")){
					pdb.preparedSelect(TREE_MCH_HYDW_TYPE);
					pdb.executePrepared();
				}
				if(pdb.size()>1){ //父节点 不显示
					for(int i=0; i < pdb.size(); i++){
						Map<String, String> tempVal = new HashMap<String, String>();
						tempVal.put("id", pdb.getString(i, "business_id"));
						tempVal.put("item_id", pdb.getString(i, "business_id"));
						tempVal.put("name", pdb.getString(i, "business_name"));
					if(!pdb.getString(i, "business_id").equals("-1")){  //去掉上级父节点。 避免选择的时候把单位也添加进去。
						tempVal.put("user_id", pdb.getString(i, "business_id"));
					}
						tempVal.put("org_id", pdb.getString(i, "phone"));
						tempVal.put("parent_id", pdb.getString(i, "sup_business_id"));
						tempVal.put("type_sn", pdb.getString(i, "ORDER_NO"));
						tempVal.put("open", "true");
						list.add(tempVal);
					}
				}
			} else if (type.indexOf("ProjectPhaseLinkTree") != -1){//add by shixing.he 项目阶段环节树
				pdb.preparedSelect(PROJECT_PHASE_LINK_SQL);
				String[] arr = type.split("_");
				pdb.setString(1, StringUtil.deNull(arr[0]));
				pdb.setString(2, StringUtil.deNull(arr[0]));
				Map<String, String> tempVal = null;
				pdb.executePrepared();
				
				for (int i = 0; i < pdb.size(); i++) {
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "project_link_id"));
					tempVal.put("item_id", pdb.getString(i, "project_link_id"));
					tempVal.put("org_id", pdb.getString(i, "project_link_id"));
					tempVal.put("name", pdb.getString(i, "project_link_name"));
					if (StringUtil.nullOrBlank(pdb.getString(i, "parent_id"))) {
						tempVal.put("nocheck", "true");
					}
					tempVal.put("parent_id", pdb.getString(i, "parent_id"));
					tempVal.put("type_desc", pdb.getString(i, "remark"));
					tempVal.put("type_sn", pdb.getString(i, "order_no"));
					list.add(tempVal);
				}
			} else if (type.indexOf("ProjectElseColumnTree") != -1){//add by shixing.he 项目扩展信息树
				pdb.preparedSelect(PROJECT_ELSE_COLUMN_SQL);
				String[] arr = type.split("_");
				pdb.setString(1, StringUtil.deNull(arr[0]));
				pdb.setString(2, StringUtil.deNull(arr[0]));
				Map<String, String> tempVal = null;
				pdb.executePrepared();
				for (int i = 0; i < pdb.size(); i++) {
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "project_column_id"));
					tempVal.put("item_id", pdb.getString(i, "project_column_id"));
					tempVal.put("org_id", pdb.getString(i, "project_column_id"));
					tempVal.put("name", pdb.getString(i, "column_name"));
					if (StringUtil.nullOrBlank(pdb.getString(i, "parent_id"))) {
						tempVal.put("nocheck", "true");
					}
					tempVal.put("parent_id", pdb.getString(i, "parent_id"));
					tempVal.put("type_desc", pdb.getString(i, "remark"));
					tempVal.put("type_sn", pdb.getString(i, "order_no"));
					list.add(tempVal);
				}
			} else if (type.indexOf("ProjectYearColumnTree") != -1){//add by shixing.he 项目年度相关信息树
				pdb.preparedSelect(PROJECT_YEAR_COLUMN_SQL);
				String[] arr = type.split("_");
				pdb.setString(1, StringUtil.deNull(arr[0]));
				pdb.setString(2, StringUtil.deNull(arr[0]));
				Map<String, String> tempVal = null;
				pdb.executePrepared();
				for (int i = 0; i < pdb.size(); i++) {
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "project_column_id"));
					tempVal.put("item_id", pdb.getString(i, "project_column_id"));
					tempVal.put("org_id", pdb.getString(i, "project_column_id"));
					tempVal.put("name", pdb.getString(i, "column_name"));
					if (StringUtil.nullOrBlank(pdb.getString(i, "parent_id"))) {
						tempVal.put("nocheck", "true");
					}
					tempVal.put("parent_id", pdb.getString(i, "parent_id"));
					tempVal.put("type_desc", pdb.getString(i, "remark"));
					tempVal.put("type_sn", pdb.getString(i, "order_no"));
					list.add(tempVal);
				}
			} else if (type.indexOf("ProjectBaseInfoTree") != -1){//add by shixing.he 项目基本信息树
				pdb.preparedSelect(PROJECT_BASE_INFO_SQL);
				Map<String, String> tempVal = null;
				pdb.executePrepared();
				for (int i = 0; i < pdb.size(); i++) {
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "english_name"));
					tempVal.put("item_id", pdb.getString(i, "english_name"));
					tempVal.put("org_id", pdb.getString(i, "english_name"));
					tempVal.put("name", pdb.getString(i, "chinese_name"));
					tempVal.put("parent_id", pdb.getString(i, "parent_id"));
					tempVal.put("type_desc", pdb.getString(i, "remark"));
					tempVal.put("type_sn", pdb.getString(i, "order_no"));
					list.add(tempVal);
				}
			} else if (type.indexOf("UserBaseInfoTree") != -1){//add by shixing.he 员工基本信息树
				pdb.preparedSelect(WC_SALARY_USER_INFO);
				Map<String, String> tempVal = null;
				pdb.executePrepared();
				for (int i = 0; i < pdb.size(); i++) {
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "english_name"));
					tempVal.put("item_id", pdb.getString(i, "english_name"));
					tempVal.put("org_id", pdb.getString(i, "english_name"));
					tempVal.put("name", pdb.getString(i, "chinese_name"));
					tempVal.put("parent_id", pdb.getString(i, "parent_id"));
					tempVal.put("type_desc", pdb.getString(i, "remark"));
					tempVal.put("type_sn", pdb.getString(i, "order_no"));
					list.add(tempVal);
				}
			} else if (type.indexOf("SalaryBaseInfoTree") != -1){//add by shixing.he 工资基本信息树
				pdb.preparedSelect(WC_SALARY_BASE_INFO);
				Map<String, String> tempVal = null;
				pdb.executePrepared();
				for (int i = 0; i < pdb.size(); i++) {
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "english_name"));
					tempVal.put("item_id", pdb.getString(i, "english_name"));
					tempVal.put("org_id", pdb.getString(i, "english_name"));
					tempVal.put("name", pdb.getString(i, "chinese_name"));
					tempVal.put("parent_id", pdb.getString(i, "parent_id"));
					tempVal.put("type_desc", pdb.getString(i, "remark"));
					tempVal.put("type_sn", pdb.getString(i, "order_no"));
					list.add(tempVal);
				}
			} else if (type.indexOf("SalaryColumnTree") != -1){//add by shixing.he 工资栏目定义树
				pdb.preparedSelect(WC_SALARY_COLUMN);
				Map<String, String> tempVal = null;
				pdb.executePrepared();
				for (int i = 0; i < pdb.size(); i++) {
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "column_eng_name"));
					tempVal.put("item_id", pdb.getString(i, "column_eng_name"));
					tempVal.put("org_id", pdb.getString(i, "column_eng_name"));
					tempVal.put("name", pdb.getString(i, "column_chi_name"));
					tempVal.put("parent_id", pdb.getString(i, "parent_id"));
					tempVal.put("type_desc", pdb.getString(i, "remark"));
					tempVal.put("type_sn", pdb.getString(i, "order_no"));
					list.add(tempVal);
				}
			}else if (type.indexOf("chooseprelink") != -1){//add by pingan.liu 前置工作环节树
				pdb.preparedSelect(PRE_LINK_SQL);
				Map<String, String> tempVal = null;
				String[] arr = type.split(",");//type = “环节ID，阶段ID，chooseprelink”
				pdb.setString(1, StringUtil.deNull(arr[1]));
				pdb.setString(2, StringUtil.deNull(arr[1]));
				//如果新增环节时环节id为空，则设置为0
//				if(StringUtil.isBlank(StringUtil.deNull(arr[0]))){
//					pdb.setString(3, "0");
//					pdb.setString(4, StringUtil.deNull(arr[1]));
//					pdb.setString(5, "0");
//				} else {
//					pdb.setString(3, StringUtil.deNull(arr[0]));
//					pdb.setString(4, StringUtil.deNull(arr[1]));
//					pdb.setString(5, StringUtil.deNull(arr[0]));
//				}
				//修改人 刘平安 修改时间2013年07月31号，修改为当前环节也是可以展示出来但不是可以选择的。避免了当前环节为父环节的时候，数据展示和项目阶段同根
				pdb.setString(3, StringUtil.deNull(arr[1]));
				pdb.executePrepared();
				for (int i = 0; i < pdb.size(); i++) {
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "project_link_id"));
					tempVal.put("item_id", pdb.getString(i, "project_link_id"));
					tempVal.put("org_id", pdb.getString(i, "project_link_id"));
					tempVal.put("name", pdb.getString(i, "project_link_name"));
					if (StringUtil.nullOrBlank(pdb.getString(i, "parent_link_id")) || StringUtil.deNull(arr[0]).equals((pdb.getString(i, "project_link_id")))) {//如果父类节点为空，设	置属性值为不可选
						tempVal.put("nocheck", "true");
					}
					tempVal.put("parent_id", pdb.getString(i, "parent_link_id"));
					tempVal.put("type_desc", pdb.getString(i, "project_link_name"));
					tempVal.put("type_sn", pdb.getString(i, "order_no"));
					list.add(tempVal);
				}
			} else if (type.indexOf("wc_choosereportproject") != -1){//设置项目选择树
				pdb.preparedSelect(REPORT_PROJECT_SQL);
				Map<String, String> tempVal = null;
				pdb.executePrepared();
				for (int i = 0; i < pdb.size(); i++) {
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "project_ins_id"));
					tempVal.put("item_id", pdb.getString(i, "project_ins_id"));
					tempVal.put("org_id", pdb.getString(i, "project_ins_id"));
					tempVal.put("name", pdb.getString(i, "project_ins_name"));
					
					tempVal.put("parent_id", pdb.getString(i, "parent_id"));
					tempVal.put("type_desc", pdb.getString(i, "project_ins_name"));
					//tempVal.put("type_sn", pdb.getString(i, "order_no"));
					list.add(tempVal);
				}
				//模拟根节点
				tempVal = new HashMap<String, String>();
				tempVal.put("id", "REPORT_PROJECT_SQL");
				tempVal.put("item_id", "REPORT_PROJECT_SQL");
				tempVal.put("org_id", "REPORT_PROJECT_SQL");
				tempVal.put("name", "项目");
				tempVal.put("parent_id", "");
				tempVal.put("type_desc", "REPORT_PROJECT_SQL");
				//tempVal.put("type_sn","");
				tempVal.put("nocheck", "true");
				tempVal.put("open", "true");
				list.add(tempVal);
			} else if (type.indexOf("wc_choose_report_projectlink") != -1){//设置项目环节选择树
				pdb.preparedSelect(REPORT_PROJECT_LINK_SQL);
				Map<String, String> tempVal = null;
				String[] arr = type.split(",");//
				pdb.setString(1, StringUtil.deNull(arr[1]));
				pdb.setString(2, StringUtil.deNull(arr[1]));
				pdb.executePrepared();
				for (int i = 0; i < pdb.size(); i++) {
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "project_link_id"));
					tempVal.put("item_id", pdb.getString(i, "project_link_id"));
					tempVal.put("org_id", pdb.getString(i, "project_link_id"));
					tempVal.put("name", pdb.getString(i, "project_link_name"));
					tempVal.put("parent_id", pdb.getString(i, "parent_id"));
					tempVal.put("type_desc", pdb.getString(i, "project_link_name"));
					tempVal.put("tree_report_user_id",pdb.getString(i, "duty_user_id"));
					tempVal.put("tree_report_user_name",pdb.getString(i, "duty_user_name"));
					tempVal.put("type_sn", pdb.getString(i, "order_no"));
					if (StringUtil.nullOrBlank(pdb.getString(i, "parent_id"))) {//如果父类节点为空，设	置属性值为不可选
						tempVal.put("nocheck", "true");
					}
					list.add(tempVal);
				}
			} else if (type.indexOf("wc_risk_point_link") != -1){//设置风险点项目环节选择树
				pdb.preparedSelect(WC_RISK_POINT_LINK);
				Map<String, String> tempVal = null;
				String[] arr = type.split(",");//
				pdb.setString(1, StringUtil.deNull(arr[1]));
				//pdb.setString(2, StringUtil.deNull(arr[1]));
				pdb.executePrepared();
				for (int i = 0; i < pdb.size(); i++) {
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "link_id"));
					tempVal.put("item_id", pdb.getString(i, "link_id"));
					tempVal.put("org_id", pdb.getString(i, "link_id"));
					tempVal.put("name", pdb.getString(i, "link_name"));
					tempVal.put("parent_id", pdb.getString(i, "parent_id"));
					tempVal.put("type_desc", pdb.getString(i, "link_name"));
					tempVal.put("type_sn", pdb.getString(i, "order_no"));
					tempVal.put("type_num",pdb.getString(i, "type_num"));
					list.add(tempVal);
				}
			} else if(type.indexOf("tree_czt_infosort_type") != -1){
				pdb.preparedSelect(TREE_CZT_INFOSORT_SQL);
				String[] strs = type.split(",");
				pdb.setString(1, strs[1]);//设置类型
				Map<String, String> tempVal = null;
				pdb.executePrepared();
				for (int i = 0; i < pdb.size(); i++) {
					tempVal = new HashMap<String, String>();
					tempVal.put("item_code", pdb.getString(i, "sort_id"));
					tempVal.put("name", pdb.getString(i, "sort_name"));
					tempVal.put("parent_id", pdb.getString(i, "parent_id"));
					tempVal.put("id", pdb.getString(i, "sort_id"));
					tempVal.put("item_id", pdb.getString(i, "sort_id"));
					tempVal.put("org_id", pdb.getString(i, "sort_id"));
					tempVal.put("type_desc", pdb.getString(i, "sort_name"));
					tempVal.put("type_sn", pdb.getString(i, "order_no"));
					tempVal.put("open", "true");
					list.add(tempVal);
				}
				//模拟根节点
				tempVal = new HashMap<String, String>();
				tempVal.put("id", "");
				tempVal.put("item_id", "");
				tempVal.put("item_code", "");
				tempVal.put("org_id", "");
				tempVal.put("name", "信息分类");
				tempVal.put("parent_id", "");
				tempVal.put("type_desc", "");
				tempVal.put("type_sn","");
				tempVal.put("nocheck", "true");
				tempVal.put("open", "true");
				list.add(tempVal);
			//特检院  专家库人员树
			} else if(type.indexOf("tree_tjy_reviewinfo") != -1){
				pdb.preparedSelect(TREE_SELECT_ORG_TJY_REVIEW);
				Map<String, String> tempVal = null;
				PreparedDBUtil pdb1 = new PreparedDBUtil();
				pdb.executePrepared();
				for(int i=0; i < pdb.size(); i++){
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "ORG_ID"));
					tempVal.put("item_id", pdb.getString(i, "ORG_ID"));
					tempVal.put("org_id", pdb.getString(i, "ORG_ID"));
					tempVal.put("name", pdb.getString(i, "ORG_NAME"));
					tempVal.put("parent_id", pdb.getString(i, "PARENT_ID"));
					tempVal.put("deptType", pdb.getString(i, "remark4"));
					tempVal.put("open", "true");
					list.add(tempVal);
					pdb1.preparedSelect(TREE_SELECT_USER_TJY_REVIEW);
					pdb1.setString(1, pdb.getString(i, "ORG_ID"));
					pdb1.executePrepared();
    				for(int j = 0; j < pdb1.size(); j++){
    					tempVal = new TreeHashMap<String, String>();
    					tempVal.put("id", pdb1.getString(j, "user_id"));
    					tempVal.put("user_id", pdb1.getString(j, "user_id"));
						tempVal.put("item_id", pdb1.getString(j, "user_id"));
						tempVal.put("item_code", pdb1.getString(j, "user_name"));
						tempVal.put("name", pdb1.getString(j, "user_realname"));
						tempVal.put("org_id", pdb.getString(i, "org_id"));
						tempVal.put("parent_id", pdb.getString(i, "org_id"));
						tempVal.put("type_desc", pdb1.getString(j, "user_realname"));
						tempVal.put("icon", "ccapp/xtbg/resources/images/user_nonFolder.gif");
    					list.add(tempVal);
    				}
				}
			}else if(type.indexOf(PROJECT_CHANGES_VISA_INFO_SQL_FLAG) != -1){
				queryProjectChangesVisaOrgTree(request,pdb,list);
				//怀化信息上报接收部门全部展开
			} else if(type.indexOf("hh_infosb") != -1){
				//信息上报接收部门展开资源树
				type="117";
				//道先查询出树类型
				String userSql ="";
				pdb.preparedSelect(TREE_TYPE_ID);
				pdb.setString(1, type);
				pdb.executePrepared();
				int treeType = pdb.getInt(0, "tree_type");
				//查询出ORG
				Map<String, AuthorityConfig>  config = CacheCommonManage.getInstance().getAuth();
				if(null != config.get(type) && null != config.get(type).getOrgsql() && !"".equals(config.get(type).getOrgsql())){
					pdb.preparedSelect(config.get(type).getOrgsql());
					int lenght  = config.get(type).getOrgsql().split("[?]").length;
					for(int i = 1;i<lenght;i++){
						pdb.setString(i, bean.getUserID());
					}
				}else{
					pdb.preparedSelect(TREE_ORG);
					pdb.setString(1, type);
					pdb.setString(2, bean.getUserID());
					pdb.setString(3, type);
					pdb.setString(4, bean.getUserID());
				}
				Map<String, String> tempVal = null;
				pdb.executePrepared();
				
				for (int i = 0; i < pdb.size(); i++) {
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "ORG_ID"));
					tempVal.put("item_id", pdb.getString(i, "ORG_ID"));
					tempVal.put("org_id", pdb.getString(i, "ORG_ID"));
					tempVal.put("name", pdb.getString(i, "ORG_NAME"));
					tempVal.put("parent_id", pdb.getString(i, "PARENT_ID"));
					tempVal.put("deptType", pdb.getString(i, "remark4"));
					tempVal.put("open", "true");
					list.add(tempVal);
				}
				if(treeType%2==1){
					
					if (null != config.get(type)&& null != config.get(type).getUsersql() && !"".equals(config.get(type).getUsersql())) {
						userSql = config.get(type).getUsersql();
					} else {

						if ("3".equals(treeType)) {// 人员树
							userSql = TREE_DIR_USER;
						} else {
							userSql = TREE_USER;
						}
						
					}
					pdb.preparedSelect(userSql);
					if (null != config.get(type)&& null != config.get(type).getUsersql() && !"".equals(config.get(type).getUsersql())) {
						int lenght  = config.get(type).getUsersql().split("[?]").length;
						for(int i = 1;i<lenght;i++){
							pdb.setString(i, bean.getUserID());
						}
					} else {
						pdb.setString(1, type);
						pdb.setString(2, bean.getUserID());
					}
					
					pdb.executePrepared();
					for(int i = 0; i < pdb.size(); i++){
						tempVal = new HashMap<String, String>();
						tempVal.put("id", pdb.getString(i, "user_id"));
						tempVal.put("user_id", pdb.getString(i, "user_id"));
						tempVal.put("item_id", pdb.getString(i, "user_id"));
						tempVal.put("item_code", pdb.getString(i, "user_name"));
						tempVal.put("name", pdb.getString(i, "user_realname"));
						tempVal.put("parent_id", pdb.getString(i, "org_id"));
						tempVal.put("icon", "../../../resources/images/user_nonFolder.gif");
						list.add(tempVal);
					}
				}
			}else {
				//道先查询出树类型
				String userSql ="";
				
				pdb.preparedSelect(TREE_TYPE_ID);
				pdb.setString(1, type);
				pdb.executePrepared();
				int treeType = pdb.getInt(0, "tree_type");
				//查询出ORG
				Map<String, AuthorityConfig>  config = CacheCommonManage.getInstance().getAuth();
				if(null != config.get(type) && null != config.get(type).getOrgsql() && !"".equals(config.get(type).getOrgsql())){
					pdb.preparedSelect(config.get(type).getOrgsql());
					int lenght  = config.get(type).getOrgsql().split("[?]").length;
					for(int i = 1;i<lenght;i++){
						pdb.setString(i, bean.getUserID());
					}
				}else{
					pdb.preparedSelect(TREE_ORG);
					pdb.setString(1, type);
					pdb.setString(2, bean.getUserID());
					pdb.setString(3, type);
					pdb.setString(4, bean.getUserID());
				}
				Map<String, String> tempVal = null;
				pdb.executePrepared();
				
				for (int i = 0; i < pdb.size(); i++) {
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "ORG_ID"));
					tempVal.put("item_id", pdb.getString(i, "ORG_ID"));
					tempVal.put("org_id", pdb.getString(i, "ORG_ID"));
					tempVal.put("name", pdb.getString(i, "ORG_NAME"));
					tempVal.put("parent_id", pdb.getString(i, "PARENT_ID"));
					tempVal.put("deptType", pdb.getString(i, "remark4"));
					list.add(tempVal);
				}
				if(treeType%2==1){
					
					if (null != config.get(type)&& null != config.get(type).getUsersql() && !"".equals(config.get(type).getUsersql())) {
						userSql = config.get(type).getUsersql();
					} else {

						if ("3".equals(treeType)) {// 人员树
							userSql = TREE_DIR_USER;
						} else {
							userSql = TREE_USER;
						}
						
					}
					pdb.preparedSelect(userSql);
					if (null != config.get(type)&& null != config.get(type).getUsersql() && !"".equals(config.get(type).getUsersql())) {
						int lenght  = config.get(type).getUsersql().split("[?]").length;
						for(int i = 1;i<lenght;i++){
							pdb.setString(i, bean.getUserID());
						}
					} else {
						pdb.setString(1, type);
						pdb.setString(2, bean.getUserID());
					}
					
					pdb.executePrepared();
					for(int i = 0; i < pdb.size(); i++){
						tempVal = new HashMap<String, String>();
						tempVal.put("id", pdb.getString(i, "user_id"));
						tempVal.put("user_id", pdb.getString(i, "user_id"));
						tempVal.put("item_id", pdb.getString(i, "user_id"));
						tempVal.put("item_code", pdb.getString(i, "user_name"));
						tempVal.put("name", pdb.getString(i, "user_realname"));
						tempVal.put("parent_id", pdb.getString(i, "org_id"));
						tempVal.put("icon", "../../../resources/images/user_nonFolder.gif");
						list.add(tempVal);
					}
				}
			}
			
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	private void queryProjectChangesVisaOrgTree(Map<String, String> request,PreparedDBUtil pdb,
			ArrayList<Map<String, String>> list) throws SQLException{
		StringBuffer sql= new StringBuffer();
		sql.append("SELECT TSO.ORG_ID,					                                     ");	
		sql.append("         TSO.ORG_NAME,                                                   ");
		sql.append("         TSO.PARENT_ID,                                                  ");
		sql.append("         TO_CHAR(WM_CONCAT(TSU.USER_ID)) USER_ID,                        ");
		sql.append("         TO_CHAR(WM_CONCAT(TSU.USER_REALNAME)) USER_REALNAME             ");
		sql.append("    FROM (SELECT *                                                       ");
		sql.append("            FROM TD_SM_ORGANIZATION TSO                                  ");
		sql.append("           START WITH TSO.ORG_ID = ?                                     ");
		sql.append("          CONNECT BY PRIOR TSO.ORG_ID = TSO.PARENT_ID) TSO               ");
		sql.append("    LEFT JOIN TD_SM_USERJOBORG TSUO                                      ");
		sql.append("      ON TSO.ORG_ID = TSUO.ORG_ID                                        ");
		sql.append("    LEFT JOIN TD_SM_USER TSU                                             ");
		sql.append("      ON TSU.USER_ID = TSUO.USER_ID                                      ");
		sql.append("   GROUP BY TSO.ORG_ID, TSO.ORG_NAME, TSO.PARENT_ID                      ");
		pdb.preparedSelect(sql.toString());
		pdb.setString(1, "eb7d2839-2dc0-484f-a34c-c434575a2846");//施工单位
		pdb.executePrepared();
		for (int i = 0; i < pdb.size(); i++) {
			Map<String, String> tempVal = new HashMap<String, String>();
			tempVal.put("id", pdb.getString(i, "ORG_ID"));
			tempVal.put("name", pdb.getString(i, "ORG_NAME"));
			tempVal.put("parent_id", pdb.getString(i, "PARENT_ID"));
			
			tempVal.put("open", "true");
			tempVal.put("org_id", pdb.getString(i, "ORG_ID"));
			tempVal.put("user_id", pdb.getString(i, "USER_ID"));
			tempVal.put("user_realname", pdb.getString(i, "USER_REALNAME"));
			list.add(tempVal);
		}
	}
	
	private static final String TREE_CUSTOM_TYPE="select c.t_id,c.t_name,c.t_desc,c.t_pid,c.t_number,c.t_type from ta_oa_maocuhui_customtype c connect by prior c.t_id=c.t_pid start with c.t_pid='0' order by c.t_number";
	private static final String TREE_PROJECT_TYPE="select c.t_id,c.t_name,c.t_desc,c.t_pid,c.t_number from ta_oa_maocuhui_projecttype c connect by prior c.t_id=c.t_pid start with c.t_pid='0' order by c.t_number";
	public  Object getcustomTreeJsonValue(TreeBean bean) {
		Map<String, String> request = bean.getRequestMap();
		String type = request.get("type");
		ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
		PreparedDBUtil pdb = new PreparedDBUtil();
		try {
			if(type.indexOf("customtype") != -1){
				//查询出ORG
				pdb.preparedSelect(TREE_CUSTOM_TYPE);
	
				Map<String, String> tempVal = null;
				pdb.executePrepared();
				
				for (int i = 0; i < pdb.size(); i++) {
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "t_id"));
					tempVal.put("item_id", pdb.getString(i, "t_id"));
					tempVal.put("org_id", pdb.getString(i, "t_id"));
					tempVal.put("name", pdb.getString(i, "t_name"));
					tempVal.put("parent_id", pdb.getString(i, "t_pid"));
					tempVal.put("t_desc", pdb.getString(i, "t_desc"));
					tempVal.put("t_number", pdb.getString(i, "t_number"));
					tempVal.put("t_type", pdb.getString(i, "t_type"));
					list.add(tempVal);
				}
			}
			
			if(type.indexOf("projecttype") != -1){
				//查询出ORG
				pdb.preparedSelect(TREE_PROJECT_TYPE);
	
				Map<String, String> tempVal = null;
				pdb.executePrepared();
				
				for (int i = 0; i < pdb.size(); i++) {
					tempVal = new HashMap<String, String>();
					tempVal.put("id", pdb.getString(i, "t_id"));
					tempVal.put("item_id", pdb.getString(i, "t_id"));
					tempVal.put("org_id", pdb.getString(i, "t_id"));
					tempVal.put("name", pdb.getString(i, "t_name"));
					tempVal.put("parent_id", pdb.getString(i, "t_pid"));
					tempVal.put("t_desc", pdb.getString(i, "t_desc"));
					tempVal.put("t_number", pdb.getString(i, "t_number"));
					list.add(tempVal);
				}
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return list;
	}
	private static final String TREE_JSONSQL_DEL="delete  ta_oa_group_resources where userid=? and treeid=?";
	private static final String TREE_JSONSQL_INSERT="insert into ta_oa_group_resources(userid,treeid,treejson,selectedids) values(?,?,?,?)";
	private static final String TREE_JSONSQL_UPDATE="update ta_oa_group_resources set selectedids=? where userid=? and treeid=?";
	private static final String TREE_JSONSQL_SELECT="select userid,treeid,treejson,selectedids from ta_oa_group_resources where userid=? and treeid=?";
	
	private static final String TREE_ADMINJSONSQL_SELECT="select decode(group_id,'1','-1',group_id) group_id, group_name, decode(parent_id,'0','1','1','-1',parent_id) parent_id from td_sm_group";
	private static final String TREE_ADMINUSER_SELECT="select wm_concat(t.user_id) user_ids  from td_sm_usergroup t where t.group_id = ?";
	public  Object getTree2JsonValue(TreeBean bean) {
		//Map<String, String>  resp = new HashMap<String, String>();
		String resp ="{'nodes':null}";
		Map<String, String> request = bean.getRequestMap();
		String type = request.get("type");
		
		PreparedDBUtil pdb = new PreparedDBUtil();
		try {
			pdb.preparedSelect(TREE_JSONSQL_SELECT);
			pdb.setString(1, bean.getUserID());
			pdb.setString(2, type);
			pdb.executePrepared();
			for (int i = 0; i < pdb.size();) {
				String jsonString = pdb.getString(0, "treejson");
				if("".equals(jsonString.trim())){
					jsonString="null";
				}
				resp ="{\"nodes\":"+jsonString+","+"\"selectedids\":"+"\""+pdb.getString(0, "selectedids")+"\"}";
				break;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return resp;
	}
   /**
    * 
     * <b>Summary: </b>
     *     复写方法 getTree3JsonValue(根据admin下配置的用户分组生成常用分组josn字符串)
     * @param bean
     * @return 
     * @see com.chinacreator.xtbg.pub.tree.dao.ModuleTreeDao#getTree3JsonValue(com.chinacreator.xtbg.pub.tree.entity.TreeBean)
    */
	public  Object getTree3JsonValue(TreeBean bean) {
		//Map<String, String>  resp = new HashMap<String, String>();
		String resp ="{'nodes':null}";
		PreparedDBUtil pdb = new PreparedDBUtil();
		try {
			pdb.preparedSelect(TREE_ADMINJSONSQL_SELECT);
			pdb.executePrepared();
			//  将查询出来的值  封装成所需的josn字符串形式
			if(pdb.size()>0){
				String jsonString = "[{'org_id':'1','name':'常用分组','parent_id':'0','open':'true'}";
				String selectedids = "";
				for (int i = 0; i < pdb.size();i++) {
					PreparedDBUtil db = new PreparedDBUtil();
					String group_id = pdb.getString(i, "group_id");
					String group_name = pdb.getString(i, "group_name");
					String parent_id = pdb.getString(i, "parent_id");
					db.preparedSelect(TREE_ADMINUSER_SELECT);
					if("-1".equals(group_id)){
						db.setString(1, "1");
					}else{
						db.setString(1, group_id);
					}
					db.executePrepared();
					String ids = "";
					ids = db.getString(0, "user_ids");
					if("".equals(ids.trim())){
						ids = "";
					}
					jsonString += ",{'org_id':'"+group_id+"','name':'"+group_name+"','parent_id':'"+parent_id+"','ids':'"+ids+"','parent_id':'"+parent_id+"','open':'true'}";
				}
				jsonString += "]        ";
				resp ="{\"nodes\":"+jsonString+","+"\"selectedids\":"+"\""+selectedids+"\"}";
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return resp;
	}
	
	public  String getTreeUpdateJsonValue(TreeBean bean) {
		String resp ="'none'";
		Map<String, String> request = bean.getRequestMap();
		String type = request.get("type");
		String selectedids = request.get("ids");
		
		PreparedDBUtil pdb = new PreparedDBUtil();
		try {
			pdb.preparedUpdate(TREE_JSONSQL_UPDATE);
			pdb.setString(1, selectedids);
			pdb.setString(2, bean.getUserID());
			pdb.setString(3, type);
			pdb.executePrepared();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return resp;
	}
	
	public Object getTreeInsertJsonValue(TreeBean bean){
		String resp ="'none'";
		Map<String, String> request = bean.getRequestMap();
		String type = request.get("type");
		String treejson = request.get("treejson");
		String selectedids ="";
		PreparedDBUtil pdb = new PreparedDBUtil();
		try {
			pdb.preparedSelect(TREE_JSONSQL_SELECT);
			pdb.setString(1, bean.getUserID());
			pdb.setString(2, type);
			pdb.executePrepared();
			if(pdb.size() > 0){
				selectedids = pdb.getString(0, "selectedids");
			}
			pdb.preparedDelete(TREE_JSONSQL_DEL);
			pdb.setString(1, bean.getUserID());
			pdb.setString(2, type);
			pdb.executePrepared();
			
			pdb.preparedInsert(TREE_JSONSQL_INSERT);
		
			pdb.setString(1, bean.getUserID());
			pdb.setString(2, type);
			pdb.setString(3, treejson);
			pdb.setString(4, selectedids);
			pdb.executePrepared();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return resp;
	}
	
	//查询范围内的机构
	private static final String SELECT_RANGE_ORG ="select org_id id, org_id item_id, org_id, org_name name, parent_id,remark4 deptType from td_sm_organization r where 1=1 #where_condition# order by r.org_sn";
	//查询范围内的人员
	private static final String SELECT_RANGE_USER ="  select distinct *  from (select 'true' open,  '../../../resources/images/user_nonFolder.gif' icon,  o.org_id parent_id,  t.user_id id,  t.user_id,  t.user_id item_id,  t.user_name item_code,  t.user_realname name,  to_number(o.index_sn) index_sn,  a.same_job_user_sn,  t.user_sn  from (select rownum index_sn, org.org_id, org.org_name  from td_sm_organization org  start with org.org_id in  (select org_id  from td_sm_organization cd  where cd.parent_id = '0')  connect by prior org.org_id = org.parent_id  order siblings by org.org_sn) o  left join td_sm_orguser ou  on ou.org_id = o.org_id  left join td_sm_user t  on t.user_id = ou.user_id  left join td_sm_userjoborg a  on a.user_id = ou.user_id  and ou.org_id = a.org_id  left join ta_oa_flow_wfactuser w  on w.user_id = t.user_id  where (t.user_name is not null)  and t.user_isvalid != '3' #where_condition#  )order by index_sn, same_job_user_sn, user_sn";
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 inqueryTreeUserByRange
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.pub.tree.dao.ModuleTreeDao#inqueryTreeUserByRange(com.chinacreator.xtbg.pub.tree.entity.TreeBean)
	 */
	public Object inqueryTreeUserByRange(TreeBean bean) {
		String action_id = bean.getRequestMap().get("actionid");
		String is_selforg = bean.getRequestMap().get("is_selforg");
		String org_id = bean.getOrgID();
		
		try {
			List<Map<String,String>> list = new ArrayList<Map<String,String>>();
			if(!StringUtil.nullOrBlank(action_id)){
				 //查询本部门的用户
	            if("true".equals(is_selforg)){
	            	list = queryToListMap(SELECT_RANGE_USER.replace("#where_condition#", " and w.action_id = ? and org_id = ?"),action_id,org_id);
	            }else {
	            	list = queryToListMap(SELECT_RANGE_USER.replace("#where_condition#", " and w.action_id = ?"),action_id);
	            }
			
	            if(0 == list.size()){
					return "'none'";
				}
	            String user_ids  ="";
	            //查询本部门的用户
	            if("true".equals(is_selforg)){
	            	 user_ids = queryToSingleMap("select wm_concat(w.user_id) user_ids from ta_oa_flow_wfactuser w ,td_sm_orguser u where w.user_id = u.user_id and u.org_id = '"+org_id+"' and w.action_id = ?", action_id).get("user_ids");
	            } else {
	            	 user_ids = queryToSingleMap("select wm_concat(user_id) user_ids from ta_oa_flow_wfactuser w where w.action_id =?", action_id).get("user_ids");
	            }
	            String org_ids = queryToSingleMap("select wf.getOrgListByUserIdS('"+user_ids+"') org_ids from dual").get("org_ids");
				List<Map<String,String>> orglist = queryToListMap(SELECT_RANGE_ORG.replace("#where_condition#", " and r.org_id in ("+org_ids+")"));
				list.addAll(orglist);
			}else{
				list = queryToListMap(SELECT_RANGE_USER.replace("#where_condition#", ""));
	            if(0 == list.size()){
					return "'none'";
				}
				List<Map<String,String>> orglist = queryToListMap(SELECT_RANGE_ORG.replace("#where_condition#", ""));
				list.addAll(orglist);
			}
			
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getUserIdsByTreeUserOrder
	  * @param userIds
	  * @return 
	  * @see com.chinacreator.xtbg.pub.tree.dao.ModuleTreeDao#getUserIdsByTreeUserOrder(java.lang.String)
	 */
	public String getUserIdsByTreeUserOrder(String userIds) throws Exception{
		StringBuffer sql = new StringBuffer();
		sql.append("select wm_concat(''''||tt.user_id||'''') user_ids from ( ");
		sql.append(SELECT_RANGE_USER.replace("#where_condition#", " and t.user_id in ("+userIds+")"));
		sql.append(") tt");
		return queryToSingleMap(sql.toString()).get("user_ids");
	}
	  
	public static void main(String[] args) { 
		try {
			PreparedDBUtil pdb = new PreparedDBUtil();
			String str  = "wf.parseUserForJyksyIdea('30')";
			pdb.executeSelect("select "+str+".FIRSTUSERREALNAME x1,"+str+".NOFIRSTUSERREALNAMES x2,"+str+".NOZHIDINGUSERREALNAMES x3 from dual");
			if(pdb.size()>0){
				System.out.println("x1:"+pdb.getString(0, "x1"));
				System.out.println("x2:"+pdb.getString(0, "x2"));
				System.out.println("x3:"+pdb.getString(0, "x3"));
			}
		       
		  } catch (Exception e) {
		   e.printStackTrace();
		  }

	} 

	

}
