package com.woniu.ssm.mapper;

import com.woniu.ssm.entity.Emp;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public interface EmpMapper {

    List<Emp> selectEmpsByPage();

    @Insert("insert into t_emp (ename,sex,jobDate,salary) values (#{ename},#{sex},#{jobDate},#{salary})")
    int insert(Emp emp);

    @Update("update t_emp set ename =#{ename},sex=#{sex},salary=#{salary},jobDate=#{jobDate} where empid = #{empid}")
    int update(Emp emp);

    @Delete("delete from t_emp where empid = #{id}")
    int delete(int id);

    @Select("select * from t_emp where empid = #{id}")
    Emp selectEmpById(int id);



}
