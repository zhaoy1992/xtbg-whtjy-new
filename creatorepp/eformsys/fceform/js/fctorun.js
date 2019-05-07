var strSwLine = unescape("%0D%0A");


function DesignStr_RunStr(sDesign) {
	var pstrUserFunction = "";
	var pstrAddHtml = "";
	var pstrSplitAddHtml = "<p id=splitaddhtml />";
	var sHtm = "";
	var sRet = sDesign;
	var bRunDjFile = false;
	var iEnd = sRet.indexOf("</scr" + "ipt>");
	if (iEnd == -1) {
		pstrUserFunction = "";
		sHtm = sRet;
	} else {
		var sHtm = sRet.substring(iEnd + 9, sRet.length);
		if (isSpace(sHtm)) {
			return "";
		}
		pstrUserFunction = sRet.substring(8, iEnd);
		pstrUserFunction = unRepNewLine(unRepXml(pstrUserFunction));
	}
	var ipos = sHtm.indexOf(pstrSplitAddHtml);
	if (ipos == -1) {
		pstrAddHtml = "";
	} else {
		pstrAddHtml = sHtm.substring(ipos + pstrSplitAddHtml.length,
				sHtm.length);
		sHtm = sHtm.substring(0, ipos);
	}
	if (sHtm == "")
		return "";
	document.write("<div id=bigmain>" + sHtm + "</div>");
	if (oContXml == null) {
		oContXml = SetDom(SKbillsheet.contxml);
	}
	DesignStr_RunStr_Before(SKbillsheet);
	SKbillsheet.removeAttribute("contentEditable");
	SKbillsheet.removeAttribute("unselectable");
	var sRun = SKbillsheet.outerHTML;
	sRun = DesignStr_RunStr_After(sRun);
	sRun = "<scr" + "ipt>" + pstrUserFunction + "</scr" + "ipt>" + sRun
			+ pstrAddHtml;			
			
	bigmain.outerHTML = "";
	document.write(sRun);
	return sRun;
}
function DesignStr_RunStr_Before0() {
	var oX = oContXml.documentElement.selectSingleNode("text");
	if (oX != null) {
		var len = oX.childNodes.length;
		for (var j = 0;j < len; j++) {
			try {
				var obj = eval(oX.childNodes(j).text);
			} catch (e) {
				continue;
			}
			if (IsSpace(obj.txtStyle) == false) {
				ClearCssPart(obj, "borderTop", "Border-Top");
				ClearCssPart(obj, "borderBottom", "border-Bottom");
				ClearCssPart(obj, "borderRight", "border-Right");
				ClearCssPart(obj, "borderLeft", "border-Left");
			}
			switch (obj.txtStyle) {
				case '1' : {
					obj.className = "txtStyleDefulte";
					break;
				}
				case '2' : {
					obj.className = "txtStyleBottom";
					break;
				}
				case '3' : {
					obj.className = "txtStyleSolid";
					break;
				}
				case '4' : {
					obj.className = "txtStyledDotted";
					break;
				}
				case '5' : {
					obj.className = "txtStyleRidge";
					break;
				}
				case '6' : {
					obj.className = "txtStyleoutset";
					break;
				}
			}
		}
	}
}

//去掉空格
String.prototype.trim=function(){
    return this.replace(/(^\s*)|(\s*$)/g, "");
 }

//通过src获取srcsk 与href1
function getSrcskbySrc(src){
	var sksrc = "";
	var tempsrc = src.split("/");
	var srcs = new Array();
	var val = 0;
	var initLoopVal=0;
	//去掉空元素
	for(i=0;i<tempsrc.length;i++){
		if(!isSpace(tempsrc[i].trim())){
			srcs[val++]=tempsrc[i];
		}
	}
	var flag_0 = (srcs[0] == "eformsys");
	var flag_1 = (srcs[1] == "fceform");
	var flag_2 = (srcs[2] == "design");
	if(flag_0&&flag_1&&flag_2){
		initLoopVal=3;
	}else if(flag_0&&flag_1&&!flag_2){
		initLoopVal=2;
		sksrc+="../";
	}else if(flag_0&&!flag_1&&!flag_2){
		initLoopVal=1;
		sksrc+="../../";
	}else{
		sksrc+="../../../";
	}
	for(i=initLoopVal;i<srcs.length;i++){
		sksrc+=srcs[i]+"/";
	}
	return sksrc.substring(0, sksrc.length-1);
}

function DesignStr_RunStr_Before(SKbillsheet) {
	var o = window.document.all.tags("a");
	var l = o.length;
	var temps = location.protocol + "//" + location.host;
	var s1 = temps+ fcpubdata.Path;
	s1 = s1.toLowerCase();
	var urlFirstPart = GetUrlFirstPart();//上下文根
	temps +=urlFirstPart;
	for (var i = 0;i < l; i++) {
		if (isSpace(o[i].href1) == false) {
			o[i].href = o[i].href1;
		} else {
			var s = o[i].href.toLowerCase();
			var s1 = location.protocol + "//" + location.host + fcpubdata.Path;
			s1 = s1.toLowerCase();
			if (s.indexOf(s1) == 0) {
				o[i].href = "../.." + s.substring(s1.length, s.length);
			}
		}
	}
	changesrc("dataset", "../images/ef_designer_dataset.gif");
	changesrc("grid", "../images/ef_designer_webgrid.gif");
	changesrc("chart", "../images/ef_designer_graph.gif");
	changesrc("spin", "../images/ef_designer_numedit.gif");
	changesrc("dropdownlist", "../images/ef_designer_fccode.gif");
	changesrc("tree", "../images/ef_designer_tree.gif");
	changesrc("extgrid", "../images/extgrid.jpg");
	var o = window.document.all.tags("img");
	var l = o.length;
	for (var i = 0;i < l; i++) {
		var s = o[i].src.toLowerCase();
		var isIMGControl = true;//是否为表单控件的方式添加的图片
		if(o[i].controltype!="img"
			&&typeof(o[i].controltype)=="undefined"
			&&isSpace(o[i].controltype)){
			isIMGControl = false;
			o[i].controltype="img";
		}
		if(!isIMGControl){//非图形控件的			
			var tempsrc = s.substring(temps.length, s.length);
			o[i].srcsk=getSrcskbySrc(tempsrc);
		}
		
		if (s.indexOf(s1) == 0) {
			o[i].src = "../.." + s.substring(s1.length, s.length);
		} else {
			// added by zhou.luo 2009-02-19 解决非eformsys目录的图片的src的绝对路径没有替换的问题。
			o[i].src = o[i].srcsk;
		}
	}
	
	var o = window.document.all.tags("line");
	var l = o.length;
	for (var i = 0;i < l; i++) {
		o[i].onresize = "";
	}
	var oNode = oContXml.documentElement.selectSingleNode("button");
	if (oNode != null) {
		var l = oNode.childNodes.length;
		for (var i = 0;i < l; i++) {
			try {
				var obj = eval(oNode.childNodes(i).text);
			} catch (e) {
				continue;
			}
			switch (obj.cmdStyle) {
				case '2' : {
					obj.className = "cmd_style";
					obj.onmouseout = "this.className='btn3_mouseout'";
					obj.onmouseover = "this.className='btn3_mouseover'";
					break;
				}
				case '3' : {
					obj.className = "fcbtn1";
					obj.onmouseout = "this.className='btn1_mouseout'";
					obj.onmouseover = "this.className='fcbtn1_mouseover'";
					break;
				}
				case '4' : {
					obj.className = 'fcbtn2_mouseout';
					obj.onmouseout = "this.className='fcbtn2_mouseout'";
					obj.onmouseover = "this.className='fcbtn2_mouseover'";
					break;
				}
				case '5' : {
					obj.className = "fcbtn3";
					break;
				}
				case '6' : {
					obj.className = "fcbtn4";
					break;
				}
				case '7' : {
					obj.className = "fcbtn5";
					break;
				}
				case '8' : {
					obj.className = "fcbtn6";
					break;
				}
			}
		}
	}
	function changesrc(comType, srcPath) {
		var oNode = oContXml.documentElement.selectSingleNode(comType);
		if (oNode != null) {
			var l = oNode.childNodes.length;
			for (var i = 0;i < l; i++) {
				var obj = eval(oNode.childNodes(i).text);
				obj.src = srcPath;
			}
		}
	}
}

/*
 * 将tab页中的img标签src路径替换成srcsk
 */
function ProcessImgSrc(obj){
	var imgSrcs = obj.getElementsByTagName("img");
	for(i=0;i<imgSrcs.length;i++)
	{
		imgSrcs[i].src = imgSrcs[i].srcsk;
	}
	return obj.outerHTML;
}

