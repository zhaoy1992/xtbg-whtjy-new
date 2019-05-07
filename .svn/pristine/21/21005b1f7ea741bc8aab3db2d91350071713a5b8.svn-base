package com.chinacreator.xtbg.pub.jqueryupload.utils;

import java.io.Serializable;
import java.util.Collection;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

/**
 * 判断对象是否为空
 */

public class BlankUtil {

	/**
	 * 判断字符串是否为空
	 */
	public static boolean isBlank(final String str) {
		return (str == null) || (str.trim().length() <= 0);
	}

	/**
	 * 判断字符是否为空
	 * @param cha
	 * @return
	 */
	public static boolean isBlank(final Character cha) {
		return (cha == null) || cha.equals(' ');
	}

	/**
	 * 判断对象是否为空
	 */
	public static boolean isBlank(final Object obj) {
		return (obj == null);
	}

	/**
	 * 判断数组是否为空
	 * @param objs
	 * @return
	 */
	public static boolean isBlank(final Object[] objs) {
		return (objs == null) || (objs.length <= 0);
	}

	/**
	 * 判断Collectionj是否为空
	 * @param obj
	 * @return
	 * @author 张宪新 修改日期：2008-07-28
	 */
	public static boolean isBlank(final Collection<?> obj) {
		return (obj == null) || obj.isEmpty();
	}

	/**
	 * 
	 * @param obj
	 * @return
	 * @description：   判断对象是否为空
	 * @return: boolean
	 * @method: isBlank
	 * @author: <a href="mailto:hnxyhcwdl1003@163.com">wandalong</a>
	 * @version: 2010-12-15 下午09:16:50
	 */
	public static boolean isBlank(final Properties properties) {
		return (properties == null||(properties != null&&properties.isEmpty()));
	}
	
	/**
	 * 判断Set是否为空
	 * @param set
	 * @return
	 */
	public static boolean isBlank(final Set<?> set) {
		return (set == null) || set.isEmpty();
	}

	/**
	 * 判断Serializable是否为空
	 * @param obj
	 * @return
	 */
	public static boolean isBlank(final Serializable obj) {
		return obj == null;
	}

	/**
	 * 判断Map是否为空
	 * @param map
	 * @return
	 */
	public static boolean isBlank(final Map<?, ?> map) {
		return (map == null) || map.isEmpty();
	}
}