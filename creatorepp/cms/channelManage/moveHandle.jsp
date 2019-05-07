<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.List"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.documentmanager.*"%>
<%@ page import="com.chinacreator.cms.driver.publish.impl.*"%>
<%@ page import="com.chinacreator.cms.driver.publish.*"%>
<%@ page import="com.chinacreator.cms.searchmanager.*"%>
<%
    AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request, response);
    
    String  siteId = request.getParameter("siteId");   //���վ��id���ĵ����ڵ�վ��id 
    
    String  docidstr = request.getParameter("docidStr"); 
    String  channelid = request.getParameter("channelid");
    
    DocumentManager idm = new DocumentManagerImpl();
    //�õ��ĵ�id����,Ϊ�ַ�������
    String[] docid;
    int[] intDocid = null;
    if(docidstr != null){
        docid = docidstr.split(":");
        //�õ��ĵ�id����������
        intDocid = new int[docid.length];
        for(int i=0;i<docid.length;i++){
            intDocid[i] = Integer.parseInt(docid[i]);
        }
    }

    //weida
    session.removeAttribute("docIds_moveDoc");
    session.setAttribute("docIds_moveDoc",intDocid);
    session.removeAttribute("siteId_moveDoc");
    session.setAttribute("siteId_moveDoc",siteId);
    %>
    <html><body>
    <iframe name="deleteIndexsFrame" src="DeleteIndexsHandle.jsp?action=moveDoc"></iframe>
    </body></html>
    <%
    
    //�ƶ���������
    try{
                
        //��ʼ���ݹ淢��
        WEBPublish publish = new WEBPublish();
        //����洢�ѷ����ĵ��б��������Ա���еݹ鷢��
        java.util.List docs = new java.util.ArrayList();
        for(int i=0;i<intDocid.length;i++){
            Document doc = idm.getPartDocInfoById(intDocid[i] + "");
            if(doc.getStatus()==5){
                docs.add(doc);
                //ɾ�������������ļ�
                publish.deletePublishFile(siteId,intDocid[i],request,response);
            }
        }
        
        idm.moveDoc(request,intDocid,Integer.parseInt(channelid));
        
        //�ݹ鷢���ĵ�
        if(docs.size() > 0)
        {
            int action = RecursivePublishManager.ACTIONTYPE_DELETE;
            session.removeAttribute("docs");
            session.setAttribute("docs",docs);
        %>
            <html>
            <body>
            <iframe name="recursiveFrame" src="recursiveHandle.jsp?siteId=<%=siteId%>&action=<%=action%>"></iframe>
            </body>
            </html>
        <%
        }   
%>
<script language="javascript">
    alert("�����ɹ���");
    window.close();
    var str = window.dialogArguments.location.href;
    var end = str.indexOf("?");
    var strArray;
    if(end != -1)
        strArray= str.slice(0,end);
    else
        strArray = str;
    window.dialogArguments.location.href = strArray+"?"+window.dialogArguments.document.all.queryString.value;
</script>
<%
    }catch(DocumentManagerException de){
        de.printStackTrace();
%>
        <script language="javascript">
            alert("���ݿ����ʧ�ܣ�");
            window.close();
        </script>
<%
    }
%>