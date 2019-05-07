package com.chinacreator.xtbg.wangcheng.virtualappmanager.dao.imploracle;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.DbconnManager;
import com.chinacreator.xtbg.wangcheng.virtualappmanager.dao.AppPermissionDao;
import com.chinacreator.xtbg.wangcheng.virtualappmanager.entity.AppPermissionBean;

/**
 * description 应用注册Dao实现层
 * author yin.liu
 * date 2012-2-2
 */
public class AppPermissionDaoImpl implements AppPermissionDao {

	private static final Logger LOG = Logger.getLogger(AppPermissionDaoImpl.class);
	private Connection conn;
	/**
	 * @Description 根据条件查询已分配的应用注册信息
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findAppPermissionList(AppPermissionBean appPermission,
			String sortName, String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<AppPermissionBean> list = new ArrayList<AppPermissionBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select a.recordid pid,a.app_id appid,b.app_name appname,b.app_img appimg ,a.giveapp_org_name orgname ,a.giveapp_org_id orgid,b.class_name appclassname,b.app_type apptype");
		sql.append(" from ta_android_appstore_giveorg a,ta_android_app_store b where a.giveapp_org_id = ? and a.app_id = b.app_id");
		sql.append(" order by " + sortName + " " + sortOrder);
		long count = 0;
		try {
			conn = DbconnManager.getInstance().getConnection();
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, appPermission.getRemark());
			rs = pstmt.executeQuery();
			   long startIndex = Integer.parseInt(offset+"");
				while(rs.next()){
					if(startIndex<=count && list.size()<=maxPagesize){

	    		AppPermissionBean bean = new AppPermissionBean();
	    		bean.setPid(rs.getString("pid"));
	    		bean.setAppid(rs.getString("appid"));
	    		bean.setAppname(rs.getString("appname"));
	    		bean.setAppimg(rs.getString("appimg"));
	    		bean.setOrgname(rs.getString("orgname"));
	    		bean.setOrgid(rs.getString("orgid"));
	    		bean.setAppclassname(rs.getString("appclassname"));
	    		bean.setApptype(rs.getString("apptype"));
	    		list.add(bean);
					}
					count++;
	    	}
		}catch(Exception e){
			LOG.error("执行应用注册列表查询报错"+e.getMessage());
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
	 * @Description 添加应用注册信息
	 * @param appPermission 应用注册Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public void addAppPermission(AppPermissionBean appPermission)
			throws SQLException {
		PreparedStatement  pstmt=null;
		StringBuffer sql = new StringBuffer();
		sql.append("insert into ta_android_appstore_giveorg(recordid,app_id,giveapp_org_id,giveapp_org_name,give_user_id,give_time,");
		sql.append("give_time_limit,giveapp_user_id,giveapp_user_name) values(SEQ_APPPERMISSION.Nextval,?,?,?,?,?,?,?,?) ");
		try {
			conn = DbconnManager.getInstance().getConnection();
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, appPermission.getAppid());
			pstmt.setString(2, appPermission.getOrgid());
			pstmt.setString(3, appPermission.getOrgname());
			pstmt.setString(4, "");
			pstmt.setString(5, "");
			pstmt.setString(6, "");
			pstmt.setString(7, "");
			pstmt.setString(8, "");
			pstmt.executeUpdate();
		}catch(Exception e){

			LOG.error("添加应用注册信息报错"+e.getMessage());
			
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
	 * 
	*<b>Summary: </b>
	* insertUserFlag(插入轮询表)
	* @param orgid
	* @return
	 */
	public boolean insertUserFlag(String orgid,String waitid){
		boolean flag = false;
		PreparedStatement  pstmt=null;
		StringBuffer sql = new StringBuffer();
		sql.append("select u.user_id from td_sm_user u left join td_sm_orguser ou ");
		sql.append(" on ou.user_id = u.user_id where ou.org_id=? ");
		ResultSet rs = null;
	try {
		conn = DbconnManager.getInstance().getConnection();
		pstmt = conn.prepareStatement(sql.toString());
		pstmt.setString(1,orgid);
		rs = pstmt.executeQuery();
		//String[] strarr = null;
		//int count = 0;
		
		while(rs.next()){
			String sqls = "insert into ta_android_userflag(flag_id, user_id, wait_id) values(seq_android_userflag.nextval,?,?)";
			pstmt = conn.prepareStatement(sqls);
			pstmt.setString(1, rs.getString("user_id"));
			pstmt.setString(2, waitid);
	
			pstmt.executeUpdate();
		}
		
		}catch(Exception e){
			LOG.error("添加轮询信息报错"+e.getMessage());
		}finally{
			try {//关闭资源
				if(pstmt!=null) pstmt.close();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			DbconnManager.closeConnection(conn);
		}
		return flag;
	}
	/**
	 * 
	*<b>Summary: </b>
	* querywaitinfo(查看wait表里是否有轮询数据)
	* @param orgid
	* @return
	* @throws SQLException
	 */
	public boolean querywaitinfo(String orgid)throws SQLException{
		boolean flag = false;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		//List<AppPermissionBean> list = new ArrayList<AppPermissionBean>();
		StringBuffer sql = new StringBuffer();
		sql.append("select count(*) counts from TA_ANDROID_WAIT t left join TA_ANDROID_USERFLAG uf on t.wait_id=uf.wait_id ");
		sql.append(" left join td_sm_orguser ou on ou.user_id = uf.user_id where t.remark='菜单权限' and ou.org_id=? ");
		conn = DbconnManager.getInstance().getConnection();
		pstmt = conn.prepareStatement(sql.toString());
		pstmt.setString(1, orgid);
		rs = pstmt.executeQuery();
		rs.next();
		if(rs.getInt("counts")>0){
			flag = true;
		}
		return flag;
	}
	/**
	 * @Description  删除应用注册信息
	 * @param pids
	 * @return boolean
	 * @throws SQLException 
	 */
	public boolean delAppPermission(String pids) throws SQLException {
		PreparedStatement  pstmt=null;
		String sql = "delete from ta_android_appstore_giveorg a where a.recordid in ("+ pids + ")";
		try{
			conn = DbconnManager.getInstance().getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.executeUpdate();
		}catch(Exception e){
			LOG.error("删除应用注册"+e.getMessage());
			
		}finally{
			try {//关闭资源
				if(pstmt!=null) pstmt.close();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			DbconnManager.closeConnection(conn);
		}
		return true;
	}

	@Override
	public void insertAppToWait(String orgid) throws SQLException {
		conn = DbconnManager.getInstance().getConnection();
		PreparedStatement  pstmt=null;
		String sqlseq="select seq_android_wait.nextval from dual";
		ResultSet rs = null;
		pstmt = conn.prepareStatement(sqlseq);
		rs = pstmt.executeQuery();
		rs.next();
		String keyid =rs.getString("nextval");
		StringBuffer sql2 = new StringBuffer();
		sql2.append("insert into ta_android_wait (wait_id, business_table,BUSINESS_ID, synchronous_type, remark, create_time, is_num_type)");
		sql2.append(" values(?,'TA_ANDROID_APPSTORE_GIVEORG','-1', '2','菜单权限',sysdate,'2')");
		pstmt = conn.prepareStatement(sql2.toString());
		pstmt.setString(1, keyid);
		pstmt.executeUpdate();
		insertUserFlag(orgid,keyid);
		
	}

}
