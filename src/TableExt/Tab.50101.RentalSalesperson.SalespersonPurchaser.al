tableextension 50101 "Rental Salesperson" extends "Salesperson/Purchaser"
{
    fields
    {
        field(50100; "Rental No."; Code[30])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(50102; "Rental No. of Posted Orders"; Integer)
        {
            CalcFormula = Count("Rental Posted Order" where("Salesperson Name" = field(Name)));
            Caption = 'No. of Rental Posted Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50103; "Rental No. of Orders"; Integer)
        {
            CalcFormula = Count("Rental Order" where("Salesperson Name" = field(Name)));
            Caption = 'No. of Rental Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50104; "Rental Average Cost"; Integer)
        {
            CalcFormula = Count("Rental Order" where("Salesperson Name" = field(Name)));
            Caption = 'Rental Average Cost';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50105; "Rental Average Price"; Integer)
        {
            CalcFormula = Count("Rental Order" where("Salesperson Name" = field(Name)));
            Caption = 'Rental Average Price';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50106; "Rental Average Profit"; Integer)
        {
            CalcFormula = Count("Rental Order" where("Salesperson Name" = field(Name)));
            Caption = 'Rental Average Profit';
            Editable = false;
            FieldClass = FlowField;
        }
    }
}