package com.team.util;

/**
 * Created by fantasy on 17-5-30.
 */
public class autoCreate {
    public static void main(String[] args) throws Exception{
        /*
            所有表名：ashes_settlement,business,car,cinerary_stand,cremation_furnace,
            dead,driver,eulogy,farewell_hall,funeral_goods,invoice,
            mourning_hall,refrigerated,registration,supplier,user
        */
        // create dto, mapper, xml
        String[] tableNames = {"user", "city_warning", "notice"};
        RunMyBatisGenerator.run(tableNames);

        // create controller, service, serviceImpl
        String[] tables = Util.transformName(tableNames);
        CopyControllerAndService.run(tables);
    }
}
