package com.chinacreator.security;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.security.Principal;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.security.auth.Subject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;

import org.apache.log4j.Logger;
import org.frameworkset.spi.BaseSPIManager;
import org.frameworkset.spi.SPIException;

import com.chinacreator.config.ConfigManager;
import com.chinacreator.epp.applymanager.dbmanager.ApplyManager;
import com.chinacreator.epp.util.AppDBNameThreadLocal;
import com.chinacreator.epp.util.AppIdThreadLocal;
import com.chinacreator.epp.util.EgpManager;
import com.chinacreator.framework.Framework;
import com.chinacreator.framework.FrameworkServlet;
import com.chinacreator.security.authentication.CheckCallBack;
import com.chinacreator.security.authentication.Credential;
import com.chinacreator.security.authentication.EncrpyPwd;
import com.chinacreator.security.authentication.LoginContext;
import com.chinacreator.security.authentication.LoginException;
import com.chinacreator.security.authentication.UsernamePasswordCallbackHandler;
import com.chinacreator.security.authorization.AccessException;
import com.chinacreator.security.authorization.AuthPrincipal;
import com.chinacreator.security.authorization.AuthRole;
import com.chinacreator.security.authorization.AuthUser;
import com.chinacreator.security.authorization.impl.AppSecurityCollaborator;
import com.chinacreator.security.context.AppAccessContext;
import com.chinacreator.security.util.CookieUtil;
import com.chinacreator.synchronize.httpclient.ApachePostMethodClient;
import com.chinacreator.sysmgrcore.entity.Group;
import com.chinacreator.sysmgrcore.entity.Organization;
import com.chinacreator.sysmgrcore.entity.Role;
import com.chinacreator.sysmgrcore.entity.User;
import com.chinacreator.sysmgrcore.exception.ManagerException;
import com.chinacreator.sysmgrcore.manager.LogManager;
import com.chinacreator.sysmgrcore.manager.OrgManager;
import com.chinacreator.sysmgrcore.manager.SecurityDatabase;
import com.chinacreator.sysmgrcore.manager.UserManager;
import com.chinacreator.sysmgrcore.manager.db.GroupCacheManager;
import com.chinacreator.sysmgrcore.manager.db.JobManagerImpl;
import com.chinacreator.sysmgrcore.manager.db.OrgAdminCache;
import com.chinacreator.sysmgrcore.manager.db.OrgCacheManager;
import com.chinacreator.sysmgrcore.manager.db.RoleCacheManager;
import com.chinacreator.sysmgrcoreext.manager.IUserManagerExt;
import com.chinacreator.xtbg.core.workbench.entity.UserSessionBean;
import com.frameworkset.common.poolman.DBUtil;
import com.frameworkset.common.poolman.PreparedDBUtil;
import com.frameworkset.util.StringUtil;

public class AccessControl
{
  private static final Logger log = Logger.getLogger(AccessControl.class);
  public static final String REMOTEADDR_CACHE_KEY = "REMOTEADDR_CACHE_KEY";
  public static final String MACADDR_CACHE_KEY = "MACADDR_CACHE_KEY";
  public static final String MACHINENAME_CACHE_KEY = "MACHINENAME_CACHE_KEY";
  public static final String SESSIONID_CACHE_KEY = "SESSIONID_CACHE_KEY";
  public static final String SERVER_IP_KEY = "SERVER_IP_KEY";
  public static final String SERVER_PORT_KEY = "SERVER_PORT_KEY";
  public static final String PRINCIPAL_INDEXS = "PRINCIPAL_INDEXS";
  public static final String PRINCIPALS_COOKIE = "PRINCIPALS_COOKIE";
  public static final String CREDENTIAL_INDEXS = "CREDENTIAL_INDEXS";
  public static final String SUBSYSTEM_ID = "subsystem_id";
  public static final String SUBSYSTEM_COOKIE = "SUBSYSTEM_COOKIE_ID";
  public static final String HEAD_SPLIT = "^@^";
  public static final String PRINCIPAL_SPLIT = "^_^";
  public static final String IDENTITY_SPLIT = "#$#";
  public static final String PRINCIPAL_CREDENTIAL_SPLIT = "^|^";
  public static final String CREDENTIAL_SPLIT = "@|@";
  public static final String CREDENTIAL_ATTRIBUTE_SPLIT = "@^@";
  public static final String ATTRIBUTE_SPLIT = "@~@";
  public static final String VISIBLE_PERMISSION = "visible";
  public static final String UNVISIBLE_PERMISSION = "unvisible";
  public static final String WRITE_PERMISSION = "write";
  public static final String READ_PERMISSION = "read";
  public static final String READ_WRITE_PERMISSION = "read_write";
  public static final String BAT_ROLE_ADD_PERMISSION = "batroleadd";
  public static final String BAT_JOB_ADD_PERMISSION = "batjobadd";
  public static final String BAT_ORG_ADD_PERMISSION = "batorgadd";
  public static final String BAT_RES_ADD_PERMISSION = "batresadd";
  public static final String SORT_USER_PERMISSION = "sortuser";
  public static final String SORT_ORG_PERMISSION = "sortorg";
  public static final String USER_MOVE_PERMISSION = "usermove";
  public static final String ADD_PERMISSION = "create";
  public static final String UPDATE_PERMISSION = "edit";
  public static final String DELETE_PERMISSION = "delete";
  public static final String DELIVER_PERMISSION = "deliver";
  public static final String WITHDRAW_DELIVER_PERMISSION = "withdrawdeliver";
  public static final String SUBPUBLISH_PERMISSION = "subpublish";
  public static final String DOCPUBLISH_PERMISSION = "docpublish";
  public static final String ARCHIVE_PERMISSION = "archive";
  public static final String TRANSMIT_PERMISSION = "transmit";
  public static final String ADD_DOCVER_PERMISSION = "addDocVer";
  public static final String MANAGE_DOCVER_PERMISSION = "manageDocVer";
  public static final String MANAGE_DOCCOMMENT_PERMISSION = "manageDocComment";
  public static final String UPARRANGE_PERMISSION = "addArrangeDoc";
  public static final String IMPORTDOC_PERMISSION = "importDoc";
  public static final String EXPORTDOC_PERMISSION = "exportDoc";
  public static final String EXECUTE_PERMISSION = "execute";
  public static final String TRASH_PERMISSION = "trash";
  public static final String AUDIT_PERMISSION = "audit";
  public static final String PUBLISH_CHNLBYINC = "chnlbyinc";
  public static final String SITE_WORKFLOW_PERMISSION = "workflow";
  public static final String SITE_VIEW = "siteview";
  public static final String SITEPUBLISH_PERMISSION = "sitepublish";
  public static final String SITEBYALL_PERMISSION = "sitebyall";
  public static final String SITEBYINC_PERMISSION = "sitebyinc";
  public static final String SITE_DOCSEARCH_PERMISSION = "docsearch";
  public static final String SITE_CONTENTMANAGEITEM_PERMISSION = "contentManageItem";
  public static final String CHANNELROOT_ADDCHANNEL_PERMISSION = "create_channel";
  public static final String SITE_TEMPMANAGER_PERMISSION = "templetmanager";
  public static final String SITE_TEMPLATEVIEW_PERMISSION = "templateview";
  public static final String SITE_TEMPLATEVIEWIMP_PERMISSION = "templateviewimp";
  public static final String SITE_TEMPLATEVIEWADD_PERMISSION = "templateviewadd";
  public static final String SITE_TEMPLATEVIEWEXP_PERMISSION = "templateviewexp";
  public static final String SITE_TEMPLATEVIEWDEL_PERMISSION = "templateviewdel";
  public static final String SITE_FILEVIEW_PERMISSION = "fileview";
  public static final String SITE_TPLCREATORFILE_PERMISSION = "tplcreatorFile";
  public static final String SITE_TPLCREATORDIRECTORY_PERMISSION = "tplcreatorDirectory";
  public static final String SITE_TPLDELFILE_PERMISSION = "tpldelFile";
  public static final String SITE_TPLSENDFILE_PERMISSION = "tplsendFile";
  public static final String SITE_TPLSENDBAG_PERMISSION = "tplsendBag";
  public static final String CHANNEL_ADDCHANNEL_PERMISSION = "createchannel";
  public static final String CHANNEL_WORKFLOW_PERMISSION = "chnlworkflow";
  public static final String CHANNEL_INDEXPIC_PERMISSION = "chnlindexpic";
  public static final String CHANNEL_ADDDOC_PERMISSION = "adddoc";
  public static final String CHANNEL_UPDATEDOC_PERMISSION = "updatedoc";
  public static final String CHANNEL_VIEWDOC_PERMISSION = "viewdoc";
  public static final String CHNL_VIEW = "chnlview";
  public static final String CHNLPUBLISH_PERMISSION = "chnlpublish";
  public static final String CHNLBYALL_PERMISSION = "chnlbyall";
  public static final String CHNLBYINC_PERMISSION = "chnlbyinc";
  public static final String COPYDOC_PERMISSION = "copydoc";
  public static final String ARRANGE_DOCM = "arrangedocm";
  public static final String CITEDOC_MANAGER = "citedocmanager";
  public static final String EXT_FIELD = "extfield";
  public static final String WITHDRAWPUBLISH_MANAGER = "withdrawPublish";
  public static final String TEMPLATE_TPLEXP_PERMISSION = "tplexp";
  public static final String TEMPLATE_TPLDEL_PERMISSION = "tpldel";
  public static final String TEMPLATE_TPLEDIT_PERMISSION = "tpledit";
  public static final String TEMPLATE_TPLREIMP_PERMISSION = "tplreimp";
  public static final String FULL_PERMISSION = "full";
  public static final String COLUMN_RESOURCE = "column";
  public static final String ORGUNIT_RESOURCE = "orgunit";
  public static final String RES_RESOURCE = "resmanager";
  public static final String GROUP_RESOURCE = "group";
  public static final String ROLE_RESOURCE = "role";
  public static final String DICT_RESOURCE = "dict";
  public static final String JOB_RESOURCE = "job";
  public static final String USER_RESOURCE = "user";
  public static final String SITE_RESOURCE = "site";
  public static final String SITE_APP_SET = "siteappset";
  public static final String SITECHANNEL_RESOURCE = "site.channel";
  public static final String SITEDOC_RESOURCE = "site.doc";
  public static final String SITETPL_RESOURCE = "sitetpl";
  public static final String SITEFILE_RESOURCE = "sitefile";
  public static final String CHANNEL_RESOURCE = "channel";
  public static final String CHANNELDOC_RESOURCE = "channeldoc";
  public static final String TEMPLATE_RESOURCE = "template";
  public static final String ADMINISTRATOR_ROLE = "administrator";
  public static final String MEMBERCHANNEL_RESOURCE = "memberchannel";
  public static final String LOGOUT_REDIRECT = "sysmanager/logoutredirect.jsp";
  public static final String EDIT_ORG = "editsuborg";
  public static final String DELETE_ORG = "deletesuborg";
  public static final String DICTDATA_RESOURCE = "orgTaxcode";
  public static final String ACCESS_PERMISSION = "readbiztype";
  public static final String NEW_BIZTYPE_GLOBAL_PERMISSION = "newbiztype";
  public static final String UPDATE_BIZTYPE_GLOBAL_PERMISSION = "biztypeupdate";
  public static final String BIZ_TYPE_RESOURCE = "biztype";
  public static final String ESPECIAL_SEPARATOR = "■";
  private Subject subject;
  private Map principalIndexs = null;

