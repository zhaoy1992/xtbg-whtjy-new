
 /**
 * [Product]
  *     xtbgbase
  * [Copyright]
  *     Copyright © 2013 ICSS All Rights Reserved.
  * [FileName]
  *     OA2ExchangerDataBean.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2013-11-9   Administrator    最初版本
   */
package com.chinacreator.xtbg.core.archive.gwcs.bean;

import java.util.ArrayList;
import java.util.List;

/**
 *<p>Title:OA2ExchangerDataBean.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-11-9
 */
public class OA2ExchangerDataBean {
	private Message Message; //向公文系统发送的数据包消息描述
	private UnitInfo UnitInfo;//公文的发送单位
	private StampInfo StampInfo;//本节点Type = 60 时必须有，Item节点数等于StampNums节点的值
	private SndDstrbtInfo SndDstrbtInfo; //本节点Type = 50或者Type = 60 时必须有
	private DataPack DataPack; //数据包，包括CEB文件，附件和元数据
	private Mac Mac; //数据包，包括CEB文件，附件和元数据

	/**
	 * <b>Summary: </b>
	 *     获取message的值
	 * @return message 
	 */
	public Message getMessage() {
		return Message;
	}

	/** 
	 * <b>Summary: </b>
	 *     设置 message 的值 
	 * @param message 
	 */
	public void setMessage(Message message) {
		Message = message;
	}

	/**
	 * <b>Summary: </b>
	 *     获取unitInfo的值
	 * @return unitInfo 
	 */
	public UnitInfo getUnitInfo() {
		return UnitInfo;
	}

	/** 
	 * <b>Summary: </b>
	 *     设置 unitInfo 的值 
	 * @param unitInfo 
	 */
	public void setUnitInfo(UnitInfo unitInfo) {
		UnitInfo = unitInfo;
	}

	/**
	 * <b>Summary: </b>
	 *     获取stampInfo的值
	 * @return stampInfo 
	 */
	public StampInfo getStampInfo() {
		return StampInfo;
	}

	/** 
	 * <b>Summary: </b>
	 *     设置 stampInfo 的值 
	 * @param stampInfo 
	 */
	public void setStampInfo(StampInfo stampInfo) {
		StampInfo = stampInfo;
	}

	/**
	 * <b>Summary: </b>
	 *     获取sndDstrbtInfo的值
	 * @return sndDstrbtInfo 
	 */
	public SndDstrbtInfo getSndDstrbtInfo() {
		return SndDstrbtInfo;
	}

	/** 
	 * <b>Summary: </b>
	 *     设置 sndDstrbtInfo 的值 
	 * @param sndDstrbtInfo 
	 */
	public void setSndDstrbtInfo(SndDstrbtInfo sndDstrbtInfo) {
		SndDstrbtInfo = sndDstrbtInfo;
	}

	/**
	 * <b>Summary: </b>
	 *     获取dataPack的值
	 * @return dataPack 
	 */
	public DataPack getDataPack() {
		return DataPack;
	}

	/** 
	 * <b>Summary: </b>
	 *     设置 dataPack 的值 
	 * @param dataPack 
	 */
	public void setDataPack(DataPack dataPack) {
		DataPack = dataPack;
	}

	/**
	 * <b>Summary: </b>
	 *     获取mac的值
	 * @return mac 
	 */
	public Mac getMac() {
		return Mac;
	}

	/** 
	 * <b>Summary: </b>
	 *     设置 mac 的值 
	 * @param mac 
	 */
	public void setMac(Mac mac) {
		Mac = mac;
	}

	//向公文系统发送的数据包消息描述
	public static class Message {
		/**
		 * OA登记普通公文：Type = 40
		 * OA登记联合公文：Type = 41
		 * OA签发普通公文：Type = 50 且 StampNums = 0
		 * OA签发联合公文：Type = 50 且 StampNums > 0
		 * OA盖章公文：	 Type = 60
		 */
		private String Type; 
		
		/**
		 * OA登记普通公文：StampNums = 0
		 * OA登记联合公文：StampNums = Unites下的Unit节点数+ 1 
		 * OA签发普通公文：StampNums = 0
		 * OA签发联合公文：StampNums = Unites下的Unit节点数+ 1
		 * OA盖章公文：	StampNums = StampInfo下的Item节点数
		 */
		private String StampNums;

