package com.chinacreator.business.common.bean;

import java.util.ArrayList;

public class FristBean {
	public ArrayList<ShowItem> item = new ArrayList<ShowItem>();
    public ArrayList<PendingItem> pending = new ArrayList<FristBean.PendingItem>();
	
	public ArrayList<ShowItem> getItem() {
		return item;
	}

	public void setItem(ArrayList<ShowItem> item) {
		this.item = item;
	}
	
	

	public ArrayList<PendingItem> getPending() {
		return pending;
	}

	public void setPending(ArrayList<PendingItem> pending) {
		this.pending = pending;
	}



	public class ShowItem {
		private String name;
		private String showType;
		private String clickurl;
		private String urlParam;
		private String sql;
		private String moreUrl;
		private String viewType;
		private String clickType;
		private String id;
		private String ruleSql;
		private int showRow = 5;

		public int getShowRow() {
			return showRow;
		}

		public void setShowRow(int showRow) {
			this.showRow = showRow;
		}

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public String getShowType() {
			return showType;
		}

		public void setShowType(String type) {
			this.showType = type;
		}

		public String getClickurl() {
			return clickurl;
		}

		public void setClickurl(String clickurl) {
			this.clickurl = clickurl;
		}

		public String getUrlParam() {
			return urlParam;
		}

		public void setUrlParam(String urlParam) {
			this.urlParam = urlParam;
		}

		public String getSql() {
			return sql;
		}

		public void setSql(String sql) {
			this.sql = sql;
		}

		public String getMoreUrl() {
			return moreUrl;
		}

		public void setMoreUrl(String moreUrl) {
			this.moreUrl = moreUrl;
		}

		public String getViewType() {
			return viewType;
		}

		public void setViewType(String viewType) {
			this.viewType = viewType;
		}

		public String getClickType() {
			return clickType;
		}

		public void setClickType(String clickType) {
			this.clickType = clickType;
		}

		public String getId() {
			return id;
		}

		public void setId(String id) {
			this.id = id;
		}

		public String getRuleSql() {
			return ruleSql;
		}

		public void setRuleSql(String ruleSql) {
			this.ruleSql = ruleSql;
		}
		
		
	}

	public class PendingItem {
		private String name;
		private String clickurl;
		private String urlParam;
		private String sql;
		private String clickType;
		private String id;
		private String ruleSql;
		private DataClass dataClass;
		
		public DataClass getDataClass() {
			return dataClass;
		}

		public void setDataClass(DataClass dataClass) {
			this.dataClass = dataClass;
		}

		public String getId() {
			return id;
		}

		public void setId(String id) {
			this.id = id;
		}

		public String getClickType() {
			return clickType;
		}

		public void setClickType(String clickType) {
			this.clickType = clickType;
		}

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public String getClickurl() {
			return clickurl;
		}

		public void setClickurl(String clickurl) {
			this.clickurl = clickurl;
		}

		public String getUrlParam() {
			return urlParam;
		}

		public void setUrlParam(String urlParam) {
			this.urlParam = urlParam;
		}

		public String getSql() {
			return sql;
		}

		public void setSql(String sql) {
			this.sql = sql;
		}

		public String getRuleSql() {
			return ruleSql;
		}

		public void setRuleSql(String ruleSql) {
			this.ruleSql = ruleSql;
		}
		
		public class DataClass {

			private String classname;
			private String method;
			public ArrayList<MethodParams> methodparams = new ArrayList<MethodParams>();
			
			
			public ArrayList<MethodParams> getMethodparams() {
				return methodparams;
			}
			public void setMethodparams(ArrayList<MethodParams> methodparams) {
				this.methodparams = methodparams;
			}
			public String getClassname() {
				return classname;
			}
			public void setClassname(String classname) {
				this.classname = classname;
			}
			public String getMethod() {
				return method;
			}
			public void setMethod(String method) {
				this.method = method;
			}
			
			public class MethodParams{
				private String name;
				private String value;

				public String getValue() {
					return value;
				}

				public void setValue(String value) {
					this.value = value;
				}

				public String getName() {
					return name;
				}

				public void setName(String name) {
					this.name = name;
				}
				
			}
			
		}

	}
	

}
