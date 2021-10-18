table 50100 "Rental Order"
{
    Caption = 'Rental Order';
    DataClassification = CustomerContent;
    LookupPageId = "Rental Order line";
    DrillDownPageId = "Rental Order line";
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    GetRentalSetup();
                    NoSeriesMgt.TestManual(GetNoSeriesCode());
                end;
            end;
        }
        field(2; "Salesperson Code"; Code[50])
        {
            Caption = 'Salesperson Code';
            DataClassification = CustomerContent;
            TableRelation = "Salesperson/Purchaser";
        }
        field(3; "Salesperson Name"; Text[100])
        {
            Caption = 'Salesperson Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Salesperson/Purchaser".Name WHERE("Name" = field("Salesperson Code")));
            TableRelation = "Salesperson/Purchaser".Name;
            ValidateTableRelation = false;

        }
        field(4; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
            TableRelation = Customer;
            trigger OnValidate()
            begin
                CopyFromCustomer();
            end;
        }
        field(5; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(6; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup(Customer.Name WHERE("No." = field("Customer No.")));
            TableRelation = Customer.Name;
            ValidateTableRelation = false;
        }
        field(7; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(8; "Rental Customer Discount"; Decimal)
        {
            Caption = 'Customer Discount';
            DataClassification = CustomerContent;
            MaxValue = 100;
            MinValue = 0;
            trigger OnValidate()
            begin
                UpdateLineDiscount();
            end;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        InitInsert();
    end;

    procedure InitInsert()
    begin
        if "No." = '' then begin
            TestNoSeries();
            NoSeriesMgt.InitSeries(GetNoSeriesCode(), xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    local procedure TestNoSeries()
    begin
        GetRentalSetup();
        RentalSetup.Testfield("Order Nos.");

    end;

    local procedure GetRentalSetup()
    begin
        if RentalSetup.Get() then
            exit;
        RentalSetup.Init();
        RentalSetup.Insert(true);
        Commit();
    end;

    local procedure CopyFromCustomer()
    var
        Customer: Record Customer;
    begin
        Customer.Get("Customer No.");
        Rec.Validate("Rental Customer Discount", Customer."Rental Customer Discount");
    end;

    local procedure UpdateLineDiscount()
    var
        RentalOrderLine: Record "Rental Order Line";
    begin
        if Rec."Rental Customer Discount" = xRec."Rental Customer Discount" then
            exit;
        RentalOrderLine.SetRange("Order No.", Rec."No.");
        if RentalOrderLine.FindSet(true, false) then
            repeat
                if RentalOrderLine.UpdateLineDiscount("Rental Customer Discount") then
                    RentalOrderLine.Modify(true);
            until RentalOrderLine.Next() = 0;
    end;

    procedure GetNoSeriesCode(): Code[20]
    begin
        exit(NoSeriesMgt.GetNoSeriesWithCheck(RentalSetup."Order Nos.", false, "No. Series"));
    end;

    trigger OnDelete()
    var
        RentalOrderLine: Record "Rental Order Line";
    begin
        RentalOrderLine.SetRange("Order No.", Rec."No.");
        RentalOrderLine.DeleteAll(true);
    end;

    var
        RentalSetup: Record "Rental Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}