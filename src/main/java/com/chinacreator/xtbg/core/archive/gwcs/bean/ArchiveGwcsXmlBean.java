package com.chinacreator.xtbg.core.archive.gwcs.bean;

import java.util.ArrayList;
import java.util.List;
/* 公文所需要素信息  注明为"非空"的字段不能够为空，未注明的可以为空*/
public class ArchiveGwcsXmlBean {
	/* 以下节点的值请过滤对xml文件有影响的非法字符 */
	
	public static class Archiveparameters {
		
		public static class Num{
			/*非空,文号的种类:无,自定义,标准.分别对应0,1,2 */
			private String type;
			/* 非空,可以为 无 或者自定义文号数据 */
			private String prefix;
			/* prefix为 无或者自定义文号时,该节点可以为空。其他情况下不能够为空,请注意年份的括号为 六角 */
			private String symbol;
			/* prefix为 无或者自定义文号时,该节点可以为空。其他情况下不能够为空, 汉字"号"是必须的*/
			private String serial_number;

			public String getType() {
				return type;
			}

			public void setType(String type) {
				this.type = type;
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
			
			
			
		}
		private String title;/* 非空，最大长度为100 */
		private Num num;/* num不能够为空 请注意年份的括号为 六角，汉字"号"是必须的 */
		private String secrecy_grade;/*secrecy_grade公文密级 值只能够为 无,秘密,机密,绝密中的一种  */
		private String effect_date;/* 保密期限  只能够为 无,1年,3年,5年,7年永久*/
		private String urgency_grade;/*urgency_grade紧急程度 值只能够为 无,缓急,平急,加急,特急,特提中的一种  */
		private String caption;/* caption可以不填写 最大长度为100*/
		private String keyword;/* keyword可以不填写 最大长度为100*/
		private String dispatch_type;/* 非空,文种 */
		private String sender;/* send可以不填写 最大长度为50 */
		private String sendscope;/* 发布层次  值只能够为 发至市师级,发市州省直,发市州,发省直单位,发至县团级,发至县级,发至县,发至乡镇,公开发布,特定范围  中的一种*/
		private String create_date;/* 非空, 成文时间，格式如下yyyy-mm-dd */
		private String send_org_name;/* 发文单位机构名称 */
		private String send_org_addr;/* 非空,发文单位20位地址码 */
		private String sendusername;/* 发文操作的用户名称 */
		private String issign;/*非空,是否加盖电子印章 是为true,否为false  */
		private String contact_phone;/* 如果遇到问题，收文用户可以询问公文相关情况的联系方式 */
		private String msg;/* 非空,公文文件初始名称 后缀名也需要*/
		private String unionmsg; /*联合发文通知下一个单位进行联合盖章时，发送的提醒短信内容*/
		private String file_type; /* 非空,公文的类型doc或者ceb */
		private String file_name; /* 非空,公文文件初始名称 后缀名也需要 */
		private List<String> affixnames;/* 附件1的文件名称  附件不能够为jsp,音频和视频文件等 没有附件的可以不填写 */
		
		public String getUnionmsg() {
			return unionmsg;
		}

		public void setUnionmsg(String unionmsg) {
			this.unionmsg = unionmsg;
		}

		/**
		 * <b>Summary: </b>
		 *     获取file_type的值
		 * @return file_type 
		 */
		public String getFile_type() {
			return file_type;
		}

		/** 
		 * <b>Summary: </b>
		 *     设置 file_type 的值 
		 * @param file_type 
		 */
		public void setFile_type(String file_type) {
			this.file_type = file_type;
		}

		/**
		 * <b>Summary: </b>
		 *     获取file_name的值
		 * @return file_name 
		 */
		public String getFile_name() {
			return file_name;
		}

		/** 
		 * <b>Summary: </b>
		 *     设置 file_name 的值 
		 * @param file_name 
		 */
		public void setFile_name(String file_name) {
			this.file_name = file_name;
		}

		public String getTitle() {
			return title;
		}

		public void setTitle(String title) {
			this.title = title;
		}

		public Num getNum() {
			return num;
		}

		public void setNum(Num num) {
			this.num = num;
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

		public String getMsg() {
			return msg;
		}

		public void setMsg(String msg) {
			this.msg = msg;
		}

		public List<String> getAffixnames() {
			return affixnames;
		}

		public void setAffixnames(List<String> affixnames) {
			this.affixnames = affixnames;
		}
		
		
		
	}
	

		/* 一个addrinfor表示一个收文单位的相关信息，多个收文单位的话就对应对多个addrinfor，每一个节点的值都不能够为空 */
		public static class Addrinfor{
			/*receiveraddr表示收文单位的20位地址码，请确保为20位的数字 */
			private String receiveraddr;
			/*receivername 收文单位机构名称  */
			private String receivername;
			/* print_num收文单位允许打印公文的份数 份数为大于0的整数，最大值为999999 */
			private String print_num;
			/* num份号值可以为0 或者 xxx-xxx x表示数字 */
			private String num;
			/* send_type该单位是主送还是抄送，如果是主送为小写的m,抄送为小写的c */
			private String send_type;
			public String getReceiveraddr() {
				return receiveraddr;
			}
			public void setReceiveraddr(String receiveraddr) {
				this.receiveraddr = receiveraddr;
			}
			public String getReceivername() {
				return receivername;
			}
			public void setReceivername(String receivername) {
				this.receivername = receivername;
			}
			public String getPrint_num() {
				return print_num;
			}
			public void setPrint_num(String print_num) {
				this.print_num = print_num;
			}
			public String getNum() {
				return num;
			}
			public void setNum(String num) {
				this.num = num;
			}
			public String getSend_type() {
				return send_type;
			}
			public void setSend_type(String send_type) {
				this.send_type = send_type;
			}
			
			
		}

	
	private Archiveparameters archiveparameters = new Archiveparameters();
	private List<Addrinfor> receivedeptinfor = new ArrayList<Addrinfor>();
	public Archiveparameters getArchiveparameters() {
		return archiveparameters;
	}
	public void setArchiveparameters(Archiveparameters archiveparameters) {
		this.archiveparameters = archiveparameters;
	}
	public List<Addrinfor> getReceivedeptinfor() {
		return receivedeptinfor;
	}
	public void setReceivedeptinfor(List<Addrinfor> receivedeptinfor) {
		this.receivedeptinfor = receivedeptinfor;
	}
	
	
	/*定义联合盖章单位参与盖章的顺序*/
	public static class Sign{
		/* 盖章单位的地址码*/
		private String orgaddr;
		/* 盖章顺序，从1开始*/
		private String signorder;
		//盖章单位名称
		private String orgname;
		
		public String getOrgname() {
			return orgname;
		}
		public void setOrgname(String orgname) {
			this.orgname = orgname;
		}
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
	}
	
	private List<Sign> signs = new ArrayList<Sign>();
	public List<Sign> getSigns() {
		return signs;
	}
	public void setSigns(List<Sign> signs) {
		this.signs = signs;
	}	
	
	
}
