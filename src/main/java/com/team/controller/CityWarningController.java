package com.team.controller;

import com.github.pagehelper.PageInfo;
import com.team.dto.CityWarning;
import com.team.service.CityWarningService;
import org.json.JSONML;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
        PageInfo pageInfo =  cityWarningService.getList(currentPage, pageSize);
        return pageInfo;
    }

    @RequestMapping("/listCity")
    @ResponseBody
    public List<CityWarning> listCity(){
        List<CityWarning> list = cityWarningService.getCityList();
        System.out.println(list);
        return list;
    }

    @RequestMapping("/findCity")
    @ResponseBody
    public Map findCity(@RequestBody CityWarning cityWarning){
        List<CityWarning> list = cityWarningService.findCity(cityWarning.getCity());
        List<String> time = new ArrayList<String>();
        List<Integer> aqi =  new ArrayList<Integer>();
        List<Double> co =  new ArrayList<Double>();
        List<Integer> pm2 =  new ArrayList<Integer>();
        List<Integer> pm10 =  new ArrayList<Integer>();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        for(int i=0;i<list.size();i++){
            time.add(formatter.format(list.get(i).getCreateTime()));
            aqi.add(list.get(i).getAqi());
            co.add(list.get(i).getCo());
            pm2.add(list.get(i).getPm2());
            pm10.add(list.get(i).getPm10());
        }
        Map map = new HashMap();
        map.put("time",time);
        map.put("aqi",aqi);
        map.put("co",co);
        map.put("pm2",pm2);
        map.put("pm10",pm10);
        return map;
    }

}
