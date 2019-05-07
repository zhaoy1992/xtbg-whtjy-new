package com.chinacreator.xtbg.core.common.util;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;

import javax.imageio.ImageIO;
import javax.swing.ImageIcon;

public class CreateImage {
	public static void main(String[] args) throws Exception {
		int width = 229;
		int height = 54;
		
		File file = new File("F:/image.jpg");
		BufferedImage bi = new BufferedImage(width, height,
				BufferedImage.SCALE_REPLICATE);
		Graphics2D g2 = (Graphics2D) bi.getGraphics();
		g2.setBackground(Color.WHITE);
		//g2.clearRect(0, 0, width, height);
		g2.setPaint(Color.WHITE);
		g2.setFont(new Font("黑体", Font.BOLD, 14));
		g2.setColor(Color.GRAY);
		
		ImageIcon imgIcon = new ImageIcon("F:/test4.png");
		Image img= imgIcon.getImage();
        g2.drawImage(img,0,0,null);
        g2.drawString("192", 5, 20);
        g2.drawString("2013", 120, 20);
        g2.drawString("110", 180, 20);
        g2.drawString("财务处", 5, 42);
        g2.drawString("永久", 120, 42);
		ImageIO.write(bi, "jpg", file);
	}
}
