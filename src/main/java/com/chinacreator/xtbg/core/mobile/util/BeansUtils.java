package com.chinacreator.xtbg.core.mobile.util;

import java.beans.BeanInfo;
import java.beans.IntrospectionException;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.PropertyUtilsBean;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;

public class BeansUtils<T> {
	public T convertMap(Class<T> type, Map<String, Object> map) {
		T obj = null;
		try {
			BeanInfo beanInfo = Introspector.getBeanInfo(type); // 获取类属性
			obj = type.newInstance();
			// 给 JavaBean 对象的属性赋值
			PropertyDescriptor[] propertyDescriptors = beanInfo
					.getPropertyDescriptors();
			for (int i = 0; i < propertyDescriptors.length; i++) {
				PropertyDescriptor descriptor = propertyDescriptors[i];
				String propertyName = descriptor.getName();
				if (map.containsKey(propertyName)) {
					// 下面一句可以 try 起来，这样当一个属性赋值失败的时候就不会影响其他属性赋值。
					try {
						Object value = map.get(propertyName);
						Object[] args = new Object[1];
						args[0] = value;
						descriptor.getWriteMethod().invoke(obj, args);
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		} catch (IntrospectionException e) {
			e.printStackTrace();
		}
		return obj;
	}

	// 将javabean转为map类型，然后返回一个map类型的值
	public synchronized static Map<String, Object> beanToMap(Object obj) {
		Map<String, Object> params = new HashMap<String, Object>(0);
		try {
			PropertyUtilsBean propertyUtilsBean = new PropertyUtilsBean();
			PropertyDescriptor[] descriptors = propertyUtilsBean
					.getPropertyDescriptors(obj);
			for (int i = 0; i < descriptors.length; i++) {
				String name = descriptors[i].getName();
				if (!"class".endsWith(name)) {
					Object value = propertyUtilsBean.getNestedProperty(obj,
							name);
					if (value != null) {
						params.put(name, value);
					}

				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return params;
	}

	public synchronized static List<Map<String, Object>> beanToMap(
			PagingBean pageBean) {
		List<Map<String, Object>> ListMap = new ArrayList<Map<String, Object>>();
		List<? extends Object> listBean = pageBean.getList();
		for (Object obj : listBean) {
			try {
				Map<String, Object> params = new HashMap<String, Object>(0);
				if (!(obj instanceof HashMap)) {
					PropertyUtilsBean propertyUtilsBean = new PropertyUtilsBean();
					PropertyDescriptor[] descriptors = propertyUtilsBean
							.getPropertyDescriptors(obj);
					for (int i = 0; i < descriptors.length; i++) {
						String name = descriptors[i].getName();
						if (!"class".endsWith(name)) {
							Object value = propertyUtilsBean.getNestedProperty(
									obj, name);
							if (value != null) {
								params.put(name, value);
							}

						}
					}
				}else
				{
					 params = (Map<String, Object>) obj;
				}

				ListMap.add(params);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return ListMap;
	}
}
