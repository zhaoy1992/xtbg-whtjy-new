package com.chinacreator.xtbg.core.common.util;

import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Graphics2D;

import javax.swing.JTextPane;
import javax.swing.plaf.basic.BasicEditorPaneUI;

/**
 *<p>Title:PrintView.java</p>
 *<p>Description: 绘制图片工具类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 何世星
 *@version 1.0
 *2014-2-7
 */
public class PrintView {

	public JTextPane panel = null;

	public PrintView(JTextPane panel) {
		this.panel = panel;
	}

	/**
	 * 绘制图片的方法
	 * 
	 * @param g
	 * @param hPage
	 * @param pageIndex
	 * @return
	 */
	public boolean paintPage(Graphics g, int hPage, int pageIndex) {
		Graphics2D g2 = (Graphics2D) g;
		Dimension d = ((BasicEditorPaneUI) panel.getUI())
				.getPreferredSize(panel);
		double panelHeight = d.height;
		double pageHeight = hPage;
		int totalNumPages = (int) Math.ceil(panelHeight / pageHeight);
		g2.translate(0f, -(pageIndex - 1) * pageHeight);
		panel.paint(g2);
		boolean ret = true;
		if (pageIndex >= totalNumPages) {
			ret = false;
			return ret;
		}
		return ret;
	}
}
