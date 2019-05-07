package com.chinacreator.xtbg.yimingju.fileUpload.dao.imploracle;

import java.io.File;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.pub.util.DateUtil;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.chinacreator.xtbg.yimingju.fileUpload.dao.VideoManageDao;
import com.chinacreator.xtbg.yimingju.fileUpload.entity.VideoInfoBean;
import com.chinacreator.xtbg.yimingju.fileUpload.entity.VideoListSearchBean;
import com.chinacreator.xtbg.yimingju.fileUpload.entity.VideoManageConstant;
import com.frameworkset.common.poolman.PreparedDBUtil;

public class VideoManageDaoImpl implements VideoManageDao {
	private static final Logger LOG = Logger.getLogger(VideoManageDaoImpl.class);
	
	@Override
	public PagingBean findVideoFileList(
			VideoListSearchBean videoListSearchBean, String sortName,
			String sortOrder, long offset, int maxPagesize) {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<VideoInfoBean> list = new ArrayList<VideoInfoBean>();
		StringBuffer sql = new StringBuffer();
		
		sql.append("select distinct(file_id),file_name, ");
	    sql.append("   file_type, ");
	    sql.append("   serverfile_name, ");
	    sql.append("   file_extra, ");
	    sql.append("   serverfile_path, ");
	    sql.append("   file_size, ");
	    sql.append("   parentfile_id, ");
	    sql.append("   user_id, ");
	    sql.append("   depart_id, ");
	    sql.append("   upload_time, ");
	    sql.append("   is_share ");
	    sql.append("   is_systemcreate ");
	    sql.append("from ta_oa_videomanage_fileinfo ");
	    
	    

		sql.append(" order by " + sortName + " " + sortOrder);
		
		try {
			int j = 1;
	    	db.preparedSelect(sql.toString(), offset, maxPagesize);

	    	db.executePrepared();
	    	for(int i = 0 ; i < db.size() ; i ++){
	    		VideoInfoBean videoInfoBean = new VideoInfoBean();
	    		videoInfoBean.setFile_id(db.getString(i,"file_id"));
	    		videoInfoBean.setFile_name(db.getString(i,"file_name"));
		    	videoInfoBean.setFile_type(db.getString(i,"file_type"));
		    	videoInfoBean.setServerfile_name(db.getString(i,"serverfile_name"));
		    	videoInfoBean.setFile_extra(db.getString(i,"file_extra"));
		    	videoInfoBean.setServerfile_path(db.getString(i,"serverfile_path"));
		    	videoInfoBean.setFile_size(getFileSizeWithLong(db.getLong(i,"file_size")));
		    	videoInfoBean.setParentfile_id(db.getString(i,"parentfile_id"));
		    	videoInfoBean.setUser_id(db.getString(i,"user_id"));
		    	videoInfoBean.setDepart_id(db.getString(i,"depart_id"));
		    	videoInfoBean.setUpload_time(DateUtil.GetTimeString(db.getTimestamp(i,"upload_time")));
		    	videoInfoBean.setIs_share(db.getString(i,"is_share"));
		    	videoInfoBean.setIs_systemcreate(db.getString(i,"is_systemcreate"));
	    		
	    		list.add(videoInfoBean);
	    	}
	    } catch (SQLException e) {
			e.printStackTrace();
			LOG.error("执行在线评议列表查询报错："+e.getMessage());
		}
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}

	@Override
	public List<VideoInfoBean> getVideoListByDepartId(String departid)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		PreparedDBUtil pdb = new PreparedDBUtil();
		List<VideoInfoBean> list = new ArrayList<VideoInfoBean>();
		sql.append("select distinct(file_id),file_name, ");
	    sql.append("   file_type, ");
	    sql.append("   serverfile_name, ");
	    sql.append("   file_extra, ");
	    sql.append("   serverfile_path, ");
	    sql.append("   file_size, ");
	    sql.append("   parentfile_id, ");
	    sql.append("   user_id, ");
	    sql.append("   depart_id, ");
	    sql.append("   upload_time, ");
	    sql.append("   is_share ");
	    sql.append("   is_systemcreate ");
	    sql.append("from ta_oa_videomanage_fileinfo ");
	    
