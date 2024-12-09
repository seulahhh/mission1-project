package view;

import java.sql.ResultSet;
import java.sql.SQLException;

public class InfoView {
    public String printListTotalCount(ResultSet rs) {
        String str = "데이터를 찾을 수 없습니다.";
        try {
            while (rs.next()) {
                String wifi_name = rs.getString("name");
                str = wifi_name;
            }
            // 거리를
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return str;
    }

}
