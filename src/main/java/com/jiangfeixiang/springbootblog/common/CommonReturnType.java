package com.jiangfeixiang.springbootblog.common;

/**
 * @Author: 姜飞祥
 * @Description: 封装结果集成统一的json样式
 * @Date: Create in 2018/9/15 12:08
 * @param: $params$
 * @return: $returns$
 */
public class CommonReturnType {
    /**
     * 返回编码，0成功，1失败
     */
    private Integer code;

    /**
     * 返回信息，success成功，fail失败
     */
    private String status;

    /**
     * 自定义信息
     */
    private String msg;

    /**
     * 返回的对象
     */
    private Object data;

    /**
     * 构造函数:成功并返回数据，返回信息，code
     * @param
     */
     private CommonReturnType(Integer code,String status,Object data) {
        this.status = status;
        this.code = code;
        this.data = data;
    }

    /**
     * 构造函数:失败并返回提示信息
     * @param status
     * @param code
     */
    public CommonReturnType(Integer code, String status){
        this.status=status;
        this.code=code;
    }

    /**
     * 构造函数:异常并返回异常信息
     * @param status
     * @param code
     */
    public CommonReturnType(Integer code, String status,String msg){
        this.status=status;
        this.code=code;
        this.msg=msg;
    }

    /**
     * 成功并返回的数据
     * @return
     */
    public static CommonReturnType success(Object data) {

        return new CommonReturnType(ResponseCode.SUCCESS.getCode(),ResponseCode.SUCCESS.getDesc(),data);
    }

    /**
     * 成功没有要返回的数据
     * @return
     */
    public static CommonReturnType success() {

        return new CommonReturnType(ResponseCode.SUCCESS.getCode(),ResponseCode.SUCCESS.getDesc());
    }

    /**
     * 失败
     * @return
     */
    public static CommonReturnType fail() {

        return new CommonReturnType(ResponseCode.ERROR.getCode(),ResponseCode.ERROR.getDesc());
    }

    /**
     * 异常
     * @return
     */
    public static CommonReturnType fail(String msg) {

        return new CommonReturnType(ResponseCode.ERROR.getCode(),ResponseCode.ERROR.getDesc(),msg);
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}
