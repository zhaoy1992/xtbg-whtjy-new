package com.chinacreator.xtbg.core.openfire;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;

import org.jivesoftware.smack.Chat;
import org.jivesoftware.smack.Connection;
import org.jivesoftware.smack.ConnectionConfiguration;
import org.jivesoftware.smack.MessageListener;
import org.jivesoftware.smack.Roster;
import org.jivesoftware.smack.RosterEntry;
import org.jivesoftware.smack.XMPPConnection;
import org.jivesoftware.smack.XMPPException;
import org.jivesoftware.smack.packet.Message;
  
/** 
 *  
 *  
 * <p> 
 * Description: 示例 业务类 
 * </p> 
 *  
 * <p> 
 * Copyright: Copyright (c) 2012 
 * </p> 
 *  
 *  
 * @author dml@2013-2-21 
 * @version 1.0 
 */  
public class IMServer {  
    private static final String IP = "127.0.0.1";  
    private static final Integer DK = 5222;  
    private static Roster roster;  
  
    /** 
     * 获取连接 
     *  
     * @return connection 
     */  
    public static Connection getConnection() {  
        ConnectionConfiguration config = new ConnectionConfiguration(IP, DK);  
        Connection connection = new XMPPConnection(config);  
        return connection;  
    }  
  
    /** 
     * 发送通知消息 
     *  
     * @param username 
     * @param pass 
     * @param messgage 
     * @param groupName 
     * @throws XMPPException 
     */  
    public void SendBCMsg(String username, String pass, String messgage,  
            String groupName) throws XMPPException {  
        Connection con = IMServer.getConnection();  
        con.connect();  
        con.login(username, pass);  
        Message m = new Message();  
        m.setBody(messgage);// 设置消息。  
        m.setTo(groupName + "@broadcast.xjtu");// [groupname]@[serviceName].[serverName]  
        con.sendPacket(m);  
    }  
  
    /** 
     * 发送即时消息 
     *  
     * @param username 
     * @param pass 
     * @param messgage 
     * @throws XMPPException 
     */  
    public void SendMsg(String username, String pass, String messgage)  
            throws XMPPException {  
        Connection con = IMServer.getConnection();  
        con.connect();  
        con.login(username, pass);  
        Chat mychat = con.getChatManager().createChat("wangbo@172.16.17.104", // 接收端的JID，JID是要加域的  
                null);  
        mychat.sendMessage(messgage); // 发送信息  
        con.disconnect(); // 断开连接  
    }  
    
    public static void main(String[] args) {
    	IMServer server = new  IMServer();
    	try {
			server.SendMsg("zhangsan", "123456", "测试12321消息发送");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
  
    /** 
     * 获取好友列表 
     *  
     * @param username 
     * @param pass 
     * @return 
     * @throws XMPPException 
     */  
    public List<RosterEntry> getRosterList(String username, String pass)  
            throws XMPPException {  
        Connection con = IMServer.getConnection();  
        con.connect();  
        con.login(username, pass);  
        Collection<RosterEntry> rosters = con.getRoster().getEntries();  
        for (RosterEntry rosterEntry : rosters) {  
            System.out.print("name: " + rosterEntry.getName() + ",jid: "  
                    + rosterEntry.getUser()); // 此处可获取用户JID  
            System.out.println("");  
        }  
        return null;  
    }  
  
    /** 
     * 获取用户列表（含组信息） 
     *  
     * @param username 
     * @param pass 
     * @return 
     * @throws XMPPException 
     */  
    public List<RosterEntry> getRoster(String username, String pass)  
            throws XMPPException {  
        Connection con = IMServer.getConnection();  
        con.connect();  
        con.login(username, pass);  
        roster = con.getRoster();  
        List<RosterEntry> EntriesList = new ArrayList<RosterEntry>();  
        Collection<RosterEntry> rosterEntry = roster.getEntries();  
        Iterator<RosterEntry> i = rosterEntry.iterator();  
        while (i.hasNext()) {  
            EntriesList.add(i.next());  
        }  
        return EntriesList;
    }  
  
}  