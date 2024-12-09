package apiServices;

//api 데이터를 db에 넣기
public class ApiDataService {
//    public void putDataToDb(List<Row> rows, Connection connection) {
//
//        PreparedStatement preparedStatement = null;
//
//
//        try {
//            for (int i = 0; i < rows.size(); i++) {
//                String sql = " insert into testTable (id, name) values (?, ?)";
//                preparedStatement = connection.prepareStatement(sql);
//                preparedStatement.setString(1, rows.get(i).getX_SWIFI_MGR_NO());
//                preparedStatement.setString(2, rows.get(i).getLNT());
//                preparedStatement.executeUpdate();
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        } finally {
//            try {
//                if (preparedStatement != null && !preparedStatement.isClosed()) {
//                    preparedStatement.close();
//                }
//            } catch (SQLException e) {
//                e.printStackTrace();
//            }
//
//            try {
//                if (connection != null && !connection.isClosed()) {
//                    connection.close();
//                }
//            } catch (SQLException e) {
//                e.printStackTrace();
//            }
//        }
//    }
}