  private Map credentialIndexs = null;
  private String moduleName;
  protected Credential credential;
  protected Principal principal;
  protected String[] roles;
  private static final ThreadLocal current = new ThreadLocal();

  public String loginPage = "login.jsp";

  public String authorfailedPage = "login.jsp";
  HttpServletRequest request;
  HttpSession session;
  private static AccessControl guest;
  public static final String OUTER_USER_ACCOUNT_KEY = "OUT_USER_ACCOUNT_KEY";
  public static final String OUTER_USER_PASSWORD_KEY = "OUTER_USER_PASSWORD_KEY";
  public static final String SESSIONID_FROMCLIENT_KEY = "SESSIONID_FROMCLIENT_KEY";
  HttpServletResponse response;
  public static String kickmode;
  public static boolean enablemutilogin;
  public static boolean cluster_session_synchronize;
  private String _alt;
  static final Object token;

  private AccessControl()
  {
    this.loginPage = ConfigManager.getInstance().getLoginPage();

    if ((this.loginPage == null) || (this.loginPage.trim().equals(""))) {
      this.loginPage = "hnu_main.jsp";
    }
    this.authorfailedPage = ConfigManager.getInstance().getAuthorfailedDirect();
    this.moduleName = ConfigManager.getInstance().getModuleName();
  }

  public static void init(AccessControl instance) {
    current.set(instance);
  }

  public static AccessControl getInstance() {
    return new AccessControl();
  }

  public boolean login(HttpServletRequest request, HttpServletResponse response, String userName, String password)
    throws AccessException
  {
    return login(request, response, userName, password, true);
  }

  public String getCurrentSystemID() {
    String id = (String)this.session.getAttribute("subsystem_id");

    return ((id == null) ? "" : id);
  }

  public String getCurrentSystemName() {
    String id = getCurrentSystemID();
    if (id == null)
      return "";
    try {
      return Framework.getInstance(id).getDescription(); } catch (Exception e) {
    }
    return "";
  }

  public boolean login(HttpServletRequest request, HttpServletResponse response, String userName, String password, boolean enablelog)
    throws AccessException
  {
    return login(request, response, userName, password, enablelog, null);
  }

  public boolean login(HttpServletRequest request, HttpServletResponse response, String userName, String password, String userType)
    throws AccessException
  {
    return login(request, response, userName, password, new String[] { userType });
  }

  public boolean login(HttpServletRequest request, HttpServletResponse response, String userName, String password, String[] userTypes)
    throws AccessException
  {
    return login(request, response, userName, password, true, userTypes);
  }

  public boolean login(HttpServletRequest request, HttpServletResponse response, String userName, String password, boolean enablelog, String[] userTypes)
    throws AccessException
  {
    AppDBNameThreadLocal.add(EgpManager.getEgpDBName());

    String userloginmode = ConfigManager.getInstance().getConfigValue("userloginmode");

    if ("true".equals(userloginmode.trim())) {
      IUserManagerExt iUserManagerExt = (IUserManagerExt)BaseSPIManager.getProvider("UserManagement");
      try
      {
        String usna = iUserManagerExt.getUserNameByUserRealname(userName);

        if ((null != usna) && (!(usna.trim().equals(""))))
          userName = usna;
      }
      catch (ManagerException e) {
        e.printStackTrace();
      }

    }

    if (!(userIsInApp(userName, request.getParameter("subsystem_id"))))
    {
      throw new AccessException("用户[" + userName + "]不存在于该系统下或者该系统已不存在！");
    }

    this.session = request.getSession();
    Map temp = (Map)this.session.getAttribute("PRINCIPAL_INDEXS");

    log("userAccount.login", request);
    if (temp != null) {
      boolean sameuserenable = ConfigManager.getInstance().getConfigBooleanValue("session.sameuserenable", true);

      unprotectedCheck(null, null);
      String userAccount = getUserAccount();

      if (userAccount.equals(userName.trim())) {
        log("userAccount.equals(userName)", request);
        String subsystem_id = request.getParameter("subsystem_id");
        if (subsystem_id != null) if (!(subsystem_id.equals("")))
          {
            String old = (String)this.session.getAttribute("subsystem_id");

            if ((old != null) && (!(old.equals(subsystem_id))))
              this.session.setAttribute("subsystem_id", subsystem_id);
          }
        return true;
      }
      log("!userAccount.equals(userName)", request);
      if (!(sameuserenable)) {
        throw new AccessException("用户[" + userAccount + "]正在使用系统，等待退出后再登录！");
      }

    }

    UsernamePasswordCallbackHandler callbackHandler = new UsernamePasswordCallbackHandler(userName.trim(), password, userTypes);

    this.principalIndexs = new HashMap();
    this.credentialIndexs = new HashMap();

    this.request = request;
    this.response = response;
    try {
      innerlogon(callbackHandler, userName.trim(), enablelog, true);
      return true;
    }
    catch (LoginException ex) {
      throw new AccessException(ex.getMessage());
    }
    catch (Exception ex) {
      throw new AccessException(ex.getMessage());
    }
  }

  public String getSessionID() {
    return ((String)this.session.getAttribute("SESSIONID_CACHE_KEY"));
  }

  private void guestlogin() {
    UsernamePasswordCallbackHandler callbackHandler = new UsernamePasswordCallbackHandler("guest___", "123456", null);
    try
    {
      this.credentialIndexs = new HashMap();
      this.principalIndexs = new HashMap();
      LoginContext loginContext = new LoginContext("base", callbackHandler);

      loginContext.login();
      this.subject = loginContext.getSubject();
      Iterator credentials = this.subject.getPublicCredentials().iterator();
      while (credentials.hasNext()) {
        Credential credential = (Credential)credentials.next();
        if (credential.isCurrent()) {
          CheckCallBack.AttributeQueue attributeQueue = credential.getCheckCallBack().getAttributeQueue();

          this.credentialIndexs.put(credential.getLoginModule(), credential);

          if (credential.getLoginModule().equals(this.moduleName)) {
            this.credential = credential;
          }
        }
      }
      Iterator principals = this.subject.getPrincipals().iterator();
      while (principals.hasNext()) {
        AuthPrincipal principal = (AuthPrincipal)principals.next();
        this.principalIndexs.put(principal.getLoginModuleName(), principal);
        if (principal.getLoginModuleName().equals(this.moduleName))
          this.principal = principal;
      }
    }
    catch (LoginException e)
    {
      e.printStackTrace();
    }
  }

  public String getMachineName()
  {
    String machineName = null;
    if (this.session != null) {
      machineName = (String)this.session.getAttribute("MACHINENAME_CACHE_KEY");
    }

    if (machineName == null) {
      return "";
    }
    return machineName;
  }

  private void innerlogon(UsernamePasswordCallbackHandler callbackHandler, String userName, boolean enablelog, boolean recordonlineuser)
    throws LoginException
  {
    LoginContext loginContext = new LoginContext("base", callbackHandler);
    loginContext.login();

    this.subject = loginContext.getSubject();

    String machineIP = this.request.getParameter("machineIp_");
    if ((machineIP == null) || (machineIP.trim().equals("")))
      machineIP = this.request.getRemoteAddr();
    
   
    String macaddr = this.request.getParameter("macaddr_");
    String machineName = this.request.getParameter("machineName_");

   

    StringBuffer ssoCookie = new StringBuffer();
    StringBuffer credentialCookie = new StringBuffer();
    boolean flag = false;
    boolean enablecookie = enablecookie();
    Iterator credentials = this.subject.getPublicCredentials().iterator();
    while (credentials.hasNext()) {
      Credential credential = (Credential)credentials.next();
      if (credential.isCurrent()) {
        CheckCallBack.AttributeQueue attributeQueue = credential.getCheckCallBack().getAttributeQueue();

        if ((enablecookie) && 
          (attributeQueue.size() > 0)) {
          if (!(flag))
            flag = true;
          else {
            credentialCookie.append("@|@");
          }
          credentialCookie.append(credential.getLoginModule()).append("@^@");

          boolean _flag = false;
          for (int i = 0; i < attributeQueue.size(); ++i) {
            if (!(_flag))
              _flag = true;
            else {
              credentialCookie.append("@~@");
            }
            CheckCallBack.Attribute attr = attributeQueue.get(i);

            credentialCookie.append(attr.getName()).append("=").append(attr.getValue());
          }

        }

        this.credentialIndexs.put(credential.getLoginModule(), credential);

        if (credential.getLoginModule().equals(this.moduleName)) {
          this.credential = credential;
        }
      }
    }

    flag = false;

    Iterator principals = this.subject.getPrincipals().iterator();
    while (principals.hasNext()) {
      AuthPrincipal principal = (AuthPrincipal)principals.next();
      this.principalIndexs.put(principal.getLoginModuleName(), principal);

      if (principal.getLoginModuleName().equals(this.moduleName)) {
        this.principal = principal;
      }
      if (enablecookie) {
        if (!(flag)) {
          ssoCookie.append(principal.getLoginModuleName()).append("#$#").append(principal.getName());

          flag = true;
        } else {
          ssoCookie.append("^_^").append(principal.getLoginModuleName()).append("#$#").append(principal.getName());
        }
      }

    }

    if ((enablecookie) && 
      (ssoCookie.length() > 0)) {
      ssoCookie.insert(0, "encrypt=false^@^");
      ssoCookie.append("^|^").append(credentialCookie);
    }

    
    String subsystem_id = this.request.getParameter("subsystem_id");
    if ((subsystem_id == null) || (subsystem_id.equals(""))) {
      subsystem_id = "module";
    }
   

    if (enablecookie)
    {
      try
      {
        log.debug("生成sso Cookie[PRINCIPALS_COOKIE," + ssoCookie.toString() + "]");

        Cookie newCookie = new Cookie("PRINCIPALS_COOKIE", URLEncoder.encode(ssoCookie.toString()));

        newCookie.setMaxAge(86400);

        this.response.addCookie(newCookie);
      } catch (Exception e) {
        e.printStackTrace();
      }

    }

    FrameworkServlet.setSubSystemToCookie(this.response, userName, subsystem_id);

    String operSource = getMachinedID();
    log_info("User[" + getUserAccount() + "," + getUserName() + "] login from [" + operSource + "].session id is " + this.session.getId(), this.request);

    String serverIp = this.request.getServerName();
    String serverport = this.request.getServerPort() + "";
    //add by 王博 20130626 在线用户
    UserSessionBean userSessionBean = new UserSessionBean();
    userSessionBean.setUser_id(getUserID());
    userSessionBean.setUser_name(getUserAccount());
    userSessionBean.setLogin_ip(machineIP);
    userSessionBean.setSession_id(this.session.getId());
    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String login_time = df.format(new Timestamp(System.currentTimeMillis()));
    userSessionBean.setLogin_time(login_time);
    userSessionBean.setUser_realname(getUserName());
    this.session.setAttribute("ONLINE_USER", userSessionBean);
    //add end
    this.session.setAttribute("USER_ID", getUserID());
    this.session.setAttribute("REMOTEADDR_CACHE_KEY", machineIP);
    this.session.setAttribute("MACADDR_CACHE_KEY", macaddr);
    this.session.setAttribute("MACHINENAME_CACHE_KEY", machineName);
    this.session.setAttribute("SESSIONID_CACHE_KEY", this.session.getId());
    this.session.setAttribute("PRINCIPAL_INDEXS", this.principalIndexs);
    this.session.setAttribute("CREDENTIAL_INDEXS", this.credentialIndexs);
    this.session.setAttribute("subsystem_id", subsystem_id);
    this.session.setAttribute("SERVER_IP_KEY", serverIp);
    this.session.setAttribute("SERVER_PORT_KEY", serverport);
    
    
    current.set(this);

    if ((!(enablelog)) || (!(recordonlineuser))) return;
    try {
      LogManager logMgr = SecurityDatabase.getLogManager();
      String userrelName = getUserName();
      String operContent = userName + "(" + userrelName + ")" + " 登陆[" + getCurrentSystemName() + "]";

      String openModle = "认证管理";

      AppIdThreadLocal.add(subsystem_id);

      logMgr.log(userName, operContent, openModle, operSource);
    }
    catch (SPIException e1) {
      e1.printStackTrace();
    }
    catch (Exception e) {
      e.printStackTrace();
    }
  }

