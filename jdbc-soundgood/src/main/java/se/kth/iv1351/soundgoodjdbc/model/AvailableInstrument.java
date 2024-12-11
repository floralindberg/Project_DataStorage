package se.kth.iv1351.soundgoodjdbc.model;

public class AvailableInstrument implements AvailableInstrumentDTO {
    private String brand;
    private String price;
    private String quantity;
    private String instrumentName;

    public AvailableInstrument(String instrumentName, String brand, String quantity, String price){
        this.brand = brand;
        this.price = price;
        this.quantity = quantity;
        this.instrumentName = instrumentName;

    }
    
    public String getBrand() {
        return brand;

    }

    public String getPrice(){
        return price;
    }

    public String getQuantity(){
        return quantity;
    }

    public String getInstrumentName(){
        return instrumentName;
    }



}