package com.chinacreator.xtbg.core.inspect.action;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.commonlist.PublicAjaxAction;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.inspect.entity.InspectBaseInfoBean;
import com.chinacreator.xtbg.core.inspect.entity.InspectReceptBean;
import com.chinacreator.xtbg.core.inspect.entity.InspectResponseBean;
import com.chinacreator.xtbg.core.inspect.service.InspectManageService;
import com.chinacreator.xtbg.core.inspect.service.impl.InspectManageServiceImpl;
import com.chinacreator.xtbg.core.inspect.util.InspectConstant;
/**
 * 
 *<p>Title:InspectManageAction.java</p>
 *<p>Description:督察督办管理action</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-10-29
 */
public class InspectManageAction extends PublicAjaxAction {
	private static final Logger LOG = Logger
			.getLogger(InspectManageAction.class);
	private InspectBaseInfoBean bean;//任务基本信息对象
	private InspectReceptBean recept;//任务接收对象
	private InspectResponseBean responseBean;//任务反馈对象
	
	private String action;//操作类型
	private String ids;//id列表	
	private String recept_userid;//任务接收人id
	/**
	 * 
	*<b>Summary:获得督察督办数据列表 </b>
	* findBaseInfoPageBean()
	 */
	public void findBaseInfoPageBean() {
		try {
			Map<String, String> map = new HashMap<String, String>();
			//将bean的属性赋值给map
			copyProperties(map,bean);
			InspectManageService service = new InspectManageServiceImpl();
			PagingBean pageBean = service.findBaseInfoPageBean(map, getPage());
			super.write4PagingBeanJson(pageBean);
		} catch (Exception e) {
			super.write4PagingBeanJson(null);
			LOG.error(e.getMessage(),e);
		}
	}
	/**
	 * 
	*<b>Summary:获得任务通知接收数据列表 </b>
	* findBaseInfoPageBean()
	 */
	public void findBaseInfoPageBean4recept() {
		try {
			Map<String, String> map = new HashMap<String, String>();
			//将bean的属性赋值给map
			copyProperties(map,bean);            
			copyProperties(map,recept);
			map.put("recept_userid", recept_userid);
			InspectManageService service = new InspectManageServiceImpl();
			PagingBean pageBean = service.findBaseInfoPageBean4recept(map, getPage());
			super.write4PagingBeanJson(pageBean);
		} catch (Exception e) {
			super.write4PagingBeanJson(null);
			LOG.error(e.getMessage(),e);
		}
	}
	/**
	 * 
	*<b>Summary:保存基本信息 </b>
	* saveBaseInfo()
	 */
	public void saveBaseInfo(){
		JSONObject json = new JSONObject();
		try {
			InspectManageService service = new InspectManageServiceImpl();
			Boolean flag = false;
			if(InspectConstant.ACTION_ADD.equals(action)){
				flag = service.saveBaseInfo(bean);
			}else{
				flag = service.updateBaseInfo(bean);
			}
			if(flag){
				json.put("flag", true);
				json.put("msg", "操作成功");
			}else{
				json.put("flag", false);
				json.put("msg", "操作失败");			
			}
			super.write(json);
		} catch (Exception e) {
			json.put("flag", false);
			json.put("msg", "操作失败");
			super.write(json);
			LOG.error(e.getMessage(),e);
		}
	}
	/**
	 * 
	*<b>Summary:删除任务信息 </b>
	* deleteBaseInfo()
	 */
	public void deleteBaseInfo(){
		JSONObject json = new JSONObject();
		try {
			InspectManageService service = new InspectManageServiceImpl();
			Boolean flag = false;
			flag = service.deleteBaseInfo(ids);
			if(flag){
				json.put("flag", true);
				json.put("msg", "操作成功");
			}else{
				json.put("flag", false);
				json.put("msg", "操作失败");			
			}
			super.write(json);
		} catch (Exception e) {
			json.put("flag", false);
			json.put("msg", "操作失败");
			super.write(json);
			LOG.error(e.getMessage(),e);
		}
	}
	/**
	 * 
	*<b>Summary: 办结任务</b>
	* overInspect()
	 */
	public void overInspect(){
		JSONObject json = new JSONObject();
		try {
			InspectManageService service = new InspectManageServiceImpl();
			Boolean flag = false;
			flag = service.overInspect(bean);
			if(flag){
				json.put("flag", true);
				json.put("msg", "操作成功");
			}else{
				json.put("flag", false);
				json.put("msg", "操作失败");			
			}
			super.write(json);
		} catch (Exception e) {
			json.put("flag", false);
			json.put("msg", "操作失败");
			super.write(json);
			LOG.error(e.getMessage(),e);
		}
	}
	/**
	 * 
	*<b>Summary:任务催办 </b>
	 */
	public void hurryInspect(){
		JSONObject json = new JSONObject();
		try {
			InspectManageService service = new InspectManageServiceImpl();
			Boolean flag = false;
			flag = service.hurryInspect(bean,ids);
			if(flag){
				json.put("flag", true);
				json.put("msg", "操作成功");
			}else{
				json.put("flag", false);
				json.put("msg", "操作失败");			
			}
			super.write(json);
		} catch (Exception e) {
			json.put("flag", false);
			json.put("msg", "操作失败");
			super.write(json);
			LOG.error(e.getMessage(),e);
		}
	}
	/**
	 * 
	*<b>Summary: 查询回复列表信息</b>
	* queryListResponse()
	 */
    public void queryListResponse(){
		JSONObject json = new JSONObject();
		try {
			InspectManageService service = new InspectManageServiceImpl();
			List<Map<String, String>> listResponse = service
					.queryListResponse(recept.getRecept_id());
			if (null != listResponse && !listResponse.isEmpty()) {
				json.put("flag", true);
				json.put("list", listResponse);
			} else {
				json.put("flag", false);
				json.put("list", null);
			}
			super.write(json);
		} catch (Exception e) {
			json.put("flag", false);
			json.put("list", null);
			super.write(json);
			LOG.error(e.getMessage(), e);
		}}
    /**
	 * 
	*<b>Summary:任务反馈  </b>
	 */
	public void responseInspect(){
		JSONObject json = new JSONObject();
		try {
			InspectManageService service = new InspectManageServiceImpl();
			Boolean flag = false;
			flag = service.responseInspect(responseBean);
			if(flag){
				json.put("flag", true);
				json.put("msg", "操作成功");
			}else{
				json.put("flag", false);
				json.put("msg", "操作失败");			
			}
			super.write(json);
		} catch (Exception e) {
			json.put("flag", false);
			json.put("msg", "操作失败");
			super.write(json);
			LOG.error(e.getMessage(),e);
		}
	}
	 /**
	 * 
	*<b>Summary:查询任务接收列表信息  </b>
	 */
	public void queryListRecept(){
		JSONObject json = new JSONObject();
		try {
			InspectManageService service = new InspectManageServiceImpl();
		    //查询接收单位反馈信息
		    List<Map<String,String>> receptList = service.queryRecept(bean.getInfo_id());
		    
			if(null!=receptList && !receptList.isEmpty()){
				json.put("flag", true);
				json.put("list", receptList);
			}else{
				json.put("flag", false);
				json.put("list", null);			
			}
			super.write(json);
		} catch (Exception e) {
			json.put("flag", false);
			json.put("list", null);
			super.write(json);
			LOG.error(e.getMessage(),e);
		}
	}
	/**
	 * 
	*<b>Summary:查询发牌列表数据 </b>
	* queryCardList()
	 */
	public void queryCardList(){
		try {
			Map<String, String> map = new HashMap<String, String>();
			//将bean的属性赋值给map
			copyProperties(map,bean);
			copyProperties(map,recept);
			InspectManageService service = new InspectManageServiceImpl();
			PagingBean pageBean = service.queryCardList(map, getPage());
			super.write4PagingBeanJson(pageBean);
		} catch (Exception e) {
			super.write4PagingBeanJson(null);
			LOG.error(e.getMessage(),e);
		}
	
	}
		