  public boolean logindw(HttpServletRequest request, HttpServletResponse response, String userName, String password, String userType)
    throws AccessException
  {
    if ((userType != null) && (!(userType.equals("")))) {
      return logindw(request, response, userName, password, new String[] { userType });
    }

    return logindw(request, response, userName, password, (String[])null);
  }

  public String getRemoteAddr()
  {
    String ip = null;
    if (this.session != null) {
      ip = (String)this.session.getAttribute("REMOTEADDR_CACHE_KEY");
    }
    if (ip == null)
      return "";
    return ip;
  }

  public String getMachinedID()
  {
    StringBuffer machineID = new StringBuffer();
    machineID.append(getRemoteAddr());
    String temp = getMacAddr();
    if ((null != temp) && (!(temp.trim().equals("")))) {
      machineID.append("||");
      machineID.append(temp);
    }
    temp = getMachineName();
    if ((null != temp) && (!(temp.trim().equals("")))) {
      machineID.append("||");
      machineID.append(temp);
    }

    return machineID.toString();
  }

  public boolean logindw(HttpServletRequest request, HttpServletResponse response, String userName, String password)
    throws AccessException
  {
    return logindw(request, response, userName, password, (String[])null);
  }

  public boolean logindw(HttpServletRequest request, HttpServletResponse response, String userName, String password, String[] userTypes)
    throws AccessException
  {
    UsernamePasswordCallbackHandler callbackHandler = new UsernamePasswordCallbackHandler(userName, password, userTypes);

    this.principalIndexs = new HashMap();
    this.credentialIndexs = new HashMap();
    this.request = request;
    this.response = response;
    this.session = request.getSession();
    try
    {
      innerlogon(callbackHandler, userName, true, false);
      this.session.setAttribute("SESSIONID_FROMCLIENT_KEY", new Boolean(true));

      return true;
    }
    catch (LoginException ex)
    {
      throw new AccessException(ex.getMessage());
    }
    catch (Exception ex)
    {
      throw new AccessException(ex.getMessage());
    }
  }

  public void refreshPassword(String newPassword)
  {
    if (getUserAttribute("password") != null) {
      this.credential.getCheckCallBack().setUserAttribute("password", EncrpyPwd.encodePassword(newPassword));

      this.credential.getCheckCallBack().setUserAttribute("password_i", newPassword);
    }
  }

  public static void updateMailPassword(String userEmail, String newPassword)
  {
    String mailValidata = ConfigManager.getInstance().getConfigValue("mailValidata");

    if ((mailValidata != null) && (mailValidata.equals("1")))
    {
      String url = "http://" + ConfigManager.getInstance().getConfigValue("mailServer") + "/creator_changepw.asp?username=" + userEmail + "&pw1=" + newPassword;

      ApachePostMethodClient client = new ApachePostMethodClient(url);
      String clientResponse;
      try
      {
        clientResponse = client.sendRequest();
      } catch (Exception ex) {
        ex.printStackTrace();
      }
      finally {
        client = null;
      }
    }
  }

  public boolean checkAccess(HttpServletRequest request, HttpServletResponse response)
  {
    return checkAccess(request, response, null, true);
  }

  public boolean checkManagerAccess(HttpServletRequest request, HttpServletResponse response)
  {
    boolean success = checkAccess(request, response);
    if (!(success))
      return false;
    if ((isAdmin()) || (isOrgManager(getUserAccount()))) {
      return true;
    }
    redirectManager(request, response, "/purviewmanager/nopermission.jsp");

    return false;
  }

  public boolean checkAdminAccess(HttpServletRequest request, HttpServletResponse response)
  {
    boolean success = checkAccess(request, response);
    if (!(success))
      return false;
    if (isAdmin()) {
      return true;
    }
    redirectManager(request, response, "/purviewmanager/onlyAdminPermission.jsp");

    return false;
  }

  public boolean checkAccess(String[] needUserTypes, HttpServletRequest request, HttpServletResponse response)
  {
    return checkAccess(needUserTypes, request, response, null, true, null);
  }

  public boolean checkAccess(HttpServletRequest request, HttpServletResponse response, String redirectPath)
  {
    return checkAccess(request, response, null, true, redirectPath);
  }

  public boolean checkAccess(HttpServletRequest request, HttpServletResponse response, boolean protect)
  {
    return checkAccess(request, response, null, protect);
  }

  public boolean checkAccess(HttpServletRequest request, HttpServletResponse response, JspWriter out, boolean protect)
  {
    return checkAccess(request, response, out, protect, null);
  }

  private boolean checkUserType(String[] userTypes)
  {
    if ((userTypes == null) || (userTypes.length == 0)) {
      return true;
    }
    Credential dd = (Credential)this.credentialIndexs.get(this.moduleName);
    String _userType = (String)dd.getCheckCallBack().getUserAttribute("LOGINCONTEXT.USERTYPE");

    if ((_userType != null) && (!(_userType.equals("")))) {
      StringBuffer b = new StringBuffer();
      for (int i = 0; i < userTypes.length; ++i) {
        String userType = userTypes[i];
        if ((userType != null) && (_userType.equals(userType))) {
          b.setLength(0);
          return true;
        }
        b.append(userType).append(",");
      }
      log.debug("用户类型不一致，访问当前模块需要的类型为[needType=" + b.toString() + "],但是用户的类型为[userType=" + _userType + "]");

      return false;
    }

    return true;
  }

  /** @deprecated */
  public boolean checkAccess(String userType, HttpServletRequest request, HttpServletResponse response, JspWriter out)
  {
    return checkAccess(new String[] { userType }, request, response, out, null);
  }

  public boolean checkAccess(String userType, HttpServletRequest request, HttpServletResponse response)
  {
    return checkAccess(userType, request, response, (JspWriter)null);
  }

  public boolean checkAccess(HttpServletRequest request, HttpServletResponse response, JspWriter out, boolean protect, boolean abc)
  {
    return checkAccess(request, response, out, protect);
  }

  public boolean checkAccess(HttpServletRequest request, HttpServletResponse response, JspWriter out, boolean protect, String redirectPath)
  {
    return checkAccess(null, request, response, out, protect, redirectPath);
  }

  public boolean checkAccess(String userType, HttpServletRequest request, HttpServletResponse response, String redirectPath)
  {
    return checkAccess(new String[] { userType }, request, response, null, redirectPath);
  }

  public boolean checkAccess(String[] userType, HttpServletRequest request, HttpServletResponse response, JspWriter out, String redirectPath)
  {
    return checkAccess(userType, request, response, out, true, redirectPath);
  }

  private boolean unprotectedCheck(String redirectPath, String[] userTypes) {
    try {
      this.principalIndexs = ((Map)this.session.getAttribute("PRINCIPAL_INDEXS"));

      this.credentialIndexs = ((Map)this.session.getAttribute("CREDENTIAL_INDEXS"));

      if (this.principalIndexs != null) {
        this.principal = ((Principal)this.principalIndexs.get(this.moduleName));
      }
      if (this.credentialIndexs != null) {
        this.credential = ((Credential)this.credentialIndexs.get(this.moduleName));
      }

      String sessionid = (String)this.session.getAttribute("SESSIONID_CACHE_KEY");

      Boolean fromclient = (Boolean)this.session.getAttribute("SESSIONID_FROMCLIENT_KEY");

      current.set(this);
    }
    catch (Exception e)
    {
      return false;
    }

    return true;
  }

  private boolean innerRedirect(String redirectPath)
  {
    if ((redirectPath == null) || (redirectPath.equals("")))
      redirect();
    else {
      redirect(this.request, this.response, redirectPath);
    }

    return false;
  }

  private boolean innerLogout(String redirectPath, String kickmode)
  {
    if ((redirectPath == null) || (redirectPath.equals("")))
    {
      logoutwithalt_(null, null, true, true, kickmode);
    }
    else {
      logoutwithalt_(redirectPath, null, true, true, kickmode);
    }

    return false;
  }

  private static void log(String msg, HttpServletRequest request) {
    Date date = new Date();
    if (request != null) {
      String remoteip = request.getRemoteAddr();

      System.err.println("date[" + date + "] [remoteip=" + remoteip + "] " + msg);
    }
    else
    {
      Exception e = new Exception("date[" + date + "] [remoteip=null] " + msg);

      e.printStackTrace();
    }
  }