	    sql.append(" where depart_id = ?");

	    try {
			int j = 1;
	    	pdb.preparedSelect(sql.toString());
	    	pdb.setString(1, departid);
	    	pdb.executePrepared();
	    	for(int i = 0 ; i < pdb.size() ; i ++){
	    		VideoInfoBean videoInfoBean = new VideoInfoBean();
	    		videoInfoBean.setFile_id(pdb.getString(i,"file_id"));
	    		videoInfoBean.setFile_name(pdb.getString(i,"file_name"));
		    	videoInfoBean.setFile_type(pdb.getString(i,"file_type"));
		    	videoInfoBean.setServerfile_name(pdb.getString(i,"serverfile_name"));
		    	videoInfoBean.setFile_extra(pdb.getString(i,"file_extra"));
		    	videoInfoBean.setServerfile_path(pdb.getString(i,"serverfile_path"));
		    	videoInfoBean.setFile_size(getFileSizeWithLong(pdb.getLong(i,"file_size")));
		    	videoInfoBean.setParentfile_id(pdb.getString(i,"parentfile_id"));
		    	videoInfoBean.setUser_id(pdb.getString(i,"user_id"));
		    	videoInfoBean.setDepart_id(pdb.getString(i,"depart_id"));
		    	videoInfoBean.setUpload_time(DateUtil.GetTimeString(pdb.getTimestamp(i,"upload_time")));
		    	videoInfoBean.setIs_share(pdb.getString(i,"is_share"));
		    	videoInfoBean.setIs_systemcreate(pdb.getString(i,"is_systemcreate"));
	    		
	    		list.add(videoInfoBean);
	    	}
	    } catch (SQLException e) {
			e.printStackTrace();
			LOG.error("执行在线评议列表查询报错："+e.getMessage());
		}

		
		