function DesignStr_RunStr_After(sRun, arr) {
	var sAttachEnd = "";
	var basePath = "";
	if (IsSpace(SKbillsheet.type)) {
		basePath = "..";
	} else {
		var typePath = BillTypeNameToPath(SKbillsheet.type).path;
		typePath = Trim(typePath);
		typePath = typePath.toLowerCase();
		if (typePath.substring(0, 1) == "/") {
			typePath = typePath.substring(1, typePath.length);
		}
		if (typePath.substring(typePath.length - 1, typePath.length) != "/") {
			typePath = typePath + "/";
		}
		if (typePath == "fceform/dj/") {
			basePath = "..";
		} else {
			var tag = 0;
			var tagbase = false;
			var arr = typePath.split("/");
			for (var i = 0;i < arr.length - 1; i++) {
				if (arr[i] == "." || IsSpace(arr[i])) {
				} else if (arr[i] == "..") {
					if (i == 0) {
						tagbase = true;
					} else {
						tag++;
					}
				} else {
					basePath += "../"
				}
			}
			for (var i = 0;i < tag; i++) {
				if (basePath.length > 3) {
					basePath = basePath.substring(3, basePath.length);
				}
			}
			if (tagbase)
				basePath += fcpubdata.Path.substring(1, fcpubdata.Path.length)
						+ "/";
			basePath += "fceform";
		}
	}
	if (typeof arr == "undefined") {
		var ArrNum = new Array();
		ArrNum = OpenControlNo(SKbillsheet.controlno, ArrNum);
	} else {
		var ArrNum = arr;
	}
	var arrtmp = new Array();
	var oNode = oContXml.documentElement.selectSingleNode("dataset");
	if (oNode != null) {
		var l = oNode.childNodes.length;
		for (var i = 0;i < l; i++) {
			var obj = eval(oNode.childNodes(i).text);
			var s1 = imgdataset_dataset(obj);
			arrtmp[i] = s1;
		}
	}
	var oNode = oContXml.documentElement.selectSingleNode("grid");
	if (oNode != null) {
		var l = oNode.childNodes.length;
		for (var i = 0;i < l; i++) {
			var obj = eval(oNode.childNodes(i).text);
			var s1 = imgwebgrid_webgrid(obj);
			obj.outerHTML = s1;
		}
	}
	var oNode = oContXml.documentElement.selectSingleNode("dataset");
	if (oNode != null) {
		var l = oNode.childNodes.length;
		for (var i = 0;i < l; i++) {
			var obj = eval(oNode.childNodes(i).text);
			obj.outerHTML = arrtmp[i];
		}
	}

	// add by zuojian.xiang 2009-4-15
	// 将EXTGRID整合到表单中
	var oNode = oContXml.documentElement.selectSingleNode("ExtGrid");
	if (oNode != null) {
		var l = oNode.childNodes.length;
		for (var i = 0;i < l; i++) {
			var obj = eval(oNode.childNodes(i).text);
			var s1 = creator_pt_createExtGrid(obj);
			// var pobj = obj.parentElement.parentElement;
			obj.outerHTML = s1;
			 //alert(obj.innerHTML);
		}
	}

	// add by zuojian.xiang 2009-4-15
	// 将ExtUpload整合到表单中
	var oNode = oContXml.documentElement.selectSingleNode("ExtUpload");
	if (oNode != null) {
		var l = oNode.childNodes.length;
		for (var i = 0;i < l; i++) {
			var obj = eval(oNode.childNodes(i).text);
			var s1 = creator_pt_createExtUpload(obj);
			obj.outerHTML = s1;
		}
	}

	var oNode = oContXml.documentElement.selectSingleNode("ExtTree");
	if (oNode != null) {
		var l = oNode.childNodes.length;
		for (var i = 0;i < l; i++) {
			var obj = eval(oNode.childNodes(i).text);
			var s1 = creator_pt_createExtTree(obj);
			obj.outerHTML = s1;
		}
	}
	/* sxb 20081031 保存时将应用控件的串转为<fc:creatorSubForm></fc:creatorSubForm>的形式 */
	/*
	 * var oNode = oContXml.documentElement.selectSingleNode("creatorSubForm") ;
	 * if(oNode != null ){ var l=oNode.childNodes.length; for(var i=0;i<l;i++){
	 * var obj = $(oNode.childNodes(i).text); var tag = obj.tagName;
	 * //alert(tag); var s1=obj.outerHTML; s1 =
	 * s1.substring(tag.length+2,s1.length-tag.length-4); s1 = "<fc:creatorSubForm
	 * "+s1+"></fc:creatorSubForm>"; obj.outerHTML = s1; } }
	 */
	/* end */

	var oNode = oContXml.documentElement.selectSingleNode("spin");
	if (oNode != null) {
		var l = oNode.childNodes.length;
		for (var i = 0;i < l; i++) {
			try {
				var obj = eval(oNode.childNodes(i).text);
			} catch (e) {
				continue;
			}
			var sHtml = new StringBuffer();
			var tmpvalue = "";
			if (IsSpace(obj.value) == false)
				tmpvalue = obj.value;
			sHtml.append("<div Class='xpSpin'  id=\"").append(obj.id)
					.append("\" field=\"").append(obj.field)
					.append("\" dataset=\"").append(obj.dataset)
					.append("\"  Min=\"").append(obj.Min).append("\" value=\"")
					.append(tmpvalue).append("\" align=\"")
					.append(obj.style.textalign);
			if (obj.parentNode.id == "fcpagesub"
					|| obj.parentNode.controltype == "div") {
				sHtml.append(" ParentPos='相对' ");
			}
			sHtml.append("\" style='align:").append(obj.style.textalign)
					.append("; position:").append(obj.style.position)
					.append("; left:").append(obj.style.left).append("; top:")
					.append(obj.style.top).append("; width:")
					.append(obj.style.width).append("; height:")
					.append(obj.style.height).append(";' NextNum=\"")
					.append(obj.NextNum).append("\" Max=\"").append(obj.Max)
					.append("\" fontsize=\"").append(obj.style.fontSize)
					.append("\" fontstyle=\"").append(obj.style.fontStyle)
					.append("\" fontfamily=\"").append(obj.style.fontFamily)
					.append("\" backgroundcolor=\"")
					.append(obj.style.backgroundColor).append("\" color=\"")
					.append(obj.style.color).append("\" fontweight=\"")
					.append(obj.style.fontWeight).append("\" enabled=\"")
					.append(obj.enabled).append("\" display=\"")
					.append(obj.style.display).append("\" left=\"")
					.append(obj.style.left).append("\"  top=\"")
					.append(obj.style.top).append("\" width=\"")
					.append(obj.style.width).append("\" height=\"")
					.append(obj.style.height).append("\"></div>");
			obj.outerHTML = sHtml.toString();
		}
	}
	var oNode = oContXml.documentElement.selectSingleNode("combobox");
	if (oNode != null) {
		var l = oNode.childNodes.length;
		for (var i = 0;i < l; i++) {
			try {
				var obj = eval(oNode.childNodes(i).text);
			} catch (E) {
				continue;
			}
			var s2 = obj.sql;
			var s3 = SqlPropTrans(s2);
			obj.sql = "";
			obj.sqltrans = s3;
		}
	}
	var oNode = oContXml.documentElement.selectSingleNode("listbox");
	if (oNode != null) {
		var l = oNode.childNodes.length;
		for (var i = 0;i < l; i++) {
			try {
				var obj = eval(oNode.childNodes(i).text);
			} catch (E) {
				continue;
			}
			var s2 = obj.sql;
			var s3 = SqlPropTrans(s2);
			obj.sql = "";
			obj.sqltrans = s3;
		}
	}
	var oNode = oContXml.documentElement.selectSingleNode("checkboxlist");
	if (oNode != null) {
		var l = oNode.childNodes.length;
		for (var i = 0;i < l; i++) {
			try {
				var obj = eval(oNode.childNodes(i).text);
			} catch (E) {
				continue;
			}
			var s2 = obj.sql;
			var s3 = SqlPropTrans(s2);
			obj.sql = "";
			obj.sqltrans = s3;
		}
	}
	var oNode = oContXml.documentElement.selectSingleNode("radiolist");
	if (oNode != null) {
		var l = oNode.childNodes.length;
		for (var i = 0;i < l; i++) {
			try {
				var obj = eval(oNode.childNodes(i).text);
			} catch (E) {
				continue;
			}
			var s2 = obj.sql;
			var s3 = SqlPropTrans(s2);
			obj.sql = "";
			obj.sqltrans = s3;
		}
	}
	// Fusionchar
	var oNode = oContXml.documentElement.selectSingleNode("Fusionchar");
	if (oNode != null) {
		var l = oNode.childNodes.length;

		for (var i = 0;i < l; i++) {
			var shtml = "";
			try {

				var obj = eval(oNode.childNodes(i).text);

				shtml = CreateFusionchar(obj);

			} catch (E) {
				continue;
			}
			obj.outerHTML = shtml;
		}

	}
	var oNode = oContXml.documentElement.selectSingleNode("dropdownlist");
	if (oNode != null) {
		var l = oNode.childNodes.length;
		for (var i = 0;i < l; i++) {
			try {
				var obj = eval(oNode.childNodes(i).text);
			} catch (E) {
				continue;
			}
			var str = new StringBuffer().append("<fc:fc_code id=\"")
					.append(obj.id).append("\" addrow=\"").append(obj.addrow)
					.append("\"  multiselect=\"").append(obj.multiselect)
					.append("\"  blninput=\"").append(obj.blninput)
					.append("\"  enabled=").append(obj.disabled)
					.append(" blnempty=\"").append(obj.blnempty)
					.append("\"  sqltrans=\"").append(SqlPropTrans(obj.sql1))
					.append("\" sql2=\"").append(obj.sql2)
					.append("\"   format=\"").append(obj.format)
					.append("\" visible=\"").append(obj.visible)
					.append("\" xml=\"").append(obj.xml);
			str.append("\" dataset=\"").append(obj.dataset)
					.append("\" align=\"").append(obj.style.textalign)
					.append("\" position=\"").append(obj.style.position)
					.append("\"   field=\"").append(obj.field);
			str.append("\" left=\"").append(obj.style.pixelLeft)
					.append("\"  top=\"").append(obj.style.pixelTop)
					.append("\" width=\"").append(obj.style.width)
					.append("\" height=\"").append(obj.height)
					.append("\" fontsize=\"").append(obj.style.fontSize)
					.append("\" fontstyle=\"").append(obj.style.fontStyle)
					.append("\" fontfamily=\"").append(obj.style.fontFamily)
					.append("\" backgroundcolor=\"")
					.append(obj.style.backgroundColor).append("\" color=\"")
					.append(obj.style.color).append("\" fontweight=\"")
					.append(obj.style.fontWeight).append("\" height=\"")
					.append(obj.style.pixelHeight).append("\" ");
			if (obj.parentNode.id == "fcpagesub") {
				str.append(" ParentPos='相对' ");
			}
			var s1 = "";
			if (IsSpace(obj.fc_onclick) == false) {
				s1 = " onclickadd='" + quot_42(obj.fc_onclick) + "'";
			}
			str.append(s1);
			var s2 = "";
			if (IsSpace(obj.onkeydown) == false) {
				s2 = " onkeydown='" + quot_42(obj.onkeydown) + "'";
			}
			str.append(s2);
			var s3 = "";
			if (IsSpace(obj.onclickopen) == false) {
				s3 = " onclickopen='" + quot_42(obj.onclickopen) + "'";
			}
			str.append(s3);
			var s4 = "";
			if (IsSpace(obj.oninterchange) == false) {
				s4 = " oninterchange='" + quot_42(obj.oninterchange) + "'";
			}
			str.append(s4);
			var s5 = "";
			if (IsSpace(obj.onchange) == false) {
				s5 = " onchange='" + quot_42(obj.onchange) + "'";
			}
			str.append(s5);
			var s6 = "";
			if (IsSpace(obj.onselchange) == false) {
				s6 = " onselchange='" + quot_42(obj.onselchange) + "'";
			}
			str.append(s6);
			str.append(">").append("</fc:fc_code>");
			obj.outerHTML = str.toString();
		}
	}
	var oNode = oContXml.documentElement.selectSingleNode("tree");
	if (oNode != null) {
		var l = oNode.childNodes.length;
		for (var i = 0;i < l; i++) {
			try {
				var obj = eval(oNode.childNodes(i).text);
			} catch (E) {
				continue;
			}
			var sStr = new StringBuffer().append('<div id="').append(obj.id)
					.append('" ');
			sStr.append('sourcetype=').append(obj.sourcetype)
					.append(' opentb="').append(obj.opentb)
					.append('" clicknode="').append(escape(obj.clicknode))
					.append('" ');
			sStr.append('roottext="').append(obj.roottext).append('" ');
			sStr.append('xml="').append(escape(obj.xml)).append('" ');
			sStr.append('ischecked="').append(obj.ischecked).append('" ');
			sStr.append('xmlpath="').append(escape(obj.xmlpath)).append('" ');
			sStr.append('isAll="').append(obj.isAll).append('" ');
			if (IsSpace(obj.sql) == false) {
				sStr.append('sql="').append(SqlPropTrans(obj.sql)).append('" ');
			}
			if (IsSpace(obj.sql2) == false) {
				sStr.append('sql2="').append(SqlPropTrans(obj.sql2))
						.append('" ');
			}
			if (obj.disabled == true) {
				sStr.append('disabled ');
			}
			sStr.append('style="OVERFLOW: auto;BORDER-STYLE:')
					.append(obj.style.borderStyle).append(';position:')
					.append(obj.style.position).append(';');
			sStr.append('border-width:').append(obj.style.borderWidth)
					.append(';');
			sStr.append(' background-color:#ffffff; width:')
					.append(obj.style.width).append('; height:')
					.append(obj.style.height).append('; left:')
					.append(obj.style.left).append('; top:')
					.append(obj.style.top).append('; display:')
					.append(obj.style.display).append('" ></div>');
			sAttachEnd = new StringBuffer().append(strSwLine)
					.append('<script language="JavaScript">');
			sAttachEnd.append('var ').append(obj.id).append(';');
			sAttachEnd.append('</').append('script>');
			obj.outerHTML = sStr.toString();
		}
	}
	var obj;
	var l;
	var oNode = oContXml.documentElement.selectSingleNode("tab");
	if (oNode != null) {
		var l = oNode.childNodes.length;
		for (var i = 0;i < l; i++) {
			var obj = eval(oNode.childNodes(i).text)
			var sHtm = new StringBuffer()
					.append("<div class=\"tab-pane\" showtype=\"luna\" IsHideTitle=");
			sHtm.append((obj.IsHideTitle == "是") ? "\"是\"" : "\"否\"").append(" id=").append(obj.id)
					.append(" style=\"position:absolute;left:")
					.append(obj.style.left).append(";top:")
					.append(obj.style.top).append(";width:")
					.append(obj.style.width).append(";Height:")
					.append(obj.style.height).append("\">");
			var sHeight = obj.style.posHeight - 18;
			var l1 = obj.childNodes(0).rows(0).cells.length;
			for (var j = 0;j < l1; j++) {
				sHtm.append("<div class=\"tab-page\" style=\"width:")
						.append(obj.style.width).append(";height:")
						.append(sHeight).append("\" >");
				sHtm.append("<h2 class=\"tab\">").append(obj.childNodes(0)
						.rows(0).cells(j).innerText).append("</h2>");
				sHtm.append(HideListBoxSave(obj.childNodes(j + 1)));
				sHtm.append("</div>");
			}
			sHtm.append("</div>");
			sHtm.append("<script>");
			sHtm.append("var ").append(obj.id)
					.append(" = new WebFXTabPane( document.getElementById( \"")
					.append(obj.id).append("\" ) );");
			sHtm.append("</scr").append("ipt>");
			obj.outerHTML = sHtm.toString();
		}
	}
//	sRun = SKbillsheet.outerHTML;
	sRun = ProcessImgSrc(SKbillsheet);
	sRun = RepStr(sRun, " onkeyup=\"this.innerText=''\" ", " ");
	sRun = RepStr(sRun, "<LABEL ", "<INPUT type=text ");
	sRun = RepStr(sRun, "</LABEL>", "</INPUT>");
	sRun = RepStr(sRun, " fc_onclick=", " onclick=");
	sRun = RepStr(sRun, " fc_ondblclick=", " ondblclick=");
	sRun = RepStr(sRun, " fc_onfocus=", " onfocus=");
	sRun = RepStr(sRun, " fc_onblur=", " onblur=");
	sRun = RepStr(sRun, " fc_onkeydown=", " onkeydown=");
	var stmp11 = "()";
	sRun = RepStr(sRun, " onmove=move" + stmp11, "");
	sRun = RepStr(sRun, " onresize=resize" + stmp11, "");
	sRun = RepStr(sRun, " oncontrolselect=controlselect" + stmp11, "");
	sRun = RepStr(sRun, " onresizeend=resizeEnd" + stmp11
			+ " onresizestart=resizeStart" + stmp11 + " onmoveend=moveEnd"
			+ stmp11, "");

	////////////////////////////////////////////
	//维护说明：10-09-01修改为根据properties-eform.xml文件中项目file.upload.jsdgmode配置值
	//确定是否采用预加载方式加载页面自定义在服务器上js程序文件, by jihongwei.
	var sAttach_p = new StringBuffer();

	var sjslib = SKbillsheet.jslib; var count=0;
	if (isSpace(sjslib) == false)
	{
		var arr = sjslib.split("\r\n");
		var l = arr.length;		
		
		var strTemp;
		sAttach_p.append('<%' + strSwLine);
		//sAttach_p.append('String strDgMode = com.chinacreator.config.ConfigManager.getInstance().getConfigValue("file.upload.jsdgmode");' + strSwLine);
		//sAttach_p.append('boolean bDgMode = !((strDgMode == null) || !strDgMode.equals("1"));' + strSwLine);		
		strTemp = "<script language='javascript'>";
		sAttach_p.append('if(!bDgMode) out.println("' + strTemp + '");' + strSwLine);
		
		for (var i = 0;i < l; i++) 
		{
			if(arr[i].indexOf("/dwr/")>0)
				continue;
			if (isSpace(arr[i]))
				continue;
				
			if (arr[i] == "fcsavedj.js" || arr[i] == "selectdate.js"|| arr[i] == "fcother.js")
			{
				strTemp = "  adv_loadjsfile('eformsys/jxc/dj/" + basePath + "/js/" + arr[i] + "');";
			}
			else if (arr[i].substring(0, 1) == "~")
			{
				strTemp = "  adv_loadjsfile('eformsys/jxc/dj/" + basePath
					+ "/../fceformext/js/" + arr[i].substring(1, arr[i].length) + "');";
			}
			else
			{
				strTemp = "  adv_loadjsfile('eformsys/jxc/dj/" + basePath + "/js/" + arr[i] + "');";
			}
			
			sAttach_p.append('if(!bDgMode) out.println("' + strTemp + '");' + strSwLine);	
			
			if (arr[i] == "fcsavedj.js" || arr[i] == "selectdate.js"
					|| arr[i] == "fcother.js")
			{
				strTemp = "<script defer src='" + basePath + "/js/"+ arr[i] + "'></" + "script>";
			} 
			else if (arr[i].substring(0, 1) == "~") 
			{
				strTemp = "<script src='" + basePath
					+ "/../fceformext/js/" + arr[i].substring(1, arr[i].length)
					+ "'></" + "script>";
			} 
			else
			{
				strTemp = "<script src='" + basePath + "/js/" + arr[i] + "'></" + "script>";
			}
			sAttach_p.append('if(bDgMode) out.println("' + strTemp + '");' + strSwLine);
		}
		
		strTemp = "</script>";
		sAttach_p.append('if(!bDgMode) out.println("' + strTemp + '");' + strSwLine);
		
		for (var i = 0; i < l; i++) 
		{
			if(arr[i].indexOf("/dwr/")>0)
			{
				strTemp = "<script src='" + basePath + "/js/" + arr[i] + "'></" + "script>";
				sAttach_p.append('out.println("' + strTemp + '");' + strSwLine);
				count++;
			}
		}
		
		sAttach_p.append("%>");
	}
	var sAttach = new StringBuffer();
	// added by zhou.luo in 2008-10-16 为表单添加自定义的css
	var creator_csslib = SKbillsheet.creator_csslib;
	if (!isSpace(creator_csslib)) {
		var cc_arr = creator_csslib.split("\r\n");
		var cc_l = cc_arr.length;
		var cc_num1 = 0;
		for (var j = 0;j < cc_l; j++) {
			if (isSpace(cc_arr[j])) {
				continue;
			} else {
				cc_num1++;
				if (cc_num1 == 1) {
					sAttach.append("<script language='javascript'>").append(strSwLine);
				}
			}
			sAttach.append("<%if(bDgMode){%>");
			sAttach.append("var mylink").append(j)
					.append(" = document.createElement(\"link\");").append(strSwLine);
			sAttach.append("mylink").append(j)
					.append(".setAttribute(\"type\",\"text/css\");").append(strSwLine);
			sAttach.append("mylink").append(j)
					.append(".setAttribute(\"rel\",\"stylesheet\");").append(strSwLine);
			sAttach
					.append("mylink")
					.append(j)
					.append(".setAttribute(\"href\",stylePath+\"css/"+fcpubdata.creatorStyle+"/")
					.append(cc_arr[j]).append("\");").append(strSwLine);
			sAttach.append("var myhead").append(j)
					.append(" = document.getElementsByTagName(\"head\")[0];").append(strSwLine);
			sAttach.append("myhead").append(j).append(".appendChild(mylink")
					.append(j).append(");").append(strSwLine);
			sAttach.append("<%}else{%>");
			sAttach.append("adv_loadjsfile(stylePath+'css/" + fcpubdata.creatorStyle+ "/"+cc_arr[j]+"');")
					.append(strSwLine);
			sAttach.append("<%}%>");
		}		
		sAttach.append("</").append("script>");
	}
	var sAttach1 = new StringBuffer();
	sAttach1.append("\r\n");
	sAttach1.append("<script language='javascript'>");
	sAttach1.append("\r\nadv_loadjsfile('/eformsys/fceform/css/tabstyle.css');");
	// 为表单添加自定义的css end
	var sCode = "\r\n<script >document.styleSheets[0].addRule(\"fc\\\\:fc_code\",\"behavior: url("
			+ basePath + "/htc/fc_code.htc)\",0);</" + "script>\r\n";
	var l = oContXml.documentElement.childNodes.length;
	for (var i = 0;i < l; i++) {
		if (oContXml.documentElement.childNodes(i).childNodes.length > 0) {
			var comtype = oContXml.documentElement.childNodes(i).nodeName;
			switch (comtype) {
				case "dropdownlist" :
					if (sAttach.toString().indexOf(sCode) < 0)
						sAttach.append(sCode);
					break;
				case "spin" :
					sAttach.append("\r\n<script >document.styleSheets[0].addRule(\".xpSpin\",\"behavior: url("
									+ basePath
									+ "/htc/NumEdit.htc)\",0);</"
									+ "script>");
					break;
				case "tab" :
					sAttach1.append("\r\nadv_loadjsfile('/eformsys/fceform/js/webfxlayout.js');");
					sAttach1.append("\r\nadv_loadjsfile('/eformsys/fceform/css/luna/tab.css');");
					break;
				case "grid" :
					sAttach.append("\r\n<script >document.styleSheets[0].addRule(\"fc\\\\:webgrid\",\"behavior: url(")
							.append(basePath).append("/htc/webgrid.htc)\",0);</").append("script>");
					sAttach1.append("\r\nadv_loadjsfile('/eformsys/fceform/js/fcwebgrid.js');");
					if (sAttach.toString().indexOf(sCode) < 0)
						sAttach.append(sCode);
					break;
				case "dataset" :
					sAttach
							.append("\r\n<script >document.styleSheets[0].addRule(\"fc\\\\:dataset\",\"behavior: url(")
							.append(basePath)
							.append("/htc/dataset.htc)\",0);</")
							.append("script>");
					sAttach1.append("\r\nadv_loadjsfile('/eformsys/fceform/js/fcdataset.js');");
					break;
				/* sxb 20081031 增加creatorSubForm.htc */

				case "creatorSubForm" :
					sAttach.append("<script >document.styleSheets[0].addRule(\"fc\\\\:creatorSubForm\",\"behavior: url(").append(basePath)
							.append("/htc/creatorSubForm.htc)\",0);</").append("script>");
					break;

				/* 增加creatorSubForm.htc结束 */
				case "shape" :
					sAttach1.append("\n\radv_loadjsfile('/eformsys/fceform/css/shape.css');");
					break;
				case "tree" :
					sAttach1.append("\r\nadv_loadjsfile('/eformsys/fceform/css/xtree.css');");
					sAttach1.append("\r\nadv_loadjsfile('/eformsys/fceform/js/xtree.js');");
					break;
				case "upload" :
					sAttach1.append("\r\nadv_loadjsfile('/eformsys/fceform/js/fcupload.js')");
					break;
				case "chart" :
					sAttach1.append("\r\nadv_loadjsfile('/eformsys/fceform/js/fcgraph.js');");
					break;
				case "SKDBTreeView" :
					sAttach1.append("\r\nadv_loadjsfile('/eformsys/fceform/js/tree.js');");
					break;
				case "button" :
					sAttach1.append("\r\nadv_loadjsfile('/eformsys/fceform/css/Button.css');");
					break;
				case "text" :
					sAttach1.append("\r\nadv_loadjsfile('/eformsys/fceform/css/TextStyle.css');");
					break;
				case "textarea" :
					sAttach.append("\r\n<script >document.styleSheets[0].addRule(\".fcmask\",\"behavior: url(").append(basePath).append("/htc/fcmask.htc)\",0);</").append("script>");
					sAttach1.append("\r\nadv_loadjsfile('/eformsys/fceform/js/fcmask.vbs');");
					break;
				case "ebshow" ://已经作废
					sAttach.append("<script src='").append(basePath).append("/ereport/js/ebshow.js'></").append("script>");
					break;
				case "ExtGrid" :
					sAttach1.append("\r\nadv_loadjsfile('/eformsys/fceform/js/Ext/SlidingPager.js');");
					sAttach1.append("\r\nadv_loadjsfile('/eformsys/fceform/js/Ext/SliderTip.js');");
					sAttach1.append("\r\nadv_loadjsfile('/eformsys/fceform/js/Ext/PanelResizer.js');");
					sAttach1.append("\r\nadv_loadjsfile('/eformsys/fceform/js/Ext/XmlTextReader.js');");
					sAttach1.append("\r\nadv_loadjsfile('/eformsys/fceform/js/Ext/CreatorMemoryProxy.js');");
					break;
				case "ExtTree" :
					sAttach1.append("\r\nadv_loadjsfile('/eformsys/fceform/js/Ext/CreatorMemoryProxy.js');");
					sAttach1.append("\r\nadv_loadjsfile('/eformsys/fceform/js/Ext/TreeCheckBoxNodeUI.js');");
					break;
				case "ExtUpload" :
					sAttach1.append("\n\radv_loadjsfile('/eformsys/fceform/js/Ext/css/SwfUploadPanel.css');");
					sAttach1.append("\r\nadv_loadjsfile('/eformsys/fceform/js/Ext/SwfUpload.js');");
					sAttach1.append("\r\nadv_loadjsfile('/eformsys/fceform/js/Ext/SwfUploadPanel.js');");
					break;
				case "Fusionchar" :
					sAttach1.append("\r\nadv_loadjsfile('/FusionCharts/Contents/Style.css');");
					sAttach1.append("\r\nadv_loadjsfile('/FusionCharts/JSClass/FusionCharts.js');");
					sAttach1.append("\r\nadv_loadjsfile('/FusionCharts/JSClass/FusionCharts_CN.js');");
					sAttach1.append("\r\nadv_loadjsfile('/FusionCharts/jquery-1.2.6.min.js');");
					sAttach1.append("\r\nadv_loadjsfile('/FusionCharts/s2u.js');");
			}
		}
	}
	sAttach1.append("\n</script>");
	sRun = formatHtmlText(sRun, 1);
	var str_attach = sAttach_p.toString() + strSwLine + formatHtmlText(sAttach.toString()+sAttach1.toString(), -1);
	sRun = str_attach + strSwLine + sRun + sAttachEnd.toString();
	return sRun;
	
	function _RepStrEnter(sRun, s, sFind, sRep) {
		var ilen = s.length;
		var ipos = sRun.indexOf(s);
		if (ipos > -1) {
			sRun = sRun.substring(0, ipos) + sRep
					+ sRun.substring(ipos + ilen, sRun.length);
		} else {
			ipos = sRun.indexOf(sFind);
			if (ipos > -1) {
				sRun = sRun.substring(0, ipos) + sRep
						+ sRun.substring(ipos + ilen, sRun.length);
			}
		}
		return sRun;
	}
	function imgwebgrid_webgrid(oimgGrid) {
		var sRetDs = "";
		var sRetGrid = new StringBuffer();
		var sFormat = "";
		var sonSetText = "";
		var sonGetText = "";
		var sonValid = "";
		var sGridFormat = new StringBuffer();
		var sonclick = new StringBuffer();
		var sondblclick = new StringBuffer();
		var sonkeydown = new StringBuffer();
		sGridFormat.append(" format=\"<cols>");
		sonclick.append(" onclick='bill_ongridclick(\"<" + oimgGrid.id + ">");
		sondblclick.append(" ondblclick='bill_ongriddblclick(\"<" + oimgGrid.id+ ">");
		sonkeydown.append(" onkeydown='bill_ongridkeydown(\"<" + oimgGrid.id+ ">");
		if (isSpace(oimgGrid.dataset) == false) {
			var ods_formatxml = eval(oimgGrid.dataset);
			if (isSpace(ods_formatxml.formatxml) == false) {
				var oXml = SetDom(ods_formatxml.formatxml);
				var l = oXml.documentElement.childNodes.length;
				for (var i = 0;i < l; i++) {
					var fdname = oXml.documentElement.childNodes(i).childNodes(0).text;
					var datatype = oXml.documentElement.childNodes(i).childNodes(2).text;
					var displaylabel = oXml.documentElement.childNodes(i).childNodes(1).text;
					var size = oXml.documentElement.childNodes(i).childNodes(3).text;
					var precision = oXml.documentElement.childNodes(i).childNodes(4).text;
					if (oXml.documentElement.childNodes(i).childNodes(9).text == "是") {
						sGridFormat.append("<col>");
						sGridFormat.append("<fname>").append(fdname).append("</fname>");
						sGridFormat.append("<cname>").append(displaylabel).append("</cname>");
						sGridFormat.append("<width>").append(size).append("</width>");
						sGridFormat.append("<dtype>").append(datatype).append("</dtype>");
						sGridFormat.append("<readonly>").append(oXml.documentElement.childNodes(i).childNodes(8).text).append("</readonly>");
						sGridFormat.append("<visible>").append(oXml.documentElement.childNodes(i).childNodes(9).text).append("</visible>");
						sGridFormat.append("<u></u><v></v><s></s><r></r>");
						sGridFormat.append("<columnwidth>").append(oXml.documentElement.childNodes(i).childNodes(19).text).append("</columnwidth>");
						sGridFormat.append("<align>").append(oXml.documentElement.childNodes(i).childNodes(18).text).append("</align>");
						sGridFormat.append("</col>");
						sonclick.append("<col>").append(quot_xml(oXml.documentElement.childNodes(i).childNodes(24).text)).append("</col>");
						sondblclick.append("<col>").append(quot_xml(oXml.documentElement.childNodes(i).childNodes(25).text)).append("</col>");
						sonkeydown.append("<col>").append(quot_xml(oXml.documentElement.childNodes(i).childNodes(23).text)).append("</col>");
					}
				}
			}
		}
		sGridFormat.append("</cols>\" ");
		sonclick.append("</").append(oimgGrid.id).append(">\")' ");
		sondblclick.append("</").append(oimgGrid.id).append(">\")' ");
		sonkeydown.append("</").append(oimgGrid.id).append(">\")' ");
		sRetGrid.append("<fc:webgrid visible='").append(oimgGrid.visible)
				.append("' readonly='").append(oimgGrid.readonly)
				.append("' autoappend='").append(oimgGrid.autoappend)
				.append("' autowidth='").append(oimgGrid.autowidth)
				.append("' autoheight='").append(oimgGrid.autoheight)
				.append("' canselect='").append(oimgGrid.canselect)
				.append("' ").append(_GetGridProp("SetRowHeight",
						oimgGrid.SetRowHeight)).append(_GetGridProp(
						"hideVscroll", oimgGrid.hideVscroll))
				.append(_GetGridProp("hideHscroll", oimgGrid.hideHscroll))
				.append(_GetGridProp("autosize", oimgGrid.autosize))
				.append(_GetGridProp("bodyrowheight", oimgGrid.bodyrowheight))
				.append(_GetGridProp("bodyrows", oimgGrid.bodyrows));
		sRetGrid.append(" id=").append(oimgGrid.id).append(" dataset=")
				.append(oimgGrid.dataset).append(" ");
		try {
			if (oimgGrid.parentNode.id == "fcpagesub"
					|| oimgGrid.parentNode.controltype == "div") {
				sRetGrid.append(" ParentPos='相对' ");
			}
		} catch (e) {
		}
		var widthText = oimgGrid.style.width;
		if (!IsSpace(widthText) && (widthText.indexOf('%') > 0)) {
			var windowWidth = window.screen.availWidth;
			widthText = widthText.substring(0, widthText.indexOf('%'));
			var realWidth = Math.round(eval(windowWidth
					* (eval(widthText / 100))));
		}
		sRetGrid.append(" left=" + oimgGrid.style.posLeft + " top="
				+ oimgGrid.style.posTop + " height="
				+ (oimgGrid.style.posHeight - 17) + " width="
				+ (oimgGrid.style.width));
		if (oimgGrid.usertitle == "是") {
			sRetGrid.append(" multihead=\"" + oimgGrid.usertitlehtml + "\" ");
			sRetGrid.append(" headrows=\"" + oimgGrid.titlerows + "\" ");
		}
		sRetGrid.append(sGridFormat);
		sRetGrid.append(sonclick);
		sRetGrid.append(sondblclick);
		sRetGrid.append(sonkeydown);
		sRetGrid.append(" >");
		var tabcss = "BORDER-COLLAPSE:collapse;TABLE-LAYOUT:fixed;left:0px;POSITION:absolute;top:0px;";
		var trcss = "";
		var tmps = CssPart(oimgGrid.csstext1);
		if (isSpace(tmps) == false) {
			tabcss += tmps;
		}
		var tmps = CssPart(oimgGrid.csstext2);
		trcss = tmps;
		var tmprowheight = oimgGrid.titlerowheight;
		if (isSpace(tmprowheight) == false) {
			trcss += ";height:" + tmprowheight;
		}
		sRetGrid.append("<table id=t cellPadding=1 cellSpacing=0 width=100% frame=box style=\""
						+ tabcss
						+ "\" > <tr style=\""
						+ trcss
						+ " \" class=\"fcGridFirstRow\" ><td></td></tr></table></fc:webgrid>");
		return sRetGrid.toString();
		function _GetGridProp(propName, propValue) {
			var s_SetRowHeight = propValue;
			if (IsSpace(s_SetRowHeight)) {
				s_SetRowHeight = "";
			} else {
				s_SetRowHeight = " " + propName + "='" + s_SetRowHeight + "' ";
			}
			return s_SetRowHeight
		}
	}
	function imgdataset_dataset(oimgGrid) {
		var sRetDs = new StringBuffer();
		var sRetGrid = "";
		var sFormat = "";
		var sonSetText = "";
		var sonGetText = "";
		var sonValid = "";
		var sGridFormat = "";
		var sonclick = "";
		var sondblclick = "";
		var sonkeydown = "";
		sRetDs.append("<fc:dataset");
		sRetDs.append(" id=" + oimgGrid.id);
		sRetDs.append(" opensortno='" + oimgGrid.opensortno + "'");
		if (isSpace(oimgGrid.chnname) == false) {
			sRetDs.append(" chnname='" + oimgGrid.chnname + "'");
		}

		// zzy
		if (isSpace(oimgGrid.showType) == false) {
			sRetDs.append(" showtypeXml='" + oimgGrid.showType + "'");
		}
		if (isSpace(oimgGrid.showType) == false) {
			sRetDs.append(" columnHeight1Xml='" + oimgGrid.columnHeight1 + "'");
		}
		if (isSpace(oimgGrid.showType) == false) {
			sRetDs.append(" columnWidth1Xml='" + oimgGrid.columnWidth1 + "'");
		}

		if (!isSpace(oimgGrid.fieldtrans)) {
			sRetDs.append(" fieldtrans='" + oimgGrid.fieldtrans + "'");
		}
		if (!isSpace(oimgGrid.runclass)) {
			sRetDs.append(" runclass='" + oimgGrid.runclass + "'");
		}
		if (!isSpace(oimgGrid.temptable)) {
			sRetDs.append(" temptable=" + oimgGrid.temptable);
		}
		if (!isSpace(oimgGrid.saveastable)) {
			sRetDs.append(" saveastable=" + oimgGrid.saveastable);
		}
		if (!isSpace(oimgGrid.multiResult)) { // 为dataset添加multiResult属性。表示返回的结果是否为多条记录。
			sRetDs.append(" multiResult=" + oimgGrid.multiResult);
		}
		if (!isSpace(oimgGrid.BeforeOpen)) {
			sRetDs.append(" BeforeOpen='bill_dsevent(\"BeforeOpen\",\""
					+ quot_42(oimgGrid.BeforeOpen) + "\")'");
		}
		if (!isSpace(oimgGrid.AfterOpen)) {
			sRetDs.append(" AfterOpen='bill_dsevent(\"AfterOpen\",\""
					+ quot_42(oimgGrid.AfterOpen) + "\")'");
		}
		if (!isSpace(oimgGrid.BeforePost)) {
			sRetDs.append(" BeforePost='bill_dsevent(\"BeforePost\",\""
					+ quot_42(oimgGrid.BeforePost) + "\")'");
		}
		if (!isSpace(oimgGrid.AfterPost)) {
			sRetDs.append(" AfterPost='bill_dsevent(\"AfterPost\",\""
					+ quot_42(oimgGrid.AfterPost) + "\")'");
		}
		if (!isSpace(oimgGrid.BeforeScroll)) {
			sRetDs.append(" BeforeScroll='bill_dsevent(\"BeforeScroll\",\""
					+ quot_42(oimgGrid.BeforeScroll) + "\")'");
		}
		if (!isSpace(oimgGrid.AfterScroll)) {
			sRetDs.append(" AfterScroll='bill_dsevent(\"AfterScroll\",\""
					+ quot_42(oimgGrid.AfterScroll) + "\")'");
		}
		sFormat = new StringBuffer().append(" format=\"<fields>");
		sonSetText = " onSetText='bill_ondatasetsettext(\"<dsid>";
		sonGetText = " onGetText='bill_ondatasetgettext(\"<dsid>";
		sonValid = " onValid='bill_ondatasetvalid(\"<dsid>";
		if (isSpace(oimgGrid.formatxml) == false) {
			var oXml = SetDom(oimgGrid.formatxml);

			// zzy
			var showtypeXml = SetDom(oimgGrid.showType);
			var columnHeight1Xml = SetDom(oimgGrid.columnHeight1);
			var columnWidth1Xml = SetDom(oimgGrid.columnWidth1);

			var l = oXml.documentElement.childNodes.length;
			var bln = false;
			if (l > 0) {
				if (oXml.documentElement.childNodes(0).childNodes.length <= 26)
					bln = true;
			}
			for (var i = 0;i < l; i++) {
				var fdname = oXml.documentElement.childNodes(i).childNodes(0).text;
				var datatype = oXml.documentElement.childNodes(i).childNodes(2).text;
				var displaylabel = oXml.documentElement.childNodes(i).childNodes(1).text;
				var size = oXml.documentElement.childNodes(i).childNodes(3).text;
				var precision = oXml.documentElement.childNodes(i)
						.childNodes(4).text;

				// zzy
				var showtype = null;
				try {
					showtype = showtypeXml.documentElement.selectSingleNode("//showType[name='" + fdname
									+ "']").childNodes(1).xml;
				} catch (e) {
					showtype = "";
				}
				var columnHeight1 = null;
				try {
					columnHeight1 = columnHeight1Xml.documentElement.selectSingleNode("//columnHeight1[name='" + fdname
									+ "']").childNodes(1).xml;
				} catch (e) {
					columnHeight1 = "";
				}
				var columnWidth1 = null;
				try {
					columnWidth1 = columnWidth1Xml.documentElement.selectSingleNode("//columnWidth1[name='" + fdname
									+ "']").childNodes(1).xml;
				} catch (e) {
					columnWidth1 = "";
				}

				sFormat.append("<field>");
				sFormat.append("<fieldname>" + fdname + "</fieldname>");
				sFormat.append("<datatype>" + datatype + "</datatype>");
				sFormat.append("<displaylabel>" + displaylabel+ "</displaylabel>");
				sFormat.append("<size>" + size + "</size>");
				sFormat.append("<precision>" + precision + "</precision>");
				sFormat.append("<fieldkind>"+ oXml.documentElement.childNodes(i).childNodes(5).text+ "</fieldkind>");
				sFormat.append("<defaultvalue>"+ oXml.documentElement.childNodes(i).childNodes(6).text+ "</defaultvalue>");
				sFormat.append("<displayformat>"+ oXml.documentElement.childNodes(i).childNodes(7).text+ "</displayformat>");
				sFormat.append("<isnull>"+ oXml.documentElement.childNodes(i).childNodes(11).text + "</isnull>");
				sFormat.append("<iskey>"+ oXml.documentElement.childNodes(i).childNodes(10).text + "</iskey>");
				sFormat.append("<valid>"+ oXml.documentElement.childNodes(i).childNodes(12).text + "</valid>");
				sFormat.append("<procvalid>"+ oXml.documentElement.childNodes(i).childNodes(13).text + "</procvalid>");
				sFormat.append("<link>"+ oXml.documentElement.childNodes(i).childNodes(15).text + "</link>");
				sFormat.append("<target>"+ oXml.documentElement.childNodes(i).childNodes(16).text + "</target>");
				sFormat.append("<href>"+ oXml.documentElement.childNodes(i).childNodes(17).text + "</href>");
				sFormat.append("<visible>"+ oXml.documentElement.childNodes(i).childNodes(9).text+ "</visible>");
				sFormat.append("<primarykey>"+ oXml.documentElement.childNodes(i).childNodes(14).text + "</primarykey>");
				if (bln) {
					sFormat.append("<fieldvalid></fieldvalid>");
					sFormat.append("<tag></tag>");
				} else {
					sFormat.append("<fieldvalid>"+ oXml.documentElement.childNodes(i).childNodes(26).text+ "</fieldvalid>");
					sFormat.append("<tag>"+ oXml.documentElement.childNodes(i).childNodes(27).text + "</tag>");
				}

				// zzy
				sFormat.append("<showtype>" + showtype + "</showtype>");
				sFormat.append("<columnHeight1>" + columnHeight1
						+ "</columnHeight1>");
				sFormat.append("<columnWidth1>" + columnWidth1
						+ "</columnWidth1>");

				sFormat.append("</field>");
				sonSetText += "<"
						+ fdname
						+ ">"
						+ quot_xml(oXml.documentElement.childNodes(i)
								.childNodes(21).text) + "</" + fdname + ">";
				sonGetText += "<"
						+ fdname
						+ ">"
						+ quot_xml(oXml.documentElement.childNodes(i)
								.childNodes(20).text) + "</" + fdname + ">";
				sonValid += "<"
						+ fdname
						+ ">"
						+ quot_xml(oXml.documentElement.childNodes(i)
								.childNodes(22).text) + "</" + fdname + ">";
			}
		}
		sFormat.append("</fields>\"");
		sonSetText += "</dsid>\")' ";
		sonGetText += "</dsid>\")' ";
		sonValid += "</dsid>\")' ";
		sRetDs.append(sFormat);
		if (isSpace(oimgGrid.opensql) == false) {
			sRetDs.append(" sqltrans=\"" + SqlPropTrans(oimgGrid.opensql)
					+ "\"");
		}
		var oNode = oContXml.documentElement.selectSingleNode("grid");
		if (oNode != null) {
			var l = oNode.childNodes.length;
			for (var i = 0;i < l; i++) {
				var oimgGrid1 = eval(oNode.childNodes(i).text);
				if (oimgGrid1.iscrosstab == "是") {
					var s1 = "";
					s1 = "<sql>" + SqlPropTrans(oimgGrid1.crosstabsql)
							+ "</sql>";
					s1 += "<no>" + oimgGrid1.crosstabdatatype + "</no>";
					s1 += "<no>" + oimgGrid1.crosstabsumtype + "</no>";
					var i1 = 0;
					if (oimgGrid1.rcount == "是")
						i1 += 1;
					if (oimgGrid1.rsum == "是")
						i1 += 2;
					if (oimgGrid1.rmin == "是")
						i1 += 4;
					if (oimgGrid1.rmax == "是")
						i1 += 8;
					if (oimgGrid1.ravg == "是")
						i1 += 10;
					var i2 = 0;
					if (oimgGrid1.ccount == "是")
						i2 += 1;
					if (oimgGrid1.csum == "是")
						i2 += 2;
					if (oimgGrid1.cmin == "是")
						i2 += 4;
					if (oimgGrid1.cmax == "是")
						i2 += 8;
					if (oimgGrid1.cavg == "是")
						i2 += 10;
					s1 += "<no>" + i1 + "</no>";
					s1 += "<no>" + i2 + "</no>";
					s1 += "<format>" + oimgGrid1.crosstabformat + "</format>";
					s1 += "<rowstr>" + oimgGrid1.rowtitle + "</rowstr>";
					s1 += "<colstr>" + oimgGrid1.coltitle + "</colstr>";
					sRetDs.append(" crossvalue=\"" + s1 + "\" ");
				}
			}
		}
		sRetDs.append(sonSetText);
		sRetDs.append(sonGetText);
		sRetDs.append(sonValid);
		sRetDs.append(" ></fc:dataset>");
		return sRetDs.toString();
	}
}
function OpenControlNo(s, ArrNum) {
	var arr = s.split(";");
	var l = arr.length;
	for (var i = 0;i < l; i++) {
		var arr1 = arr[i].split(":");
		ArrNum[arr1[0]] = arr1[1];
	}
	return ArrNum;
}
function quot_xml(s) {
	s = RepStr(s, "'", "&amp;quot;");
	return s;
}
function quot_42(s) {
	var s1 = "";
	s = RepStr(s, "'", s1 + "\\42");
	return s;
}
function fc_shaperesize() {
	var o = event.srcElement;
	if (o.id1 == 3 || o.id1 == 7 || o.id1 == 8) {
		o.to = "" + o.style.pixelWidth + ",0";
	}
	if (o.id1 == 2 || o.id1 == 5 || o.id1 == 6) {
		o.to = "0," + o.style.pixelHeight + "";
	}
	if (o.id1 == 1 || o.id1 == 10 || o.id1 == 11) {
		o.from = "0," + o.style.pixelHeight;
		o.to = "" + o.style.pixelWidth + ",0";
	}
	if (o.id1 == 4 || o.id1 == 9 || o.id1 == 12) {
		o.to = " " + o.style.pixelWidth + "," + o.style.pixelHeight + " ";
	}
}
function TransXml(sRun) {
	sRun = RepStr(sRun, "&", "&amp;");
	sRun = RepStr(sRun, ">", "&gt;");
	sRun = RepStr(sRun, "<", "&lt;");
	sRun = RepStr(sRun, "\r\n", "&#13;&#10;");
	if (fcpubdata.databaseTypeName == "sqlserver"
			|| fcpubdata.databaseTypeName == "mysql")
		sRun = RepStr(sRun, "'", "&apos;&apos;");
	return sRun;
}
function UnTransXml(sRun) {
	sRun = RepStr(sRun, "&amp;", "&");
	sRun = RepStr(sRun, "&gt;", ">");
	sRun = RepStr(sRun, "&lt;", "<");
	sRun = RepStr(sRun, "&#13;&#10;", "\r\n");
	sRun = RepStr(sRun, "&apos;", "'");
	return sRun;
}
function TransSql(sRun) {
	if (fcpubdata.databaseTypeName == "oracle"
			|| fcpubdata.databaseTypeName == "db2")
		return sRun;
	sRun = RepStr(sRun, "'", "''");
	return sRun;
}
function HideListBoxSave(oPage) {
	var sTag1
	var oList = oPage.all.tags("select")
	var sRet
	var l = oList.length
	for (var i = 0;i < l; i++) {
		if (oList(i).style.posWidth > 0) {
			return oPage.innerHTML;
		} else {
			oList(i).style.width = oList(i).backwidth
			oList(i).style.height = oList(i).backheight
		}
	}
	sRet = oPage.innerHTML;
	for (var i = 0;i < l; i++) {
		oList(i).style.posWidth = 0
		oList(i).style.posHeight = 0
	}
	return sRet
}
function e_savedj() {
	var obj = parent.dialogArguments;
	var arr = DesignDjSave("不提示", "是", "是");
	obj.eform_design = escape(arr[0]);
	obj.eform_run = escape(arr[1]);
	obj.eform_function = escape(arr[2]);
	obj.eform_addhtml = escape(arr[3]);
	blnChange = false;
	parent.close();
}
function e_opendj() {
	var obj = parent.dialogArguments;
	var s1 = obj.eform_design;
	if (typeof s1 == "undefined")
		s1 = "";
	var s2 = obj.eform_function;
	if (typeof s2 == "undefined")
		s2 = "";
	var s3 = obj.eform_addhtml;
	if (typeof s3 == "undefined")
		s3 = "";
	DesignDjOpenSub([Trim(unescape(s1)), "", unescape(s2), unescape(s3)]);
	SKbillsheet.entertype = "展现";
}

