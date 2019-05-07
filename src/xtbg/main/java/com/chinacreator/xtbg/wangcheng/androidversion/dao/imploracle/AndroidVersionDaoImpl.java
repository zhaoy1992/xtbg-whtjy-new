package com.chinacreator.xtbg.wangcheng.androidversion.dao.imploracle;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.DbconnManager;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.wangcheng.androidversion.dao.AndroidVersionDao;
import com.chinacreator.xtbg.wangcheng.androidversion.entity.AndroidVersionBean;
import com.chinacreator.xtbg.wangcheng.androidversion.entity.AndroidVersionUpGradeLogBean;

/**
 * @description 移动版本控制
 * @author yin.liu
 * @date 2012-3-2
 */
public class AndroidVersionDaoImpl implements AndroidVersionDao {

	private static final Logger LOG = Logger.getLogger(AndroidVersionDaoImpl.class);
	private Connection conn;
	/**
	 * @Description 根据条件查询手机版本信息
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findAndroidVersionBeanList(AndroidVersionBean bean, String sortName, String sortOrder, long offset, int maxPagesize){
		PagingBean pb = new PagingBean();
		List<AndroidVersionBean> list = new ArrayList<AndroidVersionBean>();
		StringBuffer sql = new StringBuffer();
	    Statement pstmt = null;
		ResultSet rs = null;
		sql.append("select v.version_id,v.version_sn,v.version_esn,v.version_name,v.sql_sn,v.upload_path,v.up_time from TA_ANDROID_VERSION v where 1=1 ");
		
		if(bean != null){
			if(!StringUtil.isBlank(bean.getVersion_name())){
				sql.append(" and v.version_name like '%"+bean.getVersion_name()+"%'");
			}
			
			if(!StringUtil.isBlank(bean.getVersion_esn())){
				sql.append(" and v.version_esn like '%"+bean.getVersion_esn()+"%'");
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

					AndroidVersionBean b = new AndroidVersionBean();
					b.setVersion_id(rs.getString("version_id"));
					b.setVersion_sn(rs.getString("version_sn"));
					b.setVersion_esn(rs.getString("version_esn"));
					b.setVersion_name(rs.getString("version_name"));
					b.setSql_sn(rs.getString("sql_sn"));
					b.setUpload_path(rs.getString("upload_path"));
					b.setUp_time(rs.getString("up_time"));
					list.add(b);
				}
				count++;

			}
	
		}catch(Exception e){
			LOG.error("执行手机版本控制列表查询报错"+e.getMessage());
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
	 * @Description 根据条件查询客户端升级日志列表
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findAndroidVersionUpGradeLogBeanList(AndroidVersionUpGradeLogBean bean, String sortName, String sortOrder, long offset, int maxPagesize){
		PagingBean pb = new PagingBean();
		List<AndroidVersionUpGradeLogBean> list = new ArrayList<AndroidVersionUpGradeLogBean>();
		StringBuffer sql = new StringBuffer();
	    Statement pstmt = null;
		ResultSet rs = null;
		sql.append("select u.user_realname user_name,nvl(s.version_name,'版本已删除') version_name,s.version_esn,v.version_sn,v.userid,v.deviceid,to_char(v.createtime,'YYYY-MM-DD HH24:mi:ss') createtime from ta_android_version_upgradelog v left join td_sm_user u on v.userid=u.user_id left join  TA_ANDROID_VERSION s on s.version_sn=v.version_sn where 1=1 ");
		
		if(bean != null){
			if(!StringUtil.isBlank(bean.getVersion_name())){
				sql.append(" and nvl(s.version_name,'版本已删除') like '%"+bean.getVersion_name()+"%'");
			}
			if(!StringUtil.isBlank(bean.getUserid())){
				//sql.append(" and ',"+bean.getUserid()+",' like '%,'||v.userid||',%'  ");
				sql.append(" and instr(',"+bean.getUserid()+",',','||v.userid||',') > 0  ");
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

					AndroidVersionUpGradeLogBean b = new AndroidVersionUpGradeLogBean();
					b.setUser_name(rs.getString("user_name"));
					b.setVersion_name(rs.getString("version_name"));
					b.setVersion_sn(rs.getString("version_sn"));
					b.setUserid(rs.getString("userid"));
					b.setDeviceid(rs.getString("deviceid"));
					b.setCreatetime(rs.getString("createtime"));
					b.setVersion_esn(rs.getString("version_esn"));
					list.add(b);
				}
				count++;

			}
	
		}catch(Exception e){
			LOG.error("执行客户端升级日志列表查询报错"+e.getMessage());
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
	
	//VERSION_ID,VERSION_SN,VERSION_ESN,VERSION_NAME,SQL_SN,UPLOAD_PATH,UP_TIME,IS_MUST_INSTALL,VERSION_CONTENT


	
	/**
	 * 插入手机版本信息
	 * @param bean
	 */
	public void insertAndroidVersionBean(AndroidVersionBean bean) throws Exception{
		String sql = "";
		PreparedStatement  pstmt=null;
		try {
			conn = DbconnManager.getInstance().getConnection();
			
			if(!StringUtil.isBlank(bean.getVersion_id())){//更新
				sql ="update TA_ANDROID_VERSION set version_content=?,is_must_install=? where version_id=? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,bean.getVersion_content());
				pstmt.setString(2,bean.getIs_must_install());
				pstmt.setString(3,bean.getUpgrade_rangeid());
				pstmt.setString(4,bean.getUpgrade_rangevalue());
				pstmt.setString(5,bean.getVersion_id());
			}else{//新增
				sql="insert into TA_ANDROID_VERSION" +
				"(VERSION_ID,VERSION_SN,VERSION_ESN,VERSION_NAME,SQL_SN,UPLOAD_PATH,UP_TIME,IS_MUST_INSTALL,VERSION_CONTENT)" +
				"values(seq_androidversion.nextVal,?,?,?,?,?,sysdate,?,?)";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,bean.getVersion_sn());
				pstmt.setString(2, bean.getVersion_esn());
				pstmt.setString(3, bean.getVersion_name());
				pstmt.setString(4, bean.getSql_sn());
				pstmt.setString(5, bean.getUpload_path());
				pstmt.setString(6, bean.getIs_must_install());
				pstmt.setString(7, bean.getVersion_content());
			}
			
			pstmt.executeUpdate();
		}catch(Exception e){
			LOG.error("插入或更新手机版本控制报错"+e.getMessage());
			
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
	 * 根据id删除手机版本信息
	 * @param id
	 * @return
	 */
	public boolean delAndroidVersionBean(String id) throws Exception{
		String sql = "delete from TA_ANDROID_VERSION a where a.version_id in ("+ id + ")";
		PreparedStatement  pstmt=null;
		try{
			conn = DbconnManager.getInstance().getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.executeUpdate();
		}catch(Exception e){
			LOG.error("删除手机版本控制报错"+e.getMessage());
			
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
	
	/**
	 * 根据id获取版本信息
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public AndroidVersionBean getAndroidVersionBeanByid(String id) throws Exception{
		AndroidVersionBean b = new AndroidVersionBean();
		StringBuffer sql = new StringBuffer();

		PreparedStatement  pstmt = null;
		ResultSet rs = null;

		sql.append("select v.version_id,v.version_sn,v.version_esn,v.version_name,v.sql_sn,v.upload_path,v.up_time,version_content,is_must_install from TA_ANDROID_VERSION v where v.version_id = ? ");
		try {
			conn = DbconnManager.getInstance().getConnection();
			pstmt = conn.prepareStatement(sql.toString());
		    pstmt.setString(1,id);	
			rs = pstmt.executeQuery();
			while(rs.next()){	
	    		b.setVersion_id(rs.getString( "version_id"));
	    		b.setVersion_sn(rs.getString("version_sn"));
	    		b.setVersion_esn(rs.getString("version_esn"));
	    		b.setVersion_name(rs.getString("version_name"));
	    		b.setSql_sn(rs.getString("sql_sn"));
	    		b.setUpload_path(rs.getString("upload_path"));
	    		b.setUp_time(rs.getString("up_time"));
	    		b.setVersion_content(rs.getString("version_content"));
	    		b.setIs_must_install(rs.getString("is_must_install"));
	    	}
		}catch(Exception e){
			LOG.error("执行手机版本控制条件查询报错"+e.getMessage());
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
		
		return b;
	}
	
	/**
	 * 根据版本名称查询是否存在
	 * @param name
	 * @return
	 * @throws Exception
	 */
	public boolean isHasByversionName(String name) throws Exception{
		boolean flag = false;
		StringBuffer sql = new StringBuffer();
		PreparedStatement  pstmt = null;
		ResultSet rs = null;
		sql.append("select v.version_id,v.version_sn,v.version_esn,v.version_name,v.sql_sn,v.upload_path,v.up_time from TA_ANDROID_VERSION v where v.version_name = ? ");
		try {
			conn = DbconnManager.getInstance().getConnection();
			pstmt = conn.prepareStatement(sql.toString());
		    pstmt.setString(1,name);	
			rs = pstmt.executeQuery();
	    	if(rs.next()){
	    		flag = true;
	    	}
		}catch(Exception e){
			LOG.error("根据版本名称查询是否存在"+e.getMessage());
	
		}finally{
			try {//关闭资源
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			DbconnManager.closeConnection(conn);
		}

		return flag;
	}
	
	/**
	 * 获得当前最新版本的名称
	 * @param userid
	 * @return
	 */
	public String getCurrentMaxVersionName()
	{
		String sql = "select version_name from TA_ANDROID_VERSION t order by t.version_sn desc,t.version_id desc ";
		String currentMaxName = "";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Connection conn = null;
		try
		{
			conn = DbconnManager.getInstance().getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				currentMaxName = rs.getString("version_name");
			}
		}
		catch (SQLException e)
		{
			LOG.error(e.getMessage());
		}finally
		{
			try
			{// 关闭资源
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				DbconnManager.closeConnection(conn);
			}catch (SQLException e)
			{
				LOG.error(e.getMessage());
			}
		}

		return currentMaxName;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 saveAndroidVersionBean
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.wangcheng.androidversion.dao.AndroidVersionDao#saveAndroidVersionBean(com.chinacreator.xtbg.wangcheng.androidversion.entity.AndroidVersionBean)
	 */
	public boolean saveAndroidVersionBean(AndroidVersionBean bean) throws Exception{
		StringBuffer sql = new StringBuffer();
		PreparedStatement  pstmt=null;
		boolean flag = false;
		conn = DbconnManager.getInstance().getConnection();
		sql.append("insert into ta_android_version ");
		sql.append("(version_id,version_sn,version_esn,version_name,upload_path,up_time,is_must_install,version_content)");
		sql.append("values(?,?,?,?,?,sysdate,?,?)");
		pstmt = conn.prepareStatement(sql.toString());
		int n = 1;
		pstmt.setString(n++,StringUtil.deNull(bean.getVersion_id()));
		pstmt.setString(n++,StringUtil.deNull(bean.getVersion_sn()));
		pstmt.setString(n++, StringUtil.deNull(bean.getVersion_esn()));
		
		pstmt.setString(n++, StringUtil.deNull(bean.getVersion_name()));
		pstmt.setString(n++, StringUtil.deNull(bean.getUpload_path()));
		
		pstmt.setString(n++, StringUtil.deNull(bean.getIs_must_install()));
		pstmt.setString(n++, StringUtil.deNull(bean.getVersion_content()));
		pstmt.executeUpdate();
		conn.close();
		flag = true;
		return flag;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 updateAndroidVersionBean
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.wangcheng.androidversion.dao.AndroidVersionDao#updateAndroidVersionBean(com.chinacreator.xtbg.wangcheng.androidversion.entity.AndroidVersionBean)
	 */
	public boolean updateAndroidVersionBean(AndroidVersionBean bean) throws Exception{
		StringBuffer sql = new StringBuffer();
		PreparedStatement  pstmt=null;
		conn = DbconnManager.getInstance().getConnection();
		boolean flag = false;
		sql.append("update ta_android_version set version_content=?,is_must_install=? where version_id=? ");
		pstmt = conn.prepareStatement(sql.toString());
		int n = 1;
		pstmt.setString(n++,StringUtil.deNull(bean.getVersion_content()));
		pstmt.setString(n++,StringUtil.deNull(bean.getIs_must_install()));
		pstmt.setString(n++,StringUtil.deNull(bean.getVersion_id()));
		flag = true;
		return flag;
	}

	@Override
	public int queryMaxXuHao() throws Exception {
		conn = DbconnManager.getInstance().getConnection();
		StringBuffer sql = new StringBuffer();
		PreparedStatement  pstmt=null;
		sql.append("select max(v.version_sn) max_version_sn  from TA_ANDROID_VERSION v ");
		pstmt = conn.prepareStatement(sql.toString());
		ResultSet rs = pstmt.executeQuery();
		int max = -1;
		if(rs.next()){
			max = rs.getInt("max_version_sn");
		}
		return max+1;
	}
}
