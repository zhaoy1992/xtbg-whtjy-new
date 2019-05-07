package com.chinacreator.xtbg.pub.util;

import java.io.Serializable;

import sun.misc.BASE64Decoder;

public class Base64 implements Serializable {
	/**
	 * base64 encode arithmetic
	 * @param s
	 * @return
	 */
	public  String getEncodeBase64(String s){
		if (s == null) return null;
		  return (new sun.misc.BASE64Encoder()).encode( s.getBytes() );

	}
	/**
	 * base64 decode arithmetic
	 * @param s
	 * @return
	 */
	public  String getDecodeBase64(String s) {
		  if (s == null) return null;
		  BASE64Decoder decoder = new BASE64Decoder();
		  try {
		    byte[] b = decoder.decodeBuffer(s);
		    return new String(b);
		  } catch (Exception e) {
		    return null;
		  }
		} 
	
	public static void main(String[] args)
	{
		Base64 base64 = new Base64();
		String encode = base64.getEncodeBase64("123456");
		System.out.println(encode);
		System.out.print(base64.getDecodeBase64(encode));
	}


}
