package com.team.service;

import com.github.pagehelper.PageInfo;
import com.team.dto.CityWarning;

import java.util.List;

/**
 * Created by fantasy on 17-5-28.
 */

public interface CityWarningService {
    int insert(CityWarning cityWarning);

    int delete(Integer id);

    int update(CityWarning cityWarning);

    CityWarning findById(Integer id);

    PageInfo getList(int currentPage, int pageSize);

    List<CityWarning> getCityList();
    List<CityWarning> findCity(String city);
}
