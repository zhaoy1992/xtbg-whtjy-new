/**
 * UnionArchiveResponseBean.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java;

public class UnionArchiveResponseBean  implements java.io.Serializable {
    private java.lang.String cebName;

    private byte[] dh;

    private java.lang.String xmlName;

    public UnionArchiveResponseBean() {
    }

    public UnionArchiveResponseBean(
           java.lang.String cebName,
           byte[] dh,
           java.lang.String xmlName) {
           this.cebName = cebName;
           this.dh = dh;
           this.xmlName = xmlName;
    }


    /**
     * Gets the cebName value for this UnionArchiveResponseBean.
     * 
     * @return cebName
     */
    public java.lang.String getCebName() {
        return cebName;
    }


    /**
     * Sets the cebName value for this UnionArchiveResponseBean.
     * 
     * @param cebName
     */
    public void setCebName(java.lang.String cebName) {
        this.cebName = cebName;
    }


    /**
     * Gets the dh value for this UnionArchiveResponseBean.
     * 
     * @return dh
     */
    public byte[] getDh() {
        return dh;
    }


    /**
     * Sets the dh value for this UnionArchiveResponseBean.
     * 
     * @param dh
     */
    public void setDh(byte[] dh) {
        this.dh = dh;
    }


    /**
     * Gets the xmlName value for this UnionArchiveResponseBean.
     * 
     * @return xmlName
     */
    public java.lang.String getXmlName() {
        return xmlName;
    }


    /**
     * Sets the xmlName value for this UnionArchiveResponseBean.
     * 
     * @param xmlName
     */
    public void setXmlName(java.lang.String xmlName) {
        this.xmlName = xmlName;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof UnionArchiveResponseBean)) return false;
        UnionArchiveResponseBean other = (UnionArchiveResponseBean) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.cebName==null && other.getCebName()==null) || 
             (this.cebName!=null &&
              this.cebName.equals(other.getCebName()))) &&
            ((this.dh==null && other.getDh()==null) || 
             (this.dh!=null &&
              java.util.Arrays.equals(this.dh, other.getDh()))) &&
            ((this.xmlName==null && other.getXmlName()==null) || 
             (this.xmlName!=null &&
              this.xmlName.equals(other.getXmlName())));
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
        if (getCebName() != null) {
            _hashCode += getCebName().hashCode();
        }
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
        if (getXmlName() != null) {
            _hashCode += getXmlName().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(UnionArchiveResponseBean.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://service.oa.gwcs.chinacreator.com/", "unionArchiveResponseBean"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("cebName");
        elemField.setXmlName(new javax.xml.namespace.QName("", "cebName"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("dh");
        elemField.setXmlName(new javax.xml.namespace.QName("", "dh"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "base64Binary"));
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
