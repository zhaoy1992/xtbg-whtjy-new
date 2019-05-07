package com.chinacreator.xtbg.core.news.dao;

import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.util.ResultCode;
import com.chinacreator.xtbg.core.common.util.ResultMap;
import com.chinacreator.xtbg.core.news.entity.archiveBean;
import com.chinacreator.xtbg.core.news.entity.newsBean;

/**
 * 新闻信息
 * @author shaojun.wu
 *
 */
public interface newsDao {
	/**
	 * 新闻发布选取列表
	 * @param bean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean findNewsReleaseListPageBean(newsBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception;
	/**
	 * 插入发布信息
	 * @param bean
	 * @return
	 */
	public boolean insertNews(newsBean bean);
	/**
	 * 查询发布信息
	 * @param id
	 * @return
	 */
	public  Map<String, String> queryNews(String id);
	
	/**
	 * 新闻发布列表
	 * @param bean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean findNewsReleaseListPageBeanforIndex(newsBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception;
	/**
	 * 新闻统计列表
	 * @param bean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean findNewsCountListPageBean(newsBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception;
	public ResultMap<ResultCode,archiveBean> getLook(String ins_id);
	public boolean deleteNews(String id);
	public String queryNewsCount(newsBean bean);
}
