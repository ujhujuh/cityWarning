package com.team.service;

import com.github.pagehelper.PageInfo;
import com.team.dto.Notice;

/**
 * Created by fantasy on 17-5-28.
 */

public interface NoticeService {
    int insert(Notice notice);

    int delete(Integer id);

    int update(Notice notice);

    Notice findById(Integer id);

    PageInfo getList(int currentPage, int pageSize);
}
