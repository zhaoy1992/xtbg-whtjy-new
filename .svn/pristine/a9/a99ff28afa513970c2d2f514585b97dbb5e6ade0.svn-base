package com.chinacreator.xtbg.core.word;

import java.util.HashMap;

import com.chinacreator.xtbg.core.common.util.Jacob;

public class TestJacob {

	/**
	 *<b>Summary: </b>
	 * main(请用一句话描述这个方法的作用)
	 * @param args 
	 */
	public static void main(String[] args) {
		String templateid = "th55c86ca4-02ee-45f8-8a07-a86748ebe6bf";
		String contentPath = "D:\\WorkSpace\\xtbgbase\\creatorepp";
		String  inputPath = contentPath+"\\ccapp\\wordtemplate\\"+ templateid+".doc";  
		String  outputPath = contentPath+"\\ccapp\\wordtemplate\\1212.doc";
		try {
			Jacob jacob = new Jacob(false);
			jacob.openDocument(outputPath);
			jacob.replaceLabelValue("year_1","2013");
			jacob.replaceLabelValue("year_2","2013");
			jacob.replaceLabelValue("month_1","12");
			jacob.replaceLabelValue("month_2","12");
			jacob.close();
			System.out.println(jacob.findLabel("year"));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		HashMap params = new HashMap();
		params.put("year", "2013");
		params.put("month", "12");
		params.put("day", "24");
		params.put("cartype", "广本");
		params.put("carnumber", "湘A C0329");
		params.put("content", "1、更换机油保养");
		
		
		//jacob.toWord(inputPath,outputPath,params);

	
	}

}
