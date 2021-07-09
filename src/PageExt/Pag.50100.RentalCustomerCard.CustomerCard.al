pageextension 50100 "Rental Customer Card" extends "Customer Card"
{
    Layout
    {
        addafter("Disable Search by Name")
        {
            field("Rental Discount"; Rec."Rental Discount")
            {
                ToolTip = 'Specifies the value of the Discount field';
                ApplicationArea = All;
                MaxValue = 100;
                MinValue = 0;

            }
        }


    }

}
