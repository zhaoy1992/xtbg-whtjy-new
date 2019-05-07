var HTMLUtil = {};
/*
	函数：cloneReplaceElement
	描述：克隆模板节点，递归替换属性及文本节点中包含格式“$name$”的字符串
	作者：何世星
	日期：2013-4-26
*/
HTMLUtil.cloneReplaceElement = function (templdate, options) {
	//escapeAtts包含无需替换的属性
	var escapeAtts = "$" + [
		"scopeName", 
		"tagName", 
		"contentEditable", 
		"readyState", 
		"outerHTML", 
		"innerHTML", 
		"nodeName", 
		"outerText", 
		"innerText"
	].join("$,$") + "$";
	//格式表达式
	var reg = /\$[^$]+\$/g;
	//递归替换函数
	function deepReplaceElement(element) {
		/*
			替换属性值
			1.只替换string类型的属性值
			2.属性不包含在escapeAttribute定义中
			3.被替换值格式为“$name$”
		*/
		for (var att in element) if (typeof element[att] == "string" && escapeAtts.indexOf("$" + att + "$") == -1 && element[att]) {
			var arr = element[att].match(reg);
			if (arr) {
				for (var i = 0, count = arr.length; i < count; i++) if (options[arr[i]]) {
					element[att] = element[att].replace(arr[i], options[arr[i]]);
				}
			}
		}
		//处理子节点
		var currentChild = element.firstChild;
		while(currentChild) {
			var nodeType = currentChild.nodeType;
			//元素节点，递归处理
			if (nodeType == 1) {
				arguments.callee(currentChild, options);
			//文本节点，替换
			} else if (nodeType == 3) {
				var reps = currentChild.nodeValue.match(reg);
				if (reps) {
					for (var j = 0, length = reps.length; j < length; j++) if (options[reps[j]]) {
						currentChild.nodeValue = currentChild.nodeValue.replace(reps[j], options[reps[j]]);
					}
				}
			}
			currentChild = currentChild.nextSibling;
		}
		//回调函数接口，可以在标签内自定义callback属性
		if (element["callback"] && element["callback"] != "$callback$") {
			try {
				eval(element["callback"] + "(element)");
			} catch (e) {
				alert(e.message);
			}
		}
	}
	//克隆模板节点
	var clone = templdate.cloneNode(true);
	//递归替换
	deepReplaceElement(clone);
	return clone;
}
/*
	函数：readOnly
	描述：将input/select标签控件去除,转换为只读的内容
	参数：
		  element：将转换的标签对象
		  style：应用在readOnly状态inuput标签的样式(暂无用)
*/
HTMLUtil.readOnly = function (element, style) {	
		var elementParent = element.parentNode;//获取当前控件所在的上一层对象,即td
		
		//for (var i=0; i<elementParent.childNodes.length;i++ )//循环td里有多少个元素
		//{
			var tmp = "";//用于拼接td里元素的所有值
			if (element.nodeName == "SELECT") {
				tmp = element.options[element.selectedIndex].text;
			} else if (element.nodeName == "INPUT"){
				tmp = element.value;
			} else if (element.nodeName == "SPAN"  || element.nodeName == "TEXTAREA"){
				tmp = element.innerHTML;
			}

			if (IsSpace(tmp))
			{
				var exitObj = document.createElement("SPAN");
				if (!document.getElementById(element.id + "_span"))
				{
					exitObj.id = element.id + "_span";
					exitObj.innerHTML = "&nbsp;";
					element.parentNode.insertBefore(exitObj,element);
					element.style.display = "none";
				}
//				elementParent.innerHTML = "&nbsp;";
			} else {
				var exitObj = document.createElement("SPAN");
				if (!document.getElementById(element.id + "_span"))
				{
					exitObj.id = element.id + "_span";
					exitObj.innerHTML = tmp;
					element.parentNode.insertBefore(exitObj,element);
					element.style.display = "none";
				}
				//elementParent.innerHTML = tmp;//将td里改为存放值
			}
		//}
}

/*
	函数：	loadXMLDoc()
	说明：	读取xml文件
	参数：	dname(文件路径加文件名)
	返回：	文件对象
*/
HTMLUtil.loadXMLDoc = function (dname){
	try {//Internet Explorer
		xmlDoc=new ActiveXObject("Microsoft.XMLDOM");
	} catch(e){
		try {//Firefox, Mozilla, Opera, etc.
			xmlDoc=document.implementation.createDocument("", "", null);
		}catch(e) {
			alert(e.message)
		}
	}
	try {
		xmlDoc.async = false;
		xmlDoc.load(dname);
		return(xmlDoc);
	}catch(e) {
		alert(e.message)
	}
	return(null);
}
