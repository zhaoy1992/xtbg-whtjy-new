package com.chinacreator.xtbg.core.file.service.impl;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.file.dao.FilePurviewDao;
import com.chinacreator.xtbg.core.file.dao.FileTypeDao;
import com.chinacreator.xtbg.core.file.entity.FilePurviewBean;
import com.chinacreator.xtbg.core.file.entity.FileTypeBean;
import com.chinacreator.xtbg.core.file.service.FileTypeServiceIfc;
/**
 * 
 *<p>Title:FileTypeServiceImpl.java</p>
 *<p>Description:档案分类业务逻辑类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Jul 16, 2013
 */
public class FileTypeServiceImpl implements FileTypeServiceIfc {
	
	private static final Log LOG = LogFactory.getLog(FileTypeServiceImpl.class);
	/**
	 * 
	 *<b>Summary: </b>
	 * getFileTypeBeanById(通过beanId获得FileTypeBean)
	 * @param beanId
	 * @return
	 */
	@Override
	public Map<String, String> getFileTypeBeanById(String beanId) {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			FileTypeDao dao = (FileTypeDao)LoadSpringContext.getApplicationContext().getBean("FileTypeDaoImpl");
			return dao.getFileTypeBeanById(conn, beanId);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return null;
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * insertOrUpdateFileTypeBean(添加或修改FileTypeBean)
	 * @param bean
	 * @return
	 */
	@Override
	public String insertOrUpdateFileTypeBean(FileTypeBean bean) {
		Connection conn = null;
		String beanId = "";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FileTypeDao dao = (FileTypeDao)LoadSpringContext.getApplicationContext().getBean("FileTypeDaoImpl");
			//1:设置时间F_creator_time
			bean.setF_creator_time(StringUtil.convertStringToTimestamp(StringUtil
					.deNull(bean.getF_creator_time()), "yyyy-MM-dd HH24:mi:ss"));
			//2:设置是否递归
			if(!FileTypeBean.IS_RECURSION_YES.equals(bean.getF_isrecursion_admin())){
				bean.setF_isrecursion_admin(FileTypeBean.IS_RECURSION_NO);
			}
			if(!FileTypeBean.IS_RECURSION_YES.equals(bean.getF_isrecursion_content())){
				bean.setF_isrecursion_content(FileTypeBean.IS_RECURSION_NO);
			}
			if(!FileTypeBean.IS_RECURSION_YES.equals(bean.getF_isrecursion_file())){
				bean.setF_isrecursion_file(FileTypeBean.IS_RECURSION_NO);
			}
			if(!FileTypeBean.IS_RECURSION_YES.equals(bean.getF_isrecursion_page())){
				bean.setF_isrecursion_page(FileTypeBean.IS_RECURSION_NO);
			}
			if(!FileTypeBean.IS_RECURSION_YES.equals(bean.getF_isrecursion_record_table())){
				bean.setF_isrecursion_record_table(FileTypeBean.IS_RECURSION_NO);
			}
			if(!FileTypeBean.IS_RECURSION_YES.equals(bean.getF_fileno_template_isrecursion())){
				bean.setF_fileno_template_isrecursion(FileTypeBean.IS_RECURSION_NO);
			}
			if(StringUtil.nullOrBlank(bean.getF_type_id())){//insert
				bean.setF_type_id(StringUtil.getUUID());
				beanId = bean.getF_type_id();
				//3:设置F_type_parentid 和 F_type_parentname
				if(StringUtil.nullOrBlank(bean.getF_parent_type_id())){
					bean.setF_type_parentid(bean.getF_type_id());
					bean.setF_type_parentname(bean.getF_type_name());
				}else{
					Map<String,String> parentBean = dao.getAllParentIdsAndNames(conn, bean.getF_parent_type_id());
					if(!StringUtil.nullOrBlank(parentBean.get("f_type_id"))&&!StringUtil.nullOrBlank(parentBean.get("f_type_name"))){
						bean.setF_type_parentid(parentBean.get("f_type_id")+","+bean.getF_type_id());
						bean.setF_type_parentname(parentBean.get("f_type_name")+"-->"+bean.getF_type_name());
					}else{
						bean.setF_type_parentid(bean.getF_type_id());
						bean.setF_type_parentname(bean.getF_type_name());
					}
				}
				//4:设置信息是否来自递归
				if(StringUtil.nullOrBlank(bean.getF_parent_type_id())){
					//4.1:顶级分类数据一定不来自递归
					bean.setF_page_by_isre(FileTypeBean.IS_RECURSION_NO);
					bean.setF_admin_by_isre(FileTypeBean.IS_RECURSION_NO);
					bean.setF_content_by_isre(FileTypeBean.IS_RECURSION_NO);
					bean.setF_file_by_isre(FileTypeBean.IS_RECURSION_NO);
					bean.setF_record_table_by_isre(FileTypeBean.IS_RECURSION_NO);
				}else{
					//4.2:五个字段信息是否与给予递归的信息相同,如果选中了递归，是否被递归直接是false
					//4.2.1
					boolean tmpFlagA = this.compare(bean.getF_isrecursion_page(),bean.getF_page_by_isre(), bean.getF_program_id());
					bean.setF_page_by_isre(tmpFlagA?FileTypeBean.IS_RECURSION_YES:FileTypeBean.IS_RECURSION_NO);
					//4.2.2
					boolean tmpFlagB = this.compare(bean.getF_isrecursion_admin(),bean.getF_admin_by_isre(), bean.getF_type_admin());
					bean.setF_admin_by_isre(tmpFlagB?FileTypeBean.IS_RECURSION_YES:FileTypeBean.IS_RECURSION_NO);
					//4.2.3
					boolean tmpFlagC = this.compare(bean.getF_isrecursion_content(),bean.getF_content_by_isre(), bean.getF_template_content());
					bean.setF_content_by_isre(tmpFlagC?FileTypeBean.IS_RECURSION_YES:FileTypeBean.IS_RECURSION_NO);
					//4.2.4
					boolean tmpFlagD = this.compare(bean.getF_isrecursion_file(),bean.getF_file_by_isre(), bean.getF_template_file());
					bean.setF_file_by_isre(tmpFlagD?FileTypeBean.IS_RECURSION_YES:FileTypeBean.IS_RECURSION_NO);
					//4.2.5
					boolean tmpFlagE = this.compare(bean.getF_isrecursion_record_table(),bean.getF_record_table_by_isre(), bean.getF_template_record_table());
					bean.setF_record_table_by_isre(tmpFlagE?FileTypeBean.IS_RECURSION_YES:FileTypeBean.IS_RECURSION_NO);
					//4.3:防止在页面展开之后,保存数据之前,被递归过来的信息所属数据被其他人修改,需要再获取一次被递归的数据
					if(tmpFlagA||tmpFlagB||tmpFlagC||tmpFlagD||tmpFlagE){
						Map<String,String[]> map = dao.getIsrecursionDataById(conn, bean.getF_parent_type_id(), true);
						if(tmpFlagA){
							if(map.containsKey("PAGE")){
								String[] tmp = map.get("PAGE");
								bean.setF_program_id(tmp[0]);
								bean.setF_program_page(tmp[1]);
							}else{//需要递归数据,却获取不到
								bean.setF_program_id("");
								bean.setF_program_page("");
							}
						}
						if(tmpFlagB){
							if(map.containsKey("ADMIN")){
								String[] tmp = map.get("ADMIN");
								bean.setF_type_admin(tmp[0]);
								bean.setF_type_adminname(tmp[1]);
							}else{//需要递归数据,却获取不到
								bean.setF_type_admin("");
								bean.setF_type_adminname("");
							}
						}
						if(tmpFlagC){
							if(map.containsKey("CONTENT")){
								String[] tmp = map.get("CONTENT");
								bean.setF_template_content(tmp[1]);
							}else{//需要递归数据,却获取不到
								bean.setF_template_content("");
							}
						}
						if(tmpFlagD){
							if(map.containsKey("FILE")){
								String[] tmp = map.get("FILE");
								bean.setF_template_file(tmp[1]);
							}else{//需要递归数据,却获取不到
								bean.setF_template_file("");
							}
						}
						if(tmpFlagE){
							if(map.containsKey("TABLE")){
								String[] tmp = map.get("TABLE");
								bean.setF_template_record_table(tmp[1]);
							}else{//需要递归数据,却获取不到
								bean.setF_template_record_table("");
							}
						}
						
						if(map.containsKey("FILENO")){
							String[] tmp = map.get("FILENO");
							bean.setF_fileno_template(tmp[1]);
						}else{//需要递归数据,却获取不到
							bean.setF_fileno_template("");
						}
					}
				}
				//5:添加到数据库
				((BaseDao)dao).insert(bean, conn);
				//6:增加之后不需要修改子节点，因为没有子节点
			}else{//update
				beanId = bean.getF_type_id();
				//3:修改信息[是否来自递归]
				Map<String, String> oldBean = dao.getFileTypeBeanById(conn, bean.getF_type_id());
				//3.1:如果老数据标记了[信息来自递归],并且新数据中没有选择[递归],并且数据在页面展开后没有被修改,则标记[信息来自递归]
				if(FileTypeBean.IS_RECURSION_YES.equals(oldBean.get("f_page_by_isre"))){
					boolean tmpFlag = this.compare(bean.getF_isrecursion_page(),bean.getF_page_by_isre(), bean.getF_program_id());
					bean.setF_page_by_isre(tmpFlag?FileTypeBean.IS_RECURSION_YES:FileTypeBean.IS_RECURSION_NO);
				}else{
					bean.setF_page_by_isre(FileTypeBean.IS_RECURSION_NO);
				}
				//3.2
				if(FileTypeBean.IS_RECURSION_YES.equals(oldBean.get("f_admin_by_isre"))){
					boolean tmpFlag = this.compare(bean.getF_isrecursion_admin(),bean.getF_admin_by_isre(), bean.getF_type_admin());
					bean.setF_admin_by_isre(tmpFlag?FileTypeBean.IS_RECURSION_YES:FileTypeBean.IS_RECURSION_NO);
				}else{
					bean.setF_admin_by_isre(FileTypeBean.IS_RECURSION_NO);
				}
				//3.3
				if(FileTypeBean.IS_RECURSION_YES.equals(oldBean.get("f_content_by_isre"))){
					boolean tmpFlag = this.compare(bean.getF_isrecursion_content(),bean.getF_content_by_isre(), bean.getF_template_content());
					bean.setF_content_by_isre(tmpFlag?FileTypeBean.IS_RECURSION_YES:FileTypeBean.IS_RECURSION_NO);
				}else{
					bean.setF_content_by_isre(FileTypeBean.IS_RECURSION_NO);
				}
				//3.4
				if(FileTypeBean.IS_RECURSION_YES.equals(oldBean.get("f_file_by_isre"))){
					boolean tmpFlag = this.compare(bean.getF_isrecursion_file(),bean.getF_file_by_isre(), bean.getF_template_file());
					bean.setF_file_by_isre(tmpFlag?FileTypeBean.IS_RECURSION_YES:FileTypeBean.IS_RECURSION_NO);
				}else{
					bean.setF_file_by_isre(FileTypeBean.IS_RECURSION_NO);
				}
				//3.5
				if(FileTypeBean.IS_RECURSION_YES.equals(oldBean.get("f_record_table_by_isre"))){
					boolean tmpFlag = this.compare(bean.getF_isrecursion_record_table(),bean.getF_record_table_by_isre(), bean.getF_template_record_table());
					bean.setF_record_table_by_isre(tmpFlag?FileTypeBean.IS_RECURSION_YES:FileTypeBean.IS_RECURSION_NO);
				}else{
					bean.setF_record_table_by_isre(FileTypeBean.IS_RECURSION_NO);
				}
				//4:修改数据
				((BaseDao)dao).update(bean, conn);
				//5:向下修改需要递归的数据
				dao.updateChildrenDataByBean(bean,conn);
				//6:如果修改了 对应的父节点, 修改F_type_parentid 和 F_type_parentname
				boolean updateSix = false;//是否修改了第六步
				if(!StringUtil.deNull(oldBean.get("f_parent_type_id")).equals(StringUtil.nullOrBlank(bean.getF_parent_type_id()))){
					dao.updateChildrenDataAFieldByBean(bean,conn);
					updateSix = true;
				}
				if(!updateSix){
					//7:如果修改了名字 修改  F_type_parentname 的路径
					if(!StringUtil.deNull(oldBean.get("f_type_name")).equals(StringUtil.nullOrBlank(bean.getF_type_name()))){
						dao.updateChildrenDataFieldByBean(bean,conn);
					}
				}
				
			}
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return beanId;
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * compare(比较是否递归,默认递归的值,新增或修改的值,判断该数据是否利用了递归数据)
	 * 判断该数据是否还是利用递归数据产生的
	 * @param aa[是否递归]
	 * @param a [老数据]
	 * @param b [新数据]
	 * @return [数据是否来自递归]
	 */
	private boolean compare(String aa,String a,String b){
		boolean tmpFlag = false;
		if(FileTypeBean.IS_RECURSION_NO.equals(aa)){
			//如果数据和默认从上获取的递归数据相同,说明该数据是来自递归数据
			if(StringUtil.nullOrBlank(a)
					&&StringUtil.nullOrBlank(b)){
				tmpFlag = true;
			}else{
				if(!StringUtil.nullOrBlank(a)
					&&a.equals(b)){
					tmpFlag = true;
				}
			}
		}else{
			//如果已经选中了将数据向下递归,说明数据已经放弃了从上获取递归数据的权利
		}
		return tmpFlag;
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * getIsrecursionDataForInsert(通过parentId获得可递归到的数据for insert)
	 * @param parentId
	 * @return
	 */
	@Override
	public FileTypeBean getIsrecursionDataForInsert(String parentId) {
		FileTypeBean bean = new FileTypeBean();
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FileTypeDao dao = (FileTypeDao)LoadSpringContext.getApplicationContext().getBean("FileTypeDaoImpl");
			Map<String,String[]> map = dao.getIsrecursionDataById(conn, parentId, true);
			if(map.containsKey("PAGE")){
				String[] tmp = map.get("PAGE");
				bean.setF_program_id(tmp[0]);
				bean.setF_program_page(tmp[1]);
			}
			if(map.containsKey("ADMIN")){
				String[] tmp = map.get("ADMIN");
				bean.setF_type_admin(tmp[0]);
				bean.setF_type_adminname(tmp[1]);
			}
			if(map.containsKey("CONTENT")){
				String[] tmp = map.get("CONTENT");
				bean.setF_template_content(tmp[1]);
			}
			if(map.containsKey("FILE")){
				String[] tmp = map.get("FILE");
				bean.setF_template_file(tmp[1]);
			}
			if(map.containsKey("TABLE")){
				String[] tmp = map.get("TABLE");
				bean.setF_template_record_table(tmp[1]);
			}
			if(map.containsKey("FILENO")){
				String[] tmp = map.get("FILENO");
				bean.setF_fileno_template(tmp[1]);
			}
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return bean;
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * deleteFileTypeInfoByIds(通过beanId的数组批量删除FileTypeBean)
	 * @param beanIdArr
	 * @return
	 */
	@Override
	public boolean deleteFileTypeInfoByIds(String[] beanIdArr) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FileTypeDao dao = (FileTypeDao)LoadSpringContext.getApplicationContext().getBean("FileTypeDaoImpl");
			for (String beanId : beanIdArr) {
				dao.deleteFileTypeBeansById(conn, beanId);
			}
			conn.commit();
			flag = true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * insertOrUpdateFilePurviewBean(添加或修改FilePurviewBean)
	 * @param bean
	 * @return
	 */
	@Override
	public boolean insertOrUpdateFilePurviewBean(FilePurviewBean bean) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FileTypeDao dao = (FileTypeDao)LoadSpringContext.getApplicationContext().getBean("FileTypeDaoImpl");
			checkFilePurviewBean(bean);
			if(StringUtil.nullOrBlank(bean.getF_purview_id())){
				bean.setF_purview_id(StringUtil.getUUID());
				((BaseDao)dao).insert(bean, conn);
			}else{
				((BaseDao)dao).update(bean, conn);
			}
			conn.commit();
			flag = true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * checkFilePurviewBean(检查bean)
	 * @param bean
	 */
	private void checkFilePurviewBean(FilePurviewBean bean) {
		if(!FilePurviewBean.CAN_DO.equals(bean.getF_download_all_user())){
			bean.setF_download_all_user(FilePurviewBean.CAN_NOT_DO);
		}
		if(!FilePurviewBean.CAN_DO.equals(bean.getF_download_dept_user())){
			bean.setF_download_dept_user(FilePurviewBean.CAN_NOT_DO);
		}
		if(!FilePurviewBean.CAN_DO.equals(bean.getF_read_all_user())){
			bean.setF_read_all_user(FilePurviewBean.CAN_NOT_DO);
		}
		if(!FilePurviewBean.CAN_DO.equals(bean.getF_read_dept_user())){
			bean.setF_read_dept_user(FilePurviewBean.CAN_NOT_DO);
		}
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * deleteFilePurviewInfo(通过beanId的数组批量删除FilePurviewBean)
	 * @param beanIdArr
	 * @return
	 */
	@Override
	public boolean deleteFilePurviewInfoByIds(String[] beanIdArr) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FilePurviewDao dao = (FilePurviewDao)LoadSpringContext.getApplicationContext().getBean("FilePurviewDaoImpl");
			for (String beanId : beanIdArr) {
				dao.deleteFilePurviewBeansById(conn, beanId);
			}
			conn.commit();
			flag = true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * getMaxFilePurviewNum(获得密级数量)
	 * @return
	 */
	@Override
	public int getMaxFilePurviewNum() {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			FilePurviewDao dao = (FilePurviewDao)LoadSpringContext.getApplicationContext().getBean("FilePurviewDaoImpl");
			return dao.getMaxFilePurviewNum(conn);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return 0;
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * getFilePurviewBeanById(通过beanId获得FilePurviewBean[Map<String, String>格式])
	 * @param beanId
	 * @return
	 */
	@Override
	public Map<String, String> getFilePurviewBeanById(String beanId) {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			FilePurviewDao dao = (FilePurviewDao)LoadSpringContext.getApplicationContext().getBean("FilePurviewDaoImpl");
			return dao.getFilePurviewBeanById(conn, beanId);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return null;
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * getBKBParamForFileTypeBean(为档案分类信息编辑获取备考表参数列表)
	 * @return
	 */
	@Override
	public List<Map<String, String>> getBKBParamForFileTypeBean() {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			FileTypeDao dao = (FileTypeDao)LoadSpringContext.getApplicationContext().getBean("FileTypeDaoImpl");
			return dao.getBKBAllParam(conn);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return null;
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * checkFileTypeRoleOfUser(检查某用户访问某档案文件的权限)
	 * @param userId
	 * @param fileDocBeanId
	 * @return
	 */
	@Override
	public Boolean[] checkFileTypeRoleOfUser(String userId, String fileDocBeanId) {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			FileTypeDao dao = (FileTypeDao)LoadSpringContext.getApplicationContext().getBean("FileTypeDaoImpl");
			//通过 档案分类方面 判断 权限有无
			Boolean[] bs = dao.checkFileTypeRoleOfUser(userId, fileDocBeanId, conn);
			if(!bs[0]||!bs[1]){
				//通过 借阅申请部分 判断 权限有无
				Boolean[] bs2 = dao.checkFileTypeRoleOfUserAboutLending(userId, fileDocBeanId, conn);
				bs[0] = (bs[0]||bs2[0])?true:false;
				bs[1] = (bs[1]||bs2[1])?true:false;
			}
			return bs;
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return new Boolean[]{false,false};
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 getDADHParamForFileTypeBean
	 * @return 
	 * @see com.chinacreator.xtbg.core.file.service.FileTypeServiceIfc#getDADHParamForFileTypeBean()
	 */
	@Override
	public List<Map<String, String>> getDADHParamForFileTypeBean() {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			FileTypeDao dao = (FileTypeDao)LoadSpringContext.getApplicationContext().getBean("FileTypeDaoImpl");
			return dao.getDHAllParam(conn);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return null;
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 checkChildrenNode
	 * @param deleteArr
	 * @return 
	 * @see com.chinacreator.xtbg.core.file.service.FileTypeServiceIfc#checkChildrenNode(java.lang.String[])
	 */
	@Override
	public boolean checkChildrenNode(String[] deleteArr) {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			FileTypeDao dao = (FileTypeDao)LoadSpringContext.getApplicationContext().getBean("FileTypeDaoImpl");
			return dao.checkChildrenNode(deleteArr,conn);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return false;
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 checkUsedData
	 * @param deleteArr
	 * @return 
	 * @see com.chinacreator.xtbg.core.file.service.FileTypeServiceIfc#checkUsedData(java.lang.String[])
	 */
	@Override
	public boolean checkUsedData(String[] deleteArr) {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			FileTypeDao dao = (FileTypeDao)LoadSpringContext.getApplicationContext().getBean("FileTypeDaoImpl");
			return dao.checkUsedData(deleteArr,conn);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return false;
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 sortOrg
	 * @param nodes
	 * @return 
	 * @see com.chinacreator.xtbg.core.file.service.FileTypeServiceIfc#sortOrg(java.lang.String)
	 */
	@Override
	public boolean sortOrg(String nodes) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FileTypeDao dao = (FileTypeDao)LoadSpringContext.getApplicationContext().getBean("FileTypeDaoImpl");
			flag = dao.sortOrg(nodes,conn);
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
}
