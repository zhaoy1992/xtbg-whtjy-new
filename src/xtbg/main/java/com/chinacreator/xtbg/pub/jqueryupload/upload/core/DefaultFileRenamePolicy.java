package com.chinacreator.xtbg.pub.jqueryupload.upload.core;

import java.io.File;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;

import com.oreilly.servlet.multipart.FileRenamePolicy;

public 	class DefaultFileRenamePolicy implements FileRenamePolicy,IFileRenamePolicy{
	
	private String fileSaveName;
	public File rename(File file) {
		String fileSaveName = StringUtils.join(new String[] { java.util.UUID.randomUUID().toString(), ".",
				FilenameUtils.getExtension(file.getName()) });
		setFileSaveName(fileSaveName);
		File result = new File(file.getParentFile(), fileSaveName);
		return result;
	}
	
	public String getFileSaveName() {
		return fileSaveName;
	}
	
	private void setFileSaveName(String fileSaveName) {
		this.fileSaveName = fileSaveName;
	}
	
	
	
}