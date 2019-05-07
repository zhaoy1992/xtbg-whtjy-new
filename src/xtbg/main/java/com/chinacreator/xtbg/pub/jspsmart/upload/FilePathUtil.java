package com.chinacreator.xtbg.pub.jspsmart.upload;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.jsp.PageContext;

public class FilePathUtil {
	
	protected ServletContext m_application; 
	
	private boolean m_denyPhysicalPath; 
	
	public final void initialize(PageContext pageContext)throws ServletException
	{ 
		m_application = pageContext.getServletContext();
	}
	public String getPhysicalPath(String filePathName, int option)throws IOException 
	{ 
		String path = new String(); 
		String fileName = new String(); 
		String fileSeparator = new String(); 
		boolean isPhysical = false; 
		fileSeparator=System.getProperty("file.separator"); 
		if(filePathName == null) 
			throw new IllegalArgumentException("There is no specified destination file (1140)."); 
		if(filePathName.equals("")) 
			throw new IllegalArgumentException("There is no specified destination file (1140)."); 
		if(filePathName.lastIndexOf("\\") >= 0) { 
			path = filePathName.substring(0, filePathName.lastIndexOf("\\")); 
			fileName = filePathName.substring(filePathName.lastIndexOf("\\") + 1); 
		} 
		if(filePathName.lastIndexOf("/") >= 0) 
		{ 
			path = filePathName.substring(0, filePathName.lastIndexOf("/")); 
			fileName = filePathName.substring(filePathName.lastIndexOf("/") + 1); 
		} 
		
		path = path.length() != 0 ? path : "/"; 
		java.io.File physicalPath = new java.io.File(path); 
		if(physicalPath.exists()) 
			isPhysical = true; 
		if(option == 0) 
		{ 
			if(isVirtual(path)) 
			{ 
				path = m_application.getRealPath(path); 
				if(path.endsWith(fileSeparator)) 
					path = path + fileName; 
				else 
					path = String.valueOf((new StringBuffer(String.valueOf(path))).append(fileSeparator).append(fileName)); 
				return path; 
			} 
			if(isPhysical) 
			{ 
				if(m_denyPhysicalPath) 
					throw new IllegalArgumentException("Physical path is denied (1125)."); 
				else 
					return filePathName; 
			} else 
			{ 
				throw new IllegalArgumentException("This path does not exist (1135)."); 
			} 
		} 
		
		if(option == 1) 
		{ 
			if(isVirtual(path)) 
			{ 
				path = m_application.getRealPath(path); 
				if(path.endsWith(fileSeparator)) 
					path = path + fileName; 
				else 
					path = String.valueOf((new StringBuffer(String.valueOf(path))).append(fileSeparator).append(fileName)); 
				if(isPhysical)
					throw new IllegalArgumentException("The path is not a virtual path."); 
				else 
					throw new IllegalArgumentException("This path does not exist (1135)."); 
			} 
			if(option == 2) 
			{ 
				if(isPhysical) 
					if(m_denyPhysicalPath) 
						throw new IllegalArgumentException("Physical path is denied (1125)."); 
					else 
						return filePathName; 
				if(isVirtual(path)) 
					throw new IllegalArgumentException("The path is not a physical path."); 
				else 
					throw new IllegalArgumentException("This path does not exist (1135)."); 
			}  
			else 
			{ 
				return null; 
			}
		}
		return path;
	} 
	
	private boolean isVirtual(String pathName) //判断是否是虚拟路径 
	{ 
		if(m_application.getRealPath(pathName) != null) 
		{ 
			java.io.File virtualFile = new java.io.File(m_application.getRealPath(pathName)); 
			return virtualFile.exists(); 
		}  
		else 
		{ 
			return false; 
		} 
	} 
}
