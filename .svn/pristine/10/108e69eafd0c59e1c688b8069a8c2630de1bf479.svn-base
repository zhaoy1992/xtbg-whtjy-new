package com.chinacreator.xtbg.pub.thread;

import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.RejectedExecutionHandler;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

/**
 * 
 *<p>Title:ThreadPoolUtils.java</p>
 *<p>Description:
 * 线程池辅助类，整个应用程序就只有一个线程池去管理线程。
 * 可以设置核心线程数、最大线程数、额外线程空状态生存时间，阻塞队列长度来优化线程池。</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2012-8-1
 */
public class ThreadPoolUtils {

	private ThreadPoolUtils() {

	}

	private  final static Object lock = new Object();
	// 池中所保存的线程数，包括空闲线程。
	private static int CORE_POOL_SIZE = 5;

	// 池中允许的最大线程数。
	private static int MAX_POOL_SIZE = 10;

	// 当线程数大于核心时，此为终止前多余的空闲线程等待新任务的最长时间。
	private static int KEEP_ALIVE_TIME = 1;
	
	//KEEP_ALIVE_TIME 参数的时间单位  秒
	private static TimeUnit UNIT  = TimeUnit.SECONDS; 
	
	//阻塞队列中最大等待任务数
	private static int MAX_WAIT_TASK = 3000;

	// 任务等待队列
	private static BlockingQueue<Runnable> workQueue = new ArrayBlockingQueue<Runnable>(MAX_WAIT_TASK);

	// 线程池
	private static ThreadPoolExecutor threadPool;
	
	public static ThreadPoolExecutor getInstance() {
		synchronized(lock) {
			if (threadPool == null) {
				threadPool = new ThreadPoolExecutor(CORE_POOL_SIZE, MAX_POOL_SIZE,
						KEEP_ALIVE_TIME, UNIT, workQueue, new RejectedExecutionHandler() {

							@Override
							public void rejectedExecution(Runnable r,
									ThreadPoolExecutor executor) {
								try{
									if (!executor.isShutdown()) {
										executor.getQueue().poll();
										executor.execute(r);
						            }
								}catch (Throwable e) {
									e.printStackTrace();
								}
							}
				});
			}
			return threadPool;
		}
	}
}

