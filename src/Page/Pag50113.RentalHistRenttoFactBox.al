page 50113 "Rental Hist. Rent-to FactBox"
{
    Caption = 'Rent-to Customer Rental History';
    PageType = CardPart;
    SourceTable = Customer;

    layout
    {
        area(content)
        {
            field("No."; Rec."No.")
            {
                ApplicationArea = All;
                Caption = 'Customer No.';
                ToolTip = 'Specifies the number of the customer. The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';

                trigger OnDrillDown()
                begin
                    ShowDetails();
                end;
            }
            cuegroup(Control2)
            {
                ShowCaption = false;
                field(NoofOrdersTile; Rec."Rental No. of Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Rental Orders';
                    DrillDownPageID = "Rental Orders";
                    ToolTip = 'Specifies the value of the Rental Orders field.';
                }
                field(NoofPostedOrdersTile; Rec."Rental No. of Posted Orders")
                {
                    ApplicationArea = Suite;
                    Caption = 'Posted Rental Orders';
                    DrillDownPageID = "Rental Posted Orders";
                    ToolTip = 'Specifies the value of the Posted Rental Orders field.';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        RentalOrder.SetRange("Customer No.", Rec."No.");
    end;

    local procedure ShowDetails()
    begin
        PAGE.Run(PAGE::"Customer Card", Rec);
    end;


    var
        RentalOrder: Record "Rental Order";
}