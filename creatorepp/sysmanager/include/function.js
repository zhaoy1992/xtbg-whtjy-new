/**
 * ͨ��ȫѡ����
 */
function checkAll(formName,elementID,checkBox) {
	var e = document.forms(formName).item(elementID);

	if(e)
	{
		if(e.length)
		{
			for(i = 0; i < e.length; i ++)
				e[i].checked = checkBox.checked;
		}
		else
		{
			e.checked = checkBox.checked;
		}
	}
}

/**
 * ���ݵ�����ѡ���״̬������ȫѡ���ѡ��״̬
 */
function checkboxevent(formName, checkbox, checkAllBox)
{
	var element = document.forms(formName).item(checkbox);
	var allCheckBox = document.forms(formName).item(checkAllBox);
	if(element)
	{
		if(element.length)
		{
			for(i = 0; i < element.length; i ++)
			{
				if(!element[i].checked)
				{
					allCheckBox.checked = element[i].checked;
					return;
				}

			}
			allCheckBox.checked = true;
		}
		else
			allCheckBox.checked = element.checked;

	}
}
/**
 * �޸Ļ���֪ͨ״̬
 */

function changeStatus(formName,meeting_id,modifyType,isStop,isHidden,meetingStatus,queryString)
{
	//�޸ķ���״̬
	if(modifyType == "meetingStatus" && confirm("ȷ��Ҫ�����û���֪ͨ��"))
	{
		document.forms(formName).statusType.value = modifyType;
		document.forms(formName).returnLink.value = queryString;
		document.forms(formName).status.value = 1;
		document.forms(formName).meeting_id.value = meeting_id;
		document.forms(formName).submit();

	}
	//�޸�����״̬
	if(modifyType == "isHidden" && confirm("ȷ��Ҫ"+ (isHidden == 0?"��ʾ":"����") +"�û���֪ͨ��"))
	{

		document.forms(formName).statusType.value = modifyType;
		document.forms(formName).returnLink.value = queryString;
		document.forms(formName).meeting_id.value = meeting_id;
		if(isHidden == 0)
			document.forms(formName).status.value = 1;
		else
			document.forms(formName).status.value = 0;
		document.forms(formName).submit();

	}
	//�޸ı�����ֹ״̬
	if(modifyType == "isStop" && confirm("ȷ��Ҫ"+ (isStop == 0?"��ͨ":"��ֹ") +"�û���֪ͨ��"))
	{
		document.forms(formName).statusType.value = modifyType;
		document.forms(formName).returnLink.value = queryString;
		document.forms(formName).meeting_id.value = meeting_id;
		if(isStop == 0)
			document.forms(formName).status.value = 1;
		else
			document.forms(formName).status.value = 0;
		document.forms(formName).submit();

	}
}

/**
 * ɾ����¼ͨ�ú���
 */
function deleteRecord(formName,deleteID)
{
	var element = document.forms(formName).item(deleteID);
	if(element)
	{
		if(element.length)
		{
			for(i = 0; i < element.length; i ++)
				if(element[i].checked)
				{
					//\r\n���ɾ������ɾ�����������֪ͨ��ص���Ϣ������\r\n����ԭ�ģ����鲹��֪ͨ�����鱨����Ϣ����
					if(confirm("��ȷ��Ҫɾ��ѡ�е��û���"))
						document.forms(formName).submit();
					return;
				}
			alert("��ѡ��Ҫɾ�����û�");
			return;
		}
		else
		{
			if(!element.checked)
			{
				alert("��ѡ��Ҫɾ�����û�");
				return;
			}
			else
			{
				//\r\n���ɾ������ɾ�����������֪ͨ��ص���Ϣ������\r\n����ԭ�ģ����鲹��֪ͨ�����鱨����Ϣ����
				if(confirm("��ȷ��Ҫɾ��ѡ�е��û���"))
					document.forms(formName).submit();
				return ;
			}
		}
	}
	else
	{
		alert("û��Ҫɾ�����û�");
		return;

	}
}


/**
 * ���油�����֪ͨ
 */
function doSave(formName,contraintField)
{
	var element = document.forms(formName).item(contraintField);
	if(checkNull(element.value))
	{
		alert("����֪ͨ���ݲ���Ϊ�գ�");
		return;
	}
	document.forms(formName).submit();
}