  private static void log_info(String msg, HttpServletRequest request)
  {
    Date date = new Date();
    if (request != null) {
      String remoteip = request.getRemoteAddr();

      System.err.println("date[" + date + "] [remoteip=" + remoteip + "] " + msg);
    }
    else
    {
      System.err.println("date[" + date + "] [remoteip=null] " + msg);
    }
  }

  private int unlogincheck()
  {
    String OUT_useraccount = this.request.getParameter("OUT_USER_ACCOUNT_KEY");
    String OUT_userpassord = this.request.getParameter("OUTER_USER_PASSWORD_KEY");

    int ret = 0;

    if ((OUT_useraccount == null) || (OUT_useraccount.equals("")))
    {
      boolean enablecookie = enablecookie();

      if (enablecookie) {
        Cookie[] cookies = this.request.getCookies();
        int idx = 0;
        boolean flag = false;
        for (int i = 0; (cookies != null) && (i < cookies.length); ++i)
        {
          if (!(cookies[i].getName().equals("PRINCIPALS_COOKIE")))
            continue;
          flag = true;
          idx = i;
          break;
        }

        if (!(flag))
        {
          ret = 1;
          return ret;
        }

        String ssoCookie = URLDecoder.decode(cookies[idx].getValue());

        CookieUtil cookieUtil = new CookieUtil();
        Object[] messages = cookieUtil.refactorPricipal(ssoCookie);

        if (messages != null) {
          this.principalIndexs = ((Map)messages[0]);
          this.credentialIndexs = ((Map)messages[1]);
          this.subject = ((Subject)messages[2]);
          this.principal = ((Principal)this.principalIndexs.get(this.moduleName));

          this.credential = ((Credential)this.credentialIndexs.get(this.moduleName));

          this.session.setAttribute("PRINCIPAL_INDEXS", this.principalIndexs);

          this.session.setAttribute("CREDENTIAL_INDEXS", this.credentialIndexs);
          ret = 3;
          return ret;
        }

        ret = 1;
        return ret;
      }

      ret = 1;
      return ret;
    }

    try
    {
      boolean su = logindw(this.request, this.response, OUT_useraccount, OUT_userpassord);

      if (!(su))
      {
        ret = 4;
        return ret;
      }

      ret = 2;
      return ret;
    }
    catch (AccessException e)
    {
      ret = 1; }
    return ret;
  }

  public String getParameters(HttpServletRequest request)
  {
    Enumeration enums = request.getParameterNames();
    StringBuffer sb = new StringBuffer(100);
    boolean flag = false;
    while (enums.hasMoreElements()) {
      String key = (String)enums.nextElement();
      String value = request.getParameter(key);
      if (!(flag)) {
        sb.append("?").append(key).append("=").append(value);
        flag = true;
      } else {
        sb.append("&").append(key).append("=").append(value);
      }
    }

    return sb.toString();
  }

  public boolean checkAccess(String[] userTypes, HttpServletRequest request, HttpServletResponse response, JspWriter out, boolean protect, String redirectPath)
  {
    this.request = request;
    this.response = response;

    this.session = this.request.getSession(false);

    String sessionid = null;
    if (this.session != null) {
      sessionid = this.session.getId();
    }

    if (this.session == null)
    {
      log("Session is null, Check page[" + request.getRequestURI() + getParameters(request) + "] will go to login.jsp.", request);

      if (protect) {
        return innerRedirect(redirectPath);
      }
      return false;
    }

    if (!(protect)) {
      return unprotectedCheck(redirectPath, userTypes);
    }

    this.principalIndexs = ((Map)this.session.getAttribute("PRINCIPAL_INDEXS"));

    this.credentialIndexs = ((Map)this.session.getAttribute("CREDENTIAL_INDEXS"));
    if (this.principalIndexs == null)
    {
      int ret = unlogincheck();
      if (ret == 1)
      {
        boolean isNew = false;
        try {
          isNew = this.session.isNew();
          log(" Check page[" + request.getRequestURI() + getParameters(request) + "]:  No user logon  will go to login.jsp.session id is " + sessionid + " and new is " + isNew, request);
        }
        catch (Exception e)
        {
          log(" Check page[" + request.getRequestURI() + getParameters(request) + "]:  No user logon  will go to login.jsp.session id is " + sessionid + " and get session status failed: " + e.getMessage(), request);
        }

        return innerRedirect(redirectPath); }
      if (ret == 4) {
        log("Check page[" + request.getRequestURI() + getParameters(request) + "]: CS client user logon failed, will go to login.jsp.session id is " + sessionid, request);

        String redirecttarget = "_self";
        redirect(request, response, redirectPath, redirecttarget, false);
        return false;
      }
      if (ret == 2)
      {
        return true; }
      if (ret == 3)
      {
        log(" Check page[" + request.getRequestURI() + getParameters(request) + "]: \r\n\tUser not logon ,but Get user info from cookie successed continue login.session id is " + sessionid, request);
      }
      else
      {
        log(" Check page[" + request.getRequestURI() + getParameters(request) + "]: \r\n\tUser not logon ,Will go to login.jsp.session id is " + this.session.getId() + " and new is " + this.session.isNew(), request);

        return innerRedirect(redirectPath);
      }

    }

    this.principal = ((Principal)this.principalIndexs.get(this.moduleName));
    if (this.credentialIndexs != null) {
      this.credential = ((Credential)this.credentialIndexs.get(this.moduleName));
    }
    else {
      log("Check page[" + request.getRequestURI() + "]: \r\n\tUser[" + this.principal + "]'s credentialIndexs not exist,Will go to login.jsp.session id is " + sessionid, request);

      return innerRedirect(redirectPath);
    }

    current.set(this);

    return true;
  }

  /** @deprecated */
  public boolean checkAccess(String userType, HttpServletRequest request, HttpServletResponse response, JspWriter out, String redirectPath)
  {
    return checkAccess(new String[] { userType }, request, response, out, redirectPath);
  }

  public boolean checkAccess(PageContext pageContext, boolean protect)
  {
    return checkAccess((HttpServletRequest)pageContext.getRequest(), (HttpServletResponse)pageContext.getResponse(), null, protect);
  }

  public static void redirect(HttpServletRequest request, HttpServletResponse response, String redirectPath)
  {
    if ((redirectPath == null) || (redirectPath.trim().equals(""))) {
      redirectPath = ConfigManager.getInstance().getLoginPage();
    }
    if ((redirectPath == null) || (redirectPath.trim().equals(""))) {
      redirectPath = "/login.jsp";
    }
    try
    {
      if (!(response.isCommitted())) {
        String t_redirectPath = StringUtil.getRealPath(request, redirectPath);

        response.sendRedirect(t_redirectPath);
      }
    }
    catch (IOException e) {
      e.printStackTrace();
    }
  }

  public static void redirect(HttpServletRequest request, HttpServletResponse response, String redirectPath, String redirecttarget)
  {
    redirect(request, response, redirectPath, redirecttarget, false);
  }

  public static void redirect(HttpServletRequest request, HttpServletResponse response, String redirectPath, String redirecttarget, boolean _alertMsg)
  {
    if ((redirectPath == null) || (redirectPath.trim().equals(""))) {
      redirectPath = ConfigManager.getInstance().getLoginPage();
    }
    if ((redirectPath == null) || (redirectPath.trim().equals(""))) {
      redirectPath = "/login.jsp";
    }
    if ((redirecttarget == null) || (redirecttarget.trim().equals(""))) {
      redirecttarget = "top";
    }
    try
    {
      if (!(response.isCommitted())) {
        StringBuffer url = new StringBuffer(request.getContextPath());
        url.append("/").append("sysmanager/logoutredirect.jsp").append("?_redirectPath=").append(StringUtil.encode(redirectPath)).append("&_redirecttarget=").append(redirecttarget);

        if (_alertMsg) {
          url.append("&_alertMsg=true");
        }
        response.sendRedirect(url.toString());
      }
    }
    catch (IOException e) {
      e.printStackTrace();
    }
  }

  private void redirect(boolean _alertMsg)
  {
    try
    {
      if ((this.response != null) && (!(this.response.isCommitted()))) {
        StringBuffer url = new StringBuffer(this.request.getContextPath());
        url.append("/").append("sysmanager/logoutredirect.jsp").append("?_redirectPath=").append(StringUtil.encode(this.request.getContextPath() + "/" + this.loginPage));

        if (_alertMsg) {
          url.append("&_alertMsg=true");
        }
        this.response.sendRedirect(url.toString());
      }
    }
    catch (IOException e) {
      e.printStackTrace();
    }
  }

  private void redirect()
  {
    redirect(false);
  }

  private void redirectManager(HttpServletRequest request, HttpServletResponse response, String redirectPath)
  {
    try
    {
      if ((response != null) && (!(response.isCommitted()))) {
        StringBuffer url = new StringBuffer(request.getContextPath());
        url.append(redirectPath);
        response.sendRedirect(url.toString());
      }
    }
    catch (IOException e) {
      e.printStackTrace();
    } catch (Exception e) {
      e.printStackTrace();
    }
  }

  public boolean checkAccess(HttpSession session)
  {
    this.session = session;

    this.principalIndexs = ((Map)session.getAttribute("PRINCIPAL_INDEXS"));

    this.credentialIndexs = ((Map)session.getAttribute("CREDENTIAL_INDEXS"));

    if (this.principalIndexs != null) {
      this.principal = ((Principal)this.principalIndexs.get(this.moduleName));
    }

    if (this.credentialIndexs != null) {
      this.credential = ((Credential)this.credentialIndexs.get(this.moduleName));
    }
    return true;
  }

  public boolean checkAccess(PageContext pageContext)
  {
    return checkAccess(pageContext, true);
  }

  public boolean checkPermission(PageContext pageContext, String resourceID, String action)
  {
    if (!(ConfigManager.getInstance().securityEnabled())) {
      return true;
    }

    this.request = ((HttpServletRequest)pageContext.getRequest());
    this.response = ((HttpServletResponse)pageContext.getResponse());

    this.session = this.request.getSession(false);
    if (this.session == null) {
      log("Check Permission failed: session is null.", this.request);
      return false;
    }
    this.principalIndexs = ((Map)this.session.getAttribute("PRINCIPAL_INDEXS"));
    this.credentialIndexs = ((Map)this.session.getAttribute("CREDENTIAL_INDEXS"));

    this.principal = ((Principal)this.principalIndexs.get(ConfigManager.getInstance().getModuleName()));

    String resourceType = ConfigManager.getInstance().getResourceInfo().getId();

    return checkPermission(resourceID, action, resourceType);
  }

  public static boolean checkPermission(Principal principal, String resourceID, String action)
  {
    return checkPermission(principal, resourceID, action, null);
  }

