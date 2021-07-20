pageextension 50106 "Rental RoleCenterExt" extends "Business Manager Role Center"
{
    actions
    {
        addafter(Action41)
        {
            group("Rental Rental")
            {
                Caption = 'Rental';
                ToolTip = 'Make rental orders, find cars for rent';
                action("Rental Cars")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cars';
                    RunObject = page "Rental Cars";
                }
                action("Rental Orders")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Rental Orders';
                    RunObject = page "Rental Orders";
                }
                action("Rental Customers")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customers';
                    RunObject = page "Rental Customers";
                }
                action("Rental Orders Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Rental Orders Report';
                    RunObject = report "Rental Orders Report";
                }
            }
            group("Rental Posted")
            {
                Caption = 'Rental Posted';
                ToolTip = 'View Posted Rental Orders';
                action("Rental Posted Rental Orders")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Rental Orders';
                    RunObject = page "Rental Posted Orders";
                }
            }
        }
        addafter("Sales Invoice")
        {
            action("Rental Order")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Rental Order';
                RunObject = Page "Rental Order Card";
                RunPageMode = Create;
                ToolTip = 'Create a new rental order.';
            }
        }
    }
}