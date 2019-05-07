/**
 * WordToGWCSServiceLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.2RC2 Nov 16, 2004 (12:19:44 EST) WSDL2Java emitter.
 */

package com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java;

public class WordToGWCSServiceLocator extends org.apache.axis.client.Service implements com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.WordToGWCSServiceImpl {

    public WordToGWCSServiceLocator() {
    }


    public WordToGWCSServiceLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    // Use to get a proxy class for WordToGWCSServiceImplPort
    private java.lang.String WordToGWCSServiceImplPort_address = "http://172.16.17.78:6666/gwcs/services/WordToGWCSService";

    public java.lang.String getWordToGWCSServiceImplPortAddress() {
        return WordToGWCSServiceImplPort_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String WordToGWCSServiceImplPortWSDDServiceName = "WordToGWCSServiceImplPort";

    public java.lang.String getWordToGWCSServiceImplPortWSDDServiceName() {
        return WordToGWCSServiceImplPortWSDDServiceName;
    }

    public void setWordToGWCSServiceImplPortWSDDServiceName(java.lang.String name) {
        WordToGWCSServiceImplPortWSDDServiceName = name;
    }

    public com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.WordToGWCSService getWordToGWCSServiceImplPort() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(WordToGWCSServiceImplPort_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getWordToGWCSServiceImplPort(endpoint);
    }

    public com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.WordToGWCSService getWordToGWCSServiceImplPort(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.WordToGWCSServiceSoapBindingStub _stub = new com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.WordToGWCSServiceSoapBindingStub(portAddress, this);
            _stub.setPortName(getWordToGWCSServiceImplPortWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setWordToGWCSServiceImplPortEndpointAddress(java.lang.String address) {
        WordToGWCSServiceImplPort_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.WordToGWCSService.class.isAssignableFrom(serviceEndpointInterface)) {
                com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.WordToGWCSServiceSoapBindingStub _stub = new com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.WordToGWCSServiceSoapBindingStub(new java.net.URL(WordToGWCSServiceImplPort_address), this);
                _stub.setPortName(getWordToGWCSServiceImplPortWSDDServiceName());
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
        if ("WordToGWCSServiceImplPort".equals(inputPortName)) {
            return getWordToGWCSServiceImplPort();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("http://www.chinacreator.com.cn", "WordToGWCSService");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("http://www.chinacreator.com.cn", "WordToGWCSServiceImplPort"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        if ("WordToGWCSServiceImplPort".equals(portName)) {
            setWordToGWCSServiceImplPortEndpointAddress(address);
        }
        else { // Unknown Port Name
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
