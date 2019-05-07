package com.chinacreator.xtbg.pub.sms.entity;

import java.util.Map;

public class SmsCommonBean {

		private String tel;//电话号码
		
		private String classNameId;//dao层配置名称
		
		private String content;//短信内容
		
		private String sendName;//发送者名字
		
		private String sendNameId;//发送者id
		
		private String receiveName;//接收者名字
		
		private String receiveNameId;//接收者id
		
		private String isSend;//是否发送
		
		public String getIsSend() {
			return isSend;
		}

		public void setIsSend(String isSend) {
			this.isSend = isSend;
		}

		public String getSendNameId() {
			return sendNameId;
		}

		public void setSendNameId(String sendNameId) {
			this.sendNameId = sendNameId;
		}

		public String getReceiveName() {
			return receiveName;
		}

		public void setReceiveName(String receiveName) {
			this.receiveName = receiveName;
		}

		public String getReceiveNameId() {
			return receiveNameId;
		}

		public void setReceiveNameId(String receiveNameId) {
			this.receiveNameId = receiveNameId;
		}

		private Map map;//扩展属性

		public String getTel() {
			return tel;
		}

		public void setTel(String tel) {
			this.tel = tel;
		}

		public String getClassNameId() {
			return classNameId;
		}

		public void setClassNameId(String classNameId) {
			this.classNameId = classNameId;
		}

		public String getContent() {
			return content;
		}

		public void setContent(String content) {
			this.content = content;
		}

		public String getSendName() {
			return sendName;
		}

		public void setSendName(String sendName) {
			this.sendName = sendName;
		}

		public Map getMap() {
			return map;
		}

		public void setMap(Map map) {
			this.map = map;
		}
		
		
		
}
