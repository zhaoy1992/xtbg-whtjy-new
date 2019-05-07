package com.chinacreator.xtbg.pub.util;

import java.util.ArrayList;
import java.util.List;

/**
 * 字符串分割工具
 * @author weiwei.liu
 * @date 2012-11-16
 */
public class StringSplitUtil {
	//找出letter在str中出现num次时的索引值
    public static int findNumber (String str,String letter,int num){
         int i = 0;
         int m = 0;
         char c = new String(letter).charAt(0);
         char [] ch = str.toCharArray();
         for(int j=0; j<ch.length; j++){
             if(ch[j] == c){
                 i++;
                 if(i == num){
                     m = j;
                     break;
                 }
             }
         }
         return m;
     }
    //得到letter在str中出现的总次数
    public static int findTotalNum(String str,String letter){
        int i = 0;
        char c = new String(letter).charAt(0);
        char [] ch = str.toCharArray();
        for(int j=0; j<ch.length; j++){
            if(ch[j] == c){
                i++;
            }
        }
        return i;
    }
    /**
     * 
     * @param str 传入的原始字符串
     * @param letter 用来分割的字符
     * @param num 指定分割频率（出现多少个letter分割一次）
     * @return list 
     */
    public static List<String> stringSplit(String str,String letter, int num){
    	List<String> list=new ArrayList<String>();
    	int toTal= StringSplitUtil.findTotalNum(str, letter);
    	String stringSplit="";
		//m是将把字符串分割的次数
		int m=0;
		//如果，号出现的总次数大于指定次数num
		if(toTal>num){
			//取整数m
			m=(int) Math.floor(toTal/num);
			//beginIndex是截取字符串的开始索引
			int beginIndex=0;
			for (int j = 0; j < m; j++) {
				//endIndex是截取字符串的结束索引
				int endIndex= StringSplitUtil.findNumber(str, ",", num*(j+1));
				//stringSplit是得到的被分割的字符串
				stringSplit= str.substring(beginIndex, endIndex);
				//将多个stringSplit加入list
				list.add(stringSplit);
				//更新下次
				beginIndex=endIndex+1;
			}
			stringSplit=str.substring(beginIndex,str.length());
			list.add(stringSplit);
		}
		return list;
    }
    
	/**
	 * 
	*<b>Summary: </b>
	* isHave(此方法有两个参数，第一个是要查找的字符串数组，第二个是要查找的字符或字符串   )
	* @param strs
	* @param s
	* @return
	 */
	 public static boolean isHave(String[] strs,String s){ 
		 if(strs == null)
			 return false;
		 for(int i=0;i<strs.length;i++){ 
			 if(strs[i].indexOf(s)!=-1){//循环查找字符串数组中的每个字符串中是否包含所有查找的内容    
				 return true;//查找到了就返回真，不在继续查询   
			}  
		 }  
		return false;//没找到返回false 
	}
	 /**
	  * 
	 *<b>Summary: 改变拼接字符串的顺序</b>
	 * @param str
	 * @param splitStr
	 * @return
	  */
	 public static String changeSplitStrOrder(String str,String splitStr){
		 String resultStr = "";
		 if(StringUtil.nullOrBlank(splitStr)){
			 splitStr = ",";
		 }
		 String[] strArry = str.split(splitStr);
		 
		 for(int i = strArry.length -1 ; i >= 0 ; i --){
			 resultStr += strArry[i];
			 if(i > 0){
				 resultStr += splitStr;
			 }
		 }
		 return resultStr;
	 }
}
