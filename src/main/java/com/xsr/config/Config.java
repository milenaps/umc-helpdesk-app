package com.xsr.config;

public class Config{

    public static String getPath()
    {
        return("/xsr-v1");
    }

    public static String getPageURL()
    {
        return(getPath()+"/interfaces/");
    }

    public static String getImagesURL()
    {
        return(getPageURL()+"/img_lib/");
    }

    public static String getCSSURL()
    {
        return(getPageURL()+"/css/");
    }

    public static String getServletURL()
    {
        return(getPath()+"/servlet/");
    }
}