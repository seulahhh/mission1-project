<%@ page import="Services.dbService" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="Services.ApiService" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.SQLException" %>

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
<body>

<h1>위치 히스토리 목록</h1>

<div class="container menu_container">
    <div class="menus">
        <ul>
            <li><a href="${pageContext.request.contextPath}">홈</a></li>
            <li><a href="history.jsp">위치 히스토리 목록</a></li>
            <li><a href="load-wifi.jsp">Open API 와이파이 정보 가져오기</a></li>
        </ul>
    </div>
</div>
<div class="container table_container">
    <table id="wifi_history_table">
        <thead>
        <tr>
            <th>ID</th>
            <th>X좌표</th>
            <th>Y좌표</th>
            <th>조회일자</th>
            <th>비고</th>
        </tr>

        </thead>
        <tbody>
        <%
                String sql = " Select * from wifi_history ";

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
            <td><%=rs.getString("id")%></td>
            <td><%=rs.getDouble("wifi_lat")%></td>
            <td><%=rs.getString("wifi_lnt")%></td>
            <td><%=rs.getString("select_date")%></td>
            <td>
                <form method = "POST" action="history-delete-submit.jsp">
                    <input type="hidden" name="delete_history" value="<%=rs.getString("id")%>">
                    <button type="submit">삭제</button>
                </form>
            </td>
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
        %>
        </tbody>
    </table>
</div>


</body>
</html>