		return list;
	}

	@Override
	public void deleteVideoFileInfo(String ids) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		try{
			sql.append("delete ta_oa_videomanage_fileinfo where file_id in (").append(ids).append(")");
			pdb.preparedDelete(sql.toString());
			pdb.executePrepared();
		}catch(Exception e){
			
			LOG.error("视频管理删除报错："+e.getMessage());
		}
		
	}

	@Override
	public VideoInfoBean findVideoFileInfo(String fileid) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		VideoInfoBean videoInfoBean = new VideoInfoBean();
		try{

			sql.append("select file_name, ");
		    sql.append("   file_type, ");
		    sql.append("   serverfile_name, ");
		    sql.append("   file_extra, ");
		    sql.append("   serverfile_path, ");
		    sql.append("   file_size, ");
		    sql.append("   parentfile_id, ");
		    sql.append("   user_id, ");
		    sql.append("   depart_id, ");
		    sql.append("   upload_time, ");
		    sql.append("   is_share ");
		    sql.append("   is_systemcreate ");
		    sql.append("from ta_oa_videomanage_fileinfo ");
		    sql.append("where file_id = ? ");
		    pdb.preparedSelect(sql.toString());
		    pdb.setString(1, fileid);
		    pdb.executePrepared();
		    if(pdb.size()> 0){
		    	videoInfoBean.setFile_id(fileid);
		    	videoInfoBean.setFile_name(pdb.getString(0,"file_name"));
		    	videoInfoBean.setFile_type(pdb.getString(0,"file_type"));
		    	videoInfoBean.setServerfile_name(pdb.getString(0,"serverfile_name"));
		    	videoInfoBean.setFile_extra(pdb.getString(0,"file_extra"));
		    	videoInfoBean.setServerfile_path(pdb.getString(0,"serverfile_path"));
		    	videoInfoBean.setFile_size(pdb.getString(0,"file_size"));
		    	videoInfoBean.setParentfile_id(pdb.getString(0,"parentfile_id"));
		    	videoInfoBean.setUser_id(pdb.getString(0,"user_id"));
		    	videoInfoBean.setDepart_id(pdb.getString(0,"depart_id"));
		    	videoInfoBean.setUpload_time(DateUtil.GetTimeString(pdb.getTimestamp(0,"upload_time")));
		    	videoInfoBean.setIs_share(pdb.getString(0,"is_share"));
		    	videoInfoBean.setIs_systemcreate(pdb.getString(0,"is_systemcreate"));
		    }

		}catch(Exception e){
			LOG.error("视频管理查询信息报错："+e.getMessage());
		}
		return videoInfoBean;
	}
	
	

	@Override
	public VideoInfoBean findVideoFileViewUrl(String fileid) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		VideoInfoBean videoInfoBean = new VideoInfoBean();
		try{

			sql.append("select file_name, ");
		    sql.append("   serverfile_name, ");
		    sql.append("   file_extra ");
		    sql.append("from ta_oa_videomanage_fileinfo ");
		    sql.append("where file_id = ? ");
		    pdb.preparedSelect(sql.toString());
		    pdb.setString(1, fileid);
		    pdb.executePrepared();
		    if(pdb.size()> 0){
		    	videoInfoBean.setFile_id(fileid);
		    	videoInfoBean.setFile_name(pdb.getString(0,"file_name"));
		    	videoInfoBean.setServerfile_name(pdb.getString(0,"serverfile_name"));
		    	videoInfoBean.setFile_extra(pdb.getString(0,"file_extra"));
		    	videoInfoBean.setServerfile_path(VideoManageConstant.VIDEOFILE_ROOTPATH+"/"+pdb.getString(0,"serverfile_name")+"."+pdb.getString(0,"file_extra"));
		    }

		}catch(Exception e){
			LOG.error("视频管理查询信息报错："+e.getMessage());
		}
		return videoInfoBean;
	}

	@Override
	public String saveVideoFileInfo(VideoInfoBean videoInfoBean)
			throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		StringBuffer sql1 = new StringBuffer();
		String file_id = "";
		try{
			sql1.append("select SEQ_OA_fileupload.nextval file_id from dual");
			sql.append("insert into ta_oa_fileupload ");
			sql.append("  (file_id, ");
			sql.append("   file_name, ");
			sql.append("   file_type, ");
			sql.append("   serverfile_name, ");
			sql.append("   file_extra, ");
			sql.append("   serverfile_path, ");
			sql.append("   file_size, ");
			sql.append("   parentfile_id, ");
			sql.append("   user_id, ");
			sql.append("   depart_id, ");
			sql.append("   upload_time, ");
			sql.append("   is_systemcreate, ");
			sql.append("   is_share, ");
			sql.append("   creatortime, ");
			sql.append("   attach_id) ");
			sql.append("values ");
			sql.append("  (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, sysdate,?) ");
			
			pdb.preparedSelect(sql1.toString());
			pdb.executePrepared();
			file_id = pdb.getString(0, "file_id");
			
			pdb.preparedInsert(sql.toString());
			int i = 1;
			pdb.setString(i++, file_id);
			pdb.setString(i++, StringUtil.deNull(videoInfoBean.getFile_name()));
			pdb.setString(i++, StringUtil.deNull(videoInfoBean.getFile_type()));
			pdb.setString(i++, StringUtil.deNull(videoInfoBean.getServerfile_name()));
			pdb.setString(i++, StringUtil.deNull(videoInfoBean.getFile_extra()));
			pdb.setString(i++, StringUtil.deNull(videoInfoBean.getServerfile_path()));
			pdb.setString(i++, StringUtil.deNull(videoInfoBean.getFile_size()));
			pdb.setString(i++, StringUtil.deNull(videoInfoBean.getParentfile_id()));
			pdb.setString(i++, StringUtil.deNull(videoInfoBean.getUser_id()));
			pdb.setString(i++, StringUtil.deNull(videoInfoBean.getDepart_id()));
			pdb.setTimestamp(i++, DateUtil.parseTimeString(StringUtil.deNull(videoInfoBean.getUpload_time())));
			pdb.setString(i++, StringUtil.deNull(videoInfoBean.getIs_systemcreate()));
			pdb.setString(i++, StringUtil.deNull(videoInfoBean.getIs_share()));
			pdb.setString(i++, StringUtil.deNull(videoInfoBean.getAttach_id()));
			pdb.executePrepared();
		}catch(Exception e){
			
			LOG.error("视频管理插入报错："+e.getMessage());
			throw e;
		}
		return file_id;
	}

	@Override
	public void updateVideoFileInfo(VideoInfoBean videoInfoBean)
			throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		try{
			sql.append("update ta_oa_videomanage_fileinfo ");
			sql.append("   set  ");
			
			if(!StringUtil.nullOrBlank(videoInfoBean.getFile_name())){
				sql.append("       file_name       = ?,");
			}
			if(!StringUtil.nullOrBlank(videoInfoBean.getFile_type())){
				sql.append("       file_type       = ?,");
			}
			if(!StringUtil.nullOrBlank(videoInfoBean.getServerfile_name())){
				sql.append("       serverfile_name = ?,");
			}
			if(!StringUtil.nullOrBlank(videoInfoBean.getFile_extra())){
				sql.append("       file_extra      = ?,");			
			}
			if(!StringUtil.nullOrBlank(videoInfoBean.getServerfile_path())){
				sql.append("       serverfile_path = ?,");
			}
			if(!StringUtil.nullOrBlank(videoInfoBean.getFile_size())){
				sql.append("       file_size       = ?,");
			}
			if(!StringUtil.nullOrBlank(videoInfoBean.getParentfile_id())){
				sql.append("       parentfile_id   = ?,");
			}
			if(!StringUtil.nullOrBlank(videoInfoBean.getUser_id())){
				sql.append("       user_id         = ?,");
			}
			if(!StringUtil.nullOrBlank(videoInfoBean.getDepart_id())){
				sql.append("       depart_id       = ?,");
			}
			if(!StringUtil.nullOrBlank(videoInfoBean.getUpload_time())){
				sql.append("       upload_time     = ?,");
			}
			if(!StringUtil.nullOrBlank(videoInfoBean.getIs_share())){
				sql.append("       is_share        = ?,");
			}
			if(!StringUtil.nullOrBlank(videoInfoBean.getIs_systemcreate())){
				sql.append("       is_systemcreate       = ?,");
			}
			pdb.preparedUpdate(sql.substring(0, sql.length()-1) + " where file_id         = ?");
			int i = 1;
			
			if(!StringUtil.nullOrBlank(videoInfoBean.getFile_name())){
				pdb.setString(i++, StringUtil.deNull(videoInfoBean.getFile_name()));
			}
			if(!StringUtil.nullOrBlank(videoInfoBean.getFile_type())){
				pdb.setString(i++, StringUtil.deNull(videoInfoBean.getFile_type()));
			}
			if(!StringUtil.nullOrBlank(videoInfoBean.getServerfile_name())){
				pdb.setString(i++, StringUtil.deNull(videoInfoBean.getServerfile_name()));
			}
			if(!StringUtil.nullOrBlank(videoInfoBean.getFile_extra())){
				pdb.setString(i++, StringUtil.deNull(videoInfoBean.getFile_extra()));			
			}
			if(!StringUtil.nullOrBlank(videoInfoBean.getServerfile_path())){
				pdb.setString(i++, StringUtil.deNull(videoInfoBean.getServerfile_path()));
			}
			if(!StringUtil.nullOrBlank(videoInfoBean.getFile_size())){
				pdb.setString(i++, StringUtil.deNull(videoInfoBean.getFile_size()));
			}
			if(!StringUtil.nullOrBlank(videoInfoBean.getParentfile_id())){
				pdb.setString(i++, StringUtil.deNull(videoInfoBean.getParentfile_id()));
			}
			if(!StringUtil.nullOrBlank(videoInfoBean.getUser_id())){
				pdb.setString(i++, StringUtil.deNull(videoInfoBean.getUser_id()));
			}
			if(!StringUtil.nullOrBlank(videoInfoBean.getDepart_id())){
				pdb.setString(i++, StringUtil.deNull(videoInfoBean.getDepart_id()));
			}
			if(!StringUtil.nullOrBlank(videoInfoBean.getUpload_time())){
				pdb.setTimestamp(i++, DateUtil.parseTimeString(StringUtil.deNull(videoInfoBean.getUpload_time())));
			}
			if(!StringUtil.nullOrBlank(videoInfoBean.getIs_share())){
				pdb.setString(i++, StringUtil.deNull(videoInfoBean.getIs_share()));
			}
			if(!StringUtil.nullOrBlank(videoInfoBean.getIs_systemcreate())){
				pdb.setString(i++, StringUtil.deNull(videoInfoBean.getIs_systemcreate()));
			}
			
			pdb.setString(i++, StringUtil.deNull(videoInfoBean.getFile_id()));
			pdb.executePrepared();
		}catch(Exception e){
			LOG.error("视频管理更新信息报错："+e.getMessage());
			throw e;
		}
		
	}
	
	
	@Override
	public boolean deleteServerFileWithPath(String path) throws Exception {
		File file = new File(path);
		return file.delete();
	}

	
	
	@Override
	public String isExsitFile(String serverfilename, String extrainfo,String wc_fjid)
			throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		String fileid = "";
		try{
			sql.append("select file_id from TA_OA_FILEUPLOAD t ");
			sql.append("where 1=1  ");
			if(!StringUtil.nullOrBlank(serverfilename)){
				sql.append(" and file_name = ?  ");
			}
			if(!StringUtil.nullOrBlank(extrainfo)){
				sql.append(" and file_extra = ?  ");
			}
			if(!StringUtil.nullOrBlank(wc_fjid)){
				sql.append(" and attach_id = ?  ");
			}

			pdb.preparedSelect(sql.toString());
			int i = 1;
			if(!StringUtil.nullOrBlank(serverfilename)){
				pdb.setString(i++, serverfilename);
			}
			if(!StringUtil.nullOrBlank(extrainfo)){
				pdb.setString(i++, extrainfo);
			}
			if(!StringUtil.nullOrBlank(wc_fjid)){
				pdb.setString(i++, wc_fjid);
			}

			pdb.executePrepared();
			if(pdb.size() > 0){
				fileid = pdb.getString(0, "file_id");
			}
		}catch(Exception e){
			LOG.error("查当前文件的fileid报错："+e.getMessage());
		}
		return fileid;
	}

	/**
	 * 根据文件大小的long值，获取相应的文件大小，带（kb，mb，gb）单位
	 * @param filesize
	 * @return
	 */
	public String getFileSizeWithLong(long filesize){
		long kb = 1024;
		long mb = 1024*1024;
		long gb = 1024*1024*1024;
		
		String filedetailsize = "";
		if(filesize < kb){
			filedetailsize = "1KB";
		}else if((filesize < mb && filesize>=kb)){
			filedetailsize = getFileSizeWithTwoPoint(filesize,kb,"KB");
		}else if(filesize < gb && filesize >= mb){
			filedetailsize = getFileSizeWithTwoPoint(filesize,mb,"MB");

		}else if(filesize > gb){
			filedetailsize = getFileSizeWithTwoPoint(filesize,gb,"GB");
		}
		return filedetailsize;
	}
	
	public String getFileSizeWithTwoPoint(long filesize,long basesize,String danwei){
		String filedetailsize = "";
		float size = (float)filesize/basesize;
		 DecimalFormat df = new DecimalFormat("0.00");//格式化小数，不足的补0
		   filedetailsize = df.format(size)+danwei;//返回的是String类型的
		return filedetailsize;
	}

	
	
}
