/*��js�ļ����ڴ���ڿ��������з�װ�ĳ��õ�һЩ����*/

/**
ʱ�䣺2008-09-11 ����
���ܣ��������װ�ķ�����EFORM��ѯ��װ������ ͨ��EFORM��ѯ���ݿ�
����ֵ�����Ϊ���򷵻ؿ����飬���򷵻ض�ά����
*/

var BatchManager = function(){
    this.sqls = "";
    this.addBatch = function(sql){
        if(!IsSpace(sql)){        	
        	this.sqls += "<no>" + sql+ "</no>";
        }
    }
    this.getSqls = function(){
        return this.sqls ;
    }
    this.execBatch = function(){
         return InsertSqls(this.sqls);
    }
}
/*
��һ��д�����Բ���
function BatchManager=function(){
    this.sqls = "";
    this.addBatch = function(sql){
        if(!IsSpace(sql))
            this.sqls += "<no>" + sql + "< >";
    }
    this.execBatch = function(){
         return InsertSqls(this.sql);
    }
}
*/


/*ȡ��ǰ����*/
function getCrntDateFmt1() {
	var date = new Date();
	var year = date.getFullYear();
	var month = date.getMonth()+1;
	var day = date.getDate();
	month = month  + "";
	day = day + "";

	if(month.length<2) {
		month = "0"+month;
	}

	if(day.length<2) {
		day = "0" + day;
	}

	return (year+month+day);
}







/* ͨ��TABLEIDȥ��������HTMLԪ�صķ��ʷ�Χ����ֻ�����ɱ༭���������� */
function setTableVisitStatus(tableId,visitType){
    var tableInfo = document.getElementById(tableId);
    var arrInput = tableInfo.getElementsByTagName("input");
    for(var i=0; i<arrInput.length; i++){
        var type = arrInput[i].getAttribute("controltype");
        if((type!=null) && (type!="undefind")){
            if(type.toLowerCase()=="text"){
                if(visitType.toLowerCase() == "view"){
                    arrInput[i].readOnly = true;
                }else if(visitType.toLowerCase() == "edit"){
                    arrInput[i].readOnly = false;
                }else{
                	  arrInput[i].style.display = "none";
                }
            }
        }
    }
    var arrComb = tableInfo.getElementsByTagName("select");
    for(var i=0; i<arrComb.length; i++){
        if(visitType.toLowerCase() == "view"){
            arrComb[i].disabled = true;
        }else if(visitType.toLowerCase() == "edit"){
            arrComb[i].disabled = false;
        }else{
            arrComb[i].style.display = "none";
        }
    }
}


/* ���ָ��TABLE�����������ֶ� */
function setTableElementClear(tableId){
	  var tableInfo = document.getElementById(tableId);
    var arrInput = tableInfo.getElementsByTagName("input");
    for(var i=0; i<arrInput.length; i++){
        var type = arrInput[i].getAttribute("controltype");
        if((type!=null) && (type!="undefind")){
            if(type.toLowerCase()=="text"){
                arrInput[i].value = "";
                arrInput[i].readOnly = false;
            }
        }
    }
    var arrComb = tableInfo.getElementsByTagName("select");
    for(var i=0; i<arrComb.length; i++){
    	  arrComb[i].value = "";
        arrComb[i].disabled = false;
    }
}





