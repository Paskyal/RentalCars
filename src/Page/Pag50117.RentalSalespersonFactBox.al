page 50117 "Rental Salesperson FactBox"
{
    Caption = 'Rental Salespersdon History';
    PageType = CardPart;
    SourceTable = "Salesperson/Purchaser";

    layout
    {
        area(content)
        {
            field("Code"; Rec."Code")
            {
                ApplicationArea = All;
                Caption = 'Order No.';
                ToolTip = 'Specifies the value of the Order No. field.';


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
        RentalOrder.SetRange("Salesperson Name", Rec.Name);
    end;

    local procedure ShowDetails()
    begin
        PAGE.Run(PAGE::"Customer Card", Rec);
    end;


    var
        RentalOrder: Record "Rental Order";
}