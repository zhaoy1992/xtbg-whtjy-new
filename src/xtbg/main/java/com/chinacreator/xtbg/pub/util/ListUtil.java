package com.chinacreator.xtbg.pub.util;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

/**
 * List 工具类
 * @author tian.xia1
 *
 */
public class ListUtil {
	/**
	 * List 排重方法，保持原有顺序
	 * @param list
	 * @return
	 */
    public static List removeDuplicateWithOrder(List list) { 
    	 Set set = new HashSet();
         List newList = new ArrayList();
         for (Iterator iter = list.iterator(); iter.hasNext();) {
             Object element = iter.next();
             if (set.add(element))
                 newList.add(element);
         }
         return newList;

    } 

}
