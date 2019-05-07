<%@ page language="java" contentType="text/html; charset=GBK"%>

<html>
<head>
<title>¿ØÖÆ×ó²Ëµ¥ÏÔÒþ</title>

<script language="JavaScript">
var LEFT_MENU_VIEW=0;

function leftmenu_open()
{
   LEFT_MENU_VIEW=0;
   leftmenu_ctrl();
}

function leftmenu_ctrl()
{
   if(LEFT_MENU_VIEW==0)
   {
      parent.document.getElementById('centerFrame').cols="676,380,0";
      LEFT_MENU_VIEW=1;
      myarrow.src="../../resources/images/rightD.jpg";
   }
   else
   {
      parent.document.getElementById('centerFrame').cols="*,8,0";
      LEFT_MENU_VIEW=0;
      myarrow.src="../../resources/images/leftD.jpg";
   }
}

function setPointer(theRow, thePointerColor)
{
    if (typeof(theRow.style) == 'undefined' || typeof(theRow.cells) == 'undefined')
    {
        return false;
    }

    var row_cells_cnt=theRow.cells.length;
    for (var c = 0; c < row_cells_cnt; c++)
    {
        theRow.cells[c].bgColor = thePointerColor;
    }

    return true;
}

</script>
</head>

<body topmargin="0" leftmargin="0" onload="leftmenu_ctrl()">

 <table cellspacing="0" width="100%" height="100%" cellpadding="0" align="center" class="col">
   <tr>
     <td>
       <table cellspacing="0" width="100%" height="50" border="0" cellpadding="0">
         <tr onclick="leftmenu_ctrl()" onmouseover="setPointer(this, '#D3E5FF')" onmouseout="setPointer(this, '#EEEEEE')">
           <td style="cursor:hand">
           <img id="myarrow" src="../../resources/images/rightD.jpg" >
           </td>
           </tr>
         </table>
     </td>
   </tr>
 </table>
</body>
</html>