  public static boolean checkPermission(Principal principal, String resourceID, String action, String resourceType)
  {
    if (resourceType == null) {
      resourceType = ConfigManager.getInstance().getResourceInfo().getId();
    }
    String userID = ((AuthPrincipal)principal).getUserID();
    if (userID == null)
      userID = getUserIDByUserAccount(principal.getName());
    if ("role".equalsIgnoreCase(resourceType))
    {
      if (isAdmin(principal.getName())) {
        return true;
      }
      Role role = RoleCacheManager.getInstance().getRoleByID(resourceID);
      if ((role != null) && 
        (userID.equals(role.getOwner_id() + ""))) {
        return true;
      }

    }
    else if ("job".equalsIgnoreCase(resourceType)) {
      if (isAdmin(principal.getName()))
        return true;
      try {
        boolean state = JobManagerImpl.isJobCreatorByUserId(userID, resourceID);

        if (state)
          return true;
      }
      catch (ManagerException e) {
        e.printStackTrace();
      }

    }
    else if ("group".equalsIgnoreCase(resourceType))
    {
      if (isAdmin(principal.getName()))
        return true;
      Group group = GroupCacheManager.getInstance().getGroupByID(resourceID);

      if ((group != null) && 
        (userID.equals(group.getOwner_id() + ""))) {
        return true;
      }

    }

    boolean ret = AppSecurityCollaborator.getInstance().checkAccess(principal, resourceID, action, resourceType);

    return ret;
  }

  public static String getUserIDByUserAccount(String userAccount) {
    try {
      UserManager um = SecurityDatabase.getUserManager();
      User user = um.getUserByName(userAccount);
      if (user == null)
        return "";
      return user.getUserId() + "";
    }
    catch (SPIException e) {
      e.printStackTrace();
    }
    catch (ManagerException e) {
      e.printStackTrace();
    }
    return "";
  }

  public static String getUserAccountByUserID(String usrID)
  {
    try {
      UserManager um = SecurityDatabase.getUserManager();
      User user = um.getUserById(usrID);
      if (user == null)
        return "";
      return user.getUserName() + "";
    }
    catch (SPIException e) {
      e.printStackTrace();
    }
    catch (ManagerException e) {
      e.printStackTrace();
    }
    return "";
  }

  public static boolean checkPermission(String useraccount, String resourceID, String action, String resourceType)
  {
    Principal principal = new AuthPrincipal(useraccount, null, null);
    return checkPermission(principal, resourceID, action, resourceType);
  }

  public static boolean checkPermissionByUserID(String userID, String resourceID, String action, String resourceType)
  {
    String useraccount = getUserAccountByUserID(userID);

    Principal principal = new AuthPrincipal(useraccount, null, null, userID);
    return checkPermission(principal, resourceID, action, resourceType);
  }

  public boolean checkPermission(String resourceID, String action, String resourceType)
  {
    return checkPermission(resourceID, action, resourceType, false, null);
  }

  public boolean checkPermission(String resourceID, String action, String resourceType, boolean redirect)
  {
    return checkPermission(resourceID, action, resourceType, redirect, null);
  }

  public boolean checkPermission(String resourceID, String action, String resourceType, boolean redirect, String redirectPath)
  {
    if (resourceType.equals("orgunit")) {
      if (isAdmin()) {
        return true;
      }
      if (isOrganizationManager(resourceID))
        return true;
      if ((action.equals("read")) && 
        (isSubOrgManager(resourceID))) {
        return true;
      }

    }

    if ("role".equalsIgnoreCase(resourceType))
    {
      if (isAdmin())
        return true;
      Role role = RoleCacheManager.getInstance().getRoleByID(resourceID);
      if ((role != null) && 
        (getUserID().equals(role.getOwner_id() + ""))) {
        return true;
      }

    }
    else if ("job".equalsIgnoreCase(resourceType)) {
      if (isAdmin())
        return true;
      try {
        boolean state = JobManagerImpl.isJobCreatorByUserId(getUserID(), resourceID);

        if (state)
          return true;
      }
      catch (ManagerException e) {
        e.printStackTrace();
      }

    }
    else if ("group".equalsIgnoreCase(resourceType))
    {
      if (isAdmin())
        return true;
      Group group = GroupCacheManager.getInstance().getGroupByID(resourceID);

      if ((group != null) && 
        (getUserID().equals(group.getOwner_id() + ""))) {
        return true;
      }

    }

    boolean ret = AppSecurityCollaborator.getInstance().checkAccess(this.principal, resourceID, action, resourceType);

    if ((!(ret)) && (redirect)) {
      log("permission check failed,will go to " + redirectPath + "/" + this.authorfailedPage, this.request);

      if ((redirectPath == null) || (redirectPath.trim().equals("")))
        redirectPath = "/" + this.authorfailedPage;
      redirect(this.request, this.response, redirectPath);
    }

    return ret;
  }

  public void logout(boolean redirected)
  {
    logout(redirected, true);
  }

  private static void releaseSession(HttpSession session)
  {
  }

  public boolean enablecookie()
  {
    return ((ConfigManager.getInstance().isSecuritycookieenabled()) && (((ConfigManager.getInstance().securityEnabled()) || (ConfigManager.getInstance().isSSO()))));
  }

  public void logoutdw()
  {
    try
    {
      Map principals = (Map)this.session.getAttribute("PRINCIPAL_INDEXS");

      if (principals == null)
      {
        return;
      }

      log("Check page[" + this.request.getRequestURI() + "]: User[" + getUserAccount() + "] logout from cs client。session id is " + this.session.getId(), this.request);

      Subject subject = ((AuthPrincipal)this.principal).getSubject();
      LoginContext loginContext = new LoginContext(subject);
      loginContext.logout();
      String userAccount = getUserAccount();

      current.set(null);

      String machineID = getMachinedID();

      releaseSession(this.session);

      String userName = getUserName();

      String userId = getUserID();

      this.session.invalidate();
      try
      {
        LogManager logMgr = SecurityDatabase.getLogManager();
        String operContent = userName + "[" + userId + "]" + " 从客户端退出系统";

        String operSource = machineID;

        String openModle = "认证管理";

        logMgr.log(userAccount, operContent, openModle, operSource);
      } catch (SPIException e1) {
        e1.printStackTrace();
      } catch (ManagerException e) {
        e.printStackTrace();
      }

    }
    catch (LoginException ex)
    {
      log.debug("Logout from dreamweaver client failed：" + ex.getMessage());
    }
    catch (Exception ex) {
      log.debug("Logout from dreamweaver client failed：" + ex.getMessage());
    }
    finally {
      current.set(null);
    }
  }

  public void logout(boolean redirected, boolean enablelog)
  {
    logout(null, null, redirected, enablelog);
  }

  public static void logoutdirect(HttpSession session)
  {
    try
    {
      Map principalsIndexs = (Map)session.getAttribute("PRINCIPAL_INDEXS");

      if (principalsIndexs == null)
      {
        log("Unknowken user logoutdirect from session destroyed event.", null);
        return;
      }

      String address = (String)session.getAttribute("REMOTEADDR_CACHE_KEY");

      log_info("User[" + principalsIndexs + "] logoutdirect from session destroyed event at [" + address + "].session id is " + session.getId(), null);

      AuthPrincipal principal_ = (AuthPrincipal)principalsIndexs.get(ConfigManager.getInstance().getModuleName());
      try
      {
        Subject subject = principal_.getSubject();
        String userName = null;
        Iterator principals = subject.getPrincipals().iterator();
        while (principals.hasNext()) {
          AuthPrincipal principal = (AuthPrincipal)principals.next();

          if (principal.getLoginModuleName().equals(ConfigManager.getInstance().getModuleName()))
          {
            userName = principal.getName();

            break;
          }

        }

        if (userName == null)
        {
          return;
        }
      }
      catch (Exception ex)
      {
        log.debug("退出登录失败：" + ex.getMessage());
      }
    }
    finally
    {
    }
  }

  public void logout()
  {
    logout(true, true);
  }

  public void logout(String redirect)
  {
    logout(redirect, true);
  }

  public static Subject getLocalSubject()
  {
    return getAccessControl().subject;
  }

  public static AccessControl getAccessControl() {
    AccessControl context = (AccessControl)current.get();
    if (context == null) {
      context = guest;
    }
    return context;
  }

  public Subject getSubject() {
    return ((AuthPrincipal)this.principal).getSubject();
  }

  public void logout(String redirect, boolean enablelog)
  {
    logout(redirect, null, true, enablelog);
  }

  public void logout(String redirect, String redirecttarget, boolean redirected, boolean enablelog)
  {
    logoutwithalt_(redirect, redirecttarget, redirected, enablelog, null);
  }

  public void logoutwithalt_(String redirect, String redirecttarget, boolean redirected, boolean enablelog, String _alt)
  {
    try
    {
      Map principalsIndexs = (Map)this.session.getAttribute("PRINCIPAL_INDEXS");

      if (principalsIndexs == null) {
        if (redirected) {
          log_info("Unknown user Logout from system on " + new Date() + ". session id is " + this.session.getId(), this.request);

          if ((redirect == null) && (redirecttarget == null))
            redirect();
          else {
            redirect(this.request, this.response, redirect, redirecttarget);
          }
        }
        return;
      }

      log_info("Logout from page[" + this.request.getRequestURI() + "]: User[" + getUserAccount() + "," + getUserName() + "] logout.session id is " + this.session.getId(), this.request);

      LoginContext loginContext = new LoginContext(getSubject());
      loginContext.logout();
      String userAccount = getUserAccount();
      String subsystem = getCurrentSystemName();

      String userId = getUserID();

      String userName = getUserName();
      String machineIP = (String)this.session.getAttribute("REMOTEADDR_CACHE_KEY");

      String orgID = getChargeOrgId();

      String machineID = getMachinedID();

      current.set(null);
      releaseSession(this.session);
      this.session.invalidate();

      if (enablelog) {
        try {
          LogManager logMgr = SecurityDatabase.getLogManager();

          String operContent = userName + "[" + userId + "] 退出[" + subsystem + "]";

          if (_alt != null) {
            operContent = operContent + ",退出原因为：该用户在其他地方登录或者用户会话信息被管理员清除。";
          }
          String operSource = machineID;
          String operModle = "认证管理";
          logMgr.log(userAccount, orgID, operModle, operSource, operContent, "", 1);
        }
        catch (SPIException e1)
        {
        }
        catch (ManagerException e)
        {
        }

      }

      if (redirected) {
        if ((redirect == null) && (redirecttarget == null)) {
          log_info("User[" + getUserAccount() + "," + getUserName() + "] logout." + new Date() + ". " + _alt, this.request);

          if (_alt == null)
            redirect();
          else
            redirect(true);
        }
        else {
          log_info("User[" + getUserAccount() + "," + getUserName() + "] logout." + new Date() + ". " + _alt + ".redirect=" + redirect + ",redirecttarget=" + redirecttarget, this.request);

          if (_alt == null)
            redirect(this.request, this.response, redirect, redirecttarget);
          else {
            redirect(this.request, this.response, redirect, redirecttarget, true);
          }
        }
      }
    }
    catch (LoginException ex)
    {
      log("Unknown user Logout failed from system on " + new Date() + ". ", this.request);

      log.debug("Logout failed：" + ex.getMessage());
    }
    catch (Exception ex)
    {
      log.debug("Logout failed：" + ex.getMessage());
    } finally {
      current.set(null);
    }
  }

