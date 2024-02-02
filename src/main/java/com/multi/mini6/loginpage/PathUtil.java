package com.multi.mini6.loginpage;

import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

public class PathUtil {

    // 이 메소드는 파일 업로드를 위한 기본 폴더 경로를 반환합니다.
    private static String getStaticFolder() {
        // `user.dir`는 애플리케이션을 실행하는 현재 작업 디렉토리를 반환합니다.
        // 여기서는 'upload-dir'이라는 하위 폴더를 기본 업로드 폴더로 사용합니다.
        // File.separator는 운영체제에 맞는 디렉토리 구분자를 사용합니다 (예: Windows에서는 '\', UNIX 계열에서는 '/').
        return System.getProperty("user.dir") + File.separator + "upload-dir" + File.separator;
    }

    // 이 메소드는 프로필 이미지를 서버에 저장하고, 저장된 파일의 경로를 문자열로 반환합니다.
    public static String writeImageFile(MultipartFile profileImg, String email) throws IOException {
        // 사용자 이메일을 기반으로 개별 사용자의 업로드 폴더 경로를 생성합니다.
        String uploadDir = getStaticFolder() + email;
        // Path 객체를 사용하여 파일 시스템의 경로를 나타냅니다.
        Path uploadPath = Paths.get(uploadDir);

        // 만약 해당 경로의 디렉토리가 존재하지 않는 경우 새로운 디렉토리를 생성합니다.
        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }

        // 파일명을 UUID를 사용하여 고유하게 만들고 원본 파일명을 추가합니다.
        // 이렇게 하면 파일명 충돌을 방지할 수 있습니다.
        String fileName = UUID.randomUUID() + "_" + profileImg.getOriginalFilename();
        // 최종 파일 경로를 생성합니다.
        Path filePath = uploadPath.resolve(fileName);

        // MultipartFile의 InputStream에서 데이터를 읽어와서 filePath에 지정된 경로에 파일을 저장합니다.
        // StandardCopyOption.REPLACE_EXISTING 옵션을 사용하여 이미 파일이 존재하는 경우 덮어쓰기를 수행합니다.
        Files.copy(profileImg.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

        // 저장된 파일의 전체 경로를 문자열로 반환합니다.
        return filePath.toString();
    }
}
