/**
*
*���Ҿ�̬���ڵ㣬��Ҫ���ҵľ�̬���ϣ��������´���
<div align="center">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table">
		<tr>
		<td align="left">
		<input name="blurryValue" type="text" onpropertychange="onBlurryQueryChange('queryBtn','nextBtn')" onkeydown="enterKeydowngo('blurryValue','queryBtn','nextBtn')"/>
		</td>
	</tr>
	<tr>
	<td align="right">
		<input type="button" name="queryBtn" value="��ѯ" onclick="blurryQuary('blurryValue','queryBtn','nextBtn')"  class="input">
		<input style="display:none" name="nextBtn" type="button" value="������һ��" onclick="nextNodes('queryBtn','nextBtn')" class="input">
		</td>
	</tr>
	</table>
</div>
*
*/




/**���涨λ����Ԫ�ؼ���**/
var eleArray_queryTreenode = new Array();
/**����ڵ����ƺ�λ�õķ�����������Ҫ��Ϊ���һ���ڵ����ƶ�Ӧ�˶���ڵ�ļ�������*/
var eleArray_reverseTreenodeIdx = new Array();

/*ģ����ѯ��һ����¼*/
var next_queryTreenode = 0;

var tree_node_rootid_ = 0;


/*
	queryTextname	��ѯ�����������ı�������
	queryBtn		��ѯ��ť����
	nextBtn			ģ����ѯ��һ����ť������
*/
function blurryQuary(queryTextname,queryBtn,nextBtn,root_id){
	/**��ѯ�����Ľڵ㼯��**/
	var a = document.getElementsByTagName("a");
	
	
	//alert(a.length);
	var count = 0;
	var blurryValue = document.all.item(queryTextname).value;
	if(blurryValue == ""){
		alert("�������ݲ���Ϊ��!");
		return ;
	}
	//�������blurryValueֵģ��ƥ��Ľڵ���
	for(var i = 0; i < a.length; i++){
		//alert(a[i].name + "---" + (a[i].name.indexOf("xml") == -1)) (a[i].name.indexOf("xml") == -1)
		if(a[i].name != ""){
			//alert(a[i].name);
			if(document.all(a[i].name).parentElement){
				document.all(a[i].name).parentElement.childNodes[0].style.backgroundColor="";
			}
			if(a[i].innerText.indexOf(blurryValue) != -1){
				//alert(a[i].innerText);
				eleArray_queryTreenode[count] = a[i].name;	
				/**
				 * �ж��Ƿ��ж��ͬ���ڵ�
				 */
				var tree_node_ = document.all(eleArray_queryTreenode[count]);
				
				if(tree_node_.length && tree_node_.length > 1)
				{
					var temp = eleArray_reverseTreenodeIdx[a[i].name];
					if(temp)
						temp[temp.length] = count;
					else
					{
						temp = new Array();
						temp[0] = count;
						eleArray_reverseTreenodeIdx[a[i].name] = temp;
					}
				}
					
				count ++;
			}
		}
	}
	if(eleArray_queryTreenode.length > 0){
	/**�������и��ڵ���Ϣ**/
	    var parentEle = new Array();
//		var node = document.all("div_"+eleArray_queryTreenode[0]);
		
//		var tree_node_ = document.all(eleArray_queryTreenode[0])
		
		var node = getCurrentNode(0);
		var tree_node_ = getCurrentTreeNode(0);
		if(!root_id)
		{
			root_id = "div_parent_0";
		}
		else
		{
			root_id = "div_parent_" + root_id;
		}
			
		if(node.id == root_id){
				tree_node_.parentElement.childNodes[0].style.backgroundColor="cornflowerblue";
				tree_node_.parentElement.focus();
				document.all.queryBtn.style.display="none";
		 		document.all.nextBtn.style.display="";
		 		next_queryTreenode ++;
	 		}
		else{
	 			
	 			
	 			for(var i = 0; i < 100; i++){
			      	node = node.parentElement;
			      	
			      /**���ڵ���ID��ʾ����**/
			      
			      	if(node.id != ""){
				     		parentEle[i] = node.id;
				    	}else{
				     		/**�˳�ѭ��**/
				     		break;
				    	}
			      	
	 			}
	 			
	 		}
		
		
 		//alert("parentEle.length = " + parentEle.length);
 		for( var i = parentEle.length - 1; i >=0 ; i --){
 			//alert("i = " + i)
 			if(Element.visible( parentEle[i])){
	   		
	   		}else{
	   		//alert(parentEle[i].substring(11,parentEle[i]));
	   		   document.all('icon_'+parentEle[i].substring(11,parentEle[i].length)).click();
	   		}

	   		/**�ж��Ƿ񵽴����һ��**/ 
	   		if( i == 0 ){
	   			tree_node_.parentElement.childNodes[0].style.backgroundColor="cornflowerblue";
	   			tree_node_.parentElement.focus();
				document.all.queryBtn.style.display="none";
		 		document.all.nextBtn.style.display="";
		 		next_queryTreenode ++;
	   		}
 		}
 		
	}else{
		onBlurryQueryChange(queryBtn,nextBtn);
		alert("û���ҵ�����Ҫ�������Ϣ��");
		return;
	}
	
}

