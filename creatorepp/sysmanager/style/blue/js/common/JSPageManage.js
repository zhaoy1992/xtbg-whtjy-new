
/*���ƺ���:
     ����:JSPageManage.js
     ����: 1. ����"��ҳ������"����ť�Ŀ���.
          2. ���ڿ���"��¼�б�"��ʾЧ��
*/
	function gotoHead(){
          /*��ҳ*/
          var vCurrentPage = document.listForm.currentPage.value;
          if((parseInt(vCurrentPage)) <= 1){}else{
              document.listForm.NextPage.value="1";
              //document.listForm.action="equipmentToBase_list.jsp?flag=1";
         	  document.listForm.submit();
         	 }
          }
        function gotoPre(){
          /*ǰһҳ*/
          var vCurrentPage = document.listForm.currentPage.value;
          var vTotalPage = document.listForm.totalPage.value;
          if((parseInt(vCurrentPage))<=1){}else{
            document.listForm.NextPage.value=parseInt(vCurrentPage)-1;
            //document.listForm.action="equipmentToBase_list.jsp?flag=1";
            document.listForm.submit();
            }
          }

        function gotoNext(){
          /*��һҳ*/
          var vCurrentPage = document.listForm.currentPage.value;
          var vTotalPage = document.listForm.totalPage.value;
          if((parseInt(vCurrentPage))>=(parseInt(vTotalPage))){}else{
            document.listForm.NextPage.value=parseInt(vCurrentPage)+1;
            //document.listForm.action="equipmentToBase_list.jsp?flag=1";
            document.listForm.submit();
            }
          }

        function gotoTail(){
          /*βҳ*/
          var vCurrentPage = document.listForm.currentPage.value;
          var vTotalPage = document.listForm.totalPage.value;
          if((parseInt(vCurrentPage))>=(parseInt(vTotalPage))){}else{
            document.listForm.NextPage.value=vTotalPage;
            //document.listForm.action="equipmentToBase_list.jsp?flag=1";
            document.listForm.submit();
            }
          }

/*����������������:������ڱ���һ��,������̬�Ӿ�Ч��*/
function sbar (st,col) {
  if(st.style.backgroundColor != '#ff0000'){
 	 st.style.backgroundColor = '#eeeeee';
  }
}
function cbar (st) {
  if(st.style.backgroundColor != '#ff0000'){
 	 st.style.backgroundColor = '';
  }
}

/*��radio��ť��ѡ�к�:�Ӿ�Ч���ı�*/
function check(o,c) {
if(o.parentElement.parentElement.style.backgroundColor==c){
    o.parentElement.parentElement.style.backgroundColor='';
}
else o.parentElement.parentElement.style.backgroundColor=c;
}
