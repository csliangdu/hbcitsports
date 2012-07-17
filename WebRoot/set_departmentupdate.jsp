<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>set_departmentupdate.jsp</title>
<link href="${pageContext.request.contextPath }/css/subcss.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.6.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/zDialog_inner.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/zDrag.js"></script>
<script language="javascript" type="text/javascript" src="${pageContext.request.contextPath }/My97DatePicker/WdatePicker.js"></script>
<style>
			body { background: #ffffff; color: #444;font-size:12px; }
			a { color: #07c; text-decoration: none; border: 0; background-color: transparent; }
			body, div, q, iframe, form, h5 { margin: 0; padding: 0; }
			img, fieldset { border: none 0; }
			body, td, textarea { word-break: break-all; word-wrap: break-word; line-height:1.6; }
			body, input, textarea, select, button { margin: 0; font-size: 12px; font-family: Tahoma, SimSun, sans-serif; }
			div, p, table, th, td { font-size:1em; font-family:inherit; line-height:inherit; }
			h5 { font-size:12px; }
			ol li,ul li{ margin-bottom:0.5em;}
			pre, code { font-family: "Courier New", Courier, monospace; word-wrap:break-word; line-height:1.4; font-size:12px;}
			pre{background:#f6f6f6; border:#eee solid 1px; margin:1em 0.5em; padding:0.5em 1em;}
			#content { padding-left:50px; padding-right:50px; }
			#content h2 { font-size:20px; color:#069; padding-top:8px; margin-bottom:8px; }
			#content h3 { margin:8px 0; font-size:14px; COLOR:#693; }
			#content h4 { margin:8px 0; font-size:16px; COLOR:#690; }
			#content div.item { margin-top:10px; margin-bottom:10px; border:#eee solid 4px; padding:10px; }
			hr { clear:both; margin:7px 0; +margin: 0;
			border:0 none; font-size: 1px; line-height:1px; color: #069; background-color:#069; height: 1px; }
			.infobar { background:#fff9e3; border:1px solid #fadc80; color:#743e04; }
			.buttonStyle{width:64px;height:22px;line-height:22px;color:#369;text-align:center;background:url(${pageContext.request.contextPath }/admin/js/images/buticon.gif) no-repeat left top;border:0;font-size:12px;}
			.buttonStyle:hover{background:url(${pageContext.request.contextPath }/admin/js/images/buticon.gif) no-repeat left -23px;}
			.input_on{padding:2px 8px 0pt 3px;height:18px;border:1px solid #999;background-color:#eeeeee;}
			
		</style>
        <script language="JavaScript">
        function updateDepart(dpid)
		{
			var reg=/["']/;
			if($('#dpname').val() == "")
			{
				Dialog.alert("请填写单位名称全称!");
				return false;
			}
			//
			if(reg.test($('#dpname').val()))
			{
				Dialog.alert("单位名称全称中请不要包含半角单引号或双引号!");
				return false;
			}
			//
			if($('#dpshortname').val() == "")
			{
				Dialog.alert("请填写单位名称简称!");
				return false;
			}
			//
			if(reg.test($('#dpshortname').val()))
			{
				Dialog.alert("单位名称简称中请不要包含半角单引号或双引号!");
				return false;
			}
			//ajax提交
			$.ajax({
			url :"${pageContext.request.contextPath }/servlet/UpdateDepartmentServlet",
			type : 'post',
			data : 'dpname='+$('#dpname').val()+'&dpsname='+$('#dpshortname').val()+'&dptype='+$('#dptype').val()+'&dpid='+dpid,
			success :function(mm){
					var revalue=mm.replace(/\r\n/g,'');
					if(revalue=="error"){
						Dialog.alert("修改单位信息失败!",function(){window.location.reload();});
					}
					if(revalue=="success"){
						Dialog.alert("修改单位信息成功!",function(){window.location.reload();});
					}
				}
			});
		}
        </script>
</head>

<body style="margin-top:30px">

<table width="100%" border="0" align="center" cellspacing="0" cellpadding="2" style="border-collapse: collapse" bordercolor="#C0C0C0">
<c:forEach var="mydp" items="${dpinfo}" varStatus="countItem"> 
 <tr>
    <td align="right" width="150">单位名称全称：</td>
    <td><label><input name="dpname" type="text" id="dpname" size="30" value="${mydp.departmentName }" />
    </label></td>
  </tr>
  <tr>
    <td align="right">单位名称简称：</td>
    <td><input name="dpshortname" type="text" id="dpshortname" size="30" value="${mydp.departmentShortName }" /></td>
  </tr>
    <tr>
    <td align="right" width="150">单位类型：</td>
    <td><label>
    <select name="dptype" id="dptype">
    	<c:if test="${mydp.departmentType eq 0}">
      	<option value="1">有学生</option>
      	<option value="0" selected="selected">无学生</option>
      	</c:if>
      	<c:if test="${mydp.departmentType eq 1}">
      	<option value="1"  selected="selected">有学生</option>
      	<option value="0">无学生</option>
      	</c:if>
    </select>
    </label></td>
  </tr>
  <tr>
    <td colspan="2" align="center"><input name="" type="button" value="确认修改" onclick="updateDepart(${mydp.id});"/></td>
  </tr>
</c:forEach>
</table>
</body>
</html>