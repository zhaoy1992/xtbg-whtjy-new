<%--
描述：办公用品入库数据处理页面
作者：童佳
版本：1.0
日期：2014-03-11
--%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.entity.OsHavaObjectBean"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsHavaObjectServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsHavaObjectService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.util.regex.Matcher"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	
	String responseCode="";//1:回调js
	Object responseObj=null;
	String responseObj_SUCCESS="操作成功";
	String responseObj_FIAL="操作失败";
	
	String action1 = request.getParameter("action1");
	//System.out.println(action1);
	 //物品名称
    String[] OFUSTYPE_NAME_VALUE_Arr = request.getParameterValues("OFUSTYPE_NAME_VALUE");
    
    //物品ID
    String[] OFUSTYPE_ID_VALUE_Arr = request.getParameterValues("OFUSTYPE_ID_VALUE");
    
    //物品规格名称
    String[] IT_NAME_VALUE_Arr = request.getParameterValues("IT_NAME_VALUE");
    
    //物品规格ID
    String[] IT_ID_VALUE_Arr = request.getParameterValues("IT_ID_VALUE");
    
    //入库时间
    String T_HA_BUYDATE = request.getParameter("T_HA_BUYDATE");
    
  	//入库人ID
    String T_HA_RKUSER_ID = request.getParameter("T_HA_RKUSER_ID");
  
 	//入库人名称
    String T_HA_RKUSER_NAME = request.getParameter("T_HA_RKUSER_NAME");
    
    //审批表ids
    String osExaIds = request.getParameter("osExaIds");
    
    //主键ID
    String[] T_HA_ID_Arr = request.getParameterValues("T_HA_ID");
    
    //物品分类ID
    String[] OFTYPE_ID_Arr = request.getParameterValues("OFTYPE_ID");
    
    //物品分类name
	String[] OFTYPE_NAME_Arr = request.getParameterValues("OFTYPE_NAME");
	
	 //数量
	String[] T_HA_NO_Arr = request.getParameterValues("T_HA_NO");
	
	 //已入库数量
	String[] T_OSEXA_OBRK_NO_Arr = request.getParameterValues("T_OSEXA_OBRK_NO"); 
 
	 //审批物品ID
	String[] T_OSEXA_OB_ID_Arr = request.getParameterValues("T_OSEXA_OB_ID"); 
	 
	 //审批表ID
	String[] T_OSEXA_ID_Arr = request.getParameterValues("T_OSEXA_ID");
	 
	//所属部门ID
	String[] T_HA_ORG_ID_Arr = request.getParameterValues("T_HA_ORG_ID"); 
	
	//所属部门名称
	String[] T_HA_ORG_NAME_Arr = request.getParameterValues("T_HA_ORG_NAME"); 
	 
	 //单价
	String[] T_HA_DJ_Arr = request.getParameterValues("T_HA_DJ");
	 
	 //数量
	String[] T_HA_SL = request.getParameterValues("T_HA_SL");

	 //备注
	String[] T_HA_BZ_Arr = request.getParameterValues("T_HA_BZ");
	 
	//设备编号
	String[] T_HA_SBNO_Arr = request.getParameterValues("T_HA_SBNO");
	
	//生产厂商
	String[] T_HA_GHMAN_Arr = request.getParameterValues("T_HA_GHMAN");

	//售后电话
	String[] T_HA_OVERTEL_Arr = request.getParameterValues("T_HA_OVERTEL");
	
	boolean flag = false;
	String action = request.getParameter("action");
	OsHavaObjectService osHavaObjectService = new OsHavaObjectServiceImpl();
	
	boolean flag_two = false;
	boolean upState = false;
	if("addOsMore".equals(action)){
		responseCode = "1";
		String beanId = "";
		for(int i = 0; i<IT_ID_VALUE_Arr.length; i++){
			OsHavaObjectBean osHavaObjectBean = new OsHavaObjectBean();
			osHavaObjectBean.setIt_id(IT_ID_VALUE_Arr[i]);
			osHavaObjectBean.setIt_name(IT_NAME_VALUE_Arr[i]);
			osHavaObjectBean.setOftype_id(OFTYPE_ID_Arr[i]);
			osHavaObjectBean.setOftype_name(OFTYPE_NAME_Arr[i]);
			osHavaObjectBean.setOfustype_id(OFUSTYPE_ID_VALUE_Arr[i]);
			osHavaObjectBean.setOfustype_name(OFUSTYPE_NAME_VALUE_Arr[i]);
			osHavaObjectBean.setT_ha_buydate(T_HA_BUYDATE);
			osHavaObjectBean.setT_ha_no(T_HA_NO_Arr[i]);
			osHavaObjectBean.setT_ha_dj(T_HA_DJ_Arr[i]);
			osHavaObjectBean.setT_ha_bz(T_HA_BZ_Arr[i]);
			osHavaObjectBean.setT_ha_id(T_HA_ID_Arr[i]);
			osHavaObjectBean.setT_ha_rkuser_id(T_HA_RKUSER_ID);
			osHavaObjectBean.setT_ha_rkuser_name(T_HA_RKUSER_NAME);
			
			List<Map<String, String>> havaValueList = new ArrayList<Map<String,String>>();
			havaValueList = osHavaObjectService.queryHavaInfoByItId(IT_ID_VALUE_Arr[i]);
			if(havaValueList.size()>0){
				osHavaObjectBean.setT_ha_id(havaValueList.get(0).get("t_ha_id"));
				long t_ha_no = Long.parseLong(havaValueList.get(0).get("t_ha_no"));
				long now_t_ha_no = Long.parseLong(T_HA_NO_Arr[i]);
				t_ha_no += now_t_ha_no;
				osHavaObjectBean.setT_ha_no(""+t_ha_no);
			}
			if(!StringUtil.isBlank(IT_ID_VALUE_Arr[i])){
				beanId = osHavaObjectService.insertOrupdateHavaObject(osHavaObjectBean);
			}
			if(!StringUtil.isBlank(T_HA_NO_Arr[i]) && !StringUtil.isBlank(IT_ID_VALUE_Arr[i])){                             //易耗品增加的操作
				long T_OSEXA_OBRK_NO = Long.parseLong(T_OSEXA_OBRK_NO_Arr[i]);   //已入库的数量
				long now_t_ha_true_no = Long.parseLong(T_HA_NO_Arr[i]);          //填写的数量
				T_OSEXA_OBRK_NO += now_t_ha_true_no;
				osHavaObjectService.updateOsexaObjectRKNO(T_OSEXA_OB_ID_Arr[i], ""+T_OSEXA_OBRK_NO);   //更新审批表物品的已入库数量
				
				flag_two = osHavaObjectService.allObjectHavaRK(T_OSEXA_ID_Arr[i]);               //所有审批物品数量都入库后
				if(flag_two){
					upState = osHavaObjectService.updateOsExaByIds(T_OSEXA_ID_Arr[i]);                    //审批表入库状态更新
				}
			}
		}
		if(beanId!=null&&beanId.length()>0){
			responseObj = responseObj_SUCCESS+","+beanId;
		}else{
			responseObj = responseObj_FIAL;
		}
	}else if("addOsNoMove".equals(action)){
		responseCode = "1";
		String beanId = "";
		
		for(int i = 0; i<OFTYPE_ID_Arr.length; i++){
			int count =Integer.valueOf(T_HA_SL[i]);//入库数量
			//【物品库存】-【固定资产库存】的【固定资产入库】页面的【物品列表】增加【数量列】。
			//当数量某个物品的数量为5时点击【入库】则添加5条相同物品记录。该列默认值为【1】，如果为小于1的数字则改为0，同时校验填写的数字必须为>=0的整数。
			//当数量为0就不添加该条物品记录。
			for(int j = 0;j < count;j++ ){
				OsHavaObjectBean osHavaObjectBean = new OsHavaObjectBean();
				osHavaObjectBean.setIt_name(IT_NAME_VALUE_Arr[i]);
				osHavaObjectBean.setOftype_id(OFTYPE_ID_Arr[i]);
				osHavaObjectBean.setOftype_name(OFTYPE_NAME_Arr[i]);
				osHavaObjectBean.setOfustype_name(OFUSTYPE_NAME_VALUE_Arr[i]);
				osHavaObjectBean.setT_ha_buydate(T_HA_BUYDATE);
				osHavaObjectBean.setT_ha_dj(T_HA_DJ_Arr[i]);
				osHavaObjectBean.setT_ha_id(T_HA_ID_Arr[i]);
				osHavaObjectBean.setT_ha_rkuser_id(T_HA_RKUSER_ID);
				osHavaObjectBean.setT_ha_rkuser_name(T_HA_RKUSER_NAME);
				osHavaObjectBean.setT_ha_sbno(T_HA_SBNO_Arr[i]);
				osHavaObjectBean.setT_ha_ghman(T_HA_GHMAN_Arr[i]);
				osHavaObjectBean.setT_ha_overtel(T_HA_OVERTEL_Arr[i]);
				osHavaObjectBean.setT_ha_bz(T_HA_BZ_Arr[i]);
				osHavaObjectBean.setT_ha_org_id(T_HA_ORG_ID_Arr[i]);
				osHavaObjectBean.setT_ha_org_name(T_HA_ORG_NAME_Arr[i]);
				osHavaObjectBean.setT_ha_sbstate("1");//状态  1在库  2领用   3在修  4报废
				
				if(!StringUtil.isBlank(OFTYPE_ID_Arr[i])){
					beanId = osHavaObjectService.insertOrupdateHavaObject(osHavaObjectBean);
				}
			}
			
			//操作成功
			if(count==0){
				beanId = "sucess";
			}
		}
		
		if(beanId!=null&&beanId.length()>0){
			responseObj = responseObj_SUCCESS+","+beanId;
		}else{
			responseObj = responseObj_FIAL;
		}
	}

	if("deleteOsupplieTypeInfo".equals(action)){
		responseCode = "1";
		
	}
	
	if("1".equals(responseCode)){
		if(responseObj!=null){
			String result = "";
			if(responseObj instanceof String){
				result = responseObj.toString();
			}else{
				result = JSON.toJSONString(responseObj,true);
				Pattern p = Pattern.compile("\\s*|\t|\r|\n");
				Matcher m = p.matcher(result);
				result= m.replaceAll("");
			}
		%>
<html>
	<head></head>
	<body>
	<script>
		try{
			var result='<%=result%>';
			eval("parent.afterSubmitFn('"+result+"');");
		}catch(e){alert(e.description);}
	</script>
	</body>
</html>
	<%
		}
	}
	%>