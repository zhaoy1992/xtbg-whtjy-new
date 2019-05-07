package com.chinacreator.xtbg.core.process.flowprocessing.tag;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.eform.business.InstanceIdManager;
import com.chinacreator.security.AccessControl;
import com.chinacreator.xtbg.core.archive.tag.ArchiveInitTag;
import com.chinacreator.xtbg.core.archive.tag.ColumnDisplayBean;
import com.chinacreator.xtbg.core.common.cache.UserCache;
import com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean;
import com.chinacreator.xtbg.core.common.commonlist.Constant;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.dssave.dao.DsCRUDDao;
import com.chinacreator.xtbg.core.dssave.dao.impl.DsCRUDDaoImpl;
import com.chinacreator.xtbg.core.dssave.entity.MdTableBean;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.FlowDefinfoBean;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.FlowWfactionBean;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.FlowWfactionExtBean;
import com.chinacreator.xtbg.core.process.flowprocessing.entity.InstanceBean;
import com.chinacreator.xtbg.core.process.flowprocessing.service.InitFlowServiceIfc;
import com.chinacreator.xtbg.core.process.flowprocessing.service.impl.InitFlowServiceImpl;
import com.chinacreator.xtbg.core.process.flowprocessing.util.FlowClassUtil;


/**
 *<p>Title:</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *@date 2013-4-9
 */
public class FlowStartTag extends TagSupport{


	private static final long serialVersionUID = 1L;
	
	private static final Log LOG = LogFactory.getLog(FlowCommonAlertStartTag.class);
	
	private String flowType;

	public String getFlowType() {
		return flowType;
	}


	public void setFlowType(String flowType) {
		this.flowType = flowType;
	}


