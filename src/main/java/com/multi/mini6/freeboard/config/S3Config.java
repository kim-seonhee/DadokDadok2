package com.multi.mini6.freeboard.config;

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

@Slf4j
@Configuration
@PropertySource("classpath:application.properties")
public class S3Config {

  @Value("${accessKey}")
  private String accessKey;

  @Value("${secretKey}")
  private String secretKey;

  @Value("${bucketName}")
  private String bucketName;  // 추가: S3 버킷 이름을 가져오기 위한 프로퍼티

  @Bean
  public BasicAWSCredentials AwsCredentials() {
      BasicAWSCredentials AwsCreds = new BasicAWSCredentials(accessKey, secretKey);
    return AwsCreds;
  }

  @Bean
  public AmazonS3 AwsS3Client() {
    AmazonS3 s3Builder = AmazonS3ClientBuilder.standard()
            .withRegion(Regions.AP_NORTHEAST_2)
            .withCredentials(new AWSStaticCredentialsProvider(this.AwsCredentials()))
            .build();

    return s3Builder;
  }

}


















