package com.hmi.aria.bot;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

public class GetProp {
    private final Properties properties;

    GetProp() {
        InputStream inStream = null;
        properties = new Properties();
        try {

            inStream = this.getClass().getClassLoader().getResourceAsStream("res/config/bot.properties");
            properties.load(inStream);

        } catch (IOException ioex) {
            Logger.getLogger(getClass().getName()).log(Level.ALL,
                    "IOException Occured while loading properties file::::" + ioex.getMessage());
        } finally {
            try {

                if (inStream != null)
                    inStream.close();

            } catch (Exception e) {
                Logger.getLogger(getClass().getName()).log(Level.ALL,
                        "Failed to close the File Inputstream" + e.getMessage());
            }
        }
    }

    public String readProperty(String keyName) {
        Logger.getLogger(getClass().getName()).log(Level.INFO, "Reading Property " + keyName);
        return properties.getProperty(keyName, "There is no key in the properties file");
    }
}
