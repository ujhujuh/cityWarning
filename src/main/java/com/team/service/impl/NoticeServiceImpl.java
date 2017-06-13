package com.team.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.team.dto.Notice;
import com.team.mapper.NoticeMapper;
import com.team.service.NoticeService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by fantasy on 17-5-28.
 */

@Service
public class NoticeServiceImpl implements NoticeService{

    Logger logger = LoggerFactory.getLogger(NoticeServiceImpl.class);

    @Autowired
    private NoticeMapper noticeMapper;

    public int insert(Notice notice) {
        return noticeMapper.insertSelective(notice);
    }

    public int delete(Integer id) {
        return noticeMapper.deleteByPrimaryKey(id);
    }

    public int update(Notice notice) {
        return noticeMapper.updateByPrimaryKeySelective(notice);
    }

    public Notice findById(Integer id) {
        return noticeMapper.selectByPrimaryKey(id);
    }

    public PageInfo getList(int currentPage, int pageSize) {
        PageHelper.startPage(currentPage, pageSize);
        List<Notice> list = noticeMapper.selectList();
        PageInfo pageInfo = new PageInfo(list);
        return pageInfo;
    }
}
