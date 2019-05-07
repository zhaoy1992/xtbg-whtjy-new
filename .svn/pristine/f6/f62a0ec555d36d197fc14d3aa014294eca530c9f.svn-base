package com.chinacreator.xtbg.core.process.workflowphone.service.impl;

import javax.jws.WebService;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.process.workflowphone.eneity.ResponseConstant;
import com.chinacreator.xtbg.core.process.workflowphone.eneity.WorkFlowPhoneRequestBean;
import com.chinacreator.xtbg.core.process.workflowphone.eneity.WorkFlowPhoneResponseBean;
import com.chinacreator.xtbg.core.process.workflowphone.exception.InitWorkFlowInfoException;
import com.chinacreator.xtbg.core.process.workflowphone.exception.WorkFlowAbstractException;
import com.chinacreator.xtbg.core.process.workflowphone.service.PCWorkFlowHandler;
import com.chinacreator.xtbg.core.process.workflowphone.service.WorkFlowPhoneHandleIfc;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowUtilDao;

/**
 * 
 *<p>Title:WorkFlowPhoneHandleImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-7-23
 */
@WebService(endpointInterface = "com.chinacreator.xtbg.core.process.workflowphone.service.WorkFlowPhoneHandleIfc",
        serviceName = "WorkFlowPhoneHandleIfc")
public class WorkFlowPhoneHandleImpl implements WorkFlowPhoneHandleIfc {
	
	private static final Logger LOG = Logger.getLogger(WorkFlowPhoneHandleImpl.class);

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 workFlowPhoneHandle
	  * @param workFlowPhoneRequestBean
	  * @return 
	  * @see com.chinacreator.xtbg.core.process.workflowphone.service.WorkFlowPhoneHandleIfc#workFlowPhoneHandle(com.chinacreator.xtbg.core.process.workflowphone.eneity.WorkFlowPhoneRequestBean)
	 */
	@Override
	public WorkFlowPhoneResponseBean workFlowPhoneHandle(WorkFlowPhoneRequestBean workFlowPhoneRequestBean) {
		WorkFlowPhoneResponseBean workFlowPhoneResponseBean = null;
		try {
			PCWorkFlowHandler pcWorkFlowInit = (PCWorkFlowHandler)LoadSpringContext.getApplicationContext().getBean(workFlowPhoneRequestBean.getOperType());//获取类型 
			//TODO  此处要根据TYPE获取不同的实现类  PCWorkFlowHanlderFactory.createInstance(workFlowPhoneRequestBean.getOperType());
			
			if(null == pcWorkFlowInit){
				throw new InitWorkFlowInfoException("", ResponseConstant.RESULT_CODE_02,ResponseConstant.RESULT_MESSAGE_02,"流程处理实例的工厂创建实例失败！");
			}
			workFlowPhoneResponseBean =  pcWorkFlowInit.doWorkFlowMethod(workFlowPhoneRequestBean);
			
		} catch (WorkFlowAbstractException e) {
			// TODO Auto-generated catch block
			System.out.println(e.toString());
			if(null == workFlowPhoneResponseBean){
				workFlowPhoneResponseBean = new WorkFlowPhoneResponseBean();
			}
				workFlowPhoneResponseBean.setExceptionMessage(e.toString());
				workFlowPhoneResponseBean.setResultCode(e.getState());
				workFlowPhoneResponseBean.setResultStateMessage(e.getMessage());
			
		}
		return workFlowPhoneResponseBean;
	}
	
	@Override
	public String checkIsAllSignJoin(String ins_id, String action_id,
			String curr_userid, String order) {
		String resultStr = "";
		try {
			FlowUtilDao flowUtilDao = (FlowUtilDao)DaoImplClassUtil.getDaoImplClass("flowUtilDaoImpl");
			resultStr = flowUtilDao.checkIsAllSignJoin(ins_id, action_id, curr_userid, order).toJSONString();
		} catch (Exception e) {
			LOG.error("手机调pc端的检查是否全部会签完毕接口报错！", e);
		}
		return resultStr;
	}
}
