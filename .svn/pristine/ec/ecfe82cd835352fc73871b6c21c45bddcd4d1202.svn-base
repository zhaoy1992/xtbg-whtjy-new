package com.chinacreator.xtbg.core.common.ntkooffice.services.impl;

import java.util.Map;
import java.util.Set;

import org.apache.commons.fileupload.FileItem;

import com.chinacreator.xtbg.core.common.ntkooffice.services.AbstractUploadOfficeService;
/**
 *<p>Title:UploadOfficeDemoService.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013年10月11日
 */
public class UploadOfficeDemoService extends AbstractUploadOfficeService{

	@Override
	public String handleFromData(Map<String, Object> formFieldMap)
			throws Exception {
		Set<String> keySet = formFieldMap.keySet();
		for(String key : keySet){
			if(formFieldMap.get(key) instanceof String){
				System.out.println(formFieldMap.get(key));
			}else{
				FileItem fileitem = (FileItem) formFieldMap.get(key);
				String flieName = fileitem.getName();
				System.out.println(flieName);
				String tempFolder = "d:\\upload\\temp\\";//TODO 　路径配置 
				super.checkFolder(tempFolder);
				super.saveFileToDisk(fileitem,tempFolder+flieName);
			}
		}
		return "操作成功";
	}

}
