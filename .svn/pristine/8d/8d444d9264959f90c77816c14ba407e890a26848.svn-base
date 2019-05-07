package com.chinacreator.xtbg.pub.tree.entity;

import java.util.HashMap;

public class TreeHashMap<K, V> extends HashMap<K, V> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (!super.equals(obj))
			return false;
		if (getClass() != obj.getClass())
			return false;
		TreeHashMap other = (TreeHashMap) obj;
		String id = (String)this.get("id");
		String other_id = (String)other.get("id");
		
		if (id == null) {
			if (other_id != null)
				return false;
		} else if (!id.equals(other_id))
			return false;

		return true;
	}
	
}
