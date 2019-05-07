package com.chinacreator.xtbg.core.common.iweboffice.util;

import java.io.File;
import java.io.FilenameFilter;
import java.util.ArrayList;

import com.goldgrid.pdfmake.KGPDFMake;
/**
 * @author 金格网络科技
 * WORD文档转PDF类
 */
public class ChangeToPDF extends Thread implements FilenameFilter{
	public static String SavePDFPath = "D:\\uploadDocument";     // PDF 文档服务器上保存的路径 默认
	public static int ChangeType = 1;      // 转换方法的类型 1:Office2007 2:Office2007+ADOBE PDF 虚拟打印机
	public static String ErrMessage = "";  // 最后产生的错误
	public static ArrayList m_list = new ArrayList(); // 存储未转换的文件名
	public static boolean isWork = false;             // 线程互斥量
	
	/*加载提供文档转换的动态链接库，调用JNI接口是一点要加载此DLL链接库*/
	static{
		try{
			System.loadLibrary("KG_PDFMake_JNI");
		}catch(Exception ex)
		{
			ex.printStackTrace();
		}
	}
	
	/**
	 * @param   m_Str WORD 文档路径名
	 * @return  返回WORD文档的名字(除去后缀名.doc或者.docx)
	 */
	public String getWordFileName(String m_Str)
	{
		if(m_Str==null)
			return "";
		else{
			File m_File = new File(m_Str);
			if(!m_File.exists())
				return "";
			else{
				String path = SavePDFPath+"\\";
				int mark1 = m_File.getName().toLowerCase().lastIndexOf(".doc");
				int mark2 = m_File.getName().toLowerCase().lastIndexOf(".docx");
				if(mark1!=-1)
					path = path+m_File.getName().substring(0,mark1);
				else
					path = path+m_File.getName().substring(0,mark2);
				return path;
			}
		}
	}
	
	/*启动线程进行文档转换*/
	public void run()
	{
		String m_FileName = "";
		if(m_list.size()!=0)
		{
			for(int i=0;i<m_list.size();i++)
			{
				m_FileName =m_FileName+(String)m_list.get(i)+";";   // 获取待转换的文档名字，以便转换之后从List中删除
				isWork = true;
				if(ChangeType==1)
				{
					/*进行方式一转换直接利用Office2007*/
					ConvertWordToPDF((String)m_list.get(i),getWordFileName((String)m_list.get(i))+".pdf");
				}else{
					/*进行方式一转换直接利用Office2007+Adobe PDF*/
					ConvertWordToPDFEx((String)m_list.get(i),getWordFileName((String)m_list.get(i))+".ps",getWordFileName((String)m_list.get(i))+".pdf");
				}
			}
			
			/*删除已经转换后的文档*/
			String deleteFileName[] = m_FileName.split(";");
			for(int i=0;i<deleteFileName.length;i++)
			{
				m_list.remove((String)deleteFileName[i]);		//循环删除删除的文档
			}
			isWork = false;
		}
	}
	
	/*判断是否可以启动线程进行转换*/
	public  void startWork()
	{
		// isWork 信号量 如果为TRUE 表示已经启动了转换文档线程此时便不能再启动线程
		if(isWork)
		{
			return ;
		}else{
			this.start(); // 启动线程进行文档转换
		}
	}
	
	/**
	 * 注意:此方法必须是线程同步的,否则可能引起JNI调用失败
	 * 调用方案一的转换
	 * @param  srcPath  WORD 文档在服务器上的保存路径
	 * @param  pdfPath  转换后PDF文件保存的路径
	 * @return TRUE:成功 FALSE:失败
	 */
	public static synchronized boolean ConvertWordToPDF(String srcPath,String pdfPath)
	{
		boolean mark = false;
		System.out.println("pdf转换路径：：："+srcPath+"!!!!!!"+pdfPath);
		if(!new File(srcPath).exists())  // 判断待转换的文件是否存在
		{
			ErrMessage = srcPath+":文件不存在";
			return false;
		}
		try{
			// 调用JNI接口进行文档转换
			if(KGPDFMake.WordToPDF(srcPath, pdfPath))
			{
				KGPDFMake.WordToPDFEx("", "", "");
				mark = true; // 文档转换成功  
				ErrMessage = "";
			}else{
				mark = false;
				ErrMessage = KGPDFMake.GetLastError(); //获取转换文档过程中最后产生的错误 如果没有错误则返回空
				System.out.println(ErrMessage);
			}
		}catch(Exception ex)
		{
			ex.printStackTrace();
			ErrMessage = ex.getMessage();
		}finally{
			KGPDFMake.FreeDll();  // 释放动态链接库的资源 转换之后必须调用 否则引起内存泄露
		}
		return mark;
	}
	
	/**
	 * 注意:此方法必须是线程同步的,否则可能引起JNI调用失败
	 * 调用方案二的转换
	 * @param srcPath WORD 文档在服务器上的保存路径
	 * @param psPath  转换过程中产生的PS文件保存的路径
	 * @param pdfPath 转换后PDF文件保存的路径
	 * @return TRUE:成功 FALSE:失败
	 */
	public static synchronized boolean ConvertWordToPDFEx(String srcPath,String psPath,String pdfPath)
	{
		boolean mark = false;
		if(!new File(srcPath).exists()) //判断待转换的文件是否存在
		{
			ErrMessage = srcPath+":文件不存在";
			return false;
		}
		try{
			// 调用JNI接口进行文档转换
			if(KGPDFMake.WordToPDFEx(srcPath, psPath, pdfPath))
			{
				mark = true; // 文档转换成功  
				ErrMessage = "";
			}else{
				mark = false;
				ErrMessage = KGPDFMake.GetLastError(); //获取转换文档过程中最后产生的错误 如果没有错误则返回空
				System.out.println(ErrMessage);
			}
		}catch(Exception ex)
		{
			ex.printStackTrace();
			ErrMessage = ex.getMessage();
		}finally{
			KGPDFMake.FreeDll();  // 释放动态链接库的资源 转换之后必须调用 否则引起内存泄露
		}
		return mark;
	}
	
	/*获取最后产生的错误*/
	public String GetLastError()
	{
		return ErrMessage;
	}
	
	/**
	 * @param  PDFFilePath PDF文件保存路径
	 * @return 获取指定目录下转换后的PDF文件名字
	 */
	public ArrayList getFileInformationList(String PDFFilePath)
	{
		ArrayList m_list = new ArrayList();
		File m_File = new File(PDFFilePath);
		if(!m_File.exists())
			return null;
		else{
			
			File m_Files[] = m_File.listFiles(this);
			for(int i=0;i<m_Files.length;i++)
			{
				m_list.add((String)m_Files[i].getName());
			}
		}
		return m_list;
	}

	/*文件过滤只显示PDF文件 由于采用方式二转换会生成ps文件和一个log文件*/
	public boolean accept(File arg0, String fileName) {
		// TODO Auto-generated method stub
		fileName = fileName.toLowerCase();
		if(fileName.endsWith(".pdf"))
			return true;
		else
			return false;
	}
}
