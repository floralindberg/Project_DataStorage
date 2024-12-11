package se.kth.iv1351.soundgoodjdbc.controller;

import java.util.List;

import se.kth.iv1351.soundgoodjdbc.integration.SoundgoodDAO;
import se.kth.iv1351.soundgoodjdbc.integration.SoundgoodDBException;
import se.kth.iv1351.soundgoodjdbc.model.AvailableInstrumentDTO;
import se.kth.iv1351.soundgoodjdbc.model.AvailableInstrumentException;
import se.kth.iv1351.soundgoodjdbc.model.RentalDTO;
import se.kth.iv1351.soundgoodjdbc.model.RentalException;

public class Controller{
    private final SoundgoodDAO soundDb;

    public Controller() throws SoundgoodDBException{
        soundDb = new SoundgoodDAO();
    }

    public List<? extends AvailableInstrumentDTO> findAllAvailableInstruments() throws AvailableInstrumentException {
        try {
            return soundDb.findAllAvailableInstruments();
        } catch (Exception e) {
            throw new AvailableInstrumentException("Unable to list available instruments.", e);
        }
    }

    public List<? extends AvailableInstrumentDTO> findSpecificAvailableInstruments(String instrument) throws AvailableInstrumentException {
        try {
            return soundDb.findSpecificAvailableInstruments(instrument);
        } catch (Exception e) {
            throw new AvailableInstrumentException("Unable to list avaliable instruments.", e);
        }
    }

    public List <? extends RentalDTO> findAllRentals() throws RentalException {
        try {
            return soundDb.findaAllRentals();
        } catch (Exception e) {
            throw new RentalException("Unable to list all rentals", e);
        }
    }
    
    public List <? extends RentalDTO> findSpecificRental(String id) throws RentalException {
        try {
            return soundDb.findSpecificRental(id);
        } catch (Exception e) {
            throw new RentalException("Unable to list all rentals", e);
        }
    }

    public void createRental(String studentId, String availInstrId) throws RentalException {
        String failureMsg = "Could not create rental for: " + studentId;

        if (studentId == null || availInstrId == null) {
            throw new RentalException(failureMsg);
        }

        try {
            soundDb.createRental(studentId, availInstrId);
        } catch (Exception e) {
            throw new RentalException(failureMsg, e);
        }
    }

    public void terminateRental(String studentId, String availInstrId) throws RentalException{
        String failureMsg = "Could not create rental for: " + studentId;

        if (studentId == null || availInstrId == null) {
            throw new RentalException(failureMsg);
        }

        try {
            soundDb.terminateRental(studentId, availInstrId);
        } catch (Exception e) {
            throw new RentalException(failureMsg, e);
        }
        
    }


}