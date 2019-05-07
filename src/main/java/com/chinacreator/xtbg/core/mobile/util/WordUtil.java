package com.chinacreator.xtbg.core.mobile.util;

import java.sql.Connection;
import java.util.Map;

public interface WordUtil {
	/**
	 * 
	 *<b>Summary: </b>
	 * initWordFile(创建word文件)
	 */
	public void initWordFile(Connection conn);
	
	/**
	 * 
	 *<b>Summary: </b>
	 * writeWordFile(将数据写入word)
	 * @param writeMap key[写入位置(表,行,列)](1,2,3) val[值](String)
	 * @return
	 */
	public boolean writeWordFile(Map<String,String> writeMap);
	
	public void readWordFileIntoDB(Connection conn);
	
	public void deleteWordFile();

}
