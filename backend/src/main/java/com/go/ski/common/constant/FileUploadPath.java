package com.go.ski.common.constant;

public enum FileUploadPath {

    USER_PROFILE_PATH("user-profile"),
    TEAM_PROFILE_PATH("team-profile");



    public String path;

    FileUploadPath(String path) {
        this.path = path;
    }

}