/*
	�ı����Ըı�
	queryBtn	��ѯ��ť����
	nextBtn		��ѯ��һ����ť����
*/
function onBlurryQueryChange(queryBtn,nextBtn){
	count = 0;
	eleArray_queryTreenode.length = 0;
	eleArray_reverseTreenodeIdx = new Array();
	document.all.item(queryBtn).style.display="";
	document.all.item(nextBtn).style.display="none";
}

function getCurrentNode(nextcount)
{
	var treenode = eleArray_queryTreenode[nextcount];
	var node = document.all("div_"+treenode);
	
	if(!node.length)
	{
		return node;
	}
	var temp = eleArray_reverseTreenodeIdx[treenode];
	var idx = -1;
	for(var i = 0; i < temp.length; i ++)
	{
		if(temp[i] == nextcount)
		{
			idx = i;
		}
	}
	node = node[idx];
	
	return node;
}

function getCurrentTreeNode(nextcount)
{
	var treenode = eleArray_queryTreenode[nextcount];
	
	var tree_node_ = document.all(treenode);
	if(!tree_node_.length)
	{
		return tree_node_;
	}
	var temp = eleArray_reverseTreenodeIdx[treenode];
	var idx = -1;
	for(var i = 0; i < temp.length; i ++)
	{
		if(temp[i] == nextcount)
		{
			idx = i;
		}
	}
	
	tree_node_ = tree_node_[idx];
	return tree_node_;
}

/*
	queryBtn	��ѯ��ť����
	nextBtn		��ѯ��һ����ť����
*/
function nextNodes(queryBtn,nextBtn,root_id){
	if(eleArray_queryTreenode.length > next_queryTreenode){
//		document.all(eleArray_queryTreenode[next_queryTreenode-1]).parentElement.childNodes[0].style.backgroundColor="";
		getCurrentTreeNode(next_queryTreenode-1).parentElement.childNodes[0].style.backgroundColor="";
		var parentEle = new Array();
		var node = getCurrentNode(next_queryTreenode);
		var tree_node_ = getCurrentTreeNode(next_queryTreenode);
		if(!root_id)
		{
			root_id = "div_parent_0";
		}
		else
		{
			root_id = "div_parent_" + root_id;
		}
			
		if(node.id == root_id){
				
				tree_node_.parentElement.childNodes[0].style.backgroundColor="cornflowerblue";
				tree_node_.parentElement.focus();
				document.all.queryBtn.style.display="none";
		 		document.all.nextBtn.style.display="";
		 		next_queryTreenode ++;
	 	}
		else{
	 			for(var i = 0; i < 100; i++){
			      	node = node.parentElement;
			      /**���ڵ���ID��ʾ����**/
			      	
			    	if(node.id != ""){
			     		parentEle[i] = node.id;
			    	}else{
			     		/**�˳�ѭ��**/
			     		break;
			    	}
	 			}
	 		}
		
		
 		
 		for( var i = parentEle.length-1; i >=0 ; i --){
 			if(Element.visible( parentEle[i])){
	   		
	   		}else{
	   		   document.all('icon_'+parentEle[i].substring(11,parentEle[i].length)).click();
	   		}

	   		/**�ж��Ƿ񵽴����һ��**/ 
	   		if( i == 0 ){
	   			tree_node_.parentElement.childNodes[0].style.backgroundColor="cornflowerblue";
	   			tree_node_.parentElement.focus();
				document.all.queryBtn.style.display="none";
		 		document.all.nextBtn.style.display="";
		 		next_queryTreenode ++;
	   		}
 		}
 		
	}else{
		alert("��ѯ��ɣ�");
		eleArray_queryTreenode = new Array();
		eleArray_reverseTreenodeIdx = new Array();
		onBlurryQueryChange(queryBtn,nextBtn);
		next_queryTreenode = 0;
	}
}
/*
	queryTextname	��ѯ�����������ı�������
	queryBtn	��ѯ��ť����
	nextBtn		��ѯ��һ����ť����
*/			
function enterKeydowngo(queryTextname,queryBtn,nextBtn,root_id){ 
	if(window.event.keyCode == 13){
		if(document.all.queryBtn.style.display==""){
			blurryQuary(queryTextname,queryBtn,nextBtn,root_id);
		}else{
			nextNodes(queryBtn,nextBtn,root_id);
		}
	}
}

/*
<div align="center">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table">
		<tr>
		<td align="left">
		<input name="blurryValue" type="text" onpropertychange="onBlurryQueryChange('queryBtn','nextBtn')" onkeydown="enterKeydowngo('blurryValue','queryBtn','nextBtn')"/>
		</td>
	</tr>
	<tr>
	<td align="right">
		<input type="button" name="queryBtn" value="��ѯ" onclick="blurryQuary('blurryValue','queryBtn','nextBtn')"  class="input">
		<input style="display:none" name="nextBtn" type="button" value="������һ��" onclick="nextNodes('queryBtn','nextBtn')" class="input">
		</td>
	</tr>
	</table>
</div>

*/
