package com.chinacreator.xtbg.core.common.util;

import java.awt.AlphaComposite;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.awt.image.RenderedImage;
import java.awt.image.renderable.ParameterBlock;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;

import javax.imageio.ImageIO;
import javax.media.jai.JAI;
import javax.media.jai.PlanarImage;
import javax.media.jai.RenderedOp;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.cache.OASystemCache;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;
import com.sun.media.jai.codec.FileSeekableStream;
import com.sun.media.jai.codec.ImageCodec;
import com.sun.media.jai.codec.ImageDecoder;
import com.sun.media.jai.codec.ImageEncoder;
import com.sun.media.jai.codec.JPEGEncodeParam;
import com.sun.media.jai.codec.TIFFDecodeParam;
import com.sun.media.jai.codec.TIFFEncodeParam;

/**
 *<p>Title:OAImageUtil.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013年11月15日
 */
public class OAImageUtil {
	
	private static final Log LOG = LogFactory.getLog(OAImageUtil.class);
	
	/**
	*<b>Summary: </b>
	* tiff2jpeg(Tiff 转成多页 jpeg图片)
	* @param srcfilePath  tiff 图片路径
	* @param tagetForder  生成jpeg的文件夹目录
	* @return
	* @throws IOException
	*/
	public String[] tiff2jpeg(String srcfilePath,String tagetForder) throws IOException{
		FileSeekableStream ss = null;
		try{
			ss = new FileSeekableStream(srcfilePath);
	        TIFFDecodeParam param0 = null;
	        TIFFEncodeParam param = new TIFFEncodeParam();
	        JPEGEncodeParam param1 = new JPEGEncodeParam();
	        ImageDecoder dec = ImageCodec.createImageDecoder("tiff", ss, param0);
	        int count = dec.getNumPages();
	        param.setCompression(TIFFEncodeParam.COMPRESSION_GROUP4);
	        param.setLittleEndian(false); // Intel
	        LOG.debug("This TIFF has " + count + " image(s)");
	        String[] filepaths = new String[count];
	        for (int i = 0; i < count; i++) {
	            RenderedImage page = dec.decodeAsRenderedImage(i);
	            String filepath = tagetForder+"fk_" + i + ".jpeg";
	            filepaths[i] = filepath;            
	            File f = new File(filepath);
	            LOG.debug("Saving " + f.getCanonicalPath());
	            ParameterBlock pb = new ParameterBlock();
	            pb.addSource(page);
	            pb.add(f.toString());
	            pb.add("JPEG");
	            pb.add(param1);
	            //JAI.create("filestore",pb);
	            RenderedOp r = JAI.create("filestore",pb);
	            r.dispose();
	        }
	        return filepaths;
		}finally{
			if(ss != null){
				ss.close();
			}
		}
	}
	
	/**
	*<b>Summary: </b>
	* many2one(合并多个图片 为一个 tiff文件)
	* @param bookFilePaths
	* @param tagetFilepath
	* @throws IOException
	*/
	public void many2one(String[] bookFilePaths, String tagetFilepath) throws IOException {
		if (bookFilePaths != null && bookFilePaths.length > 0) {
			File[] files = new File[bookFilePaths.length];
			for (int i = 0; i < bookFilePaths.length; i++) {
				files[i] = new File(bookFilePaths[i]);
			}
			if (files != null && files.length > 0) {
				ArrayList<PlanarImage> pages = new ArrayList<PlanarImage>(files.length - 1);
				FileSeekableStream[] stream = new FileSeekableStream[files.length];
				for (int i = 0; i < files.length; i++) {
					stream[i] = new FileSeekableStream(files[i].getCanonicalPath());
				}
				//ParameterBlock pb = (new ParameterBlock());
				PlanarImage firstPage = JAI.create("stream", stream[0]);
				for (int i = 1; i < files.length; i++) {
					PlanarImage page = JAI.create("stream", stream[i]);
					pages.add(page);
				}
				TIFFEncodeParam param = new TIFFEncodeParam();
				/*
				 * boolean f = makeDirs(toPath); System.out.println(f);
				 */
				OutputStream os = new FileOutputStream(tagetFilepath);
				ImageEncoder enc = ImageCodec.createImageEncoder("tiff",os, param);
				param.setExtraImages(pages.iterator());
				enc.encode(firstPage);
				for (int i = 0; i < files.length; i++) {
					stream[i].close();
				}
				os.close();
				LOG.debug("合并为tiff---->"+tagetFilepath);
			}
		}
	}
	
