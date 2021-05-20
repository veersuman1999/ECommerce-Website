
package com.learn.mycart.helper;


public class HelperName {
    public static String get20Words(String name){
        String[] strs = name.split(" ");
        if(strs.length>10)
        {
            String res="";
            for(int i=0;i<10;i++)
            {
                res=res+strs[i] + " ";
            }
            return (res+"...");
        }else
        {
            return (name+ "...");
        }
    }
}
