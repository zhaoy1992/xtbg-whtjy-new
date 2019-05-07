package com.chinacreator.xtbg.core.archive.service.impl;

import java.io.File;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.archive.common.SplitExcelFile;
import com.chinacreator.xtbg.core.archive.dao.SplitLogDao;
import com.chinacreator.xtbg.core.archive.dao.impl.SplitLogDaoImpl;
import com.chinacreator.xtbg.core.archive.entity.ExcelBean;
import com.chinacreator.xtbg.core.archive.entity.SplitLogBean;
import com.chinacreator.xtbg.core.archive.service.SplitLogService;
import com.chinacreator.xtbg.core.common.cache.OASystemCache;
import com.chinacreator.xtbg.core.common.util.DaoUtil;
import com.chinacreator.xtbg.core.common.util.DateUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.ResultCode;
import com.chinacreator.xtbg.core.common.util.ResultMap;

/**
 * 
 *<p>Title:SplitLogServiceImpl.java</p>
 *<p>Description:指标文拆分服务层实现</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *Sep 16, 2013
 */
public class SplitLogServiceImpl implements SplitLogService {
	private static final Logger LOG = Logger.getLogger(SplitLogServiceImpl.class);
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 insert
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.caizhengting.split.service.SplitLogService#insert(com.chinacreator.xtbg.caizhengting.split.entity.SplitLogBean)
	 */
	@Override
	public ResultMap<ResultCode, SplitLogBean> insert(SplitLogBean bean) {
		ResultMap<ResultCode, SplitLogBean> result = new ResultMap<ResultCode, SplitLogBean>();
		result.setCode(ResultCode.FAIL);
		if(bean != null ){
			if(bean.getFile_name() == null || "".equals(bean.getFile_name())){
				result.setCode(ResultCode.MISS_SPLIT_FILENAME);
			} else {
				SplitLogDao dao = new SplitLogDaoImpl();
				Connection con = null;
				try {
					con = DbManager.getInstance().getConnection();
					bean.setUnit_id(DaoUtil.getUUID());
					dao.insert(bean, con);
					result.setCode(ResultCode.OK);
				} catch (Exception e) {
					LOG.error(e.getMessage(),e);
				} finally {
					DbManager.closeConnection(con);
				}
			}
		}
		return result;
	}
	@Override
	public String splitFile(String relative_path,String fileName,int header_row,String user_id,String buss_id) {
		String file_url = OASystemCache.getContextProperty("oa_split_file_save_path");
		SplitExcelFile split = new SplitExcelFile(header_row);
		StringBuffer outStr = new StringBuffer();
		
		SplitLogDao dao = new SplitLogDaoImpl();
		Connection con = null;
		String filePath = file_url+relative_path+File.separator+fileName;
		SimpleDateFormat format = new SimpleDateFormat("HH:mm:ss sss");
		try {
			con = DbManager.getInstance().getConnection();
			outStr.append("<p>["+format.format(new Date())+"]: 开始拆分文件...</p>");
			List<ExcelBean> list = split.splitExcelFile(filePath);
			outStr.append("<p>["+format.format(new Date())+"]: 文件拆分完成，正在保存数据...</p>");
			
			SplitLogBean sb = new SplitLogBean();
			sb.setBuss_id(buss_id);
			sb.setFile_name(fileName);
			dao.deleteByBussidAndFileName(sb, con);	//保存之前，将同一个bussid下的同名的数据删除
			
			if(list != null && list.size() > 0){
				
				//保存主文件
				String parent_id = DaoUtil.getUUID();
				
				SplitLogBean splitlogBean = new SplitLogBean();
				splitlogBean.setBuss_id(buss_id);
				splitlogBean.setFile_name(fileName);
				
				File file = new File(filePath);
				splitlogBean.setFile_path(relative_path+File.separator+fileName);
				splitlogBean.setFile_size(file.length());
				splitlogBean.setParent_id("");
				splitlogBean.setSplit_log_id(parent_id);
				splitlogBean.setUnit_id("");
				splitlogBean.setUser_id(user_id);
				splitlogBean.setCreated(DateUtil.getCurrentDate());
				dao.insert(splitlogBean, con);
				outStr.append("<p>["+format.format(new Date())+"]: "+fileName+" 保存成功！</p>");
				
				String tmpfileName = fileName.substring(0, fileName.lastIndexOf("."))+"拆分后";
				//保存拆分的文件
				for(ExcelBean bean : list){
					SplitLogBean splitlogBean1 = new SplitLogBean();
					splitlogBean1.setBuss_id(buss_id);
					splitlogBean1.setFile_name(bean.getTitle());
					splitlogBean1.setFile_path(relative_path+File.separator+tmpfileName+File.separator+bean.getTitle());
					splitlogBean1.setFile_size(bean.getFile_size());
					splitlogBean1.setParent_id(parent_id);
					splitlogBean1.setSplit_log_id(DaoUtil.getUUID());
					splitlogBean1.setUnit_id(bean.getUnit_id());
					splitlogBean1.setUser_id(user_id);
					splitlogBean1.setCreated(DateUtil.getCurrentDate());
					dao.insert(splitlogBean1, con);
					outStr.append("<p>["+format.format(new Date())+"]: "+bean.getTitle()+" 保存成功！</p>");
				}
				outStr.append("<p>["+format.format(new Date())+"]: 文件拆分成功！共拆分文件："+(list.size())+"个，如果拆分不完全，请检查拆分单位及正确的标题行数！</p>");
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
			outStr.append("<p>["+format.format(new Date())+"]: 系统异常，结束拆分！</p>");
		} finally {
			DbManager.closeConnection(con);
		}
		return outStr.toString();
	}
	@Override
	public ResultMap<ResultCode, List<SplitLogBean>> getGwcsOrg(String buss_id) {
		ResultMap<ResultCode, List<SplitLogBean>> result = new ResultMap<ResultCode, List<SplitLogBean>>();
		result.setCode(ResultCode.FAIL);
		if(buss_id == null || "".equals(buss_id)){
			result.setCode(ResultCode.MISS_ID);
		} else {
			SplitLogDao dao = new SplitLogDaoImpl();
			Connection con = null;
			try {
				con = DbManager.getInstance().getConnection();
				SplitLogBean bean = new SplitLogBean();
				List<SplitLogBean> list = new ArrayList<SplitLogBean>();
				bean.setBuss_id(buss_id);
				list = dao.getGwcsOrg(bean,con);
				if(list != null || list.size() > 0){
					result.setCode(ResultCode.OK);	
					result.setResult(list);
				} else {
					result.setCode(ResultCode.UNEXIST);
				}
			} catch (Exception e) {
				LOG.error(e.getMessage(),e);
			} finally {
				DbManager.closeConnection(con);
			}
		}
		return result;
	}
}
