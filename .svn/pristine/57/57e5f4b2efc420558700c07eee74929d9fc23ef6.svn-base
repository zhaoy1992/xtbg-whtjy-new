package com.chinacreator.xtbg.pub.countOlinePerson.dao;

import java.util.Set;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.countOlinePerson.entity.CountOnlineBean;
import com.chinacreator.xtbg.pub.countOlinePerson.entity.LoginUserbean;

public interface SessionListenerDao {
	//保存登录信息
 	void saveLoginInfo(CountOnlineBean cOnlineBean,String state)throws Exception;
 	//按用户保存登录次数和最后登录时间及退出时间
 	void saveUserLoginInfo(CountOnlineBean cOnlineBean)throws Exception;
 	//更新用户登录时间和ip地址及登录次数
 	void updateLoginInfo(CountOnlineBean cOnlineBean,String state)throws Exception;
 	//查询用户是否已有记录
 	boolean queryUser(CountOnlineBean cOnlineBean)throws Exception;
 	//保存最高人数
 	void saveTopInfo(String num)throws Exception;
 	//查询最高人数
 	String queryTop()throws Exception;
 	//查询用户登录信息
 	String queryPsersonInfo(String username) throws Exception;
 	//查询在线用户基本信息
 	PagingBean findloginsList(Set<Object> listset,LoginUserbean params,
			String sortName, String sortOrder, long offset, int maxPagesize)throws Exception;
}
