package com.chinacreator.xtbg.core.workbench.cache;

import junit.framework.TestCase;
/**
 *<p>Title:WorkbenchConfCacheTest.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-6-25
 */
public class WorkbenchConfCacheTest extends TestCase {

	public void testinit() {
		try {
			WorkbenchConfCache workbenchConfCache = new WorkbenchConfCache();
			workbenchConfCache.init();
			assertEquals("待办公文", WorkbenchConfCache.getShowItemMap().get("dbgw").getName());
			System.out.println(WorkbenchConfCache.getShowItemMap().get("dbgw").getSql());
			assertEquals(1, WorkbenchConfCache.getShowItemMap().get("dbgw").getParamCount());
			assertEquals("ggbh,state1", WorkbenchConfCache.getShowItemMap().get("ggl").getUrlParamColumns());
			assertEquals("sub_main_todowork", WorkbenchConfCache.getPendingBean().getList().get(1).getId());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
