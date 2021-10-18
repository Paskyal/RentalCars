page 50102 "Rental Order Card"
{
    Caption = 'Rental Order';
    PageType = Card;
    SourceTable = "Rental Order";
    UsageCategory = Lists;
    ApplicationArea = all;
    PromotedActionCategories = 'New,Process,Report,Approve,Release,Posting,Prepare,Order,Request Approval,History,Print/Send,Navigate';
    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer Name';
                    ShowMandatory = true;
                    ToolTip = 'Specifies the name of the customer who will receive the products and be billed by default.';
                }
                field("Rental Customer Discount"; Rec."Rental Customer Discount")
                {
                    ToolTip = 'Specifies the value of the Customer Discount field';
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Salesperson Code field.';
                }
                field("Salesperson Name"; Rec."Salesperson Name")
                {
                    ToolTip = 'Specifies the value of the Salesperson Name field';
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field';
                    ApplicationArea = All;
                }
            }
            part("Rental Order Line Part"; "Rental Order Line Part")
            {
                SubPageLink = "Order No." = field("No.");
                ApplicationArea = all;
                UpdatePropagation = Both;
            }
        }
        area(factboxes)
        {
            part(ItemPicture; "Item Picture")
            {
                ApplicationArea = All;
                Caption = 'Car Photo';
                Provider = "Rental Order Line Part";
                SubPageLink = "No." = field("Car No.");
            }

            part(RentalLinesDetails; "Rental Line FactBox")
            {
                ApplicationArea = All;
                Caption = 'Rental Line Details';
                Provider = "Rental Order Line Part";
                SubPageLink = "Car No." = field("Car No.");
            }
        }
    }
    actions
    {
        area(processing)
        {
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(Post)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                    trigger OnAction()
                    begin
                        PostRentalOrder(CODEUNIT::"Rental Posted Order")//, "Navigate After Posting"::"Posted Document");
                    end;
                }
            }
        }
    }
    local procedure PostRentalOrder(PostingCodeunitID: Integer)
    begin
        SendToPosting(PostingCodeunitID);
    end;

    procedure SendToPosting(PostingCodeunitID: Integer) IsSuccess: Boolean
    begin
        Commit();
        IsSuccess := CODEUNIT.Run(PostingCodeunitID, Rec);
        ShowPostedConfirmationMessage();
    end;

    local procedure ShowPostedConfirmationMessage();
    var
        RentalOrder: Record "Rental Order";
        RentalPostedOrder: Record "Rental Posted Order";
        InstructionMgt: Codeunit "Instruction Mgt.";
        OpenPostedRentalOrderQst: Label 'The order is posted as number %1 and moved to the Posted Rental Orders window.\\Do you want to open the posted order?', Comment = '%1 = posted document number';
    begin
        if not RentalOrder.Get(Rec."No.") then begin
            RentalPostedOrder.FindLast();
            if InstructionMgt.ShowConfirm(StrSubstNo(OpenPostedRentalOrderQst, RentalPostedOrder."No."),
                 InstructionMgt.ShowPostedConfirmationMessageCode())
            then
                PAGE.Run(PAGE::"Rental Posted Order Card", RentalPostedOrder);
        end;
    end;


}
