package com.team.util;

/**
 * Created by fantasy on 17-5-29.
 */
public class Util {

    // 将tableNames数组全部转为驼峰式命名
    public static String[] transformName(String[] tableNames) {
        String tables = "";
        for (int i = 0; i < tableNames.length; i++) {
            tables += camelName(tableNames[i]) + ",";
        }
        tables = tables.substring(0, tables.length() - 1);
        return tables.split(",");
    }

    // 将下划线大写方式命名的字符串转换为驼峰式
    public static String camelName(String name) {
        StringBuilder result = new StringBuilder();
        // 快速检查
        if (name == null) {
            // 没必要转换
            return "";
        } else if (!name.contains("_")) {
            // 不含下划线，仅将首字母小写
            return name.substring(0, 1).toUpperCase() + name.substring(1);
        }
        // 用下划线将原始字符串分割
        String camels[] = name.split("_");
        for (String camel :  camels) {
            // 跳过原始字符串中开头、结尾的下换线或双重下划线
            if (camel == "") {
                continue;
            }
            // 处理真正的驼峰片段
            if (result.length() == 0) {
                // 第一个驼峰片段，全部字母都小写
                result.append(camel.toLowerCase());
            } else {
                // 其他的驼峰片段，首字母大写
                result.append(camel.substring(0, 1).toUpperCase());
                result.append(camel.substring(1).toLowerCase());
            }
        }
        String name2 = result.toString();
        return name2.substring(0, 1).toUpperCase() + name2.substring(1);
    }
}
