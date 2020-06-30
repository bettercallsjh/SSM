package com.woniu.ssm.entity;

import lombok.Data;
import lombok.ToString;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;


@Data
@ToString
public class Emp {
    private Integer empid ;
    private String ename ;
    private String sex ;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date jobDate ;
    private double salary ;
}
