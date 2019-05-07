package com.chinacreator.xtbg.core.archive.tag;

import java.io.IOException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.cache.OASystemCache;
import com.chinacreator.xtbg.core.common.commonlist.Constant;
import com.chinacreator.xtbg.core.dssave.entity.ViewListBean;
import com.chinacreator.xtbg.core.process.flowprocessing.dao.impl.FlowViewDaoImpl;

/**
 * 
 *公文管理->Form版流程页面初始化 控制Tag  <oa:init>
 *特检院专用
 *<p>Title:ArchiveInitTagForTJY.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author tuo.zou
 *@version 1.0
 *2014-6-15
 */
public class ArchiveInitTagForTJY extends ArchiveInitTag {
	private static final long serialVersionUID = 1L;
	
	private static final Log LOG = LogFactory.getLog(ArchiveInitTagForTJY.class);
	/**
	 * 让最新的意见排最后
	 */
	public static final String NEW_VIEW_IS_SHOW_LAST = "newlast";
	
	public static final String CODE_BETWEEN_MESS = "\n\n";
	
	//意见字段集合,会在 每一个AchiveViewTag中对该字段进行添加数据,最后 通过endTagToDo()写入js脚本
	//格式:如YJ__OA_FILE_SHOUWEN__NBYJ,YJ__OA_FILE_SHOUWEN__PYRYJ,YJ__OA_FILE_SHOUWEN__CYRQMHYJ,YJ__OA_FILE_SHOUWEN__ZBDWZXYJ
	private String viewList;
	//当前流程实例 的意见Map,key是 每一个字段,value是该这段 所有的意见列表.
	private Map<String,String> viewString;
	//当前环节实例 的意见Map,key是 每一个字段,value是该这段 所有的意见列表.(支持暂存)
	private Map<String,String> thisActionViewString;
	
	private Map<String,String> historyActionViewString;
	
	public String getViewList() {
		return viewList;
	}

	public void setViewList(String viewList) {
		this.viewList = viewList;
	}

	public void appendViewList(String viewList){
		if(this.viewList!=null&&this.viewList.length()>0){
			this.viewList += ","+viewList;
		}else{
			this.viewList += viewList;
		}
	}
	
	public String getAllViewByLocation(String loc){
		String val = this.viewString.get(loc);
		if(val==null){
			val = "";
		}
		return val;
	}
	
	public String getHistoryViewByLocation(String loc){
		String val = this.historyActionViewString.get(loc);
		if(val==null){
			val = "";
		}
		return val;
	}
	
	public String getThisActionViewByLocation(String loc){
		String val = this.thisActionViewString.get(loc);
		if(val==null){
			val = "";
		}
		return val;
	}
	
	public Map<String, String> getViewString() {
		return viewString;
	}

	public void setViewString(Map<String, String> viewString) {
		this.viewString = viewString;
	}
	
	public Map<String, String> getThisActionViewString() {
		return thisActionViewString;
	}

	public void setThisActionViewString(Map<String, String> thisActionViewString) {
		this.thisActionViewString = thisActionViewString;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 StartTagToDo
	  * @return
	  * @throws JspException 
	  * @see com.chinacreator.xtbg.core.archive.tag.BaseInitTag#StartTagToDo()
	 */
	@Override
	public void startTagToDo() throws Exception {
		//1初始化 viewList 属性
		initViewList();
		
		//2初始化 viewString 和 thisActionViewString
		HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();
		String flowInsId = request.getParameter("ins_id");
		String actInsId = request.getParameter("actInsId");
		FlowViewDaoImpl dao = new FlowViewDaoImpl();
		List<ViewListBean> viewList = dao.getViewListForShow(flowInsId);
		
		initViewString(viewList,actInsId);
	}
	
	

	private void initViewList() {
		this.viewList = "";
	}
	
	private void initViewString(List<ViewListBean> viewList,String actInsId) {
		//0
		String viewOeder = OASystemCache.getContextProperty("viewOeder");
		boolean isNewLast = NEW_VIEW_IS_SHOW_LAST.equals(viewOeder);
		//1
		Map<String,String> allView = new HashMap<String,String>();
		Map<String,String> thisActionView = new HashMap<String,String>();
		Map<String,String> historyActionView = new HashMap<String,String>();
		
		HashSet<String> filter = new HashSet<String>();
		
		//如果是 同一个用户在 同一个环节实例中，在同一个格子内 最后一次意见才是需要显示的,
		//如果不是最后那条 ，就表示 流程成退回到这个环节定义，用户在这个环节顶一下 得多个环节实例 写过意见 ，只显示最新的。其余的都在 详细列表中显示


		for(ViewListBean bean : viewList){
			///过滤
			String filterEle = bean.getUser_id()+bean.getAction_id()+bean.getTable_name()+bean.getColumn_name()+bean.getAction_ins_id();
			if(!filter.contains(filterEle)){
				filter.add(filterEle);
			}else{
				continue;
			}
			//1.1
			String key = bean.getTable_name() + Constant.SEPARATOR + bean.getColumn_name();
			String newValue = bean.getAction_handeridea();
			//1.2
			if(!allView.containsKey(key)){
				allView.put(key, newValue);
			}else{
				if(isNewLast){
					allView.put(key, newValue + CODE_BETWEEN_MESS + allView.get(key));
				}else{
					allView.put(key, allView.get(key) + CODE_BETWEEN_MESS + newValue);
				}
			}
			//1.3
			String tmpActInsId = bean.getAction_ins_id();
			if(tmpActInsId!=null &&tmpActInsId.equals(actInsId))
			{
				
				if(!thisActionView.containsKey(key)){
					thisActionView.put(key, newValue);
				}else{
					if(isNewLast){
						thisActionView.put(key, newValue + CODE_BETWEEN_MESS + thisActionView.get(key));
					}else{
						thisActionView.put(key, thisActionView.get(key) + CODE_BETWEEN_MESS + newValue);
					}
				}
				
			}else{
				if(!historyActionView.containsKey(key)){
					historyActionView.put(key, newValue);
				}else{
					if(isNewLast){
						historyActionView.put(key, newValue + CODE_BETWEEN_MESS + historyActionView.get(key));
					}else{
						historyActionView.put(key, historyActionView.get(key) + CODE_BETWEEN_MESS + newValue);
					}
				}
			}
		}
		
		this.setViewString(allView);
		this.setThisActionViewString(thisActionView);
		this.setHistoryActionViewString(historyActionView);
	}

	

	public Map<String, String> getHistoryActionViewString() {
		return historyActionViewString;
	}

	public void setHistoryActionViewString(
			Map<String, String> historyActionViewString) {
		this.historyActionViewString = historyActionViewString;
	}

	public void endTagToDo() throws JspException {
		StringBuffer htmlString = new StringBuffer();
		htmlString.append("<script type='text/javascript'>");
		htmlString.append("var views = '");
		htmlString.append(viewList+"'");
		htmlString.append("</script>");
		try {
			pageContext.getOut().write(htmlString.toString());
		} catch (IOException e) {
			LOG.error(e.getMessage(), e);
		}
	}
}
