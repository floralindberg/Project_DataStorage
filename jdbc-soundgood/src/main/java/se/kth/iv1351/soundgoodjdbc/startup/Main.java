package se.kth.iv1351.soundgoodjdbc.startup;
import se.kth.iv1351.soundgoodjdbc.controller.*;
import se.kth.iv1351.soundgoodjdbc.integration.SoundgoodDBException;
import se.kth.iv1351.soundgoodjdbc.view.BlockingInterpreter;

public class Main {
    public static void main(String[] args) {
        try {
        new BlockingInterpreter(new Controller()).handleCmds();
        } catch(SoundgoodDBException sdbe) {
            System.out.println("Could not connect to Bank db.");
            sdbe.printStackTrace();
        }
        
    }
}