function creator_pt_createExtGrid(obj) {
	try {		
		var returnstr = new StringBuffer();
		returnstr.append("<img style='display:none'/><div style='position:" + obj.style.position
				+";width:"+(obj.isChecked=='yes'?obj.txt_width+"":obj.width+"")+ ";left:" + obj.style.left + ";top:" + obj.style.top
				+ "'><div id=div_"+obj.id+"></div></div>");
		returnstr.append('<script type="text/javascript">var '+obj.id+';\n');
		returnstr.append("Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';\n");
		returnstr.append('var ' + obj.id + '_retint = 0;\n');
		returnstr.append('var ' + obj.id + '_onReady = function(){\n');
		returnstr.append('var dataset = document.getElementById("'+ obj.dataset + '");\n');
		returnstr.append('try{var temp = dataset.Fields.Field.length;}catch(e){if('
						+ obj.id + '_retint==0) '
						+ obj.id + '_retint = setInterval('
						+ obj.id
						+ '_onReady,200);dataset =null;return;}finally{if(temp!=null)temp=null;}\n');
		var temp = -1;
		if (eval(obj.isPage)) {
			temp = obj.pagesize;
		}
		returnstr.append('clearInterval(' + obj.id + '_retint);' + obj.id
				+ '_retint = null ;var pagesize =' + temp + ';\n');
		returnstr.append('dataset.PageSize = pagesize ;\n');
		returnstr.append('var mapping = creator_pt_getmapping(dataset);\n');
		if (eval(obj.isGroup)) {
			returnstr.append('var store  = new Ext.data.GroupingStore({\n');
			returnstr.append('	proxy: new Ext.data.CreatorMemoryProxy(\n"'
					+ obj.dataset + '"), \n');
			returnstr.append("	reader: new Ext.data.XmlStringReader({\n");
			returnstr.append("       record: 'tr',\n");
			returnstr.append("       totalRecords: 'pages'\n");
			returnstr.append("   }, mapping),\n");
			returnstr.append("	sortInfo:{field: '" + obj.sortField
					+ "', direction: 'ASC'},\n");
			returnstr.append("    groupField:'" + obj.groupField + "'\n");
			returnstr.append("});");
			returnstr.append("var view = new Ext.grid.GroupingView({\n");
			returnstr.append("    forceFit:true,\n");
			returnstr.append("    groupTextTpl: '{text} (共 {[values.rs.length]} 项)'");
			returnstr.append("});\n");
		} else {
			returnstr.append('var store  = new Ext.data.Store({\n');
			returnstr.append('	proxy: new Ext.data.CreatorMemoryProxy("'
					+ obj.dataset + '"), \n');
			returnstr.append("	reader: new Ext.data.XmlStringReader({");
			returnstr.append("       record: 'tr',");
			returnstr.append("       totalRecords: 'pages'");
			returnstr.append("   }, mapping)");
			returnstr.append("});\n");
		}
		returnstr.append("var sm = new Ext.grid.RowSelectionModel({singleSelect: true});\n");
		var tempstr = eval(obj.isEdit) ? ",'true'" : "";
		returnstr.append("var retcm = creator_pt_getcm(dataset" + tempstr
				+ ",sm);var cm = new Ext.grid.ColumnModel(retcm);\n");
		returnstr.append("if(typeof(retcm[0].getCount)!='undefined') sm = retcm[0] ;\n");
		if (eval(obj.isEdit)) {
			returnstr.append("var n =0;\n");
			returnstr.append("mapping.push({name:'modnum',type:'string'});\n");
			returnstr.append("mapping.push({name:'opflag',type:'string'});\n");
			returnstr.append(obj.id+" = new Ext.grid.EditorGridPanel({\n");
			returnstr.append("clicksToEdit:2,");
			returnstr.append("tbar: [{");
			returnstr.append("    text: '新增数据',");
			returnstr.append("    handler : function(){\n");
			returnstr.append("       var record = Ext.data.Record.create(mapping);\n");
			returnstr.append("    	var tempR='{ ';\n");
			returnstr.append("		for(var i=0;i<mapping.length;++i){\n");
			returnstr.append("			if(mapping[i].name=='modnum'||mapping[i].name=='opflag') continue;\n");
			returnstr.append(" 			var defValue=dataset.Fields.Field[mapping[i].mapping].DefaultValue;\n");
			returnstr.append('			defValue=IsSpace(defValue)?\'""\':defValue;');
			returnstr.append("			tempR+=mapping[i].name+' : '+defValue+',';");
			returnstr.append("		}");
			returnstr.append("		tempR=tempR.replace(/,$/g,\"\")+'  }';\n");
			returnstr.append("		var p = new record(eval('('+tempR+')'));\n");
			returnstr.append(" 		p.set('opflag','add');\n");
			returnstr.append("		p.set('modnum',n);\n");
			returnstr.append("		++n;");
			returnstr.append("       "+obj.id+".stopEditing();\n");
			returnstr.append("       store.insert(0, p);\n");
			returnstr.append("       "+obj.id+".startEditing(0, 0);\n");
			returnstr.append("    }");
			returnstr.append("},");
			returnstr.append("{");
			returnstr.append("    text: '删除数据',");
			returnstr.append("     handler : function(){\n");
			returnstr.append("        var record = "+obj.id+".getSelectionModel().getSelected();if(IsSpace(record)){alert('请选择一行数据');return;}\n");
			returnstr.append("    	 if(record.get('opflag')=='add'){\n");
			returnstr.append("			var tempMod = store.modified;\n");
			returnstr.append("			var tempN = record.get('modnum');\n");
			returnstr.append("			for(var i=0;i<tempMod.length;++i){\n");
			returnstr.append("				if(tempMod[i].get('modnum') == tempN){\n");
			returnstr.append("					store.modified.splice(i,1);\n");
			returnstr.append("					break;\n");
			returnstr.append("				}\n");
			returnstr.append("			}");
			returnstr.append("}");
			returnstr.append("		if(IsSpace(record.get('opflag'))){\n");
			returnstr.append("			record.set('opflag','del');\n");
			returnstr.append("		}");
			returnstr.append("        "+obj.id+".stopEditing();\n");
			returnstr.append("       store.remove(record);\n");
			returnstr.append("       "+obj.id+".startEditing(0, 0);\n");
			returnstr.append("   }\n");
			returnstr.append("}\n");
			returnstr.append("],");
		} else {
			returnstr.append(" "+obj.id+" = new Ext.grid.GridPanel({\n");
		}
		returnstr.append("		el: 'div_" + obj.id + "',");
		returnstr.append("        store: store,\n");
		returnstr.append("        cm:cm,\n");
		returnstr.append("		sm: sm,\n");
		returnstr.append(" 			 bodyStyle : 'width:100%',\n");
		returnstr.append("		viewConfig: {\n");
		returnstr.append("			forceFit: true");
		returnstr.append("		},");
		returnstr.append("       loadMask: true,\n");
		if (eval(obj.isGroup)) {
			returnstr.append("		view:view,");
		}
		if(obj.isChecked=='yes'){
			//returnstr.append("	width: '"+obj.txt_width+"',\n" );
			returnstr.append("	width: '100%',\n" );
			if(obj.txt_div==''||typeof(obj.txt_div)=='undefined'){
				returnstr.append("					height: eval(document.body.clientHeight*(parseFloat('"+obj.txt_height+"')))/100,\n");
			}else{
				returnstr.append("					height: eval(parseFloat(document.getElementById('"+obj.txt_div+"').style.height)*(parseFloat('"+obj.txt_height+"')))/100-60,\n");
			}
		}else{
			//returnstr.append("		width:" + obj.width + ",");
			returnstr.append("		width:'100%',");
			returnstr.append("      height:" + obj.height + ",");
		}
		returnstr.append("		split: true,\n");
		returnstr.append("		region: 'north',\n");
		returnstr.append("		title:'" + obj.GridTitle + "',\n");
		returnstr.append("		frame:true\n");
		if (eval(obj.isPage)) {
			returnstr.append("		,plugins: new Ext.ux.PanelResizer({\n");
			returnstr.append("            minHeight: 100");
			returnstr.append("        }),\n");
			returnstr.append("       bbar: new Ext.PagingToolbar({\n");
			returnstr.append("            pageSize: pagesize,\n");
			returnstr.append("            store: store,\n");
			returnstr.append("            displayInfo: true,\n");
			returnstr.append("            displayMsg:'当前显示第 {0} - {1} 条，共 {2} 条',");
			returnstr.append("            plugins: new Ext.ux.SlidingPager()");
			returnstr.append("        })		");
		}
		returnstr.append("    });\n");
		returnstr.append("    var grid="+obj.id+";\n");
		returnstr.append(obj.usercode);
		returnstr.append(obj.id+".render();\n");
		if (!eval(obj.isPage)) {
			returnstr.append("store.load();\n");
		} else {
			returnstr.append("store.load({params:{start:0, limit:pagesize}});\n");
		}
		returnstr.append("if(typeof(creator_pt_grids)=='undefined'){creator_pt_grids=new Array();}\n");
		returnstr.append("creator_pt_grids.push({id:'" + obj.id
				+ "',obj:"+obj.id+",dataset:'" + obj.dataset + "',isEdit:'"
				+ obj.isEdit + "'});\n");
		// 这里必须用setTimeout，否则就要报IE无法打开Internet站点的错
		returnstr.append("if(typeof(onGridPanelLoaded)=='function') setTimeout(onGridPanelLoaded,0);\n");
		returnstr.append("};\n");
		returnstr.append(obj.id + '_onReady();');
		if(obj.isChecked=='yes'){
		if(obj.txt_div==''||typeof(obj.txt_div)=='undefined'){
		 	returnstr.append("window.onresize=function(){try{");
 	    	returnstr.append(obj.id+".setWidth(0);"+obj.id+".setWidth(div_"+obj.id+".parentNode.offsetWidth);}catch(e){}};");
		}}
		returnstr.append("</script>");
		return returnstr.toString();
	} catch (e) {
	} finally {
		returnstr = null
	}
}

