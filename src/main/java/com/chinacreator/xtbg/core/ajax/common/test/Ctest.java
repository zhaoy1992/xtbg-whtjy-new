package com.chinacreator.xtbg.core.ajax.common.test;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.chinacreator.xtbg.core.ajax.common.bean.BusinessBean;

public class Ctest {
    public Object aaa(BusinessBean bean){
    	//System.out.println("----");
    	Map<String, Object> s = new HashMap<String, Object>();
    	s.put("str", "string");
    	ArrayList<String> list = new ArrayList<String>();
    	list.add("listvalue");
    	s.put("list",list);
    	return s;
    }
}
