package com.chinacreator.xtbg.core.archive.gwcs.bean;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;
import org.w3c.dom.NodeList;

/**
 * 描述：xml文件操作类（利用dom4j操作，需导入dom4j.jar与jaxen-1.1-beta-2.jar）<br>
 * 版本：1.0 <br>
 * 
 * @author minghua.guo
 */
public class XmlBuilder {
	/**
	 * xml文件对象
	 * */
	public Document document = null;
	/**
	 * 构造函数
	 * 
	 * @param url xml所在路径
	 * 
	 */
	public XmlBuilder(String url) {
		if (new File(url).exists()) {
			document = getDom(url);
		} else {
			document = DocumentHelper.createDocument();
		}
	}
	
	/**
	 * 通过url读取xml文件，返回XML文档对象
	 * 
	 * @param url
	 *            xml所在路径
	 * @return xml文件对象
	 */
	private Document getDom(String url) {
		try {
			// 创建dom4j解析xml文件对象
			SAXReader saxReader = new SAXReader();

			// 通过url读取xml文件，返回XML文档对象
			return saxReader.read(new File(url));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 通过指定路径，得到指定元素的值
	 * 
	 * @param elementUrl
	 *            指定路径
	 * @return 指定元素的值
	 */
	public String getElementValue(String elementUrl) {
		// 得到指定路径上的元素列表
		List<?> list = document.selectNodes(elementUrl);
		Iterator<?> iter = list.iterator();
		if (iter.hasNext()) {
			// 得到指定元素对象
			Element element = (Element) iter.next();
			return element.getTextTrim();
		}
		return "";
	}
	
	/**
	 * 通过指定路径，得到指定元素的值
	 * 
	 * @param elementUrl
	 *            指定路径
	 * @return 指定元素的值
	 */
	public List<?> getElements(String elementUrl) {
		// 得到指定路径上的元素列表
		//Element e = document.getElement("add");
		return null;
	}

	/**
	 * 通过指定路径，得到指定元素
	 * 
	 * @param elementUrl
	 *            指定路径
	 * @return 指定元素的值
	 */
	public Element getElement(String elementUrl) {
		// 得到指定路径上的元素列表
		List<?> list = document.selectNodes(elementUrl);
		Iterator<?> iter = list.iterator();
		if (iter.hasNext()) {
			// 得到指定元素对象
			Element element = (Element) iter.next();
			return element;
		}
		return null;
	}

	/**
	 * 修改xml文件元素的值
	 * 
	 * @param elementUrl
	 *            元素所在位置
	 * @param value
	 *            修改后的值
	 */
	public void updateElement(String elementUrl, String value) {
		// 得到指定路径上的元素列表
		List<?> list = document.selectNodes(elementUrl);
		Iterator<?> iter = list.iterator();
		if (iter.hasNext()) {
			// 得到指定元素对象
			Element element = (Element) iter.next();
			// 修改元素的值
			element.setText(value);
		}
	}

	/**
	 * 将document中的内容写入指定文件中
	 * 
	 * @param url
	 *            指定写入的文件路径
	 * @return true 写入成功
	 */
	public boolean writerXML(String url) {
		XMLWriter writer = null;
		// 格式化输出,类型IE浏览一样
		OutputFormat format = OutputFormat.createPrettyPrint();
		// 指定XML编码
		format.setEncoding("utf-8");
		try {
			writer = new XMLWriter(new FileWriter(new File(url)), format);
			writer.write(document);
			writer.close();
		} catch (IOException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	/**
	 * 通过指定路径，将指定元素与值加到xml文件中
	 * 
	 * @param elementUrl
	 *            指定路径
	 * @param elementName
	 *            指定元素
	 * @param elementValue
	 *            指定元素的值
	 */
	public void creatElement(String elementUrl, String elementName,
			String elementValue) {
		// 得到指定路径上的元素列表
		List<?> list = document.selectNodes(elementUrl);
		Iterator<?> iter = list.iterator();
		if (iter.hasNext()) {
			// 得到指定元素对象
			Element element = (Element) iter.next();
			// 在指定元素对象下加入指定元素
			Element nameElement = element.addElement(elementName);
			// 设置元素的值
			nameElement.setText(elementValue);
		}
	}
	
	public void addElement(String elementName){
		if(document==null){
			document = DocumentHelper.createDocument();
		}
		document.addElement(elementName);
	}
	
	public static void main(String[] args){
		String url = "D:\\test.xml";
		XmlBuilder xBuilder = new XmlBuilder(url);
		xBuilder.addElement("archive");
		//xBuilder.creatElement("archive", "archiveparameters", "");
		Element archive = xBuilder.getElement("archive");
		Element archiveparameters = archive.addElement("archiveparameters");
		archiveparameters.addElement("title").addText("公文标题");
		Element num = archiveparameters.addElement("num");
		num.addElement("type").addText("");
		num.addElement("prefix").addText("");
		num.addElement("symbol").addText("");
		num.addElement("serial_number").addText("1号");
		archiveparameters.addElement("secrecy_grade").addText("秘密");
		archiveparameters.addElement("effect_date").addText("1年");
		archiveparameters.addElement("urgency_grade").addText("缓急");
		archiveparameters.addElement("caption").addText("主题词");
		archiveparameters.addElement("keyword").addText("关键字");
		archiveparameters.addElement("dispatch_type").addText("决定");
		archiveparameters.addElement("sender").addText("签发人");
		archiveparameters.addElement("sendscope").addText("发市州省直");
		archiveparameters.addElement("create_date").addText("2008-06-17");
		archiveparameters.addElement("send_org_name").addText("中共湖南省委");
		archiveparameters.addElement("send_org_addr").addText("10000000000000000000");
		archiveparameters.addElement("sendusername").addText("省委办公厅");
		archiveparameters.addElement("issign").addText("false");
		archiveparameters.addElement("file_type").addText("ceb");
		archiveparameters.addElement("contact_phone").addText("询问公文相关问题的联系方式");
		archiveparameters.addElement("file_name").addText("发文模块测试报告.ceb");
		archiveparameters.addElement("affix1_name").addText("附件1.txt");
		archiveparameters.addElement("affix2_name").addText("附件2.txt");
		archiveparameters.addElement("affixN_name").addText("附件N.txt");
		Element receivedeptinfor = archive.addElement("receivedeptinfor");
		Element addrinfor1 = receivedeptinfor.addElement("addrinfor");
		addrinfor1.addElement("receiveraddr").addText("10010060000000000000");
		addrinfor1.addElement("receivername").addText("省委组织部");
		addrinfor1.addElement("print_num").addText("份数");
		addrinfor1.addElement("num").addText("份号");
		addrinfor1.addElement("send_type").addText("m");
		Element addrinfor2 = receivedeptinfor.addElement("addrinfor");
		addrinfor2.addElement("receiveraddr").addText("11030000000000000000");
		addrinfor2.addElement("receivername").addText("株洲市委");
		addrinfor2.addElement("print_num").addText("份数");
		addrinfor2.addElement("num").addText("份号");
		addrinfor2.addElement("send_type").addText("c");

		xBuilder.writerXML(url);
		
		
		//Document doc = xBuilder.getDocument();
		//Element root = doc.getRootElement();
		//String aa = xBuilder.getElementValue("graph");
		//System.out.println(root.getName());
		//System.out.println(root.attributeCount());
		//System.out.println(root.attributeValue("caption"));
//		List list = root.elements();
//		int i=0,size = list.size();
//		for (i = 0; i < size; i++) {
//			Element element = (Element)list.get(i);
//			System.out.println(i+":"+ element.elementTextTrim("org_id"));
//		}
		System.out.println(xBuilder.toString());
	}

	public Document getDocument() {
		return document;
	}

	public void setDocument(Document document) {
		this.document = document;
	}
}