	@Override
	public int doStartTag() throws JspException {
		StringBuffer htmlString = new StringBuffer();
		
		HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();
		HttpServletResponse response = (HttpServletResponse)pageContext.getResponse();
		String flowType = StringUtil.deNull(request.getParameter("actiontype_code"));
		String businessType = StringUtil.deNull(request.getParameter("busiTypeCode"));
		String actiontype_code = StringUtil.deNull(request.getParameter("actiontype_code"));
		String is_agency = StringUtil.deNull(request.getParameter("is_agency"));//是否代理
		String entrust_user_name = StringUtil.deNull(request.getParameter("entrust_user_name"));//代理人
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
		String ins_id = request.getParameter("ins_id"); //实例ID
		try {
			//加载流程相关参数
			String initType = "1";  //1表示受理环节， 2表示中间环节，3表示办结环节
			if(StringUtil.isBlank(actiontype_code)) {//第一环节
				
			} else if("02".equals(actiontype_code)) {//中间环节
				initType = "2";
			} else if("03".equals(actiontype_code)){//最后环节
				initType = "3";
			} else if("04".equals(actiontype_code)) {//已办列表进入库
				initType = "4";
			}
			
			htmlString.append("<script type='text/javascript' src='ccapp/oa/resources/util/inputideaarea.js'></script>");//签字JS
			htmlString.append("<script type='text/javascript' src='ccapp/oa/process/flowprocessing/js/commonflowdo.js'></script>");//流程发起JS
			//TODO 此处应该根据控件的不同，引用不同的JS。操作按钮JS
			htmlString.append("<script type='text/javascript' src='ccapp/oa/process/flowprocessing/js/workflowgoldgrid.js'></script>");
			
			Map<String, String> initmap = null;
			String action_id = "";
			String pageParmsjsonstr = "";
			if(!"4".equals(initType)) { //不是已办列表进入
				initmap = new HashMap<String, String>();
				initmap = initFlowStart(request,response, initType);
				initmap.put("basePath", basePath);
				action_id = initmap.get("action_id");
				JSONObject pageParmsjson = new JSONObject();
				pageParmsjson.put("flowParmJson", initmap); //将map对
				pageParmsjsonstr = pageParmsjson.toString();
			
				//操作类型
				htmlString.append("<script type='text/javascript'>");
				htmlString.append("var parms =  ");
				htmlString.append(pageParmsjsonstr);
				htmlString.append("</script>");
				
				//加入验证
				htmlString.append("<script type='text/javascript'>");
				htmlString.append("jQuery(document).ready(function() {");
				htmlString.append("	  jQuery('#form1').validationEngine();");
				htmlString.append("});");
				htmlString.append("</script>");
			} else {
				initmap = new HashMap<String, String>();
				initmap.put("basePath", basePath);
				initmap.put("ins_id", ins_id);
				JSONObject pageParmsjson = new JSONObject();
				pageParmsjson.put("flowParmJson", initmap); //将map对
				pageParmsjsonstr = pageParmsjson.toString();
				htmlString.append("<script type='text/javascript'>");
				htmlString.append("var parms =  ");
				htmlString.append(pageParmsjsonstr);
				htmlString.append("</script>");
				
			}
			//this.columnDisplay
			Map<String,Map<String,ColumnDisplayBean>>  columnDisplay  =  getcolumnDisplay(action_id,businessType);
			//将环节ID插入该扩展属性。在正文中会用到该ID
			Map<String,String> examParam = new HashMap<String,String>();
			examParam.put("action_id", action_id);//环节ID
			examParam.put("initType", initType);//环节类型
			
			ArchiveInitTag data = (ArchiveInitTag) this.getParent(); // 获得父标签实例
			
			data.setColumnDisplay(columnDisplay); //重要！  在这里将字段的显示形式设置进父INIT标签。
			data.setExamParam(examParam); //重要！  在这里将action_id设置进父INIT标签。
			//加载流程相关参数 end 
			
			//根据环节ID初始化操作按钮
			String buttonString = this.initButton(action_id,flowType);
			htmlString.append(buttonString);
			
			//组装环节，选择执行人，操作按钮
			if(StringUtil.isBlank(flowType)) {
				flowType = "01";
			}
			if("01".equals(flowType)) { //受理
				//环节名称
				htmlString.append("	<input type=\"hidden\" class=\"cText_out\" id=\"xzsp_workflowControl_selectAct\" name=\"xzsp_workflowControl_selectAct\" />");
				//人员选择
				htmlString.append("	<input type=\"hidden\" class=\"cText_out\" id=\"DYNAMICPERFORMER\" name=\"DYNAMICPERFORMER\" />");
				htmlString.append("	<input type=\"hidden\" class=\"cText_out\" id=\"DYNAMICPERFORMER_ID\" name=\"DYNAMICPERFORMER_ID\" />");
				htmlString.append("	<input type=\"hidden\" class=\"cText_out\" id=\"DYNAMICPERFORMER_REALNAME\" name=\"DYNAMICPERFORMER_REALNAME\" />");
		
			} else if("02".equals(flowType)) { //中间环节
				//环节名称
				htmlString.append("	<input type=\"hidden\" class=\"cText_out\" id=\"xzsp_workflowControl_selectAct\" name=\"xzsp_workflowControl_selectAct\" />");
				//人员选择
				htmlString.append("	<input type=\"hidden\" class=\"cText_out\" id=\"DYNAMICPERFORMER\" name=\"DYNAMICPERFORMER\" />");
				htmlString.append("	<input type=\"hidden\" class=\"cText_out\" id=\"DYNAMICPERFORMER_ID\" name=\"DYNAMICPERFORMER_ID\" />");
				htmlString.append("	<input type=\"hidden\" class=\"cText_out\" id=\"DYNAMICPERFORMER_REALNAME\" name=\"DYNAMICPERFORMER_REALNAME\" />");
				
			} else if("03".equals(flowType)) { //最后的环节
				
			} else if("04".equals(flowType)) { //已办列表进入
				
			}
			//组装环节，选择执行人，操作按钮 end
			//隐藏参数区 
			htmlString.append("<input id=\"flowData\" name=\"flowData\" type=\"hidden\"/>");
			htmlString.append("<input id=\"busiData\" name=\"busiData\" type=\"hidden\"/>");
			htmlString.append("<input id=\"classNameId\" name=\"classNameId\" type=\"hidden\"/>");
			htmlString.append("<input id=\"bigColumnsValue\" name=\"bigColumnsValue\" type=\"hidden\"/>");
			htmlString.append("<input id=\"action_handeridea\" name=\"action_handeridea\" type=\"hidden\"/>");
			htmlString.append("<input id=\"xzspWorkflowType\" name=\"xzspWorkflowType\" type=\"hidden\"/>");
			htmlString.append("<input id=\"flowTache\" name=\"flowTache\" type=\"hidden\"/>");
			htmlString.append("<input id=\"isDynamicSelectAct\" name=\"isDynamicSelectAct\" type=\"hidden\"/>");
			htmlString.append("<input id=\"isDynamicSelectUser\" name=\"isDynamicSelectUser\" value=\"\" type=\"hidden\"/>");
			htmlString.append("<input id=\"isDynamicSelectAndAct\" name=\"isDynamicSelectAndAct\" type=\"hidden\"/>");
			htmlString.append("<input id=\"nextActList\" name=\"nextActList\" type=\"hidden\"/>");
			htmlString.append("<input id=\"nextActId\" name=\"nextActId\" type=\"hidden\"/>");
			htmlString.append("<input id=\"insname_rule\" name=\"insname_rule\" type=\"hidden\"/>");
			htmlString.append("<input id=\"initType\" name=\"initType\" value="+initType+" type=\"hidden\"/>");
			htmlString.append("<input id=\"isSaveData\" name=\"isSaveData\" type=\"hidden\"/>");//存档信息隐藏域
			htmlString.append("<input id=\"saveData\" name=\"saveData\" type=\"hidden\"/>");//存档信息隐藏域
			htmlString.append("<input id=\"is_agency\" name=\"is_agency\" value=\""+is_agency+"\" type=\"hidden\"/>");//是否是代理
			htmlString.append("<input id=\"entrust_user_name\" name=\"entrust_user_name\" value=\""+entrust_user_name+"\" type=\"hidden\"/>");//代理人
			//意见信息列表
			htmlString.append("<input id=\"views\" name=\"views\" type=\"hidden\"/>");
			pageContext.getOut().write(htmlString.toString());
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		} 
		return EVAL_PAGE;
		
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* initFlowStart(流程初始化)
	* @param request
	* @param response
	* @param initType
	* @return
	* @throws Exception
	 */
	public Map<String, String> initFlowStart(HttpServletRequest request, HttpServletResponse response, String initType) throws Exception {
		Map<String, String> initmap = new HashMap<String, String>();
		
		
		AccessControl accesscontroler = AccessControl.getInstance();
		accesscontroler.checkAccess(request, response);
		
		String userName = accesscontroler.getUserAccount(); //用户名称
		String userRealName = accesscontroler.getUserName();
		//String orgId = accesscontroler.getChargeOrgId(); //用户的机构ID
		String user_id = accesscontroler.getUserID();
		
		//获取用户信息
		UserCacheBean userBean = UserCache.getUserCacheBean(user_id);
		String userOrgId  =  userBean.getOrg_id();
		String userOrgName = userBean.getOrg_name();
		String unitId = userBean.getUnit_id();
		String unitName = userBean.getUnit_name();
		
		String entrance = request.getParameter("entrance");
		String mgrName = request.getParameter("mgrName");
		String ins_code = request.getParameter("ins_code"); //实例编码
		String def_id = request.getParameter("def_id");//流程定义ID
		String action_defid = request.getParameter("action_defid");  //活动定义ID

		String actInsId = request.getParameter("actInsId");  //活动实例ID
		String procId = request.getParameter("procId");
		String actiontype_code = request.getParameter("actiontype_code");  //活动类型编号
		
		String ins_id = request.getParameter("ins_id"); //实例ID
		String cc_form_instanceid = request.getParameter("cc_form_instanceid"); //平台业务ID
		String busiTypeCode = request.getParameter("busiTypeCode"); //流程类型编码
		String operType = request.getParameter("operType"); //操作类型
		String openFlag = request.getParameter("openFlag");//取得removewindow的id;
		String busi_id = request.getParameter("busi_id");  //业务ID
		String template_id = request.getParameter("template_id");  //WORD模板ID

		if (StringUtil.isBlank(ins_id)) {
			ins_code = FlowClassUtil.getNewInstanceCode(busiTypeCode); //实例编号
			//ins_id = StringUtil.getUUID(); //不能再此处初始化
		}
		
		if (StringUtil.isBlank(cc_form_instanceid)) { //新受理生成平台业务ID
			cc_form_instanceid = InstanceIdManager.getFormInstanceId();
		}
		
		String fromPage = "tabs-1";
		
		if ("daiban".equals(operType)) {
			fromPage = "tabs-1";
		} else if ("nosend".equals(operType)) {
			fromPage = "tabs-2";
		} else if ("yiban".equals(operType)) {
			fromPage = "tabs-3";
		}
		
		String isDynamicSelectUser = Constant.STATUS_FALSE; //是否动态选择或活动执行人
		String isShowBack = Constant.STATUS_FALSE;  //是否回退 
		String isDispense = Constant.STATUS_FALSE;  //是否分发
		String isSignCount = Constant.STATUS_FALSE;  //是否会签
		String opType = "isShowActSelectText@isShowUserText@isShowBackButton@isShowRecycle@isShowCompleteWorkflow@isShowTempSaveForm@isShowTerminate@isShowSuspend@isShowResume";//流程行为标识
		
		//初始化要用的参数
		initmap.put("initType", initType);
		initmap.put("entrance", entrance);
		initmap.put("fromPage", fromPage);
		initmap.put("openFlag", openFlag);
		initmap.put("procId", procId);
		initmap.put("busi_id", busi_id);
		initmap.put("action_defid", action_defid);
		initmap.put("actiontype_code", actiontype_code);
		initmap.put("orgId", userOrgId);
		initmap.put("orgName", userOrgName);
		initmap.put("unitId", unitId);
		initmap.put("unitName", unitName);
		initmap.put("userName", userName);
		initmap.put("userRealName", userRealName);
		initmap.put("user_id", user_id);
		initmap.put("busiTypeCode", busiTypeCode);
		initmap.put("ins_id", ins_id);
		initmap.put("opType", opType);
		initmap.put("actInsId", actInsId);
		initmap.put("cc_form_instanceid", cc_form_instanceid);
		initmap.put("ins_code", ins_code);
		initmap.put("def_id", def_id);
		initmap.put("operType", operType);
		initmap.put("template_id", template_id);
		String flowinfo = "";//流程信息
		String actionAliasAndOrderStr = ""; //环节别名与排序
		String actUsertList= "";
		FlowDefinfoBean flowDefinfoBean = null; //流程定义Bean
		FlowWfactionBean flowWfactionBean = null; //活动定义Bean
		FlowWfactionExtBean flowWfactionExtBean = null; //流程活动扩展Bean
		InstanceBean instanceBean = null; //实例Bean
		
		InitFlowServiceIfc initFlowServiceIfc = new InitFlowServiceImpl();
		
		//加载流程相关
		Map<String, Object> map = initFlowServiceIfc.init(initmap);

		if (map.get("instanceBean") != null) {
			instanceBean = (InstanceBean) map.get("instanceBean");//活动定义Bean
			initmap.put("status_code", instanceBean.getStatus_code());
		}

		if (map.get("flowDefinfoBean") != null) {
			flowDefinfoBean = (FlowDefinfoBean) map.get("flowDefinfoBean");//流程定义Bean
			mgrName = flowDefinfoBean.getPackage_id() + "#" + flowDefinfoBean.getFlow_version() + "#" + flowDefinfoBean.getFlow_defid();
			initmap.put("mgrName", mgrName);
			initmap.put("action_defid", flowDefinfoBean.getAction_defid());
			initmap.put("flow_id", flowDefinfoBean.getFlow_id());
			initmap.put("action_form", flowDefinfoBean.getAction_form());
			initmap.put("insname_rule", flowDefinfoBean.getInsname_rule());
		}

		if (map.get("flowWfactionBean") != null) {
			flowWfactionBean = (FlowWfactionBean) map.get("flowWfactionBean");//活动定义Bean
			initmap.put("def_id", flowWfactionBean.getDef_id());
			initmap.put("action_id", flowWfactionBean.getAction_id());
			initmap.put("action_name", flowWfactionBean.getAction_name());
		}

		if (map.get("flowWfactionExtBean") != null) {
			flowWfactionExtBean = (FlowWfactionExtBean) map
					.get("flowWfactionExtBean");//活动定义Bean
			isDynamicSelectUser = flowWfactionExtBean.getIsshowuser();
			isShowBack = flowWfactionExtBean.getIsshowback();
			isDispense = flowWfactionExtBean.getIsdispense();
			if(!StringUtil.isBlank(flowWfactionExtBean.getIssignjoinbyorder())){
				isSignCount = flowWfactionExtBean.getIssignjoinbyorder();//会签个数
			}
			if ("Y".equals(isDynamicSelectUser)) {
				isDynamicSelectUser = "true";
			} else {
				isDynamicSelectUser = "false";
			}
			if("Y".equals(isShowBack)) {
				isShowBack = "true";
			} else {
				isShowBack = "false";
			}
			if("Y".equals(isDispense)) {
				isDispense = "true";
			} else {
				isDispense = "false";
			}
			/*if("Y".equals(isSign)){
				isSign = "true";
			}else{
				isSign = "false";
			}*/
			
			initmap.put("isDynamicSelectUser", isDynamicSelectUser);
			initmap.put("isShowBack", isShowBack);
			initmap.put("isDispense", isDispense);
			initmap.put("isSignCount", isSignCount);
			
		}

		if (map.get("flowinfo") != null) {
			flowinfo = map.get("flowinfo").toString();//流程信息
			initmap.put("flowinfo", flowinfo);
		}
		
		if (map.get("actionAliasAndOrderStr") != null) {
			actionAliasAndOrderStr = map.get("actionAliasAndOrderStr").toString();//环节别名与排序
			initmap.put("actionAliasAndOrderStr", actionAliasAndOrderStr);
		}
		
		if (map.get("actUsertList") != null) {
			actUsertList = map.get("actUsertList").toString();//环节用户与是否选择人员
			initmap.put("actUsertList", actUsertList);
		}
		return initmap;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* getcolumnDisplay(获取页面控制逻辑)
	* @param nodeid
	* @param businessType
	* @return
	* @throws Exception
	 */
	public Map<String,Map<String,ColumnDisplayBean>> getcolumnDisplay(String action_id,String businessType) throws Exception{
		Map<String,Map<String,ColumnDisplayBean>> ColumnDisplay = new HashMap<String, Map<String,ColumnDisplayBean>>();
		
		DsCRUDDao dao = new DsCRUDDaoImpl();
		List<MdTableBean> listBean = dao.getMdTableInfo(businessType);//获取业务类型的配置信息
		for(MdTableBean archiveMdTableBean:listBean){
			Map<String,ColumnDisplayBean> map = new HashMap<String, ColumnDisplayBean>();
			if(StringUtil.isBlank(action_id)){
				map= dao.getDefaultActColStauts(archiveMdTableBean.getTable_id(), null);
			}else{
				map= dao.getActColStauts(action_id,archiveMdTableBean.getTable_id());
				if(map.isEmpty()){
					//pageContext.getOut().write("<script type='text/javascript'> alert('没有根据环节ID查询出配置信息，将加载默认配置！')</script>");
					map= dao.getDefaultActColStauts(archiveMdTableBean.getTable_id(), null);
				}
			}
				
			ColumnDisplay.put(archiveMdTableBean.getTable_code(), map);
		}
		return ColumnDisplay;
	}
	
	@Override
	public int doEndTag() throws JspException {
		return 0;
		
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* initButton(根据环节ID 初始化操作按钮)
	* @param action_id
	* @return
	 */
	public String initButton(String action_id,String flowType) throws Exception{
		StringBuffer buttonString = new StringBuffer();
		//加载按钮配置；
		Map<String,String> textContorlInfo= getContorlInfo(action_id);
		String is_trace = textContorlInfo.get("is_trace"); //是否显示痕迹 1为是
	    String is_red = textContorlInfo.get("is_red"); //是否套红
	    String is_readonly = textContorlInfo.get("is_readonly"); //是否只读
	    //String is_msg = textContorlInfo.get("is_msg"); //是否发送短信
	    String msg_txt = textContorlInfo.get("msg_txt"); //短信规则
	    String is_sign = textContorlInfo.get("is_sign"); //是否可签名
	    @SuppressWarnings("unused")
		String is_keeptrace = textContorlInfo.get("is_keeptrace"); //是否保留痕迹
	    is_keeptrace = "1"; //每个环节都保留痕迹
	    String is_attachment = textContorlInfo.get("is_attachment"); //是否处理附件
	    String is_serialnumber = textContorlInfo.get("is_serialnumber"); //是否可编号
	    String is_gwzl = textContorlInfo.get("is_gwzl"); //是否可整理
	    String is_ckcg = textContorlInfo.get("is_ckcg"); //是否可以查看草稿
	    //String is_ckzw = textContorlInfo.get("is_ckzw"); //是否可以查看正文
	    String is_ckmq = textContorlInfo.get("is_ckmq"); //是否可以查看面签
	    String is_singname = textContorlInfo.get("is_singname"); //是否签名
	    String is_affix = textContorlInfo.get("is_affix"); //是否可以盖章
	    //String remark1 = textContorlInfo.get("remark1"); //扩展字段
	    String is_xd = textContorlInfo.get("is_xd"); //是否校对
	    String is_gwff = textContorlInfo.get("is_gwff"); //是否分发公文
	    String is_cd = textContorlInfo.get("is_cd"); //是否存档
	    String is_cklc = textContorlInfo.get("is_cklc"); //是否查看流程
	    String is_newflow = textContorlInfo.get("is_newflow"); //是否能发起新的流程
	    String is_gk = textContorlInfo.get("is_gk");//是否公开
	    String is_print = textContorlInfo.get("is_print");//是否打印
	    String is_split = textContorlInfo.get("is_split");//是否拆分指标文
	    //String is_infotype = textContorlInfo.get("is_infotype");//是否信息分类
	    String is_nbfs = textContorlInfo.get("is_nbfs");//内部分送
	    String is_doback = textContorlInfo.get("is_doback");//是否回退
	    String is_chief = textContorlInfo.get("is_chief");//是否督办
	    String is_ckls = textContorlInfo.get("is_ckls");//是否查看历史
	    if(!"04".equals(flowType)){//如果不是已办环节
	    	//暂存
			buttonString.append(this.getBottonHtml("保存", "saveWord()"));	
	    }
		//回退
		if("1".equals(is_doback)){
			buttonString.append(this.getBottonHtml("回退", "doBackNext()"));
		}
		if(!"04".equals(flowType)){
			//后续环节
		 	buttonString.append(this.getBottonHtml("后续环节", "sendNext()"));
	    }
	 	if("1".equals(is_serialnumber)){//公文编号 serialNumber();
	 		buttonString.append(this.getBottonHtml("公文编号", "serialNumber()"));
	 	}
	 	if("1".equals(is_gwzl)){//公文整理  doWord();
	 		buttonString.append(this.getBottonHtml("整理", "doWord()"));
	 	} 
	 	if("1".equals(is_xd)){//校对	jiaodui();
	 		buttonString.append(this.getBottonHtml("校对", "jiaodui()"));
	 	}
	 	if("1".equals(is_affix)){//转公文传输 (盖章) sendToArchive();
	 		buttonString.append(this.getBottonHtml("盖章", "sendToArchive()"));
	 	}
	 	if("1".equals(is_gwff)){//分发公文
	 		buttonString.append(this.getBottonHtml("分发公文", "dispenseend()"));
	 	}
	 	if("1".equals(is_nbfs)){//内部分送
			buttonString.append(this.getBottonHtml("内部分送", "isnbfs()"));
		}
	 	if("1".equals(is_cd )){//存档（将文件送入档案模块）doFlowSave();
			buttonString.append(this.getBottonHtml("存档", "doFlowSave()"));
	 	}
	 	//附件，参阅件，每个环节都会显示，只是控制其上传，删除。
	 	buttonString.append(this.getBottonHtml("附件", "optAttachment()"));
	 	buttonString.append(this.getBottonHtml("参阅件", "optAttachment1()"));
	    
 	    if("1".equals(is_cklc)){//办件历史 queryWord("draft");
		    	buttonString.append(this.getBottonHtml("办件历史", "showFlowHistory()"));
	 	}
 	    if("1".equals(is_ckcg)){//查看草稿  queryWord("draft");
	    	buttonString.append(this.getBottonHtml("查看草稿", "queryWord('draft')"));
	 	}
 	    if("1".equals(is_ckmq)){//公文面签 queryWord("singn");
	    	buttonString.append(this.getBottonHtml("公文面签", "queryWord('singn')"));
	 	}
 	    if("1".equals(is_trace)){//设置显示或者隐藏痕迹 
 	    	buttonString.append(this.getBottonHtml("显示痕迹", "ShowRevision(true)"));
 	    	buttonString.append(this.getBottonHtml("隐藏痕迹", "ShowRevision(false)"));
	 	}
 	    if("1".equals(is_sign)){//签字  wordSing();  
	    	buttonString.append(this.getBottonHtml("签字", "wordSing()"));
	 	}
 	    if("1".equals(is_gk)){//信息公开 isPublicSel();
	    	buttonString.append(this.getBottonHtml("信息公开", "isPublicSel()"));
	    }
 	    if("1".equals(is_newflow)){//发起新的流程(流程发起) wordiwebofficeJS.doFlowInFlow.newFlow();
	    	buttonString.append(this.getBottonHtml("发起流程", "wordiwebofficeJS.doFlowInFlow.newFlow()"));
	    }
 	    if("1".equals(is_split)){//拆分opentSplitPage();
			buttonString.append(this.getBottonHtml("指标拆分", "opentSplitPage()"));
	    }
 	    if("1".equals(is_print)){//打  印 printText();
			buttonString.append(this.getBottonHtml("打  印", "printText()"));
		}
 	    if("1".equals(is_ckls)){//查看历史  isckls() 
			buttonString.append(this.getBottonHtml("查看历史", "isckls()"));
	    }
 	    if("1".equals(is_chief)){//督办 ischief();
	 		buttonString.append(this.getBottonHtml("督办", "ischief()"));
	    }
 	    if("1".equals(is_singname)){//签  名wordSing();  
			buttonString.append(this.getBottonHtml("签名", "wordSingname()"));
	 	}
 	    if("1".equals(is_red)){//套红
	 		
	 	}
 	    
 	    //添加配置隐藏域
 	    buttonString.append("<input name='is_readonly' id='is_readonly' type='hidden' value='"+ is_readonly +"' />");
	    buttonString.append("<input name='is_attachment' id='is_attachment' type='hidden' value='"+ is_attachment +"' />");
	    buttonString.append("<input name='msg_txt_config' id='msg_txt_config' type='hidden' value='"+ msg_txt +"' />");
	    return buttonString.toString();
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* getBottonHtml(生产按钮HTML)
	* @param buttonName
	* @param onClickDo
	* @return
	 */
	public String getBottonHtml(String buttonName,String onClickDo){
		StringBuffer bottonHtml = new StringBuffer();
		bottonHtml.append("<div style=\"float:left;padding-right: 5px;padding-left:5px;\">");
		bottonHtml.append("<input class='but_y_01'  type=\"button\" name=\"sendNextBotton\" id=\"sendNextBotton\" value=\"").append(buttonName).append("\" onClick=\"").append(onClickDo).append("\"/>"); 
		bottonHtml.append("</div>");	
		return bottonHtml.toString();
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* getContorlInfo(根据环节ID获取正文的配置信息。)
	* @param action_id
	* @return
	 */
	private Map<String, String> getContorlInfo(String action_id) throws Exception {
		DsCRUDDao dao = new DsCRUDDaoImpl();
		Map<String, String>  textContorl = dao.getTextContorlInfo(action_id, null);
		return textContorl;
	}
	
}