package com.jiangfeixiang.springbootblog.common;

/**
 * @Author: 姜飞祥
 * @Description:
 * @Date: Create in 2018/10/11 22:13
 * @param: $params$
 * @return: $returns$
 */
public enum ResponseCode {
    /**
     * 返回成功
     */
    SUCCESS(0, "SUCCESS"),
    /**
     * 返回失败
     */
    ERROR(1, "ERROR");

    private final int code;
    private final String desc;

    ResponseCode(int code, String desc) {
        this.code = code;
        this.desc = desc;
    }

    public int getCode() {
        return code;
    }

    public String getDesc() {
        return desc;
    }
}
