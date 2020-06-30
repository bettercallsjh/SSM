package com.woniu.ssm.controller;

import com.github.pagehelper.PageInfo;
import com.woniu.ssm.entity.Emp;
import com.woniu.ssm.service.IEmpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequestMapping("/empAjax")
public class EmpAjaxController {

    @Autowired
    IEmpService empService ;


    @RequestMapping("/list")
    @ResponseBody
    public PageInfo<Emp> list(Integer now , Integer size){
        now = now == null?1:now ;
        size = size == null?5:size ;

        PageInfo<Emp> emps = empService.findEmpByPage(now,size);

        return emps;
    }

    @RequestMapping("/add")
    @ResponseBody
    public Emp add(Emp emp) {
        empService.add(emp);
        return  emp;
    }

    @RequestMapping("/findEmp/{id}")
    @ResponseBody
    public Emp showEmp(@PathVariable("id") int id) {
        Emp emp = empService.findEmpById(id);
        return emp ;
    }

    @RequestMapping("/modify")
    @ResponseBody
    public int modify(Emp emp) {

        empService.modify(emp);

        return 1 ;
    }

    @RequestMapping("/del/{id}")
    @ResponseBody
    public int del(@PathVariable("id") int id) {

        empService.remove(id);
        return 1 ;
    }


}
