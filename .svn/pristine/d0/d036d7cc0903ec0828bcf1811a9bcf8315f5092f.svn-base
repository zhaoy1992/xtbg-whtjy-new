package com.chinacreator.xtbg.core.image;

import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;

import javax.imageio.ImageIO;
import javax.media.jai.JAI;
import javax.media.jai.RenderedOp;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;
import com.sun.media.jai.codec.ImageCodec;
import com.sun.media.jai.codec.ImageEncoder;
import com.sun.media.jai.codec.TIFFEncodeParam;

/**
 *<p>Title:ImageUtil.java</p>
 *<p>Description:图片工具</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013年9月11日
 */
public class ImageUtil {
	
	/**
	 *<b>Summary:jpg图片转成tif文件 </b>
	 * jpg2tif()
	 * @param srcFile
	 * @param descFile
	 * @throws Exception
	 */
	public void jpg2tif(String srcFile, String descFile) throws Exception {
		InputStream istream = new FileInputStream(srcFile);
		
		RenderedOp src = JAI.create("fileload", istream);
		OutputStream os = new FileOutputStream(descFile);
		TIFFEncodeParam param = new TIFFEncodeParam();
		ImageEncoder encoder = ImageCodec.createImageEncoder("TIFF", os, param);
		encoder.encode(src);
		os.close();
	}
	
	/**
	 *<b>Summary: 添加水印</b>
	 * addwater()
	 * @param srcFile 源文件
	 * @param waterFile 水印文件
	 * @param descFile 保存文件
	 * @throws Exception
	 */
	public void addwater(String srcFile,String waterFile,String descFile) throws Exception {
	    //get source image
	    Image img = ImageIO.read(new File(srcFile));
	    int width = img.getWidth(null);
	    int height = img.getHeight(null);
	    //create target image
	    BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
	    //get a graphics pen
	    Graphics g = image.createGraphics();
	    //draw source image
	    g.drawImage(img, 0, 0, width, height, null);
	    //draw target logo
	    Image logo = ImageIO.read(new File(waterFile));
	    //int lw = logo.getWidth(null);
	    //int lh = logo.getHeight(null);
	    g.drawImage(logo, width/2, 10, 200, 160, null);
	    //如果不想加图片水印，而是文字，则是这里的代码
//	    String str = "http://www.hongliang.net";
//	    g.setColor(Color.BLUE);
//	    g.setFont(new Font("Courier", Font.PLAIN, 36));
	    //这里的文字位置要研究一番，容易对不准
//	    g.drawString(str, width-360, height-72);
	    g.dispose();
	    FileOutputStream os = new FileOutputStream(descFile);
	    JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(os);
	    encoder.encode(image);
	  }
	
	public static void main(String[] args) {
		ImageUtil util = new ImageUtil();
		try {
			//util.addwater("D:\\test\\test2.tif", "D:\\test\\ti.jpg", "D:\\test\\test2.jpg");
			util.jpg2tif("D:\\test\\test2.jpg", "D:\\test\\test2.tif");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
