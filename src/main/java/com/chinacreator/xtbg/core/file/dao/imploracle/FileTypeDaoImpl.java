package com.chinacreator.xtbg.core.file.dao.imploracle;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.sysmgrcore.manager.db.OrgCacheManager;
import com.chinacreator.xtbg.core.common.cache.UserCache;
import com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.file.dao.FileTypeDao;
import com.chinacreator.xtbg.core.file.entity.FilePurviewBean;
import com.chinacreator.xtbg.core.file.entity.FileTypeBean;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * 
 *<p>Title:FileTypeDaoImpl.java</p>
 *<p>Description:档案分类数据访问实现类[ORACLE]</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Jul 16, 2013
 */
public class FileTypeDaoImpl extends XtDbBaseDao implements FileTypeDao {
	
	private static final Logger LOG=Logger.getLogger(FileTypeDaoImpl.class);
	/**
	 * 
	 *<b>Summary: </b>
	 * getFileTypeList(查询档案分类)
	 * @param parmjson
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	@Override
	public PagingBean getFileTypeList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		try {
			if (!StringUtil.isBlank(parmjson)) {
				FileTypeBean bean = (FileTypeBean) JSONObject.parseObject(parmjson, FileTypeBean.class);
				if(!StringUtil.nullOrBlank(bean.getF_org_id())){
					List<String> argList = new ArrayList<String>();
					StringBuffer sql = new StringBuffer();
					sql.append("SELECT F_TYPE_NAME,");
					sql.append("       F_TYPENO,");
					sql.append("       DECODE(F_TYPE_LEVEL,1,'第一层',2,'中间层',3,'最底层','最底层') F_TYPE_LEVEL_NAME,");
					sql.append("       F_TYPE_ADMINNAME,");
					sql.append("       F_PROGRAM_PAGE,");
					sql.append("       F_TYPE_REMARK,");
					sql.append("       F_TYPE_ID,");
					sql.append("       F_PARENT_TYPE_ID");
					sql.append("  FROM OA_FILE_TYPE OFT");
					sql.append(" WHERE OFT.F_ORG_ID = ?");
					argList.add(bean.getF_org_id());
					if(!StringUtil.nullOrBlank(bean.getF_parent_type_id())){
						sql.append("   AND OFT.F_PARENT_TYPE_ID=?");
						argList.add(bean.getF_parent_type_id());
					}else{
						sql.append("   AND OFT.F_PARENT_TYPE_ID IS NULL");
					}
					if(!StringUtil.nullOrBlank(bean.getF_type_name())){
						sql.append("   AND OFT.F_TYPE_NAME LIKE ?");
						argList.add("%"+bean.getF_type_name()+"%");
					}
					sql.append("   ORDER BY OFT.F_TYPE_ORDER");
					
					PagingBean pb = new PagingBean();
					conn = DbManager.getInstance().getConnection();
					pb = queryToPagingBean(sql.toString(),offset,maxPagesize, conn,argList);
					return pb;
				}
			}
			return null;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * getFileTypeBeanById(通过beanId获得Map形式的行数据集合)
	 * @param conn
	 * @param beanId
	 * @return
	 * @throws Exception
	 */
	@Override
	public Map<String, String> getFileTypeBeanById(Connection conn,
			String beanId) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT OFT.*,(SELECT F_TYPE_NAME FROM OA_FILE_TYPE OFTT WHERE OFTT.F_TYPE_ID=OFT.F_PARENT_TYPE_ID) F_PARENT_NAME");
		sql.append("  FROM OA_FILE_TYPE OFT");
		sql.append(" WHERE OFT.F_TYPE_ID = ?");
		return queryToSingleMap(conn, sql.toString(), beanId);
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * getAllParentIdsAndNames(获得beanId和beanId所有父类别的id 和 name)
	 * @param conn
	 * @param beanId
	 * @return
	 * @throws Exception
	 */
	@Override
	public Map<String, String> getAllParentIdsAndNames(Connection conn,
			String beanId) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT TO_CHAR(WM_CONCAT(OFT.F_TYPE_ID)) F_TYPE_ID,");
		//sql.append("       TO_CHAR(WM_CONCAT(OFT.F_TYPE_NAME)) F_TYPE_NAME");
		//防止F_TYPE_NAME中自带[,]号,假如了'!@#$%^&*()'
		sql.append("       REPLACE(REPLACE(TO_CHAR(WM_CONCAT('!@#$%^&*()'||OFT.F_TYPE_NAME)),',!@#$%^&*()','-->'),'!@#$%^&*()','') F_TYPE_NAME");
		sql.append("  FROM (SELECT OFT.F_TYPE_ID, OFT.F_TYPE_NAME");
		sql.append("          FROM OA_FILE_TYPE OFT");
		sql.append("         START WITH OFT.F_TYPE_ID = ?");
		sql.append("        CONNECT BY PRIOR OFT.F_PARENT_TYPE_ID = OFT.F_TYPE_ID");
		sql.append("         ORDER BY ROWNUM DESC) OFT");
		return queryToSingleMap(conn, sql.toString(), beanId);
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * getIsrecursionDataById(通过beanId向上获取可递归的数据,flag:true包括beanId,false:不包括beanId)
	 * 在页面中新增时 无条件获取全部能递归的数据
	 * @param conn
	 * @param beanId
	 * @param flag
	 * @return
	 * @throws Exception
	 */
	@Override
	public Map<String, String[]> getIsrecursionDataById(Connection conn,
			String beanId, boolean flag) throws Exception {
		//String digui = FileTypeBean.IS_RECURSION_YES;
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT 'PAGE' TYPENAME, OFT1.F_PROGRAM_ID ID, OFT1.F_PROGRAM_PAGE VAL");
		sql.append("  FROM (SELECT F_TYPE_ID, F_PROGRAM_ID, F_PROGRAM_PAGE, F_ISRECURSION_PAGE");
		sql.append("          FROM OA_FILE_TYPE");
		sql.append("         START WITH F_TYPE_ID = '"+beanId+"'");
		sql.append("        CONNECT BY PRIOR F_PARENT_TYPE_ID = F_TYPE_ID) OFT1");
		sql.append(" WHERE 1=1");//1=1 以前是 OFT1.F_ISRECURSION_PAGE = '"+digui+"'(无条件递归)
		if(!flag){
			sql.append("   AND OFT1.F_TYPE_ID <> '"+beanId+"'");
		}
		sql.append("   AND ROWNUM = 1");
		sql.append(" UNION ");
		sql.append("SELECT 'ADMIN', OFT2.F_TYPE_ADMIN, OFT2.F_TYPE_ADMINNAME");
		sql.append("  FROM (SELECT F_TYPE_ID,F_TYPE_ADMIN,F_TYPE_ADMINNAME,F_ISRECURSION_ADMIN");
		sql.append("          FROM OA_FILE_TYPE");
		sql.append("         START WITH F_TYPE_ID = '"+beanId+"'");
		sql.append("        CONNECT BY PRIOR F_PARENT_TYPE_ID = F_TYPE_ID) OFT2");
		sql.append(" WHERE 1=1");//OFT2.F_ISRECURSION_ADMIN = '"+digui+"'
		if(!flag){
			sql.append("   AND OFT2.F_TYPE_ID <> '"+beanId+"'");
		}
		sql.append("   AND ROWNUM = 1");
		sql.append(" UNION ");
		sql.append("SELECT 'CONTENT', '', OFT3.F_TEMPLATE_CONTENT");
		sql.append("  FROM (SELECT F_TYPE_ID, F_TEMPLATE_CONTENT, F_ISRECURSION_CONTENT");
		sql.append("          FROM OA_FILE_TYPE");
		sql.append("         START WITH F_TYPE_ID = '"+beanId+"'");
		sql.append("        CONNECT BY PRIOR F_PARENT_TYPE_ID = F_TYPE_ID) OFT3");
		sql.append(" WHERE 1=1");//OFT3.F_ISRECURSION_CONTENT = '"+digui+"'
		if(!flag){
			sql.append("   AND OFT3.F_TYPE_ID <> '"+beanId+"'");
		}
		sql.append("   AND ROWNUM = 1");
		sql.append(" UNION ");
		sql.append("SELECT 'FILE', '', OFT4.F_TEMPLATE_FILE");
		sql.append("  FROM (SELECT F_TYPE_ID, F_TEMPLATE_FILE, F_ISRECURSION_FILE");
		sql.append("          FROM OA_FILE_TYPE");
		sql.append("         START WITH F_TYPE_ID = '"+beanId+"'");
		sql.append("        CONNECT BY PRIOR F_PARENT_TYPE_ID = F_TYPE_ID) OFT4");
		sql.append(" WHERE 1=1");//OFT4.F_ISRECURSION_FILE = '"+digui+"'
		if(!flag){
			sql.append("   AND OFT4.F_TYPE_ID <> '"+beanId+"'");
		}
		sql.append("   AND ROWNUM = 1");
		sql.append(" UNION ");
		sql.append("SELECT 'TABLE', '', OFT5.F_TEMPLATE_RECORD_TABLE");
		sql.append("  FROM (SELECT F_TYPE_ID,F_TEMPLATE_RECORD_TABLE,F_ISRECURSION_RECORD_TABLE");
		sql.append("          FROM OA_FILE_TYPE");
		sql.append("         START WITH F_TYPE_ID = '"+beanId+"'");
		sql.append("        CONNECT BY PRIOR F_PARENT_TYPE_ID = F_TYPE_ID) OFT5");
		sql.append(" WHERE 1=1");//OFT5.F_ISRECURSION_RECORD_TABLE = '"+digui+"'
		if(!flag){
			sql.append("   AND OFT5.F_TYPE_ID <> '"+beanId+"'");
		}
		sql.append("   AND ROWNUM = 1");
		
		sql.append(" UNION ");
		sql.append("SELECT 'FILENO', '', OFT6.F_FILENO_TEMPLATE");
		sql.append("  FROM (SELECT F_TYPE_ID,F_FILENO_TEMPLATE,F_FILENO_TEMPLATE_ISRECURSION");
		sql.append("          FROM OA_FILE_TYPE");
		sql.append("         START WITH F_TYPE_ID = '"+beanId+"'");
		sql.append("        CONNECT BY PRIOR F_PARENT_TYPE_ID = F_TYPE_ID) OFT6");
		sql.append(" WHERE 1=1");//OFT6.F_FILENO_TEMPLATE_ISRECURSION = '"+digui+"'
		if(!flag){
			sql.append("   AND OFT6.F_TYPE_ID <> '"+beanId+"'");
		}
		sql.append("   AND ROWNUM = 1");
		PreparedDBUtil pdb = new PreparedDBUtil();// 初始化数据库连接
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared(conn);
		Map<String, String[]> map = new HashMap<String, String[]>();
		for (int j = 0; j < pdb.size(); j++) {
			map.put(pdb.getString(j, "TYPENAME"), new String[]{pdb.getString(j, "ID"),pdb.getString(j, "VAL")});
		}
		return map;
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * updateChildrenDataByBean(修改bean的所有直接点的递归数据)
	 * @param bean
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	@Override
	public boolean updateChildrenDataByBean(FileTypeBean bean, Connection conn)
			throws Exception {
		if(FileTypeBean.F_TYPE_LEVEL_THREE.equals(bean.getF_type_level())){
			return true;
		}
		//0:通过bean.getF_type_id()子孙节点组成的树结构,然后通过CONNECT BY PRIOR...OFT.F_PAGE_BY_ISRE=1将部分分支节点去除
		PreparedDBUtil pdb = new PreparedDBUtil();// 初始化数据库连接
		int i = -1;
		StringBuffer sql = null;
		//1:PAGE
		if(FileTypeBean.IS_RECURSION_YES.equals(bean.getF_isrecursion_page())){
			sql = new StringBuffer();
			sql.append("UPDATE OA_FILE_TYPE");
			sql.append("   SET OA_FILE_TYPE.F_PROGRAM_ID = ?,OA_FILE_TYPE.F_PROGRAM_PAGE=?");
			sql.append(" WHERE OA_FILE_TYPE.F_TYPE_ID IN");
			sql.append("       (SELECT OFT1.F_TYPE_ID");
			sql.append("          FROM (SELECT OFT.F_TYPE_ID");
			sql.append("                  FROM OA_FILE_TYPE OFT");
			sql.append("                 START WITH OFT.F_TYPE_ID = ?");
			sql.append("                CONNECT BY PRIOR OFT.F_TYPE_ID = OFT.F_PARENT_TYPE_ID");
			sql.append("                ) OFT1");//AND OFT.F_PAGE_BY_ISRE = ?) OFT1
			sql.append("         WHERE OFT1.F_TYPE_ID <> ?)");
			pdb.preparedUpdate(sql.toString());
			i = 1;
			pdb.setString(i++, bean.getF_program_id());
			pdb.setString(i++, bean.getF_program_page());
			pdb.setString(i++, bean.getF_type_id());
			//pdb.setString(i++, FileTypeBean.IS_RECURSION_YES);
			pdb.setString(i++, bean.getF_type_id());
			pdb.executePrepared(conn);
		}
		//2:ADMIN
		if(FileTypeBean.IS_RECURSION_YES.equals(bean.getF_isrecursion_admin())){
			sql = new StringBuffer();
			sql.append("UPDATE OA_FILE_TYPE");
			sql.append("   SET OA_FILE_TYPE.F_TYPE_ADMIN = ?,OA_FILE_TYPE.F_TYPE_ADMINNAME=?");
			sql.append(" WHERE OA_FILE_TYPE.F_TYPE_ID IN");
			sql.append("       (SELECT OFT1.F_TYPE_ID");
			sql.append("          FROM (SELECT OFT.F_TYPE_ID");
			sql.append("                  FROM OA_FILE_TYPE OFT");
			sql.append("                 START WITH OFT.F_TYPE_ID = ?");
			sql.append("                CONNECT BY PRIOR OFT.F_TYPE_ID = OFT.F_PARENT_TYPE_ID");
			sql.append("                ) OFT1");//AND OFT.F_PAGE_BY_ISRE = ?) OFT1
			sql.append("         WHERE OFT1.F_TYPE_ID <> ?)");
			pdb.preparedUpdate(sql.toString());
			i = 1;
			pdb.setString(i++, bean.getF_type_admin());
			pdb.setString(i++, bean.getF_type_adminname());
			pdb.setString(i++, bean.getF_type_id());
			//pdb.setString(i++, FileTypeBean.IS_RECURSION_YES);
			pdb.setString(i++, bean.getF_type_id());
			pdb.executePrepared(conn);
		}
		
		//3:CONTENT
		if(FileTypeBean.IS_RECURSION_YES.equals(bean.getF_isrecursion_admin())){
			sql = new StringBuffer();
			sql.append("UPDATE OA_FILE_TYPE");
			sql.append("   SET OA_FILE_TYPE.F_TEMPLATE_CONTENT = ?");
			sql.append(" WHERE OA_FILE_TYPE.F_TYPE_ID IN");
			sql.append("       (SELECT OFT1.F_TYPE_ID");
			sql.append("          FROM (SELECT OFT.F_TYPE_ID");
			sql.append("                  FROM OA_FILE_TYPE OFT");
			sql.append("                 START WITH OFT.F_TYPE_ID = ?");
			sql.append("                CONNECT BY PRIOR OFT.F_TYPE_ID = OFT.F_PARENT_TYPE_ID");
			sql.append("                ) OFT1");//AND OFT.F_PAGE_BY_ISRE = ?) OFT1
			sql.append("         WHERE OFT1.F_TYPE_ID <> ?)");
			pdb.preparedUpdate(sql.toString());
			i = 1;
			pdb.setString(i++, bean.getF_template_content());
			pdb.setString(i++, bean.getF_type_id());
			//pdb.setString(i++, FileTypeBean.IS_RECURSION_YES);
			pdb.setString(i++, bean.getF_type_id());
			pdb.executePrepared(conn);
		}
		//4:FILE
		if(FileTypeBean.IS_RECURSION_YES.equals(bean.getF_isrecursion_file())){
			sql = new StringBuffer();
			sql.append("UPDATE OA_FILE_TYPE");
			sql.append("   SET OA_FILE_TYPE.F_TEMPLATE_FILE = ?");
			sql.append(" WHERE OA_FILE_TYPE.F_TYPE_ID IN");
			sql.append("       (SELECT OFT1.F_TYPE_ID");
			sql.append("          FROM (SELECT OFT.F_TYPE_ID");
			sql.append("                  FROM OA_FILE_TYPE OFT");
			sql.append("                 START WITH OFT.F_TYPE_ID = ?");
			sql.append("                CONNECT BY PRIOR OFT.F_TYPE_ID = OFT.F_PARENT_TYPE_ID");
			sql.append("                ) OFT1");//AND OFT.F_PAGE_BY_ISRE = ?) OFT1
			sql.append("         WHERE OFT1.F_TYPE_ID <> ?)");
			pdb.preparedUpdate(sql.toString());
			i = 1;
			pdb.setString(i++, bean.getF_template_file());
			pdb.setString(i++, bean.getF_type_id());
			//pdb.setString(i++, FileTypeBean.IS_RECURSION_YES);
			pdb.setString(i++, bean.getF_type_id());
			pdb.executePrepared(conn);
		}
		//5:TABLE
		if(FileTypeBean.IS_RECURSION_YES.equals(bean.getF_isrecursion_record_table())){
			sql = new StringBuffer();
			sql.append("UPDATE OA_FILE_TYPE");
			sql.append("   SET OA_FILE_TYPE.F_TEMPLATE_RECORD_TABLE = ?");
			sql.append(" WHERE OA_FILE_TYPE.F_TYPE_ID IN");
			sql.append("       (SELECT OFT1.F_TYPE_ID");
			sql.append("          FROM (SELECT OFT.F_TYPE_ID");
			sql.append("                  FROM OA_FILE_TYPE OFT");
			sql.append("                 START WITH OFT.F_TYPE_ID = ?");
			sql.append("                CONNECT BY PRIOR OFT.F_TYPE_ID = OFT.F_PARENT_TYPE_ID");
			sql.append("                ) OFT1");//AND OFT.F_PAGE_BY_ISRE = ?) OFT1
			sql.append("         WHERE OFT1.F_TYPE_ID <> ?)");
			pdb.preparedUpdate(sql.toString());
			i = 1;
			pdb.setString(i++, bean.getF_template_record_table());
			pdb.setString(i++, bean.getF_type_id());
			//pdb.setString(i++, FileTypeBean.IS_RECURSION_YES);
			pdb.setString(i++, bean.getF_type_id());
			pdb.executePrepared(conn);
		}
		//5:FILENO
		if(FileTypeBean.IS_RECURSION_YES.equals(bean.getF_fileno_template_isrecursion())){
			sql = new StringBuffer();
			sql.append("UPDATE OA_FILE_TYPE");
			sql.append("   SET OA_FILE_TYPE.F_FILENO_TEMPLATE = ?");
			sql.append(" WHERE OA_FILE_TYPE.F_TYPE_ID IN");
			sql.append("       (SELECT OFT1.F_TYPE_ID");
			sql.append("          FROM (SELECT OFT.F_TYPE_ID");
			sql.append("                  FROM OA_FILE_TYPE OFT");
			sql.append("                 START WITH OFT.F_TYPE_ID = ?");
			sql.append("                CONNECT BY PRIOR OFT.F_TYPE_ID = OFT.F_PARENT_TYPE_ID");
			sql.append("                ) OFT1");//AND OFT.F_PAGE_BY_ISRE = ?) OFT1
			sql.append("         WHERE OFT1.F_TYPE_ID <> ?)");
			pdb.preparedUpdate(sql.toString());
			i = 1;
			pdb.setString(i++, bean.getF_fileno_template());
			pdb.setString(i++, bean.getF_type_id());
			//pdb.setString(i++, FileTypeBean.IS_RECURSION_YES);
			pdb.setString(i++, bean.getF_type_id());
			pdb.executePrepared(conn);
		}
		return true;
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * deleteFileTypeBeansById(通过beanId删除以beanId节点为根节点的树结构数据上的所有FileTypeBean[包含beanId])
	 * @param conn
	 * @param beanId
	 * @return
	 * @throws Exception
	 */
	@Override
	public boolean deleteFileTypeBeansById(Connection conn, String beanId)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("DELETE FROM OA_FILE_TYPE");
		sql.append(" WHERE F_TYPE_ID IN");
		sql.append("       (SELECT F_TYPE_ID");
		sql.append("          FROM OA_FILE_TYPE OFT");
		sql.append("         START WITH OFT.F_TYPE_ID = ?");
		sql.append("        CONNECT BY PRIOR OFT.F_TYPE_ID = OFT.F_PARENT_TYPE_ID)");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, beanId);
		pdb.executePrepared(conn);
		return true;
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * getBKBAllParam(获得备考表参数集合)
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<Map<String, String>> getBKBAllParam(Connection conn) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT *");
		sql.append("  FROM OA_DICT_DATA ODD");
		sql.append(" WHERE ODD.DICT_ID = '"+FileTypeBean.BKB_DICT_ID+"'");
		sql.append("   AND ODD.DICTDATA_VALUE IS NOT NULL");
		sql.append("   AND ODD.DICTDATA_NAME IS NOT NULL");
		sql.append(" ORDER BY ODD.DICTDATA_ORDER");
		return queryToListMap(sql.toString(),conn, new ArrayList<String>());
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 checkFileTypeRoleOfUser
	 * @param userId
	 * @param fileDocBeanId
	 * @param conn
	 * @return 
	 * @see com.chinacreator.xtbg.core.file.dao.FileTypeDao#checkFileTypeRoleOfUser(java.lang.String, java.lang.String, java.sql.Connection)
	 */
	@Override
	public Boolean[] checkFileTypeRoleOfUser(String userId,
			String fileDocBeanId, Connection conn) {
		boolean read = false;
		boolean download = false;
		StringBuffer logMess = new StringBuffer();
		StringBuffer sqll = new StringBuffer();
		sqll.append("SELECT COUNT(1) COUNTT");
		sqll.append("  FROM TD_SM_USER TSU");
		sqll.append(" WHERE (TSU.USER_ID IN");
		sqll.append("       (SELECT USER_ID");
		sqll.append("           FROM TD_SM_USERGROUP");
		sqll.append("          WHERE GROUP_ID IN (SELECT * FROM TABLE(SPLIT(?)))) OR");
		sqll.append("       TSU.USER_ID IN");
		sqll.append("       (SELECT USER_ID");
		sqll.append("           FROM TD_SM_USERROLE");
		sqll.append("          WHERE ROLE_ID IN");
		sqll.append("                (SELECT ROLE_ID");
		sqll.append("                   FROM TD_SM_GROUPROLE");
		sqll.append("                  WHERE GROUP_ID IN (SELECT * FROM TABLE(SPLIT(?))))))");
		sqll.append("   AND TSU.USER_ID = ?");
		try{
			UserCacheBean userBean= UserCache.getUserCacheBean(userId);
			logMess.append("检查[USER:"+userId+"]的档案RD权限:");
			if(userBean!=null){
				StringBuffer sql = new StringBuffer();
				sql.append("SELECT OFP.*, OFD.F_ORG_ID, OFD.F_DEPT_ID");
				sql.append("  FROM OA_FILE_DOC OFD");
				sql.append("  LEFT JOIN OA_FILE_PURVIEW OFP");
				sql.append("    ON OFD.F_TYPE_ID = OFP.F_TYPE_ID");
				sql.append("   AND OFD.F_SECRECY_ID = OFP.F_SECRECY_ID");
				sql.append(" WHERE OFD.F_DOC_ID = ?");
				List<Map<String, String>> list = queryToListMap(sql.toString(),conn,fileDocBeanId);
				if(list.size()==1){
					Map<String, String> map = list.get(0);
					//1:检查read 权限
					//1.1
					String f_read_all_user = map.get("f_read_all_user");
					if(FilePurviewBean.CAN_DO.equals(f_read_all_user)){
						String f_org_id = map.get("f_org_id");
						if(f_org_id!=null&&f_org_id.equals(userBean.getUnit_id())){
							logMess.append("[read:所有人[OK]]");
							read = true;
						}
					}
					//1.2
					if(!read){
						String f_read_dept_user = map.get("f_read_dept_user");
						if(FilePurviewBean.CAN_DO.equals(f_read_dept_user)){
							String f_dept_id = map.get("f_dept_id");
							if(f_dept_id!=null&&f_dept_id.equals(userBean.getOrg_id())){
								logMess.append("[read:本部门[OK]]");
								read = true;
							}
						}
						//1.3
						if(!read){
							String f_read_user_groupid = map.get("f_read_user_groupid");
							if(f_read_user_groupid!=null&&f_read_user_groupid.length()>0){
								List<Map<String, String>> listTwo = queryToListMap(sqll.toString(),conn,f_read_user_groupid,f_read_user_groupid,userId);
								if(listTwo.size()==1){
									if(!"0".equals(listTwo.get(0).get("countt"))){
										logMess.append("[read:用户组[OK]]");
										read = true;
									}
								}
							}
						}
					}
					
					//2:检查download 权限
					//2.1
					String f_download_all_user = map.get("f_download_all_user");
					if(FilePurviewBean.CAN_DO.equals(f_download_all_user)){
						String f_org_id = map.get("f_org_id");
						if(f_org_id!=null&&f_org_id.equals(userBean.getUnit_id())){
							logMess.append("[download:所有人[OK]]");
							download = true;
						}
					}
					//2.2
					if(!download){
						String f_download_dept_user = map.get("f_download_dept_user");
						if(FilePurviewBean.CAN_DO.equals(f_download_dept_user)){
							String f_dept_id = map.get("f_dept_id");
							if(f_dept_id!=null&&f_dept_id.equals(userBean.getOrg_id())){
								logMess.append("[download:本部门[OK]]");
								download = true;
							}
						}
						//2.3
						if(!download){
							String f_download_user_groupid = map.get("f_download_user_groupid");
							if(f_download_user_groupid!=null&&f_download_user_groupid.length()>0){
								List<Map<String, String>> listTwo = queryToListMap(sqll.toString(),conn,f_download_user_groupid,f_download_user_groupid,userId);
								if(listTwo.size()==1){
									if(!"0".equals(listTwo.get(0).get("countt"))){
										logMess.append("[download:用户组[OK]]");
										download = true;
									}
								}
							}
						}
					}
				}else{
					//=0:文档不存在;>1:OA_FILE_PURVIEW档案分类权限表数据重复
					logMess.append("[DB DATA ERROR]");
				}
			}else{
				logMess.append("[获取UserCache失败]");
			}
			
		}catch(Exception e){
			LOG.error(e.getMessage(), e);
			logMess.append("[Exception]");
		}
		if(!read){
			logMess.append("[read:[NO]]");
		}
		if(!download){
			logMess.append("[download:[NO]]");
		}
		LOG.info(logMess);
		return new Boolean[]{read,download};
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 getDHAllParam
	 * @param conn
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.file.dao.FileTypeDao#getDHAllParam(java.sql.Connection)
	 */
	@Override
	public List<Map<String, String>> getDHAllParam(Connection conn)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("select *");
		sql.append(" from OA_DICT_DATA odd");
		sql.append(" where dict_id in");
		sql.append(" (select dict_id from OA_DICT_TYPE where dict_code = 'dadhmbcs')");
		return queryToListMap(sql.toString(),conn, new ArrayList<String>());
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 checkFileTypeRoleOfUserAboutLending
	 * @param userId
	 * @param fileDocBeanId
	 * @param conn
	 * @return 
	 * @see com.chinacreator.xtbg.core.file.dao.FileTypeDao#checkFileTypeRoleOfUserAboutLending(java.lang.String, java.lang.String, java.sql.Connection)
	 */
	@Override
	public Boolean[] checkFileTypeRoleOfUserAboutLending(String userId,
			String fileDocBeanId, Connection conn){
		boolean read = false;
		boolean download = false;
		StringBuffer sql = new StringBuffer();
		//防止多条数据的存在，获取最大值
		sql.append("select decode (max(ofld.f_read_approve),null,'0',max(ofld.f_read_approve)) f_read_approve");//1:只阅读，2可下载 0,不同意or无数据
		sql.append("  from oa_file_lending_detail ofld");
		sql.append(" where ofld.f_lending_userid = '"+userId+"'");//人
		sql.append("   and ofld.f_islending = '1'");//已借阅
		sql.append("   and (ofld.f_isback = '0' or (ofld.F_REBACK_TIME is not null and ofld.F_REBACK_TIME<sysdate))");//未归还 或者 计划归还时间 小于当天
		sql.append("   and ofld.f_doc_id = '"+fileDocBeanId+"'");//文档ID
		
		try{
			List<Map<String, String>> list = queryToListMap(sql.toString(),conn, new ArrayList<String>());
			if(list.size()==1){
				Map<String, String> map = list.get(0);
				String f_read_all_user = map.get("f_read_approve");//以批准的借阅权限为准
				if("1".equals(f_read_all_user)){
					read = true;
				}else if("2".equals(f_read_all_user)){
					read = true;
					download = true;
				}
			}
		}catch(Exception e){
			LOG.error(e.getMessage(), e);
		}
		return new Boolean[]{read,download};
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 checkChildrenNode
	 * @param deleteArr
	 * @param conn
	 * @return 
	 * @see com.chinacreator.xtbg.core.file.dao.FileTypeDao#checkChildrenNode(java.lang.String[], java.sql.Connection)
	 */
	@Override
	public boolean checkChildrenNode(String[] deleteArr, Connection conn) {
		boolean flag = true;
		StringBuffer delIds = new StringBuffer();
		if(deleteArr!=null&&deleteArr.length>0){
			for (String str : deleteArr) {
				delIds.append(",'"+str+"'");
			}
		}
		if(delIds.length()>0){
			try {
				String sql ="select count(1) countt from oa_file_type where f_parent_type_id in ("+delIds.substring(1)+")";
				PreparedDBUtil pdb = new PreparedDBUtil();
				pdb.preparedSelect(sql.toString());
				pdb.executePrepared(conn);
				if(pdb.size()==1){
					if("0".equals(pdb.getString(0, "countt"))){
						flag = false;
					}
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		return flag;
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 checkUsedData
	 * @param deleteArr
	 * @param conn
	 * @return 
	 * @see com.chinacreator.xtbg.core.file.dao.FileTypeDao#checkUsedData(java.lang.String[], java.sql.Connection)
	 */
	@Override
	public boolean checkUsedData(String[] deleteArr, Connection conn) {
		boolean flag = true;
		StringBuffer delIds = new StringBuffer();
		if(deleteArr!=null&&deleteArr.length>0){
			for (String str : deleteArr) {
				delIds.append(",'"+str+"'");
			}
		}
		if(delIds.length()>0){
			try {
				StringBuffer sql = new StringBuffer();
				sql.append("select (select count(1) from oa_file_doc where f_type_id in ("+delIds.substring(1)+")) +");
				sql.append("       (select count(1) from oa_file_files where f_type_id in ("+delIds.substring(1)+")) countt");
				sql.append("  from dual");
				PreparedDBUtil pdb = new PreparedDBUtil();
				pdb.preparedSelect(sql.toString());
				pdb.executePrepared(conn);
				if(pdb.size()==1){
					if("0".equals(pdb.getString(0, "countt"))){
						flag = false;
					}
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		return flag;
	}
	/**
	 * 更新全表的OA_FILE_TYPE.F_TYPE_PARENTNAME字段,
	 * SQL缺陷：如果分类名称中出现,会有问题
	 * <b>Summary: </b>
	 *     复写方法 updateChildrenDataFieldByBean
	 * @param bean
	 * @param conn
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.file.dao.FileTypeDao#updateChildrenDataFieldByBean(com.chinacreator.xtbg.core.file.entity.FileTypeBean, java.sql.Connection)
	 */
	@Override
	public boolean updateChildrenDataFieldByBean(FileTypeBean bean,
			Connection conn) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("UPDATE OA_FILE_TYPE OA_FILE_TYPE");
		sql.append("   SET F_TYPE_PARENTNAME =");
		sql.append("       (SELECT REPLACE(TO_CHAR(WM_CONCAT(OFTT.F_TYPE_NAME)), ',', '-->')");
		sql.append("          FROM (SELECT OFTTT.F_TYPE_ID, OFTTT.F_TYPE_NAME");
		sql.append("                  FROM OA_FILE_TYPE OFTTT");
		sql.append("                 ORDER BY OFTTT.F_TYPE_LEVEL, OFTTT.F_CREATOR_TIME) OFTT");
		sql.append("         WHERE OFTT.F_TYPE_ID IN");
		sql.append("               (SELECT COLUMN_VALUE");
		sql.append("                  FROM TABLE(SPLIT(OA_FILE_TYPE.F_TYPE_PARENTID))))");
		sql.append(" WHERE OA_FILE_TYPE.F_TYPE_PARENTID IS NOT NULL");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.executePrepared(conn);
		return true;
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 updateChildrenDataAFieldByBean
	 * @param bean
	 * @param conn
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.file.dao.FileTypeDao#updateChildrenDataAFieldByBean(com.chinacreator.xtbg.core.file.entity.FileTypeBean, java.sql.Connection)
	 */
	@Override
	public boolean updateChildrenDataAFieldByBean(FileTypeBean bean,
			Connection conn) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("select f_type_id,f_type_name");
		sql.append("  from oa_file_type");
		sql.append(" start with f_type_id = '"+bean.getF_type_id()+"'");
		sql.append("connect by prior f_type_id = f_parent_type_id");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared(conn);
		
		for (int j = 0; j < pdb.size(); j++) {
			String tmpBeanId = pdb.getString(j,"f_type_id");
			//String tmpBeanName = pdb.getString(j,"f_type_name");
			Map<String,String> parentBean = this.getAllParentIdsAndNames(conn, tmpBeanId);
			if(!StringUtil.nullOrBlank(parentBean.get("f_type_id"))&&!StringUtil.nullOrBlank(parentBean.get("f_type_name"))){
				String f_type_parentid=parentBean.get("f_type_id");
				String f_type_parentname=parentBean.get("f_type_name");
				PreparedDBUtil pdb1 = new PreparedDBUtil();
				sql = new StringBuffer();
				sql.append("UPDATE OA_FILE_TYPE OA_FILE_TYPE");
				sql.append("   SET F_TYPE_PARENTNAME = ?,F_TYPE_PARENTID=?");
				sql.append(" WHERE OA_FILE_TYPE.F_TYPE_ID = ?");
				pdb1.preparedUpdate(sql.toString());
				pdb1.setString(1, f_type_parentname);
				pdb1.setString(2, f_type_parentid);
				pdb1.setString(3, tmpBeanId);
				pdb1.executePrepared(conn);
			}else{
				LOG.info("updateChildrenDataAFieldByBean:数据不符合业务逻辑");
			}
		}
		return false;
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 sortOrg
	 * @param nodes
	 * @param conn
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.file.dao.FileTypeDao#sortOrg(java.lang.String, java.sql.Connection)
	 */
	@Override
	public boolean sortOrg(String nodes, Connection conn) throws Exception {
		String sql = "update OA_FILE_TYPE  set F_TYPE_ORDER = ? where F_TYPE_ID= ?";
		String[] org_idArray = null;
		PreparedDBUtil db = null;
		
		if(!StringUtil.isBlank(nodes)) {
			org_idArray = nodes.split(",");
			db = new PreparedDBUtil();
			for(int i=1; i< org_idArray.length ;i++){ //子节点成1开始遍历
				db.preparedUpdate(sql.toString());
				db.setInt(1, i);
				db.setString(2, org_idArray[i]);
				
				db.addPreparedBatch();
			}
			db.executePreparedBatch(conn);
		}
		
		return true;
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 updateLevelThreeType
	 * @param beanId
	 * @param conn
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.file.dao.FileTypeDao#updateLevelThreeType(java.lang.String, java.sql.Connection)
	 */
	@Override
	public boolean updateLevelThreeType(String beanId, Connection conn)
			throws Exception {
		String sql = "update oa_file_type set f_type_level = ? where f_type_id = ? and f_type_level <> ?";
		PreparedDBUtil db = new PreparedDBUtil();
		db.preparedUpdate(sql.toString());
		db.setString(1, FileTypeBean.F_TYPE_LEVEL_THREE);
		db.setString(2, beanId);
		db.setString(3, FileTypeBean.F_TYPE_LEVEL_THREE);
		db.executePrepared();
		return true;
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 jieshou
	 * @param ids
	 * @param conn
	 * @return
	 * @throws Exception 
	 * @see com.chinacreator.xtbg.core.file.dao.FileTypeDao#jieshou(java.lang.String[], java.sql.Connection)
	 */
	@Override
	public boolean jieshou(String[] ids, Connection conn) throws Exception {
		String sql = "update OA_FILE_DOC  set F_FLOW_STATE = '3' where F_DOC_ID= ?";
		PreparedDBUtil db = new PreparedDBUtil();
		for(int i=0; i< ids.length ;i++){ //子节点成1开始遍历
			db.preparedUpdate(sql.toString());
			db.setString(1,ids[i]);
			db.addPreparedBatch();
		}
		db.executePreparedBatch(conn);
		return true;
	}
	@Override
	public boolean tuihui(String[] ids, Connection conn,String mess) throws Exception {
		String sql = "update OA_FILE_DOC  set F_FLOW_STATE = '1',F_ROLLBACK_IDEA=? where F_DOC_ID= ?";
		PreparedDBUtil db = null;
		db = new PreparedDBUtil();
		for(int i=0; i< ids.length ;i++){ //子节点成1开始遍历
			db.preparedUpdate(sql.toString());
			db.setString(1, mess);
			db.setString(2,ids[i]);
			
			db.addPreparedBatch();
		}
		db.executePreparedBatch(conn);
		
		return true;
	}

}
