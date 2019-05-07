package com.chinacreator.xtbg.core.common.creatormaker.services.impl;

import java.io.File;
import java.util.UUID;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.util.FileCopyUtils;

import com.chinacreator.xtbg.core.common.cache.OASystemCache;
import com.chinacreator.xtbg.core.common.creatormaker.services.CreatorMakerService;
import com.chinacreator.xtbg.core.common.creatormaker.services.InvokWebservices;
import com.chinacreator.xtbg.core.common.creatormaker.support.MakerConstants;
import com.chinacreator.xtbg.core.common.creatormaker.util.ChangeToPDF;
import com.chinacreator.xtbg.core.common.creatormaker.util.FileUtil;
/**
 *<p>Title:CreatorMakerServiceImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-7-1
 */
public class CreatorMakerServiceImpl implements CreatorMakerService {
	
	private static final Log LOG = LogFactory.getLog(CreatorMakerServiceImpl.class);

	/**
	  * <b>Summary: </b>
	  *     复写方法 doc2Pdf
	  * @param content
	  * @return 
	  * @see com.chinacreator.xtbg.core.common.creatormaker.services.CreatorMakerService#doc2Pdf(byte[])
	 */
	@Override
	public byte[] doc2Pdf(byte[] content) {
		byte[] pdfContent = null;
		String transfer_type = OASystemCache.getContextProperty("pdf_maker_type");
		try {
			if(MakerConstants.LCOAL_MAKER.equals(transfer_type)){//本地调用
				pdfContent = localDoc2Pdf(content);
			}else if (MakerConstants.REMOTE_MAKER.equals(transfer_type)) {//远程调用
				//OASystemCacheBean oASystemCacheBean = OASystemCacheBean.getInstance();//配置参数
				Object[] objects = InvokWebservices.invokeCxfService(OASystemCache.getContextProperty("maker_wsdl"),
						OASystemCache.getContextProperty("maker_namespace"), OASystemCache.getContextProperty("maker_method"), content);
				pdfContent = (byte[])objects[0];
			}else{
				LOG.error("转换错误，请检查oa.properties 文件中配置的 pdf_maker_type 值");
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		return pdfContent;
	}
	
	/**
	*<b>Summary: </b>
	* localDoc2Pdf(本地转换)
	* @param content
	* @return
	* @throws Exception
	 */
	private byte[] localDoc2Pdf(byte[] content) throws Exception{
		String TEMP = OASystemCache.getContextProperty("temppath");//"c:/creator/temp/";//文件临时目录
		FileUtil.checkFolder(TEMP);
		String DOC_SUFFIX = ".doc";
		String PDF_SUFFIX = ".pdf";
		String uuid = UUID.randomUUID().toString();
		String docFilePath = TEMP+uuid+DOC_SUFFIX;
		String pdfFilePath = TEMP+uuid+PDF_SUFFIX;
		byte[] pdfFile = null;
		try{
			FileCopyUtils.copy(content, new File(docFilePath));//将doc生存到磁盘
			if(ChangeToPDF.convertWordToPDF(docFilePath, pdfFilePath) && FileUtil.checkFile(pdfFilePath)){//方式1  转换成功
				pdfFile = FileCopyUtils.copyToByteArray(new File(pdfFilePath));
			}else{
				throw new Exception(ChangeToPDF.getLastError());
			}
		}finally{
			//FileUtil.deleteFiles(docFilePath,pdfFilePath);
		}
		return pdfFile;
	}
	
	/*public static void main(String[] args) {
		byte[] pdfContent;
		try {
			pdfContent = (byte[]) InvokWebservices.invokeCxfService("http://172.16.17.78:801/maker/services/CreatorPDFMakerService?wsdl",
					"http://services.core.xtbg.chinacreator.com/", "doc2pdf", FileCopyUtils.copyToByteArray(new File("D:\\工作\\OA\\test.doc")))[0];
			FileCopyUtils.copy(pdfContent, new File("D:\\工作\\OA\\test1111.pdf"));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}*/
}
