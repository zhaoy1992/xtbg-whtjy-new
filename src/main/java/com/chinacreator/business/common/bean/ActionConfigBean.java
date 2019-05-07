package com.chinacreator.business.common.bean;

import java.util.ArrayList;

public class ActionConfigBean {
	private ArrayList<ActionBean> ActionList = new ArrayList<ActionBean>();

	public ArrayList<ActionBean> getActionList() {
		return ActionList;
	}

	public void setActionList(ArrayList<ActionBean> actionList) {
		ActionList = actionList;
	}

}
