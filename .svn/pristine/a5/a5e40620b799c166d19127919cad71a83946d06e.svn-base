package com.chinacreator.xtbg.pub.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.transaction.RollbackException;

import com.frameworkset.common.poolman.PreparedDBUtil;
import com.frameworkset.orm.transaction.TransactionManager;

public class MD5Util {
	/**
	 * Md5加密
	 * String pwString = MainMD5.MD5Encoder("刘兴123456", "utf-8").toUpperCase();
	 * @param s
	 * @param charset
	 * @return
	 */
	public final static String MD5Encoder(String s, String charset) {
        try {
            byte[] btInput = s.getBytes(charset);
            MessageDigest mdInst = MessageDigest.getInstance("MD5");
            mdInst.update(btInput);
            byte[] md = mdInst.digest();
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < md.length; i++) {
                int val = ((int) md[i]) & 0xff;
                if (val < 16){
                	sb.append("0");
                }
                sb.append(Integer.toHexString(val));
            }
            return sb.toString();
        } catch (Exception e) {
            return null;
        }
    }
	
	/**
	*<b>Summary: </b>
	* MD5(用MD5加密，32位)
	* @param s
	* @return
	* @throws NoSuchAlgorithmException
	 */
	public final static String MD5(String s) throws NoSuchAlgorithmException {
		String result = "";
		char hexDigits[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
				'a', 'b', 'c', 'd', 'e', 'f' };
			byte[] strTemp = s.getBytes();
			MessageDigest mdTemp = MessageDigest.getInstance("MD5");
			mdTemp.update(strTemp);
			byte[] md = mdTemp.digest();
			int j = md.length;
			char str[] = new char[j * 2];
			int k = 0;
			for (int i = 0; i < j; i++) {
				byte b = md[i];
				str[k++] = hexDigits[b >> 4 & 0xf];
				str[k++] = hexDigits[b & 0xf];
			}
			result = new String(str);
		return result;
	}
	/**
	*<b>Summary: </b>
	* MD5(用MD5加密，32位 大写)
	* @param s
	* @return
	* @throws NoSuchAlgorithmException
	 */
	public final static String MD5UpperCase(String s) throws NoSuchAlgorithmException {
		String result = "";
		char hexDigits[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
				'a', 'b', 'c', 'd', 'e', 'f' };
			byte[] strTemp = s.getBytes();
			MessageDigest mdTemp = MessageDigest.getInstance("MD5");
			mdTemp.update(strTemp);
			byte[] md = mdTemp.digest();
			int j = md.length;
			char str[] = new char[j * 2];
			int k = 0;
			for (int i = 0; i < j; i++) {
				byte b = md[i];
				str[k++] = hexDigits[b >> 4 & 0xf];
				str[k++] = hexDigits[b & 0xf];
			}
			result = new String(str);
		return result.toUpperCase();
	}
	public static void main(String args[]){
		 List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		try {
//			list = queryUserPassword();
//			for (int i = 0; i < list.size(); i++) {
//				System.out.println("userid : "+list.get(i).get("userid")+"     ;password :"+list.get(i).get("password"));
//			}
			String authid = MD5Util.MD5("123456aaa");
			System.out.println("authid ===="+authid.toUpperCase());
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* queryUserPassword(查询所有用户的密码)  add  by   jia.tong  2013-09-27
	* @return
	 */
	public List<Map<String,String>> queryUserPassword(){
		PreparedDBUtil pdb = new PreparedDBUtil();
	    StringBuffer sql = new StringBuffer();
	    sql.append(" select u.user_password,u.user_id from td_sm_user u ");
	    sql.append(" where 1 = 1");
	    List<Map<String, String>> list = new ArrayList<Map<String, String>>();
	    try {
			pdb.preparedSelect(sql.toString());
			 pdb.executePrepared();
			 for (int i = 0; i < pdb.size(); i++) {
				    Map<String, String> userMap = new HashMap<String, String>();
				    String userid = pdb.getString(i,"user_id");
					String password= pdb.getString(i, "user_password");
					userMap.put("userid", userid);
					userMap.put("password", password);
					list.add(userMap);
				}
		} catch (Exception e) {
			e.printStackTrace();
		}
	   
		return list;
	}
	/**
	 * 
	*<b>Summary: </b>
	* updateUserPassword(更新用户密码) add  by   jia.tong  2013-09-27
	* @param userid
	* @param password
	* @return
	 */
	public boolean updateUserPassword(String userid,String password){
		PreparedDBUtil pdb = new PreparedDBUtil();
	    StringBuffer sql = new StringBuffer();
	    sql.append(" update td_sm_user u set u.user_password = '"+password+"'");
	    sql.append(" where u.user_id = '"+userid+"'");
	    try {
			pdb.preparedUpdate(sql.toString());
			pdb.executePrepared();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;
		
	}
	/**
	 * 
	*<b>Summary: </b>
	* updateUserPasswordAll(批量修改：用于将用户密码修改为MD5加密形式) add  by   jia.tong  2013-09-27
	* @return
	 */
	public boolean updateUserPasswordAll(){
		MD5Util  md5Util = new MD5Util();
		List<Map<String,String>>  list = new ArrayList<Map<String,String>>();
		list = md5Util.queryUserPassword();
		TransactionManager tm = new TransactionManager();
		boolean  falg = true;
		try {
			tm.begin();
			for(int i = 0 ; i < list.size() ; i++){
				Map<String,String> userMap = new HashMap<String,String>();
				userMap = list.get(i);
				String userid = userMap.get("userid");
				String password = userMap.get("password");
				password = md5Util.MD5(password).toUpperCase();
				md5Util.updateUserPassword(userid, password);
			}
			tm.commit();
			falg = true;
		} catch (Exception e) {
			e.printStackTrace();
			try {
				tm.rollback();
			} catch (RollbackException e1) {
				e1.printStackTrace();
			}
			falg = false;
		}
		return falg;
	}
}
