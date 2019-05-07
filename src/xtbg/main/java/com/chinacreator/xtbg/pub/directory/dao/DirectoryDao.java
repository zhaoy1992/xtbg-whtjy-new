package com.chinacreator.xtbg.pub.directory.dao;

import java.sql.SQLException;
import java.util.List;

import com.chinacreator.sysmgrcore.entity.User;
import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.directory.entity.DirectoryBean;
import com.chinacreator.xtbg.pub.directory.entity.ListShowUtilBean;
import com.chinacreator.xtbg.pub.directory.entity.UserinfoBean;



/**
 *<p>Title:DirectoryDao.java</p>
 *<p>Description:名录管理dao层接口</p> 
 *<p>Company:湖南科创</p>
 *@author 刘春元
 *@version 1.0
 *2012-2-16
 */
public interface DirectoryDao {

	/**
	 * @Description 根据条件查询名录管理
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findTypeList(DirectoryBean typeBeanJson, String sortName, String sortOrder, long offset, int maxPagesize)throws Exception;
	
	/**
	 * @Description 添加名录管理
	 * @param typeBean 公告类型Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public String addType(DirectoryBean typeBean) throws Exception;
	

	
	/**
	 * @Description 添加名录管理(数据传输)
	 * @param typeBean 公告类型Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public void addTypeCS(DirectoryBean typeBean) throws Exception;
	
	
	/**
	 * @Description  删除名录管理根据数据传输关联值
	 * @param userIds
	 * @return boolean
	 * @throws SQLException 
	 */
	public boolean delTypeByPortalandoa_id(String portalandoa_id) throws SQLException;
	
	/**
	 * @Description  删除名录管理(数据传输表)根据数据传输关联值
	 * @param userIds
	 * @return boolean
	 * @throws SQLException 
	 */
	public boolean delTypeCsByPortalandoa_id(String portalandoa_id) throws SQLException;
	
	/**
	 * @Description  删除名录管理
	 * @param userIds
	 * @return boolean
	 * @throws SQLException 
	 */
	public boolean delType(String userIds) throws SQLException;
	
	/**
	 * @Description 修改名录管理
	 * @param typeBean 名录管理Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public void updateType(DirectoryBean typeBean) throws Exception;
	
	/**
	 * @Description 修改名录管理根据身份证
	 * @param typeBean 名录管理Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public void updateTypeByIdNum(DirectoryBean typeBean) throws Exception;
	
	/**
	 * @Description 修改名录管理根据身份证(数据传输表)
	 * @param typeBean 名录管理Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public void updateTypeCSByIdNum(DirectoryBean typeBean) throws Exception;
	
	/**
	 * @Description 根据用户ID获得名录管理
	 * @param typeBean 名录管理Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public DirectoryBean getTypeBeanById(String id,String listtype) throws SQLException;
	
	
	/**
	 * 获取公共通讯录首字母查询相关信息
	 * @param orgid
	 * @return
	 * @throws Exception
	 */
	public List<ListShowUtilBean> getFirstCodeShowInfo(String orgoruserid) throws Exception;
	
	/**
	 * @Description 管理员修改用户信息
	 * @param UserinfoBean 用户信息封装Bean
	 * @return void
	 * @throws SQLException 
	 */
	public void updateUserinfo(UserinfoBean userinfoBean) throws Exception;
	
	/**
	 * 查询查询用户是否在ta_oa_userandsn表中就记录
	 * @return 存在返回true,否则返回false
	 * @param usreid
	 * @throws Exception
	 */
	boolean queryuser(String userid)throws Exception; 
	
	/**
	 * 往ta_oa_userandsn中插入一条扩展记录
	 * @param usreid
	 * @throws Exception
	 */
	void insertuser(String usreid)throws Exception;
	
	/**
	 * 刘为玮2013-04-24修改
	 * @Description 保存人员照片
	 * @param imgsrc
	 * @return boolean
	 * @throws SQLException 
	 */
	public String Insertimg(String imgsrc,String imgid);
	
	/**
	 * 刘为玮2013-04-24修改
	 * @Description 根据user照片id删除关联图片
	 * @param imgsrc
	 * @return boolean
	 * @throws SQLException 
	 */
	public void delCarImg(String imgid);
	
	/**
	 * 刘为玮2013-04-24修改
	 * @Description 管理员修改用户信息(旺城专用)
	 * @param UserinfoBean 用户信息封装Bean
	 * @return void
	 * @throws SQLException 
	 */
	public void updateUserinfowc(User user) throws Exception;
	
	
	/**
	 * 刘为玮2013-04-24修改
	 * @Description 根据用户ID获得名录信息
	 * @param typeBean 名录管理Bean
	 * @return boolean
	 * @throws SQLException 
	 */
	public User getuserinfo(String id) throws SQLException;
	
	/**
	 * 陈建华2013-05-27 为望城增加
	*<b>Summary: 根据视图名称，查询出数据，并组装成select 的html</b>
	* createSelectHtml()
	* @param viewName
	* @param selected
	* @param selectName
	* @return
	 */
	public String createSelectHtml(String viewName,String selected,String selectName) throws SQLException;
	
	/**
	 * 陈建华2013-05-27 为望城增加
	*<b>Summary:根据系统参数ID，查询出系统参数值（次方法是提供个人简历，家庭成员模板）</b>
	* getSystemParameter()
	* @param paramId
	* @return
	* @throws SQLException
	 */
	public String getSystemParameter(String paramId) throws SQLException;
}
