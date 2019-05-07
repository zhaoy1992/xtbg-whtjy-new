package com.chinacreator.xtbg.core.codegenerator.generator.SqlUtilGenerator.service;

import com.chinacreator.xtbg.core.codegenerator.entity.ClassProperty;
import com.chinacreator.xtbg.core.codegenerator.generator.ServiceMethodGenerator;
import com.chinacreator.xtbg.core.codegenerator.util.CodeConstant;
import com.chinacreator.xtbg.core.codegenerator.util.CodeUtil;


public class GenerateServiceImplMethod implements ServiceMethodGenerator {
	@Override
	public String delete(ClassProperty classProperty) {
		StringBuffer code = new StringBuffer();
		code.append("    @Override\r\n");
		code.append("    "+CodeConstant.service_method_delete(classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY)+" {\r\n");
		code.append("        ResultMap<ResultCode, "+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY+"> result = new ResultMap<ResultCode, "+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY+">();\r\n");
		code.append("        result.setCode(ResultCode.FAIL);\r\n");
		code.append("	     if(ids == null || \"\".equals(ids)){\r\n");
		code.append("	         result.setCode(ResultCode.MISS_ID);\r\n");
		code.append("	     } else {\r\n");
		code.append("	         Connection con = null;\r\n");
		code.append("	         try {\r\n");
		code.append("		         con = DbManager.getInstance().getConnection();\r\n");
		code.append("		         dao."+CodeConstant.METHOD_DELETE+"(ids, con);\r\n");
		code.append("		         result.setCode(ResultCode.OK);\r\n");
		code.append("	         } catch (Exception e) {\r\n");
		code.append("		         LOG.error(e.getMessage(),e);\r\n");
		code.append("	         } finally {\r\n");
		code.append("		         DbManager.closeConnection(con);\r\n");
		code.append("	         }\r\n");
		code.append("	    }\r\n");
		code.append("       return result;\r\n");
		code.append("    }\r\n");
		return code.toString();
	}

	@Override
	public String insert(ClassProperty classProperty) {
		StringBuffer code = new StringBuffer();
		code.append("    @Override\r\n");
		code.append("    "+CodeConstant.service_method_insert(classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY)+" {\r\n");
		code.append("        ResultMap<ResultCode, "+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY+"> result = new ResultMap<ResultCode, "+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY+">();\r\n");
		code.append("        result.setCode(ResultCode.FAIL);\r\n");
		code.append("        Connection con = null;\r\n");
		code.append("        try {\r\n");
		code.append("            con = DbManager.getInstance().getConnection();\r\n");
		code.append("            bean.set"+CodeUtil.upperCaseFirst(classProperty.getPrimaryKey())+"(DaoUtil.getUUID());\r\n");
		code.append("            dao."+CodeConstant.METHOD_INSERT+"(bean, con);\r\n");
		code.append("            result.setCode(ResultCode.OK);\r\n");
		code.append("        } catch (Exception e) {\r\n");
		code.append("            LOG.error(e.getMessage(),e);\r\n");
		code.append("        } finally {\r\n");
		code.append("            DbManager.closeConnection(con);\r\n");
		code.append("        }\r\n");
		code.append("        return result;\r\n");
		code.append("    }\r\n");
		return code.toString();
	}

	@Override
	public String listWithOutPage(ClassProperty classProperty) {
		StringBuffer code = new StringBuffer();
		code.append("    @Override\r\n");
		code.append("    "+CodeConstant.service_method_listWithOutPage(classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY)+" {\r\n");
		code.append("        ResultMap<ResultCode, List<"+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY+">> result = new ResultMap<ResultCode, List<"+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY+">>();\r\n");
		code.append("        result.setCode(ResultCode.FAIL);\r\n");
		code.append("        Connection con = null;\r\n");
		code.append("        try {\r\n");
		code.append("            con = DbManager.getInstance().getConnection();\r\n");
		code.append("            List<"+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY+"> list = dao."+CodeConstant.METHOD_LISTWITHOUTPAGE+"(bean, con);\r\n");
		code.append("            if(list != null && list.size() > 0) {\r\n");
		code.append("                result.setCode(ResultCode.OK);\r\n");
		code.append("                result.setResult(list);\r\n");
		code.append("            } else {\r\n");
		code.append("                result.setCode(ResultCode.UNEXIST);\r\n");
		code.append("            }\r\n");
		code.append("        } catch (Exception e) {\r\n");
		code.append("            LOG.error(e.getMessage(),e);\r\n");
		code.append("        } finally {\r\n");
		code.append("            DbManager.closeConnection(con);\r\n");
		code.append("        }\r\n");
		code.append("        return result;\r\n");
		code.append("    }\r\n");
		return code.toString();
	}

	@Override
	public String update(ClassProperty classProperty) {
		StringBuffer code = new StringBuffer();
		code.append("    @Override\r\n");
		code.append("    "+CodeConstant.service_method_update(classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY)+" {\r\n");
		code.append("        ResultMap<ResultCode, "+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY+"> result = new ResultMap<ResultCode, "+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY+">();\r\n");
		code.append("        result.setCode(ResultCode.FAIL);\r\n");
		code.append("        Connection con = null;\r\n");
		code.append("        try {\r\n");
		code.append("            con = DbManager.getInstance().getConnection();\r\n");
		code.append("            dao."+CodeConstant.METHOD_UPDATE+"(bean, con);\r\n");
		code.append("            result.setCode(ResultCode.OK);\r\n");
		code.append("        } catch (Exception e) {\r\n");
		code.append("            LOG.error(e.getMessage(),e);\r\n");
		code.append("	     } finally {\r\n");
		code.append("            DbManager.closeConnection(con);\r\n");
		code.append("        }\r\n");
		code.append("        return result;\r\n");
		code.append("    }\r\n");
		return code.toString();
	}

	@Override
	public String getById(ClassProperty classProperty) {
		StringBuffer code = new StringBuffer();
		code.append("    @Override\r\n");
		code.append("    "+CodeConstant.service_method_getById(classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY)+" {\r\n");
		code.append("        ResultMap<ResultCode, "+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY+"> result = new ResultMap<ResultCode, "+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY+">();\r\n");
		code.append("        result.setCode(ResultCode.FAIL);\r\n");
		code.append("        Connection con = null;\r\n");
		code.append("        try {\r\n");
		code.append("            con = DbManager.getInstance().getConnection();\r\n");
		code.append("            "+classProperty.getClassName()+CodeConstant.CLASS_SUFFIX_ENTITY+" b = dao."+CodeConstant.METHOD_GETBYID+"(bean, con);\r\n");
		code.append("            if(b != null) {\r\n");
		code.append("                result.setCode(ResultCode.OK);\r\n");
		code.append("                result.setResult(b);\r\n");
		code.append("            } else {\r\n");
		code.append("                result.setCode(ResultCode.UNEXIST);\r\n");
		code.append("            }\r\n");
		code.append("        } catch (Exception e) {\r\n");
		code.append("            LOG.error(e.getMessage(),e);\r\n");
		code.append("        } finally {\r\n");
		code.append("            DbManager.closeConnection(con);\r\n");
		code.append("        }\r\n");
		code.append("        return result;\r\n");
		code.append("    }\r\n");
		return code.toString();
	}
}