		/**
		 * <b>Summary: </b>
		 *     获取type的值
		 * @return type 
		 */
		public String getType() {
			return Type;
		}

		/** 
		 * <b>Summary: </b>
		 *     设置 type 的值 
		 * @param type 
		 */
		public void setType(String type) {
			Type = type;
		}

		/**
		 * <b>Summary: </b>
		 *     获取stampNums的值
		 * @return stampNums 
		 */
		public String getStampNums() {
			return StampNums;
		}

		/** 
		 * <b>Summary: </b>
		 *     设置 stampNums 的值 
		 * @param stampNums 
		 */
		public void setStampNums(String stampNums) {
			StampNums = stampNums;
		}

		
		
	}
	
	//公文的发送单位
	public static class UnitInfo {
		private List<Unit> Sends;
		private List<Unit> Unites;
		private List<Unit> Receives;
		
		public List<Unit> getUnites() {
			return Unites;
		}

		public void setUnites(List<Unit> unites) {
			Unites = unites;
		}

		public List<Unit> getReceives() {
			return Receives;
		}

		public void setReceives(List<Unit> receives) {
			Receives = receives;
		}

		public List<Unit> getSends() {
			return Sends;
		}

		public void setSends(List<Unit> sends) {
			Sends = sends;
		}

			public static class Unit{
				public Unit(String UnitID, String UnitName, String ProcUUID) {  
			        this.UnitID = UnitID;  
			        this.UnitName = UnitName;  
			        this.ProcUUID = ProcUUID;  
			    }  
				public Unit() {  
			      
			    }  
				private String UnitID;
				private String UnitName;
				private String ProcUUID;
				/**
				 * <b>Summary: </b>
				 *     获取unitID的值
				 * @return unitID 
				 */
				public String getUnitID() {
					return UnitID;
				}
				/** 
				 * <b>Summary: </b>
				 *     设置 unitID 的值 
				 * @param unitID 
				 */
				public void setUnitID(String unitID) {
					UnitID = unitID;
				}
				/**
				 * <b>Summary: </b>
				 *     获取unitName的值
				 * @return unitName 
				 */
				public String getUnitName() {
					return UnitName;
				}
				/** 
				 * <b>Summary: </b>
				 *     设置 unitName 的值 
				 * @param unitName 
				 */
				public void setUnitName(String unitName) {
					UnitName = unitName;
				}
				/**
				 * <b>Summary: </b>
				 *     获取procUUID的值
				 * @return procUUID 
				 */
				public String getProcUUID() {
					return ProcUUID;
				}
				/** 
				 * <b>Summary: </b>
				 *     设置 procUUID 的值 
				 * @param procUUID 
				 */
				public void setProcUUID(String procUUID) {
					ProcUUID = procUUID;
				}
		}
	}
	
	//盖章记录  本节点Type = 60 时必须有，Item节点数等于StampNums节点的值
	public static class StampInfo {
		public ArrayList<Item> Item = new ArrayList<Item>();

		/**
		 * <b>Summary: </b>
		 *     获取item的值
		 * @return item 
		 */
		public ArrayList<Item> getItem() {
			return Item;
		}

		/** 
		 * <b>Summary: </b>
		 *     设置 item 的值 
		 * @param item 
		 */
		public void setItem(ArrayList<Item> item) {
			Item = item;
		}

		//盖章记录
		public static class Item{
			private String StampID;
			private String StampSerial;
			private String StampName;
			private String StampTime;
			private String StampMan;
			/**
			 * <b>Summary: </b>
			 *     获取stampID的值
			 * @return stampID 
			 */
			public String getStampID() {
				return StampID;
			}
			/** 
			 * <b>Summary: </b>
			 *     设置 stampID 的值 
			 * @param stampID 
			 */
			public void setStampID(String stampID) {
				StampID = stampID;
			}
			/**
			 * <b>Summary: </b>
			 *     获取stampSerial的值
			 * @return stampSerial 
			 */
			public String getStampSerial() {
				return StampSerial;
			}
			/** 
			 * <b>Summary: </b>
			 *     设置 stampSerial 的值 
			 * @param stampSerial 
			 */
			public void setStampSerial(String stampSerial) {
				StampSerial = stampSerial;
			}
			/**
			 * <b>Summary: </b>
			 *     获取stampName的值
			 * @return stampName 
			 */
			public String getStampName() {
				return StampName;
			}
			/** 
			 * <b>Summary: </b>
			 *     设置 stampName 的值 
			 * @param stampName 
			 */
			public void setStampName(String stampName) {
				StampName = stampName;
			}
			/**
			 * <b>Summary: </b>
			 *     获取stampTime的值
			 * @return stampTime 
			 */
			public String getStampTime() {
				return StampTime;
			}
			/** 
			 * <b>Summary: </b>
			 *     设置 stampTime 的值 
			 * @param stampTime 
			 */
			public void setStampTime(String stampTime) {
				StampTime = stampTime;
			}
			/**
			 * <b>Summary: </b>
			 *     获取stampMan的值
			 * @return stampMan 
			 */
			public String getStampMan() {
				return StampMan;
			}
			/** 
			 * <b>Summary: </b>
			 *     设置 stampMan 的值 
			 * @param stampMan 
			 */
			public void setStampMan(String stampMan) {
				StampMan = stampMan;
			}
			
		}
	}
	
