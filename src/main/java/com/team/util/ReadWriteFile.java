package com.team.util;

import java.io.*;

/**
 * Created by fantasy on 17-5-28.
 */
public class ReadWriteFile {
    public static String readFile(String path) throws Exception {
        File file = new File(path);
        InputStreamReader read = new InputStreamReader(
                new FileInputStream(file),"utf-8");//考虑到编码格式
        BufferedReader bufferedReader = new BufferedReader(read);
        String content = "";
        String lineTxt = null;
        while((lineTxt = bufferedReader.readLine()) != null){
            content += lineTxt + "\n";
        }
        read.close();
        return content;
    }

    public static void writeFile(String path, String content) throws Exception {
        File file = new File(path);
        if (file.exists()) {
            System.out.println("文件存在");
            return;
        } else {
            System.out.println("文件不存在");
            file.createNewFile();// 不存在则创建
        }
        BufferedWriter output = new BufferedWriter(new FileWriter(file));
        output.write(content);
        output.close();
    }

    public static void modifyFile(String path, String content) throws Exception {
        File file = new File(path);
        BufferedWriter output = new BufferedWriter(new FileWriter(file));
        output.write(content);
        output.close();
    }
}
