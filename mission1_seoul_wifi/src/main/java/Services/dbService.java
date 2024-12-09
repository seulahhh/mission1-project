package Services;

import db.Row;

import java.sql.*;
import java.util.*;


public class dbService {
    private static Connection con = null;
    public Connection getDbConnection() {
        if (con == null) {
            try {
                Class.forName("org.sqlite.JDBC");
                con = DriverManager.getConnection("Jdbc:sqlite:" + this.getClass().getClassLoader().getResource("/seoul-wifi.sqlite3"));
//                con = DriverManager.getConnection("Jdbc:sqlite:./src/main/webapp/WEB-INF/classes");

                System.out.println(this.getClass().getResource("/"));

                System.out.println("아래는 새로운거");
                System.out.println("Jdbc:sqlite:" + this.getClass().getClassLoader().getResource("/seoul-wifi.sqlite3"));
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
                System.out.println("연결불가");
            }
        }

        return con;
    }

    // # connection객체와 query를 받아 db의 데이터를 ResultSet으로 가공하여 내보내기
    public ResultSet getDbData(Connection con, String sql) {
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;
        System.out.println("getDbData 메서드 시작");
        try {
            preparedStatement = con.prepareStatement(sql);
            rs = preparedStatement.executeQuery();
            System.out.println("rs 할당했음!");
            String html =
            " <td>" + rs.getString("distance") + "</td>" +
            " <td>" + rs.getString("mng_no") + "</td>" +
            " <td>" + rs.getString("wrdofc") + "</td>" +
            " <td>" + rs.getString("wifi_name") + "</td>" +
            " <td>" + rs.getString("address1") + "</td>" +
            " <td>" + rs.getString("address2") + "</td>" +
            " <td>" + rs.getString("instl_floor") + "</td>" +
            " <td>" + rs.getString("instl_type") + "</td>" +
            " <td>" + rs.getString("instl_mbu") + "</td>" +
            " <td>" + rs.getString("svc_se") + "</td>" +
            " <td>" + rs.getString("cmcwr") + "</td>" +
            " <td>" + rs.getString("instl_year") + "</td>" +
            " <td>" + rs.getString("in_out") + "</td>" +
            " <td>" + rs.getString("remars3") + "</td>" +
            " <td>" + rs.getString("wifi_lat") + "</td>" +
            " <td>" + rs.getString("wifi_lnt") + "</td>" +
            " <td>" + rs.getString("work_date") + "</td>";

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

        return rs;
    }

    // db에서 데이터 받아서 출력 : db데이터의 resultSet --> 출력
    // db에 데이터 업데이트 : sql을 가지고 업데이트할 정보 업데이트

    // # List<Row> 와 sql query를 입력받아서 원하는 정보를 데이터베이스에 넣음.
    // # getConnection으로 connection 받아오고, 원하는 정보를 해당 db에 삽입하면 된다.
    public void putDataToDb (Connection con, List<Row> rows) {
        PreparedStatement preparedStatement = null;
        resetTable(con, "seoul-wifi-data");
        try {

            for (int i = 0; i < rows.size(); i++) {


                String sql = " insert into \"seoul-wifi-data\" (mng_no, wrdofc, address1, address2, instl_floor, instl_type, instl_mby, svc_se, wifi_name, cmcwr, instl_year, in_out, remars3, wifi_lat, wifi_lnt, work_date)  values (?, ?, ?, ?, ?, ?, ?, ?, ? ,?, ?, ?, ?, ?, ?, ?) ";
                preparedStatement = con.prepareStatement(sql);
                preparedStatement.setString(1, rows.get(i).getX_SWIFI_MGR_NO());
                preparedStatement.setString(2, rows.get(i).getX_SWIFI_WRDOFC());
                preparedStatement.setString(3, rows.get(i).getX_SWIFI_ADRES1());
                preparedStatement.setString(4, rows.get(i).getX_SWIFI_ADRES2());
                preparedStatement.setString(5, rows.get(i).getX_SWIFI_INSTL_FLOOR());
                preparedStatement.setString(6, rows.get(i).getX_SWIFI_INSTL_TY());
                preparedStatement.setString(7, rows.get(i).getX_SWIFI_INSTL_MBY());
                preparedStatement.setString(8, rows.get(i).getX_SWIFI_SVC_SE());
                preparedStatement.setString(9, rows.get(i).getX_SWIFI_MAIN_NM());
                preparedStatement.setString(10, rows.get(i).getX_SWIFI_CMCWR());
                preparedStatement.setString(11, rows.get(i).getX_SWIFI_CNSTC_YEAR());
                preparedStatement.setString(12, rows.get(i).getX_SWIFI_INOUT_DOOR());
                preparedStatement.setString(13, rows.get(i).getX_SWIFI_REMARS3());
                preparedStatement.setDouble(14, rows.get(i).getLAT());
                preparedStatement.setDouble(15, rows.get(i).getLNT());
                preparedStatement.setString(16, rows.get(i).getWORK_DTTM());

                preparedStatement.executeUpdate();
                System.out.println("업데이트 완료!");
                System.out.println(con.getMetaData());
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public void resetTable(Connection con, String tableName) {
        PreparedStatement preparedStatement = null;
        try {
            String deletesql = " DELETE from \"seoul-wifi-data\" where mng_no is not null; ";
            preparedStatement = con.prepareStatement(deletesql);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public void closeConnection() {
        try {
            if (con != null && !con.isClosed()) {
                con.close();
                con = null;
            }
            System.out.println("connection 연결 해제 완료");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}