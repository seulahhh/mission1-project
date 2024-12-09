package db;

import lombok.*;

import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@ToString
@NoArgsConstructor
public class Row{
    private String X_SWIFI_MGR_NO;
    private String X_SWIFI_WRDOFC;
    private String X_SWIFI_MAIN_NM;
    private String X_SWIFI_ADRES1;
    private String X_SWIFI_ADRES2;
    private String X_SWIFI_INSTL_FLOOR;
    private String X_SWIFI_INSTL_TY;
    private String X_SWIFI_INSTL_MBY;
    private String X_SWIFI_SVC_SE;
    private String X_SWIFI_CMCWR;
    private String X_SWIFI_CNSTC_YEAR;
    private String X_SWIFI_INOUT_DOOR;
    private String X_SWIFI_REMARS3;
    private double LAT;
    private double LNT;
    private String WORK_DTTM;
    private double distance;

//    @Override
//    public int compareTo(Row o) {
//        if (this.getDistance() > o.getDistance()) return 1;
//        return -1;
//    }
}
