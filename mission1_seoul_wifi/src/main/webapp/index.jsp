<%@ page import="Services.dbService" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="Services.ApiService" %>
<%@ page import="db.Row" %>
<%@ page import="db.Row" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/style.css"/>
    <script src="js/main.js"></script>

    <title>Insert title here</title>
</head>
<body>
<%
    // api값 받아서 Row list로 저장 테스트



    if (request.getParameter("lat") != null && request.getParameter("lnt") != null) { // 이거수정
        List<Row> rowList = null;
        ApiService apiService = new ApiService();
        // api 데이터 받아서 Row 로 저장하는 테스트
        String urlStr = "http://openapi.seoul.go.kr:8088/444b62625970726935324753444b4a/json/TbPublicWifiInfo/";

        rowList = apiService.getApiDataRows(urlStr);
        // ㄴ api 데이터 받기 && // ㄴ Row로 저장하기 (아직까지는 함께 정의)

        // 일단 이거 db에 그냥 올리고
        // distance 는 나중에 업데이트하는걸로


        double[] myLocation = new double[]{Double.parseDouble(request.getParameter("lat")), Double.parseDouble(request.getParameter("lnt"))}; // 테스트용 임의의 값
        if (rowList != null) {
//            for (Row row : rowList) {
//                apiService.setRowDistance(row, myLocation);
//            }
            dbService dbService = new dbService();
            Connection con = dbService.getDbConnection();
            dbService.putDataToDb(con, rowList);
            dbService.closeConnection();
        }
    }
//
//
//    // db에서 데이터 받아오는 테스트 // ResultSet은 사용 후 밖에서 닫아줄것
//    if (request.getParameter("getDatabaseData") != null) {
//
//        String sql = " select * from \"seoul-wifi-data"; // seoul-wifi-data table 전체조회
//        dbService dbService = new dbService();
//        Connection con = dbService.getDbConnection();
//        ResultSet rs = dbService.getDbData(con, sql);
//        while (rs.next()) {
//
//        }
//        dbService.closeConnection();
//    }
%>

<h1>와이파이 정보 구하기</h1>

<div class="container menu_container">
    <div class="menus">
        <ul>
            <li><a href="#">홈</a></li>
            <li><a href="#">위치 히스토리 목록</a></li>
            <li><a href="#">Open API 와이파이 정보 가져오기</a></li>
        </ul>
    </div>

    <div class="location_menu">
        <form>
            <label for="LAT">LAT:</label>
            <input type="text" id="LAT" name="lat">

            <label for="LNT">LNT:</label>
            <input type="text" id="LNT" name="lnt">

            <button type="submit">근처 WIFI 정보 보기</button>
        </form>
        <form id="locationForm">
            <input type="hidden" id="please">
            <button type="button" id="pleaseHelp" name="getApiData" onclick="getLocation()">내 위치 가져오기</button>
        </form>
    </div>

</div>

<div class="container table_container">
    <table id="wifi_info_table">
        <thead>
        <tr>
            <th>거리<br>(Km)</th>
            <th>관리번호</th>
            <th>자치구</th>
            <th>와이파이명</th>
            <th>도로명주소</th>
            <th>상세주소</th>
            <th>설치위치<br>(층)</th>
            <th>설치유형</th>
            <th>설치기관</th>
            <th>서비스<br>구분</th>
            <th>망종류</th>
            <th>설치년도</th>
            <th>실내외<br>구분</th>
            <th>WIFI<br>접속환경</th>
            <th>X좌표</th>
            <th>Y좌표</th>
            <th>작업일자</th>
        </tr>

        </thead>
<%--        <tbdoy>--%>
<%--            <tr class="empty_tr">--%>
<%--                <td colspan="16" class="empty_td">위치 정보를 입력한 후에 조회해 주세요.</td>--%>
<%--            </tr>--%>
<%--        </tbdoy>--%>
        <tbody>
        <%
            // db에서 데이터 받아오는 테스트 // ResultSet은 사용 후 밖에서 닫아줄것

            if (request.getParameter("getWifiInfo") != null) {

                // db조회문
                String sql = " Select * from \"seoul-wifi-data\" order by distance limit 20 ";
                dbService dbService = new dbService();
                Connection con = dbService.getDbConnection();
                PreparedStatement preparedStatement = null;
                ResultSet rs = null;
                try {
                    preparedStatement = con.prepareStatement(sql);
                    rs = preparedStatement.executeQuery();
                    while (rs.next()) {
        %>
        <tr>
            <td><%=rs.getString("distance")%></td>
            <td><%=rs.getString("mng_no")%></td>
            <td><%=rs.getString("wrdofc")%></td>
            <td><%=rs.getString("wifi_name")%></td>
            <td><%=rs.getString("address1")%></td>
            <td><%=rs.getString("address2")%></td>
            <td><%=rs.getString("instl_floor")%></td>
            <td><%=rs.getString("instl_type")%></td>
            <td><%=rs.getString("instl_mby")%></td>
            <td><%=rs.getString("svc_se")%></td>
            <td><%=rs.getString("cmcwr")%></td>
            <td><%=rs.getString("instl_year")%></td>
            <td><%=rs.getString("in_out")%></td>
            <td><%=rs.getString("remars3")%></td>
            <td><%=rs.getString("wifi_lat")%></td>
            <td><%=rs.getString("wifi_lnt")%></td>
            <td><%=rs.getString("work_date")%></td>
        </tr>
        <%
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (!rs.isClosed() && rs != null) {
                            rs.close();
                        }

                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    try {
                        if (!preparedStatement.isClosed() && preparedStatement != null) {
                            preparedStatement.close();
                        }
                    } catch (SQLException e) {
                        throw new RuntimeException(e);
                    }
                }
                dbService.closeConnection();
            } else {
        %>
                <%=" <tr class=\"empty_tr\">" +
                        "<td colspan=\"16\" class=\"empty_td\">위치 정보를 입력한 후에 조회해 주세요.</td> " +
                        "</tr> " %>
                    <%}%>
        </tbody>
    </table>
</div>




<%--<form>--%>
<form method="POST">
    <button type="submit" name="getDatabaseData" value="clicked">db 불러오기</button>
</form>
<form method="POST">
    <button type="submit" name="getApiData" value="clicked">Api 불러오기</button>
</form>

<%--</form>--%>
</body>

</html>