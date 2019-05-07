package com.chinacreator.xtbg.core.archive.gwcs.bean;

import java.io.File;

import javax.jws.WebService;

import com.chinacreator.xtbg.core.common.cache.OASystemCache;

/**
 *<p>Title:公文常量</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 夏天
 *@version 1.0
 *@date 2013-8-6
 */
@WebService
public class GwConstant {
	public String root_path = OASystemCache.getContextProperty("root_path");//在oa.properties中配置
	public String oa_path = root_path + File.separator + "oa";
	public String tmp_xml_path = oa_path+ File.separator + "temp" + File.separator + "tmp.xml";//地址本要素
	public String tmp_zip_path = oa_path + File.separator + "temp" +File.separator+ "tmp.zip";//公文落地zip
	public String tmp_zip_dir = oa_path + File.separator+ "temp" +File.separator+ "zipdir" +File.separator;//落地公文解压路径
	public String tmp_zip_attch_path = root_path + File.separator + "oa"+ File.separator + "temp";
	
	public String archive_xml = "archive.xml";			//公文上传要素xml
	public String archive_path = oa_path+ File.separator + "temp" + File.separator + "archive" + File.separator + archive_xml;//公文上传文件目录
	public String archive_zip_path = oa_path + File.separator + "temp" + File.separator + "archive" + File.separator + "archive.zip";//公文上传文件目录
	
	public String gwcsword_ceb = "gwcsword.ceb";
	public String ceb_path = oa_path+ File.separator + "temp" + File.separator + "ceb" + File.separator + gwcsword_ceb;//ceb的临时文件存放路径
	

	public String ret_success = "0";//成功
	public String ret_failed = "1";//失败
	
	public String gwcs_web_url = "";//公文传输系统发布的webservice路径
	
	public String gwcs_org_operate_insert = "insert";//公文传输单个机构新增
	public String gwcs_org_operate_update = "update";//公文传输单个机构更新
	public String gwcs_org_operate_delete = "delete";//公文传输单个机构删除

	public String getRoot_path() {
		return root_path;
	}

	public void setRoot_path(String rootPath) {
		root_path = rootPath;
	}

	public String getOa_path() {
		return oa_path;
	}

	public void setOa_path(String oaPath) {
		oa_path = oaPath;
	}

	public String getTmp_xml_path() {
		return tmp_xml_path;
	}

	public void setTmp_xml_path(String tmpXmlPath) {
		tmp_xml_path = tmpXmlPath;
	}

	public String getTmp_zip_path() {
		return tmp_zip_path;
	}

	public void setTmp_zip_path(String tmpZipPath) {
		tmp_zip_path = tmpZipPath;
	}

	public String getTmp_zip_dir() {
		return tmp_zip_dir;
	}

	public void setTmp_zip_dir(String tmpZipDir) {
		tmp_zip_dir = tmpZipDir;
	}

	public String getArchive_xml() {
		return archive_xml;
	}

	public void setArchive_xml(String archiveXml) {
		archive_xml = archiveXml;
	}

	public String getArchive_path() {
		return archive_path;
	}

	public void setArchive_path(String archivePath) {
		archive_path = archivePath;
	}

	public String getArchive_zip_path() {
		return archive_zip_path;
	}

	public void setArchive_zip_path(String archiveZipPath) {
		archive_zip_path = archiveZipPath;
	}



	public String getRet_success() {
		return ret_success;
	}

	public void setRet_success(String retSuccess) {
		ret_success = retSuccess;
	}

	public String getRet_failed() {
		return ret_failed;
	}

	public void setRet_failed(String retFailed) {
		ret_failed = retFailed;
	}

	public String getGwcs_web_url() {
		return gwcs_web_url;
	}

	public void setGwcs_web_url(String gwcsWebUrl) {
		gwcs_web_url = gwcsWebUrl;
	}

	public String getGwcsword_ceb() {
		return gwcsword_ceb;
	}

	public void setGwcsword_ceb(String gwcswordCeb) {
		gwcsword_ceb = gwcswordCeb;
	}

	public String getCeb_path() {
		return ceb_path;
	}

	public void setCeb_path(String cebPath) {
		ceb_path = cebPath;
	}

	public void setGwcs_org_operate_insert(String gwcsOrgOperateInsert) {
		gwcs_org_operate_insert = gwcsOrgOperateInsert;
	}

	public void setGwcs_org_operate_update(String gwcsOrgOperateUpdate) {
		gwcs_org_operate_update = gwcsOrgOperateUpdate;
	}

	public void setGwcs_org_operate_delete(String gwcsOrgOperateDelete) {
		gwcs_org_operate_delete = gwcsOrgOperateDelete;
	}

	
	
}
