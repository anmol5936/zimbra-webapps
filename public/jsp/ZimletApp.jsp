<%@ page import="com.zimbra.cs.taglib.bean.BeanUtils" %>
<%
String contextPath = request.getContextPath();
if (contextPath.equals("/")) contextPath = "";
String vers = (String) request.getAttribute("version");
vers = BeanUtils.cook(vers);
String ext = (String) request.getAttribute("fileExtension");
ext = BeanUtils.cook(ext);
%>
<script type="text/javascript" src="<%=contextPath%>/js/zimbraMail/share/controller/ZmZimletAppController.js?v=<%=vers%>"></script>
<script type="text/javascript" src="<%=contextPath%>/js/zimbraMail/share/view/ZmZimletAppView.js?v=<%=vers%>"></script>
<script type="text/javascript" src="<%=contextPath%>/js/zimbraMail/share/view/ZmZimletApp.js?v=<%=vers%>"></script>
<script type="text/javascript">
AjxPackage.define("ZimletApp");
AjxPackage.define("zimbraMail.share.controller.ZmZimletAppController");
AjxPackage.define("zimbraMail.share.view.ZmZimletAppView");
AjxPackage.define("zimbraMail.share.view.ZmZimletApp");
</script>
