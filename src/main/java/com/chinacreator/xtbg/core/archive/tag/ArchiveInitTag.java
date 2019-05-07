package com.chinacreator.xtbg.core.archive.tag;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.cache.OASystemCache;
import com.chinacreator.xtbg.core.common.commonlist.Constant;
import com.chinacreator.xtbg.core.dssave.dao.DsCRUDDao;
import com.chinacreator.xtbg.core.dssave.dao.impl.DsCRUDDaoImpl;
import com.chinacreator.xtbg.core.dssave.entity.ViewListBean;

/**
 * 
 *<p>Title:ArchiveInitTag1.java</p>
 *<p>Description:公文初始化标签。</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-7-15
 */

public class ArchiveInitTag extends BaseInitTag {
	private static final long serialVersionUID = 1L;
	private static final Log LOG = LogFactory.getLog(ArchiveInitTag.class);
	private String viewList = ""; //意见字段集合。
	private Map<String,String> viewString;  //意见信息回填。
	
	public String getViewList() {
		return viewList;
	}

	public void setViewList(String viewList) {
		this.viewList = viewList;
	}

	public Map<String, String> getViewString() {
		return viewString;
	}

	public void setViewString(Map<String, String> viewString) {
		this.viewString = viewString;
	}

	/**
	 * 
	  * <b>Summary: 在这里实现自己的业务逻辑，将意见信息标签集合封装</b>
	  *     复写方法 doEndTag
	  * @return
	  * @throws JspException 
	  * @see com.chinacreator.xtbg.core.archive.tag.BaseInitTag#doEndTag()
	 */
	@Override
	public void endTagToDo() throws JspException {
		StringBuffer htmlString = new StringBuffer();
		htmlString.append("<script type='text/javascript'>");
		htmlString.append("var views = '");
		htmlString.append(viewList+"';");
		htmlString.append("</script>");
		
		try {
			pageContext.getOut().write(htmlString.toString());
		} catch (IOException e) {
			LOG.error(e.getMessage(), e);
		}
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
		HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();
		this.viewList = "";//每次加载将意见列表清空
		DsCRUDDao dao = new DsCRUDDaoImpl();
		String ins_id = request.getParameter("ins_id"); //实例ID
		List<ViewListBean> viewList = dao.getView(ins_id);
		viewString = new HashMap<String,String>();
		//签字顺序。
		String viewOeder = OASystemCache.getContextProperty("viewOeder");
		for(ViewListBean viewListBean:viewList){
			String viewStr = "";
			if(!viewString.containsKey(viewListBean.getTable_name()+Constant.SEPARATOR+viewListBean.getColumn_name())){
				//TODO 在这里对意见字段进行组装。
				viewStr = viewListBean.getAction_handeridea();
			}else{
				if("newlast".equals(viewOeder)){
					viewStr = viewListBean.getAction_handeridea() +"\n\n"+ viewString.get(viewListBean.getTable_name()+Constant.SEPARATOR+viewListBean.getColumn_name())  ;

				}else{
					viewStr = viewString.get(viewListBean.getTable_name()+Constant.SEPARATOR+viewListBean.getColumn_name()) +"\n\n"+ viewListBean.getAction_handeridea();

				}
			}
			viewString.put(viewListBean.getTable_name()+Constant.SEPARATOR+viewListBean.getColumn_name(),viewStr);
		}
		
		
		
	}
	
}
