table 50104 "Rental Posted Order Line"
{
    Caption = 'Rental Posted Order Line';
    DataClassification = CustomerContent;
    LookupPageId = "Rental Posted Order Line";
    DrillDownPageId = "Rental Posted Order Line";

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
            Caption = 'Line No.';
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

            trigger OnValidate()
            begin
                if (Rec."Ending Date" <> 0D) and (Rec."Starting Date" > Rec."Ending Date") then
                    Error('Starting Date cannot be later than Ending Date');
                UpdateDaysAmt();
            end;
        }
        field(42; "Ending Date"; Date)
        {
            Caption = 'Ending Date.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if (Rec."Starting Date" <> 0D) and ("Ending Date" < "Starting Date") then
                    Error('Ending Date cannot be earlier than Starting Date');
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
            trigger OnValidate()
            begin
                UpdateLineAmount();
            end;
        }
        field(62; "Rental Car Discount"; Decimal)
        {
            Caption = 'Car Discount';
            DataClassification = CustomerContent;
            MaxValue = 100;
            MinValue = 0;
            trigger OnValidate()
            begin
                UdateLineDiscount(0);
                UpdateLineAmount();
            end;

        }
        field(70; "Line Discount"; Decimal)
        {
            Caption = 'Line Discount';
            DataClassification = CustomerContent;
            MaxValue = 100;
            MinValue = 0;
            trigger OnValidate()
            begin
                UpdateLineAmount();
            end;
        }
        field(80; "Line Amount"; Decimal)
        {
            Caption = 'Line Amount';
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
        Rec.Validate("Rental Car Discount", Item."Rental Car Discount");
    end;

    local procedure UpdateDaysAmt()
    begin
        if (Rec."Ending Date" <> 0D) and (Rec."Starting Date" <> 0D) then
            Rec.validate("Days Amt.", "Ending Date" - "Starting Date" + 1);
    end;

    local procedure UpdateLineAmount()
    begin
        Rec.Validate("Line Amount", "Days Amt." * "Price a day" - ("Days Amt." * "Price a day" * ("Line Discount" / 100)));
    end;

    procedure UdateLineDiscount(CustomerDiscount: decimal): boolean
    var
        RentalOrder: Record "Rental Order";
    begin
        if CustomerDiscount = 0 then begin
            RentalOrder.Get("Order No.");
            CustomerDiscount := RentalOrder."Rental Customer Discount";
        end;

        case true of
            (Rec."Rental Car Discount" >= CustomerDiscount):
                Rec.Validate("Line Discount", "Rental Car Discount");//CustomerDiscount
            (Rec."Rental Car Discount" < CustomerDiscount):
                Rec.Validate("Line Discount", CustomerDiscount);
        end;
        exit(format(Rec) <> format(xRec));
    end;
}