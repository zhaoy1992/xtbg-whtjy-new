/**
 * ArchiveToServerServiceLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.2RC2 Nov 16, 2004 (12:19:44 EST) WSDL2Java emitter.
 */

package com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java;

public class ArchiveToServerServiceLocator extends org.apache.axis.client.Service implements com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.ArchiveToServerServiceImpl {

    public ArchiveToServerServiceLocator() {
    }


    public ArchiveToServerServiceLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    // Use to get a proxy class for ArchiveToServerServiceImplPort
    private java.lang.String ArchiveToServerServiceImplPort_address = "http://172.16.17.78:6666/gwcs/services/ArchiveToServerService";

    public java.lang.String getArchiveToServerServiceImplPortAddress() {
        return ArchiveToServerServiceImplPort_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String ArchiveToServerServiceImplPortWSDDServiceName = "ArchiveToServerServiceImplPort";

    public java.lang.String getArchiveToServerServiceImplPortWSDDServiceName() {
        return ArchiveToServerServiceImplPortWSDDServiceName;
    }

    public void setArchiveToServerServiceImplPortWSDDServiceName(java.lang.String name) {
        ArchiveToServerServiceImplPortWSDDServiceName = name;
    }

    public com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.ArchiveToServerService getArchiveToServerServiceImplPort() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(ArchiveToServerServiceImplPort_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getArchiveToServerServiceImplPort(endpoint);
    }

    public com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.ArchiveToServerService getArchiveToServerServiceImplPort(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.ArchiveToServerServiceSoapBindingStub _stub = new com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.ArchiveToServerServiceSoapBindingStub(portAddress, this);
            _stub.setPortName(getArchiveToServerServiceImplPortWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setArchiveToServerServiceImplPortEndpointAddress(java.lang.String address) {
        ArchiveToServerServiceImplPort_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.ArchiveToServerService.class.isAssignableFrom(serviceEndpointInterface)) {
                com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.ArchiveToServerServiceSoapBindingStub _stub = new com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.ArchiveToServerServiceSoapBindingStub(new java.net.URL(ArchiveToServerServiceImplPort_address), this);
                _stub.setPortName(getArchiveToServerServiceImplPortWSDDServiceName());
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
        if ("ArchiveToServerServiceImplPort".equals(inputPortName)) {
            return getArchiveToServerServiceImplPort();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("http://www.chinacreator.com.cn", "ArchiveToServerService");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("http://www.chinacreator.com.cn", "ArchiveToServerServiceImplPort"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        if ("ArchiveToServerServiceImplPort".equals(portName)) {
            setArchiveToServerServiceImplPortEndpointAddress(address);
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
