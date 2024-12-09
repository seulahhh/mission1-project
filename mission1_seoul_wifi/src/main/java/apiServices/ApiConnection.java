//package apiServices;
//
//import java.io.BufferedReader;
//import java.io.IOException;
//import java.io.InputStream;
//import java.io.InputStreamReader;
//import java.net.MalformedURLException;
//import java.net.URL;
//import java.net.URLConnection;
//import java.util.ArrayList;
//import java.util.List;
////
////public class data.ApiConnection {
////    public String getUserInfo(String key) {
////        ResponseBody body = null;
////        Response response = null;
////
////        try {
////            String url = "http://openapi.seoul.go.kr:8088/444b62625970726935324753444b4a/json/TbPublicWifiInfo/1/2/" + key;
////
////            // OkHttp 클라이언트 객체 생성
////            OkHttpClient client = new OkHttpClient.Builder().connectTimeout(10, TimeUnit.SECONDS).readTimeout(30, TimeUnit.SECONDS).writeTimeout(30, TimeUnit.SECONDS).build();
////
////            // GET 요청 객체 생성
////            Request.Builder builder = new Request.Builder().url(url).get();
////            builder.addHeader("password", "BlahBlah");
////            Request request = builder.build();
////
////            // OkHttp 클라이언트로 GET 요청 객체 전송
////            response = client.newCall(request).execute();
////            if (response.isSuccessful()) {
////                // 응답 받아서 처리
////                body = response.body();
////                if (body != null) {
////                    Gson gson = new Gson();
////                    data.All all = gson.fromJson(body.string(), data.All.class);
////                    System.out.println(all.getTbPublicWifiInfo().getList_total_count());
////                    System.out.println(body.string());
////                    return all.getTbPublicWifiInfo().getRow().get(1).getX_SWIFI_ADRES2();
////                }
////
////            }
////
////        } catch(Exception e) {
////            System.out.println("dfdfdf");
////            e.printStackTrace();
////        } finally {
////            try {
////                System.out.println(";;jkj");
////                response.close();
////                if (body != null) {
////                    body.close();
////
////                }
////            }
////            catch (Exception e) {
////                e.printStackTrace();
////            }
////        }
////        System.out.println("122");
////        return null;
////    }
////
////}
//
//import com.google.gson.Gson;
//
//import db.All;
//import db.Row;
//
//public class ApiConnection {
//    public List<Row> getApiConnection() {
//        String urlstr = "http://openapi.seoul.go.kr:8088/444b62625970726935324753444b4a/json/TbPublicWifiInfo/1/30/";
//        URLConnection urlCon = null;
//        InputStream inputStream = null;
//        BufferedReader reader = null;
//
//        List<Row> totalRows = new ArrayList<>();
//        try {
//            URL url = new URL(urlstr);
//
//            try {
//                urlCon = url.openConnection();
//                inputStream = urlCon.getInputStream();
//                reader = new BufferedReader(new InputStreamReader(inputStream));
//
//                Gson gson = new Gson();
//                String text = reader.readLine();
//                All all = gson.fromJson(text, All.class);
//
//                int listTotalCount = all.getTbPublicWifiInfo().getList_total_count();
//                System.out.println(listTotalCount);
//
//            } catch (IOException e) {
//                e.printStackTrace();
//            }
//
//        } catch (MalformedURLException e) {
//            e.printStackTrace();
//        } finally {
//            try {
//                inputStream.close();
//                reader.close();
//
//            } catch (IOException e) {
//                e.printStackTrace();
//            }
//        }
//
//        return totalRows;
//    }
//}
