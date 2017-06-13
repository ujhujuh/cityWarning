package com.team.util;

import org.mybatis.generator.api.MyBatisGenerator;
import org.mybatis.generator.config.Configuration;
import org.mybatis.generator.config.xml.ConfigurationParser;
import org.mybatis.generator.internal.DefaultShellCallback;
import org.slf4j.Logger;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by fantasy on 17-5-28.
 */
public class RunMyBatisGenerator {

    static Logger logger = org.slf4j.LoggerFactory.getLogger(RunMyBatisGenerator.class);

    public static void run(String[] tableNames) throws Exception {
        logger.info("正在创建dto, mapper, xml");
        String configPath = "./src/main/resources/generatorConfig.xml";
        // modify tableName
        for (int i = 0; i < tableNames.length; i++) {
            String content = ReadWriteFile.readFile(configPath);
            content = content.replaceAll("tableName=\"[\\w\\_]+\"", "tableName=\"" + tableNames[i] + "\"");
            ReadWriteFile.modifyFile(configPath, content);

            List<String> warnings = new ArrayList<String>();
            boolean overwrite = true;
            File configFile = new File(configPath);

            ConfigurationParser cp = new ConfigurationParser(warnings);
            Configuration config = cp.parseConfiguration(configFile);
            DefaultShellCallback callback = new DefaultShellCallback(overwrite);
            MyBatisGenerator myBatisGenerator = new MyBatisGenerator(config, callback, warnings);
            myBatisGenerator.generate(null);
        }
        logger.info("生成Mybatis配置成功！");
        updateMapper(tableNames);
    }

    private static void updateMapper(String[] tableNames) throws Exception {
        logger.info("正在更新mapper");
        String mapperPath = "./src/main/java/com/team/mapper/";
        for (String tableName : tableNames) {
            String tableDto = Util.camelName(tableName);
            // 修改mapper.java文件
            String content = ReadWriteFile.readFile(mapperPath + tableDto + "Mapper.java");
            content = content.replace("package com.team.mapper;",
                    "package com.team.mapper;\n" +
                    "\n" +
                    "import java.util.List;");
            content = content.replace("}",
                    "\n" +
                    "    List<" + tableDto + "> selectList();\n" +
                    "}");
            ReadWriteFile.modifyFile(mapperPath + tableDto + "Mapper.java", content);

            //修改mapper.xml文件
            String content2 = ReadWriteFile.readFile(mapperPath + tableDto + "Mapper.xml");
            content2 = content2.replace("</mapper>",
                    "  <select id=\"selectList\" resultMap=\"BaseResultMap\">\n" +
                    "    select\n" +
                    "    <include refid=\"Base_Column_List\" />\n" +
                    "    from " + tableName + "\n" +
                    "  </select>\n" +
                    "</mapper>");
            ReadWriteFile.modifyFile(mapperPath + tableDto + "Mapper.xml", content2);
        }
        logger.info("mapper更新成功！");
    }
}
