/**
 * ISmsOperatorInter.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.chinacreator.xtbg.pub.ema6;

public interface ISmsOperatorInter extends java.rmi.Remote {
    public com.chinacreator.xtbg.pub.ema6.MoMessageRes getSms(java.lang.String arg0, java.lang.String arg1) throws java.rmi.RemoteException;
    public com.chinacreator.xtbg.pub.ema6.ReportMessageRes getReport(java.lang.String arg0, java.lang.String arg1) throws java.rmi.RemoteException;
    public com.chinacreator.xtbg.pub.ema6.MtMessageRes sendSms(java.lang.String arg0, java.lang.String arg1, java.lang.String arg2, java.lang.String arg3, com.chinacreator.xtbg.pub.ema6.MtMessage arg4) throws java.rmi.RemoteException;
    public com.chinacreator.xtbg.pub.ema6.BalanceRes getBalance(java.lang.String arg0, java.lang.String arg1, java.lang.String arg2) throws java.rmi.RemoteException;
    public com.chinacreator.xtbg.pub.ema6.MtMessageRes bathSendSms(java.lang.String arg0, java.lang.String arg1, java.lang.String arg2, java.lang.String arg3, com.chinacreator.xtbg.pub.ema6.MtMessage[] arg4) throws java.rmi.RemoteException;
}
