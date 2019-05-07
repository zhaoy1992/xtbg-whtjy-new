
<%@page import="com.chinacreator.xtbg.core.vote.entity.VotePaperBean"%>
<%@page import="com.chinacreator.xtbg.core.vote.entity.VoteQuestionBean"%>
<%@page import="com.chinacreator.xtbg.core.vote.entity.VoteOptionBean"%>
<%@page import="com.chinacreator.xtbg.core.vote.entity.VoteQuestionAnswerBean"%>
<%@page import="com.chinacreator.xtbg.core.vote.entity.VoteEvalUserBean"%>
<%@page import="com.chinacreator.xtbg.core.vote.service.VoteViewService"%>
<%@page import="com.chinacreator.xtbg.core.vote.service.impl.VoteViewServiceImpl"%>

<%@ page import="jxl.write.Label"%>
<%@ page import="jxl.format.Alignment"%>
<%@ page import="jxl.write.WritableCellFormat"%>
<%@ page import="jxl.write.WritableFont"%>
<%@ page import="jxl.write.WritableSheet"%>
<%@ page import="jxl.Workbook"%>
<%@ page import="jxl.write.WritableWorkbook"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@page import="java.net.URLDecoder"%>
<%@ page import="com.chinacreator.eform.util.Escape"%>
<%@ page import="com.alibaba.fastjson.JSONObject"%>
<%@ page import="java.util.Date"%>
<%@ page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@ page import="org.apache.commons.configuration.PropertiesConfiguration"%>
<%@ page import="org.apache.poi.poifs.filesystem.DocumentEntry"%>
<%@ page import="org.apache.poi.poifs.filesystem.DirectoryEntry"%>

<%@ page import="org.apache.poi.poifs.filesystem.POIFSFileSystem"%>
<%@ page import="java.io.FileOutputStream"%>
<%@ page import="java.io.ByteArrayInputStream"%>
<%@ page import="com.frameworkset.common.poolman.PreparedDBUtil"%>
<%@page import="java.io.File"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.OutputStream"%>

<%@ page language="java" contentType="application/octet-stream; charset=gbk"%>


<%--  ����ͨѶ¼excel����
������ϵͳ�ļ�����ҳ��
���ߣ�steven.zhu
�汾��1.0
���ڣ�2011-7-11
--%>
<%!
public static String toUtf8String(String s) {
	StringBuffer sb = new StringBuffer();
	for (int i=0;i<s.length();i++) {
		char c = s.charAt(i);
		if (c >= 0 && c <= 255) {
			sb.append(c);
		} else {
			byte[] b;
			try {
				b = Character.toString(c).getBytes("utf-8");
			} catch (Exception ex) {		
				b = new byte[0];
			}
			for (int j = 0; j < b.length; j++) {
				int k = b[j];
				if (k < 0) k += 256;
				sb.append("%" + Integer.toHexString(k).toUpperCase());
			}
		}
	}
	return sb.toString();
}

public static String toChinese(String strvalue)
{
         try{
             if(strvalue == null)
                return null;
             else
             {
                strvalue = new String(strvalue.getBytes("GBK"), "ISO8859_1");
                return strvalue;
         }
         }catch(Exception e){
               return null;
         }
}

