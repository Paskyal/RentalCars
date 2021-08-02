report 50101 "Rental Orders Report"
{
    ApplicationArea = All;
    Caption = 'Rental Orders Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Reports/Layouts/Rental Orders Report.rdlc';

    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.";
            DataItemTableView = WHERE(Type = CONST(Rental));
            column(No; "No.")
            {
            }
            column(Car_Description; Description)
            {
            }
            column(Starting_Date; StartingDate)
            {
            }
            column(Ending_Date; EndingDate)
            {
            }

            trigger OnAfterGetRecord()
            var
                RentalPostedOrderLine: Record "Rental Posted Order Line";
                RentalOrderLine: Record "Rental Order Line";
            begin
                RentalOrderLine."Starting Date" := RentalOrderLine."Ending Date";
                RentalPostedOrderLine.SetRange("Car No.", Item."No.");
                if StartingDate = 0D then
                    Error('');
                StartingDate := WorkDate();

                if EndingDate <> 0D then begin
                    RentalPostedOrderLine.SETFILTER("Starting Date", '%1|%1..%2|<%1&<%2|>%1&<%2', StartingDate, EndingDate);
                    RentalPostedOrderLine.SETFILTER("Ending Date", '%2|%1..%2|>%1&<%2|>%1', StartingDate, EndingDate);
                end else
                    RentalPostedOrderLine.SETFILTER("Starting Date", '%1..', StartingDate);

                if RentalPostedOrderLine.IsEmpty() = IsAvailable then
                    CurrReport.Skip();
            end;
            // dataitem("Rental Posted Order Line"; "Rental Posted Order Line")
            // {
            //     RequestFilterFields = "Car No.", "Starting Date", "Ending Date";
            //     DataItemLink = "Order No." = field("No.");
            //     column(Order_No_; "Order No.")
            //     {
            //     }
            //     column(Car_No_; "Car No.")
            //     {
            //     }
            //     column(Car_Description; "Car Description")
            //     {
            //     }
            //     column(Starting_Date; "Starting Date")
            //     {
            //     }
            //     column(Ending_Date; "Ending Date")
            //     {
            //     }
            // }
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
                    field(fieldStartingDate; StartingDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Starting Date';
                        ToolTip = 'Specifies the Starting Date';
                    }
                    field(fieldEndingDate; EndingDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Ending Date';
                        ToolTip = 'Specifies the Ending Date';
                    }
                    field(CarIsAvailable; IsAvailable)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'The car is available';
                        ToolTip = 'Shows the availability of the car';
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
        IsAvailable: Boolean;
}