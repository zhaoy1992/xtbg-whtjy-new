package com.chinacreator.xtbg.yimingju.fileUpload.service.impl;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.yimingju.fileUpload.dao.VideoManageDao;
import com.chinacreator.xtbg.yimingju.fileUpload.entity.UploadFileResultBean;
import com.chinacreator.xtbg.yimingju.fileUpload.entity.VideoInfoBean;
import com.chinacreator.xtbg.yimingju.fileUpload.entity.VideoManageConstant;
import com.chinacreator.xtbg.yimingju.fileUpload.service.VideoManageServiceIfc;
import com.frameworkset.orm.transaction.TransactionManager;

public class VideoManageServiceImpl implements VideoManageServiceIfc {
	private static final Logger LOG = Logger.getLogger(VideoManageServiceImpl.class);
	@Override
	public void delFile(String realPath, String fileids) throws Exception {
		VideoManageDao videoManageDao = (VideoManageDao)DaoImplClassUtil.getDaoImplClass("videoManageDaoImpl");
		TransactionManager tm = new TransactionManager();
		boolean isdelsucess = true;
		try{
			tm.begin();
			
			String[] fileidArry = fileids.split(",");
			for(int i = 0 ; i < fileidArry.length ; i++){
				String fileid = fileidArry[i];
				if(fileid.indexOf("'") != -1){
					fileid = fileid.split("'")[1];
				}
				VideoInfoBean videoInfoBean = videoManageDao.findVideoFileInfo(fileid);
				String path = realPath+VideoManageConstant.VIDEOFILE_ROOTPATH
							+videoInfoBean.getServerfile_path()+"/"
							+videoInfoBean.getServerfile_name()+"."
							+videoInfoBean.getFile_extra();
				isdelsucess = videoManageDao.deleteServerFileWithPath(path);
				if(!isdelsucess){
					break;
				}
			}
			if(isdelsucess){
				videoManageDao.deleteVideoFileInfo(fileids);
				tm.commit();
			}else{
				tm.rollback();
				LOG.info("删除文件失败!");
				throw new Exception("删除文件失败!");
			}
			
		}catch(Exception e){
			LOG.info(e.getMessage());
			tm.rollback();
			throw e;
		}
		
	}

	@Override
	public UploadFileResultBean uploadFile(VideoInfoBean videoInfoBean)
			throws Exception {
		VideoManageDao videoManageDao = (VideoManageDao)DaoImplClassUtil.getDaoImplClass("fileupload");
		UploadFileResultBean uploadFileResultBean = new UploadFileResultBean();
		TransactionManager tm = new TransactionManager();
		try{
			tm.begin();
			String fileid = videoManageDao.isExsitFile( videoInfoBean.getServerfile_name(), videoInfoBean.getFile_extra(),videoInfoBean.getAttach_id());
			videoInfoBean.setFile_id(fileid);//判断是否已经保存文件到了数据库,根据用户id，服务器文件名，文件扩展名查询
			if(!StringUtil.nullOrBlank(fileid)){
				videoManageDao.updateVideoFileInfo(videoInfoBean);
			}else{
				videoManageDao.saveVideoFileInfo(videoInfoBean);
			}
			
			uploadFileResultBean.setIssucess(true);
			tm.commit();
		}catch(Exception e){
			LOG.info(e.getMessage());
			tm.rollback();
			throw e;
		}
		return uploadFileResultBean;
	}
	
}
