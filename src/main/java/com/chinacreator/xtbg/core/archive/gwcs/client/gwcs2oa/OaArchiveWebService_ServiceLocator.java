/**
 * OaArchiveWebService_ServiceLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.chinacreator.xtbg.core.archive.gwcs.client.gwcs2oa;

public class OaArchiveWebService_ServiceLocator extends org.apache.axis.client.Service implements com.chinacreator.xtbg.core.archive.gwcs.client.gwcs2oa.OaArchiveWebService_Service {

    public OaArchiveWebService_ServiceLocator() {
    }


    public OaArchiveWebService_ServiceLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public OaArchiveWebService_ServiceLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for OaArchiveWebServiceImplPort
    private java.lang.String OaArchiveWebServiceImplPort_address = "http://localhost:8080/xtbgbase/services/OaArchiveWebService";

    public java.lang.String getOaArchiveWebServiceImplPortAddress() {
        return OaArchiveWebServiceImplPort_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String OaArchiveWebServiceImplPortWSDDServiceName = "OaArchiveWebServiceImplPort";

    public java.lang.String getOaArchiveWebServiceImplPortWSDDServiceName() {
        return OaArchiveWebServiceImplPortWSDDServiceName;
    }

    public void setOaArchiveWebServiceImplPortWSDDServiceName(java.lang.String name) {
        OaArchiveWebServiceImplPortWSDDServiceName = name;
    }

    public com.chinacreator.xtbg.core.archive.gwcs.client.gwcs2oa.OaArchiveWebService_PortType getOaArchiveWebServiceImplPort() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(OaArchiveWebServiceImplPort_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getOaArchiveWebServiceImplPort(endpoint);
    }

    public com.chinacreator.xtbg.core.archive.gwcs.client.gwcs2oa.OaArchiveWebService_PortType getOaArchiveWebServiceImplPort(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            com.chinacreator.xtbg.core.archive.gwcs.client.gwcs2oa.OaArchiveWebServiceSoapBindingStub _stub = new com.chinacreator.xtbg.core.archive.gwcs.client.gwcs2oa.OaArchiveWebServiceSoapBindingStub(portAddress, this);
            _stub.setPortName(getOaArchiveWebServiceImplPortWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setOaArchiveWebServiceImplPortEndpointAddress(java.lang.String address) {
        OaArchiveWebServiceImplPort_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (com.chinacreator.xtbg.core.archive.gwcs.client.gwcs2oa.OaArchiveWebService_PortType.class.isAssignableFrom(serviceEndpointInterface)) {
                com.chinacreator.xtbg.core.archive.gwcs.client.gwcs2oa.OaArchiveWebServiceSoapBindingStub _stub = new com.chinacreator.xtbg.core.archive.gwcs.client.gwcs2oa.OaArchiveWebServiceSoapBindingStub(new java.net.URL(OaArchiveWebServiceImplPort_address), this);
                _stub.setPortName(getOaArchiveWebServiceImplPortWSDDServiceName());
                return _stub;
            }
        }
        catch (java.lang.Throwable t) {
            throw new javax.xml.rpc.ServiceException(t);
        }
        throw new javax.xml.rpc.ServiceException("There is no stub implementation for the interface:  " + (serviceEndpointInterface == null ? "null" : serviceEndpointInterface.getName()));
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(javax.xml.namespace.QName portName, Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        if (portName == null) {
            return getPort(serviceEndpointInterface);
        }
        java.lang.String inputPortName = portName.getLocalPart();
        if ("OaArchiveWebServiceImplPort".equals(inputPortName)) {
            return getOaArchiveWebServiceImplPort();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("http://impl.services.gwcs.archive.core.xtbg.chinacreator.com/", "OaArchiveWebService");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("http://impl.services.gwcs.archive.core.xtbg.chinacreator.com/", "OaArchiveWebServiceImplPort"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        
if ("OaArchiveWebServiceImplPort".equals(portName)) {
            setOaArchiveWebServiceImplPortEndpointAddress(address);
        }
        else 
{ // Unknown Port Name
            throw new javax.xml.rpc.ServiceException(" Cannot set Endpoint Address for Unknown Port" + portName);
        }
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(javax.xml.namespace.QName portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        setEndpointAddress(portName.getLocalPart(), address);
    }

}
