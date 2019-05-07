package com.chinacreator.xtbg.core.upload.service.impl;

import java.io.File;
import java.sql.Connection;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DaoUtil;
import com.chinacreator.xtbg.core.common.util.DateUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.sysparam.util.SysParamUitl;
import com.chinacreator.xtbg.core.upload.dao.UploadDao;
import com.chinacreator.xtbg.core.upload.entity.UploadModel;
import com.chinacreator.xtbg.core.upload.service.UploadService;
import com.chinacreator.xtbg.core.upload.util.UploadConstants;

public class UploadServiceImpl implements UploadService {
	private static final Logger LOG = Logger.getLogger(UploadServiceImpl.class);
	UploadDao uploadDao = (UploadDao)LoadSpringContext.getApplicationContext().getBean("uploadDaoImpl");
	
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 uploadFile
	  * @param uploadModel
	  * @return 
	  * @see com.chinacreator.xtbg.core.upload.service.UploadService#uploadFile(com.chinacreator.xtbg.core.upload.entity.UploadModel) 
	  */
	public JSONObject uploadFile(UploadModel uploadModel){
		Connection conn = null;
		boolean flag = false;
		JSONObject json = new JSONObject();
		try {
			conn = DbManager.getInstance().getConnection();
			//判断是否已经保存文件到了数据库,根据用户id，服务器文件名，文件扩展名查询
			//String fileid = uploadDao.isExsitFile(uploadModel.getTableName(),uploadModel.getServerfile_name(), uploadModel.getFile_extra(),uploadModel.getAttach_id());
			/*if(!StringUtil.nullOrBlank(fileid)){
				uploadModel.setFile_id(fileid);
				flag = uploadDao.updateUploadFileInfo(conn,uploadModel);
			}else{
				fileid = StringUtil.getUUID();
				uploadModel.setFile_id(fileid);
				flag = uploadDao.saveUploadFileInfo(conn,uploadModel);
			}*/
			
			flag = uploadDao.saveUploadFileInfo(conn,uploadModel);
			json.put("uploadModel", uploadModel);
			json.put("info","上传文件成功。");
			json.put("fileid",uploadModel.getFile_id());
		} catch (Exception e) {
			json.put("info",e.getMessage());
            DbManager. rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally {
			if(conn!=null){
                DbManager. closeConnection(conn);
           }
		}
		json.put("flag",flag);
		json.put("uploadModel", uploadModel);
		return json;
	}

	public JSONObject cleanFile(String diskPath){
		Connection conn = null;
		boolean flag = false;
		JSONObject json = new JSONObject();
		try {
			conn = DbManager.getInstance().getConnection();
			String UPLOADSAVEPATH = UploadConstants.UPLOADSAVEPATH;
			String bigfileuploadfolderpath =diskPath+UPLOADSAVEPATH;
			File file = new File(bigfileuploadfolderpath);
			File[] arr4TableNameFolderPath = file.listFiles();
			String[] arr4TableName = file.list();
			String strFilter = ".svn";
			SysParamUitl sysParamUitl=new SysParamUitl();
			String DICTDATA_VALUE=UploadConstants.DICTDATA_VALUE;
			UploadDao uploadDao = (UploadDao)LoadSpringContext.getApplicationContext().getBean("uploadDaoImpl");
			for(int i=0;i<arr4TableNameFolderPath.length;i++){//paper,kbm
				if(arr4TableNameFolderPath[i].toString().indexOf(strFilter)==-1){
					File yearFolderFile = new File(arr4TableNameFolderPath[i].toString());
					File[] arr4YearFolderPath = yearFolderFile.listFiles();
					if (arr4YearFolderPath!=null){
						for(int j=0;j<arr4YearFolderPath.length;j++){//2013,2014
							File monthFolderFile = new File(arr4YearFolderPath[j].toString());
							File[] arr4MonthFolderPath = monthFolderFile.listFiles();
							for(int k=0;k<arr4MonthFolderPath.length;k++){//01,02...10,11,12
								File attachIdFolderFile = new File(arr4MonthFolderPath[k].toString());
								if(true){
									File[] arr4AttachIdFolderPath = attachIdFolderFile.listFiles();
									String[] arr4AttachId = attachIdFolderFile.list();
									StringBuffer sql = new StringBuffer();
									//删除之前先要判断 名为“arr4TableName[i]”的专门记录模块上传文档信息的table在数据库中是否存在
									String isRightUploadTableName = DaoUtil.sqlToField("select '1' from user_constraints t where t.table_name = '"+arr4TableName[i]+"'");        
									json.put(arr4TableName[i]+"_isRightUploadTableName",isRightUploadTableName);
									if ("1".equalsIgnoreCase(isRightUploadTableName)){
										for(int m=0;m<arr4AttachIdFolderPath.length;m++){//5c18daa0-e257-4c8e-9c02-3e6f58c4e564,6dcc6c38-3add-465d-9719-9fad0d0805b1 
											System.out.println("相差小时数"+DateUtil.getDiffHour(DateUtil.getCurrentDateTime(),DateUtil.getDateTime(arr4AttachIdFolderPath[m].lastModified())));
											//不处理字段有问题的，不处理今天的  ,加判断
											if(DateUtil.getDiffHour(DateUtil.getCurrentDateTime(),DateUtil.getDateTime(arr4AttachIdFolderPath[m].lastModified()))>=1){
												List<Map<String, String>> listMap = sysParamUitl.getSysParamByTableName(DICTDATA_VALUE, arr4TableName[i]);
												for (Map<String, String> map : listMap){
													String isRightTableName = DaoUtil.sqlToField("select '1' from user_constraints t where t.table_name = '"+map.get("p_code")+"'");        
													json.put(map.get("p_code")+"_isRightTableName",isRightTableName);
													String isRightColumnName = DaoUtil.sqlToField("select '1' from user_tab_columns t where t.TABLE_NAME=UPPER('"+map.get("p_code")+"') and t.COLUMN_NAME=UPPER('"+map.get("p_content")+"')");
													json.put(map.get("p_content")+"_isRightColumnName",isRightColumnName);
													if("1".equalsIgnoreCase(isRightTableName) &&"1".equalsIgnoreCase(isRightColumnName)){//排除字段配置错误
														sql.append(" select 'find' from "+map.get("p_code")+" where  "+map.get("p_content")+"= '"+arr4AttachId[m]+"' ");
														sql.append(" union all ");
													}
												}
												if(sql.toString()!=""){
													sql.append(" select 'find' from dual where 1=2");
													String iCount = StringUtil.deNull(DaoUtil.sqlToField(sql.toString()));
													if("".equalsIgnoreCase(iCount)){
														//调用删除接口，先对应表的记录删除，再删除磁盘物理文件
														flag = uploadDao.deleteUploadByAttachId(conn, arr4TableName[i], arr4AttachId[m]);
														if (flag) {
															File[] realFile = arr4AttachIdFolderPath[m].listFiles();
															for(int n=0;n<realFile.length;n++){
										                        File deleteRealFile = new File(realFile[n].toString());
										                        deleteRealFile.delete();
															}
									                        File deletefile = new File(arr4AttachIdFolderPath[m].toString());
															if(deletefile.exists()){//删除文件夹
																deletefile.delete();
															}
														}
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
			json.put("info","操作成功！");
			flag=true;
		} catch (Exception e) {
            DbManager. rollBackNoThrow(conn);
            flag=false;
            json.put("info",e.getMessage());
        } finally{
             if(conn != null ){
                 DbManager. closeConnection(conn);
            }
        }
        json.put("flag",flag);
		return json;
	}
}
