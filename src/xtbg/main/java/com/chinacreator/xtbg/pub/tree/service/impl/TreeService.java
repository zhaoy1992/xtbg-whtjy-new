package com.chinacreator.xtbg.pub.tree.service.impl;

import com.chinacreator.xtbg.core.common.tree.dao.impl.CommonTreeDaoImpl;
import com.chinacreator.xtbg.pub.tree.dao.ModuleTreeDao;
import com.chinacreator.xtbg.pub.tree.entity.TreeBean;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;

public class TreeService {
    public Object getTreeJsonValue(TreeBean bean) throws Exception{
    	ModuleTreeDao moduleTreeDao= (ModuleTreeDao)DaoImplClassUtil.getDaoImplClass("moduleTreeDaoImpl");
    	return moduleTreeDao.getTreeJsonValue(bean);
    }
    
    public Object getTree2JsonValue(TreeBean bean) throws Exception{
    	ModuleTreeDao moduleTreeDao= (ModuleTreeDao)DaoImplClassUtil.getDaoImplClass("moduleTreeDaoImpl");
    	return moduleTreeDao.getTree2JsonValue(bean);
    }
    
    public Object getTree3JsonValue(TreeBean bean) throws Exception{
    	ModuleTreeDao moduleTreeDao= (ModuleTreeDao)DaoImplClassUtil.getDaoImplClass("moduleTreeDaoImpl");
    	return moduleTreeDao.getTree3JsonValue(bean);
    }
    
    public Object getTreeUpdateJsonValue(TreeBean bean) throws Exception{
    	ModuleTreeDao moduleTreeDao= (ModuleTreeDao)DaoImplClassUtil.getDaoImplClass("moduleTreeDaoImpl");
    	return moduleTreeDao.getTreeUpdateJsonValue(bean);
    }
    public Object getTreeInsertJsonValue(TreeBean bean) throws Exception{
    	ModuleTreeDao moduleTreeDao= (ModuleTreeDao)DaoImplClassUtil.getDaoImplClass("moduleTreeDaoImpl");
    	return moduleTreeDao.getTreeInsertJsonValue(bean);
    }
    public Object getcustomTreeJsonValue(TreeBean bean) throws Exception{
    	ModuleTreeDao moduleTreeDao= (ModuleTreeDao)DaoImplClassUtil.getDaoImplClass("moduleTreeDaoImpl");
    	return moduleTreeDao.getcustomTreeJsonValue(bean);
    }
    public Object inqueryTreeUserByRange(TreeBean bean) throws Exception{
    	ModuleTreeDao moduleTreeDao= (ModuleTreeDao)DaoImplClassUtil.getDaoImplClass("moduleTreeDaoImpl");
    	return moduleTreeDao.inqueryTreeUserByRange(bean);
    }
    
    public Object inqueryOfTypeTree(TreeBean bean) throws Exception{
    	return CommonTreeDaoImpl.inqueryOfTypeTree(bean);
    }
    	
    public Object inqueryDETTypeTree(TreeBean bean) throws Exception{
    	return CommonTreeDaoImpl.inqueryDETTypeTree(bean);
    }
    
    public Object inqueryCANTypeTree(TreeBean bean) throws Exception{
    	return CommonTreeDaoImpl.inqueryCANTypeTree(bean);
    }
}