  public String getUserID()
  {
    if (this.credential == null)
      return "";
    Object userID = this.credential.getCheckCallBack().getUserAttribute("userID");

    return ((userID == null) ? "" : userID.toString());
  }
  /**
  *<b>Summary: </b>
  * getUserPhone(获取登录用户手机号码)
  * @return
   */
  public String getUserPhone(){
	  if (this.credential == null){
		  return "";
	  }else{
		  CheckCallBack checkCallBack = this.credential.getCheckCallBack();
		  Object userMobiletel1 = checkCallBack.getUserAttribute("userMobiletel1");
		  return ((userMobiletel1 == null) ? "" : userMobiletel1.toString());
	  }
  }

  public String getUserAccount()
  {
    if (this.principal != null) {
      String userAccount = this.principal.getName();
      return ((userAccount == null) ? "" : userAccount);
    }
    return "";
  }

  public String getUserName()
  {
    if (this.credential == null)
      return "";
    Object userName = this.credential.getCheckCallBack().getUserAttribute("userName");

    return ((userName == null) ? "" : userName.toString());
  }

  public String getChargeOrgName()
  {
    if (this.credential == null)
      return "";
    Organization chargeOrg = (Organization)this.credential.getCheckCallBack().getUserAttribute("CHARGEORGID");

    return ((chargeOrg == null) ? "" : chargeOrg.getOrgName());
  }

  public String getChargeOrgId()
  {
    if (this.credential == null)
      return "";
    Organization chargeOrg = (Organization)this.credential.getCheckCallBack().getUserAttribute("CHARGEORGID");

    return ((chargeOrg == null) ? "" : chargeOrg.getOrgId());
  }

  public String getChargeOrgCode()
  {
    if (this.credential == null)
      return "";
    Organization chargeOrg = (Organization)this.credential.getCheckCallBack().getUserAttribute("CHARGEORGID");

    return ((chargeOrg == null) ? "" : chargeOrg.getOrgnumber());
  }

  public String getChargeOrgLevel()
  {
    if (this.credential == null)
      return "";
    Organization chargeOrg = (Organization)this.credential.getCheckCallBack().getUserAttribute("CHARGEORGID");

    return ((chargeOrg == null) ? "" : chargeOrg.getOrg_level());
  }

  public Organization getChargeOrg()
  {
    if (this.credential == null)
      return null;
    Organization chargeOrg = (Organization)this.credential.getCheckCallBack().getUserAttribute("CHARGEORGID");

    return chargeOrg;
  }

  public List getAllOrgListExcludeCharge()
  {
    if (this.credential == null)
      return new ArrayList();
    List secondOrgs = (List)this.credential.getCheckCallBack().getUserAttribute("secondOrgs");

    return secondOrgs;
  }

  public Principal getPrincipal()
  {
    return this.principal;
  }

  public Credential getCredential() {
    return this.credential;
  }

  /** @deprecated */
  public String getCurrentSystem()
  {
    return FrameworkServlet.getSubSystem(this.request, this.response, getUserAccount());
  }

  public boolean isAdmin()
  {
    return AppSecurityCollaborator.getInstance().isAdmin(this.principal);
  }

  public static boolean isAdmin(String userAccount) {
    if (userAccount == null)
      return false;
    AuthPrincipal principal = new AuthPrincipal(userAccount, null, null);
    return AppSecurityCollaborator.getInstance().isAdmin(principal);
  }

  public static boolean isAdminByUserid(String userID) {
    if (userID == null) {
      return false;
    }
    AuthPrincipal principal = new AuthPrincipal(getUserAccountByUserID(userID), null, null);

    return AppSecurityCollaborator.getInstance().isAdmin(principal);
  }

  public static boolean isAdministratorRole(String role)
  {
    if (role == null)
      return false;
    String administratorRole = AppSecurityCollaborator.getInstance().getAdministratorRoleName();

    return administratorRole.equals(role);
  }

  public static boolean isRoleOfEveryOne(String role)
  {
    if (role == null)
      return false;
    String roleOfEveryOne = AppSecurityCollaborator.getInstance().getEveryonegrantedRoleName();

    return roleOfEveryOne.equals(role);
  }

  public boolean isGrantedRole(AuthRole role)
  {
    return AppSecurityCollaborator.getInstance().isCallerInRole(new AppAccessContext(ConfigManager.getInstance().getAppName(), ConfigManager.getInstance().getModuleName()), role, this.principal);
  }

  public boolean isGrantedRole(String role)
  {
    AuthRole arole = new AuthRole();
    arole.setRoleName(role);
    return isGrantedRole(arole);
  }

  public static String getAdministratorRoleName()
  {
    return AppSecurityCollaborator.getInstance().getAdministratorRoleName();
  }

  public static String getEveryonegrantedRoleName()
  {
    return AppSecurityCollaborator.getInstance().getEveryonegrantedRoleName();
  }

  public String getUserAttribute(String userAttribute)
  {
    try {
      Object value = this.credential.getCheckCallBack().getUserAttribute(userAttribute);

      return ((value == null) ? "" : value.toString()); } catch (Exception e) {
    }
    return "";
  }

  public Object getUserObjectAttribute(String userAttribute)
  {
    try {
      Object value = this.credential.getCheckCallBack().getUserAttribute(userAttribute);

      return value; } catch (Exception e) {
    }
    return null;
  }

  public boolean isLogin(String userAccount)
  {
    if (userAccount == null)
      return false;
    if (this.principal == null) {
      return false;
    }
    String login_userAccount = this.principal.getName();
    return ((login_userAccount != null) && (login_userAccount.equals(userAccount)));
  }

  public int getLoginUserCount()
  {
    return -1;
  }

  public Collection getLoginUsers()
  {
    return new ArrayList();
  }

  public boolean allowIfNoRequiredRoles(String resourceType)
  {
    return AppSecurityCollaborator.getInstance().allowIfNoRequiredRoles(resourceType);
  }

  public static boolean isUnprotected(String resourceId, String operation, String resourceType)
  {
    return AppSecurityCollaborator.getInstance().isUnprotected(resourceId, operation, resourceType);
  }

  public static boolean isUnprotected(String resourceId, String resourceType)
  {
    return AppSecurityCollaborator.getInstance().isUnprotected(resourceId, resourceType);
  }

  public static boolean isExcluded(String resourceId, String operation, String resourceType)
  {
    return AppSecurityCollaborator.getInstance().isExcluded(resourceId, operation, resourceType);
  }

  public static boolean isExcluded(String resourceId, String resourceType)
  {
    return AppSecurityCollaborator.getInstance().isExcluded(resourceId, resourceType);
  }

  public static AuthRole[] getAllRoleofUser(String userAccount)
  {
    return AppSecurityCollaborator.getInstance().getAllRoleofUser(userAccount);
  }

  public static boolean hasGrantedAnyRole(String resource, String resourceType)
  {
    return AppSecurityCollaborator.getInstance().hasGrantedAnyRole(resource, resourceType);
  }

  public static boolean hasGrantedRole(String role, String roleType, String resource, String resourceType)
  {
    return AppSecurityCollaborator.getInstance().hasGrantedRole(role, roleType, resource, resourceType);
  }

  public static AuthUser[] getAllPermissionUsersOfResource(String resourceid, String operation, String resourceType)
  {
    return AppSecurityCollaborator.getInstance().getAllPermissionUsersOfResource(resourceid, operation, resourceType);
  }

  public boolean isOrganizationManager(String orgid)
  {
    boolean tag = false;
    try {
      Organization org = OrgCacheManager.getInstance().getOrganization(orgid);

      if (org != null) {
        String path = org.getUniqPath();
        String[] orgids = path.split("/");

        if (orgids.length > 0) {
          for (int i = 0; i < orgids.length; ++i) {
            OrgAdminCache orgAdminCache = OrgAdminCache.getOrgAdminCache();

            List adminList = orgAdminCache.getManagersOfOrg(orgids[i]);

            if (adminList.size() > 0) {
              for (int j = 0; j < adminList.size(); ++j) {
                User user = new User();
                user = (User)adminList.get(j);
                if ((user == null) || 
                  (!(getUserID().equals(user.getUserId() + ""))))
                  continue;
                tag = true;
              }
            }
          }
        }
      }

    }
    catch (ManagerException e)
    {
      e.printStackTrace();
    }
    return tag;
  }

  public boolean isSubOrgManager(String parentOrgid)
  {
    boolean tag = false;
    List adminOrgs = new ArrayList();
    OrgAdminCache orgAdminCache = OrgAdminCache.getOrgAdminCache();
    adminOrgs = orgAdminCache.getManagerOrgsOfUserByID(getUserID());
    for (int i = 0; i < adminOrgs.size(); ++i) {
      Organization org = (Organization)adminOrgs.get(i);
      if (org != null) {
        String path = org.getUniqPath();
        if (path != null) {
          String[] orgids = path.split("/");
          for (int j = 0; j < orgids.length; ++j) {
            if (orgids[j].equals(parentOrgid)) {
              tag = true;
            }
          }
        }
      }
    }
    return tag;
  }

  public static boolean isOrganizationManager(String userid, String orgid)
  {
    boolean tag = false;
    try {
      Organization org = OrgCacheManager.getInstance().getOrganization(orgid);

      if (org != null) {
        String path = org.getUniqPath();
        String[] orgids = path.split("/");

        if (orgids.length > 0) {
          for (int i = 0; i < orgids.length; ++i) {
            OrgAdminCache orgAdminCache = OrgAdminCache.getOrgAdminCache();

            List adminList = orgAdminCache.getManagersOfOrg(orgids[i]);

            if (adminList.size() > 0) {
              for (int j = 0; j < adminList.size(); ++j) {
                User user = new User();
                user = (User)adminList.get(j);
                if (userid.equals(user.getUserId() + ""))
                  tag = true;
              }
            }
          }
        }
      }
    }
    catch (ManagerException e)
    {
      e.printStackTrace();
    }
    return tag;
  }

