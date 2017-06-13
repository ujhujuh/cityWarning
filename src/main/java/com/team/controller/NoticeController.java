package com.team.controller;

import com.github.pagehelper.PageInfo;
import com.team.dto.Notice;
import com.team.service.NoticeService;
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
@RequestMapping("/notice")
@Controller
public class NoticeController {

    Logger logger = LoggerFactory.getLogger(NoticeController.class);

    @Autowired
    private NoticeService noticeService;

    @RequestMapping("/insert")
    @ResponseBody
    public int insert(@RequestBody Notice notice) {
        return noticeService.insert(notice);
    }

    @RequestMapping("/delete")
    @ResponseBody
    public int delete(@RequestParam("id") Integer id) {
        return noticeService.delete(id);
    }

    @RequestMapping("/update")
    @ResponseBody
    public int update(@RequestBody Notice notice) {
        return noticeService.update(notice);
    }

    @RequestMapping("/find")
    @ResponseBody
    public Notice find(@RequestParam("id") Integer id) {
        return noticeService.findById(id);
    }

    @RequestMapping("/list")
    @ResponseBody
    public PageInfo list(@RequestParam("currentPage")int currentPage, @RequestParam("pageSize")int pageSize){
        return noticeService.getList(currentPage, pageSize);
    }

}