	public static class PrintInfo {
		
	}
	
	//发文表信息
	public static class SndDstrbtInfo {
		private String bTolNumCtrl; //发文表信息
		private String TotalPrnNum; //是否控制公文总打印份数，表示不控制，表示控制
		private String CreateTime; //创建时间
		
		/**
		 * <b>Summary: </b>
		 *     获取bTolNumCtrl的值
		 * @return bTolNumCtrl 
		 */
		public String getbTolNumCtrl() {
			return bTolNumCtrl;
		}


		/** 
		 * <b>Summary: </b>
		 *     设置 bTolNumCtrl 的值 
		 * @param bTolNumCtrl 
		 */
		public void setbTolNumCtrl(String bTolNumCtrl) {
			this.bTolNumCtrl = bTolNumCtrl;
		}


		/**
		 * <b>Summary: </b>
		 *     获取totalPrnNum的值
		 * @return totalPrnNum 
		 */
		public String getTotalPrnNum() {
			return TotalPrnNum;
		}


		/** 
		 * <b>Summary: </b>
		 *     设置 totalPrnNum 的值 
		 * @param totalPrnNum 
		 */
		public void setTotalPrnNum(String totalPrnNum) {
			TotalPrnNum = totalPrnNum;
		}


		/**
		 * <b>Summary: </b>
		 *     获取createTime的值
		 * @return createTime 
		 */
		public String getCreateTime() {
			return CreateTime;
		}


		/** 
		 * <b>Summary: </b>
		 *     设置 createTime 的值 
		 * @param createTime 
		 */
		public void setCreateTime(String createTime) {
			CreateTime = createTime;
		}


		private DetailXml DetailXml;

		/**
		 * <b>Summary: </b>
		 *     获取detailXml的值
		 * @return detailXml 
		 */
		public DetailXml getDetailXml() {
			return DetailXml;
		}

		/** 
		 * <b>Summary: </b>
		 *     设置 detailXml 的值 
		 * @param detailXml 
		 */
		public void setDetailXml(DetailXml detailXml) {
			DetailXml = detailXml;
		}


		public static class DetailXml{
			private  ArrayList<TemplateMem> Template;

			public ArrayList<TemplateMem> getTemplate() {
				return Template;
			}
			
			public void setTemplate(ArrayList<TemplateMem> template) {
				Template = template;
			}

				//必须保证与Receives节点下的Unit节点数目相等
				public static class TemplateMem{
					private String RecvUnitID;
					private String RecvUnitName;
					private String PrnNums;
					private String StartNum;
					private String version;
					
