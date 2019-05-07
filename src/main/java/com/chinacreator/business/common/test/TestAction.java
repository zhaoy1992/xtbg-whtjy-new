package com.chinacreator.business.common.test;

import java.util.HashMap;

import com.chinacreator.business.common.bean.BusinessBean;
import com.chinacreator.business.common.exception.BusinessException;
import com.chinacreator.business.common.exception.SystemException;
import com.chinacreator.business.common.tools.CacheCommonManage;

public class TestAction {
    public void delete(BusinessBean bean){
         System.out.println(bean.getParamMap().toString());
    }
    
    public void reload(BusinessBean bean){
    	try {
			CacheCommonManage.getInstance().init();
		} catch (SystemException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
    
    public Object select(BusinessBean bean) throws BusinessException {
    	throw new BusinessException("kkk","dafasdf");
    	//ArrayList<Object> list = new ArrayList<Object>();
    	/*HashMap<String,String> str = new HashMap<String, String>();
    	str.put("aa", "bb");
    	return str;*/
    }
}