/* Data Access Object Model������һ�����ݿ���ʻ��� */
function BaseDao(){
   this.appId = "app_5";
   this.tableName = "undefined";
   this.keyName = "undefined";
   this.dataset = null;
   
   /*ͨ��������ѯ*/
   this.findByPK = function(dataset, keyValue){   
       var sql="select "+genInquireFields(dataset)+" from "+this.appId+"."+this.tableName+
               " where "+this.keyName+"='"+keyValue+"'";
	     dataset.Open(sql);
	     dataset.dset_cont();
   }

   /*ͨ���ֶβ�ѯ*/
   this.findByProperty = function(dataset, propertyName, propertyValue, orderFields){
       var sql="select "+genInquireFields(dataset)+" from "+this.appId+"."+this.tableName+
               " where "+propertyName+"='"+propertyValue+"'"; 
	     var orderSql = "";
	     if(!IsSpace(orderFields)){
	     	   for(var i=0; i<orderFields.length; i++){
	     	   	   var fieldName = orderFields[i][0];
	     	   	   var orderType = orderFields[i][1];
	     	   	   if(IsSpace(orderType) || orderType.toUpperCase()!="DESC")  orderType = "ASC"; //Ĭ��Ϊ����
	     	   	   orderSql += fieldName + " " + orderType;
	     	   	   if(i != orderFields.length-1)  orderSql += ",";
	     	   }	
	     }
	     if(!IsSpace(orderSql)){
	     	   orderSql = " order by " + orderSql;
	     	   sql += orderSql;
			   
	     }
	     dataset.Open(sql);
	     dataset.dset_cont();
   }

   /*�������޸�*/
   this.saveOrUpdate = function(dataset){
	     SKbillsheet.keyfield = this.keyName;
	     fcpubvar.DsMain = dataset.id;
	     var msg = DjSave();
	     return msg;
	 }
	 
   /*ͨ������ɾ��*/
   this.deleteByPK = function(keyValue){
       var sql = "delete from "+this.appId+"."+this.tableName+" where "+this.keyName+"='"+keyValue+"'";
	     var msg = InsertSql(sql);
       return msg;
   }   
   
   /* ����DATASET */
   this.setDataset = function(dataset){
   	   this.dataset = dataset;
   }
}

/*��Ŀʵ��Dao*/
var InstanceDao=function(){
    this.tableName = "ta_sp_instance"; 
    this.keyName = "shenpi_insid";
}
InstanceDao.prototype=new BaseDao();


/* ͨ��dataset���Ҫ��ѯ���ֶ�����ɵ�sql��� */
function genInquireFields(dataset){
   var sqlFields = "";
   if(IsSpace(dataset)){  
       sqlFields = "*"; //��ѯ�����ֶ�
       return sqlFields ;
   }
   var dsFields = dataset.Fields.Field ;
   for(var i=0; i<dataset.FieldCount; i++){
      var crntFieldName = dsFields[i].FieldName; 
      var sqlPlus = crntFieldName ;
      if(dsFields[i].DataType == "����"){
			    sqlPlus = "to_char("+crntFieldName+",'yyyy-mm-dd') as "+crntFieldName; //��������
			}
		  if(dsFields[i].DisplayLabel=="��ѡ") continue;
	        sqlFields += sqlPlus ;
	    if(i != dataset.FieldCount-1)  sqlFields += ",";
   }
   return sqlFields ;
}


/******************************����������λ��֤�߼�***********************/



//��String���trim���� 
String.prototype.trim = function(){
   return this.replace(/(^\s*)|(\s*$)/g, "");
}

/******************��֤��ڶ���*******************/
function checkList(){
    this.blankList = new Array(0);//��������
    this.numList = new Array(0);  //�������Ϊ��ֵ
    this.intList = new Array(0);  //�������Ϊ����
    this.idCardList = new Array(0); //�������Ϊ��ȷ�����֤��
    this.emailList = new Array(0);//�������Ϊ��ȷ��email
    this.zipList = new Array(0);  //�������Ϊ��ȷ���ʱ�
    this.phoneList = new Array(0);//�������Ϊ��ȷ�ĵ绰����
    this.dateList = new Array(0); //�������Ϊ��ȷ����������
    this.compareDateList = new Array(0); //�Ƚ����ڴ�С
    this.msgList = new Array(0);  //��֤��Ϣ
    this.error = false ;

    this.appendList = appendList;
    this.addBlank = addBlank;
    this.addNum = addNum;
    this.addInt = addInt;
    this.addIdCard = addIdCard;
    this.addEmail = addEmail;
    this.addZip = addZip;
    this.addPhone = addPhone;
    this.addDate = addDate;
    this.addCompareDate = addCompareDate;

    this.check = check;
    this.checkBlank = checkBlank;
    this.checkNum = checkNum;
    this.checkInt = checkInt;
    this.checkIdCard = checkIdCard;
    this.checkEmail = checkEmail;
    this.checkZip = checkZip;
    this.checkPhone = checkPhone;
    this.checkDate = checkDate;
    this.checkDateHelper = checkDateHelper;
    this.checkCompareDate = checkCompareDate;
}



//��һ��������λ���Ƽ��뵽������
function appendList(objList, fldName){
    var size = objList.length;
    objList[size] = fldName;
}