					public String getVersion() {
						return version;
					}
					public void setVersion(String version) {
						this.version = version;
					}
					/**
					 * <b>Summary: </b>
					 *     获取recvUnitID的值
					 * @return recvUnitID 
					 */
					public String getRecvUnitID() {
						return RecvUnitID;
					}
					/** 
					 * <b>Summary: </b>
					 *     设置 recvUnitID 的值 
					 * @param recvUnitID 
					 */
					public void setRecvUnitID(String recvUnitID) {
						RecvUnitID = recvUnitID;
					}
					/**
					 * <b>Summary: </b>
					 *     获取recvUnitName的值
					 * @return recvUnitName 
					 */
					public String getRecvUnitName() {
						return RecvUnitName;
					}
					/** 
					 * <b>Summary: </b>
					 *     设置 recvUnitName 的值 
					 * @param recvUnitName 
					 */
					public void setRecvUnitName(String recvUnitName) {
						RecvUnitName = recvUnitName;
					}
					/**
					 * <b>Summary: </b>
					 *     获取prnNums的值
					 * @return prnNums 
					 */
					public String getPrnNums() {
						return PrnNums;
					}
					/** 
					 * <b>Summary: </b>
					 *     设置 prnNums 的值 
					 * @param prnNums 
					 */
					public void setPrnNums(String prnNums) {
						PrnNums = prnNums;
					}
					/**
					 * <b>Summary: </b>
					 *     获取startNum的值
					 * @return startNum 
					 */
					public String getStartNum() {
						return StartNum;
					}
					/** 
					 * <b>Summary: </b>
					 *     设置 startNum 的值 
					 * @param startNum 
					 */
					public void setStartNum(String startNum) {
						StartNum = startNum;
					}
					
			}
		}
	}
	
	//数据包，包括CEB文件，附件和元数据
	public static class DataPack {
		private CEBFile CEBFile;
		private List<Att> AttFiles;
		private ArchMetaDatas ArchMetaDatas;
		private BarCodeAttribute BarCodeAttribute;

		
		public List<Att> getAttFiles() {
			return AttFiles;
		}

		public void setAttFiles(List<Att> attFiles) {
			AttFiles = attFiles;
		}

		/**
		 * <b>Summary: </b>
		 *     获取cEBFile的值
		 * @return cEBFile 
		 */
		public CEBFile getCEBFile() {
			return CEBFile;
		}

		/** 
		 * <b>Summary: </b>
		 *     设置 cEBFile 的值 
		 * @param cEBFile 
		 */
		public void setCEBFile(CEBFile cEBFile) {
			CEBFile = cEBFile;
		}


		/**
		 * <b>Summary: </b>
		 *     获取archMetaDatas的值
		 * @return archMetaDatas 
		 */
		public ArchMetaDatas getArchMetaDatas() {
			return ArchMetaDatas;
		}

		/** 
		 * <b>Summary: </b>
		 *     设置 archMetaDatas 的值 
		 * @param archMetaDatas 
		 */
		public void setArchMetaDatas(ArchMetaDatas archMetaDatas) {
			ArchMetaDatas = archMetaDatas;
		}

		/**
		 * <b>Summary: </b>
		 *     获取barCodeAttribute的值
		 * @return barCodeAttribute 
		 */
		public BarCodeAttribute getBarCodeAttribute() {
			return BarCodeAttribute;
		}

		/** 
		 * <b>Summary: </b>
		 *     设置 barCodeAttribute 的值 
		 * @param barCodeAttribute 
		 */
		public void setBarCodeAttribute(BarCodeAttribute barCodeAttribute) {
			BarCodeAttribute = barCodeAttribute;
		}

		public static class CEBFile{
			private String CEBFileName;
			private String CEBFilePathNameInOA;
			private byte[] CEBContent;
			private String CEBContentLength;
			/**
			 * <b>Summary: </b>
			 *     获取cEBFileName的值
			 * @return cEBFileName 
			 */
			public String getCEBFileName() {
				return CEBFileName;
			}
			/** 
			 * <b>Summary: </b>
			 *     设置 cEBFileName 的值 
			 * @param cEBFileName 
			 */
			public void setCEBFileName(String cEBFileName) {
				CEBFileName = cEBFileName;
			}
			/**
			 * <b>Summary: </b>
			 *     获取cEBFilePathNameInOA的值
			 * @return cEBFilePathNameInOA 
			 */
			public String getCEBFilePathNameInOA() {
				return CEBFilePathNameInOA;
			}
			/** 
			 * <b>Summary: </b>
			 *     设置 cEBFilePathNameInOA 的值 
			 * @param cEBFilePathNameInOA 
			 */
			public void setCEBFilePathNameInOA(String cEBFilePathNameInOA) {
				CEBFilePathNameInOA = cEBFilePathNameInOA;
			}
			/**
			 * <b>Summary: </b>
			 *     获取cEBContent的值
			 * @return cEBContent 
			 */
			public byte[] getCEBContent() {
				return CEBContent;
			}
			/** 
			 * <b>Summary: </b>
			 *     设置 cEBContent 的值 
			 * @param cEBContent 
			 */
			public void setCEBContent(byte[] cEBContent) {
				CEBContent = cEBContent;
			}
			/**
			 * <b>Summary: </b>
			 *     获取cEBContentLength的值
			 * @return cEBContentLength 
			 */
			public String getCEBContentLength() {
				return CEBContentLength;
			}
			/** 
			 * <b>Summary: </b>
			 *     设置 cEBContentLength 的值 
			 * @param cEBContentLength 
			 */
			public void setCEBContentLength(String cEBContentLength) {
				CEBContentLength = cEBContentLength;
			}
			
		}
		
