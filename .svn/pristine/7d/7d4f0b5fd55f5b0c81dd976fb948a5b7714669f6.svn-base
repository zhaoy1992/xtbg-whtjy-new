package com.chinacreator.sysmgrcore.purviewmanager;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.chinacreator.config.ConfigException;
import com.chinacreator.config.ConfigManager;
import com.chinacreator.resource.ResourceManager;
import com.chinacreator.sysmgrcore.entity.Organization;
import com.chinacreator.sysmgrcore.manager.OrgManager;
import com.chinacreator.sysmgrcore.manager.db.OrgCacheManager;
import com.chinacreator.sysmgrcore.manager.db.OrgManagerImpl;
import com.frameworkset.common.tag.contextmenu.Menu;
import com.frameworkset.common.tag.tree.COMTree;
import com.frameworkset.common.tag.tree.itf.ITreeNode;
/**
 *<p>Title:PurviewManagerOrgTree.java</p>
 *<p>Description:（王博反编译）</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-5-13
 */
public class PurviewManagerOrgTree extends COMTree
  implements Serializable{
	
	private static final long serialVersionUID = 1L;
	boolean orguser_modify_forbidden = ConfigManager.getInstance().getConfigBooleanValue("orguser.modify.forbidden", false);

  public boolean hasSon(ITreeNode father)
  {
    String treeID = father.getId();
    try
    {
      if (father.isRoot()) {
        return true;
      }
      return OrgCacheManager.getInstance().hasSubOrg(treeID);
    }
    catch (Exception e)
    {
      e.printStackTrace();
    }

    return false;
  }

  public boolean setSon(ITreeNode father, int curLevel)
  {
    String treeID = father.getId();

    String displayNameInput = this.request.getParameter("displayNameInput");
    String displayValueInput = this.request.getParameter("displayValueInput");
    try {
      List orglist = OrgCacheManager.getInstance().getSubOrganizations(treeID);

      if (orglist != null) {
        for (int i = 0; i < orglist.size(); ++i) {
          Organization sonorg = (Organization)orglist.get(i);
          String treeName = "";
          if ((sonorg.getRemark5() == null) || (sonorg.getRemark5().trim().equals("")))
          {
            treeName = sonorg.getOrgName();
          }
          else treeName = sonorg.getRemark5();
          String orgId = sonorg.getOrgId();
          Map map = new HashMap();
          map.put("orgId", orgId);
          map.put("resId", orgId);
          map.put("resName", treeName);
          map.put("displayNameInput", displayNameInput);
          map.put("displayValueInput", displayValueInput);
          map.put("nodeLink", this.request.getContextPath() + "/purviewmanager/userorgmanager/org/org_userlist.jsp");

          if ((this.accessControl.isOrganizationManager(orgId)) || (this.accessControl.isAdmin()))
          {
            ITreeNode node = addNode(father, orgId, treeName, "org", true, curLevel, (String)null, (String)null, orgId, map);

            Menu orgmenu = new Menu();

            orgmenu.setIdentity(orgId);

            Menu.ContextMenuItem sitemenuitem1 = new Menu.ContextMenuItem();
            sitemenuitem1.setName("基本信息查看");
            sitemenuitem1.setLink("javascript:checkOrgInfo('" + orgId + "','" + sonorg.getParentId() + "');");

            sitemenuitem1.setIcon(this.request.getContextPath() + "/sysmanager/images/icons/task.gif");

            orgmenu.addContextMenuItem(sitemenuitem1);

            if (this.accessControl.checkPermission("orgunit", "orgupdate", "orgunit"))
            {
              orgmenu.setIdentity(orgId);

              if (!(this.orguser_modify_forbidden)) {
                Menu.ContextMenuItem sitemenuitem2 = new Menu.ContextMenuItem();
                sitemenuitem2.setName("基本信息修改");
                sitemenuitem2.setLink("javascript:modifyOrgInfo('" + orgId + "','" + sonorg.getParentId() + "');");

                sitemenuitem2.setIcon(this.request.getContextPath() + "/sysmanager/images/icons/task-edit.gif");

                orgmenu.addContextMenuItem(sitemenuitem2);
              }

            }
            
            if (this.accessControl.checkPermission("orgunit", "newdelorg", "orgunit"))
            {
              OrgManager orgManager = new OrgManagerImpl();

              Organization org = OrgCacheManager.getInstance().getOrganization(orgId);

              if ((this.accessControl.isAdmin()) || (org.getCreator().equals(this.accessControl.getUserID())))
              {
                orgmenu.setIdentity(orgId);

                if (!(this.orguser_modify_forbidden)) {
                  Menu.ContextMenuItem sitemenuitem3 = new Menu.ContextMenuItem();
                  sitemenuitem3.setName("删除");
                  sitemenuitem3.setLink("javascript:deleteOrg('" + orgId + "','" + sonorg.getRemark5() + "');");

                  sitemenuitem3.setIcon(this.request.getContextPath() + "/sysmanager/images/clean.gif");

                  orgmenu.addContextMenuItem(sitemenuitem3);
                }

              }

            }
            
            if (this.accessControl.checkPermission("orgunit", "newdelorg", "orgunit"))
            {
              orgmenu.setIdentity(orgId);

              if (!(this.orguser_modify_forbidden))
              {
                Menu.ContextMenuItem sitemenuitem5 = new Menu.ContextMenuItem();
                sitemenuitem5.setName("建子机构");
                sitemenuitem5.setLink("javascript:addOrgSon('" + orgId + "','" + sonorg.getRemark5() + " ');");

                sitemenuitem5.setIcon(this.request.getContextPath() + "/sysmanager/images/addFieldCon.gif");

                orgmenu.addContextMenuItem(sitemenuitem5);
              }

            }

            orgmenu.setIdentity(orgId);
            Menu.ContextMenuItem sitemenuitem6 = new Menu.ContextMenuItem();
            sitemenuitem6.setName("子机构排序");
            sitemenuitem6.setLink("javascript:sortSonOrg('" + orgId + "','" + sonorg.getOrgName() + " 机构下的子机构排序：')");

            sitemenuitem6.setIcon(this.request.getContextPath() + "/sysmanager/images/procedure.gif");

            orgmenu.addContextMenuItem(sitemenuitem6);

            orgmenu.setIdentity(orgId);

          /*  if (ConfigManager.getInstance().getConfigBooleanValue("enablejobfunction", false))
            {
              Menu.ContextMenuItem sitemenuitem7 = new Menu.ContextMenuItem();
              sitemenuitem7.setName("岗位设置");
              sitemenuitem7.setLink("javascript:changeOrgJob('" + orgId + "','" + sonorg.getRemark5() + "');");

              sitemenuitem7.setIcon(this.request.getContextPath() + "/sysmanager/images/Valve.gif");

              orgmenu.addContextMenuItem(sitemenuitem7);
            }*/

            /*Menu.ContextMenuItem sitemenuitem8;
            if ((ConfigManager.getInstance().getConfigBooleanValue("enableorgrole", false)) && ((
              (this.accessControl.isAdmin()) || (!(orgId.equals(this.accessControl.getChargeOrgId()))))))
            {
              orgmenu.setIdentity(orgId);

              sitemenuitem8 = new Menu.ContextMenuItem();
              sitemenuitem8.setName("角色设置");
              sitemenuitem8.setLink("javascript:rightRole('" + orgId + "');");

              sitemenuitem8.setIcon(this.request.getContextPath() + "/sysmanager/images/rightMemu/chl_publish.gif");

              orgmenu.addContextMenuItem(sitemenuitem8);
            }*/
            OrgManager orgManager;
            List orgs;
            Iterator iter;
            Organization org;
            if (this.accessControl.checkPermission("orgunit", "changeorgadmin", "orgunit"))
            {
              if (this.accessControl.isAdmin()) {
                orgmenu.setIdentity(orgId);
                Menu.ContextMenuItem sitemenuitem9 = new Menu.ContextMenuItem();
                sitemenuitem9.setName("管理员设置");
                sitemenuitem9.setLink("javascript:changeOrgAdmin('" + orgId + "');");

                sitemenuitem9.setIcon(this.request.getContextPath() + "/sysmanager/images/profile.gif");

                orgmenu.addContextMenuItem(sitemenuitem9);
              } else {
                orgManager = new OrgManagerImpl();
                orgs = orgManager.getOrgListOfUser(this.accessControl.getUserID());

                if (orgs.size() > 0) {
                  iter = orgs.iterator();
                  while (iter.hasNext()) {
                    org = (Organization)iter.next();

                    if (!(org.getOrgId().equals(orgId))) {
                      orgmenu.setIdentity(orgId);

                      Menu.ContextMenuItem sitemenuitem9 = new Menu.ContextMenuItem();
                      sitemenuitem9.setName("管理员设置");
                      sitemenuitem9.setLink("javascript:changeOrgAdmin('" + orgId + "');");

                      sitemenuitem9.setIcon(this.request.getContextPath() + "/sysmanager/images/profile.gif");

                      orgmenu.addContextMenuItem(sitemenuitem9);
                    }
                  }
                }
              }

            }

            /*orgmenu.addSeperate();
            if (this.accessControl.checkPermission("orgunit", "purset", "orgunit"))
            {
              if (this.accessControl.isAdmin()) {
                orgmenu.setIdentity(orgId);
                Menu.ContextMenuItem sitemenuitem10 = new Menu.ContextMenuItem();
                sitemenuitem10.setName("权限回收");
                sitemenuitem10.setLink("javascript:reclaimOrgUserRes('" + orgId + "');");

                sitemenuitem10.setIcon(this.request.getContextPath() + "/sysmanager/images/icons/16x16/recycle.gif");

                orgmenu.addContextMenuItem(sitemenuitem10);
              } else {
                orgManager = new OrgManagerImpl();

                orgs = orgManager.getOrgListOfUser(this.accessControl.getUserID());

                if (orgs.size() > 0) {
                  iter = orgs.iterator();
                  while (iter.hasNext()) {
                    org = (Organization)iter.next();

                    if (!(org.getOrgId().equals(orgId))) {
                      orgmenu.setIdentity(orgId);
                      Menu.ContextMenuItem sitemenuitem10 = new Menu.ContextMenuItem();
                      sitemenuitem10.setName("权限回收");
                      sitemenuitem10.setLink("javascript:reclaimOrgUserRes('" + orgId + "');");

                      sitemenuitem10.setIcon(this.request.getContextPath() + "/sysmanager/images/icons/16x16/recycle.gif");

                      orgmenu.addContextMenuItem(sitemenuitem10);
                    }
                  }
                }

              }

            }

            if (ConfigManager.getInstance().getConfigBooleanValue("enableorgrole", false))
            {
              orgmenu.setIdentity(orgId);

              sitemenuitem8 = new Menu.ContextMenuItem();
              sitemenuitem8.setName("权限查询");
              sitemenuitem8.setLink("javascript:orgResQuery('" + orgId + "');");

              sitemenuitem8.setIcon(this.request.getContextPath() + "/sysmanager/images/icons/16x16/book-purple-open.gif");

              orgmenu.addContextMenuItem(sitemenuitem8);
              if ((this.accessControl.checkPermission("orgunit", "purset", "orgunit")) && ((
                (this.accessControl.isAdmin()) || (!(orgId.equals(this.accessControl.getChargeOrgId()))))))
              {
                Menu.ContextMenuItem sitemenuitem9 = new Menu.ContextMenuItem();
                sitemenuitem9.setName("权限授予");
                sitemenuitem9.setLink("javascript:grantOrgRes('" + orgId + "');");

                sitemenuitem9.setIcon(this.request.getContextPath() + "/sysmanager/images/JSTreeImgs/task-view.gif");

                orgmenu.addContextMenuItem(sitemenuitem9);
              }

            }*/

            if (orgmenu.getContextMenuItems().size() > 0) {
              super.addContextMenuOfNode(node, orgmenu);
            }
          }
          else if (this.accessControl.isSubOrgManager(orgId)) {
            addNode(father, orgId, treeName, "org", false, curLevel, (String)null, (String)null, (String)null, map);
          }
        }
      }

    }
    catch (Exception e)
    {
      e.printStackTrace();
    }

    if ((ConfigManager.getInstance().getConfigBooleanValue("enableorgusermove", true)) && 
      (father.isRoot()))
    {
      String resId = null;
      try {
        Map map = new HashMap();

        ResourceManager resManager = new ResourceManager();
        resId = resManager.getGlobalResourceid("orgunit");

        map.put("nodeLink", "javascript:openModalDialogWin('" + this.request.getContextPath() + "/purviewmanager/userorgmanager/user/discreteUserList.jsp',screen.availWidth-50,screen.availHeight-50);");

        map.put("node_linktarget", "lisanwindows");

        addNode(father, "lisan", "离散用户管理", "lisan", true, curLevel, (String)null, (String)null, (String)null, map);
      }
      catch (ConfigException e) {
        e.printStackTrace();
      }

    }

    return true;
  }

  protected void buildContextMenus() {
    if (this.accessControl.isAdmin()) {
      Menu orgmenu = new Menu();
      orgmenu.setIdentity("1");

      Menu.ContextMenuItem orgreordermenu = new Menu.ContextMenuItem();
      orgreordermenu.setName("机构排序");
      orgreordermenu.setLink("javascript:sortOrg('0','所有一级机构排序：')");
      orgreordermenu.setIcon(this.request.getContextPath() + "/sysmanager/images/actions.gif");

      orgmenu.addContextMenuItem(orgreordermenu);

      orgmenu.addSeperate();

      Menu.ContextMenuItem orgcacherefresh = new Menu.ContextMenuItem();
      orgcacherefresh.setName("机构缓冲刷新");
      orgcacherefresh.setLink("javascript:refreshorgcache()");
      orgcacherefresh.setIcon(this.request.getContextPath() + "/sysmanager/images/dialog-reset.gif");

      orgmenu.addContextMenuItem(orgcacherefresh);

      Menu.ContextMenuItem orgmanagercacherefresh = new Menu.ContextMenuItem();
      orgmanagercacherefresh.setName("部门管理员可管理机构缓冲刷新");
      orgmanagercacherefresh.setLink("javascript:refreshorgmanagercache()");

      orgmanagercacherefresh.setIcon(this.request.getContextPath() + "/sysmanager/images/dialog-reset.gif");

      orgmenu.addContextMenuItem(orgmanagercacherefresh);

      Menu.ContextMenuItem cacherefresh = new Menu.ContextMenuItem();
      cacherefresh.setName("权限缓冲刷新");
      cacherefresh.setLink("javascript:refreshcache()");
      cacherefresh.setIcon(this.request.getContextPath() + "/sysmanager/images/dialog-reset.gif");

      orgmenu.addContextMenuItem(cacherefresh);

      super.addContextMenuOfType(orgmenu);
    }
  }
}