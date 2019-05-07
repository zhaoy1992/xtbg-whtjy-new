package com.chinacreator.xtbg.core.xmltest;

import java.io.BufferedOutputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;

import com.chinacreator.xtbg.core.archive.gwcs.bean.ReceiveGwcsXmlBean;
import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;
import com.thoughtworks.xstream.io.xml.StaxDriver;
import com.thoughtworks.xstream.io.xml.XmlFriendlyNameCoder;

public class XstreamTest {

	/**
	 * 文件转化为字节数组
	 * 
	 * @param file
	 * @return
	 */
	public static byte[] getBytesFromFile(File file) {
		byte[] ret = null;
		try {
			if (file == null) {
				// log.error("helper:the file is null!");
				return null;
			}
			FileInputStream in = new FileInputStream(file);
			ByteArrayOutputStream out = new ByteArrayOutputStream(4096);
			byte[] b = new byte[4096];
			int n;
			while ((n = in.read(b)) != -1) {
				out.write(b, 0, n);
			}
			in.close();
			out.close();
			ret = out.toByteArray();
		} catch (IOException e) {
			// log.error("helper:get bytes from file process error!");
			e.printStackTrace();
		}
		return ret;
	}
	
	/**
	 * 把字节数组保存为一个文件
	 * 
	 * @param b
	 * @param outputFile
	 * @return
	 */
	public static File getFileFromBytes(byte[] b, String outputFile) {
		File ret = null;
		BufferedOutputStream stream = null;
		try {
			ret = new File(outputFile);
			FileOutputStream fstream = new FileOutputStream(ret);
			stream = new BufferedOutputStream(fstream);
			stream.write(b);
		} catch (Exception e) {
			// log.error("helper:get file from byte process error!");
			e.printStackTrace();
		} finally {
			if (stream != null) {
				try {
					stream.close();
				} catch (IOException e) {
					// log.error("helper:get file from byte process error!");
					e.printStackTrace();
				}
			}
		}
		return ret;
	}
	
	/**
	 *<b>Summary: </b>
	 * main(请用一句话描述这个方法的作用)
	 * @param args 
	 */
	@SuppressWarnings("unchecked")
	public static void main(String[] args) {
		String path = "C:\\oa\\temp\\zipdir2\\aa.xml";
		
		File xmlFile = new File(path);
		byte[] filebytes = getBytesFromFile(xmlFile);

		File file = getFileFromBytes(filebytes,path);

		// TODO Auto-generated method stub
		XStream xstream = new XStream(new DomDriver("UTF-8"));
		xstream.alias("receive", ReceiveGwcsXmlBean.class);
		xstream.alias("num", ReceiveGwcsXmlBean.Num.class);
		xstream.alias("affixname", String.class);
		
		XStream xstream2 =  new XStream(new DomDriver("UTF-8",new XmlFriendlyNameCoder("-_", "_")));
		xstream2.alias("receive", ReceiveGwcsXmlBean.class);
		xstream2.alias("num", ReceiveGwcsXmlBean.Num.class);
		xstream2.alias("affixname", String.class);
		 try {
			 ReceiveGwcsXmlBean receiveGwcsXmlBean = (ReceiveGwcsXmlBean) xstream.fromXML(new FileInputStream(path));
			 OutputStream outputStream = new FileOutputStream("C:\\oa\\temp\\zipdir2\\a1.xml");;
			 xstream2.toXML(receiveGwcsXmlBean, outputStream);
			 System.out.println(receiveGwcsXmlBean.getNum().getSerial_number());
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
