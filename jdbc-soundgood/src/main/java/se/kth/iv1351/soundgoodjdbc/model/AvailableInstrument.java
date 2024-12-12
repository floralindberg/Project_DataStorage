package se.kth.iv1351.soundgoodjdbc.model;

public class AvailableInstrument implements AvailableInstrumentDTO {
    private String brand;
    private String price;
    private String quantity;
    private String instrumentName;
    private String availableInstrumentId;


    public AvailableInstrument(String instrumentName, String brand, String quantity, String price, String availableInstrumentId){
        this.brand = brand;
        this.price = price;
        this.quantity = quantity;
        this.instrumentName = instrumentName;
        this.availableInstrumentId = availableInstrumentId;

    }
    
    @Override
    public String getBrand() {
        return brand;

    }

    @Override
    public String getPrice(){
        return price;
    }

    @Override
    public String getQuantity(){
        return quantity;
    }

    @Override
    public String getInstrumentName(){
        return instrumentName;
    }

    public String getAvailableInstrumentId(){
        return availableInstrumentId;
    }



}