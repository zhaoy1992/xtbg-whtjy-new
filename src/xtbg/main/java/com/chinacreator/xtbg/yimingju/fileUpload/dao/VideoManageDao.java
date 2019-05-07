package com.chinacreator.xtbg.yimingju.fileUpload.dao;

import java.util.List;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.yimingju.fileUpload.entity.VideoInfoBean;
import com.chinacreator.xtbg.yimingju.fileUpload.entity.VideoListSearchBean;

public interface VideoManageDao {
	
	/**
	 * @Description 根据条件查询视频文件记录
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	public PagingBean findVideoFileList(VideoListSearchBean videoListSearchBean, String sortName, String sortOrder, long offset, int maxPagesize);

	
	/**
	 * 根据部门获取视频文件集合
	 * @param departid
	 * @return
	 * @throws Exception
	 */
	public List<VideoInfoBean> getVideoListByDepartId(String departid) throws Exception;
	
	
	/**
	 * 新增视频文件信息
	 * @param personFileInfoBean
	 * @throws Exception
	 */
	public String saveVideoFileInfo(VideoInfoBean videoInfoBean) throws Exception;
	
	/**
	 * 更新视频文件信息
	 * @param personFileInfoBean
	 * @throws Exception
	 */
	public void updateVideoFileInfo(VideoInfoBean videoInfoBean) throws Exception;
	
	/**
	 * 删除视频文件信息
	 * @param ids
	 * @throws Exception
	 */
	public void deleteVideoFileInfo(String ids) throws Exception;
	
	/**
	 * 查找视频文件信息
	 * @param fileid
	 * @return
	 * @throws Exception
	 */
	public VideoInfoBean findVideoFileInfo(String fileid) throws Exception;
	
	/**
	 * 查找视频文件播放路径
	 * @param fileid
	 * @return
	 * @throws Exception
	 */
	public VideoInfoBean findVideoFileViewUrl(String fileid) throws Exception;
	
	/**
	 * 删除指定路径的服务器文件
	 * @param path
	 * @return
	 * @throws Exception
	 */
	public boolean deleteServerFileWithPath(String path) throws Exception;
	
	/**
	 * 查当前文件的fileid
	 * @param userid
	 * @param serverfilename
	 * @param extrainfo
	 * @return
	 * @throws Exception
	 */
	public String isExsitFile(String serverfilename,String extrainfo,String wc_id) throws Exception;
	
	
}
