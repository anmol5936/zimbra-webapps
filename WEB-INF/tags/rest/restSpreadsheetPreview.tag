<%--
 * ***** BEGIN LICENSE BLOCK *****
 * Zimbra Collaboration Suite Web Client
 * Copyright (C) 2010, 2011, 2013, 2014, 2016 Synacor, Inc.
 *
 * This program is free software: you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free Software Foundation,
 * version 2 of the License.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
 * without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU General Public License for more details.
 * You should have received a copy of the GNU General Public License along with this program.
 * If not, see <https://www.gnu.org/licenses/>.
 * ***** END LICENSE BLOCK *****
--%>
<%@ tag body-content="empty" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="com.zimbra.i18n" %>
<%@ taglib prefix="rest" uri="com.zimbra.restclient" %>
<%@ taglib prefix="app" uri="com.zimbra.htmlclient" %>
<%@ taglib prefix="zm" uri="com.zimbra.zm" %>
<rest:handleError>
    <fmt:getLocale var="locale"/>
    <fmt:setLocale value="${not empty param.localeId ? param.localeId : (not empty requestScope.zimbra_target_account_prefLocale ? requestScope.zimbra_target_account_prefLocale : locale)}"/>
    <fmt:setBundle basename="/messages/ZhMsg" scope='request'/>
    <zm:getDocument var="spreadsheet" box="${mailbox}" id="${requestScope.zimbra_target_account_id}:${requestScope.zimbra_target_item_id}"/>
</rest:handleError>
<c:set var="isViewOnly" value="${not empty param.viewonly}" scope="request"/>
<html>
    <head>
        <%
            String contextPath = request.getContextPath();
            if(contextPath.equals("/")) {
                contextPath = "";
            }

            final String SKIN_COOKIE_NAME = "ZM_SKIN";
            String skin = application.getInitParameter("zimbraDefaultSkin");
            Cookie[] cookies = request.getCookies();
            String requestSkin = request.getParameter("skin");
            if (requestSkin != null) {
                skin = requestSkin;
            } else if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals(SKIN_COOKIE_NAME)) {
                        skin = cookie.getValue();
                    }
                }
            }
            request.setAttribute("contextPath", contextPath);
            request.setAttribute("skin", skin);
        %>

        <!-- Zimbra Variables -->
        <c:if test="${not empty param.dev and param.dev eq '1'}">
            <c:set var="mode" value="mjsf" scope="request"/>
            <c:set var="gzip" value="false" scope="request"/>
            <c:set var="fileExtension" value="" scope="request"/>
            <c:if test="${empty param.debug}">
                <c:set var="debug" value="1" scope="request"/>
            </c:if>
            <c:set var="packages" value="dev" scope="request"/>
        </c:if>

        <c:set var="isDevMode" value="${not empty requestScope.mode and requestScope.mode eq 'mjsf'}" scope="request"/>
        <c:set var="isSkinDebugMode" value="${not empty requestScope.mode} and ${requestScope.mode eq 'skindebug'}" scope="request"/>        
        <c:set var="ext" value="${requestScope.fileExtension}" scope="page"/>
        <c:set var="vers" value="${requestScope.version}" scope="page"/>
        <c:if test="${empty ext or isDevMode}">
            <c:set var="ext" value="" scope="page"/>
        </c:if>


        <!-- CSS -->
        <c:set value="/img" var="iconPath" scope="request"/>
        <c:url var='cssurl' value='/css/images,common,login,skin,docs.css'>
            <c:param name="client"	value="standard" />
            <c:param name="skin"	value="${skin}" />
            <c:param name="v"		value="${initParam.zimbraCacheBusterVersion}" />
        </c:url>
        <link rel="stylesheet" type="text/css" href="${cssurl}" />

        <!-- Resournces -->
        <jsp:include page="/public/Resources.jsp">
            <jsp:param name="res" value="I18nMsg,TzMsg,AjxMsg,ZMsg,ZmMsg,AjxKeys,ZmKeys" />
            <jsp:param name="skin" value="${skin}" />
        </jsp:include>

        <!-- Packages -->
        <c:set var="packages" value="Boot,SpreadsheetPreview,Debug" scope="request"/>
        <c:set var="pnames" value="${fn:split(packages,',')}" scope="request"/>
        <c:set var="pprefix" value="js" scope="request"/>
        <c:choose>
            <c:when test="${isDevMode}">
                <c:set var="pprefix" value="public/jsp" scope="request"/>
                <c:set var="psufix" value=".jsp" scope="request"/>
            </c:when>
            <c:otherwise>
                <c:set var="pprefix" value="js" scope="request"/>
                <c:set var="psufix" value="_all.js" scope="request"/>
            </c:otherwise>
        </c:choose>
        <c:forEach var="pname" items="${pnames}">
            <c:set var="pageurl" value="/${pprefix}/${pname}${psufix}" scope="request"/>
            <c:choose>
                <c:when test="${isDevMode}">
                    <jsp:include>
                        <jsp:attribute name='page'>${pageurl}</jsp:attribute>
                    </jsp:include>
                </c:when>
                <c:otherwise>
                    <script type="text/javascript" src="${contextPath}${pageurl}${requestScope.fileExtension}?v=${vers}"></script>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <c:set var="version" value="${spreadsheet.version}"/>
        <c:if test="${not empty param.ver}">
            <c:set var="version" value="${param.ver}"/>
        </c:if>
              
    </head>
    <body>
    <table role="presentation" width="100%" height="100%" cellspacing="0" cellpadding="0">
        <tbody>
            <c:if test="${not isViewOnly}">
            <tr>
                <td class="TbTop" style="height:40px;">
                    <table role="presentation" width="100%" height="100%" cellpadding="0" cellspacing="5">
                    <tr>
                        <td>
                            <span style="font-size:18px;"><b>${spreadsheet.name}</b></span>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td><fmt:message key="labelBy"/>&nbsp;${spreadsheet.creator}</td>
                        <td align="right"><fmt:message key="labelVersion"/>: <span id="version_cont">${spreadsheet.version}</span>  |  <fmt:message key="labelModifiedOn"/>: <fmt:formatDate value="${spreadsheet.modifiedDate}" pattern="M/d/yyyy hh:mm" timeZone="${timeZone}"/></td>
                    </tr>
                    </table>
                </td>
            </tr>
            </c:if>
            <tr>
                <td align="top">
                    <table role="presentation" width="100%" height="100%" cellpadding="5" cellspacing="5">
                        <tbody>
                            <tr>
                                <td class="ZhAppContent" style="border-width:1px;">
                                <div style="width:100%; height:100%;" id="spreadsheet">
                                   <!-- Spreadsheet Content -->
                                </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
        </tbody>
    </table>
    <script type="text/javascript">
        window.DBG = new AjxDebug(AjxDebug.NONE, null, false);

        ZmSpreadSheetPreview.launch('spreadsheet',{
            version: '${zm:cook(version)}',
            versionCont: "version_cont" 
        });
    </script>
    </body>
</html>