//����һ�������������λ����
function addBlank(fldName){
    eval("this.appendList(this.blankList,'"+fldName+"')");
}

//����һ����Ҫ����Ϊ��ֵ����λ����
function addNum(fldName){
    eval("this.appendList(this.numList,'"+fldName+"')");
}

//����һ����Ҫ����Ϊ���͵���λ����
function addInt(fldName){
    eval("this.appendList(this.intList,'"+fldName+"')");
}

//����һ����Ҫ�������֤�ŵ���λ����
function addIdCard(fldName){
    eval("this.appendList(this.idCardList,'"+fldName+"')");
}

//����һ����Ҫ����Email����λ����
function addEmail(fldName){
    eval("this.appendList(this.emailList,'"+fldName+"')");
}

//����һ����Ҫ����绰�������λ����
function addZip(fldName){
    eval("this.appendList(this.zipList,'"+fldName+"')");
}

//����һ����Ҫ����绰�������λ����
function addPhone(fldName){
    eval("this.appendList(this.phoneList,'"+fldName+"')");
}

//����һ����Ҫ�������ڵ���λ����
function addDate(fldName){
    eval("this.appendList(this.dateList,'"+fldName+"')");
}

//������Ҫ�Ƚ����ڴ�С��������λ����
function addCompareDate(){
    this.appendList(this.compareDateList,addCompareDate.arguments);
    this.addDate(addCompareDate.arguments[0]);
    this.addDate(addCompareDate.arguments[1]);
}


/*----------------�����������֤������λ----------------*/
function check(){
    //������ʾ��Ϣ��
    document.body.appendChild(mouseMsg); 
    //��֤
    if(this.blankList){
       for(var i=0; i<this.blankList.length; i++){
          this.checkBlank(this.blankList[i]);
       }
    }
    if(this.numList){
       for(var i=0; i<this.numList.length; i++){
          this.checkNum(this.numList[i]);
       }
    }
    if(this.intList){
       for(var i=0; i<this.intList.length; i++){
          this.checkInt(this.intList[i]);
       }
    }
    if(this.idCardList){
       for(var i=0; i<this.idCardList.length; i++){
          this.checkIdCard(this.idCardList[i]);
       }
    }
    if(this.emailList){
       for(var i=0; i<this.emailList.length; i++){
          this.checkEmail(this.emailList[i]);
       }
    }
    if(this.zipList){
       for(var i=0; i<this.zipList.length; i++){
          this.checkZip(this.zipList[i]);
       }
    }
    if(this.phoneList){
       for(var i=0; i<this.phoneList.length; i++){
          this.checkPhone(this.phoneList[i]);
       }
    }
    if(this.dateList){
       for(var i=0; i<this.dateList.length; i++){
          this.checkDate(this.dateList[i]);
       }
    }
    if(this.compareDateList){
       for(var i=0; i<this.compareDateList.length; i++){
          this.checkCompareDate(this.compareDateList[i]);
       }
    }
    //�ͷ��ڴ�
    this.blankList = new Array(0);
    this.numList = new Array(0);
    this.intList = new Array(0);
    this.idCardList = new Array(0);
    this.emailList = new Array(0);
    this.zipList = new Array(0);
    this.phoneList = new Array(0);
    this.dateList = new Array(0);
    this.compareDateList = new Array(0);
    //����д�����ʾʹ����
    if((this.msgList && this.msgList.length>0) || this.error){
        alert("�������");
        return false;
    }else{
        return true;
    }
}


//�������������ֶ�
function checkBlank(fldName){
    eval('var obj = document.getElementsByName("'+fldName+'")');
    for(var i=0; i<obj.length; i++){
       if(doTrim(obj[i].value) == ""){
          obj[i].style.backgroundColor = errBgColor;
          obj[i].setAttribute("tt","����Ϊ��ֵ");
          eval("this.appendList(this.msgList,'0"+fldName+"')");
       }else{
          obj[i].style.backgroundColor = ""; 
          obj[i].setAttribute("tt","������ȷ");
       }
       obj[i].attachEvent("onmouseover",showMsg);
       obj[i].attachEvent("onmouseout",hideMsg);
    }
}

