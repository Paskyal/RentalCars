tableextension 50102 "Rental Customer" extends Customer
{
    fields
    {
        field(50100; "Rental Customer Discount"; Decimal)
        {
            Caption = 'Customer Discount';
            DataClassification = CustomerContent;
        }
        field(50101; "Rental No. of Posted Orders"; Integer)
        {
            CalcFormula = Count("Rental Posted Order" where("Customer No." = field("No.")));
            Caption = 'No. of Rental Posted Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50102; "Rental No. of Orders"; Integer)
        {
            CalcFormula = Count("Rental Order" where("Customer No." = field("No.")));
            Caption = 'No. of Rental Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50103; "Rental Average Cost"; Integer)
        {
            CalcFormula = Count("Rental Order" where("Customer No." = field("No.")));
            Caption = 'Rental Average Cost';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50104; "Rental Average Price"; Integer)
        {
            CalcFormula = Count("Rental Order" where("Customer No." = field("No.")));
            Caption = 'Rental Average Price';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50105; "Rental Average Profit"; Integer)
        {
            CalcFormula = Count("Rental Order" where("Customer No." = field("No.")));
            Caption = 'Rental Average Profit';
            Editable = false;
            FieldClass = FlowField;
        }
    }
}