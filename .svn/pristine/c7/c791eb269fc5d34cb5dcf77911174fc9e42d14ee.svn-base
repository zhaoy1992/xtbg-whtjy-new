/**
 * CreatorPDFMakerServiceLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.2RC2 Nov 16, 2004 (12:19:44 EST) WSDL2Java emitter.
 */

package com.chinacreator.xtbg.core.common.creatormaker.webservices;

public class CreatorPDFMakerServiceLocator extends org.apache.axis.client.Service implements com.chinacreator.xtbg.core.common.creatormaker.webservices.CreatorPDFMakerServiceService {

    public CreatorPDFMakerServiceLocator() {
    }


    public CreatorPDFMakerServiceLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    // Use to get a proxy class for CreatorPDFMakerServiceImplPort
    private java.lang.String CreatorPDFMakerServiceImplPort_address = "http://172.16.17.104/maker/services/CreatorPDFMakerService";

    public java.lang.String getCreatorPDFMakerServiceImplPortAddress() {
        return CreatorPDFMakerServiceImplPort_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String CreatorPDFMakerServiceImplPortWSDDServiceName = "CreatorPDFMakerServiceImplPort";

    public java.lang.String getCreatorPDFMakerServiceImplPortWSDDServiceName() {
        return CreatorPDFMakerServiceImplPortWSDDServiceName;
    }

    public void setCreatorPDFMakerServiceImplPortWSDDServiceName(java.lang.String name) {
        CreatorPDFMakerServiceImplPortWSDDServiceName = name;
    }

    public com.chinacreator.xtbg.core.common.creatormaker.webservices.CreatorPDFMakerService getCreatorPDFMakerServiceImplPort() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(CreatorPDFMakerServiceImplPort_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getCreatorPDFMakerServiceImplPort(endpoint);
    }

    public com.chinacreator.xtbg.core.common.creatormaker.webservices.CreatorPDFMakerService getCreatorPDFMakerServiceImplPort(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            com.chinacreator.xtbg.core.common.creatormaker.webservices.CreatorPDFMakerServiceSoapBindingStub _stub = new com.chinacreator.xtbg.core.common.creatormaker.webservices.CreatorPDFMakerServiceSoapBindingStub(portAddress, this);
            _stub.setPortName(getCreatorPDFMakerServiceImplPortWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setCreatorPDFMakerServiceImplPortEndpointAddress(java.lang.String address) {
        CreatorPDFMakerServiceImplPort_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (com.chinacreator.xtbg.core.common.creatormaker.webservices.CreatorPDFMakerService.class.isAssignableFrom(serviceEndpointInterface)) {
                com.chinacreator.xtbg.core.common.creatormaker.webservices.CreatorPDFMakerServiceSoapBindingStub _stub = new com.chinacreator.xtbg.core.common.creatormaker.webservices.CreatorPDFMakerServiceSoapBindingStub(new java.net.URL(CreatorPDFMakerServiceImplPort_address), this);
                _stub.setPortName(getCreatorPDFMakerServiceImplPortWSDDServiceName());
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
        if ("CreatorPDFMakerServiceImplPort".equals(inputPortName)) {
            return getCreatorPDFMakerServiceImplPort();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("http://impl.services.core.xtbg.chinacreator.com/", "CreatorPDFMakerService");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("http://impl.services.core.xtbg.chinacreator.com/", "CreatorPDFMakerServiceImplPort"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        if ("CreatorPDFMakerServiceImplPort".equals(portName)) {
            setCreatorPDFMakerServiceImplPortEndpointAddress(address);
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