//�������Ϊ���ֵ��ֶ�
function checkNum(fldName){
    eval('var obj = document.getElementsByName("'+fldName+'")');
    for(var i=0; i<obj.length; i++){
       if(isNotNum(obj[i])){  //������ֵ
          obj[i].style.backgroundColor = errBgColor;
          obj[i].setAttribute("tt","����Ϊ����");
          eval("this.appendList(this.msgList,'1"+fldName+"')");
       }else{
          obj[i].style.backgroundColor = "";
          obj[i].setAttribute("tt","������ȷ");
       }
       obj[i].attachEvent("onmouseover",showMsg);
       obj[i].attachEvent("onmouseout",hideMsg);
    }
}

//�������Ϊ�������ֶ�
function checkInt(fldName){
    eval('var obj = document.getElementsByName("'+fldName+'")');
    for(var i=0; i<obj.length; i++){
        if(isNotNum(obj[i])){  //������ֵ
          obj[i].style.backgroundColor = errBgColor;
          obj[i].setAttribute("tt","����Ϊ����");
          eval("this.appendList(this.msgList,'1"+fldName+"')");
       }else if(isNotInt(obj[i])){
          obj[i].style.backgroundColor = errBgColor;
          obj[i].setAttribute("tt","����Ϊ����");
          eval("this.appendList(this.msgList,'1"+fldName+"')");
       }else{
          obj[i].style.backgroundColor = "";
          obj[i].setAttribute("tt","������ȷ");
       }
       obj[i].attachEvent("onmouseover",showMsg);
       obj[i].attachEvent("onmouseout",hideMsg);
    }
}

//��֤���֤��
function checkIdCard(fldName){
    eval('var obj = document.getElementsByName("'+fldName+'")');
    for(var i=0; i<obj.length; i++){
       var chkFlag = true;
       var errMsg = "";
       var temp = doTrim(obj[i].value);
       if(temp==""){
          chkFlag = true;
       }else if((temp.length!=15) && (temp.length!=18)){ //λ������
          chkFlag = false;
          errMsg = "���֤��λ��Ϊ"+temp.length+"���󣬱���Ϊ15��18";
       }else{
          var pid = temp.length==18 ? temp.substring(0,17) : temp.slice(0,6)+"19"+temp.slice(6,14);
          var reg = /^\d+$/;
          if(!reg.test(pid)){
             chkFlag = false;
             errMsg = "���֤�ų����һλ�⣬����Ϊ����";
          }else{
             var year = temp.slice(6,10);
             var month = temp.slice(10,12)-1;
             var day = temp.slice(12,14);
             var date = new Date(year, month, day);
             var nowDate = new Date();
             var chkedYear = date.getFullYear();
             var chkedMonth = date.getMonth();
             var chkedDay = date.getDate();
             if((year!=chkedYear) || (month!=chkedMonth) || (day!=chkedDay) || (date>nowDate) || (year<1940)){
                 chkFlag = false;
                 errMsg = "���֤���������";
             }
          }
       }
       //�������
       if(!chkFlag){ 
          obj[i].style.backgroundColor = errBgColor;  
          obj[i].setAttribute("tt",errMsg);
          eval("this.appendList(this.msgList,'2"+fldName+"')");
       }else{
          obj[i].style.backgroundColor = "";
          obj[i].setAttribute("tt","������ȷ");
       }
       obj[i].attachEvent("onmouseover",showMsg);
       obj[i].attachEvent("onmouseout",hideMsg);
    }
}

//��֤Email
function checkEmail(fldName){
    eval('var obj = document.getElementsByName("'+fldName+'")');
    for(var i=0; i<obj.length; i++){
       var reg = /^(.+)@(.+)$/;
       if((doTrim(obj[i].value)!="") && !reg.test(obj[i].value)){
          obj[i].style.backgroundColor = errBgColor;  
          obj[i].setAttribute("tt","email�������");
          eval("this.appendList(this.msgList,'3"+fldName+"')");
       }else{
          obj[i].style.backgroundColor = "";
          obj[i].setAttribute("tt","������ȷ");
       }
       obj[i].attachEvent("onmouseover",showMsg);
       obj[i].attachEvent("onmouseout",hideMsg);
    }
}

