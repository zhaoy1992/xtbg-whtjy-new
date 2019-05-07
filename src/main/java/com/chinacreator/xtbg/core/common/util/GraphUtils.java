package com.chinacreator.xtbg.core.common.util;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.util.ArrayList;
import java.util.UUID;

import javax.swing.JTextPane;
import javax.swing.border.EmptyBorder;
import javax.swing.plaf.basic.BasicEditorPaneUI;

import org.apache.commons.io.FileUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

//import com.cxsoft.rap.ed.util.ManualUtil;
import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGEncodeParam;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

/**
 *<p>Title:GraphUtils.java</p>
 *<p>Description: html字符串转jgp图片工具类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 何世星
 *@version 1.0
 *2014-2-7
 */
public class GraphUtils {

	private final static Log log = LogFactory.getLog(GraphUtils.class);

	public static int DEFAULT_IMAGE_WIDTH = 2024;

	//默认值最好设置大点，因为我们再导之前，不知道这个流有多大，如果过小，则生成的图片后面的为黑色，因为流没有读取完整
	public static int DEFAULT_IMAGE_HEIGHT = 2000;

	/**
	 *<b>Summary: </b>
	 * toJpeg(将BufferedImage转换为图片的信息)
	 * @param BufferedImage image
	 * @param String imgAllPathName 服务器图片路径+图片名称+图片后缀
	 * @param year
	 * @return 
	 */
	public static String toJpeg(BufferedImage image, String imgAllPathName) {
		// 获取图片文件的在服务器的路径
		// String imgPath = ManualUtil.getImgPath(nsrlsh, year);
		// String imageName = imgPath+UUID.randomUUID().toString() + ".jpg";
		//String imageName = "E:\\" + UUID.randomUUID().toString() + ".jpg";
		String imageName = imgAllPathName;
		log.error("图片文件:" + imageName);
		try {
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(baos);
			JPEGEncodeParam param = encoder.getDefaultJPEGEncodeParam(image);
			param.setQuality(1.0f, false);
			encoder.setJPEGEncodeParam(param);
			encoder.encode(image);
			byte[] buff = baos.toByteArray();
			baos.close();
			// 将字节流写入文件保存为图片
			FileUtils.writeByteArrayToFile(new File(imageName), buff);
			log.error("图片保存成功!....");
		} catch (Exception ex) {
			log.error("保存删除图片失败:" + ex.getMessage(), ex);
		}
		return imageName;
	}

	/**
	 *<b>Summary: </b>
	 * html2jpeg(html转换为jpeg文件)
	 * @param bgColor 图片的背景色
	 * @param html html的文本信息
	 * @param width 显示图片的Ｔｅｘｔ容器的宽度
	 * @param height 显示图片的Ｔｅｘｔ容器的高度
	 * @param eb 設置容器的边框
	 * @param imgAllPathName 服务器图片路径+图片名称+图片后缀
	 * @return
	 * @throws Exception 
	 */
	private static ArrayList<String> html2jpeg(Color bgColor, String html,
			int width, int height, EmptyBorder eb, String imgAllPathName)
			throws Exception {
		ArrayList<String> ret = new ArrayList<String>();
		try {
			JTextPane tp = new JTextPane();
			tp.setSize(width, height);
			if (eb == null) {
				eb = new EmptyBorder(0, 50, 0, 50);
			}
			if (bgColor != null) {
				tp.setBackground(bgColor);
			}
			if (width <= 0) {
				width = DEFAULT_IMAGE_WIDTH;
			}
			if (height <= 0) {
				height = DEFAULT_IMAGE_HEIGHT;
			}
			tp.setBorder(eb);
			tp.setContentType("text/html");
			tp.setText(html);
			Dimension d = ((BasicEditorPaneUI) tp.getUI()).getPreferredSize(tp);
			// 此处是将一个页面生成一张图片，如果要人为控制图片大小进行分页生成，则再自行进行高度设置，但是分页之后可能出现的情况就是分页的时候字体被截断的可能，因为在截断的之后，他不知道流是否刚好将一行字显示完成
			if (d.height > DEFAULT_IMAGE_HEIGHT) {
				height = d.height;
			}
			PrintView m_printView = new PrintView(tp);
			int pageIndex = 1;
			boolean bcontinue = true;
			while (bcontinue) {
				BufferedImage image = new java.awt.image.BufferedImage(width,
						height, java.awt.image.BufferedImage.TYPE_INT_RGB);
				Graphics g = image.getGraphics();
				g.setClip(0, 0, width, height);
				bcontinue = m_printView.paintPage(g, height, pageIndex);
				g.dispose();
				String path = toJpeg(image, imgAllPathName);
				ret.add(path);
				pageIndex++;
			}
		} catch (Exception ex) {
			throw ex;
		}
		return ret;
	}

	/**
	 *<b>Summary: </b>
	 * toImages(将一個html格式的字符串转换为图片)
	 * @param String html 
	 * @param String imgPath 服务器图片路径
	 * @param String width 图片的宽度
	 * @param String height 图片的高度
	 * @return 图片名称（uuid+".jpg"）
	 * @throws Exception 
	 */
	public static String toImages(String html, String imgPath,
			int width, int height) throws Exception {
		String uuid = UUID.randomUUID().toString();
		String imgAllPathName = imgPath + uuid + ".jpg";
		html2jpeg(null, html, width, height, new EmptyBorder(0, 0, 0, 0), imgAllPathName);
		return uuid + ".jpg";
	}

	public static void main(String[] args) {
		
			//String tempPath = CacheCommonManage.getInstance().getSystemParam("upload_To_SeverPath");
			//String imgPath = request.getSession().getServletContext().getRealPath("") + tempPath;
			//GraphUtils.toImages(html, imgPath, 2000, 2000);//"D:\\creatorepp\\ccapp\\Upload\\"
		
	}

}