			//单个附件文件
			public static class Att{
				private String AttFileName;
				private String AttFilePathNameInOA;
				private byte[] AttContent;
				private String AttContentLength;
				/**
				 * <b>Summary: </b>
				 *     获取attFileName的值
				 * @return attFileName 
				 */
				public String getAttFileName() {
					return AttFileName;
				}
				/** 
				 * <b>Summary: </b>
				 *     设置 attFileName 的值 
				 * @param attFileName 
				 */
				public void setAttFileName(String attFileName) {
					AttFileName = attFileName;
				}
				/**
				 * <b>Summary: </b>
				 *     获取attFilePathNameInOA的值
				 * @return attFilePathNameInOA 
				 */
				public String getAttFilePathNameInOA() {
					return AttFilePathNameInOA;
				}
				/** 
				 * <b>Summary: </b>
				 *     设置 attFilePathNameInOA 的值 
				 * @param attFilePathNameInOA 
				 */
				public void setAttFilePathNameInOA(String attFilePathNameInOA) {
					AttFilePathNameInOA = attFilePathNameInOA;
				}
				/**
				 * <b>Summary: </b>
				 *     获取attContent的值
				 * @return attContent 
				 */
				public byte[] getAttContent() {
					return AttContent;
				}
				/** 
				 * <b>Summary: </b>
				 *     设置 attContent 的值 
				 * @param attContent 
				 */
				public void setAttContent(byte[] attContent) {
					AttContent = attContent;
				}
				/**
				 * <b>Summary: </b>
				 *     获取attContentLength的值
				 * @return attContentLength 
				 */
				public String getAttContentLength() {
					return AttContentLength;
				}
				/** 
				 * <b>Summary: </b>
				 *     设置 attContentLength 的值 
				 * @param attContentLength 
				 */
				public void setAttContentLength(String attContentLength) {
					AttContentLength = attContentLength;
				}
			}
		
		public static class ArchMetaDatas{
			private ArchSechma ArchSechma;

			/**
			 * <b>Summary: </b>
			 *     获取archSechma的值
			 * @return archSechma 
			 */
			public ArchSechma getArchSechma() {
				return ArchSechma;
			}

			/** 
			 * <b>Summary: </b>
			 *     设置 archSechma 的值 
			 * @param archSechma 
			 */
			public void setArchSechma(ArchSechma archSechma) {
				ArchSechma = archSechma;
			}


			//元数据描述，一个完整的XML文件
			public static class ArchSechma{
				private String ArchSerial;
				private String ArchFormTime;
				private String ExigenceLevel;
				private String SecretLevel;
				private String SecretYear;
				private String ArchTitle;
				private String ArchKeyWords;
				private String MainReceiver;
				private String CopyReceiver;
				private String DistributeLeader;
				private String DistributeTime;
				private String ProcMan;
				private String Contact;
				private String ArchRemark;
				private String OADataID;
				
				/**
				 * <b>Summary: </b>
				 *     获取archSerial的值
				 * @return archSerial 
				 */
				public String getArchSerial() {
					return ArchSerial;
				}

				/** 
				 * <b>Summary: </b>
				 *     设置 archSerial 的值 
				 * @param archSerial 
				 */
				public void setArchSerial(String archSerial) {
					ArchSerial = archSerial;
				}

				/**
				 * <b>Summary: </b>
				 *     获取archFormTime的值
				 * @return archFormTime 
				 */
				public String getArchFormTime() {
					return ArchFormTime;
				}

				/** 
				 * <b>Summary: </b>
				 *     设置 archFormTime 的值 
				 * @param archFormTime 
				 */
				public void setArchFormTime(String archFormTime) {
					ArchFormTime = archFormTime;
				}

				/**
				 * <b>Summary: </b>
				 *     获取exigenceLevel的值
				 * @return exigenceLevel 
				 */
				public String getExigenceLevel() {
					return ExigenceLevel;
				}

