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

            // trigger OnValidate()
            // var
            //     Salesperson: Record "Salesperson/Purchaser";
            // begin
            //     Rec.Validate("Salesperson Name", Salesperson.Name)
            // end;
        }
        field(3; "Salesperson Name"; Text[100])
        {
            Caption = 'Salesperson Name';
            TableRelation = "Salesperson/Purchaser".Name;
            ValidateTableRelation = false;
            // trigger OnValidate()
            // var
            //     SalespersonName: Text;
            // begin
            //     SalespersonName := "Salesperson Name";
            //     "Salesperson Name" := CopyStr(SalespersonName, 1, MaxStrLen("Salesperson Name"));
            // end;
        }
        field(4; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
            TableRelation = Customer;
            trigger OnValidate()
            begin
                CopyFromCustomer();
                Rec.Validate("Customer Name")
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
            TableRelation = Customer.Name;
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                CustomerName: Text[100];
            begin
                CustomerName := "Customer Name";
                SetCustomerName(CustomerName);
                "Customer Name" := CustomerName;
            end;
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

    // Delete if it is not successful
    procedure LookupCustomerName(): Boolean
    var
        Customer: Record Customer;
    // RecVariant: Variant;
    begin
        if LookupCustomer(Customer) then
            Validate("Customer No.", Customer."No.");
        exit(true);
    end;

    // Delete if it is not successful
    procedure SetCustomerName(var CustomerName: Text[100]): Boolean
    var
        Customer: Record Customer;
    // RecVariant: Variant;
    begin
        if "Customer No." <> '' then
            Customer.Get("Customer No.");

        if Rec."Customer Name" = Customer.Name then
            CustomerName := ''
        else
            CustomerName := Customer.Name;
        // RecVariant := Customer;
        exit(true);
    end;

    procedure LookupCustomer(var Customer: Record Customer): Boolean
    var
        CustomerLookup: Page "Customer Lookup";
        Result: Boolean;
    begin
        CustomerLookup.SetTableView(Customer);
        CustomerLookup.SetRecord(Customer);
        CustomerLookup.LookupMode := true;
        Result := CustomerLookup.RunModal() = ACTION::LookupOK;
        if Result then
            CustomerLookup.GetRecord(Customer)
        else
            Clear(Customer);

        exit(Result);
    end;

    procedure ValidateSalespersonName(var SalespersonName: Text): Boolean
    var
        Salesperson: Record "Salesperson/Purchaser";
    begin
        if "Salesperson Code" <> '' then
            Salesperson.Get("Salesperson Code");
        if Rec."Salesperson Name" = Salesperson.Name then
            SalespersonName := ''
        else
            SalespersonName := Salesperson.Name;
        exit(true);
    end;

    // procedure LookupSalespersonCode(): Boolean //var SalespersonName: Text[100]
    // var
    //     Salesperson: Record "Salesperson/Purchaser";
    // begin
    //     Salesperson.Get("Salesperson Code");
    //     Salesperson.SetRange("Code", Rec."Salesperson Code");

    //     // if "Salesperson Code" <> '' then
    //     //     Salesperson.Get("Salesperson Code");

    //     // "Salesperson Name" := Salesperson.Name;
    //     Rec.Validate("Salesperson Code", Salesperson."Code");
    //     exit(true);
    // end;


    var
        RentalSetup: Record "Rental Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}