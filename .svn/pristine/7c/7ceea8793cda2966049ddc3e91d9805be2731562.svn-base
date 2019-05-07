update OA_SYS_PARAM set p_content='知识库中有一篇【用户名】上传的标题为【文档标题】的文档已经审核，审核结果为【文档审核结果】。谢谢！',p_remark= '【用户名】    将替换为 文档登记人姓名' || chr(13) || '' || chr(10) || '【文档标题】  将替换为 标题' || chr(13) || '' || chr(10) || '【文档审核结果】  将替换为 文档状态' || chr(13) || '' || chr(10) || '注： 管理员审核后发短信给上传人。' where p_id='877aaf6f-8c96-4acb-bb56-b13a842b89f8' ;

update OA_SYS_PARAMVALUE set p_value_name= '文档审核结果' where p_value_id='61a4de28-c186-4518-bc4c-bf579ffdfddd';

commit;