<%@ page import="Services.dbService" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/style.css"/>
    <title>와이파이 정보 구하기</title>
</head>
<body>

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

            <button type="submit">내 위치 가져오기</button>
            <button type="submit" name="getWifiInfo" value="clicked">근처 WIFI 정보 보기</button>
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
        <tbody>
<%--        <tr class="empty_tr">--%>
<%--            <td colspan="16" class="empty_td">위치 정보를 입력한 후에 조회해 주세요.</td>--%>
<%--        </tr>--%>
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
                            e.printStackTrace();
                        }
                    }
                    dbService.closeConnection();
                }
            %>
        </tbody>
    </table>
</div>


</body>
</html>