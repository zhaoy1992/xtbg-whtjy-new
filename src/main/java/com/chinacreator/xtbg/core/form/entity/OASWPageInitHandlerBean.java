package com.chinacreator.xtbg.core.form.entity;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chinacreator.xtbg.core.wordnumdef.dao.WordNumDefDao;
import com.chinacreator.xtbg.core.wordnumdef.dao.impl.WordNumDefDaoImpl;


/**
 * 表单初始化处理bean
 * @author tuo.zou
 *
 */
public class OASWPageInitHandlerBean extends PageInitHandlerBean{
	/**
	 * 支持数据
	 */
	@Override
	public Map<String, String> getPageDefaultData(HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, String> a = super.getPageDefaultData(request, response);
		WordNumDefDao wordNumDefDao = new WordNumDefDaoImpl();
		String liushuihao1 = "";
		String liushuihao2 = "";
		try {
			liushuihao1 = wordNumDefDao.findSerialcode("S",null).getS_allcode();
			liushuihao2 = wordNumDefDao.findSerialcode("C",null).getS_allcode();
			
		} catch (Exception e) {
		
		}
		a.put("swlsh1", liushuihao1);
		a.put("swlsh2", liushuihao2);
		return a;
	}
	/**
	 * 支持下拉框
	 */
	@Override
	public LinkedHashMap<String, String> getPageDefaultDataName() {
		LinkedHashMap<String, String> a = super.getPageDefaultDataName();
		a.put("{swlsh1}", "S收文流水号");
		a.put("{swlsh2}", "C收文流水号");
		return a;
		//{nihao} "欢迎词"
	}
	/**
	 * 支持jsp java脚本的变量
	 */
	@Override
	public List<String> getPageDefaultDataVarName() {
		List<String> a =super.getPageDefaultDataVarName();
		a.add("swlsh1");
		a.add("swlsh2");
		return a;
	}
	
}
