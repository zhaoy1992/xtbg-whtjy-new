/*����ǳ�Ƶ���ɫ--------------------------------------------------------------------*/
/*����������������:������ڱ���һ��,������̬�Ӿ�Ч��*/
function sbar4 (st) {
  if(st.style.backgroundColor != '#ffe1d2'){
 	 st.style.backgroundColor = '#eeeeee';
  }
}
function cbar4 (st) {
  if(st.style.backgroundColor != '#ffe1d2'){
 	 st.style.backgroundColor = '';
  }
}
/*��radio��ť��ѡ�к�:�Ӿ�Ч���ı�*/
function check4(o) {
if(o.parentElement.parentElement.style.backgroundColor=='#ffe1d2'){
    o.parentElement.parentElement.style.backgroundColor='';
}
else o.parentElement.parentElement.style.backgroundColor='#ffe1d2';
}

function setYellowBkColor(o) {
	//���û�ɫ�ı�����ɫ
	o.parentElement.parentElement.style.backgroundColor = '#ffe1d2';
}

function clearBkColor(o) {
	//���������ɫ
	o.parentElement.parentElement.style.backgroundColor = '';
}
/*����ǳ�Ƶ���ɫ��������--------------------------------------------------------------------*/

/*����ǳ�Ƶ���ɫ����� tr ����ɫ�ı䡿--------------------------------------------------------------------*/
function clickChange(o) {
	//��� tr ����ɫ�ı�
	var table = o.parentElement;
	//if (table.rows)
	for (i=0;i<table.rows.length;i++) {
		//����Ǻ�ɫ���򲻸ı���ɫ����Ϊ��ɫ������Ҫɾ����������
		if (table.rows(i).style.backgroundColor=='#ff0000') continue;
		if (o.rowIndex==i) {
			//�ı�ָ���е���ɫ
			table.rows(i).style.backgroundColor='#ffe1d2';
		}else{
			//�������ɫȥ��
			table.rows(i).style.backgroundColor='';
		}
	}
}

function clickChangeTD(o) {
	//��� td ����ɫ�ı�
	clickChange(o.parentElement);
}
/*����ǳ�Ƶ���ɫ���������ɫ�ı䡿��������--------------------------------------------------------------------*/

/*����������ɫ--------------------------------------------------------------------*/

/*����������������:������ڱ���һ��,������̬�Ӿ�Ч��*/
function sbar (st,col) {
  if((st.style.backgroundColor != '#ff0000') && (st.style.backgroundColor != '#ffe1d2')){
 	 st.style.backgroundColor = '#eeeeee';
  }
}
function cbar (st) {
  if((st.style.backgroundColor != '#ff0000') && (st.style.backgroundColor != '#ffe1d2')){
 	 st.style.backgroundColor = '';
  }
}
/*��radio��ť��ѡ�к�:�Ӿ�Ч���ı�*/
function check2(o) {
	//alert("radio");
if(o.parentElement.parentElement.style.backgroundColor=='#ff0000'){
    o.parentElement.parentElement.style.backgroundColor='';
}
else o.parentElement.parentElement.style.backgroundColor='#ff0000';
}
/*����������ɫ��������--------------------------------------------------------------------*/


/*�������⡾���������������ɫ--------------------------------------------------------------------*/
/*����������������:������ڱ���һ��,������̬�Ӿ�Ч��*/
function sbar2 (st,col) {
  if(st.style.backgroundColor != col){
 	 st.style.backgroundColor = '#eeeeee';
  }
}
function cbar2 (st,col) {
  if(st.style.backgroundColor != col){
 	 st.style.backgroundColor = '';
  }
}

/*����������������:������ڱ���һ��,������̬�Ӿ�Ч��*/
/*
function sbar (st,col)
{ st.style.backgroundColor = '#eeeeee'; }

function cbar (st)
{ st.style.backgroundColor = ''; }
*/

/*��radio��ť��ѡ�к�:�Ӿ�Ч���ı�*/
function check(o,c) {
if(o.parentElement.parentElement.style.backgroundColor==c){
    o.parentElement.parentElement.style.backgroundColor='';
}
else o.parentElement.parentElement.style.backgroundColor=c;
}

function check3(o,c){
		o.parentElement.parentElement.style.backgroundColor=c;
}
/*�������⡾���������������ɫ��������--------------------------------------------------------------------*/
