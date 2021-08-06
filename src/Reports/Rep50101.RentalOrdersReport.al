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
            begin
                RentalPostedOrderLine.SetRange("Car No.", Item."No.");
                if StartingDate = 0D then
                    Error('Specify a Starting Date');
                // StartingDate := Workdate();
                if EndingDate <> 0D then begin
                    RentalPostedOrderLine.SETFILTER("Starting Date", '%1|%1..%2|<%1&<%2|>%1&<%2', StartingDate, EndingDate);
                    RentalPostedOrderLine.SETFILTER("Ending Date", '%2|%1..%2|>%1&<%2|>%1', StartingDate, EndingDate);
                end else
                    RentalPostedOrderLine.SETFILTER("Starting Date", '%1..', StartingDate);
                if not RentalPostedOrderLine.IsEmpty() = IsAvailable then
                    CurrReport.Skip();
            end;
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

                        trigger OnValidate()
                        begin
                            if (EndingDate < StartingDate)
                                and (EndingDate <> 0D)
                            then
                                Error('Ending Date is earlier than Starting Date');
                        end;
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