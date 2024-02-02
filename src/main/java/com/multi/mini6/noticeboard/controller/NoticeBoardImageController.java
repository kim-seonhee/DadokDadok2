package com.multi.mini6.noticeboard.controller;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@RestController
public class NoticeBoardImageController {

    private static final String UPLOAD_DIR = "C:" + File.separator + "upload_data" + File.separator + "temp";

    @GetMapping("/upload_data/temp/{filename:.+}")
    public ResponseEntity<Resource> getImage(@PathVariable String filename) throws IOException {
        String filePath = UPLOAD_DIR + File.separator + filename;
        Path imagePath = Paths.get(filePath);

        if (!Files.exists(imagePath)) {
            try {
                Files.createDirectories(imagePath.getParent());
            } catch (IOException e) {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
            }
        }

        if (Files.exists(imagePath) && Files.isReadable(imagePath)) {
            MediaType mediaType = MediaType.IMAGE_JPEG;
            if (filename.toLowerCase().endsWith(".png")) {
                mediaType = MediaType.IMAGE_PNG;
            }

            Resource fileResource = new FileSystemResource(imagePath.toFile());
            return ResponseEntity.ok().contentType(mediaType).body(fileResource);
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}

