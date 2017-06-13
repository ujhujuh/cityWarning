package com.team.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.team.dto.User;
import com.team.mapper.UserMapper;
import com.team.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by fantasy on 17-5-28.
 */

@Service
public class UserServiceImpl implements UserService{

    Logger logger = LoggerFactory.getLogger(UserServiceImpl.class);

    @Autowired
    private UserMapper userMapper;

    public int insert(User user) {
        return userMapper.insertSelective(user);
    }

    public int delete(Integer id) {
        return userMapper.deleteByPrimaryKey(id);
    }

    public int update(User user) {
        return userMapper.updateByPrimaryKeySelective(user);
    }

    public User findById(Integer id) {
        return userMapper.selectByPrimaryKey(id);
    }

    public PageInfo getList(int currentPage, int pageSize) {
        PageHelper.startPage(currentPage, pageSize);
        List<User> list = userMapper.selectList();
        PageInfo pageInfo = new PageInfo(list);
        return pageInfo;
    }

    public User findByUsername(String username) {
        return userMapper.selectByUsername(username);
    }
}
