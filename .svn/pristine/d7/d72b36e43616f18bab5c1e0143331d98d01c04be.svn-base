package com.chinacreator.xtbg.core.file.action;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.swing.ImageIcon;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.Constant;
import com.chinacreator.xtbg.core.common.commonlist.PageInfoBean;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.commonlist.PublicAjaxAction;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.dssave.service.DsCRUDService;
import com.chinacreator.xtbg.core.dssave.service.impl.DsCRUDServiceImpl;
import com.chinacreator.xtbg.core.file.dao.FileFilesDao;
import com.chinacreator.xtbg.core.file.dao.FileTypeDao;
import com.chinacreator.xtbg.core.file.dao.imploracle.FileTypeDaoImpl;
import com.chinacreator.xtbg.core.file.entity.FileDocBean;
import com.chinacreator.xtbg.core.file.entity.FileFilesBean;
import com.chinacreator.xtbg.core.file.entity.FileNoteBean;
import com.chinacreator.xtbg.core.file.entity.FileTypeBean;
import com.chinacreator.xtbg.core.file.service.FileFilesService;
import com.chinacreator.xtbg.core.file.service.impl.FileFilesServiceImpl;
import com.chinacreator.xtbg.core.file.util.FileConstant;

/**
 * 
 *<p>Title:FileFilesAction.java</p>
 *<p>Description:档案管理，前台请求的类</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-7-23
 */
public class FileFilesAction extends PublicAjaxAction {
	private static final Logger LOG = Logger.getLogger(FileFilesAction.class);
	private FileFilesBean search;// 用作查询的档案对象
	private FileFilesBean bean;// 用作更新保存的档案对象
	private FileDocBean docBean;// 用作保存的文件对象
	private FileNoteBean noteBean;// 备考表对象
	private String ids;// id列表
	private String ids_to;//调卷时使用的参数
	private String f_files_id;// 档案id
	private String f_files_id_to;//调卷时使用的参数(目标案卷的案卷id)
	private String docIds;// 文档id列表
	private String f_doc_id;// 文档id
	private String f_doc_num;// 文档件号
	private String f_type_id;// 类型id
    private String action ;//当前操作类型
    private String filenoFlag;//在批量更新时，是否重新生成档号1：重新生成，0：不重新生成
    private String realPath;//水印的文件路径
	/**
	 * 
	 * <b>Summary:批量修改档案 </b> updateListFiles()
	 */
	public void updateListFiles() {
		try {
			
			FileFilesService service = new FileFilesServiceImpl();
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("ids", ids);
			map.put("search", search);
			map.put("bean", bean);
			map.put("filenoFlag", filenoFlag);
			// 更新
			boolean flag = service.updateListFiles(map);
			if (flag) {
				write("{\"flag\":\"true\",\"msg\":\"操作成功\"}");
			} else {
				write("{\"flag\":\"false\",\"msg\":\"操作失败\"}");
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);

			write("{\"flag\":\"false\",\"msg\":\"操作失败\"}");

		}
	}

	/**
	 * 
	 * <b>Summary:文件入卷操作</b> updateListFiles()
	 */
	public void addDocToFiles() {
		try {
			FileFilesService service = new FileFilesServiceImpl();
			String userId = getRequest().getParameter("userId");
			String userName = getRequest().getParameter("userName");
			// 更新
			boolean flag = service.insertDocFiles(ids, f_files_id,userId,userName);
			if (flag) {
				write("{\"flag\":\"true\",\"msg\":\"操作成功\"}");
			} else {
				write("{\"flag\":\"false\",\"msg\":\"操作失败\"}");
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);

			write("{\"flag\":\"false\",\"msg\":\"操作失败\"}");

		}
	}

	/**
	 * 
	 *<b>Summary: 文件出卷操作</b> deleteDocFiles()
	 */
	public void deleteDocFiles() {
		try {
			FileFilesService service = new FileFilesServiceImpl();
			// 更新
			boolean flag = service.deleteDocFiles(ids, docIds);
			if (flag) {
				write("{\"flag\":\"true\",\"msg\":\"操作成功\"}");
			} else {
				write("{\"flag\":\"false\",\"msg\":\"操作失败\"}");
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);

			write("{\"flag\":\"false\",\"msg\":\"操作失败\"}");
		}
	}

	/**
	 * 
	 *<b>Summary:生成档号 ，更新时</b> createFileno()
	 */
	public void createFileno() {
		try {
			FileFilesService service = new FileFilesServiceImpl();
			String temp = service.createFileno(f_type_id, f_files_id);		 
			write(temp);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			write("{\"flag\":false,\"value\":\"\",\"msg\":\"操作失败\"}");
		}
	}
	
