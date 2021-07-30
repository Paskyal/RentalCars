report 50101 "Rental Orders Report"
{
    ApplicationArea = All;
    Caption = 'Rental Orders Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Rental Orders Report.rdlc';

    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.";
            DataItemTableView = SORTING("No.", "Description") WHERE(Type = CONST(Rental));
            column(No; "No.")
            {
            }
            column(Description; Description)
            {
            }

            dataitem("Rental Order Line"; "Rental Order Line")
            {
                RequestFilterFields = "Car No.";
                DataItemLink = "Order No." = field("No.");
                column(Order_No_; "Order No.")
                {
                }
                column(Car_No_; "Car No.")
                {
                }
                // column(Starting_Date; "Starting Date")
                // {
                // }
                // column(Ending_Date; "Ending Date")
                // {
                // }
                trigger OnAfterGetRecord()
                var
                    RentalPostedOrderLine: Record "Rental Posted Order Line";
                begin
                    RentalPostedOrderLine.SetRange("Car No.", Item."No.");
                end;
            }
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(StartingDate; StartingDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Starting Date';
                        ToolTip = 'Specifies the Starting Date';
                    }
                    field(EndingDate; EndingDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Ending Date';
                        ToolTip = 'Specifies the Ending Date';
                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
        trigger OnInit()
        begin
            StartingDate := WorkDate();
        end;

    }
    var
        StartingDate: Date;
        EndingDate: Date;
}