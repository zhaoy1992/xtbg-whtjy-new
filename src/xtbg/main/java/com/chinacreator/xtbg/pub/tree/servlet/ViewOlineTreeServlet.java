package com.chinacreator.xtbg.pub.tree.servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.chinacreator.eform.util.Escape;
import com.chinacreator.xtbg.pub.tree.dao.TreeDao;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;

public class ViewOlineTreeServlet extends HttpServlet
{
        private static final long serialVersionUID = 132383828833L;
        
    	private static final Logger LOG = Logger.getLogger(ViewOlineTreeServlet.class);
    	
        public void doGet(HttpServletRequest req, HttpServletResponse resp)
                        throws ServletException, IOException {
        	String orgTreeInfo = "";
        	req.setCharacterEncoding("UTF-8");
        	String item_id = req.getParameter("item_id");
        	String userid = req.getParameter("userid");
        	String toporgId = req.getParameter("toporgId");
        	String resourceLogo = req.getParameter("resourceLogo");
        	String rolename = DataControlUtil.replaceStr(req.getParameter("rolename"));
        	String orgid=req.getParameter("orgid");
        	if(!StringUtil.nullOrBlank(rolename))
        	rolename = "'"+Escape.unescape(rolename)+"'";
        	
        	Map<String, String> map = new HashMap<String, String>();
        	map.put("item_id", item_id);
        	map.put("userid", userid);
        	map.put("toporgId", toporgId);
        	map.put("resourceLogo", resourceLogo);
        	map.put("rolename", rolename);
        	map.put("orgid", orgid);
        	
        	resp.setCharacterEncoding("UTF-8");
        	TreeDao dao;
			try {
				dao = (TreeDao)DaoImplClassUtil.getDaoImplClass("TreeDaoImpl");
				orgTreeInfo = dao.getViewOlineTreeMessage(map);
			} catch (Exception e) {
				LOG.error(e);
			}
        	resp.getWriter().print(orgTreeInfo);
    	   
        }

        public void doPost(HttpServletRequest req, HttpServletResponse resp)
                        throws ServletException, IOException {
                doGet(req,resp);
        }
}