	public InspectBaseInfoBean getBean() {
		return bean;
	}

	public void setBean(InspectBaseInfoBean bean) {
		this.bean = bean;
	}

	public String getAction() {
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}

	/**
	 * 
	*<b>Summary:将Bean的属性值复制到map，为null或为空的则忽略 </b>
	* copyProperties()
	* @param map
	* @param obj
	* @throws IllegalArgumentException
	* @throws IllegalAccessException
	* @throws InvocationTargetException
	 */
	private void copyProperties(Map<String, String> map,Object obj) throws IllegalArgumentException, IllegalAccessException, InvocationTargetException{
		// 获得所有公共方法
		Method[] methods = obj.getClass().getMethods();
		Field[] fields = obj.getClass().getDeclaredFields();// 获取私有属性
		for(Field field : fields){
			// 获得赋值函数
			Method m = getMethod("get" + field.getName(), methods);
			String value = StringUtil.deNull(m.invoke(obj));
			if(!StringUtil.nullOrBlank(value)){
				map.put(field.getName(), value);
			}
		}
	}
	
	
	/**
	 * 
	*<b>Summary: 根据方法名，从方法数组中遍历得到方法</b>
	* getMethod()
	* @param methodName
	* @param methods
	* @return
	 */
	private Method getMethod(String methodName,Method[] methods){
		if(null == methodName || null == methods || methods.length == 0){
			return null;
		}
		for(Method method : methods){
			if(methodName.equalsIgnoreCase(method.getName())){
				return method;
			}
		}
		return null;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public String getRecept_userid() {
		return recept_userid;
	}

	public void setRecept_userid(String receptUserid) {
		recept_userid = receptUserid;
	}
	public InspectReceptBean getRecept() {
		return recept;
	}
	public void setRecept(InspectReceptBean recept) {
		this.recept = recept;
	}
	public InspectResponseBean getResponseBean() {
		return responseBean;
	}
	public void setResponseBean(InspectResponseBean responseBean) {
		this.responseBean = responseBean;
	}

}