function creator_pt_createExtUpload(obj) {
	if (!eval(obj.uploadisuse) && !eval(obj.readable)) {
		return "";
	}
	var str = new StringBuffer();
	str.append("<div id='div_" + obj.id + "' style='position:"
			+ obj.style.position + ";left:" + obj.style.left + ";top:"
			+ obj.style.top + "' ></div>\n");
	str.append("&nbsp;<script type='text/javascript'>\n");
	str.append("Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';\n");
	str.append("var w_" + obj.id + " = " + obj.style.width.replace("px", '')+ ";\n");
	str.append("var h_" + obj.id + " = " + obj.style.height.replace("px", '')+ ";\n");
	str.append("var upobj_" + obj.id + ";var refidtemp;var attachidtemp;\n");
	str.append("var fileListGrid_" + obj.id + ";\n");
	str.append("var del_" + obj.id + " = eval('" + obj.deleteisuse + "');\n");
	str.append("var isflow = IsSpace(fcpubdata.cc_form_instanceid)?-1:1;\n");
	str.append('var ' + obj.id + '_retint = 0;\n');
	str.append('var ' + obj.id + '_onReady = function(){\n');
	str.append('if(' + obj.id + '_retint==0) {' + obj.id+ '_retint = setInterval(' + obj.id + '_onReady,200);return;}\n');
	str.append('if(document.readyState!="complete") return;\n');
	str.append('clearInterval(' + obj.id + '_retint);' + obj.id+ '_retint = null ;\n');
	str.append("var urls = eval('getContextPath()');\n");
	str.append("var _djsn = localWindowParams(\"djsn\");\n");
	str.append("var _djid = localWindowParams(\"djid\");\n");
	str.append("var _djbh = localWindowParams(\"djbh\");\n");
	str.append("if(typeof(creator_pt_djbh)!='undefined') _djbh=creator_pt_djbh;\n");
	str.append("if(IsSpace(_djbh)&&isflow==-1) return;\n");
	str.append("var urls = urls+'/servlet/CreatorPTServlet?key=ExtUpload';\n");
	str.append("urls += '&uploadid=" + obj.id + "';\n");
	str.append("urls += '&djsn='+_djsn;\n");
	str.append("urls += '&djid='+_djid;\n");
	str.append("urls += '&djbh='+_djbh;\n");
	str.append("urls += '&creator=<%=accesscontroler.getUserID()%>';\n");
	str.append("urls += '&savetofile=" + obj.savetype + "';\n");
	str.append("urls += '&savefiledir=" + obj.savefiledir + "';\n");
	str.append("var uploadFinishFlag = false;\n");
	str.append("	function createUpload(){\n");
	str.append("	var uploader = new Ext.ux.SwfUploadPanel({\n");
	str.append("		title: '" + obj.title + "'\n");
	str.append("		, width: w_" + obj.id);
	str.append("		, height: h_" + obj.id);
	str.append("		,collapsible : true\n");
	str.append("		,file_size_limit : '" + obj.uploadfilesize + "'\n");
	str.append("		,fc_addfiles : true\n");
	str.append("		,fc_delfiles : true\n");
	str.append("		,fc_uploadfiles :true\n");
	str.append("		, upload_url:urls\n");
	str.append("		, flash_url: '../../fceform/js/Ext/swfupload.swf'\n");
	str.append("		, single_file_select: false\n");
	str.append("		, confirm_delete: false\n");
	str.append("		, remove_completed: false\n");
	str.append("        , file_types : '" + obj.filetypes + "'});\n");
	str.append("	uploader.on('uploadStart',function(obj,file){\n");
	str.append("		if(typeof(Creator_setRelativePath)=='function'){\n");
	str.append("			var relativePath = eval('Creator_setRelativePath()');\n");
	str.append("			if(relativePath=='undefined'||typeof(relativePath)!='string'){\n");
	str.append("				alert('定义的函数Creator_setRelativePath期望返回字符串类型，返回的是【'+typeof(relativePath)+'】，相对路径设置无效！');\n");
	str.append("			}else{\n");
	str.append("				uploader.suo.setUploadURL(urls+'&relativePath='+relativePath);\n");
	str.append("			}\n");
	str.append("		}\n");
	str.append("		var note = obj.store.getById(file.id).get('note');note=IsSpace(note)?\"\":note;\n");
	str.append("		this.addPostParam( 'note',note );\n");
	str.append("		if(IsSpace(_djbh) && isflow==1) {this.addPostParam( 'cc_form_instanceid',fcpubdata.cc_form_instanceid);}\n");
	str.append("	});\n");
	str.append("	uploader.on('swfUploadLoaded',function(obj,file){\n");
	str.append("		uploader.focus();\n");
	str.append("	});\n");
	str.append("	uploader.on('startUpload', function(t) {\n");
	str.append("	});\n");
	str.append("	uploader.on('fileDialogStart', function(t) {if(uploadFinishFlag) {t.store.removeAll(); uploadFinishFlag=false;};\n");
	str.append("	});\n");
	str.append("  uploader.on('fileUploadSuccess',function(t,file,data){t.store.getById(file.id).set('attachid',data.attachid);fcpubdata.cc_form_instanceid=data.cc_form_instanceid;});\n");
	str.append(" uploader.on('allUploadsComplete', function(t, file){\n");
	str.append(" fileListGrid_"+ obj.id+ ".store.reload({params:{cc_form_instanceid:fcpubdata.cc_form_instanceid}});uploadFinishFlag=true;\n");
	if (!IsSpace(obj.donecallback)) {
		str.append("	try{");
		str.append(obj.donecallback);
		str.append("	}catch(e){");
		str.append("	}");
	}
	str.append("});");
	str.append("	upobj_" + obj.id + " = uploader;\n");

	str.append("	return uploader;\n");
	str.append("	}\n");

	str.append("function createGridList(){\n");
	str.append("	var uploadRecode = Ext.data.Record.create([\n");
	str.append("        {name: 'refid', type: 'string'},\n");
	str.append("        {name: 'addTime', type: 'string'},\n");
	str.append("        {name: 'filename', type: 'string'},\n");
	str.append("        {name: 'filetype', type: 'string'},\n");
	str.append("        {name: 'note', type: 'string'},\n");
	str.append("        {name: 'attachid', type: 'string'}\n");
	str.append("    ]);\n");
	str.append("    var store = new Ext.data.Store({\n");
	str.append("        proxy: new Ext.data.HttpProxy({url: urls+'&showlist=showlist'}),\n");
	str.append("        reader: new Ext.data.JsonReader({\n");
	str.append("        totalProperty: 'totalCount',\n");
	str.append("        root: 'result'\n");
	str.append("        },uploadRecode)\n");
	str.append("  });\n");

	str.append("       var sm =new Ext.grid.CheckboxSelectionModel();\n");
	str.append("       sm.handleMouseDown = Ext.emptyFn;\n");

	str.append("        var cm = new Ext.grid.ColumnModel([\n");
	str.append("        new Ext.grid.RowNumberer(),\n");
	str.append("        sm,\n");
	str.append("        {header: '文件名', dataIndex: 'filename',width: '20%',renderer:function(val){return decodeURI(val);}},\n");
	str.append("        {header: '添加时间', dataIndex: 'addTime',width: '20%'},\n");
	str.append("		{header: '类型', dataIndex: 'filetype',width: '20%',renderer:function(val){return decodeURI(val);}},\n");
	str.append("        {header: '备注', dataIndex: 'note',width: '20%',renderer:function(val){return decodeURI(IsSpace(val)?\"\":val);}}\n");
	str.append("    ]);\n");

	str.append("        cm.defaultSortable = true;\n");
	str.append("if(!del_" + obj.id + "){\n");
	str.append("cm.setHidden(1,!del_" + obj.id + ");\n");
	str.append("}\n");

	str.append("        var grid = new Ext.grid.GridPanel({\n");
	str.append("        title: '已上传文件列表',\n");
	str.append("        region: 'center',\n");
	str.append("        loadMask: true,\n");
	str.append("        width: w_" + obj.id + ",\n");
	str.append("	    height: h_" + obj.id + ",\n");
	str.append("             margins : '0 0 0 0',\n");
	str.append("        store: store,\n");
	str.append("        cm: cm,\n");
	str.append("        sm: sm,\n");
	str.append("        tbar: [\n");
	str.append("        {\n");
	str.append("            text: '删除',\n");
	str.append("        iconCls:'deletepanel',\n");
	str.append("            xtype:del_" + obj.id + "?\"\":'hidden',\n");
	str.append("            handler :deleteGrid\n");
	str.append("        },'->'\n");
	str.append("        ],\n");
	str.append("        viewConfig: {\n");
	str.append("        columnsText:'显示的列',\n");
	str.append("        sortAscText:'升序',\n");
	str.append("        sortDescText:'降序',\n");
	str.append("        forceFit: true\n");
	str.append("		}");
	str.append("    });");
	str.append("	grid.on('rowdblclick',function(g,index){\n");
	str.append("		var downloadFrame = document.getElementById(\"downloadFrame\");\n");
	str.append("		if(downloadFrame==null){\n");
	str.append("			downloadFrame = document.createElement(\"iframe\");\n");
	str.append("			downloadFrame.setAttribute(\"id\", \"downloadFrame\");\n");
	str.append("			downloadFrame.setAttribute(\"display\", \"none\");\n");
	str.append("			downloadFrame.setAttribute(\"width\", \"0\");\n");
	str.append("			downloadFrame.setAttribute(\"height\", \"0\");\n");
	str.append("			document.body.appendChild(downloadFrame);\n");
	str.append("		}\n");
	str.append("		downloadFrame.src = getContextPath()+'/servlet/CreatorPTServlet?key=Extdownload&refid='+g.getStore().getAt(index).get('refid');\n");
	//str.append("	var openobj = window; if(typeof(window.dialogArguments) == 'object'){openobj = window.dialogArguments;} \n");
	//str.append("	openobj.open(getContextPath()+'/servlet/CreatorPTServlet?key=Extdownload&refid='+g.getStore().getAt(index).get('refid'),'_blank');\n");
	//str.append("	//window.open(getContextPath()+'/servlet/CreatorPTServlet?key=Extdownload&refid='+g.getStore().getAt(index).get('refid'));\n");
	str.append("	});\n");
	str.append("    store.load({params:{cc_form_instanceid:fcpubdata.cc_form_instanceid}});\n");
	str.append("	fileListGrid_" + obj.id + "  = grid ;\n");
	str.append("    return grid;\n");
	str.append("}\n");
	str.append("function deleteGrid(){\n");
	str.append(" var rows = fileListGrid_" + obj.id+ ".getSelectionModel().getSelections();\n");
	str.append("				if(rows.length==0){\n");
	str.append("				Ext.MessageBox.alert('警告', '最少选择一条信息，进行删除!');\n");
	str.append("				}else{\n");
	str.append("				Ext.MessageBox.confirm('提示框', '您确定要进行该操作？',function(btn){\n");
	str.append("				 var delid=\"\"; var delidw=\"\";\n");
	str.append("				if(btn=='yes'){    \n");
	str.append("					for(var i=0;i<rows.length;i++){\n");
	str.append("					 delid=delid+rows[i].get('refid')+'^';   \n");
	str.append("					}refidtemp=delid;\n");
	str.append("					for(var i=0;i<rows.length;i++){\n");
	str.append("					 delidw=delidw+rows[i].get('attachid')+'^';   \n");
	str.append("					}attachidtemp=delidw;\n");
	str.append("				  Ext.Ajax.request({\n");
	str.append("                  url : urls,\n");
	str.append("                 method : 'POST',\n");
	str.append("                  params : {\n");
	str.append("                      ids : delid,\n");
	str.append("					  deletes :'delete'	\n");
	str.append("                  },\n");
	str.append("                      success: function(response, options) {\n");
	str.append("                       var responseArray = Ext.util.JSON.decode(response.responseText);\n");
	str.append("                            if(responseArray.success==true){\n");
	str.append("								fileListGrid_"+ obj.id+ ".getStore().reload({params:{cc_form_instanceid:fcpubdata.cc_form_instanceid}});\n");
	str.append("                            }\n");
	str.append("                            else{\n");
	str.append("                                Ext.Msg.alert('失败',responseArray.msg);\n");
	str.append("                            }\n");
	str.append("                         }\n");
	str.append("              });\n");
	if (!IsSpace(obj.delcallback)) {
		str.append("					try{");
		str.append(obj.delcallback);
		str.append("					}catch(e){	");
		str.append("					}");
	}
	str.append("				}  ");
	str.append("		});");
	str.append("	}");
	str.append("}");
	str.append("    var panel = new Ext.TabPanel({\n");
	str.append("             title : '上传控件面板',\n");
	if (eval(obj.showtype)) {
		str.append("             renderTo:'div_" + obj.id + "',\n");
	};
	str.append("             id : 'div_" + obj.id + "',\n");
	if(obj._checked=='yes'){
			if (eval(obj.showtype)) {
				str.append("					width: '"+obj._width+"',\n" );
				if(obj._div==''||typeof(obj._div)=='undefined'){
					str.append("					height: eval(document.body.clientHeight*(parseFloat('"+obj._height+"')))/100,\n");
				}else{
					str.append("					height: eval(parseFloat(document.getElementById('"+obj._div+"').style.height)*(parseFloat('"+obj._height+"')))/100,\n");
				}
			}else{
				str.append("					width: '100%',\n" );
				str.append("					height: '100%',\n");
			}
		}else{
			str.append("					width: w_" + obj.id + "+10,\n");
			str.append("					height: h_" + obj.id + "+10,\n");
		}
	str.append("             frame:true,\n");
	str.append("			 activeTab: 0,\n");
	str.append("             margins : '0 0 0 0',\n");
	str.append("             minHeight : 100,\n");
	str.append("             autoHeight : false,\n");
	str.append("             items : [");
	if (eval(obj.uploadisuse)) {
		str.append("				createUpload(),");
	}
	if (eval(obj.readable)) {
		str.append("				createGridList(),");
	}
	str = new StringBuffer().append(str.toString().replace(/,$/g, ''));
	str.append("             ]");
	str.append("             });");

	if (!eval(obj.showtype)) {
		str.append("				var win = new Ext.Window({");
		str.append("					title: '上传窗口'");
		if(obj._checked=='yes'){
			str.append("					, width: '" + obj._width + "'");
			str.append("					, height: '" + eval(document.body.clientHeight*obj._height) + "'");
		}else{
			str.append("					, width: w_" + obj.id + "+20");
			str.append("					, height: h_" + obj.id + "+60");
		}
		str.append("					, resizable: true");
		str.append("					, items: [");
		str.append("					panel");
		str.append("					]");
		str.append("				});");
		str.append("				win.show();\n");
	}
	str.append("if(localWindowParams('operType')=='readonly'){\n");
	str.append("panel.setActiveTab(panel.items.item(1));\n");
	str.append("panel.items.item(0).setDisabled(true);\n");
	str.append("panel.items.item(1).getTopToolbar().setVisible(false);\n");
	str.append("}");
	str.append("if(typeof(creator_pt_uppanels)=='undefined'){creator_pt_uppanels=new Array();}\n");
	str.append("creator_pt_uppanels.push({id:'" + obj.id + "',obj:panel});\n");
	// 这里必须用setTimeout，否则就要报IE无法打开Internet站点的错
	str.append("if(typeof(onUpPanelLoaded)=='function') setTimeout(onUpPanelLoaded,0);\n");
	// str.append("});");
	str.append("};\n");
	str.append("function dodoupload(){\n");
	str.append("upobj_" + obj.id + ".startUpload();\n");
	str.append("}");

	str.append(obj.id + '_onReady();');
	str.append("</scri" + "pt>");
	return str.toString();
}

