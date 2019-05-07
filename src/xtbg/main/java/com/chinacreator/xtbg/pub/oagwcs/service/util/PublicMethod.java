package com.chinacreator.xtbg.pub.oagwcs.service.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import org.dom4j.Element;

import com.chinacreator.xtbg.pub.oagwcs.dao.SendGwDao;
import com.chinacreator.xtbg.pub.oagwcs.dao.imploracle.YmjSendGwDaoImpl;
public class PublicMethod {
//	public final static String ROOT_PATH = "C:";//ConfigManager.getInstance()
//											//.getConfigValue("appFilePath");
//	public final static String TMP_XML_PATH = ROOT_PATH + "\\oa\\temp\\tmp.xml";//地址本要素
//	public final static String TMP_ZIP_PATH = ROOT_PATH + "\\oa\\temp\\tmp.zip";//公文落地zip
//	public final static String TMP_ZIP_DIR = ROOT_PATH + "\\oa\\temp\\zipdir\\";//落地公文解压路径
//	public final static String ARCHIVE_XML = "archive.xml";			//公文上传要素xml
//	public final static String ARCHIVE_PATH = ROOT_PATH + "\\oa\\temp\\archive\\";//公文上传文件目录
//	public final static String ARCHIVE_ZIP_PATH = ROOT_PATH + "\\oa\\temp\\archive\\archive.zip";//公文上传文件目录
//	
//	public final static String ARCHIVE_XML_ROOT = "archive";			//公文上传要素xml
//	public final static String ARCHIVE_XML_PARAMETERS = "archiveparameters";
//	public final static String ARCHIVE_XML_PARAMETERS_TITLE = "title";
//	public final static String RET_SUCCESS = "0";//成功
//	public final static String RET_FAILED = "1";//失败
	
	
	public String replaceNull(Object obj){
		return obj!=null?obj.toString().trim():"";
	}
	
	
	public static File getFileFromBytes(byte[] content, String filepath) throws Exception {
		FileOutputStream fos = null;
		File zipfile = new File(filepath);
		String dir = zipfile.getParent();
		File directory = new File(dir);
		try {
			if(!directory.exists()){
				directory.mkdirs();
			}
			fos = new FileOutputStream(zipfile);
			fos.write(content);
		} catch (IOException e) {
			System.out.println("ceb文件生成失败" + e.getMessage());
			throw new Exception("byteToFile" + e.getMessage());
		} finally {
			try {
				if (fos != null) { 
					fos.flush();
					fos.close();
					fos = null;
				}
			} catch (IOException e) {
				System.out.println("dispatchservice:byteToFile流关闭失败" + e.getMessage());
			}

		}
		return new File(filepath);
	}
	/**
	 * 删除文件或文件夹
	 * @param filePath 文件或文件夹绝对路径
	 */
	public static void deleteFile(String filePath){
		File file = new File(filePath);
		if(file.exists()){
			if(file.isFile()){
				file.delete();
			}else{
				File[] files = file.listFiles();
				for(File f : files){
					if(f!=null&&f.exists()){
						deleteFile(f.getAbsolutePath());
					}
				}
				file.delete();
			}
		}
	}
	
	/**
	 * 主送和抄送设置
	 * @param addresses
	 * @param type
	 * @return
	 */ 
	public void setSWDW(XmlBuilder xmlBuilder, String addresses,String type){
		String[] addressess = addresses.split(",");
		int i = 0;
		for(String address : addressess){
			String[] args = address.split(":");
			String id = "";
			String name = "";
			String printNum = "0";
			String number = "0";
			if(args.length==4){
				id = args[0];
				name = args[1];
				printNum = args[2];
				number = args[3];
			}else if(args.length==3){
				id = args[0];
				name = args[1];
				printNum = args[2];
			}else if(args.length==2){
				id = args[0];
				name = args[1];
			}else if(args.length==1){
				id = args[0];
			}else{
				id = address;
			}
			Element el=xmlBuilder.getElement("archive/receivedeptinfor").addElement("addrinfor");
			Element etmp = null;
			etmp = el.addElement("receiveraddr");
			etmp.setText(id);
			etmp = el.addElement("receivername");
			etmp.setText(name);
			etmp = el.addElement("print_num");
			etmp.setText(printNum);
			etmp = el.addElement("num");
			etmp.setText(number);
			etmp = el.addElement("send_type");
			etmp.setText(type);
			/*xmlBuilder.creatElement("archive/receivedeptinfor", "addrinfor", "");
			org.dom4j.Element element = xmlBuilder.getElement("archive/receivedeptinfor");
			List list = element.elements();
			int size = list.size();
			if (list!=null&&size>i) {
				org.dom4j.Element e = (org.dom4j.Element)list.get(i);
				Element etmp = e.addElement("receiveraddr");
				etmp.setText(id);
				etmp = e.addElement("receivername");
				etmp.setText(name);
				etmp = e.addElement("print_num");
				etmp.setText(printNum);
				etmp = e.addElement("num");
				etmp.setText(number);
				etmp = e.addElement("send_type");
				etmp.setText(type);
			}
			i++;*/
		}

	}
	public static void main(String[] args) {
		//File file = new File("C:\\oa\\temp\\tmp.zip");
		//file.delete();
		//PublicMethod publicMethod = new PublicMethod();
		//publicMethod.deleteFile("C:\\oa\\temp\\tmp.zip");
		
		
	}
}
