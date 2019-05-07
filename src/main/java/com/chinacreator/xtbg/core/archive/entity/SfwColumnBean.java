package com.chinacreator.xtbg.core.archive.entity;

public class SfwColumnBean implements Comparable{
	private String column_name = "";
	private String column_field = "";
	private int column_index = 0;
	
	

	public String getColumn_field() {
		return column_field;
	}
	public void setColumn_field(String column_field) {
		this.column_field = column_field;
	}
	public String getColumn_name() {
		return column_name;
	}
	public void setColumn_name(String column_name) {
		this.column_name = column_name;
	}
	public int getColumn_index() {
		return column_index;
	}
	public void setColumn_index(int column_index) {
		this.column_index = column_index;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + column_index;
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		SfwColumnBean other = (SfwColumnBean) obj;
		if (column_index != other.column_index)
			return false;
		return true;
	}
	@Override
	public int compareTo(Object o) {
		
		return this.column_index - ((SfwColumnBean)o).getColumn_index();
		
	}
	
	
	
	
}
