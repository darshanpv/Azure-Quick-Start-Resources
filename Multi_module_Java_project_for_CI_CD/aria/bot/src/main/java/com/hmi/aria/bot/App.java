package com.hmi.aria.bot;

import java.io.File;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.hmi.aria.util.Util;

public class App {

    public static void main(String[] args) {

        System.out.println(new App().greet(" World !!"));

        System.out.println("\nClass Path : ====>");
        File jarPath = new File(App.class.getProtectionDomain().getCodeSource().getLocation().getPath());
        String propertiesPath = jarPath.getParentFile().getAbsolutePath();
        System.out.println(propertiesPath);

        System.out.println("\nProperties : ====>");
        GetProp properties = new GetProp();
        Logger.getLogger("App Main").log(Level.INFO,
                properties.readProperty("PROTOCOL"));

    }

    public String greet(String name) {
        return Util.join("Hello", name);
    }

}