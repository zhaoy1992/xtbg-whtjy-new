package com.chinacreator.xtbg.pub.jqueryupload.filebuess;

import com.chinacreator.xtbg.pub.jqueryupload.filebuess.entity.FileInfoBean;
import com.chinacreator.xtbg.pub.util.StringUtil;

public class FileDownLoadHandler {
	public final static String onlineEditType = ".xls|.xlsx|.doc|.docx|.et|";//允许在线修改的文档类型
	public final static String onlineEditUrl = "/ccapp/xtbg/public/util/jsp/iwebOffice2009.jsp?RecordID=%DJSN%&EditType=1,1&ShowType=1&DBType=fc_attach&FileType=%FileType%";
	
	/**
	 * 允许在线编辑 并且 符合指定的类型
	 * @param onlineEdit
	 * @param fileExtend
	 * @return
	 */
	public static boolean ifOnlineEdit(String onlineEdit,String fileExtend){
		return ("true".equals(onlineEdit) && onlineEditType.indexOf(fileExtend.trim()+"|") != -1);
	}
	
	/**
	 * 获取在线编辑路径
	 * @param djsn
	 * @return
	 */
	public static String getOnlineEditUrl(FileInfoBean fileInfoBean){
		return onlineEditUrl.replace("%DJSN%", StringUtil.deNull(fileInfoBean.getDjsn())).replace("%FileType%", StringUtil.deNull(fileInfoBean.getExtend()));
	}
	
	
}