//��֤��������
function checkZip(fldName){
    eval('var obj = document.getElementsByName("'+fldName+'")');
    for(var i=0; i<obj.length; i++){
       var reg = /^\d{6}$/;
       if((doTrim(obj[i].value)!="") && !reg.test(obj[i].value)){
          obj[i].style.backgroundColor = errBgColor;  
          obj[i].setAttribute("tt","��������������󣬱���Ϊ6λ����");
          eval("this.appendList(this.msgList,'4"+fldName+"')");
       }else{
          obj[i].style.backgroundColor = "";
          obj[i].setAttribute("tt","������ȷ");
       }
       obj[i].attachEvent("onmouseover",showMsg);
       obj[i].attachEvent("onmouseout",hideMsg);
    }
}

//��֤�绰����
function checkPhone(fldName){
    eval('var obj = document.getElementsByName("'+fldName+'")');
    for(var i=0; i<obj.length; i++){
       var reg = /((\(\d{3}\)|(\d{3}-))?\d{8})|((\(\d{4}\)|(\d{4}-))?\d{7})/;
       if((doTrim(obj[i].value)!="") && !reg.test(obj[i].value)){
          obj[i].style.backgroundColor = errBgColor;  
          obj[i].setAttribute("tt","�绰�����������");
          eval("this.appendList(this.msgList,'5"+fldName+"')");
       }else{
          obj[i].style.backgroundColor = "";
          obj[i].setAttribute("tt","������ȷ");
       }
       obj[i].attachEvent("onmouseover",showMsg);
       obj[i].attachEvent("onmouseout",hideMsg);
    }
}

//��֤����
function checkDate(fldName){
    var flag=false;
    eval('var obj = document.getElementsByName("'+fldName+'")');
    for(var i=0; i<obj.length; i++){
       var trimedDate = doTrim(obj[i].value);
       if(trimedDate!=""){
	       var dateStr = preDateFormat(doTrim(obj[i].value));
	       var reg = /^\d{8}$/;
	       if(!reg.test(dateStr)){
	          obj[i].style.backgroundColor = errBgColor;  
	          obj[i].setAttribute("tt","����������󣬳����ָ�������Ϊ8λ����");
	          eval("this.appendList(this.msgList,'7"+fldName+"')");
	       }else if(this.checkDateHelper(dateStr)!=""){
	          switch(parseInt(this.checkDateHelper(dateStr))){
	             case 1:
	                 obj[i].setAttribute("tt","���ڸ�ʽ�·�����") ;
	                 break;
	             case 2:
	                 obj[i].setAttribute("tt","���ڸ�ʽ��������") ;
	                 break;
	             case 3:
	                 obj[i].setAttribute("tt","�����������") ;
	                 break;
	          }
	          obj[i].style.backgroundColor = errBgColor;  
	          eval("this.appendList(this.msgList,'7"+fldName+"')");
			  
	       }else{
	          obj[i].style.backgroundColor = "";
	          obj[i].setAttribute("tt","������ȷ");
			  flag=true;
	       }
	   }
       obj[i].attachEvent("onmouseover",showMsg);
       obj[i].attachEvent("onmouseout",hideMsg);
	   return flag;
    }
}

//�����ڵ�б�ܡ��ָ���ȥ��
function preDateFormat(dateStr){
    var partArr = dateStr.split("-");
    if(partArr.length == 1)
        partArr = dateStr.split("/");
    var generalDate="";
    for(var i=0;i<partArr.length;i++){
        if(i>0 && partArr[i].length==1)
      	   partArr[i]="0"+partArr[i] ;
        generalDate += partArr[i];
    }
    return generalDate;
}

//��֤���������Ƿ���ȷ
function checkDateHelper(dateStr){
    var len = dateStr.length;
    var yy = dateStr.substring(0,len-4);
    var mm =0,dd=0;
    if(dateStr.substr(len-4,2).substr(0,1)=="0")    
        mm = parseInt(dateStr.substr(len-3,1));
    else
        mm = parseInt(dateStr.substr(len-4,2));
    if(dateStr.substr(len-2,2).substr(0,1)=="0")
        dd = parseInt(dateStr.substr(len-1,1));
    else
        dd = parseInt(dateStr.substr(len-2,2));
    
    if(mm>12 || mm<=0){
        return "1";
    }else{
        switch(mm){
           case 1:case 3:case 5:case 7:case 8:case 10:case 12:
              if(dd>31 || dd<1)  return "2";
              else   return "";
              break;
           case 4:case 6:case 9:case 11:
              if (dd>30 || dd<1)    return "2";
              else   return "";
              break;
           case 2:
              if (dd>29 || dd<1){
                  return "2";
              }else if(dd==29){
                  if(isReun(yy))  return "";
                  else return "2";
              }else{
                  return "";
              }
              break;
           default:
              return "3";
        }
    }
}