function creator_pt_createExtTree(obj) {
	var str = new StringBuffer().append("&nbsp;");
	str.append("	   <div id='ExtTreeDiv_" + obj.id+ "' style='overflow:auto; ");
	if (obj.opentb == "_self") {
		str.append("position:" + obj.style.position + ";left:" + obj.style.left
				+ ";top:" + obj.style.top + ";");
	}
	str.append("border:1px solid #c3daf9;'></div>");
	str.append("&nbsp;<script type=\"text/javascript\">var tree,"+obj.id+";");
	str.append("Ext.onReady(function(){");
	str.append("	Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';");
	str.append("    tree="+obj.id+" = new Ext.tree.TreePanel({");
	str.append("		el:'ExtTreeDiv_" + obj.id + "',");
	str.append("		title:'" + obj.roottext + "',");
	str.append("		frame:true,");
	if (obj.opentb == "_self") {
		str.append("	height:" + obj.style.height.replace("px", "") + ",");
		str.append("	width:" + obj.style.width.replace("px", "") + ",");
	}
	str.append("		autoScroll:'true',");
	str.append("		loader:new Ext.tree.TreeLoader({");
	if (checkTF(obj.isSelect)) {
		str.append("			baseAttrs: { uiProvider: Ext.ux.TreeCheckNodeUI } ");
	}
	str.append("		}),");
	if (checkTF(obj.isSelect)) {
		str.append("		checkModel: '" + obj.ischecked + "', ");
		str.append("		onlyLeafCheckable : "
				+ (obj.onlySelectLeaf == "是" ? "true" : "false") + ",");
	}
	if (checkTF(obj.isFilter)) {
		str.append("		tbar:[");
		str.append("			new Ext.form.TextField({");
		str.append("				emptyText:'输入后按回车',");
		str.append("				allowBlank:true,");
		str.append("				listeners:{");
		str.append("					specialkey:function(field,e){");  
		str.append("						if (e.getKey()==Ext.EventObject.ENTER){");
		str.append("							filterTree(e); ");
		str.append("						}");
		str.append("					}");
		str.append("				}");
		str.append("			})");
		str.append("		]");
	}
	str.append("	});");
	var tempstr = "";
	switch (obj.treeRule.toString()) {
		case '0' :
			tempstr = getJsonStr(obj.xml);
			break;
		case '1' :
			tempstr = obj.dataIF;
			break;
		case '2' :
			tempstr = obj.jsonData;
			break;
	}
	str.append("	var jsonObj = "+tempstr+";");
	str.append("	var root = new Ext.tree.AsyncTreeNode(jsonObj);");
	if (checkTF(obj.sortAble)) {
		str.append("	new Ext.tree.TreeSorter("+obj.id+", {folderSort:true");
		str.append(",property:'" + obj.sortProperty + "',dir:'"
				+ obj.sortMethod + "'");
		if (!IsSpace(obj.leafAttr)) {
			str.append(",leafAttr:'" + (obj.leafAttr == "是" ? 'true' : 'false')
					+ "'");
		}
		if (!IsSpace(obj.caseSensitive)) {
			str.append(",caseSensitive:"
					+ (obj.caseSensitive == "是" ? 'true' : 'false'));
		}
		if (!IsSpace(obj.sortTypeFunction)) {
			str.append(",sortType:" + obj.sortTypeFunction);
		}
		str.append("});");
	}
	str.append("	"+obj.id+".setRootNode(root);");
	str.append(obj.clicknode);
	str.append("	"+obj.id+".render();");
	if (checkTF(obj.isAll)) {
		str.append("	root.expand();");
	}
	if (obj.opentb == "_blank") {
		str.append("var win = new Ext.Window({");
		str.append("		title		: '对话窗',");
		str.append("		layout      : 'fit',");
		str.append("		width       : " + obj.style.width.replace('px', '')+ ",");
		str.append("		height      : " + obj.style.height.replace('px', '')+ ",");
		str.append("		closeAction :'hide',");
		str.append("		plain       : true,");
		str.append("		items       : "+obj.id+",");
		str.append("		buttons: [{");
		str.append("			text     : '确认',");
		str.append("			handler  : "+ obj.windowCloseEvent.replace(/(\(\))$/g, ''));
		str.append("		},{");
		str.append("			text     : '取消',");
		str.append("			handler  : function(){");
		str.append("				win.hide();");
		str.append("			}");
		str.append("		}]");
		str.append("    });win.show();");
	}
	if (!IsSpace(obj.onclickEvent)) {
		str.append("	"+obj.id+".on('click',"
				+ obj.onclickEvent.replace(/(\(\))$/g, '') + ");");
	}
	if (checkTF(obj.isFilter)) {
		str.append("	var filter = new Ext.tree.TreeFilter("+obj.id+", {");
		str.append("		clearBlank: true,");
		str.append("		autoClear: true");
		str.append("	});");
		str.append("	function filterTree(e){");
		str.append("		filterCondition = Ext.escapeRe(e.target.value);");
		str.append("		"+obj.id+".body.mask('加载中……','x-mask-loading');");
		str.append("		var myroot = "+obj.id+".root;");
		str.append("		var i = myroot.childNodes.length-1;");
		str.append("		for(; i>=0 ;i-- ){");
		str.append("			myroot.removeChild(myroot.item(i));");
		str.append("		}");
		str.append("		var jsonFilterObj = jsonFilterResult();");
		str.append("		if(jsonFilterObj.children.length>0){");
		str.append("			myroot.appendChild(jsonFilterObj.children);");
		str.append("		}");
		str.append("		myroot.expand(false,true,function(){");
		str.append("		"+obj.id+".body.unmask();});");
		str.append("	}");
		str.append("	var filterCondition=\"\";");
		str.append("	function filterJSONLeafSon(source) {");
		str.append("		var arrs = source.children;");
		str.append("		for ( var i = arrs.length - 1; i >= 0; i--) {");
		str.append("			var attri = arrs[i];");
		str.append("			if ((typeof attri.leaf != 'undefined' && attri.text.indexOf(filterCondition) < 0)) {");
		str.append("				arrs.splice(i, 1);");
		str.append("			} else if (typeof attri.children != 'undefined'&& attri.children.length > 0) {");
		str.append("				filterJSONLeafSon(attri);");
		str.append("				if (attri.children.length <= 0) {");
		str.append("					arrs.splice(i, 1);");
		str.append("				}");
		str.append("			}");
		str.append("		}");
		str.append("		return source;");
		str.append("	}	");
		str.append("	function jsonFilterResult() {");
		str.append("		var json =Ext.decode(Ext.encode(jsonObj));");
		str.append("		if(filterCondition!=\"\"){");
		str.append("			json=filterJSONLeafSon(json);");
		str.append("		}");
		str.append("		return json;");
		str.append("	}");
	}
	str.append("	Ext.QuickTips.init();");
	str.append("if(Ext.isIE6){var nodes = null;"+obj.id+".on('beforecollapsenode',function(node){nodes = "+obj.id+".getChecked();});"+obj.id+".on('expandnode',function(){if(nodes==null) return;for(var i=0;i<nodes.length;++i){if(nodes[i].isLeaf())nodes[i].getUI().toggleCheck(true);}});}");
	str.append("if(typeof(creator_pt_trees)=='undefined'){creator_pt_trees=new Array();}");
	str.append("creator_pt_trees.push({id:'" + obj.id + "',obj:"+obj.id+"});");
	str.append("});");
	str.append("</script>");
	return str.toString();
}
function checkTF(str) {
	if (str == "是")
		return true;
	else
		return false;
}
function parseXmlToJson(rootNode) {
	var str = new StringBuffer();
	var nodes = rootNode.childNodes;
	for (var i = 0, len = nodes.length;i < len; ++i) {
		var temp = nodes[i];
		str.append("{");
		str.append("text:\"" + temp.getAttribute("text") + "\",");
		str.append("qtip:\"" + temp.getAttribute("title") + "\",");
		str.append("id:\"" + temp.getAttribute("code") + "\",");
		if (!IsSpace(temp.getAttribute("link"))) {
			str.append("href:\"" + temp.getAttribute("link") + "\",");
			if (!IsSpace(temp.getAttribute("linkTarget"))) {
				str.append("hrefTarget:\"" + temp.getAttribute("linkTarget")
						+ "\",");
			}
		}
		if (temp.childNodes.length > 0) {
			str.append("children:[");
			str.append(parseXmlToJson(temp));
			str.append("]");
		} else {
			str.append("leaf:true");
		}
		str.append("},");
	}
	str = str.toString().replace(/,$/g, '');
	return str;
}

