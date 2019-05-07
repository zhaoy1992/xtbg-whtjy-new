
/**
 * 黄艺平 2013-10-10 added
 */
/**
 * 菜单:
 */
(function($) {
	$.tree = function() {
		this.treeID = "treeID";
		this.showAreaID = "showTreeID";
		this.showTreeHeader = true;
		this.treeHeaderText = "";
		this.className = "_tree";
		this.menuList = new Array();
		this.dynamicLoadUrl = '';
		this.secendMenuLocation = "";
	};
	$.extend($.tree, {});
})(jQuery);
/**
 * 
 * @param s外面的样式
 * @param c默认样式
 * @returns {String}
 */
function setStyle(s, c) {
	return s + c + styleID;
}
/**
 * 子节点树的入参
 */
(function($) {
	$.menu = function() {
		this.className = "_tree";
		this.menuList = new Array();
	};
	$.extend($.treeParam, {
		menuID : "menuID"/* 节点ID */
	}, 
	{
		className : ""/* 样式名字 */
	}, 
	{
		menuList : new Array()
	/* 加载的menuList */
	}, 
	{
		text : ""/* 显示名字 */
	}, 
	{
		url : ""/* 地址路径 */
	}, 
	{
		value : ""/* 值 */
	}, {
		name : ""/* 名字 */
	}, 
	{
		isClose : ""/* 名字 */
	});
})(jQuery);
/**
 * 新建树
 */
var newTree = function(p) {
	/*
	var object;
	if (p.isClearSelectMenuList) {
		pushPageCache(p.treeID, p);
	} else {
		var pp = findPageCacheName(p.treeID);
		if (null == pp) {
			pushPageCache(p.treeID, p);
		} else {
			p = pp;
		}
	}*/
	/* 入参类型 判断. */
	if (typeof p == 'object') {
		if ('' != p.dynamicLoadUrl) {/* 是否动态加载 */
			/* 动态加载 */
		} else {
			/* 直接加载 */
			addTree(p);
		}
	} else {
		alert("error:the input param is not tree", true, "_erroralert");
	}
}

var addTree = function(p) {
	var showArea = $("#" + p.showAreaID);/* 得到树要显示的位置 */
	showArea.html("");/* 清空HTML */
	
	var header = document.createElement("h3");
	$(header).html(p.treeHeaderText);
	showArea.append($(header));

	addMenuInDiv(1, p, p.menuList, showArea);
}
/**
 * 添加菜单
 * 
 * @param p
 */
function addMenuInDiv(levelNo, p, menuList, rootdiv) {
	 
	 var menu_v = document.createElement("ul");
	 $(rootdiv).append($(menu_v));
	 $(menu_v).addClass("");
	 $(menu_v).attr("id", "_menu_ul_");
	 
	$.each(menuList, function(key, m) {
		var li = document.createElement("li");
		$(menu_v).append($(li));
		$(li).append("<a href='#'><b class='"+m.className+"'></b><br />"+m.menuName+"</a>");
		$(li).attr("id", "_menu_li_"+m.menuId);
		
		$(li).click(function() {
			    var boxMenu = {}
			    boxMenu.isClose = true;
			    boxMenu.menuId = m.menuId;
			    boxMenu.menuName = m.text;
			    boxMenu.closeName = p.closeName;
			    boxMenu.isReload = true;
			    boxMenu.leftUrl = m.leftUrl;
			    boxMenu.secendmenu = m.secendmenu;
			    boxMenu.secendMenuLocation = p.secendMenuLocation;
			    boxMenu.description = m.description;
			    boxMenu.headimg = m.headimg;
			    var url = "";
			    for(i = 0; i < m.secendmenu.length; i++) {
			    	url = m.secendmenu[i].url;
			    	break;
			    }
				addBoxMenu(boxMenu, 'wrap', url, m.secendmenu);
		});
		
		
	});
}




