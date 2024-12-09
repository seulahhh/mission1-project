package Services;

import com.google.gson.Gson;
import db.All;
import db.Row;
import lombok.Getter;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.List;

@Getter
public class ApiService {
    private int listTotalCount;
    public double getDistance(double lat1, double lon1, double lat2, double lon2) {
        double theta = lon1 - lon2;
        double dist = Math.sin(deg2rad(lat1)) * Math.sin(deg2rad(lat2)) + Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * Math.cos(deg2rad(theta));
        dist = Math.acos(dist);
        dist = rad2deg(dist);
        dist = dist * 60 * 1.1515 * 1609.344;
        return Math.round(dist/1000.0 * 10000.0) / 10000.0; //단위 meter
    }

    //10진수를 radian(라디안)으로 변환
    private static double deg2rad(double deg) {
        return (deg * Math.PI / 180.0);
    }

    //radian(라디안)을 10진수로 변환
    private static double rad2deg(double rad) {
        return (rad * 180 / Math.PI);
    }


    public List<Row> getApiDataRows(String urlStr) {
        URLConnection urlCon = null;
        InputStream inputStream = null;
        BufferedReader reader = null;
        List<Row> totalRows = new ArrayList<>();

        try {
            int loadStartN = 1;
            int loadEndN = 1000;

            URL url = new URL(urlStr + loadStartN + '/' + loadEndN + '/');
            do{
                urlCon = url.openConnection();
                inputStream = urlCon.getInputStream();
                reader = new BufferedReader(new InputStreamReader(inputStream));
                Gson gson = new Gson();
                String text = reader.readLine();
                All all = gson.fromJson(text, All.class);
                totalRows.addAll(all.getTbPublicWifiInfo().getRow());
                listTotalCount = all.getTbPublicWifiInfo().getList_total_count();

                if (loadEndN == listTotalCount) {
                    break;
                }
                loadStartN += 1000;
                loadEndN += 1000;
                if (loadEndN >= listTotalCount) {
                    loadEndN = listTotalCount;
                }
            } while (true);

            System.out.println("totalRows.size() = " + totalRows.size());
            System.out.println("loadEndN = " + loadEndN);
            // ================ api 데이터를 List<Row>로 저장후 내보내기

        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (reader != null) {
                try {
                    reader.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (inputStream != null) {
                try {
                    inputStream.close();

                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            System.out.println("총 row는 ? api Servie 내부 호출 : " + totalRows.size());
        }
        return totalRows;
    }

    public void setRowDistance(Row row, double[] location) {
        double distance = getDistance(location[0], location[1], (double) row.getLAT(), (double) row.getLNT());
        row.setDistance(distance);
    }




}