function getJsonStr(xml) {
	var xdom = SetDom(xml);
	var rootnode = xdom.documentElement;
	var retstr = new StringBuffer();
	retstr.append("{");
	retstr.append("text:\"" + rootnode.getAttribute("text") + "\",");
	retstr.append("qtip:\"" + rootnode.getAttribute("title") + "\",");
	retstr.append("id:\"" + rootnode.getAttribute("code") + "\",");
	if (!IsSpace(rootnode.getAttribute("link"))) {
		retstr.append("href:\"" + rootnode.getAttribute("link") + "\",");
		if (!IsSpace(rootnode.getAttribute("linkTarget"))) {
			retstr.append("hrefTarget:\"" + rootnode.getAttribute("linkTarget")
					+ "\",");
		}
	}
	if (rootnode.childNodes.length > 0) {
		retstr.append("children:[");
		retstr.append(parseXmlToJson(rootnode));
		retstr.append("]");
	} else {
		retstr.append("leaf:true");
	}
	retstr.append("}");
	return retstr.toString();
}

function CreateFusionchar(obj) {
	var divw = obj.f_w; // flash width
	divw = divw == '' ? 500 : divw;
	var divh = obj.f_h; // flash high
	divh = divh == '' ? 230 : divh;
	var rv = obj.returnValue.replace(/\r?\n/g, '');
	var returnValue = decodeURI(rv); // the chart properties string

	var div_top = obj.f_top;
	var div_left = obj.f_left;

	var index = returnValue.indexOf('$');
	var idname = returnValue.substring(0, index);

	var pvalue = returnValue.substring(index + 1);
	pvalue = encodeURI(pvalue);
	// get returnValue and resolve the chart type name
	var charttypename = idname.substring(0, idname.indexOf('_'));
	var divid = obj.fusion_id + 'divid';
	var chartid = obj.fusion_id + 'chartid';
	var hidinput = obj.fusion_id + 'hidinput';

	// get datasetid aaa=1`eformDataSetName=abc
	var datasetid;
	var datasetindex = returnValue.indexOf('eformDataSetName');
	var datasetleftstr = returnValue.substring(datasetindex + 1);
	var datasetfirstEqIndex = datasetleftstr.indexOf('`');
	if (datasetfirstEqIndex == -1) {
		datasetid = datasetleftstr;
	} else {
		datasetid = datasetleftstr.substring(0, datasetfirstEqIndex);
	}

	datasetid = datasetid.substring(datasetid.indexOf('=') + 1);
	var returnStr = "<input type='hidden' value='"
			+ pvalue
			+ "' id='"
			+ hidinput
			+ "'><div style='position:absolute;top:"
			+ div_top
			+ ";left:"
			+ div_left
			+ "' id='"
			+ divid
			+ "' align='center'>loading data...</div>"
			+ "<script type=text/javascript defer>"
			+ "var dataset_"
			+ datasetid
			+ " = document.getElementById('"
			+ datasetid
			+ "');if(typeof(varfuns_"
			+ datasetid
			+ ")=='undefined'){varfuns_"
			+ datasetid
			+ " = new Array();}varfuns_"
			+ datasetid
			+ ".push(function(){"
			+ "var xml=dataset_"
			+ datasetid
			+ ".xml; "
			+ "var propertiesValue = decodeURI(document.getElementById('"
			+ hidinput
			+ "').value);"
			+ "$.ajax({"
			+ "    url: getContextPath()+'/fusionchar',"
			+ "    type: 'POST',"
			+ "	 data: 'datasetxml='+toUN.on(xml)+'&propertiesValue='+toUN.on(propertiesValue)+'&chart_modelname="
			+ idname + "&chart_action=3'," + "    async: true ,"
			+ "    error: function(){" + "       $('#" + divid
			+ "').html('load data error!');" + "    },"
			+ "    success: function(xml){" + "	 	 $('#" + divid
			+ "').html(' ');" + "        var fusionxml = xml;    "
			+ "		 var chart = new FusionCharts('../../../FusionCharts/Charts/"
			+ charttypename + ".swf', '" + chartid + "', '" + divw + "', '"
			+ divh + "');" + "		 chart.setDataXML(decodeURI(fusionxml));"
			+ "		 chart.render('" + divid + "');" + "    }" + "});"
			+ "}); dataset_" + datasetid
			+ ".AfterOpen=function(){if(typeof(varfuns_" + datasetid
			+ ")!=null) for(var i=0;i<varfuns_" + datasetid
			+ ".length;++i){varfuns_" + datasetid + "[i]();}}</script>";
	// alert(returnStr);
	return returnStr;
}
