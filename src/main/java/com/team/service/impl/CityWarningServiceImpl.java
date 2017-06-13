package com.team.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.team.dto.CityWarning;
import com.team.mapper.CityWarningMapper;
import com.team.service.CityWarningService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by fantasy on 17-5-28.
 */

@Service
public class CityWarningServiceImpl implements CityWarningService{

    Logger logger = LoggerFactory.getLogger(CityWarningServiceImpl.class);

    @Autowired
    private CityWarningMapper cityWarningMapper;

    public int insert(CityWarning cityWarning) {
        return cityWarningMapper.insertSelective(cityWarning);
    }

    public int delete(Integer id) {
        return cityWarningMapper.deleteByPrimaryKey(id);
    }

    public int update(CityWarning cityWarning) {
        return cityWarningMapper.updateByPrimaryKeySelective(cityWarning);
    }

    public CityWarning findById(Integer id) {
        return cityWarningMapper.selectByPrimaryKey(id);
    }

    public PageInfo getList(int currentPage, int pageSize) {
        PageHelper.startPage(currentPage, pageSize);
        List<CityWarning> list = cityWarningMapper.selectList();
        PageInfo pageInfo = new PageInfo(list);
        return pageInfo;
    }
}
