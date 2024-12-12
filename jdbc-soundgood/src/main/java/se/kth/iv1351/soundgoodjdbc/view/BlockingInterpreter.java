package se.kth.iv1351.soundgoodjdbc.view;
import java.util.List;
import java.util.Scanner;

import se.kth.iv1351.soundgoodjdbc.controller.Controller;
import se.kth.iv1351.soundgoodjdbc.model.AvailableInstrumentDTO;
import se.kth.iv1351.soundgoodjdbc.model.RentalDTO;
import se.kth.iv1351.soundgoodjdbc.model.RentalException;

public class BlockingInterpreter {
    private static final String PROMPT = "> ";
    private final Scanner console = new Scanner(System.in);
    private Controller ctrl;
    private boolean keepReceivingCmds = false;

    /**
     * Creates a new instance that will use the specified controller for all operations.
     *
     * @param ctrl The controller used by this instance.
     */
    public BlockingInterpreter(Controller ctrl) {
        this.ctrl = ctrl;
    }

    /**
     * Stops the commend interpreter.
     */
    public void stop() {
        keepReceivingCmds = false;
    }

    /**
     * Interprets and performs user commands. This method will not return until the
     * UI has been stopped. The UI is stopped either when the user gives the
     * "quit" command, or when the method <code>stop()</code> is called.
     */
    public void handleCmds() {
        keepReceivingCmds = true;
        while (keepReceivingCmds) {
            try {
                CmdLine cmdLine = new CmdLine(readNextLine());
                switch (cmdLine.getCmd()) {
                    case HELP:
                        for (Command command : Command.values()) {
                            if (command == Command.ILLEGAL_COMMAND) {
                                continue;
                            }
                            System.out.println(command.toString().toLowerCase());
                        }
                        break;
                    case QUIT:
                        keepReceivingCmds = false;
                        break;
                    case RENTAL:
                        List<? extends RentalDTO> rentals = null;
                        if (cmdLine.getParameter(0).equals("")) {
                            rentals = ctrl.findAllRentals();
                        } else {
                            rentals = ctrl.findSpecificRental(cmdLine.getParameter(0));
                        }
                        for (RentalDTO rental : rentals) {
                            System.out.println("student id: " + rental.getStudentId() + ", "
                                            + "available instrument id: " + rental.getAvailableInstrumentId() + ", "
                                            + "student name: " + rental.getStudentName() + ", "
                                            + "instrument Name: " + rental.getInstrumentName() + ", "
                                            + "instrument brand: " + rental.getBrand() + ", "
                                            + "price: " + rental.getPrice()  + ", "
                                            + "status: " + rental.getStatus());
                        }
                        break;
                    case TERMINATE:
                        try{
                            String studentId = cmdLine.getParameter(0);
                            String availableInstrumentId = cmdLine.getParameter(1);
                            ctrl.terminateRental(studentId, availableInstrumentId);
                            System.out.println("Ended rental for student id: " + studentId + ", and available instrument id: " +  availableInstrumentId);
                        } catch (RentalException e){
                            System.out.println("No rental found");
                        }
                        break;
                    case LIST:
                        List<? extends AvailableInstrumentDTO> availableInstrument = null;
                        if (cmdLine.getParameter(0).equals("")) {
                            availableInstrument = ctrl.findAllAvailableInstruments();
                        } else {
                            availableInstrument = ctrl.findSpecificAvailableInstruments(cmdLine.getParameter(0));
                        }
                        for (AvailableInstrumentDTO instrument : availableInstrument) {
                            System.out.println("instrument name: " + instrument.getInstrumentName() + ", "
                                            + "instrument brand: " + instrument.getBrand() + ", "
                                            + "quantity: " + instrument.getQuantity() + ", "
                                            + "price: " + instrument.getPrice()+ ", "
                                            + "available instrument id: " + instrument.getAvailableInstrumentId());
                        }
                        break;
                    case RENT:
                        try{
                            String studentId2 = cmdLine.getParameter(0);
                            String availableInstrumentId2 = cmdLine.getParameter(1);
                            ctrl.createRental(studentId2, availableInstrumentId2);
                            System.out.println("Created rental for student id: " + studentId2 + ", and available instrument id: " +  availableInstrumentId2);
                            
                        } catch (RentalException e){
                            System.out.println("Rental denied");
                        }
                        break;
                    default:
                        System.out.println("illegal command");
                }
            } catch (Exception e) {
                System.out.println("Operation failed");
                System.out.println(e.getMessage());
                e.printStackTrace();
            }
        }
    }

    private String readNextLine() {
        System.out.print(PROMPT);
        return console.nextLine();
    }
    
}