	/**
	 * 
	 *<b>Summary:生成档号,记录为保存时 </b> createFileno4Add()
	 */
	public void createFileno4Add() {
		try {
			FileFilesService service = new FileFilesServiceImpl();
			String temp = service.createFileno4Add(f_type_id, f_files_id);		 
			write(temp);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			write("{\"flag\":false,\"value\":\"\",\"msg\":\"操作失败\"}");
		}
	}

	/**
	 * 
	 *<b>Summary:批量修改文件 </b> updateListDoc()
	 */
	public void updateListDoc() {
		try {
			FileFilesService service = new FileFilesServiceImpl();
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("bean", docBean);
			map.put("ids", ids);
			map.put("fileId", f_files_id);
			//更新
			boolean flag = service.updateListDoc(map);

			if (flag) {
				write("{\"flag\":\"true\",\"msg\":\"操作成功\"}");
			} else {
				write("{\"flag\":\"false\",\"msg\":\"操作失败\"}");
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);

			write("{\"flag\":\"false\",\"msg\":\"操作失败\"}");

		}
	}

	/**
	 * 
	 *<b>Summary: 修改文件件号</b> updateDocNum()
	 */
	public void updateDocNum() {
		try {
			if (!StringUtil.nullOrBlank(f_doc_id)
					&& !StringUtil.nullOrBlank(f_doc_num)) {
				FileDocBean doc = new FileDocBean();
				doc.setF_doc_id(f_doc_id);
				doc.setF_doc_num(f_doc_num);
				FileFilesService service = new FileFilesServiceImpl();
				service.updateFileDoc(doc);
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
	}

	/**
	 * 
	 *<b>Summary:根据备考表模板生成数据 </b> queryNoteTemplement()
	 */
	public void queryNoteTemplement() {
		JSONObject json = new JSONObject();
		try {
			FileFilesService service = new FileFilesServiceImpl();

			String temp = service.queryNoteTemplement(f_type_id, f_files_id);

			write(temp);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			json.clear();
			json.put("flag", "false");
			json.put("value", "");
			json.put("msg", "操作失败");
			write(json.toString());

		}
	}

	/**
	 * 
	 *<b>Summary: 保存备考表信息</b> saveFileNote()
	 */
	public void saveFileNote() {
		try {
			FileFilesService service = new FileFilesServiceImpl();
			service.saveFileNoteBean(noteBean);
			write("{\"flag\":\"true\",\"msg\":\"操作成功\"}");
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			write("{\"flag\":\"false\",\"msg\":\"操作失败\"}");
		}
	}

	/**
	 * 
	 *<b>Summary: 查询档案列表</b> queryFilesList()
	 */
	public void queryFilesList() {
		PagingBean pb = new PagingBean();
		try {
			FileFilesService service = new FileFilesServiceImpl();
			pb = service.findFilesPageBean4acc(bean, getPage());
			// 将分页数据写入response
			write4PagingBeanJson(pb);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			write4PagingBeanJson(pb);
		}
	}
	/**
	 * 
	 *<b>Summary: 查询档案列表</b>
	 * queryFilesListForOrder(查询档案列表为排序)
	 */
	public void queryFilesListForOrder() {
		PagingBean pb = new PagingBean();
		try {
			FileFilesService service = new FileFilesServiceImpl();
			pb = service.findFilesPageBean4acc(bean, getPage());
			// 将分页数据写入response
			write4PagingBeanJson(pb);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			write4PagingBeanJson(pb);
		}
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * updateFilesListOrder(排序)
	 */
	public void updateFilesListOrder() {
		boolean flag = false;
		try {
			FileFilesService service = new FileFilesServiceImpl();
			flag = service.updateFilesListOrder(bean);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		if (flag) {
			write("{\"flag\":\"true\",\"msg\":\"操作成功\"}");
		} else {
			write("{\"flag\":\"false\",\"msg\":\"操作失败\"}");
		}
	}
	/**
	 * 
	 *<b>Summary: </b>
	 * updateFileListInFilesOrder(请用一句话描述这个方法的作用)
	 */
	public void updateFileListInFilesOrder() {
		boolean flag = false;
		try {
			FileFilesService service = new FileFilesServiceImpl();
			flag = service.updateFileListInFilesOrder(bean);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		if (flag) {
			write("{\"flag\":\"true\",\"msg\":\"操作成功\"}");
		} else {
			write("{\"flag\":\"false\",\"msg\":\"操作失败\"}");
		}
	}
	/**
	 * 
	 *<b>Summary:查询会计档案的列表 </b> queryFilesList4acc()
	 */
	public void queryFilesList4acc() {
		PagingBean pb = new PagingBean();
		try {

			PageInfoBean page = getPage();// 分页对象
			FileFilesDao dao = (FileFilesDao) LoadSpringContext
					.getApplicationContext().getBean("fileFilesDaoImpl");
			pb = dao.findFilesPageBean(bean, page.getSortName(), page
					.getSortOrder(), page.getOffset(), page.getRows());
			write4PagingBeanJson(pb);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			write4PagingBeanJson(pb);
		}
	}

	/**
	 * 
	 *<b>Summary:保存档案信息 </b> saveFileFiles()
	 */
	public void saveFileFiles() {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			DsCRUDService dsCRUDService = new DsCRUDServiceImpl();
			Boolean flag = false;
			if (Constant.ACTION_ADD.equals(action)) {
				flag = dsCRUDService.dsSave(getRequest(), conn);
				if(flag){
					FileTypeDao daoType = new FileTypeDaoImpl();
					daoType.updateLevelThreeType(getRequest().getParameter("OA_FILE_FILES__F_TYPE_ID"),conn);
				}
			} else if (Constant.ACTION_UPDATE.equals(action)) {
				flag = dsCRUDService.dsUpdate(getRequest(), conn);
			}
			/**
			 * 暂时屏蔽掉保存会计档案时顺便
			 */
			//是否会计类档案，如果是，则要插入数据到文件表，且保存关联关系
//			String isAccount = StringUtil.deNull(getRequest().getParameter("isAccount"));
//			if("Y".equals(isAccount)){
//				FileFilesService service = new FileFilesServiceImpl();
//				//插入或更新对应的文件信息
//				service.saveFileDocBean(getRequest());
//			}
			
			if (flag) {
				write("{\"flag\":\"true\",\"msg\":\"操作成功\"}");
			} else {
				write("{\"flag\":\"false\",\"msg\":\"操作失败\"}");
			}
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
			write("{\"flag\":\"false\",\"msg\":\"操作失败\"}");
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	 *<b>Summary:根据类型id查询 配置的列表页面信息</b> queryPageByTypeId()
	 */
	public void queryPageByTypeId() {
		JSONObject json = new JSONObject();
		json.put("flag", false);
		json.put("page", "");
		try {
			if(StringUtil.nullOrBlank(f_type_id)){
				super.write4Json(json);
			    return;
			}
			FileFilesService service = new FileFilesServiceImpl();
            Map<String,String> type = service.queryProgramByTypeId(f_type_id);
            if(null != type && !type.isEmpty()){
            	String page = type.get("f_files_list");
            	if(!StringUtil.nullOrBlank(page)){
            		json.put("flag", true);
    				json.put("page", page);    				
            	}
            }
            super.write4Json(json);
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
			super.write4Json(json);
		}
	}
	
	/**
	 * 
	*<b>Summary:调卷 </b>
	* fitFiles()
	 */
	public void fitFiles(){

		try {
			FileFilesService service = new FileFilesServiceImpl();
			String vids = StringUtil.deNull(ids);
			String vidsTo = StringUtil.deNull(ids_to);
			// 更新
			boolean flag = service.fitFiles(f_files_id, vids, f_files_id_to, vidsTo);
			if (flag) {
				write("{\"flag\":true,\"msg\":\"操作成功\"}");
			} else {
				write("{\"flag\":false,\"msg\":\"操作失败\"}");
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);

			write("{\"flag\":\"false\",\"msg\":\"操作失败\"}");

		}
	}

	/**
	 * 
	*<b>Summary: 删除案卷信息</b>
	* deleteFiles()
	 */
	public void deleteFiles(){

		try {
			FileFilesService service = new FileFilesServiceImpl();
			// 更新
			boolean flag = service.deleteListFileFiles(ids);
			if (flag) {
				write("{\"flag\":true,\"msg\":\"操作成功\"}");
			} else {
				write("{\"flag\":false,\"msg\":\"操作失败\"}");
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);

			write("{\"flag\":\"false\",\"msg\":\"操作失败\"}");

		}
	}
	
	/**
	 * 
	*<b>Summary: 获得档案的正文模板</b>
	* deleteFiles()
	 */
	public void getContentTemp(){
		JSONObject json = new JSONObject();		
		try {
			FileFilesService service = new FileFilesServiceImpl();
			// 更新
			FileTypeBean type = service.queryToFileType(f_type_id);
			String temp = "";			
			if(null != type){
				temp = type.getF_template_content();
			}
			if(StringUtil.nullOrBlank(temp)){
				json.put("flag", false);
				json.put("msg", "没有为该档案类型配置正文模板！");
			}else{
				json.put("flag", true);
				json.put("value",temp);
				json.put("msg", "操作成功！");
			}
			write4Json(json);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
            json.put("flag", false);
            json.put("msg", "操作失败!");
            write4Json(json);
		}
	}	
	
	/**
	 * 
	*<b>Summary:更新档案状态 为已归档</b>
	* updateFilesState()
	 */
	public void updateFilesState(){
		JSONObject json = new JSONObject();		
		try {
			FileFilesService service = new FileFilesServiceImpl();
			// 更新
			boolean flag = service.updateListFileState("1", "已归档", ids);
			if(!flag){
				json.put("flag", false);
				json.put("msg", "操作失败！");
			}else{
				json.put("flag", true);
				json.put("msg", "操作成功！");
			}
			write4Json(json);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
            json.put("flag", false);
            json.put("msg", "操作失败!");
            write4Json(json);
		}
	}
	/**
	 * 
	*<b>Summary: 复制档案</b>
	* copyFile()
	 */
	public void copyFile(){
		JSONObject json = new JSONObject();		
		try {
			FileFilesService service = new FileFilesServiceImpl();
			// 更新
			FileFilesBean newFile = service.copyFile(f_files_id);
			if(null == newFile){
				json.put("flag", false);
				json.put("msg", "操作失败！");
			}else{
				json.put("flag", true);
				json.put("msg", "操作成功,是否马上编辑复制的案卷！");
				json.put("bean", newFile);
			}
			write4Json(json);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
            json.put("flag", false);
            json.put("msg", "操作失败!");
            write4Json(json);
		}
	}
	/**
	 * 
	*<b>Summary:复制文件 </b>
	* copyDoc()
	 */
	public void copyDoc(){
		JSONObject json = new JSONObject();		
		try {
			FileFilesService service = new FileFilesServiceImpl();
			// 更新
			FileDocBean newFile = service.copyDoc(f_doc_id,f_files_id); 
			if(null == newFile){
				json.put("flag", false);
				json.put("msg", "操作失败！");
			}else{
				json.put("flag", true);
				json.put("msg", "操作成功,是否马上进行编辑！");
				json.put("bean", newFile);
			}
			write4Json(json);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
            json.put("flag", false);
            json.put("msg", "操作失败!");
            write4Json(json);
		}
	}
	/**
	 * 
	*<b>Summary:生成水印 </b>
	* createWatermark()
	 */
	public void createWatermark(){
		JSONObject json = new JSONObject();
		try {
			int width = 177;//参见background1.png像素
			int height = 63;
			String url = getRequest().getSession().getServletContext()
					.getRealPath("")
					+ FileConstant.WATERMARK_PATH;
			File file = new File(url + "watermark4doc.jpg");
			BufferedImage bi = new BufferedImage(width, height,
					BufferedImage.SCALE_REPLICATE);
			Graphics2D g2 = (Graphics2D) bi.getGraphics();
			g2.setBackground(Color.WHITE);
			g2.clearRect(0, 0, width, height);
			g2.setPaint(Color.WHITE);
			g2.setFont(new Font("新宋体", Font.BOLD, 14));
			g2.setColor(Color.RED);
			ImageIcon imgIcon = new ImageIcon(url+"background1.png");
			Image img= imgIcon.getImage();
		    g2.drawImage(img,0,0,null);
			g2.drawString(StringUtil.deNull(bean.getF_fondsno()), 7, 20);
			g2.drawString(StringUtil.deNull(docBean.getF_doc_year()), 72, 20);
			g2.drawString(StringUtil.deNull(docBean.getF_doc_num()), 125, 20);
			g2.drawString(StringUtil.deNull(docBean.getF_doc_deadline_name()), 74, 52);
			if(StringUtil.deNull(docBean.getF_dept_name()).length()>3){
				g2.setFont(new Font("新宋体", Font.BOLD, 12));
				g2.drawString(StringUtil.deNull(docBean.getF_dept_name()),5, 52);
			}else{
				g2.drawString(StringUtil.deNull(docBean.getF_dept_name()),7, 52);
			}
			
			
			ImageIO.write(bi, "jpg", file);
			json.put("flag", true);
			json.put("path", getRequest().getContextPath()
					+ FileConstant.WATERMARK_PATH + "watermark4doc.jpg");
			json.put("realPath", url+ "watermark4doc.jpg");
			write4Json(json);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			json.put("flag", false);
			write4Json(json);
		}
	}
	
	/**
	 * 
	*<b>Summary: 下载水印</b>
	* downLoadWatermark()
	* @param fileName
	* @param response
	* @throws IOException
	 */
	public void downLoadWatermark()  {
		// 封装成输出流
		OutputStream output = null;
		FileInputStream fis = null;
		try {
			getResponse().reset();
			getResponse().resetBuffer();
			getResponse().setContentType("application/octet-stream");
			getResponse().addHeader("Content-disposition", "attachment; filename=\""
					+ new String("水印.jpg".getBytes("GBK"), "ISO8859_1") + "\"");
			getResponse().setHeader("Pragma","No-cache"); 
			getResponse().setHeader("Cache-Control","no-cache"); 
			getResponse().setDateHeader("Expires", 0); 

			output = getResponse().getOutputStream();
			fis = new FileInputStream(this.realPath);

			byte[] b = new byte[1024];
			int i = 0;
			while ((i = fis.read(b)) > 0){
				output.write(b, 0, i);
			}
			
		}catch(Exception e){
			LOG.error(e.getMessage(),e);
		} finally {
			try {
				if (fis != null) {
					fis.close();
					fis = null;
				}
			} catch (Exception e) {
				LOG.error("FileInputStream关闭出错", e);
			}
			try {
				if (output != null) {
					output.flush();
					output.close();
					output = null;
				}
			} catch (Exception e) {
				LOG.error("OutputStream关闭出错", e);
			}
		}
	}	
	/**
	 * 
	*<b>Summary: 查询最大案卷号</b>
	* queryMaxFileNo()
	 */
	public void queryMaxFileNo(){
		JSONObject json = new JSONObject();		
		try {
			FileFilesService service = new FileFilesServiceImpl();
			Map<String, String> map = service.queryMaxFileNo(bean.getF_type_id(),bean.getF_org_id());
			String fileNo = map.get("f_filesno");
			if(!StringUtil.nullOrBlank(fileNo)){
				json.put("flag", true);
				json.put("f_filesno",fileNo);
			}else{
				json.put("flag", false);
				json.put("f_filesno","");
			}
		}catch(Exception e){
			LOG.error(e.getMessage(),e);
			json.put("flag", false);
			json.put("f_filesno","");
		}
		write4Json(json);
	}
	public FileFilesBean getSearch() {
		return search;
	}

	public void setSearch(FileFilesBean search) {
		this.search = search;
	}

	public FileFilesBean getBean() {
		return bean;
	}

	public void setBean(FileFilesBean bean) {
		this.bean = bean;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public String getF_files_id() {
		return f_files_id;
	}

	public void setF_files_id(String fFilesId) {
		f_files_id = fFilesId;
	}

	public String getDocIds() {
		return docIds;
	}

	public void setDocIds(String docIds) {
		this.docIds = docIds;
	}

	public FileDocBean getDocBean() {
		return docBean;
	}

	public void setDocBean(FileDocBean docBean) {
		this.docBean = docBean;
	}

	public String getF_doc_id() {
		return f_doc_id;
	}

	public void setF_doc_id(String fDocId) {
		f_doc_id = fDocId;
	}

	public String getF_doc_num() {
		return f_doc_num;
	}

	public void setF_doc_num(String fDocNum) {
		f_doc_num = fDocNum;
	}

	public String getF_type_id() {
		return f_type_id;
	}

	public void setF_type_id(String fTypeId) {
		f_type_id = fTypeId;
	}

	public FileNoteBean getNoteBean() {
		return noteBean;
	}

	public void setNoteBean(FileNoteBean noteBean) {
		this.noteBean = noteBean;
	}

	public String getAction() {
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}

	public String getIds_to() {
		return ids_to;
	}

	public void setIds_to(String idsTo) {
		ids_to = idsTo;
	}

	public String getF_files_id_to() {
		return f_files_id_to;
	}

	public void setF_files_id_to(String fFilesIdTo) {
		f_files_id_to = fFilesIdTo;
	}

	public String getFilenoFlag() {
		return filenoFlag;
	}

	public void setFilenoFlag(String filenoFlag) {
		this.filenoFlag = filenoFlag;
	}

	public String getRealPath() {
		return realPath;
	}

	public void setRealPath(String realPath) {
		this.realPath = realPath;
	}
}
