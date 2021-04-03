package com.xsr.config;

public class Config{

	public static String getURL()
    {
        return("http://127.0.0.1:8080");
    }

	public static String getPath()
    {
        return(getURL()+"/XSR");
    }

	public static String getPageURL()
    {
        return(getPath()+"/interfaces/");
    }
	
    public static String getImagesURL()
    {
        return(getPageURL()+"img_lib/");
    }
	
	public static String getCSSURL()
    {
        return(getPageURL()+"css/");
    }

	public static String getServletURL()
    {
        return(getPath()+"/servlet/");
    }
}