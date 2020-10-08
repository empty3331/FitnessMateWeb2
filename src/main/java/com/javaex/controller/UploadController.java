package com.javaex.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.UUID;

@Controller
@RequestMapping("/upload")
public class UploadController {

    @Resource(name="uploadPath")
    private String uploadPath;

    @ResponseBody
    @RequestMapping("/image")
    public String imageUpload(MultipartFile file) {
        String saveName = "";
        
        if(!file.isEmpty()) { //파일을 첨부했을 때만

            //저장 경로
            String saveDir = uploadPath;

            //파일 이름
            String orgName = file.getOriginalFilename();

            //파일 확장자
            String exName = orgName.substring(orgName.lastIndexOf("."));

            //저장파일 이름
            saveName = System.currentTimeMillis() + UUID.randomUUID().toString() + exName;

            //파일경로
            String filePath = saveDir + "/" + saveName;

            //파일 서버에 복사
            try {
                byte[] fileData = file.getBytes();
                OutputStream out = new FileOutputStream(filePath);
                BufferedOutputStream bufferedOut = new BufferedOutputStream(out);

                bufferedOut.write(fileData);
                bufferedOut.close();

            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return saveName;
    }
}
