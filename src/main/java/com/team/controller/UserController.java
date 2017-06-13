package com.team.controller;

import com.github.pagehelper.PageInfo;
import com.team.dto.User;
import com.team.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by fantasy on 17-5-28.
 */
@RequestMapping("/user")
@Controller
public class UserController {

    Logger logger = LoggerFactory.getLogger(UserController.class);

    @Autowired
    private UserService userService;

    @RequestMapping("/insert")
    @ResponseBody
    public int insert(@RequestBody User user) {
        return userService.insert(user);
    }

    @RequestMapping("/delete")
    @ResponseBody
    public int delete(@RequestParam("id") Integer id) {
        return userService.delete(id);
    }

    @RequestMapping("/update")
    @ResponseBody
    public int update(@RequestBody User user) {
        return userService.update(user);
    }

    @RequestMapping("/find")
    @ResponseBody
    public User find(@RequestParam("id") Integer id) {
        return userService.findById(id);
    }

    @RequestMapping("/list")
    @ResponseBody
    public PageInfo list(@RequestParam("currentPage")int currentPage, @RequestParam("pageSize")int pageSize){
        return userService.getList(currentPage, pageSize);
    }

}
