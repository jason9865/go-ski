package com.go.ski.common.constant;

public enum FileUploadPath {

    USER_PROFILE_PATH("user-profile"),
    TEAM_PROFILE_PATH("team-profile"),
    TEAM_IMAGE_PATH("team-image"),
    FEEDBACK_IMAGE_PATH("feedback/images"),
    FEEDBACK_VIDEO_PATH("feedback/videos"),
    NOTIFICATION_IMAGE_PATH("notification");

    public final String path;

    FileUploadPath(String path) {
        this.path = path;
    }

}
