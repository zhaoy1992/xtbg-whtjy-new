package com.chinacreator.xtbg.pub.oagwcs.entity;

/**
 *<p>Title:</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南科创</p>
 *@author yiping.huang
 *@version 1.0
 *@date 2012-7-4
 */
public class GwreceiveBean {

	private String gwreceive_id;//主键id
	private String title;//公文标题
	private String prefix;//文号前缀
	private String symbol;//文号年份
	private String serial_number;//文号
	private String secrecy_grade;//公文密级
	private String effect_date;//保密期限
	private String urgency_grade;//紧急程度
	private String caption;//主题词
	private String keyword;//关键字
	private String dispatch_type;//文种
	private String sender;//签发人
	private String sendscope;//发布层次
	private String create_date;//成文时间
	private String send_date;//公文发送时间
	private String send_org_name;//发文单位机构名称
	private String send_org_addr;//发文单位20位地址码
	private String sendusername;//发文操作的用户名称
	private String issign;//是否加盖电子印章
	private String contact_phone;//询问公文相关问题的联系方式
	private String recv_org_name;//收文单位机构名称
	private String recv_org_addr;//收文单位的20位地址码
	private String file_name;//公文文件名称
	private String is_accept;//是否已受理
	private String attach_id;//附件
	private String wordcontent_id;//word内容
	
	public String getWordcontent_id() {
		return wordcontent_id;
	}
	public void setWordcontent_id(String wordcontent_id) {
		this.wordcontent_id = wordcontent_id;
	}
	public String getGwreceive_id() {
		return gwreceive_id;
	}
	public void setGwreceive_id(String gwreceive_id) {
		this.gwreceive_id = gwreceive_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
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
	public void setSerial_number(String serial_number) {
		this.serial_number = serial_number;
	}
	public String getSecrecy_grade() {
		return secrecy_grade;
	}
	public void setSecrecy_grade(String secrecy_grade) {
		this.secrecy_grade = secrecy_grade;
	}
	public String getEffect_date() {
		return effect_date;
	}
	public void setEffect_date(String effect_date) {
		this.effect_date = effect_date;
	}
	public String getUrgency_grade() {
		return urgency_grade;
	}
	public void setUrgency_grade(String urgency_grade) {
		this.urgency_grade = urgency_grade;
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
	public void setDispatch_type(String dispatch_type) {
		this.dispatch_type = dispatch_type;
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
	public void setCreate_date(String create_date) {
		this.create_date = create_date;
	}
	public String getSend_date() {
		return send_date;
	}
	public void setSend_date(String send_date) {
		this.send_date = send_date;
	}
	public String getSend_org_name() {
		return send_org_name;
	}
	public void setSend_org_name(String send_org_name) {
		this.send_org_name = send_org_name;
	}
	public String getSend_org_addr() {
		return send_org_addr;
	}
	public void setSend_org_addr(String send_org_addr) {
		this.send_org_addr = send_org_addr;
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
	public void setContact_phone(String contact_phone) {
		this.contact_phone = contact_phone;
	}
	public String getRecv_org_name() {
		return recv_org_name;
	}
	public void setRecv_org_name(String recv_org_name) {
		this.recv_org_name = recv_org_name;
	}
	public String getRecv_org_addr() {
		return recv_org_addr;
	}
	public void setRecv_org_addr(String recv_org_addr) {
		this.recv_org_addr = recv_org_addr;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	public String getIs_accept() {
		return is_accept;
	}
	public void setIs_accept(String is_accept) {
		this.is_accept = is_accept;
	}
	public String getAttach_id() {
		return attach_id;
	}
	public void setAttach_id(String attach_id) {
		this.attach_id = attach_id;
	}
	
	
}
