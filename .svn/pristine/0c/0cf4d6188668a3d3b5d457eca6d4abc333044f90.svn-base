package com.chinacreator.xtbg.core.common.iweboffice;

import com.chinacreator.iWebOffice2006.iDBManager2000;
import com.chinacreator.xtbg.core.common.iweboffice.dao.impl.ManageIWebOfficeDataInDocumentFile;
import com.chinacreator.xtbg.core.common.iweboffice.dao.impl.ManageIWebOfficeDataInFcAttach;

public abstract class IWebOfficeDBManager {
	protected IWebOffice iWebOffice;
	protected iDBManager2000 DbaObj;
	
	public IWebOfficeDBManager(IWebOffice iWebOffice,iDBManager2000 DbaObj){
		this.iWebOffice = iWebOffice;
		this.DbaObj = DbaObj;
	}
	
	/**
	 * 
	 * @param db_type (oa_document_File:文档数据表(默认)，fc_attach:附件数据表)
	 * @param DbaObj iDBManager2000
	 * @return
	 */
	public static IWebOfficeDBManager getInstance(IWebOffice iWebOffice,iDBManager2000 DbaObj){
		if("document_file".equals(iWebOffice.getmDBType()))//文档数据表
			return new ManageIWebOfficeDataInDocumentFile(iWebOffice, DbaObj);
		if("fc_attach".equals(iWebOffice.getmDBType()))//附件数据表
			return new ManageIWebOfficeDataInFcAttach(iWebOffice, DbaObj);
		return new ManageIWebOfficeDataInDocumentFile(iWebOffice, DbaObj);
	}	
	

}
