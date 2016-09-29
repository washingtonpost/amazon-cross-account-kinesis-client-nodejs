package com.washingtonpost.aws.auth;

import com.amazonaws.auth.AWSCredentials;

/**
 * Created by findleyr on 9/29/16.
 */
public class STSAssumeRoleSessionCredentialsProvider extends com.amazonaws.auth.STSAssumeRoleSessionCredentialsProvider {
    public STSAssumeRoleSessionCredentialsProvider() {
        super(new AWSCredentials() {
            public String getAWSAccessKeyId() {
                return System.getenv("AWS_ACCESS_KEY_ID");
            }

            public String getAWSSecretKey() {
                return System.getenv("AWS_SECRET_ACCESS_KEY");
            }
        }, System.getenv("AWS_ROLE_ARN"), System.getenv("AWS_ROLE_SESSION_NAME"));
    }
}