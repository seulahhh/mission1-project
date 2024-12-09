<%@ page import="db.Row" %>
<%@ page import="java.util.List" %>
<%@ page import="Services.ApiService" %>
<%@ page import="Services.dbService" %>
<%@ page import="java.sql.Connection" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/style.css"/>
    <script src="js/main.js"></script>
    <title>Document</title>
</head>
<body id="load_wifi">
<%
        List<Row> rowList = null;
        ApiService apiService = new ApiService();
        // api 데이터 받아서 Row 로 저장하는 테스트
        String urlStr = "http://openapi.seoul.go.kr:8088/444b62625970726935324753444b4a/json/TbPublicWifiInfo/";

        rowList = apiService.getApiDataRows(urlStr);

        //? double[] myLocation = new double[]{Double.parseDouble(request.getParameter("lat")), Double.parseDouble(request.getParameter("lnt"))}; // 테스트용 임의의 값
        if (rowList != null) {
            dbService dbService = new dbService();
            Connection con = dbService.getDbConnection();
            dbService.putDataToDb(con, rowList);
            dbService.closeConnection();
            int totalCount = apiService.getListTotalCount();%>
            <h1><%= totalCount %> 개의 WIFI 정보를 정상적으로 저장하였습니다.</h1>
<%        } %>
<div class="container menu_container"><a href="${pageContext.request.contextPath}">홈으로 가기</a></div>
</body>
</html>