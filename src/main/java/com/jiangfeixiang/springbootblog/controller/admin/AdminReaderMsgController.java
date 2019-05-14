package com.jiangfeixiang.springbootblog.controller.admin;

import com.alibaba.excel.ExcelWriter;
import com.alibaba.excel.metadata.Sheet;
import com.alibaba.excel.support.ExcelTypeEnum;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jiangfeixiang.springbootblog.common.CommonReturnType;
import com.jiangfeixiang.springbootblog.entity.ReaderMassageDo;
import com.jiangfeixiang.springbootblog.service.ReaderMsgService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.swing.filechooser.FileSystemView;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * @ProjectName: springboot-blog
 * @Package: com.jiangfeixiang.springbootblog.controller.admin
 * @ClassName: AdminReaderMsgController
 * @Author: jiangfeixiang
 * @email: 1016767658@qq.com
 * @Description: 后端留言板controller
 * @Date: 2019/5/9/0009 13:45
 */
@Controller
@RequestMapping("/admin")
public class AdminReaderMsgController {

    @Autowired
    private ReaderMsgService readerMsgService;


    /**
     * 获取所有留言
     * @param pageNum
     * @param pageSize
     * @return
     */
    @RequestMapping(value = "/getAllMsg",method = RequestMethod.GET)
    @ResponseBody
    public CommonReturnType getAllMsg(@RequestParam(value = "pageNum",defaultValue = "1") int pageNum,
                                      @RequestParam(value = "pageSize",defaultValue = "5") int pageSize) {

        PageHelper.startPage(pageNum, pageSize);
        List<ReaderMassageDo> allMsg = readerMsgService.getAllMsg();
        PageInfo<ReaderMassageDo> pageInfo=new PageInfo<>(allMsg);
        return CommonReturnType.success(pageInfo);

    }

    /**
     * 根据id查询留言信息内容
     * @param id
     * @return
     */
    @RequestMapping(value = "/selectByMsgId",method = RequestMethod.GET)
    @ResponseBody
    public CommonReturnType selectByPrimaryKey(Integer id) {
        ReaderMassageDo readerMassageDo = readerMsgService.selectByPrimaryKey(id);
        if (readerMassageDo !=null) {
            return CommonReturnType.success(readerMassageDo);
        }
        return CommonReturnType.fail();
    }


    /**
     * 导出至Excel表
     */
    @RequestMapping(value = "/excelOut",method = RequestMethod.GET)
    @ResponseBody
    public CommonReturnType excelOut(){
        // 文件输出位置
        OutputStream out = null;
        try {
            //获取桌面路径，然后把文件输出在桌面
            File desktop = FileSystemView.getFileSystemView().getHomeDirectory();
            //创建时间
            String format = new SimpleDateFormat("yyyy-MM-dd ss").format( new Date( ));
            //随机码
            UUID uuid = UUID.randomUUID();
            //根据时间，在桌面创建文件
            File path = new File(desktop+"\\"+format+uuid+".xlsx");
            //输出文件
            out = new FileOutputStream(path);
            ExcelWriter writer = new ExcelWriter(out, ExcelTypeEnum.XLSX);
            // 写仅有一个 Sheet 的 Excel 文件, 此场景较为通用
            Sheet sheet1 = new Sheet(1, 0,ReaderMassageDo.class);

            // 写数据到 Writer 上下文中
            // 入参1: 创建要写入的模型数据
            // 入参2: 要写入的目标 sheet
            writer.write(readerMsgService.getAllMsg(), sheet1);
            // 将上下文中的最终 outputStream 写入到指定文件中
            writer.finish();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }finally {
            try {
                // 关闭流
                out.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        return CommonReturnType.success();
    }
}
