page 50115 "Rental Car History FactBox"
{
    Caption = 'Rental Car History';
    PageType = CardPart;
    SourceTable = Item;

    layout
    {
        area(content)
        {
            field("No."; Rec."No.")
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
        RentalOrder.SetRange("Customer No.", Rec."No.");
    end;

    local procedure ShowDetails()
    begin
        PAGE.Run(PAGE::"Customer Card", Rec);
    end;


    var
        RentalOrder: Record "Rental Order";
}