package se.kth.iv1351.soundgoodjdbc.model;

public class AvailableInstrument implements AvailableInstrumentDTO {
    private final String brand;
    private final String price;
    private final String quantity;
    private final String instrumentName;

    public AvailableInstrument(String instrumentName, String brand, String quantity, String price){
        this.brand = brand;
        this.price = price;
        this.quantity = quantity;
        this.instrumentName = instrumentName;

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



}