/**
 * ����/Ԥ��/��������֪ͨ
 */
function doMeetingNoteAction(formName,action)
{
	var sourceNumber = document.forms(formName).item("sourceNumber");
	var meetingType_ID = document.forms(formName).item("meetingType_ID");
	var urgencyLevel = document.forms(formName).item("urgencyLevel");
	var meetingTime = document.forms(formName).item("meetingTime");
	var meetingPlace = document.forms(formName).item("meetingPlace");
	var meetingSubject = document.forms(formName).item("meetingSubject");
	//var meetingContent = document.forms(formName).item("meetingContent");
	var meetingLinkman = document.forms(formName).item("meetingLinkman");
	var meetingLinkPhone = document.forms(formName).item("meetingLinkPhone");
	var linkManFax = document.forms(formName).item("linkManFax");
	document.forms(formName).actiontype.value = action;

	var message = "";
	if(checkNull(sourceNumber.value))
	{
		message += "�����Ų���Ϊ��\r\n";
	}
	if(meetingType_ID.value == "-1")
		message += "��ѡ���������\r\n";
	if(urgencyLevel.value == "-1")
		message += "��ѡ����黺���̶�\r\n";

	if(checkNull(meetingTime.value) || !checkDateFormat(meetingTime.value))
		message += "����ʱ�䲻��Ϊ�ջ�ʱ���ʽ����ȷ������Ϊ2005-04-05 12��00��ʽ\r\n";
	if(checkNull(meetingPlace.value))
		message += "����ص㲻��Ϊ��\r\n";
	if(checkNull(meetingSubject.value))
		message += "��������ⲻ��Ϊ��\r\n";
	//if(checkNull(meetingContent.value))
	//	message += "��༭����֪ͨ����\r\n";
	if(checkNull(meetingLinkman.value))
		message += "������ϵ�˲���Ϊ��\r\n";
	if(checkNull(meetingLinkPhone.value))
		message += "������ϵ�绰����Ϊ��\r\n";
	if(message != "")
	{
		alert("���棺\r\n" + message);
		return;
	}
	if(action == "publish")
	{
	    if(confirm("��ȷ��Ҫ��������֪ͨ��"))
    	    document.forms(formName).submit();
    }
    else if(action == "preview")
	{
	    document.forms(formName).action = "meetingnote_preview.jsp"
	    document.forms(formName).target = "_blank";
    	document.forms(formName).submit();
    }
    else
    {
        document.forms(formName).submit();
    }

}

/**
 * Ԥ������֪ͨ
 */
function preview(formName)
{
}

//���value�Ƿ�Ϊ�ջ�մ�
function checkNull(value)
{
	if(!value || value == "")
		return true;
	return false;
}

function checkDateFormat(value)
{
	return true;
}


function addUndertakerUnit(formName,units)
{
	var hasChoose = false;
	var unitID = document.forms(formName).item(units);
	if(unitID)
	{
		if(unitID.length)
		{
			for(i = 0; i < unitID.length; i ++)
				if(unitID[i].checked)
				{
					hasChoose = true;
					break;
				}
		}
		else
		{
			if(!unitID.checked)
			{
			}
			else
			{
				hasChoose = true;
			}
		}
	}
	//if(!hasChoose)
	//{
	//	alert("��ѡ��λᵥλ��λᵥλ���ͣ�");
	//	return;
	//}
	document.forms(formName).submit();
}
function addUnit(formName,units)
{
	var hasChoose = false;

	var unitID = document.forms(formName).item(units);

	if(unitID)
	{
		if(unitID.length)
		{
			for(i = 0; i < unitID.length; i ++)
				if(unitID[i].checked)
				{
					hasChoose = true;
					break;
				}
		}
		else
		{
			if(!unitID.checked)
			{
			}
			else
			{
				hasChoose = true;
			}
		}
	}
	if(!hasChoose)
	{
		alert("��ѡ��λᵥλ��");
		return;
	}
	document.forms(formName).submit();

}
function addUnitType(formName)
{
	var unitTypeID = document.forms(formName).unitType
	var hasChoose = false;
	if(unitTypeID)
	{
		if(unitTypeID.length)
		{
			for(i = 0; i < unitTypeID.length; i ++)
				if(unitTypeID[i].checked)
				{
					hasChoose = true;
					break;
				}
		}
		else
		{
			if(!unitTypeID.checked)
			{
			}
			else
			{
				hasChoose = true;
			}
		}
	}

	if(!hasChoose)
	{
		alert("��ѡ��λᵥλ��λᵥλ���ͣ�");
		return;
	}
	document.forms(formName).submit();
}

