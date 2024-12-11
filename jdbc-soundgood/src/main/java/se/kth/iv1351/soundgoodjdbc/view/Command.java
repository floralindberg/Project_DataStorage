package se.kth.iv1351.soundgoodjdbc.view;

    
    public enum Command {
        /**
         * list all instruments of a certain kind (guitar, saxophone, etc) that are available to rent. 
         * Instruments which are already rented shall not be included in the listing. 
         * The listing shall show brand and price for each listed instrument.
         */
        LIST,
        /**
         * Terminate an ongoing rental. The database must still contain all information about the rental, 
         * but also show that the rental has been terminated.
         */
        TERMINATE,
        /**
         * Specify which student is renting the instrument, and which instrument is being rented. 
         */
        RENTAL,
        /**
         * Lists all commands.
         */
        RENT,
        /**
         * Lists all commands.
         */
        HELP,
        /**
         * Lists all commands.
         */
        QUIT,
        /**
         * None of the valid commands above was specified.
         */
        ILLEGAL_COMMAND
    }


