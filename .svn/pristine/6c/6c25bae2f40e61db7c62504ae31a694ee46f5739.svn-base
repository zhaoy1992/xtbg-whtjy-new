package com.chinacreator.xtbg.core.workbench.cache;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.workbench.dao.UserLoginInfoDao;
import com.chinacreator.xtbg.core.workbench.entity.UserCacheBean;

/**
 *<p>Title:UserLoginInfoCache.java</p>
 *<p>Description:用户登录信息缓存处理线程</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-6-26
 */
public class UserLoginInfoThread extends Thread{
	
	private boolean auto;//线程是否启动
	
	private long interval = 60000;//线程轮询的时间间隔 默认为1分钟
	
	private long operDBInterval = 1800000;//入库的间隔时间  默认为 30分钟
	
	private int maxCount = 10;//最大的任务数  默认为10个任务
	
	private Object lock = new Object();
	
	private static final Log LOG = LogFactory.getLog(UserLoginInfoThread.class);
	
	private static int count = 0;//计数器
	
	private static List<UserCacheBean> dataList = new ArrayList<UserCacheBean>();
	
	private static long lastOperDB = System.currentTimeMillis(); //上次操作数据库的时间,默认为容器的启动时间
	
	private UserLoginInfoDao userLoginInfoDao;//用户登录信息操作dao
	
	/**
	*<b>Summary: </b>
	* addTask(添加任务)
	* @param bean
	*/
	public static void addTask(UserCacheBean bean){
		count++;
		/*if(dataList == null){
			dataList = new ArrayList<UserCacheBean>();
		}*/
		dataList.add(bean);
	}
	
	
	public void run() {
		if (auto) {	
			LOG.info("系统用户登录信息记录线程启动成功。");
			synchronized (lock) {
				while(true) {
					try {
 						if(dataList != null && dataList.size()>0){
							if((dataList.size() >= maxCount) || (System.currentTimeMillis() - lastOperDB >= operDBInterval)){//达到最大任务数或者操作时间达到最大间隔数
								userLoginInfoDao.operLoginInfo(dataList, null);
								taskRest();
							}
						}
					} catch (Exception e) {
						LOG.error("系统用户登录任务处理线程运行错误",e);
					} finally {
						try {
							lock.wait(interval);
						} catch (InterruptedException e) {
							LOG.error("系统用户登录任务处理线程等待错误",e);
						}
				
					}
				}
			}
		} else {
			LOG.info("系统用户登录任务处理线程设置为关闭,系统将不能实时提醒来文消息");
		}
	}
	
	/**
	*<b>Summary: </b>
	* taskRest(任务重置)
	*/
	private void taskRest(){
		dataList.clear();
		dataList = new ArrayList<UserCacheBean>();//入库成功之后将任务重置
	}
	
	public void setAuto(boolean auto) {
		this.auto = auto;
	}

	public void setInterval(long interval) {
		this.interval = interval;
	}

	public void setOperDBInterval(long operDBInterval) {
		this.operDBInterval = operDBInterval;
	}

	public void setMaxCount(int maxCount) {
		this.maxCount = maxCount;
	}

	public void setUserLoginInfoDao(UserLoginInfoDao userLoginInfoDao) {
		this.userLoginInfoDao = userLoginInfoDao;
	}
}