  public static boolean isSubOrgManager(String userid, String parentOrgid)
  {
    boolean tag = false;
    List adminOrgs = new ArrayList();
    OrgAdminCache orgAdminCache = OrgAdminCache.getOrgAdminCache();
    adminOrgs = orgAdminCache.getManagerOrgsOfUserByID(userid);
    for (int i = 0; i < adminOrgs.size(); ++i) {
      Organization org = (Organization)adminOrgs.get(i);
      String path = org.getUniqPath();
      String[] orgids = path.split("/");
      for (int j = 0; j < orgids.length; ++j) {
        if (orgids[j].equals(parentOrgid)) {
          tag = true;
        }
      }
    }
    return tag;
  }

  public boolean isSiteManager()
  {
    return false;
  }

  public static boolean isBussinessDepartment(String orgId)
  {
    OrgManager orgManager = null;
    try {
      orgManager = SecurityDatabase.getOrgManager();
      return orgManager.isBussinessDepartment(orgId);
    }
    catch (SPIException e) {
      e.printStackTrace(); }
    return false;
  }

  public static Organization getUserBelongsCountyDepartment(String userId)
  {
    OrgManager orgManager = null;
    try {
      orgManager = SecurityDatabase.getOrgManager();
      return orgManager.userBelongsCountyDepartment(userId);
    }
    catch (SPIException e) {
      e.printStackTrace(); }
    return null;
  }

  public static Organization getUserBelongsCityDepartment(String userId)
  {
    OrgManager orgManager = null;
    try {
      orgManager = SecurityDatabase.getOrgManager();
      return orgManager.userBelongsCityDepartment(userId);
    }
    catch (SPIException e) {
      e.printStackTrace(); }
    return null;
  }

  public static List getUserBelongsBussinessDepartment(String userId)
  {
    OrgManager orgManager = null;
    try {
      orgManager = SecurityDatabase.getOrgManager();
      return orgManager.userBelongsBussinessDepartment(userId);
    }
    catch (SPIException e) {
      e.printStackTrace(); }
    return null;
  }

  public boolean isBussinessDepartment()
  {
    OrgManager orgManager = null;
    try {
      orgManager = SecurityDatabase.getOrgManager();
      return orgManager.isBussinessDepartment(getChargeOrgId());
    }
    catch (SPIException e) {
      e.printStackTrace(); }
    return false;
  }

  public Organization getUserBelongsCountyDepartment()
  {
    OrgManager orgManager = null;
    try {
      orgManager = SecurityDatabase.getOrgManager();
      return orgManager.userBelongsCountyDepartment(getUserID());
    }
    catch (SPIException e) {
      e.printStackTrace(); }
    return null;
  }

  public Organization getUserBelongsCityDepartment()
  {
    OrgManager orgManager = null;
    try {
      orgManager = SecurityDatabase.getOrgManager();
      return orgManager.userBelongsCityDepartment(getUserID());
    }
    catch (SPIException e) {
      e.printStackTrace(); }
    return null;
  }

  public Organization getUserBelongsProvinceDepartment()
  {
    OrgManager orgManager = null;
    try {
      orgManager = SecurityDatabase.getOrgManager();
      return orgManager.userBelongsCityDepartment(getUserID());
    }
    catch (SPIException e) {
      e.printStackTrace(); }
    return null;
  }

  public List getUserBelongsBussinessDepartment()
  {
    OrgManager orgManager = null;
    try {
      orgManager = SecurityDatabase.getOrgManager();
      return orgManager.userBelongsBussinessDepartment(getUserID());
    }
    catch (SPIException e) {
      e.printStackTrace(); }
    return null;
  }

  public String getUserRes_jobRoleandRoleandSelf(String userCurOrgId, String grantUserId, String resName, String restypeId, String resId, String opId)
    throws ManagerException
  {
    String[] userIds = grantUserId.split(",");
    if (userIds.length > 1)
      return "";
    String returnStr = "";
    DBUtil db_role = new DBUtil();

    StringBuffer sql_role = new StringBuffer().append("select t.OP_ID, t.RES_ID, t.ROLE_ID, t.RESTYPE_ID, t.TYPES from td_sm_roleresop t ").append("where t.role_id in (select ojr.role_id ").append("from td_sm_orgjobrole ojr, td_sm_job j ").append(" where ojr.job_id in(select job_id from td_sm_userjoborg where user_id = ").append(grantUserId).append(")").append("and org_id = '").append(userCurOrgId).append("' and ojr.job_id = j.job_id ").append("union select role_id from td_sm_userrole where user_id = ").append(grantUserId).append(") ").append("and restype_id = '").append(restypeId).append("' ").append("and res_id = '").append(resId).append("' ").append("and op_id = '").append(opId).append("' and types='role' ");

    StringBuffer sql_role_self = new StringBuffer().append(sql_role.toString()).append(" union ").append("select t.OP_ID, t.RES_ID, t.ROLE_ID, t.RESTYPE_ID, t.TYPES from td_sm_roleresop t ").append("where t.role_id in (").append("select role_id from td_sm_roleresop where role_id='").append(grantUserId).append("') ").append("and restype_id = '").append(restypeId).append("' ").append("and res_id = '").append(resId).append("' ").append("and op_id = '").append(opId).append("' and types='user' ");
    try
    {
      db_role.executeSelect(sql_role.toString());
      if (db_role.size() > 0) {
        returnStr = "1";
        DBUtil db_role_self = new DBUtil();
        db_role_self.executeSelect(sql_role_self.toString());
        if (db_role_self.size() >= db_role.size() + 1)
          returnStr = "2";
      }
      else {
        returnStr = "3";
      }
    } catch (SQLException e) {
      e.printStackTrace();
    }
    return returnStr;
  }

  public Map getSourceUserRes_Role(String userCurOrgId, String grantUserId, String resName, String restypeId, String resId)
    throws ManagerException
  {
    String[] userIds = grantUserId.split(",");
    if (userIds.length > 1) {
      return null;
    }

    StringBuffer sql_selfRole = new StringBuffer().append("select t.op_id,'用户角色【'||a.role_name||'】拥有该资源；' as jobname ").append("from td_sm_roleresop t,td_sm_role a ").append("where t.role_id in ").append("(select role_id from td_sm_userrole where user_id = ").append(grantUserId).append(") ").append("and restype_id = '").append(restypeId).append("' ").append("and res_id = '").append(resId).append("' ").append(" and a.role_id = t.role_id and t.types = 'role' ");

    StringBuffer sql_jobRole = new StringBuffer().append("select a.op_id,'用户岗位'||infos.job_name || '下的角色【' || b.role_name||'】拥有该资源；' as jobname ").append("from (select aa.role_id, aa.job_id, job.job_name ").append("from td_sm_orgjobrole aa, td_sm_userjoborg bb, td_sm_job job ").append("where aa.org_id = bb.org_id and aa.job_id = bb.job_id ").append("and job.job_id = bb.job_id and bb.user_id = ").append(grantUserId).append(") infos, ").append("td_sm_roleresop a,td_sm_role b  where a.role_id = infos.role_id and a.types = 'role' ").append("and a.role_id = b.role_id ").append("and restype_id = '").append(restypeId).append("' ").append("and res_id = '").append(resId).append("' ");

    StringBuffer sql_org = new StringBuffer().append("select a.op_id,'来自机构【' || nvl(b.remark5,b.org_name) ||'】；'  as jobname ").append(" from td_sm_roleresop a left join td_sm_organization b on a.role_id = b.org_id ").append(" where a.types='organization' and a.role_id in (select  org_id from td_sm_userjoborg ").append(" where user_id =").append(grantUserId).append(") and a.restype_id = '").append(restypeId).append("' and a.res_id = '").append(resId).append("' ").append(" union").append(" select a.op_id,'来自【'|| o.remark5 ||'】机构的角色【' || b.role_name || '】；' as jobname ").append(" from td_sm_orgrole c ,td_sm_organization o ,td_sm_roleresop a,td_sm_role b ").append(" where c.org_id=o.org_id and a.role_id=c.role_id and a.types='role' and c.role_id=b.role_id and c.org_id in (").append("select  org_id from td_sm_userjoborg where user_id =").append(grantUserId).append(") and a.restype_id = '").append(restypeId).append("' and a.res_id = '").append(resId).append("' ");

    StringBuffer sql_group = new StringBuffer().append(" select  a.op_id,'来自用户组【'||g.group_name||'】对应角色【' || b.role_name || '】；' as jobname").append(" from td_sm_grouprole d , td_sm_group g  ,td_sm_roleresop a,td_sm_role b where d.group_id=g.group_id and a.role_id=d.role_id and d.role_id=b.role_id and a.types='role' and d.group_id in (").append(" select  group_id from td_sm_usergroup  where user_id = ").append(grantUserId).append(") and a.restype_id = '").append(restypeId).append("' and a.res_id = '").append(resId).append("' ");

    StringBuffer sql = new StringBuffer().append(sql_selfRole.toString()).append(" union ").append(sql_jobRole.toString()).append(" union ").append(sql_org.toString()).append(" union ").append(sql_group.toString());

    DBUtil db = new DBUtil();
    try {
      db.executeSelect(sql.toString());

      Map opMap = new HashMap();

      for (int i = 0; i < db.size(); ++i) {
        String key = db.getString(i, "op_id");
        String values = db.getString(i, "jobname");
        String exist = (String)opMap.get(key);
        if (exist == null) {
          opMap.put(key, values);
        } else {
          exist = exist + values;
          opMap.put(key, exist);
        }
      }

      return opMap;
    } catch (SQLException e) {
      e.printStackTrace();
    }
    return null;
  }

  public Map getRoleSelfResource(String roleId, String resTypeId, String roleTypeId, String opId)
  {
    String sql1 = "select res_id from td_sm_roleresop where role_id='" + roleId + "' and restype_id='" + resTypeId + "' and types='" + roleTypeId + "' and op_id='" + opId + "'";

    Map checks = new HashMap();
    PreparedDBUtil db1 = new PreparedDBUtil();
    try
    {
      db1.executeSelect(sql1);
      for (int i = 0; i < db1.size(); ++i)
        checks.put(db1.getString(i, "res_id"), token);
    }
    catch (SQLException e)
    {
      e.printStackTrace();
    }
    return checks;
  }

  public Map getRoleSelfResource(String roleId, String resTypeId, String roleTypeId, String opId, String orgId)
  {
    String sql1 = "select res_id from td_sm_roleresop where role_id='" + roleId + "' and restype_id='" + resTypeId + "' and types='" + roleTypeId + "' and op_id='" + opId + "' and org_id='" + orgId + "'";

    Map checks = new HashMap();
    PreparedDBUtil db1 = new PreparedDBUtil();
    try
    {
      db1.executeSelect(sql1);
      for (int i = 0; i < db1.size(); ++i)
        checks.put(db1.getString(i, "res_id"), token);
    }
    catch (SQLException e)
    {
      e.printStackTrace();
    }
    return checks;
  }

