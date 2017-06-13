package com.team.service;

import com.github.pagehelper.PageInfo;
import com.team.dto.User;

/**
 * Created by fantasy on 17-5-28.
 */

public interface UserService {
    int insert(User user);

    int delete(Integer id);

    int update(User user);

    User findById(Integer id);

    PageInfo getList(int currentPage, int pageSize);

    User findByUsername(String username);
}
