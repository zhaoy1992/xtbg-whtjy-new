package com.chinacreator.xtbg.pub.util;

import java.io.OutputStream;
import java.io.Writer;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.converters.reflection.ReflectionProvider;
import com.thoughtworks.xstream.io.HierarchicalStreamDriver;

public class XmlDeclarationXStream extends XStream {
    private static Log log = LogFactory.getLog(XmlDeclarationXStream.class);
    private String version;
 
    private String ecoding;
 
    public XmlDeclarationXStream() {
       this("1.0", "GBK");
    }
    

	public XmlDeclarationXStream(
			HierarchicalStreamDriver hierarchicalStreamDriver) {
		super(hierarchicalStreamDriver);
		// TODO Auto-generated constructor stub
	}



	public XmlDeclarationXStream(String version, String ecoding) {
       this.version = version;
       this.ecoding = ecoding;
    }
	
 
   
    public String getVersion() {
		return version;
	}


	public void setVersion(String version) {
		this.version = version;
	}


	public String getEcoding() {
		return ecoding;
	}


	public void setEcoding(String ecoding) {
		this.ecoding = ecoding;
	}


	public String getDeclaration() {
       return "<?xml version=\"" + this.version + "\" encoding=\"" + this.ecoding + "\"?>";
    }
 
    @Override
    public void toXML(Object arg0, OutputStream arg1) {
       try {
           String dec = this.getDeclaration();
           byte[] bytesOfDec = dec.getBytes(this.ecoding);
           arg1.write(bytesOfDec);
       } catch (Exception e) {
           log.error("输出Declaration时候出现异常", e);
           return ;
       }
       super.toXML(arg0, arg1);
    }
 
    @Override
    public void toXML(Object arg0, Writer arg1) {
       try {
           arg1.write(getDeclaration());
       } catch (Exception e) {
           log.error("输出Declaration时候出现异常", e);
           return ;
       }
       super.toXML(arg0, arg1);
    }
 
}