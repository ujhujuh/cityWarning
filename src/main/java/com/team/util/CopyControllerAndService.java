package com.team.util;

import java.io.File;

/**
 * Created by fantasy on 17-5-28.
 */
public class CopyControllerAndService {
    public static void run(String[] entities) throws Exception {
        System.out.println("正在创建controller, service, serviceImpl");
        String teamPath = "./src/main/java/com/team/";

        String exampleContent1 = ReadWriteFile.readFile(teamPath + "util/ExampleController.txt");
        String exampleContent2 = ReadWriteFile.readFile(teamPath + "util/ExampleService.txt");
        String exampleContent3 = ReadWriteFile.readFile(teamPath + "util/ExampleServiceImpl.txt");
        String[] exampleContents = {exampleContent1, exampleContent2, exampleContent3};

        // 判断是否存在controller, service, service.impl文件夹，若不存在，则创建
        String[] dirs = {"controller", "service/impl"};
        for (int i=0; i<dirs.length; i++) {
            File file = new File(teamPath + dirs[i]);
            if (!file.exists()) {
                file.mkdirs();
            }
        }
        // copy controller and service to packages
        copy(exampleContents, entities, teamPath);
        System.out.println("创建成功");
    }

    public static void copy(String[] exampleContents, String[] entities, String teamPath) throws Exception {

        // exampleContents
        for (int i = 0; i < entities.length; i++) {
            // controller
            String controllerContent = exampleContents[0].replaceAll("example", firstToLower(entities[i])).replaceAll("Example", entities[i]);
            ReadWriteFile.writeFile(teamPath + "controller/" +  entities[i] + "Controller.java", controllerContent);
            // service
            String serviceContent = exampleContents[1].replaceAll("example", firstToLower(entities[i])).replaceAll("Example", entities[i]);
            ReadWriteFile.writeFile(teamPath + "service/" +  entities[i] + "Service.java", serviceContent);
            // serviceImpl
            String serviceImplContent = exampleContents[2].replaceAll("example", firstToLower(entities[i])).replaceAll("Example", entities[i]);
            ReadWriteFile.writeFile(teamPath + "service/impl/" +  entities[i] + "ServiceImpl.java", serviceImplContent);
        }
    }
    //首字母小写
    public static String firstToLower(String name) {
        name = name.substring(0, 1).toLowerCase() + name.substring(1);
        return  name;
    }
}
