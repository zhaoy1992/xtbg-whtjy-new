<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="cms"%>


<html>
    <%@ include file="/epp/css/cssControl.jsp"%><body >
    <cms:vote>
    <TABLE>
        <cms:outline datatype="questions" channel="6">
        	<tr><td>
        		<cms:question optionstyle=""/><p>
			</td></tr>
        </cms:outline>
    </TABLE>
    <cms:votebutton/>
    </cms:vote>
</html>
