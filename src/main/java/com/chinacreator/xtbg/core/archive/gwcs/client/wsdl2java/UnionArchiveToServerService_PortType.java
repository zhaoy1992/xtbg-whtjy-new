/**
 * UnionArchiveToServerService_PortType.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java;

public interface UnionArchiveToServerService_PortType extends java.rmi.Remote {
    public com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.SendResponseBean doUnionArchiveSend(com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.SendRequestBean arg0) throws java.rmi.RemoteException;
    public com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.UnionArchiveResponseBean callUnionArchiveFeedBack(java.lang.String arg0) throws java.rmi.RemoteException;
    public com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.SendResponseBean callUnionArchiveSend(com.chinacreator.xtbg.core.archive.gwcs.client.wsdl2java.SendRequestBean arg0) throws java.rmi.RemoteException;
}
