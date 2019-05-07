package com.chinacreator.xtbg.core.common.msgcenter.cache;

import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import javax.annotation.PostConstruct;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import com.chinacreator.xtbg.core.common.msgcenter.dao.MessageCenterDao;

/**
 *<p>Title:MessageCache.java</p>
 *<p>Description:消息缓存中心</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-5-28
 */
public class MessageCache {
	
	private static final Log LOG = LogFactory.getLog(MessageCache.class);
	
	private MessageCenterDao messageCenterDao = null;
	
	public void setMessageCenterDao(MessageCenterDao messageCenterDao) {
		this.messageCenterDao = messageCenterDao;
	}

	/**
	 * 消息缓存   Map&lt;userID,Map&lt;msgID,Object&gt;&gt;<br/>
	 * ConcurrentHashMap是Java 5中支持高并发、高吞吐量的线程安全HashMap实现  <br/>
	 * 键和值都不可以为 null
	 */
	private static Map<String,Map<String,Object>> messageCache = new ConcurrentHashMap<String, Map<String,Object>>();
	
	/**
	*<b>Summary: </b>
	* initCacheOnStart(启动容器时将未查看的消息加载到缓存中)
	*/
	@PostConstruct
	public void initCacheOnStart(){
		try {
			List<Map<String,String>> messageSendList = messageCenterDao.queryWaitReadMessage(null);
			if(messageSendList != null){
				for(Map<String,String> map : messageSendList){
				    addMessage(map.get("recv_userid"),map.get("recv_id"));
				}
			}
			LOG.info("成功加载所有未读的站内消息到缓存");
		} catch (Exception e) {
			LOG.error("初始化加载未读站内消息到内存时异常", e);
		}
	}
	
	/**
	*<b>Summary: </b>
	* getALlMessageCache(获取所有用户的未阅读的站内消息)
	* @return
	*/
	public static Map<String,Map<String,Object>> getALlMessageCache(){
		return messageCache;
	}
	
	/**
	*<b>Summary: </b>
	* getUserMessageCache(获取指定用户的未阅读的站内消息)
	* @param user_id
	* @return
	*/
	public static Map<String,Object> getUserMessageCache(String user_id){
		return messageCache.get(user_id);
	}
	/**
	 * 
	*<b>Summary:获得用户未读消息条数 </b>
	* getUserUnReadCount()
	* @param user_id
	* @return
	 */
	public static Integer getUserUnReadCount(String user_id){
		if(messageCache.containsKey(user_id)){
			return messageCache.get(user_id).size();
		}else{
			return 0;
		}		
	}
	/**
	*<b>Summary: </b>
	* addMessage(向缓存中添加新消息,请确保参数都不能为null，否则将不向换成中添加消息)
	* @param user_id 消息接收人用户id
	* @param msg_id	消息主键id
	* @param messageSendBean 消息实体
	*/
	public static void addMessage(String user_id,String recv_id,Object bean){
		if(user_id != null && recv_id != null ){//所有参数都不为null 才进行处理
			if(messageCache.containsKey(user_id)){//存在此用户的未读消息
				messageCache.get(user_id).put(recv_id,bean);
			}else{//不存在此用户的未读消息
				Map<String,Object> msgMap = new ConcurrentHashMap<String, Object>();
				msgMap.put(recv_id, bean);
				messageCache.put(user_id, msgMap);
			}
		} 
	}
	/**
	 * 
	*<b>Summary: 由于只需要统计个数，不需要具体消息内容，故暂不传入实体对象</b>
	* addMessage()
	* @param user_id
	* @param recv_id
	* @param bean
	 */
	public static void addMessage(String user_id,String recv_id){
		//暂时将空字符串加入缓存，如果到时候需要缓存消息数据，再扩展
		addMessage(user_id,recv_id,"");
	}
	
	/**
	 * 
	*<b>Summary:批量添加 </b>
	* addMessage()
	* @param user_id
	* @param recv_ids
	 */
	public static void addMessage(String user_id,List<String> recv_ids){
		if(null!=recv_ids){
			for(String id : recv_ids){
				addMessage(user_id,id);
			}
		}		
	}
	
	/**
	*<b>Summary: </b>
	* addMessage(向缓存中添加新消息，请确保参数都不能为null，否则将不向换成中添加消息)
	* @param user_ids 消息接收人用户id 集合
	* @param msg_id	消息主键id
	* @param messageSendBean 消息实体
	*/
	public static void addMessage(List<String> user_ids,String recv_id,Object messageSendBean){
		if(user_ids != null){
			for(String user_id : user_ids){
				addMessage(user_id,recv_id,messageSendBean);
			}
		}
	}
	
	/**
	*<b>Summary: </b>
	* deleteMessage(删除缓存中消息)
	* @param user_id 消息接收用户id
	* @param msg_id	消息主键id
	*/
	public static void deleteMessage(String user_id,String recv_id){
		if(user_id != null && recv_id != null){
			if(messageCache.containsKey(user_id)){
				if(messageCache.get(user_id).containsKey(recv_id)){
					messageCache.get(user_id).remove(recv_id);//根据消息id 删除缓存
					if(messageCache.get(user_id).size() == 0){//此用户已无 未读消息
						messageCache.remove(user_id);//根据用户id 删除缓存
					}
				}
			}
		}
	}
	
	/**
	*<b>Summary: </b>
	* deleteMessage(批量删除缓存中消息)
	* @param user_id 消息接收用户id
	* @param msg_ids 消息主键id集合
	*/
	public static void deleteMessage(String user_id,List<String> recv_ids){
		if(recv_ids != null){
			for(String recvId : recv_ids){
				deleteMessage(user_id, recvId);
			}
		}
	}
	/**
	 * 
	*<b>Summary:清空当前用户的所有未读信息 </b>
	* deleteMessage()
	* @param userId
	 */
	public static void deleteMessage(String userId){
		if(null != userId ){
			if(messageCache.containsKey(userId)){
				messageCache.remove(userId);
			}
		}
	}
}
