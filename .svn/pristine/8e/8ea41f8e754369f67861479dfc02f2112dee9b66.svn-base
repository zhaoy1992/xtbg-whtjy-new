/**
 * SendRequestBean.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.2RC2 Nov 16, 2004 (12:19:44 EST) WSDL2Java emitter.
 */

package com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java;

public class SendRequestBean  implements java.io.Serializable {
    private byte[] dh;
    private java.lang.String[] affixName;
    private java.lang.String id;
    private java.lang.String type;
    private java.lang.String xmlName;

    public SendRequestBean() {
    }

    public SendRequestBean(
           byte[] dh,
           java.lang.String[] affixName,
           java.lang.String id,
           java.lang.String type,
           java.lang.String xmlName) {
           this.dh = dh;
           this.affixName = affixName;
           this.id = id;
           this.type = type;
           this.xmlName = xmlName;
    }


    /**
     * Gets the dh value for this SendRequestBean.
     * 
     * @return dh
     */
    public byte[] getDh() {
        return dh;
    }


    /**
     * Sets the dh value for this SendRequestBean.
     * 
     * @param dh
     */
    public void setDh(byte[] dh) {
        this.dh = dh;
    }


    /**
     * Gets the affixName value for this SendRequestBean.
     * 
     * @return affixName
     */
    public java.lang.String[] getAffixName() {
        return affixName;
    }


    /**
     * Sets the affixName value for this SendRequestBean.
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
     * Gets the id value for this SendRequestBean.
     * 
     * @return id
     */
    public java.lang.String getId() {
        return id;
    }


    /**
     * Sets the id value for this SendRequestBean.
     * 
     * @param id
     */
    public void setId(java.lang.String id) {
        this.id = id;
    }


    /**
     * Gets the type value for this SendRequestBean.
     * 
     * @return type
     */
    public java.lang.String getType() {
        return type;
    }


    /**
     * Sets the type value for this SendRequestBean.
     * 
     * @param type
     */
    public void setType(java.lang.String type) {
        this.type = type;
    }


    /**
     * Gets the xmlName value for this SendRequestBean.
     * 
     * @return xmlName
     */
    public java.lang.String getXmlName() {
        return xmlName;
    }


    /**
     * Sets the xmlName value for this SendRequestBean.
     * 
     * @param xmlName
     */
    public void setXmlName(java.lang.String xmlName) {
        this.xmlName = xmlName;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof SendRequestBean)) return false;
        SendRequestBean other = (SendRequestBean) obj;
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
            ((this.id==null && other.getId()==null) || 
             (this.id!=null &&
              this.id.equals(other.getId()))) &&
            ((this.type==null && other.getType()==null) || 
             (this.type!=null &&
              this.type.equals(other.getType()))) &&
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
        if (getId() != null) {
            _hashCode += getId().hashCode();
        }
        if (getType() != null) {
            _hashCode += getType().hashCode();
        }
        if (getXmlName() != null) {
            _hashCode += getXmlName().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(SendRequestBean.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://service.oa.gwcs.chinacreator.com/", "sendRequestBean"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("dh");
        elemField.setXmlName(new javax.xml.namespace.QName("", "dh"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "base64Binary"));
        elemField.setMinOccurs(0);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("affixName");
        elemField.setXmlName(new javax.xml.namespace.QName("", "affixName"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("id");
        elemField.setXmlName(new javax.xml.namespace.QName("", "id"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("type");
        elemField.setXmlName(new javax.xml.namespace.QName("", "type"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("xmlName");
        elemField.setXmlName(new javax.xml.namespace.QName("", "xmlName"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
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