%>
<%
	String paperId = request.getParameter("paperId");//�ʾ�ID
	VotePaperBean votePaperBean = new VotePaperBean();
	VoteViewService voteViewService = new VoteViewServiceImpl();
	votePaperBean = voteViewService.getEvalPaperTotalInfo(paperId);
	Map<VoteEvalUserBean,List<VoteQuestionAnswerBean>> voteEvalUserList= voteViewService.getVoteUserCountList(paperId);
	//String fileName = votePaperBean.getTitle()+".xls";
	String filename= URLDecoder.decode(votePaperBean.getTitle()+".xls", "GBK");
	//��Ĭ���ַ���������ַ�����
	byte[] bs = filename.getBytes();
	filename = new String(bs, "ISO-8859-1");
	
	List<VoteQuestionBean> voteQuestionBeanList = votePaperBean.getVoteQuestionBeanList();
	response.reset();
    
	OutputStream output = null;
	FileInputStream fis = null;
	InputStream obis = null;
	ByteArrayInputStream bais = null;
    FileOutputStream fos = null;
    String path = request.getContextPath();//LoadPropertiesUtil.getInstance().getPropertiesValue("config/oacommon.properties","towordtemppath");  //����ʵ�����д·��
    File file = new File(path+"excel.xls");
   
	try {
		 if(!file.exists()){
		        file.createNewFile();
		    }
			    fos = new FileOutputStream(path+"excel.xls");
			    output = response.getOutputStream();
				response.setContentType("application/octet-stream;charset=gb2312");
				response.addHeader("Content-disposition", "attachment; filename="+filename);
          
				WritableWorkbook wwk = Workbook.createWorkbook(fos);
				WritableSheet ws = wwk.createSheet("��Ա����ͳ��", 0);
				WritableFont wf = new WritableFont(WritableFont.ARIAL, 14, WritableFont.BOLD);
				WritableCellFormat wcf = new WritableCellFormat(wf);
				wcf.setAlignment(Alignment.CENTRE);

				ws.mergeCells(0,0,0,1); 
				ws.mergeCells(1,0,1,1); 
				Label lab1 = new Label(0, 0, "���",wcf);
				Label lab2 = new Label(1, 0, "����",wcf);
				ws.addCell(lab1);
				ws.addCell(lab2);
				//���ɱ�ͷ
				int colno =2; //cell�ϲ���ʼ
				for(int i=0; i<voteQuestionBeanList.size(); i++){
					VoteQuestionBean voteQuestionBean = voteQuestionBeanList.get(i);
					ws.mergeCells(colno,0,colno+voteQuestionBean.getVoteOptionBeanList().size()-1,0); 
					Label labs = new Label(colno, 0, voteQuestionBean.getTitle(),wcf);
					ws.addCell(labs);
					for(int j=0; j<voteQuestionBean.getVoteOptionBeanList().size(); j++){
						VoteOptionBean VoteOptionBean = voteQuestionBean.getVoteOptionBeanList().get(j);
						Label labss = new Label(colno+j, 1, VoteOptionBean.getOption_code(),wcf);
						ws.addCell(labss);
						
					}
					colno= colno+voteQuestionBean.getVoteOptionBeanList().size();
				} 
				//��������
				String countAnswer = "0";
				int rownum=2;//���嵱ǰ��
				for(VoteEvalUserBean voteEvalUserBean:voteEvalUserList.keySet()){
					List<VoteQuestionAnswerBean> voteQuestionAnswerList = voteEvalUserList.get(voteEvalUserBean);//��ȡ���е�KEY���������û�MAP<'ѡ��ID','ͳ����'>
					Label labs= new Label(0, rownum, (rownum-1)+"",wcf);//���������
					Label labs1= new Label(1, rownum, voteEvalUserBean.getUser_name(),wcf);//����������
					int colnum=2; //���嵱ǰ��
					for(int i=0; i<voteQuestionBeanList.size(); i++){
						VoteQuestionBean voteQuestionBean = voteQuestionBeanList.get(i);
						for(int j=0; j<voteQuestionBean.getVoteOptionBeanList().size(); j++){
							VoteOptionBean voteOptionBean = voteQuestionBean.getVoteOptionBeanList().get(j);
							for(VoteQuestionAnswerBean answerBean:voteQuestionAnswerList){
								if(voteOptionBean.getId().equals(answerBean.getSelectid())){//����ǵ�ǰѡ���ID
									countAnswer = answerBean.getAnswerCount();
								}
							}
							Label labss = new Label(colnum, rownum, countAnswer,wcf);
							ws.addCell(labss);
							colnum++;
							countAnswer= "0";
						}
					} 
					ws.addCell(labs);
					ws.addCell(labs1);
					rownum++;
				}
				
				wwk.write();
				wwk.close();
				fos.flush();
				fos.close();
 
            obis = (InputStream)(new FileInputStream(path+"excel.xls"));
             
            byte[] b = new byte[1024];
 			int i = 0;
 			while ((i = obis.read(b)) > 0) {
 				output.write(b, 0, i);
 			}
 		
	 		output.flush();
	 		out.clear();
	 		out = pageContext.pushBody();
             
            // bais.close();
             //fos.close();
	} catch (Exception e) {
	    e.printStackTrace();
	} finally {
		if(file.exists()){    
			file.delete(); 
		}
		if (fis != null) {
			fis.close();
			fis = null;
		}
		if(obis != null) {
			obis.close();
			obis = null;
		}
		if (output != null) {
			output.close();
			output = null;
		}
	}
%>
