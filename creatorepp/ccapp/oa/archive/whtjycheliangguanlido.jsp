<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="java.util.List" %>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageCarBean"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.service.CarManageCarServiceIfc"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.service.impl.CarManageCarServiceImpl"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.entity.CarEditInfoBean"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.service.CarEditInfoService"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.service.impl.CarEditInfoServiceImpl"%>

<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
//对服务器的所有操作，具体调用后台的哪个方法操作用method来判断执行
String method = request.getParameter("method");
String car_id = request.getParameter("car_id")!=null?request.getParameter("car_id"):"";
CarManageCarServiceIfc service = new CarManageCarServiceImpl();

String pro_name = request.getParameter("pro_name")!=null?request.getParameter("pro_name"):"";
String pro_num = request.getParameter("pro_num")!=null?request.getParameter("pro_num"):"";
String pro_unit = request.getParameter("pro_unit")!=null?request.getParameter("pro_unit"):"";
String think_price = request.getParameter("think_price")!=null?request.getParameter("think_price"):"";
String price = request.getParameter("price")!=null?request.getParameter("price"):"";
String count_price = request.getParameter("count_price")!=null?request.getParameter("count_price"):"";
String remark = request.getParameter("remark")!=null?request.getParameter("remark"):"";
String tableName = request.getParameter("tableName");

CarEditInfoService editService = new CarEditInfoServiceImpl();

if(method != null || "".equals(method)){
	if(method.equals("getCarList")){
		response.setContentType("application/x-json");
		CarManageCarBean carBean1 = (CarManageCarBean)service.getCarId(car_id,tableName);
		String c_id = carBean1!=null?carBean1.getCar_id():"";
		List<CarManageCarBean> list = (List<CarManageCarBean>)service.getAllCarList();
		StringBuffer str = new StringBuffer();
		str.append("<option value=''>--请选择--</option>");
		if(list!=null && list.size()>0){
			String selected = "";
			for(CarManageCarBean carBean : list){
				selected = c_id.equals(carBean.getCar_id())?"selected":"";
				str.append("<option value='"+carBean.getCar_id()+"' "+selected+">"+carBean.getCar_num()+"</option>");
			}
		}
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result",str.toString());
		response.getWriter().print(jsonObj);
		
	} else if(method.equals("getCarInfo")){
		response.setContentType("application/x-json");
		StringBuffer str = new StringBuffer();
		if(car_id!=null && !car_id.equals("")){
			CarManageCarBean carBean = (CarManageCarBean)service.getCarByCarId(car_id);
			if(carBean!=null){
				str.append(""+carBean.getDriver()+"");
			}
		}else{
			str.append("");
		}
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result",str.toString());
		response.getWriter().print(jsonObj);
	} else if(method.equals("editinsert")){
		response.setContentType("application/x-json");
		CarEditInfoBean bean = new CarEditInfoBean();
		bean.setCar_id(car_id);
		bean.setPro_name(pro_name);
		bean.setPro_num(pro_num);
		bean.setPro_unit(pro_unit);
		bean.setThink_price(think_price);
		bean.setPrice(price);
		bean.setCount_price(count_price);
		bean.setRemark(remark);
		boolean result = editService.insert(bean);
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result",result);
		response.getWriter().print(jsonObj);
	} else if(method.equals("editdelete")){
		response.setContentType("application/x-json");
		CarEditInfoBean bean = new CarEditInfoBean();
		bean.setCar_id(car_id);
		boolean result = editService.delete(bean);
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result",result);
		response.getWriter().print(jsonObj);
	}
}
%>