	/**
	*<b>Summary: </b>
	* waterMark(图片加盖水印文件)
	* @param srcfilePath 原始文件
	* @param waterFilePath	水印文件
	* @throws IOException
	*/
	public void waterMark(String srcfilePath,String waterFilePath) throws IOException {
		File file = new File(srcfilePath);
		Image srcImage = ImageIO.read(file);
		int width = srcImage.getWidth(null);
		int height = srcImage.getHeight(null);
		BufferedImage bImage = new BufferedImage(width, height,BufferedImage.TYPE_INT_RGB);
		Graphics2D gh = bImage.createGraphics();
		gh.drawImage(srcImage, 0, 0, width, height, null);
		File waterFile = new File(waterFilePath);
		Image waterImage = ImageIO.read(waterFile);
		int waterWidth = waterImage.getWidth(null);
		int waterHeight = waterImage.getHeight(null);
		gh.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_ATOP,0.5f));
		gh.drawImage(waterImage, (width - waterWidth) / 2,20, waterWidth, waterHeight, null);
		gh.dispose();
		FileOutputStream fos = new FileOutputStream(file);
		JPEGImageEncoder jie = JPEGCodec.createJPEGEncoder(fos);
		jie.encode(bImage);
		fos.close();
	}
	
	/**
	*<b>Summary: </b>
	* tiffWaterMark(tiff 图片加盖水印)
	* @param srctiff	原tiff 文件
	* @param water	水印文件
	* @throws IOException
	*/
	public void tiffWaterMark(String srcTiff,String water,String targetTiff)throws Exception {
		//String tempFolder = "d://test//test//";
		String tempFolder = OASystemCache.getContextProperty("temppath")+File.separator+StringUtil.getUUID()+File.separator;
		String[] jpegs = null;
		try{
			if(checkFolder(tempFolder)){
				jpegs = tiff2jpeg(srcTiff, tempFolder);//tiff 文件拆分为 jpeg
			}else{
				throw new Exception(tempFolder+"临时目录创建失败");
			}
			if(jpegs != null && jpegs.length > 0){
				waterMark(jpegs[0],water); //第一张 jpeg图片加盖水印
			}
			many2one(jpegs,targetTiff);//将 jpeg合并为 tiff文件
		}finally{
			System.gc();
			delFolder(tempFolder);
		}
	}
	
	/**
	*<b>Summary: </b>
	* checkFolder(检查目录是否存在,不存在则创建)
	* @param path
	* @return
	*/
	private boolean checkFolder(String folderPath) {
		boolean success = true;
		File tempfolder = new File(folderPath);
		if (!tempfolder.exists()){
			success = tempfolder.mkdirs();
		}
		return success;
	}
	
	/**
	*<b>Summary: </b>
	* delFolder(删除文件夹及文件夹下的所以内容)
	* @param folderPath 文件夹
	*/
	private void delFolder(String folderPath) {
		delAllFile(folderPath); // 删除完里面所有内容
		String filePath = folderPath;
		filePath = filePath.toString();
		java.io.File myFilePath = new java.io.File(filePath);
		myFilePath.delete(); // 删除空文件夹
	}

	/**
	*<b>Summary: </b>
	* delAllFile(删除文件夹下的所有文件)
	* @param path 文件夹
	* @return
	*/
	private boolean delAllFile(String path) {
		boolean flag = false;
		File file = new File(path);
		if (!file.exists()) {
			return flag;
		}
		if (!file.isDirectory()) {
			return flag;
		}
		String[] tempList = file.list();
		File temp = null;
		for (int i = 0; i < tempList.length; i++) {
			if (path.endsWith(File.separator)) {//子文件夹
				temp = new File(path + tempList[i]);
			} else {
				temp = new File(path + File.separator + tempList[i]);
			}
			if (temp.isFile()) {
				temp.delete();
			}
			if (temp.isDirectory()) {
				delAllFile(path + "/" + tempList[i]);// 先删除文件夹里面的文件
				delFolder(path + "/" + tempList[i]);// 再删除空文件夹
				flag = true;
			}
		}
		return flag;
	}

	public static void main(String[] args) {
		OAImageUtil util = new OAImageUtil();
		try {
			util.tiffWaterMark("D:\\test\\pdf.tif", "D:\\test\\2.jpg","D:\\test\\test.tif");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