  public Map getRoleSelfResource(String roleId, String resTypeId, String roleTypeId)
  {
    String sql1 = "select res_id,op_id from td_sm_roleresop where role_id='" + roleId + "' and restype_id='" + resTypeId + "' and types='" + roleTypeId + "' ";

    Map checks = new HashMap();
    PreparedDBUtil db1 = new PreparedDBUtil();
    try
    {
      db1.executeSelect(sql1);
      for (int i = 0; i < db1.size(); ++i) {
        checks.put(db1.getString(i, "res_id") + "||" + db1.getString(i, "op_id"), token);
      }
    }
    catch (SQLException e)
    {
      e.printStackTrace();
    }
    return checks;
  }

  public Map getSourceUserRes_Role(String userCurOrgId, String grantUserId, String restypeId, String opId)
  {
    String[] userIds = grantUserId.split(",");
    if (userIds.length > 1) {
      return null;
    }

    StringBuffer sql_selfRole = new StringBuffer().append("select t.res_id,'用户角色【'||a.role_name||'】拥有该资源；' as jobname ").append("from td_sm_roleresop t,td_sm_role a ").append("where t.role_id in ").append("(select role_id from td_sm_userrole where user_id = ").append(grantUserId).append(") ").append("and restype_id = '").append(restypeId).append("' ").append("and op_id = '").append(opId).append("' ").append(" and a.role_id = t.role_id and t.types = 'role' ");

    StringBuffer sql_jobRole = new StringBuffer().append("select a.res_id,'用户岗位'||infos.job_name || '下的角色【' || b.role_name||'】拥有该资源；' as jobname ").append("from (select aa.role_id, aa.job_id, job.job_name ").append("from td_sm_orgjobrole aa, td_sm_userjoborg bb, td_sm_job job ").append("where aa.org_id = bb.org_id and aa.job_id = bb.job_id ").append("and job.job_id = bb.job_id and bb.user_id = ").append(grantUserId).append(") infos, ").append("td_sm_roleresop a,td_sm_role b  where a.role_id = infos.role_id and a.types = 'role' ").append("and a.role_id = b.role_id ").append("and restype_id = '").append(restypeId).append("' ").append("and op_id = '").append(opId).append("' ");

    StringBuffer sql_org = new StringBuffer().append("select a.res_id,'来自机构【' || nvl(b.remark5,b.org_name) ||'】；'  as jobname ").append(" from td_sm_roleresop a left join td_sm_organization b on a.role_id = b.org_id ").append(" where a.types='organization' and a.role_id in (select  org_id from td_sm_userjoborg ").append(" where user_id =").append(grantUserId).append(") and a.restype_id = '").append(restypeId).append("' and a.op_id = '").append(opId).append("' ").append(" union").append(" select a.res_id,'来自【'|| o.remark5 ||'】机构的角色【' || b.role_name || '】；' as jobname ").append(" from td_sm_orgrole c ,td_sm_organization o ,td_sm_roleresop a,td_sm_role b ").append(" where c.org_id=o.org_id and a.role_id=c.role_id and a.types='role' and c.role_id=b.role_id and c.org_id in (").append("select  org_id from td_sm_userjoborg where user_id =").append(grantUserId).append(") and a.restype_id = '").append(restypeId).append("' and a.op_id = '").append(opId).append("' ");

    StringBuffer sql_group = new StringBuffer().append(" select  a.res_id,'来自用户组【'||g.group_name||'】对应角色【' || b.role_name || '】；' as jobname").append(" from td_sm_grouprole d , td_sm_group g  ,td_sm_roleresop a,td_sm_role b where d.group_id=g.group_id and a.role_id=d.role_id and d.role_id=b.role_id and a.types='role' and d.group_id in (").append(" select  group_id from td_sm_usergroup  where user_id = ").append(grantUserId).append(") and a.restype_id = '").append(restypeId).append("' and a.op_id = '").append(opId).append("' ");

    StringBuffer sql = new StringBuffer().append(sql_selfRole.toString()).append(" union ").append(sql_jobRole.toString()).append(" union ").append(sql_org.toString()).append(" union ").append(sql_group.toString());

    DBUtil db = new DBUtil();
    try {
      db.executeSelect(sql.toString());

      Map opMap = new HashMap();

      for (int i = 0; i < db.size(); ++i) {
        String key = db.getString(i, "res_id");
        String values = db.getString(i, "jobname");
        String exist = (String)opMap.get(key);
        if (exist == null) {
          opMap.put(key, values);
        } else {
          exist = exist + values;
          opMap.put(key, exist);
        }
      }

      return opMap;
    } catch (SQLException e) {
      e.printStackTrace();
    }
    return null;
  }

  public String getSourceUserRes_jobRoleandRoleandSelf(String userCurOrgId, String grantUserId, String resName, String restypeId, String resId, String opId)
    throws ManagerException
  {
    String[] userIds = grantUserId.split(",");
    if (userIds.length > 1) {
      return "";
    }
    String returnStr = "";

    StringBuffer sql_self = new StringBuffer().append("select '用户自身拥有该资源；' as jobname from td_sm_roleresop t ").append("where t.role_id in (").append("select role_id from td_sm_roleresop where role_id='").append(grantUserId).append("') ").append("and restype_id = '").append(restypeId).append("' ").append("and res_id = '").append(resId).append("' ").append("and op_id = '").append(opId).append("' and t.types = 'user' ");

    StringBuffer sql_selfRole = new StringBuffer().append("select '用户角色【'||a.role_name||'】拥有该资源；' as jobname ").append("from td_sm_roleresop t,td_sm_role a ").append("where t.role_id in ").append("(select role_id from td_sm_userrole where user_id = ").append(grantUserId).append(") ").append("and restype_id = '").append(restypeId).append("' ").append("and res_id = '").append(resId).append("' ").append("and op_id = '").append(opId).append("' ").append(" and a.role_id = t.role_id and t.types = 'role' ");

    StringBuffer sql_jobRole = new StringBuffer().append("select '用户岗位'||infos.job_name || '下的角色【' || b.role_name||'】拥有该资源；' as jobname ").append("from (select aa.role_id, aa.job_id, job.job_name ").append("from td_sm_orgjobrole aa, td_sm_userjoborg bb, td_sm_job job ").append("where aa.org_id = bb.org_id and aa.job_id = bb.job_id ").append("and job.job_id = bb.job_id and bb.user_id = ").append(grantUserId).append(") infos, ").append("td_sm_roleresop a,td_sm_role b  where a.role_id = infos.role_id and a.types = 'role' ").append("and a.role_id = b.role_id ").append("and restype_id = '").append(restypeId).append("' ").append("and res_id = '").append(resId).append("' ").append("and op_id = '").append(opId).append("' ");

    StringBuffer sql = new StringBuffer().append(sql_selfRole.toString()).append(" union ").append(sql_jobRole.toString()).append(" union ").append(sql_self.toString());

    DBUtil db = new DBUtil();
    try {
      db.executeSelect(sql.toString());
      if (db.size() > 0)
        for (int i = 0; i < db.size(); ++i) {
          String jobname = db.getString(i, "jobname");
          returnStr = returnStr + jobname;
        }
    }
    catch (SQLException e) {
      e.printStackTrace();
    }
    return returnStr;
  }

  public static boolean isOrgManager(String userName)
  {
    boolean state = false;
    DBUtil db = new DBUtil();
    String sql = "select count(b.org_id) from td_sm_user a,td_sm_orgmanager b where a.user_id = b.user_id and a.user_name='" + userName + "'";
    try
    {
      db.executeSelect(sql);
      if (db.getInt(0, 0) > 0)
        state = true;
    }
    catch (SQLException e) {
      e.printStackTrace();
    }
    return state;
  }

  public static boolean removeUser(String userName)
  {
    return false;
  }

  public static boolean removeAllUser()
  {
    return false;
  }

  public static boolean removeAllUserExcludeSelf(String userName, String sessionId, String ip, String macaddr, String DNSName, String serverIp, String serverport)
  {
    return false;
  }

  public static boolean removeUsers(String[] selectUserName, String curUserName)
  {
    return false;
  }

  public String getMacAddr() {
    String macaddr = null;
    if (this.session != null) {
      macaddr = (String)this.session.getAttribute("MACADDR_CACHE_KEY");
    }
    if (macaddr == null)
      return "";
    return macaddr;
  }

  public static LineUser getLineUser(String userAccount)
  {
    return null;
  }

  public static String formatErrorMsg(String errorMessage)
  {
    if (errorMessage != null) {
      errorMessage = errorMessage.replaceAll("\\n", "\\\\n");
      errorMessage = errorMessage.replaceAll("\\r", "\\\\r");
    }
    return errorMessage;
  }

  public static void resetPermissionCache()
  {
    AppSecurityCollaborator.getInstance().resetPermissionCache();
  }

  public static void resetAuthCache()
  {
    AppSecurityCollaborator.getInstance().resetAuthCache();
  }

  public String getPort()
  {
    return String.valueOf(this.request.getLocalPort());
  }

  public String getContextPath()
  {
    return this.request.getContextPath();
  }

  boolean userIsInApp(String userName, String appId)
  {
    if ((appId == null) || (appId.equals("")) || (appId.equals("module"))) {
      return true;
    }
    String dbname = new ApplyManager().getdbnameByApplyId(appId);
    String sql = "select u.user_id from td_sm_user u where u.user_name='" + userName.trim() + "'";

    DBUtil db = new DBUtil();
    try {
      db.executeSelect(dbname, sql);
      if (db.size() > 0)
        return true;
    }
    catch (SQLException e) {
      System.out.println("登录时查询登录用户错误！[" + dbname + "]");
    }
    return false;
  }

  public List getLoanOrgFromUser(String userId)
  {
    List list = null;
    if (null != userId) {
      OrgManager orgManager = SecurityDatabase.getOrgManager();
      list = orgManager.getLoanOrgFromUserJob(userId, "兼职");
      if ((null == list) || (list.size() <= 0)) {
        list = new ArrayList();
        list.add(getChargeOrg());
      }
    }
    return list;
  }

  static
  {
    try
    {
      guest = new AccessControl();
      guest.guestlogin();
    }
    catch (Exception e) {
      e.printStackTrace();
    }

    kickmode = ConfigManager.getInstance().getConfigValue("kickmode", "refuse");

    enablemutilogin = ConfigManager.getInstance().getConfigBooleanValue("enablemutilogin", true);

    cluster_session_synchronize = ConfigManager.getInstance().getConfigBooleanValue("cluster.session.synchronize", false);

    token = new Object();
  }
}