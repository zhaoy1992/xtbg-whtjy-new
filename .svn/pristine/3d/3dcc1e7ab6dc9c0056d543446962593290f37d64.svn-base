package com.chinacreator.xtbg.yimingju.carmanage.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 
 *<p>Title:DriverSort.java</p>
 *<p>Description:生成司机驾照类型信息</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 童佳
 *@version 1.0
 *2013-10-25
 */
public class DriverSort {
     private static List<Map<String, String>>   sortList = new ArrayList<Map<String,String>>();
     static{
    	 Map<String, String> sortMapA = new HashMap<String, String>();
    	 Map<String, String> sortMapB = new HashMap<String, String>();
    	 Map<String, String> sortMapC = new HashMap<String, String>();
    	 sortMapA.put("1", "A照");
    	 sortMapB.put("2", "B照");
    	 sortMapC.put("3", "C照");
    	 sortList.add(sortMapA);
    	 sortList.add(sortMapB);
    	 sortList.add(sortMapC);
     }
	public static List<Map<String, String>> getSortList() {
		return sortList;
	}
	public static void setSortList(List<Map<String, String>> sortList) {
		DriverSort.sortList = sortList;
	}
    
}
