package com.woniu.ssm.service;

import com.github.pagehelper.PageInfo;
import com.woniu.ssm.entity.Emp;

public interface IEmpService {


    PageInfo<Emp> findEmpByPage(int now, int size);


    int add(Emp emp) ;

    int modify(Emp emp) ;

    int remove(int id);

    Emp findEmpById(int id);

}
