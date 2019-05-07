package com.chinacreator.xtbg.core.archive.gwcs.bean;

import java.util.List;

/**
 * 
 *<p>Title:ReceiveGwcsXmlBean.java</p>
 *<p>Description:<!-- 公文落地要素信息  注明为"非空"的字段不能够为空，未注明的可以为空--></p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 夏天
 *@version 1.0
 *Aug 9, 2013
 */
public class ReceiveGwcsXmlBean {
	
	
	/*<!-- num不能够为空 请注意年份的括号为 六角，汉字"号"是必须的 -->*/
	public static class Num {
		/*<!-- 非空,可以为 无 或者自定义文号数据 -->*/
		private String prefix;
		/*<!-- prefix为 无或者自定义文号时,该节点可以为空。其他情况下不能够为空,请注意年份的括号为 六角 -->*/
		private String symbol;
		/*<!-- prefix为 无或者自定义文号时,该节点可以为空。其他情况下不能够为空, 汉字"号"是必须的-->*/
		private String serial_number;
		public String getPrefix() {
			return prefix;
		}
		public void setPrefix(String prefix) {
			this.prefix = prefix;
		}
		public String getSymbol() {
			return symbol;
		}
		public void setSymbol(String symbol) {
			this.symbol = symbol;
		}
		public String getSerial_number() {
			return serial_number;
		}
		public void setSerial_number(String serialNumber) {
			serial_number = serialNumber;
		}
	}
	
	private Num num;
	/*<!-- 非空 ，最大长度为100 -->*/
	private String title;
	/*<!--secrecy_grade公文密级 值只能够为 无,秘密,机密,绝密中的一种  -->*/
	private String secrecy_grade;
	/*<!-- 保密期限  只能够为 无,1年,3年,5年,7年,永久-->*/
	private String effect_date;
	/*<!--urgency_grade紧急程度 值只能够为 无,缓急,平急,加急,特急,特提中的一种  -->*/
	private String urgency_grade;
	/*<!-- caption可以不填写 最大长度为100-->*/
	private String caption;
	/*<!-- keyword可以不填写 最大长度为100-->*/
	private String keyword;
	/*<!--非空, 文种 -->*/
	private String dispatch_type;
	/*<!-- send可以不填写 最大长度为50 -->*/
	private String sender;
	/*<!-- 发布层次  值为 发至市师级,发市州省直,发市州,发省直单位,发至县团级,发至县级,发至县,发至乡镇,公开发布,特定范围  中的一种-->*/
	private String sendscope;
	/*<!-- 非空,成文时间，格式如下yyyy-mm-dd -->*/
	private String create_date;
	/*<!-- 非空,公文发送时间 -->*/
	private String send_date;
	/*<!-- 发文单位机构名称 -->*/
	private String send_org_name;
	/*<!-- 发文单位20位地址码 -->*/
	private String send_org_addr;
	/*<!-- 发文操作的用户名称 -->*/
	private String sendusername;
	/*<!--非空,是否加盖电子印章 是为true,否为false  -->*/
	private String issign;
	/*<!-- 如果遇到问题，收文用户可以询问公文相关情况的联系方式 -->*/
	private String contact_phone;
	/*<!-- 收文单位机构名称  -->*/
	private String recv_org_name;
	/*<!--非空,recv_org_addr表示收文单位的20位地址码，20位的数字 -->*/
	private String recv_org_addr;
	/*<!-- 非空,公文文件名称 后缀为.ceb-->*/
	private String file_name;
	/*<!-- 附件的文件名称集合  附件不能够为jsp,音频和视频文件等 没有附件的不填写 -->*/
	private List<String> affixnames;
	public Num getNum() {
		return num;
	}
	public void setNum(Num num) {
		this.num = num;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getSecrecy_grade() {
		return secrecy_grade;
	}
	public void setSecrecy_grade(String secrecyGrade) {
		secrecy_grade = secrecyGrade;
	}
	public String getEffect_date() {
		return effect_date;
	}
	public void setEffect_date(String effectDate) {
		effect_date = effectDate;
	}
	public String getUrgency_grade() {
		return urgency_grade;
	}
	public void setUrgency_grade(String urgencyGrade) {
		urgency_grade = urgencyGrade;
	}
	public String getCaption() {
		return caption;
	}
	public void setCaption(String caption) {
		this.caption = caption;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getDispatch_type() {
		return dispatch_type;
	}
	public void setDispatch_type(String dispatchType) {
		dispatch_type = dispatchType;
	}
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
	}
	public String getSendscope() {
		return sendscope;
	}
	public void setSendscope(String sendscope) {
		this.sendscope = sendscope;
	}
	public String getCreate_date() {
		return create_date;
	}
	public void setCreate_date(String createDate) {
		create_date = createDate;
	}
	public String getSend_date() {
		return send_date;
	}
	public void setSend_date(String sendDate) {
		send_date = sendDate;
	}
	public String getSend_org_name() {
		return send_org_name;
	}
	public void setSend_org_name(String sendOrgName) {
		send_org_name = sendOrgName;
	}
	public String getSend_org_addr() {
		return send_org_addr;
	}
	public void setSend_org_addr(String sendOrgAddr) {
		send_org_addr = sendOrgAddr;
	}
	public String getSendusername() {
		return sendusername;
	}
	public void setSendusername(String sendusername) {
		this.sendusername = sendusername;
	}
	public String getIssign() {
		return issign;
	}
	public void setIssign(String issign) {
		this.issign = issign;
	}
	public String getContact_phone() {
		return contact_phone;
	}
	public void setContact_phone(String contactPhone) {
		contact_phone = contactPhone;
	}
	public String getRecv_org_name() {
		return recv_org_name;
	}
	public void setRecv_org_name(String recvOrgName) {
		recv_org_name = recvOrgName;
	}
	public String getRecv_org_addr() {
		return recv_org_addr;
	}
	public void setRecv_org_addr(String recvOrgAddr) {
		recv_org_addr = recvOrgAddr;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String fileName) {
		file_name = fileName;
	}
	public List<String> getAffixnames() {
		return affixnames;
	}
	public void setAffixnames(List<String> affixnames) {
		this.affixnames = affixnames;
	}
	
	
}
