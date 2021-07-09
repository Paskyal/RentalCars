table 50101 "Rental Order Line"
{
    Caption = 'Rental Order Line';
    DataClassification = CustomerContent;
    LookupPageId = "Rental Order Line";
    DrillDownPageId = "Rental Order Line";

    fields
    {
        field(1; "Order No."; Code[20])
        {
            Caption = 'Order No.';
            DataClassification = CustomerContent;
            TableRelation = "Rental Order";
            Editable = false;
        }
        field(20; "Line No."; Integer)
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(30; "Car No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;
            TableRelation = "Item";
            trigger OnValidate()
            begin
                CopyFromItem();
            end;
        }
        field(40; "Car Description"; Text[100])
        {
            Caption = 'Car Description';
            FieldClass = FlowField;
            CalcFormula = lookup(Item."Description" where("No." = field("Car No.")));
            Editable = false;

        }
        field(41; "Starting Date"; Date)
        {
            Caption = 'Starting Date.';
            DataClassification = CustomerContent;
        }
        field(42; "Ending Date"; Date)
        {
            Caption = 'Ending Date.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                UpdateDaysAmt();
            end;
        }
        field(50; "Days Amt."; Integer)
        {
            Caption = 'Days Amt.';
            DataClassification = CustomerContent;
            Editable = false;

            trigger OnValidate()
            begin
                UpdateLineAmount();
            end;
        }
        field(60; "Price a day"; Decimal)
        {
            Caption = 'Price a day';
            DataClassification = CustomerContent;
        }
        field(61; "Customer Discount"; Decimal)
        {
            Caption = 'Customer Discount';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(62; "Car Discount"; Decimal)
        {
            Caption = 'Car Discount';
            DataClassification = CustomerContent;

        }
        field(70; "Line Discount"; Decimal)
        {
            Caption = 'Total Discount';
            DataClassification = CustomerContent;
            MaxValue = 100;
            MinValue = 0;
            Editable = false;
            trigger OnValidate()
            begin
                UpdateLineAmount();
            end;
        }
        field(80; "Line Amount"; Decimal)
        {
            Caption = 'Total Amount';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Order No.", "Line No.")
        {
            Clustered = true;
        }
    }

    local procedure CopyFromItem()
    var
        Item: Record Item;
    begin
        if "Car No." = '' then
            exit;
        Item.Get("Car No.");
        Rec.Validate("Price a day", Item."Unit Price");
        Rec.Validate("Car Discount", Item."Car Discount");
    end;



    local procedure UpdateDaysAmt()
    begin
        if (Rec."Ending Date" <> 0D) and (Rec."Starting Date" <> 0D) then
            Rec.validate("Days Amt.", "Ending Date" - "Starting Date" + 1);
    end;

    local procedure UpdateLineAmount()
    begin
        Rec.Validate("Line Amount", "Days Amt." * "Price a day" - ("Days Amt." * "Price a day" * "Line Discount" / 100));
    end;
}
