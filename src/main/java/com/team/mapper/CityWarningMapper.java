package com.team.mapper;

import java.util.List;

import com.team.dto.CityWarning;

public interface CityWarningMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(CityWarning record);

    int insertSelective(CityWarning record);

    CityWarning selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(CityWarning record);

    int updateByPrimaryKey(CityWarning record);

    List<CityWarning> selectList();
}
