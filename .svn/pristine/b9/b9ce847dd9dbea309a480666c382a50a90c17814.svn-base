package com.chinacreator.xtbg.core.archive.gwcs.bean;

import java.util.ArrayList;
import java.util.List;

public class Union {
	
	public static class Sign{
		private String orgaddr;// 参与盖章的单位地址码
		private String signorder;// 盖章顺序，主办方默认为第一位 
		private String issigned;// 是否完成盖章操作默认为 0 表示未完成盖章 1 表示完成盖章
		private String terminate;// 该单位是否终止联合盖章 0 表示未终止 1 表示终止
		private String isstamping;// 盖章流程标识默认为0表示未到此单位，1 表示已到此单位 
		private String stampdate;//  盖章或者终止的时间
		public String getOrgaddr() {
			return orgaddr;
		}
		public void setOrgaddr(String orgaddr) {
			this.orgaddr = orgaddr;
		}
		public String getSignorder() {
			return signorder;
		}
		public void setSignorder(String signorder) {
			this.signorder = signorder;
		}
		public String getIssigned() {
			return issigned;
		}
		public void setIssigned(String issigned) {
			this.issigned = issigned;
		}
		public String getTerminate() {
			return terminate;
		}
		public void setTerminate(String terminate) {
			this.terminate = terminate;
		}
		public String getIsstamping() {
			return isstamping;
		}
		public void setIsstamping(String isstamping) {
			this.isstamping = isstamping;
		}
		public String getStampdate() {
			return stampdate;
		}
		public void setStampdate(String stampdate) {
			this.stampdate = stampdate;
		}
	}
	
	private List<Sign> signs = new ArrayList<Sign>();

	public List<Sign> getSigns() {
		return signs;
	}

	public void setSigns(List<Sign> signs) {
		this.signs = signs;
	}
}