				/** 
				 * <b>Summary: </b>
				 *     设置 exigenceLevel 的值 
				 * @param exigenceLevel 
				 */
				public void setExigenceLevel(String exigenceLevel) {
					ExigenceLevel = exigenceLevel;
				}

				/**
				 * <b>Summary: </b>
				 *     获取secretLevel的值
				 * @return secretLevel 
				 */
				public String getSecretLevel() {
					return SecretLevel;
				}

				/** 
				 * <b>Summary: </b>
				 *     设置 secretLevel 的值 
				 * @param secretLevel 
				 */
				public void setSecretLevel(String secretLevel) {
					SecretLevel = secretLevel;
				}

				/**
				 * <b>Summary: </b>
				 *     获取secretYear的值
				 * @return secretYear 
				 */
				public String getSecretYear() {
					return SecretYear;
				}

				/** 
				 * <b>Summary: </b>
				 *     设置 secretYear 的值 
				 * @param secretYear 
				 */
				public void setSecretYear(String secretYear) {
					SecretYear = secretYear;
				}

				/**
				 * <b>Summary: </b>
				 *     获取archTitle的值
				 * @return archTitle 
				 */
				public String getArchTitle() {
					return ArchTitle;
				}

				/** 
				 * <b>Summary: </b>
				 *     设置 archTitle 的值 
				 * @param archTitle 
				 */
				public void setArchTitle(String archTitle) {
					ArchTitle = archTitle;
				}

				/**
				 * <b>Summary: </b>
				 *     获取archKeyWords的值
				 * @return archKeyWords 
				 */
				public String getArchKeyWords() {
					return ArchKeyWords;
				}

				/** 
				 * <b>Summary: </b>
				 *     设置 archKeyWords 的值 
				 * @param archKeyWords 
				 */
				public void setArchKeyWords(String archKeyWords) {
					ArchKeyWords = archKeyWords;
				}

				/**
				 * <b>Summary: </b>
				 *     获取mainReceiver的值
				 * @return mainReceiver 
				 */
				public String getMainReceiver() {
					return MainReceiver;
				}

				/** 
				 * <b>Summary: </b>
				 *     设置 mainReceiver 的值 
				 * @param mainReceiver 
				 */
				public void setMainReceiver(String mainReceiver) {
					MainReceiver = mainReceiver;
				}

				/**
				 * <b>Summary: </b>
				 *     获取copyReceiver的值
				 * @return copyReceiver 
				 */
				public String getCopyReceiver() {
					return CopyReceiver;
				}

				/** 
				 * <b>Summary: </b>
				 *     设置 copyReceiver 的值 
				 * @param copyReceiver 
				 */
				public void setCopyReceiver(String copyReceiver) {
					CopyReceiver = copyReceiver;
				}

				/**
				 * <b>Summary: </b>
				 *     获取distributeLeader的值
				 * @return distributeLeader 
				 */
				public String getDistributeLeader() {
					return DistributeLeader;
				}

				/** 
				 * <b>Summary: </b>
				 *     设置 distributeLeader 的值 
				 * @param distributeLeader 
				 */
				public void setDistributeLeader(String distributeLeader) {
					DistributeLeader = distributeLeader;
				}

				/**
				 * <b>Summary: </b>
				 *     获取distributeTime的值
				 * @return distributeTime 
				 */
				public String getDistributeTime() {
					return DistributeTime;
				}

				/** 
				 * <b>Summary: </b>
				 *     设置 distributeTime 的值 
				 * @param distributeTime 
				 */
				public void setDistributeTime(String distributeTime) {
					DistributeTime = distributeTime;
				}

				/**
				 * <b>Summary: </b>
				 *     获取procMan的值
				 * @return procMan 
				 */
				public String getProcMan() {
					return ProcMan;
				}

				/** 
				 * <b>Summary: </b>
				 *     设置 procMan 的值 
				 * @param procMan 
				 */
				public void setProcMan(String procMan) {
					ProcMan = procMan;
				}

				/**
				 * <b>Summary: </b>
				 *     获取contact的值
				 * @return contact 
				 */
				public String getContact() {
					return Contact;
				}

				/** 
				 * <b>Summary: </b>
				 *     设置 contact 的值 
				 * @param contact 
				 */
				public void setContact(String contact) {
					Contact = contact;
				}

