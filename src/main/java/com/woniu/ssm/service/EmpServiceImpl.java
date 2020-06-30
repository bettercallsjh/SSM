package com.woniu.ssm.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.woniu.ssm.entity.Emp;
import com.woniu.ssm.mapper.EmpMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


/**
 * @author T430s1
 */
@Service
public class EmpServiceImpl implements IEmpService {

    @Autowired
    EmpMapper empMapper ;

    @Override
    public PageInfo<Emp> findEmpByPage(int now, int size) {

        PageHelper.startPage(now,size);
        List<Emp> list = empMapper.selectEmpsByPage();

        PageInfo<Emp> pageInfo = new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    @Transactional
    public int add(Emp emp) {
        return empMapper.insert(emp);
    }

    @Override
    @Transactional
    public int modify(Emp emp) {
        return empMapper.update(emp);
    }

    @Override
    @Transactional
    public int remove(int id) {
        return empMapper.delete(id);
    }

    @Override
    public Emp findEmpById(int id) {
        return empMapper.selectEmpById(id);
    }
}
