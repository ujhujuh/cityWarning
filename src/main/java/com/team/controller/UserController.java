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
import org.springframework.security.core.context.SecurityContext;
import javax.servlet.http.HttpSession;

import java.util.List;

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
        return userService.getList(currentPage,pageSize);
    }

    @RequestMapping("/getMyInfo")
    @ResponseBody
    public User getMyInfo(HttpSession session) {
        SecurityContext securityContext = (SecurityContext) session.getAttribute("SPRING_SECURITY_CONTEXT");
//        System.out.println(securityContext);
        String username = securityContext.getAuthentication().getName();
        User user = userService.findByUsername(username);
        user.setPassword(null);
        return user;
    }

    @RequestMapping("/isRegister")
    @ResponseBody
    public int isRegister(@RequestParam("username") String username) {
        User user = userService.findByUsername(username);
        if(user == null) {
            // 该用户可以添加
            return 1;
        } else {
            return 0;
        }
    }


}
