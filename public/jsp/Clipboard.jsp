<%@ page import="com.zimbra.cs.taglib.bean.BeanUtils" %>
<%
String contextPath = request.getContextPath();
if (contextPath.equals("/")) contextPath = "";
String vers = (String) request.getAttribute("version");
vers = BeanUtils.cook(vers);
String ext = (String) request.getAttribute("fileExtension");
ext = BeanUtils.cook(ext);
%>
<script type="text/javascript" src="<%=contextPath%>/js/ajax/3rdparty/clipboard_min.js?v=<%=vers%>"></script>
<script type="text/javascript">
AjxPackage.define("Clipboard");
AjxPackage.define("ajax.3rdparty.clipboard_min");
</script>
