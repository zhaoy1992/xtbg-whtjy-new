package com.chinacreator.xtbg.core.common.tree.dao.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.cache.UserCache;
import com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean;
import com.chinacreator.xtbg.core.common.tree.service.impl.TreeDataInfo;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 
 *<p>Title:FileTypeTree.java</p>
 *<p>Description:查询树[档案分类树]</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Jul 15, 2013
 */
public class FileTypeTree extends TreeDataInfo{
	/**
	 * 档案分类管理树的根节点ID
	 */
	public static final String FILE_TYPE_TREE_ROOT_NODE = "Hello World!";
	/**
	 * 树节点前显示的图片(黄色文件夹打开状态)
	 */
	public static final String OPEN_ICON_URL = "../../../../ccapp/oa/resources/plug/ifrom/blue/img/filetypetree_open.gif";
	
	public static final String OPEN_ICON_URL_B = "ccapp/oa/resources/plug/ifrom/blue/img/filetypetree_open.gif";
	private List<Map<String, String>> list = new ArrayList<Map<String, String>>();
	/**
	 * 
	  * <b>Summary:查询树[档案分类树] </b>
	  *     复写方法 getTreeDateInfo
	  * @return 
	 * @throws Exception 
	  * @see com.chinacreator.xtbg.core.common.tree.service.impl.TreeDataInfo#getTreeDateInfo()
	 */
	public Object getTreeDateInfo() throws Exception {
		UserCacheBean userBean= UserCache.getUserCacheBean(accesscontroler.getUserID());
		if(userBean!=null){
			PreparedDBUtil pdb = new PreparedDBUtil();
			String sql1 = "select count(1) countt from OA_FILE_TYPE";
			pdb.preparedSelect(sql1);
			pdb.executePrepared();
			boolean isopen = true;
			if(pdb.size()==1&&pdb.getInt(0,"countt")>1000){
				isopen = false;
			}
			String f_org_id = userBean.getUnit_id();
			String f_type_id = request.getParameter("f_type_id");
			
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT F_TYPE_ID, F_TYPE_NAME, DECODE(F_PARENT_TYPE_ID,'','"+FILE_TYPE_TREE_ROOT_NODE+"',NULL,'"+FILE_TYPE_TREE_ROOT_NODE+"',F_PARENT_TYPE_ID) F_PARENT_TYPE_ID, F_TYPE_REMARK");
			//依据是否有子节点判断
			sql.append("	   ,(SELECT COUNT(1) FROM OA_FILE_TYPE OFYY WHERE OFYY.F_PARENT_TYPE_ID=OFY.F_TYPE_ID AND OFYY.F_ORG_ID = '"+f_org_id+"') COUNTTA");
			//依据类型级别判断
			sql.append("	   ,DECODE(OFY.F_TYPE_LEVEL,1,'1',2,'1',3,'0','0') COUNTTB");
			
			sql.append("   ,p.f_program_id,p.f_program_page,p.f_file_list,p.f_file_detail,p.f_files_list,p.f_files_detail,OFY.f_type_parentname,OFY.f_type_level,f_typeno");
			sql.append("  FROM OA_FILE_TYPE OFY left join oa_file_program_page p ");
			sql.append("  on p.f_program_id=OFY.F_PROGRAM_ID WHERE OFY.F_ORG_ID = '"+f_org_id+"'");
			if(f_type_id!=null){
				sql.append(" START WITH F_PARENT_TYPE_ID='"+f_type_id+"'");
				sql.append(" CONNECT BY PRIOR F_TYPE_ID=F_PARENT_TYPE_ID");
			}
			sql.append(" ORDER BY OFY.F_TYPE_ORDER");
			pdb = new PreparedDBUtil();
			pdb.preparedSelect(sql.toString());
			pdb.executePrepared();
			Map<String,String> tempVal = null;
			for (int i = 0; i < pdb.size(); i++) {
				tempVal = new HashMap<String, String>();
				tempVal.put("id", pdb.getString(i, "F_TYPE_ID"));
				tempVal.put("item_code", pdb.getString(i, "F_TYPE_ID"));
				tempVal.put("f_type_id", pdb.getString(i, "F_TYPE_ID"));
				tempVal.put("name", pdb.getString(i, "F_TYPE_NAME"));
				tempVal.put("parent_id", pdb.getString(i, "F_PARENT_TYPE_ID"));
				tempVal.put("deptType",  pdb.getString(i, "F_TYPE_REMARK"));
				
				tempVal.put("f_program_id",  pdb.getString(i, "F_PROGRAM_ID"));
				tempVal.put("f_program_page",  pdb.getString(i, "F_PROGRAM_PAGE"));
				tempVal.put("f_file_list",  pdb.getString(i, "F_FILE_LIST"));
				tempVal.put("f_file_detail",  pdb.getString(i, "F_FILE_DETAIL"));
				tempVal.put("f_files_list",  pdb.getString(i, "F_FILES_LIST"));
				tempVal.put("f_files_detail",  pdb.getString(i, "F_FILES_DETAIL"));
				
				tempVal.put("f_type_level",  pdb.getString(i, "f_type_level"));
				tempVal.put("f_type_parentname",  pdb.getString(i, "f_type_parentname"));
				tempVal.put("f_typeno",  pdb.getString(i, "f_typeno"));
				
				tempVal.put("open", Boolean.toString(isopen));
				
				if(pdb.getString(i, "COUNTTA").equals("0")&&!pdb.getString(i, "COUNTTB").equals("0")){
					tempVal.put("icon",OPEN_ICON_URL);
				}
				list.add(tempVal);
			}
			if(f_type_id==null){
				//模拟根节点
				tempVal = new HashMap<String, String>();
				tempVal.put("id","Hello World!");
				tempVal.put("item_code", FILE_TYPE_TREE_ROOT_NODE);
				tempVal.put("f_type_id", FILE_TYPE_TREE_ROOT_NODE);
				tempVal.put("name","档案分类");
				tempVal.put("parent_id","");
				tempVal.put("deptType","F_TYPE_REMARK");
				tempVal.put("isParent","true");
				tempVal.put("open", "true");
				
				tempVal.put("f_program_id", "");
				tempVal.put("f_program_page", "");
				tempVal.put("f_file_list", "");
				tempVal.put("f_file_detail", "");
				tempVal.put("f_files_list", "");
				tempVal.put("f_files_detail", "");
				
				tempVal.put("f_type_level", "-1");
				tempVal.put("f_type_parentname", "档案分类");
				tempVal.put("f_typeno", "");
				
				list.add(tempVal);
			}
		}
		if(0 == list.size()){
			return "";
		}
		return list;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* getSonOrg(获得子机构的节点)
	* @param orgId
	* @throws Exception
	 */
	public void getSonOrg(String orgId) throws Exception {
	}

}
