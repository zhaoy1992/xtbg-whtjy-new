package com.chinacreator.xtbg.core.file.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspWriter;

import org.apache.commons.io.FileUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.fancyuoload.dao.FiletransfersSysDao;
import com.chinacreator.xtbg.core.common.fancyuoload.dao.impl.FiletransfersSysDaoImpl;
import com.chinacreator.xtbg.core.common.fancyuoload.entity.FileInfoBean;
import com.chinacreator.xtbg.core.common.fancyuoload.service.impl.FiletransferServiceImpl;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.file.dao.FileFilesDevolveDao;
import com.chinacreator.xtbg.core.file.entity.FileFilesDevolveBean;
import com.chinacreator.xtbg.core.file.entity.FileFilesDevolveDetailBean;
import com.chinacreator.xtbg.core.file.service.FileFilesDevolveService;
import com.chinacreator.xtbg.core.file.util.AccessDataBaseManager;
import com.chinacreator.xtbg.core.file.util.ZIPUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 * 档案移交 serivce
 *<p>Title:FileFilesDevolveServiceImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Sep 16, 2013
 */
public class FileFilesDevolveServiceImpl implements FileFilesDevolveService{
	private static final Log LOG = LogFactory.getLog(FileFilesDevolveServiceImpl.class);
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 addDetailBean
	 * @param bean
	 * @return 
	 * @see com.chinacreator.xtbg.core.file.service.FileFilesDevolveService#addDetailBean(com.chinacreator.xtbg.core.file.entity.FileFilesDevolveDetailBean)
	 */
	@Override
	public boolean addDetailBean(FileFilesDevolveDetailBean bean) {
		return false;
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 addOrUpdate
	 * @param bean
	 * @return 
	 * @see com.chinacreator.xtbg.core.file.service.FileFilesDevolveService#addOrUpdate(com.chinacreator.xtbg.core.file.entity.FileFilesDevolveBean)
	 */
	@Override
	public String addOrUpdate(FileFilesDevolveBean bean) {
		Connection conn = null;
		String beanId = "";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FileFilesDevolveDao dao = (FileFilesDevolveDao)LoadSpringContext.getApplicationContext().getBean("FileFilesDevolveDaoImpl");
			//1:设置时间
			bean.setF_log_time(StringUtil.convertStringToTimestamp(StringUtil
					.deNull(bean.getF_log_time()), "yyyy-MM-dd HH24:mi:ss"));
			bean.setF_begin_time(StringUtil.convertStringToTimestamp(StringUtil
					.deNull(bean.getF_begin_time()), "yyyy-MM-dd"));
			bean.setF_den_time(StringUtil.convertStringToTimestamp(StringUtil
					.deNull(bean.getF_den_time()), "yyyy-MM-dd"));
			
			if(StringUtil.nullOrBlank(bean.getF_devolve_id())){//insert
				bean.setF_devolve_id(StringUtil.getUUID());
				beanId = bean.getF_devolve_id();
				//5:添加到数据库
				((BaseDao)dao).insert(bean, conn);
				//6:增加之后不需要修改子节点，因为没有子节点
			}else{//update
				beanId = bean.getF_devolve_id();
				//4:修改数据
				((BaseDao)dao).update(bean, conn);
				//修改子数据
				if(FileFilesDevolveBean.STATE_TWO.equals(bean.getF_state())){
					dao.updateDetailBeanStateByBeanId(conn, beanId);
				}
			}
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
			return "";
		} finally{
			DbManager.closeConnection(conn);
		}
		return beanId;
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 delDetailBeanByIds
	 * @param ids
	 * @return 
	 * @see com.chinacreator.xtbg.core.file.service.FileFilesDevolveService#delDetailBeanByIds(java.lang.String)
	 */
	@Override
	public boolean addDetailBeanByIds(String ids,String beanId) {
		String[] idsArr = ids.split(",");
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FileFilesDevolveDao dao = (FileFilesDevolveDao)LoadSpringContext.getApplicationContext().getBean("FileFilesDevolveDaoImpl");
			
			for (String id : idsArr) {
				FileFilesDevolveDetailBean bean = new FileFilesDevolveDetailBean();
				bean.setF_files_id(id);
				bean.setF_devolve_id(beanId);
				bean.setF_devolve_detail_id(StringUtil.getUUID());
				((BaseDao)dao).insert(bean, conn);
			}
			
			this.keepRightData(conn, beanId);
			flag = true;
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 getDetailBeanListForExport
	 * @param id
	 * @return 
	 * @see com.chinacreator.xtbg.core.file.service.FileFilesDevolveService#getDetailBeanListForExport(java.lang.String)
	 */
	@Override
	public List<Map<String,String>> getDetailBeanListForExport(String id) {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			FileFilesDevolveDao dao = (FileFilesDevolveDao)LoadSpringContext.getApplicationContext().getBean("FileFilesDevolveDaoImpl");
			return dao.getDetailBeanListForExport(conn, id);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return null;
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 getBeanById
	 * @param id
	 * @return 
	 * @see com.chinacreator.xtbg.core.file.service.FileFilesDevolveService#getBeanById(java.lang.String)
	 */
	@Override
	public Map<String, String> getBeanById(String id) {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			FileFilesDevolveDao dao = (FileFilesDevolveDao)LoadSpringContext.getApplicationContext().getBean("FileFilesDevolveDaoImpl");
			return dao.getBeanById(conn, id);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return null;
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 getQZH
	 * @param orgId
	 * @return 
	 * @see com.chinacreator.xtbg.core.file.service.FileFilesDevolveService#getQZH(java.lang.String)
	 */
	@Override
	public String getQZH(String orgId) {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			FileFilesDevolveDao dao = (FileFilesDevolveDao)LoadSpringContext.getApplicationContext().getBean("FileFilesDevolveDaoImpl");
			return dao.getQZH(conn, orgId);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return null;
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 delDetailBeanByIds
	 * @param ids
	 * @return 
	 * @see com.chinacreator.xtbg.core.file.service.FileFilesDevolveService#delDetailBeanByIds(java.lang.String)
	 */
	@Override
	public boolean delDetailBeanByIds(String ids) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FileFilesDevolveDao dao = (FileFilesDevolveDao)LoadSpringContext.getApplicationContext().getBean("FileFilesDevolveDaoImpl");
			String[] beanIdArr = ids.split(",");
			if(beanIdArr.length>0){
				StringBuffer sql = new StringBuffer();
				sql.append("select f_devolve_id from oa_files_devolve_detail t where f_devolve_detail_id = '"+beanIdArr[0]+"'");
				PreparedDBUtil preparedDBUtil = new PreparedDBUtil();
				preparedDBUtil.executeSelect(sql.toString(), conn);
				String f_devolve_id = preparedDBUtil.getString(0, 0);
				
				for (String beanId : beanIdArr) {
					FileFilesDevolveDetailBean bean = new FileFilesDevolveDetailBean();
					bean.setF_devolve_detail_id(beanId);
					((BaseDao)dao).delete(bean, conn);
				}
				
				this.keepRightData(conn, f_devolve_id);
			}
			
			conn.commit();
			flag = true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 delBeanByIds
	 * @param id
	 * @return 
	 * @see com.chinacreator.xtbg.core.file.service.FileFilesDevolveService#delBeanByIds(java.lang.String)
	 */
	@Override
	public boolean delBeanByIds(String id) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FileFilesDevolveDao dao = (FileFilesDevolveDao)LoadSpringContext.getApplicationContext().getBean("FileFilesDevolveDaoImpl");
			String[] beanIdArr = id.split(",");
			for (String beanId : beanIdArr) {
				FileFilesDevolveBean bean = new FileFilesDevolveBean();
				bean.setF_devolve_id(beanId);
				dao.deleteDetailByBeanId(conn,bean.getF_devolve_id());
				((BaseDao)dao).delete(bean, conn);
			}
			conn.commit();
			flag = true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 createZIPForDevolve
	 * @param out
	 * @param busi_id 
	 * @throws Exception 
	 * @throws IOException 
	 * @see com.chinacreator.xtbg.core.file.service.FileFilesDevolveService#createZIPForDevolve(javax.servlet.jsp.JspWriter, java.lang.String)
	 */
	@Override
	public Map<String,String> createZIPForDevolve(JspWriter out,HttpServletRequest request,String busi_id,String f_type){
		try{
			String baseURL = request.getSession().getServletContext().getRealPath("/")+FiletransferServiceImpl.upload_To_SeverPath;
			String mdbURL = request.getSession().getServletContext().getRealPath("/")+"ccapp"+File.separator+"oa"+File.separator+"file"+File.separator+"resources"+File.separator+"mdb";
			String zipFileName = request.getParameter("zipFileName").trim();
			//1:创建目录
			String[] mess = this.createZIPPath(baseURL,zipFileName);
			String thisURL = mess[0];
			String parentURL = mess[1];
			outMess(out, true, "创建目录:["+thisURL+"]");
			
			if("1".equals(f_type)){
				//2.1:查询文书
				List<Map<String,String>> listA = this.getData(busi_id,"WenShu");
				outMess(out, true, "文书记录数量:"+listA.size());
				if(listA.size()>0){
					//2.2:导出MDB
					String mdbFileName= exportMDB("WenShu",listA, mdbURL, thisURL,request);
					if(mdbFileName.length()>0){
						outMess(out, true, "导出MDB文件:["+mdbFileName+"]");
						//2.3:导出文档
						outMess(out, false, "导出电子文件:");
						exportFile(listA,out,thisURL);
					}
				}
			}else if("2".equals(f_type)){
				//5.1:查询照片
				List<Map<String,String>> listD = this.getData(busi_id,"ZhaoPian");
				outMess(out, true, "照片记录数量:"+listD.size());
				if(listD.size()>0){
					//2.2:导出MDB
					String mdbFileName= exportMDB("ZhaoPian",listD, mdbURL, thisURL,request);
					if(mdbFileName.length()>0){
						outMess(out, true, "导出MDB文件:["+mdbFileName+"]");
						//2.3:导出文档
						outMess(out, false, "导出电子文件:");
						exportFile(listD,out,thisURL);
					}
				}
			}else if("3".equals(f_type)){
				//3.1:查询视频
				List<Map<String,String>> listB = this.getData(busi_id,"ShiPin");
				outMess(out, true, "视频记录数量:"+listB.size());
				if(listB.size()>0){
					//2.2:导出MDB
					String mdbFileName= exportMDB("ShiPin",listB, mdbURL, thisURL,request);
					if(mdbFileName.length()>0){
						outMess(out, true, "导出MDB文件:["+mdbFileName+"]");
						//2.3:导出文档
						outMess(out, false, "导出电子文件:");
						exportFile(listB,out,thisURL);
					}
				}
			}else if("4".equals(f_type)){
				//4.1:查询光盘
				List<Map<String,String>> listC = this.getData(busi_id,"GuangPan");
				outMess(out, true, "光盘记录数量:"+listC.size());
				if(listC.size()>0){
					//2.2:导出MDB
					String mdbFileName= exportMDB("GuangPan",listC, mdbURL, thisURL,request);
					if(mdbFileName.length()>0){
						outMess(out, true, "导出MDB文件:["+mdbFileName+"]");
						//2.3:导出文档
						outMess(out, false, "导出电子文件:");
						exportFile(listC,out,thisURL);
					}
				}
			}
			
			
			//end:创建zip
			String zipFileUrl = parentURL+File.separator+zipFileName+".zip";
			outMess(out, false, "正在创建文件压缩包：["+zipFileUrl+"]");
			boolean b = ZIPUtil.getInstance().createZipFile(thisURL,zipFileUrl);
			if(b){
				outMess(out, true, "	成功");
				outMess(out, true, "导出结束(成功)");
				outMess(out, true, "");
				Map<String,String> map = new HashMap<String,String>();
				map.put("name", zipFileName+".zip");
				map.put("url", zipFileUrl.replace("\\","/"));
				//map.put("url", zipFileUrl.substring(zipFileUrl.indexOf("ccapp\\FcAttach")).replace("\\","/"));
				return map;
			}else{
				outMess(out, true, "导出结束(失败)");
			}
			outMess(out, true, "");
		}catch(IOException e){
			outMess(out, true, "导出结束(失败)");
		}catch(SQLException e){
			outMess(out, true, "导出结束(失败)");
		}catch(Exception e){
			outMess(out, true, "导出结束(失败)");
		}
		return null;
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * exportFile(导出File)
	 * @param list
	 * @throws IOException 
	 * @throws Exception 
	 * @throws Exception 
	 */
	private void exportFile(List<Map<String, String>> list,JspWriter out,String thisURL) throws Exception {
		//code copy from FileDownloadServlet
		FiletransfersSysDao fsd = new FiletransfersSysDaoImpl();
		for (Map<String, String> map : list) {
			String djsn = map.get("djsn");
			if(djsn!=null){
				FileInfoBean fib = fsd.getFileByDjsn(djsn);
				if(fib!=null&&fib.getFileInput()!=null){
					//创建目录
					String path = thisURL+map.get("dzwjm_path");//+map.get("dzwjm_name")
					File filePath = new File(path);
					if(!filePath.exists()){
						filePath.mkdirs();
						outMess(out, true, "----创建目录:"+path);
					}
					//copy文件
					String name = map.get("dzwjm_name");
					if(name!=null&&name.length()>0){
						name = name.replaceAll("[\\\\]|[/]|[:]|[*]|[?]|[<]|[>]|[|]|[\"]", "_");
						File file = null;
						int i = 0;
						do{
							String fileName = null;
							if(i>0){
								fileName = path+name.substring(0, name.lastIndexOf("."))+"("+i+")"+name.substring(name.lastIndexOf("."));
							}else{
								fileName = path+map.get("dzwjm_name");
							}
							file = new File(fileName);
							i++;
						}while(file.exists());
						file.createNewFile();
						outMess(out, false, "----创建文件:"+file.getName());
						FileOutputStream output = new FileOutputStream(file);
						byte[] b = new byte[1024];
						int ii = 0;
						while ((ii = fib.getFileInput().read(b)) > 0) {
							output.write(b, 0, ii);
						}
						outMess(out, true, "   成功");
						output.flush();
						output.close();
					}
				}
			}
		}
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * outMess(请用一句话描述这个方法的作用)
	 * @param out
	 * @param flag
	 * @param mess
	 */
	public void outMess(JspWriter out,boolean flag,String mess){
		try {
			if(flag){
				out.write(mess+"\r\n");
			}else{
				out.write(mess);
			}
			out.flush();
			LOG.info("导出移交信息:"+mess);
		} catch (IOException e) {
			LOG.info("导出移交信息:日志输出对象出错");
		}
	}
	
	private String[] createZIPPath(String baseURL,String zipFileName){
		//创建临时目录
		File filePath = null;
		do{
			String newPath = StringUtil.getUUID();
			filePath = new File(baseURL+File.separator+newPath);
		}while(filePath.exists());
		filePath.mkdir();
		String parentURL = filePath.getPath();
		filePath = new File(filePath.getPath()+File.separator+zipFileName);
		filePath.mkdir();
		String thisURL = filePath.getPath();
		return new String[]{thisURL,parentURL};
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * getData(按照类别 提取移交的数据)
	 * @param busi_id
	 * @param type
	 * @return
	 */
	private List<Map<String,String>> getData(String busi_id,String type){
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			FileFilesDevolveDao dao = (FileFilesDevolveDao)LoadSpringContext.getApplicationContext().getBean("FileFilesDevolveDaoImpl");
			//目前sql几乎一样
			if(type.equals("WenShu")){
				return dao.getWenShuList(conn, busi_id);
			}else if(type.equals("ShiPin")){
				return dao.getShiPinList(conn, busi_id);
			}else if(type.equals("GuangPan")){
				return dao.getGuangPanList(conn, busi_id);
			}else if(type.equals("ZhaoPian")){
				return dao.getZhaoPianList(conn, busi_id);
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return null;
	}
	
	public final static String MDB_NAME_WENSHU = "backup文本.mdb";
	public final static String MDB_NAME_SHIPIN = "backup视频.mdb";
	public final static String MDB_NAME_GUANGPAN = "backup光盘.mdb";
	public final static String MDB_NAME_ZhaoPian = "backup照片.mdb";
	/**
	 * 
	 *<b>Summary: </b>
	 * exportMDB(导出)
	 * @param type
	 * @param list
	 * @param mdbURL
	 * @param thisURL
	 * @param request
	 * @return
	 * @throws Exception
	 */
	private String exportMDB(String type,List<Map<String,String>> list,String mdbURL,String thisURL,HttpServletRequest request) throws Exception{
		String oldFileName = "";
		if(type.equals("WenShu")){
			oldFileName = MDB_NAME_WENSHU;
		}else if(type.equals("ShiPin")){
			oldFileName = MDB_NAME_SHIPIN;
		}else if(type.equals("GuangPan")){
			oldFileName = MDB_NAME_GUANGPAN;
		}else if(type.equals("ZhaoPian")){
			oldFileName = MDB_NAME_ZhaoPian;
		}
		
		//0:check
		if(list==null||list.size()==0){
			return "";
		}
		//1:copy fileA -> fileB
		File fileA = new File(mdbURL+File.separator+oldFileName);
		if(!fileA.exists()){
			return "";
		}
		File fileB = new File(thisURL+File.separator+oldFileName);
		FileUtils.copyFile(fileA, fileB);
		//2:export mdb
		String ciPanName = request.getParameter("ciPanName");
		String zipFileName = request.getParameter("zipFileName").trim();
		List<Map<Integer,String>> dataList = new ArrayList<Map<Integer,String>>();
		for (Map<String,String> map : list) {
			Map<Integer,String> tmpMap = new LinkedHashMap<Integer,String>();
			tmpMap.put(1, map.get("qzh"));
			tmpMap.put(2, map.get("hh"));
			tmpMap.put(3, map.get("jh"));
			tmpMap.put(4, map.get("nd"));
			tmpMap.put(5, map.get("zrz"));
			tmpMap.put(6, map.get("bgqx"));
			tmpMap.put(7, map.get("wh"));
			tmpMap.put(8, map.get("wt"));
			tmpMap.put(9, map.get("tm"));
			tmpMap.put(10, map.get("cwsj"));
			tmpMap.put(11, map.get("ys"));
			tmpMap.put(12, map.get("xxlx"));
			tmpMap.put(13, map.get("bz"));
			String dzwjm_name = map.get("dzwjm_name");
			if(dzwjm_name!=null&&dzwjm_name.length()>0){
				tmpMap.put(14, ciPanName+zipFileName+map.get("dzwjm_path")+map.get("dzwjm_name"));
			}else{
				tmpMap.put(14, "");
			}
			
			dataList.add(tmpMap);
		}
		AccessDataBaseManager adb = new AccessDataBaseManager(fileB.getPath());
		String sql = "INSERT INTO FILE_CATALOG(QZH,HH,JH,ND,ZRZ,BGQX,WH,WT,TM,CWSJ,YS,XXLX,BZ,DZWJM) VALUES";
		adb.insert(getSQLList(sql, dataList));
		return fileB.getPath();
	}
	private List<String> getSQLList(String sql,List<Map<Integer,String>> dataList){
		List<String> list = new ArrayList<String>();
		for (Map<Integer,String> map : dataList) {
			StringBuffer sqlSB = new StringBuffer(sql);
			sqlSB.append("(");
			for (Integer key : map.keySet()) {
				if(key.intValue()==1){
					sqlSB.append("'"+map.get(key)+"'");
				}else{
					sqlSB.append(",'"+map.get(key)+"'");
				}
			}
			sqlSB.append(")");
			list.add(sqlSB.toString());
		}
		return list;
	}
	
	public void keepRightData(Connection conn,String ...ids) throws  Exception{
		PreparedDBUtil preparedDBUtil = new PreparedDBUtil();
		for (String id : ids) {
			//1,判断是那种类型的案卷
			StringBuffer sql = new StringBuffer();
			sql.append("select count(1) countt,");
			sql.append("       to_char(min(b.f_start_time), 'yyyy-MM-dd') F_START_TIME,");
			sql.append("       to_char(max(b.f_end_time), 'yyyy-MM-dd') F_END_TIME");
			sql.append("  from oa_files_devolve_detail a, oa_file_files b");
			sql.append(" where a.f_files_id = b.f_files_id");
			sql.append("   and f_devolve_id = '"+id+"'");
			preparedDBUtil.executeSelect(sql.toString(), conn);
			String countt = preparedDBUtil.getString(0, 0);
			String f_start_time = preparedDBUtil.getString(0, 1);
			String f_end_time = preparedDBUtil.getString(0, 2);
			FileFilesDevolveBean bean = new FileFilesDevolveBean();
			bean.setF_devolve_id(id);
			bean.setF_num(countt);
			if(!StringUtil.nullOrBlank(f_start_time)){
				bean.setF_begin_time(StringUtil.convertStringToTimestamp(f_start_time, "yyyy-MM-dd"));
			}else{
				bean.setF_begin_time("");
			}
			if(!StringUtil.nullOrBlank(f_end_time)){
				bean.setF_den_time(StringUtil.convertStringToTimestamp(f_end_time, "yyyy-MM-dd"));
			}else{
				bean.setF_den_time("");
			}
            FileFilesDevolveDao dao = (FileFilesDevolveDao)LoadSpringContext.getApplicationContext().getBean("FileFilesDevolveDaoImpl");
            ((BaseDao)dao).update(bean,conn);
		}
	}
	/**
	 * file_catalog
QZH       全宗号
HH        盒号
JH        档案室编件号
ND	      归档年度
ZRZ       责任者
BGQX      保管期限
WH        文号
WT        组织机构或问题
TM        题名
CWSJ      文件形成时间   yyyyMMdd
YS        页数
XXLX      信息类型（文本、图像、影像、声音）
BZ        备注
DZWJM     电子文件名称
	 * 
	 * 
	 * 
	 */
	public static void main(String[] args) {
		String name = "\\/:*?<>!";
		name = name.replaceAll("[\\\\]|[/]|[:]|[*]|[?]|[<]|[>]|[|]|[\"]", "_");
		System.out.println(name);
	}
}
