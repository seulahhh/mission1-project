package db;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@AllArgsConstructor
public class Info{
    private int list_total_count;
    private Result RESULT;
    private List<Row> row;
}