function closeChooseUnitWindow()
{
	//alert(window.parent.opener.document.all.item("unit").value = );
	window.parent.close();
}


function deleteUnitType(formName,deleteID)
{
	var element = document.forms(formName).item(deleteID);
	if(element)
	{
		if(element.length)
		{
			for(i = 0; i < element.length; i ++)
				if(element[i].checked)
				{
					if(confirm("��ȷ��Ҫɾ���μӻ��鵥λ������"))
						document.forms(formName).submit();
					return;
				}
			alert("��ѡ��Ҫɾ���μӻ��鵥λ����");
			return;
		}
		else
		{
			if(!element.checked)
			{
				alert("��ѡ��Ҫɾ���μӻ��鵥λ����");
				return;
			}
			else
			{
				if(confirm("��ȷ��Ҫɾ���μӻ��鵥λ������"))
					document.forms(formName).submit();
				return ;
			}
		}
	}
	else
	{
		alert("û��Ҫɾ���Ĳμӻ��鵥λ����");
		return;

	}
}

function deleteUnit(formName,OrgUnitID)
{
	var element = document.forms(formName).item(OrgUnitID);
	if(element)
	{
		if(element.length)
		{
			for(i = 0; i < element.length; i ++)
				if(element[i].checked)
				{
					if(confirm("��ȷ��Ҫɾ���μӻ��鵥λ��"))
						document.forms(formName).submit();
					return;
				}
			alert("��ѡ��Ҫɾ���μӻ��鵥λ");
			return;
		}
		else
		{
			if(!element.checked)
			{
				alert("��ѡ��Ҫɾ���μӻ��鵥λ");
				return;
			}
			else
			{
				if(confirm("��ȷ��Ҫɾ���μӻ��鵥λ��"))
					document.forms(formName).submit();
				return ;
			}
		}
	}
	else
	{
		alert("û��Ҫɾ���Ĳμӻ��鵥λ");
		return;

	}
}

function deleteOriginText(formName,id)
{
	if(confirm("ȷ��Ҫɾ������ԭ����"))
	{
		document.forms(formName).originTextID.value = id;
		//document.forms(formName).action.value="deleteOriginText";
		document.forms(formName).submit();
		//location.replace(formName);
	}
}

function upload(id,url)
{
	if(id != "-1")
	{
		if(confirm("ȷ��Ҫ�滻ԭ�����ĵ���"))
		{
			window.open(url);
		}
	}
	else
		window.open(url);
}

/**
 * ѡ��ģ��ʱ���л�����֪ͨ������������
 */
function changeTemplate(formName,element)
{

	var template = element.options[element.selectedIndex].value;

	if(template == "-1")
		return;
	if(!confirm("��ȷ��Ҫʹ��ģ����\r\n��������ģ�壬��ǰ����Ϣ����ʧ��"))
	    return;

	var templateInfo = template.split(":") ;
	window.opener.document.forms(formName).meetingTemplate_ID.value= templateInfo[0];
	var meetingContent = window.opener.document.forms(formName).meetingContent.value;

	var idx = templateInfo[1].indexOf(".");
	var fileName = templateInfo[1].substring(0,idx);
	var url = window.opener.document.forms(formName).meetingContenthref.value;

	var q = url.indexOf("?");
	if(q != -1)
	    url += "&sTemplate=/upload/template/" + fileName;
	else
	    url += "?sTemplate=/upload/template/" + fileName;

    url += "&sOpenModelFileName=" + meetingContent + "&meetingTemplate_ID=" + templateInfo[0];
	//document.fmeetingContent.location.replace(url);
	location.replace(url);
}
function addContent(formName)
{
   	var url = document.forms(formName).meetingContenthref_true.value;
   	window.open(url);
}
/**
 * �༭����֪ͨҳ�淵�غ���
 */
function returnButton(formName)
{
	document.forms(formName).submit();
}
