package com.chinacreator.xtbg.pub.common;

import java.io.IOException;

import com.chinacreator.xtbg.pub.util.FileUtil;
public class IeInstallation {
	
	public void execFlv(String path) {
		 try {

			 Runtime rt = Runtime.getRuntime();
			 Process proc = rt.exec(FileUtil.getClassPath(IeInstallation.class) + "\\soft\\IE8-Setup-Ylmf.exe");
		 } catch (IOException e) {
			 e.printStackTrace();
		 }
	}
	
}
