/**
 * SendArchiveRequestBean.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java;

public class SendArchiveRequestBean  implements java.io.Serializable {
    private byte[] dh;

    private java.lang.String[] affixName;

    private java.lang.String fileName;

    private java.lang.String type;

    private java.lang.String xmlName;

    private java.lang.String zipPath;

    public SendArchiveRequestBean() {
    }

    public SendArchiveRequestBean(
           byte[] dh,
           java.lang.String[] affixName,
           java.lang.String fileName,
           java.lang.String type,
           java.lang.String xmlName,
           java.lang.String zipPath) {
           this.dh = dh;
           this.affixName = affixName;
           this.fileName = fileName;
           this.type = type;
           this.xmlName = xmlName;
           this.zipPath = zipPath;
    }


    /**
     * Gets the dh value for this SendArchiveRequestBean.
     * 
     * @return dh
     */
    public byte[] getDh() {
        return dh;
    }


    /**
     * Sets the dh value for this SendArchiveRequestBean.
     * 
     * @param dh
     */
    public void setDh(byte[] dh) {
        this.dh = dh;
    }


    /**
     * Gets the affixName value for this SendArchiveRequestBean.
     * 
     * @return affixName
     */
    public java.lang.String[] getAffixName() {
        return affixName;
    }


    /**
     * Sets the affixName value for this SendArchiveRequestBean.
     * 
     * @param affixName
     */
    public void setAffixName(java.lang.String[] affixName) {
        this.affixName = affixName;
    }

    public java.lang.String getAffixName(int i) {
        return this.affixName[i];
    }

    public void setAffixName(int i, java.lang.String _value) {
        this.affixName[i] = _value;
    }


    /**
     * Gets the fileName value for this SendArchiveRequestBean.
     * 
     * @return fileName
     */
    public java.lang.String getFileName() {
        return fileName;
    }


    /**
     * Sets the fileName value for this SendArchiveRequestBean.
     * 
     * @param fileName
     */
    public void setFileName(java.lang.String fileName) {
        this.fileName = fileName;
    }


    /**
     * Gets the type value for this SendArchiveRequestBean.
     * 
     * @return type
     */
    public java.lang.String getType() {
        return type;
    }


    /**
     * Sets the type value for this SendArchiveRequestBean.
     * 
     * @param type
     */
    public void setType(java.lang.String type) {
        this.type = type;
    }


    /**
     * Gets the xmlName value for this SendArchiveRequestBean.
     * 
     * @return xmlName
     */
    public java.lang.String getXmlName() {
        return xmlName;
    }


    /**
     * Sets the xmlName value for this SendArchiveRequestBean.
     * 
     * @param xmlName
     */
    public void setXmlName(java.lang.String xmlName) {
        this.xmlName = xmlName;
    }


    /**
     * Gets the zipPath value for this SendArchiveRequestBean.
     * 
     * @return zipPath
     */
    public java.lang.String getZipPath() {
        return zipPath;
    }


    /**
     * Sets the zipPath value for this SendArchiveRequestBean.
     * 
     * @param zipPath
     */
    public void setZipPath(java.lang.String zipPath) {
        this.zipPath = zipPath;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof SendArchiveRequestBean)) return false;
        SendArchiveRequestBean other = (SendArchiveRequestBean) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.dh==null && other.getDh()==null) || 
             (this.dh!=null &&
              java.util.Arrays.equals(this.dh, other.getDh()))) &&
            ((this.affixName==null && other.getAffixName()==null) || 
             (this.affixName!=null &&
              java.util.Arrays.equals(this.affixName, other.getAffixName()))) &&
            ((this.fileName==null && other.getFileName()==null) || 
             (this.fileName!=null &&
              this.fileName.equals(other.getFileName()))) &&
            ((this.type==null && other.getType()==null) || 
             (this.type!=null &&
              this.type.equals(other.getType()))) &&
            ((this.xmlName==null && other.getXmlName()==null) || 
             (this.xmlName!=null &&
              this.xmlName.equals(other.getXmlName()))) &&
            ((this.zipPath==null && other.getZipPath()==null) || 
             (this.zipPath!=null &&
              this.zipPath.equals(other.getZipPath())));
        __equalsCalc = null;
        return _equals;
    }

    private boolean __hashCodeCalc = false;
    public synchronized int hashCode() {
        if (__hashCodeCalc) {
            return 0;
        }
        __hashCodeCalc = true;
        int _hashCode = 1;
        if (getDh() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getDh());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getDh(), i);
                if (obj != null &&
                    !obj.getClass().isArray()) {
                    _hashCode += obj.hashCode();
                }
            }
        }
        if (getAffixName() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getAffixName());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getAffixName(), i);
                if (obj != null &&
                    !obj.getClass().isArray()) {
                    _hashCode += obj.hashCode();
                }
            }
        }
        if (getFileName() != null) {
            _hashCode += getFileName().hashCode();
        }
        if (getType() != null) {
            _hashCode += getType().hashCode();
        }
        if (getXmlName() != null) {
            _hashCode += getXmlName().hashCode();
        }
        if (getZipPath() != null) {
            _hashCode += getZipPath().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(SendArchiveRequestBean.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://service.oa.gwcs.chinacreator.com/", "sendArchiveRequestBean"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("dh");
        elemField.setXmlName(new javax.xml.namespace.QName("", "dh"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "base64Binary"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("affixName");
        elemField.setXmlName(new javax.xml.namespace.QName("", "affixName"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(true);
        elemField.setMaxOccursUnbounded(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("fileName");
        elemField.setXmlName(new javax.xml.namespace.QName("", "fileName"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("type");
        elemField.setXmlName(new javax.xml.namespace.QName("", "type"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("xmlName");
        elemField.setXmlName(new javax.xml.namespace.QName("", "xmlName"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("zipPath");
        elemField.setXmlName(new javax.xml.namespace.QName("", "zipPath"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
    }

    /**
     * Return type metadata object
     */
    public static org.apache.axis.description.TypeDesc getTypeDesc() {
        return typeDesc;
    }

    /**
     * Get Custom Serializer
     */
    public static org.apache.axis.encoding.Serializer getSerializer(
           java.lang.String mechType, 
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType) {
        return 
          new  org.apache.axis.encoding.ser.BeanSerializer(
            _javaType, _xmlType, typeDesc);
    }

    /**
     * Get Custom Deserializer
     */
    public static org.apache.axis.encoding.Deserializer getDeserializer(
           java.lang.String mechType, 
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType) {
        return 
          new  org.apache.axis.encoding.ser.BeanDeserializer(
            _javaType, _xmlType, typeDesc);
    }

}
