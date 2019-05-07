package com.chinacreator.xtbg.core.process.flowprocessing.service.impl;

import java.io.File;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DateUtil;
import com.chinacreator.xtbg.core.common.util.FileUtil;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.common.util.WordToPDFConf;
import com.chinacreator.xtbg.core.common.util.WordToPDFUtil;
import com.chinacreator.xtbg.core.common.util.WordUtil;
import com.chinacreator.xtbg.core.mobile.util.FlowWordUtil;
import com.chinacreator.xtbg.core.process.flowprocessing.dao.impl.FlowUtilDaoImpl;
import com.chinacreator.xtbg.core.process.processconfig.dao.impl.FlowInfoDaoImpl;

/**
 * 
 * 在流程实例 各个环节处理 之后,有一些同样的事情需要处理,交给该对象处理
 *<p>Title:LastWorkFlowServiceImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author tuo.zou
 *@version 1.0
 *2014-10-14
 */
@SuppressWarnings("unchecked")
public class LastWorkFlowServiceImpl {
	/**
	 * 客户端类型:电脑
	 */
	public static final String CLIENT_PC="1";
	
	/**
	 * 客户端类型:手机
	 */
	public static final String CLIENT_PHONE="2";
	/**
	 * 处理暂存业务
	 */
	static final String HANDLE_TYPE_DOTEMP = "doTemp";
	/**
	 * 启动流程
	 */
	static final String HANDLE_TYPE_DOSTARTFLOW = "doStartFlow";
	/**
	 * 完成活动流程业务
	 */
	static final String HANDLE_TYPE_DOCOMPLETEACT = "doCompleteAct";
	/**
	 * 除第一环节外的暂存功能
	 */
	static final String HANDLE_TYPE_DOTEMPORARYSAVE = "doTemporarySave";
	/**
	 * 办结活动流程业务
	 */
	static final String HANDLE_TYPE_DOFLOWFINISH = "doFlowFinish";
	/**
	 * 终止流程业务
	 */
	static final String HANDLE_TYPE_DOTERMINATIONFLOW = "doTerminationFlow";
	/**
	 * 回退流程业务
	 */
	static final String HANDLE_TYPE_DOFLOWBACK = "doFlowBack";
	/**
	 * 
	 *<b>Summary: </b>
	 * handle(多种流程处理之后,需要再做同样的操作,这些操作集中写入该方法,例如转PDF)
	 * @param handleType
	 * @param flowInfo
	 * @param conn
	 */
	public synchronized void handle(String handleType,Map<Object, Object> flowInfo, Connection conn){
		WordToPDFConf conf = (WordToPDFConf)LoadSpringContext.getApplicationContext().getBean("WordToPDFConf");
		if(conf.isOpened()){
			//转PDF --------- begin
			//1:获得流程实例ID
			Map<String,String> bean = (Map<String,String>)flowInfo.get("flowCtrlInfo");
			Map<String,String> bean2 = (Map<String,String>)flowInfo.get("flowData");
			String action_handeridea = bean2.get("action_handeridea");
			boolean needCleanHJ = !CLIENT_PC.equals(flowInfo.get("clientType"));
			String insId = "";
			String userRealName= "";
			String actionId = "";//环节定义ID
			if(bean!=null){
				insId = bean.get("ins_id");
			}
			if(bean2!=null){
				if(StringUtil.nullOrBlank(insId)){
					insId = bean2.get("ins_id");
				}
				actionId = bean2.get("action_id");
				userRealName = bean2.get("userRealName");
				if(userRealName==null){
					userRealName = bean2.get("accepter");
				}
			}
			
			//2:获得word文件数据
			FlowUtilDaoImpl dao = new FlowUtilDaoImpl();
			Map<String,String> mess = dao.getDocmentAttachIdByInsId(insId,conn);
			if(mess!=null
					&&!StringUtil.nullOrBlank(mess.get("yw_id"))
					&&!StringUtil.nullOrBlank(userRealName)){//如果当前用户存在  并且 存在原文(带有面签单)
				//3:将word文件数据转 word文件
				File tmpFileUrl = new File(conf.getWordFileUrl());
				if(!tmpFileUrl.exists()){
					tmpFileUrl.mkdirs();
				}
String name = conf.getWordFileUrl();
				
				if(!StringUtil.isBlank(action_handeridea) && !"".equals(action_handeridea)){
					try {
						FlowInfoDaoImpl flowConfDao = new FlowInfoDaoImpl();
						Map<String,String> viewMap = flowConfDao.findFlowWfactionExtInfoById(actionId);
						//{"sign":"1,4,2"}
						String view_location =viewMap.get("view_location");
//						String view_location = "1,4,1";
//						Map<String, Object> map = new HashMap<String,Object>();
						if(null != view_location && !"".equals(view_location) ){
							//map = parseJSON2Map(view_location);
							String yiJianLoc =view_location;
							String content =action_handeridea;
							String time = DateUtil.getCurrentDate();
							Map<String,String> writeMap = new HashMap<String,String>();
							if(!StringUtil.nullOrBlank(yiJianLoc)){
								writeMap.put(yiJianLoc, content+" "+userRealName+" "+time);
								needCleanHJ = true;
							}else{
								System.out.println("没有配置意见位置");
							}
							if(writeMap.size()>0){
								FlowWordUtil wordUtil = new FlowWordUtil(insId);
								wordUtil.initWordFile(conn);
								boolean flag = wordUtil.writeWordFile(writeMap);
								if(flag){ 
									wordUtil.readWordFileIntoDB(conn);
								}
							}
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				//else{
					FileUtil.tableTodisk(name, mess.get("yw_id"), "docment",insId);
				//}
					File tmp = new File(name+insId+".doc");
					if(tmp.exists()){
						//4:将word文件转换成pdf文件
						WordToPDFUtil toPdfUtil = new WordToPDFUtil();
						File pdfFile = new File(conf.getPdfFileUrl()+insId+".pdf");
						toPdfUtil.docToPdf(tmp, pdfFile);
						System.out.println("最后的pdf:"+pdfFile.getPath());
						WordUtil wordUtil = new WordUtil();//警告:若在同一台电脑上启动应用，和通过浏览器处理流程，会出现问题，然后事实上没什么乱用
						wordUtil.wordToPdf(insId, mess.get("yw_id"),needCleanHJ);
					}else{
						System.out.println("生成需要转换的文件失败:"+tmp.getPath());
					}
				//4:转PDF
				/*WordUtil wordUtil = new WordUtil();
				wordUtil.wordToPdf(insId, mess.get("yw_id"),needCleanHJ);*/
				
			}else{
				System.out.println("生成WORD 与 转PDF的时候 找不到 原文ID, 或者 无法识别用户中文名");
			}
			//转PDF--------- end
		}else{
			System.out.println("未生成pdf文件 ，bean-wordtopdf.xml中的开关已经关闭");
		}
		
	}
	public  Map<String, Object> parseJSON2Map(String jsonStr){  
        Map<String, Object> map = new HashMap<String, Object>();  
        //最外层解析  
        JSONObject json = JSONObject.fromObject(jsonStr);  
        for(Object k : json.keySet()){  
            Object v = json.get(k);   
            //如果内层还是数组的话，继续解析  
            if(v instanceof JSONArray){  
                List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();  
                Iterator<JSONObject> it = ((JSONArray)v).iterator();  
                while(it.hasNext()){  
                    JSONObject json2 = it.next();  
                    list.add(parseJSON2Map(json2.toString()));  
                }  
                map.put(k.toString(), list);  
            } else {  
               map.put(k.toString(), v);  
            }  
        }  
        return map;  
    }  
}