//�ж�ĳ���Ƿ�������
function isReun(yy){
    if(yy%400 == 0){
        return true;
    }else if(yy%100 == 0){
        return false;
    }else if(yy%4 == 0){
        return true;
    }
}


//�Ƚ��������ڴ�С
function checkCompareDate(target){
   
    if(!this.checkDate(target[0])) return; //��֤���������Ƿ���ȷ
    if(!this.checkDate(target[1])) return; //��֤���������Ƿ���ȷ 
    var compareDateObj1 = document.getElementsByName(target[0])[0];
    var compareDateObj2 = document.getElementsByName(target[1])[0];
    if(compareDateObj1.value.length != compareDateObj2.value.length){
	 
		compareDateObj1.style.backgroundColor = errBgColor;  
        compareDateObj1.setAttribute("tt","���ұȽϵ����ڸ����������");
        eval("this.appendList(this.msgList,'8"+target[0]+"')");
        compareDateObj2.style.backgroundColor = errBgColor;  
        compareDateObj2.setAttribute("tt","���ұȽϵ����ڸ����������");
        eval("this.appendList(this.msgList,'8"+target[1]+"')");
       
    }else{
		    
            if(compareDateObj1.value > compareDateObj2.value){
                compareDateObj1.style.backgroundColor = errBgColor;  
		        compareDateObj1.setAttribute("tt","��ʼ���ڲ��ܴ��ڽ�������");
		        eval("this.appendList(this.msgList,'8"+target[0]+"')");
		        compareDateObj2.style.backgroundColor = errBgColor;  
		        compareDateObj2.setAttribute("tt","��ʼ���ڲ��ܴ��ڽ�������");
		        eval("this.appendList(this.msgList,'8"+target[1]+"')");
            }else{
               compareDateObj1.style.backgroundColor = "";
               compareDateObj1.setAttribute("tt","������ȷ");
               compareDateObj2.style.backgroundColor = "";
               compareDateObj2.setAttribute("tt","������ȷ");
            } 
            compareDateObj1.attachEvent("onmouseover",showMsg);
            compareDateObj1.attachEvent("onmouseout",hideMsg);
            compareDateObj2.attachEvent("onmouseover",showMsg);
            compareDateObj2.attachEvent("onmouseout",hideMsg);
        }
    
}


//�ѿո���˵�
function doTrim(s){
    if(s==null){
       return "";
    }else{
       return s.trim();
    }   
}

//�Ƿ�Ϊ����
function isNotNum(obj){
   if((obj!=null) && (doTrim(obj.value)!="")){
      var reg = /,/g;
      var temp = obj.value.replace(reg,""); //ȥ������
      return isNaN(temp)
   }
   return false;
}

//�Ƿ�������
function isNotInt(obj){
   if(obj==null || obj.value==null)
      return true;
   var p = obj.value.indexOf(".");
   if(p != -1)
      if(parseFloat(obj.value.substring(p))!=0)
         return true;
   return false;
}

//��ʾ������Ϣ��ʾ
function showMsg(){
   mouseMsg.style.cssText = "position:absolute;";
   mouseMsg.style.backgroundColor = "lightgrey"; //��ʾС���ڵı���ɫ
   mouseMsg.style.visibility = "visible";
   mouseMsg.style.left = event.x + 8;
   mouseMsg.style.top = event.y + document.body.scrollTop + 8;
   if (event.srcElement.tt){
      mouseMsg.innerHTML = "&nbsp;"+event.srcElement.tt+"&nbsp;";
   }
}

//���ش�����Ϣ
function hideMsg(){
   mouseMsg.style.visibility = "hidden";
}

//������Ϣ��ʾ��
var mouseMsg = document.createElement("DIV");
//������λ����ɫ
var errBgColor = "#ffc8ff";
