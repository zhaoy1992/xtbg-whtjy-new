package com.chinacreator.xtbg.yimingju.fileUpload.service;

import com.chinacreator.xtbg.yimingju.fileUpload.entity.UploadFileResultBean;
import com.chinacreator.xtbg.yimingju.fileUpload.entity.VideoInfoBean;

public interface VideoManageServiceIfc {
	
	/**
	 * 上传文件
	 * @param personFileInfoBean
	 * @return
	 * @throws Exception
	 */
	public UploadFileResultBean uploadFile(VideoInfoBean videoInfoBean) throws Exception;
	
	/**
	 * 删除指定文件（数据库记录和服务器文件）
	 * @param fileids
	 * @throws Exception
	 */
	public void delFile(String realPath,String fileids) throws Exception;
}
