report 50100 "Rental Orders Report"
{
    Caption = 'Rental Orders Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = 'Rental Orders Report.rdlc';
    WordLayout = 'Rental Orders Report.docx';
    dataset
    {
        dataitem("Rental Order"; "Rental Order")
        {
            column(No_; "No.")
            {

            }
            column(Customer_No_; "Customer No.")
            {

            }
            column(Customer_Name; "Customer Name")
            {

            }
            column(Salesperson_Name; "Salesperson Name")
            {

            }
            column(Posting_Date; "Posting Date")
            {

            }
        }
        dataitem("Rental Order Line"; "Rental Order Line")
        {
            column(Order_No_; "Order No.")
            {

            }
            column(Car_No_; "Car No.")
            {

            }
            column(Car_Description; "Car Description")
            {

            }
            column(Price_a_day; "Price a day")
            {

            }
            column(Days_Amt_; "Days Amt.")
            {

            }
            column(Total_Discount; "Line Discount")
            {

            }
            column(Line_Amount; "Line Amount")
            {

            }
        }
    }
}