/**
 * SendResponseBean.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.2RC2 Nov 16, 2004 (12:19:44 EST) WSDL2Java emitter.
 */

package com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java;

public class SendResponseBean  implements java.io.Serializable {
    private java.lang.String businessid;
    private java.lang.String exception;
    private java.lang.String messageid;
    private java.lang.String summary;

    public SendResponseBean() {
    }

    public SendResponseBean(
           java.lang.String businessid,
           java.lang.String exception,
           java.lang.String messageid,
           java.lang.String summary) {
           this.businessid = businessid;
           this.exception = exception;
           this.messageid = messageid;
           this.summary = summary;
    }


    /**
     * Gets the businessid value for this SendResponseBean.
     * 
     * @return businessid
     */
    public java.lang.String getBusinessid() {
        return businessid;
    }


    /**
     * Sets the businessid value for this SendResponseBean.
     * 
     * @param businessid
     */
    public void setBusinessid(java.lang.String businessid) {
        this.businessid = businessid;
    }


    /**
     * Gets the exception value for this SendResponseBean.
     * 
     * @return exception
     */
    public java.lang.String getException() {
        return exception;
    }


    /**
     * Sets the exception value for this SendResponseBean.
     * 
     * @param exception
     */
    public void setException(java.lang.String exception) {
        this.exception = exception;
    }


    /**
     * Gets the messageid value for this SendResponseBean.
     * 
     * @return messageid
     */
    public java.lang.String getMessageid() {
        return messageid;
    }


    /**
     * Sets the messageid value for this SendResponseBean.
     * 
     * @param messageid
     */
    public void setMessageid(java.lang.String messageid) {
        this.messageid = messageid;
    }


    /**
     * Gets the summary value for this SendResponseBean.
     * 
     * @return summary
     */
    public java.lang.String getSummary() {
        return summary;
    }


    /**
     * Sets the summary value for this SendResponseBean.
     * 
     * @param summary
     */
    public void setSummary(java.lang.String summary) {
        this.summary = summary;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof SendResponseBean)) return false;
        SendResponseBean other = (SendResponseBean) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.businessid==null && other.getBusinessid()==null) || 
             (this.businessid!=null &&
              this.businessid.equals(other.getBusinessid()))) &&
            ((this.exception==null && other.getException()==null) || 
             (this.exception!=null &&
              this.exception.equals(other.getException()))) &&
            ((this.messageid==null && other.getMessageid()==null) || 
             (this.messageid!=null &&
              this.messageid.equals(other.getMessageid()))) &&
            ((this.summary==null && other.getSummary()==null) || 
             (this.summary!=null &&
              this.summary.equals(other.getSummary())));
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
        if (getBusinessid() != null) {
            _hashCode += getBusinessid().hashCode();
        }
        if (getException() != null) {
            _hashCode += getException().hashCode();
        }
        if (getMessageid() != null) {
            _hashCode += getMessageid().hashCode();
        }
        if (getSummary() != null) {
            _hashCode += getSummary().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(SendResponseBean.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://service.oa.gwcs.chinacreator.com/", "sendResponseBean"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("businessid");
        elemField.setXmlName(new javax.xml.namespace.QName("", "businessid"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("exception");
        elemField.setXmlName(new javax.xml.namespace.QName("", "exception"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("messageid");
        elemField.setXmlName(new javax.xml.namespace.QName("", "messageid"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("summary");
        elemField.setXmlName(new javax.xml.namespace.QName("", "summary"));
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
