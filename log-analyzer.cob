       *========================================================
       * ADVANCED PAYROLL PROCESSING SYSTEM
       * Demonstrates:
       * - File handling
       * - Record structures
       * - Multiple input/output files
       * - Payroll processing architecture
       *========================================================

       IDENTIFICATION DIVISION. 
       PROGRAM-ID. ADVANCED-PAYROLL.     *> Name of the COBOL program
       AUTHOR. RAYMOND SUNG-SEH HARRISON.*> Program author
       INSTALLATION. Personal COBOL Portfolio Project.
       DATE-WRITTEN. 2025-06-11.         *> Date the program was created
       DATE-COMPILED.
       SECURITY. PUBLIC.
       REMARKS.
           Payroll system module.
           Calculates monthly salary payments.
           Interfaces with tax and benefits systems.

       ENVIRONMENT DIVISION.
       *--------------------------------------------------------
       * Defines external files and how the program interacts
       * with the operating system.
       *--------------------------------------------------------

       INPUT-OUTPUT SECTION.

       FILE-CONTROL. 
           * Employee master file containing staff information
           SELECT EMP-FILE ASSIGN TO "EMPLOYEE.DAT"
               ORGANIZATION IS LINE SEQUENTIAL.
               *> Text file where each line represents a record

           * Transaction file containing payroll adjustments
           SELECT TRANS-FILE ASSIGN TO "TRANSACTIONS.DAT"
               ORGANIZATION IS LINE SEQUENTIAL.

           * Output payroll file that will store final results
           SELECT PAY-FILE ASSIGN TO "PAYROLL.DAT"
               ORGANIZATION IS LINE SEQUENTIAL.

           * Error log file for recording processing problems
           SELECT ERROR-FILE ASSIGN TO "ERROR.LOG"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       *--------------------------------------------------------
       * Defines the structure of all data used by the program
       *--------------------------------------------------------

       FILE SECTION.
       *--------------------------------------------------------
       * Employee File Layout
       *--------------------------------------------------------
       FD EMP-FILE.                     *> File description for EMP-FILE

       01 EMP-REC.                      *> One employee record
           05 EMP-ID       PIC 9(5).    *> Employee ID (5 digit number)
           05 EMP-NAME     PIC X(30).   *> Employee full name
                                        *> Up to 30 characters
           05 DEPARTMENT   PIC X(20).   *> Department name
                                        *> Example: HR, IT, FINANCE
           05 BASIC-SALARY PIC 9(7)V99. *> Basic salary
                                        *> 7 digits + 2 decimal places
                                        *> Example: 45000.50
           05 TAX-BRACKET  PIC 9(1).    *> Tax category (1 digit)
                                        *> Used later to determine tax rate


       *--------------------------------------------------------
       * Transaction File Layout
       * Contains monthly adjustments
       *--------------------------------------------------------
       FD TRANS-FILE.
       01 TRANS-REC.
           05 T-EMP-ID       PIC 9(5).  *> Employee ID matching EMP-FILE
           05 OVERTIME-HRS   PIC 9(3)V99.
                                        *> Overtime hours worked
                                        *> Example: 10.50 hours
           05 BONUS          PIC 9(5)V99.
                                        *> Extra bonus payment
           05 LEAVE-DEDUCT   PIC 9(5)V99.
                                        *> Salary deduction due to leave

       *--------------------------------------------------------
       * Payroll Output File Layout
       * Final payroll results are written here
       *--------------------------------------------------------

       FD PAY-FILE.
       01 PAY-REC.
           05 PAY-EMP-ID     PIC 9(5).   *> Employee ID
           05 PAY-EMP-NAME   PIC X(30).  *> Employee name
           05 PAY-DEPT       PIC X(20).  *> Department
           05 GROSS-PAY      PIC 9(7)V99.
                                         *> Salary before tax
           05 TAX-AMT        PIC 9(7)V99.
                                         *> Tax amount deducted
           05 DEDUCTIONS     PIC 9(5)V99.
                                         *> Other deductions
           05 NET-PAY        PIC 9(7)V99.
                                         *> Final take-home salar

       *--------------------------------------------------------
       * Error File Layout
       * Used to record processing errors
       *--------------------------------------------------------

       FD ERROR-FILE.

       01 ERROR-REC PIC X(80).
           *> A text message describing an error
           *> Maximum 80 characters

   
       WORKING-STORAGE SECTION.
       *--------------------------------------------------------
       * Temporary variables used during program execution
       *--------------------------------------------------------

       01 EOF-EMP   PIC X VALUE "N".
           *> End-of-file indicator for employee file
           *> "N" = not reached end
           *> "Y" = end of file reached

       01 EOF-TRANS PIC X VALUE "N".
           *> End-of-file indicator for transaction file


       PROCEDURE DIVISION.
       *--------------------------------------------------------
       * This section contains the executable program logic
       *--------------------------------------------------------

       MAIN-PROCEDURE. 
           * Open employee and transaction files for reading
           OPEN INPUT EMP-FILE TRANS-FILE

           * Open payroll and error files for writing
           OPEN OUTPUT PAY-FILE ERROR-FILE

           *----------------------------------------------------
           * Actual payroll processing would normally occur here
           * Example steps:
           *   1. READ employee records
           *   2. MATCH transactions
           *   3. CALCULATE gross pay
           *   4. APPLY tax rules
           *   5. WRITE payroll record
           *----------------------------------------------------

           * Close all files after processing is finished
           CLOSE EMP-FILE TRANS-FILE PAY-FILE ERROR-FILE

           * Display completion message on the screen
           DISPLAY "DONE: Payroll processing completed successfully."

           * Terminate the program
           STOP RUN.
