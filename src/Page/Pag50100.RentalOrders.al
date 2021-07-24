page 50100 "Rental Orders"
{
    Caption = 'Rental Orders';
    PageType = List;
    SourceTable = "Rental Order";
    CardPageId = "Rental Order Card";
    UsageCategory = Lists;
    ApplicationArea = All;
    PromotedActionCategories = 'New,Process,Report,Request Approval,Order,Release,Posting,Print/Send,Navigate';
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the Doc. No. field';
                    ApplicationArea = All;
                }
                field("Salesperson Name"; Rec."Salesperson Name")
                {
                    ToolTip = 'Specifies the value of the Salesperson No. field';
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer Name';
                    ToolTip = 'Specifies the value of the Customer Name field';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            group(Posting)
            {
                Caption = 'Posting';
                Image = Post;
                action(Post)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Category7;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                    trigger OnAction()
                    begin
                        PostDocument(CODEUNIT::"Rental Posted Order");
                    end;
                }
            }

        }
    }
    local procedure PostDocument(PostingCodeunitID: Integer)
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
                PAGE.Run(PAGE::"Rental Posted Orders", RentalPostedOrder);
        end;
    end;



}