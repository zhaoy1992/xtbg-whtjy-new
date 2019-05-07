package com.chinacreator.xtbg.core.common.filter;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.zip.GZIPOutputStream;
/**
 *<p>Title:GZipUtil.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2012-8-22
 */
public final class GZipUtil {
	
	/**
	*<b>Summary: </b>
	* gzip(进行gzip压缩)
	* @param data
	* @return
	*/
	public static byte[] gzip(byte[] data) {
		ByteArrayOutputStream byteOutput = new ByteArrayOutputStream(10240);
		GZIPOutputStream output = null;
		try {
			output = new GZIPOutputStream(byteOutput);
			output.write(data);
		} catch (IOException e) {
			throw new RuntimeException("G-Zip failed.", e);
		} finally {
			if (output != null) {
				try {
					output.close();
				} catch (IOException e) {
				}
			}
		}
		return byteOutput.toByteArray();
	}
}
