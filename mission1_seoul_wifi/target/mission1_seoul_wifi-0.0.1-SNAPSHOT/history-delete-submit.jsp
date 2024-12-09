<%@ page import="Services.dbService" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.PreparedStatement" %>

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
<%
    // history 삭제 버튼 처리
    String alertMsg = null;
    if (request.getParameter("delete_history") != null) {
        dbService dbService = new dbService();
        Connection con = dbService.getDbConnection();
        PreparedStatement preparedStatement = null;
        String sql = " delete from wifi_history where id = " + request.getParameter("delete_history");
        try {
            preparedStatement = con.prepareStatement(sql);
            preparedStatement.executeUpdate();
            boolean result = true;
            alertMsg = result ? "히스토리 삭제가 완료되었습니다." : "히스토리 삭제에 실패하였습니다.";
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (!preparedStatement.isClosed() && preparedStatement != null) {
                    preparedStatement.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
<script>
    alert('<%=alertMsg%>')
    window.location.href = "history.jsp"; // 처리 후 돌아갈 페이지
</script>
</body>
</html>