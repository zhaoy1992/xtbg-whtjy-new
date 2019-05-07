<%@ page contentType="text/html;charset=GB2312" %>
　　<%@ page import="javax.xml.parsers.*,
      org.xml.sax.*,
      org.xml.sax.helpers.*,
      org.xml.sax.helpers.DefaultHandler,
      java.io.*"%> 
　　<html>
 　　 <head><title>用SAX解析并遍历user.xml</title></head>
 　　 <body>
　　<%!
static class SAXParseUser extends DefaultHandler{
 StringBuffer tempString=new StringBuffer();
 //文档解析开始
 public void startDocument() throws SAXException {
  tempString.append("开始解析xml文件......<br>");
 }
 //标签解析开始
 public void startElement(String namespaceURI, String localName,String qName, Attributes atts) throws SAXException{
 tempString.append("开始解析结点，结点名称："+qName+"<br>");
  //解析得到标签所有的属性
  for(int i=0;i<atts.getLength();i++){
  tempString.append("&nbsp;&nbsp;属性"+atts.getQName(i)+",值为："+atts. getValue(i)+"<br>");  
  }
 }
 //标签解析结束
 public void endElement(String namespaceURI,String localName,String qName) throws SAXException{
 tempString.append("解析结点结束，结点名称："+qName+"<br>");
 }
 //字符串解析
 public void characters(char[] ch,int start,int length){
  tempString.append("&nbsp;&nbsp;解析出字符串,值为：'"+(new String(ch,start, length))+"'<br>"); 
 }
 //文档解析结束
 public void endDocument() throws SAXException {
  tempString.append("解析xml文件结束!<br>");
 }
 //得到解析结果
 public StringBuffer getPrintXML(){
  return tempString;
 }
}
%>
　　<% //生成SAX解析器工厂
 SAXParserFactory spf = SAXParserFactory.newInstance();
 XMLReader xmlReader = null;
 SAXParser saxParser=null;
 SAXParseUser saxParseUser=new SAXParseUser();
 String filename=pageContext.getServletContext().getRealPath("/user.xml");
 try {
  // 创建一个解析器SAXParser对象
  saxParser = spf.newSAXParser();
  // 得到SAXParser中封装的SAX XMLReader
  xmlReader = saxParser.getXMLReader();
  //设置解析时处理事件的对象
  xmlReader.setContentHandler(saxParseUser);
  //开始解析XML文件
  xmlReader.parse(filename);
 }catch (Exception ex) {
  System.out.println(ex);
 }
 //输出解析结果
 out.println(saxParseUser.getPrintXML()); 
%>  
　　 </body>
　　</html>
