/*
	�ֵ�����ѯ��ֻ�����ڵ�������ѯ��
*/

/**��ѯ�����Ľڵ㼯��**/
var a = document.getElementsByTagName("a");
/**���涨λ����Ԫ�ؼ���**/
var eleArray = new Array();
/*ģ����ѯ��һ����¼*/
var next = 0;

function blurryQuary(){
	var count = 0;
	var blurryValue = document.all("blurryValue").value;
	if(blurryValue == ""){
		alert("�������ݲ���Ϊ��!");
		return ;
	}
	for(var i = 0; i < a.length; i++){
		if(a[i].name != "" && a[i].name != "0"){
			document.all(a[i].name).parentElement.childNodes[0].style.backgroundColor="";
			if(a[i].innerText.indexOf(blurryValue) != -1){
				eleArray[count] = a[i].name;
				count ++;
			}
		}
	}
	if(eleArray.length > 0){
		document.all(eleArray[0]).parentElement.childNodes[0].style.backgroundColor="cornflowerblue";
		document.all(eleArray[0]).parentElement.focus();
		document.all.queryBtn.style.display="none";
 		document.all.nextBtn.style.display="";
 		next ++;
 		
	}else{
		onBlurryQueryChange();
		alert("û���ҵ�����Ҫ�������Ϣ��");
		return;
	}
	
}

/**�ı����Ըı�**/
function onBlurryQueryChange(){
 count = 0;
 eleArray.length = 0;
 document.all.queryBtn.style.display="";
 document.all.nextBtn.style.display="none";
}

function nextNodes(){
	if(eleArray.length > next){
		document.all(eleArray[next-1]).parentElement.childNodes[0].style.backgroundColor="";
		document.all(eleArray[next]).parentElement.childNodes[0].style.backgroundColor="cornflowerblue";
		try{
		document.all(eleArray[next]).parentElement.focus();
		}catch(e){
			alert('�ڵ��Ѳ�ѯ������չ�����ڵ�!');			
		}
		next ++;
	}else{
		alert("��ѯ��ɣ�");
		onBlurryQueryChange();
		next = 0;
	}
}

function enterKeydowngo(){ 
	if(window.event.keyCode == 13){
		if(document.all.queryBtn.style.display==""){
			blurryQuary();
		}else{
			nextNodes();
		}
	}
}

/*
	���ø�js��ҳ���������д
*/
/*
<tr>
	<td align="left">
	<input name="blurryValue" type="text" onpropertychange="onBlurryQueryChange()" onkeydown="enterKeydowngo()"/>
	</td>
</tr>
<tr>
<td align="right">
	<input type="button" name="queryBtn" value="��ѯ" onclick="blurryQuary()"  class="input">
	<input style="display:none" name="nextBtn" type="button" value="������һ��" onclick="nextNodes()" class="input">
	</td>
</tr>
*/