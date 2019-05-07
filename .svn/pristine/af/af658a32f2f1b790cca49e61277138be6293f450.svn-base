package com.chinacreator.xtbg.pub.jqueryupload.filebuess.list;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.pub.jqueryupload.filebuess.entity.FileInfoBean;
import com.chinacreator.xtbg.pub.jqueryupload.utils.FileUtils;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;
import com.frameworkset.common.tag.pager.DataInfoImpl;
import com.frameworkset.util.ListInfo;


	/**
	 *<p>Title:FileListInfo.java</p>
	 *<p>Description:文件信息查询列表</p>
	 *<p>Copyright:Copyright (c) 2010</p>
	 *<p>Company:湖南科创</p>
	 *@author steven.zhu
	 *@version 1.0
	 * 2011-07-06
	 */
	public class FileListInfo extends DataInfoImpl{
		private static final long serialVersionUID = 1L;
		
		private static final Logger LOG = Logger.getLogger(FileListInfo.class);

		@Override
		protected ListInfo getDataList(String sortKey, boolean desc) {

			ListInfo listInfo = new ListInfo();
			String buessid = request.getParameter("buessid").trim();
			String isPre = StringUtil.deNull(request.getParameter("isPre")).trim();
			String sql = "";

			sql = "select attachid,filename,extend,filepos,djsn from fc_attach where djbh='"+buessid+"'";
	
			PreparedDBUtil pdb = new PreparedDBUtil();
			List<FileInfoBean> list = new ArrayList<FileInfoBean>();
			String filepos="";
			String careate="";
			String extedn="";
			try {
					pdb.preparedSelect(sql);
					pdb.executePrepared();
					for (int i = 0; i < pdb.size(); i++) {
						FileInfoBean bean = new FileInfoBean();
						bean.setAttachid(pdb.getString(i, "attachid"));
						bean.setFilename(pdb.getString(i, "filename"));
						extedn=pdb.getString(i, "extend");
						bean.setExtend(extedn);
						filepos=pdb.getString(i, "filepos");
						bean.setFilepos(filepos);
						bean.setDjsn(pdb.getString(i, "djsn"));
						
						if (!filepos.equals("")){
							 careate="";
							int j=0,k=0;
						    j= filepos.lastIndexOf(".");
						    k= filepos.lastIndexOf("_");
						if (j!= -1 && k!= -1) {
							careate=filepos.substring(k+1,j);
							bean.setCreate_date(FileUtils.stringToString(careate));
						}
						bean.setNewName(careate+extedn);
					  }
						list.add(bean);
					}
				
				listInfo.setDatas(list);
				listInfo.setTotalSize((long)list.size());
			} catch (SQLException e) {
				LOG.error("获取用户列表异常"+e);
			}
			return listInfo;
		
		}

		@Override
		protected ListInfo getDataList(String sortKey, boolean desc, long offset,
				int maxPageSize) {
			return null;
		}

	}


