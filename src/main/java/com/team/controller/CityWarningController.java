package com.team.controller;

import com.github.pagehelper.PageInfo;
import com.team.dto.CityWarning;
import com.team.service.CityWarningService;
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
@RequestMapping("/cityWarning")
@Controller
public class CityWarningController {

    Logger logger = LoggerFactory.getLogger(CityWarningController.class);

    @Autowired
    private CityWarningService cityWarningService;

    @RequestMapping("/insert")
    @ResponseBody
    public int insert(@RequestBody CityWarning cityWarning) {
        return cityWarningService.insert(cityWarning);
    }

    @RequestMapping("/delete")
    @ResponseBody
    public int delete(@RequestParam("id") Integer id) {
        return cityWarningService.delete(id);
    }

    @RequestMapping("/update")
    @ResponseBody
    public int update(@RequestBody CityWarning cityWarning) {
        return cityWarningService.update(cityWarning);
    }

    @RequestMapping("/find")
    @ResponseBody
    public CityWarning find(@RequestParam("id") Integer id) {
        return cityWarningService.findById(id);
    }

    @RequestMapping("/list")
    @ResponseBody
    public PageInfo list(@RequestParam("currentPage")int currentPage, @RequestParam("pageSize")int pageSize){
        return cityWarningService.getList(currentPage, pageSize);
    }

}