				/**
				 * <b>Summary: </b>
				 *     获取archRemark的值
				 * @return archRemark 
				 */
				public String getArchRemark() {
					return ArchRemark;
				}

				/** 
				 * <b>Summary: </b>
				 *     设置 archRemark 的值 
				 * @param archRemark 
				 */
				public void setArchRemark(String archRemark) {
					ArchRemark = archRemark;
				}

				/**
				 * <b>Summary: </b>
				 *     获取oADataID的值
				 * @return oADataID 
				 */
				public String getOADataID() {
					return OADataID;
				}

				/** 
				 * <b>Summary: </b>
				 *     设置 oADataID 的值 
				 * @param oADataID 
				 */
				public void setOADataID(String oADataID) {
					OADataID = oADataID;
				}

				private List<String> AttachmentFiles ;

				public List<String> getAttachmentFiles() {
					return AttachmentFiles;
				}

				public void setAttachmentFiles(List<String> attachmentFiles) {
					AttachmentFiles = attachmentFiles;
				}
				
			}
			
		}
		
		public static class BarCodeAttribute{
			private String BarCodeVersion;//条码版本标识
			private String BarCodeSerial;//条码编号
			private String ArchSendDep;//发文单位
			private String ArchIssueSerial;//发文字号或期号
			private String EncryptLevel;//密级
			private String ExigenceLevel;//紧急程度
			private String ArchPoseDate;//公文成文日期
			private String MakeCodeDepNa;//条码制作单位的具体名称
			private String MakeCodeDate;//条码制作日期
			private String ArchType;//公文种类
			private String MainReceiver;//主送单位
			private String ArchTitle;//标题
			private String IssueLevel;//发布层次
			private String TiffContent;//公文标准二维条码TIFF数据流
			private String Custom;//自定义元素
			/**
			 * <b>Summary: </b>
			 *     获取barCodeVersion的值
			 * @return barCodeVersion 
			 */
			public String getBarCodeVersion() {
				return BarCodeVersion;
			}
			/** 
			 * <b>Summary: </b>
			 *     设置 barCodeVersion 的值 
			 * @param barCodeVersion 
			 */
			public void setBarCodeVersion(String barCodeVersion) {
				BarCodeVersion = barCodeVersion;
			}
			/**
			 * <b>Summary: </b>
			 *     获取barCodeSerial的值
			 * @return barCodeSerial 
			 */
			public String getBarCodeSerial() {
				return BarCodeSerial;
			}
			/** 
			 * <b>Summary: </b>
			 *     设置 barCodeSerial 的值 
			 * @param barCodeSerial 
			 */
			public void setBarCodeSerial(String barCodeSerial) {
				BarCodeSerial = barCodeSerial;
			}
			/**
			 * <b>Summary: </b>
			 *     获取archSendDep的值
			 * @return archSendDep 
			 */
			public String getArchSendDep() {
				return ArchSendDep;
			}
			/** 
			 * <b>Summary: </b>
			 *     设置 archSendDep 的值 
			 * @param archSendDep 
			 */
			public void setArchSendDep(String archSendDep) {
				ArchSendDep = archSendDep;
			}
			/**
			 * <b>Summary: </b>
			 *     获取archIssueSerial的值
			 * @return archIssueSerial 
			 */
			public String getArchIssueSerial() {
				return ArchIssueSerial;
			}
			/** 
			 * <b>Summary: </b>
			 *     设置 archIssueSerial 的值 
			 * @param archIssueSerial 
			 */
			public void setArchIssueSerial(String archIssueSerial) {
				ArchIssueSerial = archIssueSerial;
			}
			/**
			 * <b>Summary: </b>
			 *     获取encryptLevel的值
			 * @return encryptLevel 
			 */
			public String getEncryptLevel() {
				return EncryptLevel;
			}
			/** 
			 * <b>Summary: </b>
			 *     设置 encryptLevel 的值 
			 * @param encryptLevel 
			 */
			public void setEncryptLevel(String encryptLevel) {
				EncryptLevel = encryptLevel;
			}
			/**
			 * <b>Summary: </b>
			 *     获取exigenceLevel的值
			 * @return exigenceLevel 
			 */
			public String getExigenceLevel() {
				return ExigenceLevel;
			}
			/** 
			 * <b>Summary: </b>
			 *     设置 exigenceLevel 的值 
			 * @param exigenceLevel 
			 */
			public void setExigenceLevel(String exigenceLevel) {
				ExigenceLevel = exigenceLevel;
			}
			/**
			 * <b>Summary: </b>
			 *     获取archPoseDate的值
			 * @return archPoseDate 
			 */
			public String getArchPoseDate() {
				return ArchPoseDate;
			}
			/** 
			 * <b>Summary: </b>
			 *     设置 archPoseDate 的值 
			 * @param archPoseDate 
			 */
			public void setArchPoseDate(String archPoseDate) {
				ArchPoseDate = archPoseDate;
			}
			/**
			 * <b>Summary: </b>
			 *     获取makeCodeDepNa的值
			 * @return makeCodeDepNa 
			 */
			public String getMakeCodeDepNa() {
				return MakeCodeDepNa;
			}
			/** 
			 * <b>Summary: </b>
			 *     设置 makeCodeDepNa 的值 
			 * @param makeCodeDepNa 
			 */
			public void setMakeCodeDepNa(String makeCodeDepNa) {
				MakeCodeDepNa = makeCodeDepNa;
			}
			/**
			 * <b>Summary: </b>
			 *     获取makeCodeDate的值
			 * @return makeCodeDate 
			 */
			public String getMakeCodeDate() {
				return MakeCodeDate;
			}
			/** 
			 * <b>Summary: </b>
			 *     设置 makeCodeDate 的值 
			 * @param makeCodeDate 
			 */
			public void setMakeCodeDate(String makeCodeDate) {
				MakeCodeDate = makeCodeDate;
			}
			/**
			 * <b>Summary: </b>
			 *     获取archType的值
			 * @return archType 
			 */
			public String getArchType() {
				return ArchType;
			}
			/** 
			 * <b>Summary: </b>
			 *     设置 archType 的值 
			 * @param archType 
			 */
			public void setArchType(String archType) {
				ArchType = archType;
			}
			/**
			 * <b>Summary: </b>
			 *     获取mainReceiver的值
			 * @return mainReceiver 
			 */
			public String getMainReceiver() {
				return MainReceiver;
			}
			/** 
			 * <b>Summary: </b>
			 *     设置 mainReceiver 的值 
			 * @param mainReceiver 
			 */
			public void setMainReceiver(String mainReceiver) {
				MainReceiver = mainReceiver;
			}
			/**
			 * <b>Summary: </b>
			 *     获取archTitle的值
			 * @return archTitle 
			 */
			public String getArchTitle() {
				return ArchTitle;
			}
			/** 
			 * <b>Summary: </b>
			 *     设置 archTitle 的值 
			 * @param archTitle 
			 */
			public void setArchTitle(String archTitle) {
				ArchTitle = archTitle;
			}
			/**
			 * <b>Summary: </b>
			 *     获取issueLevel的值
			 * @return issueLevel 
			 */
			public String getIssueLevel() {
				return IssueLevel;
			}
			/** 
			 * <b>Summary: </b>
			 *     设置 issueLevel 的值 
			 * @param issueLevel 
			 */
			public void setIssueLevel(String issueLevel) {
				IssueLevel = issueLevel;
			}
			/**
			 * <b>Summary: </b>
			 *     获取tiffContent的值
			 * @return tiffContent 
			 */
			public String getTiffContent() {
				return TiffContent;
			}
			/** 
			 * <b>Summary: </b>
			 *     设置 tiffContent 的值 
			 * @param tiffContent 
			 */
			public void setTiffContent(String tiffContent) {
				TiffContent = tiffContent;
			}
			/**
			 * <b>Summary: </b>
			 *     获取custom的值
			 * @return custom 
			 */
			public String getCustom() {
				return Custom;
			}
			/** 
			 * <b>Summary: </b>
			 *     设置 custom 的值 
			 * @param custom 
			 */
			public void setCustom(String custom) {
				Custom = custom;
			}
		}
		
	}
	
	//数据包，包括CEB文件，附件和元数据
	public static class Mac{
		private String MacType;

		/**
		 * <b>Summary: </b>
		 *     获取macType的值
		 * @return macType 
		 */
		public String getMacType() {
			return MacType;
		}

		/** 
		 * <b>Summary: </b>
		 *     设置 macType 的值 
		 * @param macType 
		 */
		public void setMacType(String macType) {
			MacType = macType;
		}
		
	}
	
}
