package com.chinacreator.xtbg.pub.jqueryupload.filebuess.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import com.chinacreator.business.common.tools.CacheCommonManage;
import com.chinacreator.xtbg.pub.jqueryupload.filebuess.dao.impl.FiletransfersSysDaoImpl;
import com.chinacreator.xtbg.pub.jqueryupload.filebuess.entity.FileInfoBean;
import com.chinacreator.xtbg.pub.jqueryupload.filebuess.service.FiletransferService;
import com.frameworkset.common.poolman.PreparedDBUtil;




public class FiletransferServiceImpl extends FiletransferService {

	public final static String upload_To_SeverPath = CacheCommonManage.getInstance().getSystemParam("upload_To_SeverPath");  
	public final static String upload_To_SeverPath_czt = CacheCommonManage.getInstance().getSystemParam("upload_To_SeverPath_czt");  
	public final static String upload_To_Zip_Path = CacheCommonManage.getInstance().getSystemParam("upload_To_Zip_Path");  
	public boolean saveFile(List<FileInfoBean> listFileInfoBean) {
		boolean  rs=false;
		try
		{
			FiletransfersSysDaoImpl sft=new FiletransfersSysDaoImpl();
			return sft.saveFile(null, listFileInfoBean);
		}
		catch(Exception e)
		{
			rs=false;
			//FIXME tian.xia
		}
			return rs;
  }
	public String[] copyDBFileToServerByDjBh(String FilePath,String djbh){
		String[] paths = {};

		FileOutputStream fopStream = null;
		InputStream iStream = null;
		StringBuffer sql = new StringBuffer();
		sql.append("select * from fc_attach f where trim(f.djbh) = ?");
		PreparedDBUtil pdb = new PreparedDBUtil();
		
		try
		{
			pdb.preparedSelect(sql.toString());
			pdb.setString(1, djbh);
			pdb.executePrepared();
			String filePath = "";
			for(int i = 0 ; i < pdb.size() ; i++){
				filePath = FilePath+pdb.getString(i, "djsn")+pdb.getString(i,"extend");
				fopStream = new FileOutputStream(new File(filePath));
				iStream = pdb.getBlob(i, "attachcontent").getBinaryStream();
				byte[] b = new byte[1024];
				int j = 0;
				while ((j = iStream.read(b)) > 0) {
					fopStream.write(b, 0, j);
				}
				fopStream.flush();
			}

			paths[paths.length] = filePath;
		}catch(Exception e){
			//FIXME tian.xia
		} finally {
	
			if(iStream != null) {
				try {
					iStream.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				iStream = null;
			}
			if (fopStream != null) {
				try {
					fopStream.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				fopStream = null;
			}
		}
		return paths;
		
	}

	
	public String[] uploadFileToServer(String FilePath,List<FileInfoBean> listFileInfoBean) {
		String[] paths = new String[listFileInfoBean.size()];
		FileOutputStream fopStream = null;
		InputStream iStream = null;
		try
		{
			String filePath = ""; 
			int index = 0;
			for(FileInfoBean fib:listFileInfoBean){
				filePath = FilePath+fib.getDjsn()+fib.getExtend();
				fopStream = new FileOutputStream(new File(filePath));
				paths[index] = filePath.trim();
				index++;
				iStream = fib.getFileInput();
				byte[] b = new byte[1024];
				int i = 0;
				while ((i = iStream.read(b)) > 0) {
					fopStream.write(b, 0, i);
				}
				fopStream.flush();
			}
			
		}
		catch(Exception e)
		{
			//FIXME tian.xia
		} finally {

			if(iStream != null) {
				try {
					iStream.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				iStream = null;
			}
			if (fopStream != null) {
				try {
					fopStream.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				fopStream = null;
			}
		}
		return paths;
	}
	
	
}
