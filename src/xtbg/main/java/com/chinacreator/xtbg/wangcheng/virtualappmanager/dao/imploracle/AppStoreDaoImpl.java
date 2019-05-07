package com.chinacreator.xtbg.wangcheng.virtualappmanager.dao.imploracle;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.DbconnManager;
import com.chinacreator.xtbg.wangcheng.virtualappmanager.dao.AppStoreDao;
import com.chinacreator.xtbg.wangcheng.virtualappmanager.entity.AppStoreBean;

/**
 * description 应用商店信息Dao实现层
 * author yin.liu
 * date 2012-1-31
 */
public class AppStoreDaoImpl implements AppStoreDao {

	private static final Logger LOG = Logger.getLogger(AppStoreDaoImpl.class);
	private Connection conn;
	/**
	 * @Description 根据条件查询应用商店信息
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findAppStoreList(AppStoreBean appStoreBean,
			String sortName, String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		List<AppStoreBean> list = new ArrayList<AppStoreBean>();
		StringBuffer sql = new StringBuffer();
		Statement pstmt = null;
		ResultSet rs = null;
//		sql.append("select a.app_id,a.app_name,a.app_img,a.app_description,a.class_name,a.menu_code,");
//		sql.append("(select d.key_value from ta_android_app_dic_store d where d.key_name=a.app_type and d.key_type='03') app_type,");
//		sql.append("a.remark,a.last_update_time from ta_android_app_store a where 1=1 ");	
		
//		sql.append("select a.app_id appid,a.app_name name,a.app_img img,a.app_description description,a.class_name classname,a.menu_code applocation,");
//		sql.append("(select d.key_value from ta_android_app_dic_store d where d.key_name=a.app_type and d.key_type='09') apptype,");
//		sql.append("a.remark,a.last_update_time lastupdatetime from ta_android_app_store a where 1=1 ");
		sql.append("select a.app_id appid,a.app_name name,a.app_img img,a.app_description description,a.class_name classname,a.menu_code applocation,");
		sql.append("(select distinct d.key_value from ta_android_app_dic_store d where d.key_name=a.app_type ) apptype,");
		sql.append("a.remark,a.last_update_time lastupdatetime from ta_android_app_store a where 1=1 ");
		if (appStoreBean != null) {
			if (!StringUtils.isEmpty(appStoreBean.getName())) {
				sql.append(" and a.app_name like '%" + appStoreBean.getName()
						+ "%'");
			}

			if (!StringUtils.isEmpty(appStoreBean.getApptype())) {
				if (!"00".equals(appStoreBean.getApptype())) {
					sql.append(" and a.app_type = '"
							+ appStoreBean.getApptype() + "'");
				}
			}
		}

		sql.append(" order by " + sortName + " " + sortOrder);

		long count = 0;
		try {
			conn = DbconnManager.getInstance().getConnection();
			pstmt = conn.createStatement();
			rs = pstmt.executeQuery(sql.toString());
			long startIndex = Integer.parseInt(offset + "");
			while (rs.next()) {
				if (startIndex <= count && list.size() <= maxPagesize) {

					AppStoreBean bean = new AppStoreBean();
					bean.setAppid(rs.getString("appid"));
					bean.setName(rs.getString("name"));
					bean.setImg(rs.getString("img"));
					bean.setDescription(rs.getString("description"));
					bean.setClassname(rs.getString("classname"));
					bean.setApplocation(rs.getString("applocation"));
					bean.setApptype(rs.getString("apptype"));
					bean.setRemark(rs.getString("remark"));
					bean.setLastupdatetime(rs.getString("lastupdatetime"));

					// bean.setAppid(rs.getString("app_id"));
					// bean.setName(rs.getString("app_name"));
					// bean.setImg(rs.getString("app_img"));
					// bean.setDescription(rs.getString("app_description"));
					// bean.setClassname(rs.getString("class_name"));
					// bean.setApplocation(rs.getString("menu_code"));
					// bean.setApptype(rs.getString("app_type"));
					// bean.setRemark(rs.getString("remark"));
					// bean.setLastupdatetime(rs.getString("last_update_time"));

					list.add(bean);
				}
				count++;
			}
		}catch(Exception e){
			LOG.error("执行应用商店列表查询报错"+e.getMessage());
			return null;
		}finally{
			try {//关闭资源
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			DbconnManager.closeConnection(conn);
		}
		
	    pb.setList(list);
	    pb.setRecords(count);
		return pb;
	}
	
	/**
	 * @Description 根据条件查询未分配的应用商店信息
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findAppStoreList_grant(AppStoreBean appStoreBean,
			String sortName, String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		List<AppStoreBean> list = new ArrayList<AppStoreBean>();
		StringBuffer sql = new StringBuffer();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		sql.append("select a.app_id appid,a.app_name name,a.app_img img,a.app_description description,a.class_name classname,a.menu_code applocation,");
		sql.append("(select d.key_value from ta_android_app_dic_store d where d.key_name=a.app_type and d.key_type='09') apptype,");
		sql.append("a.remark,a.last_update_time lastupdatetime from ta_android_app_store a ");
		sql.append(" where not exists (select recordid from ta_android_appstore_giveorg app where app.app_id=a.app_id and app.giveapp_org_id= ? ) ");
		
		
//		sql.append("select a.app_id,a.app_name,a.app_img,a.app_description,a.class_name,a.menu_code,");
//		sql.append("(select d.key_value from ta_android_app_dic_store d where d.key_name=a.app_type and d.key_type='03') app_type,a.remark,a.last_update_time from ta_android_app_store a");
//		sql.append(" where not exists (select recordid from ta_android_appstore_giveorg app where app.app_id=a.app_id and app.giveapp_org_id= ? ) ");
		if(appStoreBean != null){
			if(!StringUtils.isEmpty(appStoreBean.getName())){
				sql.append(" and a.app_name like '%"+appStoreBean.getName()+"%'");
			}
			
			if(!StringUtils.isEmpty(appStoreBean.getApptype())){
				if(!"00".equals(appStoreBean.getApptype())){
					sql.append(" and a.app_type = '"+appStoreBean.getApptype()+"'");
				}
			}
		}
		
		sql.append(" order by " + sortName + " " + sortOrder);
		
		long count = 0;
		try {
			conn = DbconnManager.getInstance().getConnection();
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, appStoreBean.getRemark());
			rs = pstmt.executeQuery();
			   long startIndex = Integer.parseInt(offset+"");
				while(rs.next()){
					if(startIndex<=count && list.size()<=maxPagesize){

	    		AppStoreBean bean = new AppStoreBean();
	    		bean.setAppid(rs.getString("appid"));
	    		bean.setName(rs.getString("name"));
	    		bean.setImg(rs.getString("img"));
	    		bean.setDescription(rs.getString("description"));
	    		bean.setClassname(rs.getString("classname"));
	    		bean.setApplocation(rs.getString("applocation"));
	    		bean.setApptype(rs.getString("apptype"));
	    		bean.setRemark(rs.getString("remark"));
	    		bean.setLastupdatetime(rs.getString("lastupdatetime"));
	    		
	    		
//	    		
//	    		bean.setAppid(rs.getString("app_id"));
//	    		bean.setName(rs.getString("app_name"));
//	    		bean.setImg(rs.getString("app_img"));
//	    		bean.setDescription(rs.getString("app_description"));
//	    		bean.setClassname(rs.getString("class_name"));
//	    		bean.setApplocation(rs.getString("menu_code"));
//	    		bean.setApptype(rs.getString("app_type"));
//	    		bean.setRemark(rs.getString("remark"));
//	    		bean.setLastupdatetime(rs.getString("last_update_time"));
	    		list.add(bean);
					}
	    		count++;
	    	}
		}catch(Exception e){
			LOG.error("执行未分配的应用商店列表查询报错"+e.getMessage());
			return null;
		}finally{
			try {//关闭资源
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			DbconnManager.closeConnection(conn);
		}
		
	    pb.setList(list);
	    pb.setRecords(count);
		return pb;
	}

	/**
	 * @Description 添加应用商店信息
	 * @param appStoreBean 应用商店Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public void addAppStore(AppStoreBean appStoreBean) throws SQLException {
		PreparedStatement  pstmt=null;
		conn = DbconnManager.getInstance().getConnection();
		String maxSn = String.valueOf(getAppSn(conn));
		StringBuffer sql = new StringBuffer();
		sql.append("insert into ta_android_app_store(app_id,app_name,app_img,app_description,class_name,menu_code,app_type,remark,last_update_time,sn) ");
		sql.append(" values(seq_appstore.nextval,?,?,?,?,?,?,?,sysdate,?) ");
		try {
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, appStoreBean.getName());
			pstmt.setString(2, appStoreBean.getImg());
			pstmt.setString(3, appStoreBean.getDescription());
			pstmt.setString(4, appStoreBean.getClassname());
			pstmt.setString(5, appStoreBean.getApplocation());
			pstmt.setString(6, appStoreBean.getApptype());
			pstmt.setString(7, appStoreBean.getRemark());
			pstmt.setString(8, maxSn);
			pstmt.executeUpdate();
		
		}catch(Exception e){
			LOG.error("添加应用商店报错"+e.getMessage());
			
		}finally{
			try {//关闭资源
			
				if(pstmt!=null) pstmt.close();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			DbconnManager.closeConnection(conn);
		}
	}
	
	public int getAppSn(Connection conn){
		int maxSn = 0;
		ResultSet rs = null;
		PreparedStatement  pstmt=null;
		StringBuffer sql = new StringBuffer();
		sql.append(" select max(sn) max_sn from TA_ANDROID_APP_STORE ");
		try {
			pstmt = conn.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			while(rs.next()){
				maxSn = rs.getInt("max_sn")+1;
			}
		
		}catch(Exception e){
			LOG.error("获取菜单最大编号报错"+e.getMessage());
			
		}finally{
			try {//关闭资源
				if(pstmt!=null) pstmt.close();
				if(rs!=null) rs.close();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
		return maxSn;
	}

	/**
	 * @Description  删除应用商店信息
	 * @param appIds
	 * @return boolean
	 * @throws SQLException 
	 */
	public boolean delAppStore(String appIds) throws SQLException {
		PreparedStatement  pstmt=null;
		String sql = "delete from ta_android_app_store a where a.app_id in ("+ appIds + ")";
		boolean flag = false;
		try{
			conn = DbconnManager.getInstance().getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.executeUpdate();
			flag = true;
		}catch(Exception e){
			LOG.error("删除应用商店"+e.getMessage());
			flag = false;
		}finally{
			try {// 关闭资源
				if (pstmt != null)
					pstmt.close();
			} catch (SQLException e1) {
				e1.printStackTrace();
				return flag;
			}
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
					return flag;
				} catch (SQLException e) {
					LOG.error("删除应用商店：" + e.getMessage());
					return flag;
				}
			}
		}
		return flag;
	}

	/**
	 * @Description 修改应用商店信息
	 * @param appStoreBean 应用商店Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public void updateAppStore(AppStoreBean appStoreBean) throws SQLException {
		PreparedStatement  pstmt=null;
		StringBuffer sql = new StringBuffer();
		sql.append("  update ta_android_app_store set app_name=?,app_img=?,app_description=?,class_name=?,menu_code=?,app_type=?,last_update_time=sysdate where app_id=? ");
		try{
			conn = DbconnManager.getInstance().getConnection();
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, appStoreBean.getName());
			pstmt.setString(2, appStoreBean.getImg());
			pstmt.setString(3, appStoreBean.getDescription());
			pstmt.setString(4, appStoreBean.getClassname());
			pstmt.setString(5, appStoreBean.getApplocation());
			pstmt.setString(6, appStoreBean.getApptype());
			pstmt.setString(7, appStoreBean.getAppid());
			pstmt.executeUpdate();
		}catch(Exception e){
			LOG.error("修改应用商店"+e.getMessage());
			
		}finally{
			try {//关闭资源
				
				if(pstmt!=null) pstmt.close();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			DbconnManager.closeConnection(conn);
		}
		
	
	}

	/**
	 * @Description 根据应用ID获得应用信息
	 * @param appid 应用商店id
	 * @return boolean
	 * @throws SQLException 
	 */
	public AppStoreBean getAppStoreBeanById(String appid) throws SQLException {
		StringBuffer sql = new StringBuffer();
		sql.append("select a.app_id,a.app_name,a.app_img,a.app_description,a.class_name,a.menu_code,a.app_type,");
		sql.append("a.remark,a.last_update_time from ta_android_app_store a where a.app_id=? ");
		PreparedStatement  pstmt=null;
		ResultSet rs = null;
		AppStoreBean bean = new AppStoreBean();
		try{
			conn = DbconnManager.getInstance().getConnection();
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1,appid);
			rs = pstmt.executeQuery();
			while(rs.next()){
			
    		bean.setAppid(rs.getString("app_id"));
    		bean.setName(rs.getString("app_name"));
    		bean.setImg(rs.getString("app_img"));
    		bean.setDescription(rs.getString("app_description"));
    		bean.setClassname(rs.getString("class_name"));
    		bean.setApplocation(rs.getString("menu_code"));
    		bean.setApptype(rs.getString("app_type"));
    		bean.setRemark(rs.getString("remark"));
    		bean.setLastupdatetime(rs.getString("last_update_time"));
		}
			}catch(Exception e){
			LOG.error("根据应用ID获得应用"+e.getMessage());
			
		}finally{
			try {//关闭资源
				
				if(pstmt!=null) pstmt.close();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			DbconnManager.closeConnection(conn);
		}
		return bean;
	}
	
	/**
	 * 获取图标集合
	 * @return
	 * @throws Exception
	 */
	public HashMap<String,String> getAppIconMap() throws Exception{
		HashMap<String,String> map = new HashMap<String,String>();
		PreparedStatement  pstmt=null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		sql.append("  select d.key_name,d.key_value,d.sn from ta_android_app_dic_store d where d.key_type='01' order by d.sn ");
		try{
			conn = DbconnManager.getInstance().getConnection();
			pstmt = conn.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				map.put(rs.getString("key_name"), rs.getString("key_value"));
			}
			}catch(Exception e){
				LOG.error("获取图标集合"+e.getMessage());
				
			}finally{
				try {//关闭资源
					if(rs!=null) rs.close();
					if(pstmt!=null) pstmt.close();
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
				DbconnManager.closeConnection(conn);
			}
				
		
		return map;
		
	}
	
	/**
	 * 获取应用类别集合
	 * @return
	 * @throws Exception
	 */
	public HashMap<String,String> getAppTypeMap() throws Exception{

		HashMap<String,String> map = new HashMap<String,String>();
		StringBuffer sql = new StringBuffer();
		PreparedStatement  pstmt=null;
		ResultSet rs = null;
		sql.append("select d.key_name,d.key_value,d.sn from ta_android_app_dic_store d where d.key_type='03' order by d.sn ");
		try{
		conn = DbconnManager.getInstance().getConnection();
		pstmt = conn.prepareStatement(sql.toString());
		rs = pstmt.executeQuery();
		
		while(rs.next()){
			map.put(rs.getString("key_name"), rs.getString("key_value"));
		}
		}catch(Exception e){
			LOG.error("获取应用类别集合"+e.getMessage());
			
		}finally{
			try {//关闭资源
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			DbconnManager.closeConnection(conn);
		}
			
		return map;
		
	}
	
	/**
	 * 获取应用class类集合
	 * @return
	 * @throws Exception
	 */
	public HashMap<String,String> getClassNameMap() throws Exception{
		HashMap<String,String> map = new HashMap<String,String>();
		StringBuffer sql = new StringBuffer();
		PreparedStatement  pstmt=null;
		ResultSet rs = null;
		sql.append("  select d.key_name,d.key_value,d.sn from ta_android_app_dic_store d where d.key_type='02' order by d.sn ");
		try{
		conn = DbconnManager.getInstance().getConnection();
		pstmt = conn.prepareStatement(sql.toString());
		rs = pstmt.executeQuery();
		
		while(rs.next()){
			map.put(rs.getString("key_name"), rs.getString("key_value"));
		}
		}catch(Exception e){
			LOG.error("获取应用class类集合"+e.getMessage());
			
		}finally{
			try {//关闭资源
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			DbconnManager.closeConnection(conn);
		}
		
		return map;
	}

}
