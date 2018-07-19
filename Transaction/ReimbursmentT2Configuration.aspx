<%@ Page Title="ReimbursmentT2 Configuration" Language="C#" MasterPageFile="~/MasterPages/UserMasterPage.master" AutoEventWireup="true" CodeFile="ReimbursmentT2Configuration.aspx.cs" Inherits="ReimbursmentT2Configuration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ControlContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="mainContentPlaceHolder" runat="Server">
   
    <style>

        .ConfigLabel
        {
            float: left;
            padding-left: 10px;
            width: 300px;
            font-size: 15px;
        }
        
    </style>
     <telerik:RadCodeBlock ID="rcb1" runat="server">
        <script type="text/javascript">
            function onRequestStart(sender, args) {
                if (args.get_eventTarget().indexOf("btnEmployeeExcelExport") >= 0 ||
                    args.get_eventTarget().indexOf("LinkEmployeeExcelExport") >= 0 ||
                        args.get_eventTarget().indexOf("btnEmployeeCsvExport") >= 0 ||
                        args.get_eventTarget().indexOf("LinkEmployeeCsvExport") >= 0 ||
                        args.get_eventTarget().indexOf("btnEmployeePdfExport") >= 0 ||
                        args.get_eventTarget().indexOf("LinkEmployeePdfExport") >= 0 ||
                        args.get_eventTarget().indexOf("btnEmployeePrint") >= 0 ||
                        args.get_eventTarget().indexOf("LinkbtnEmployeePrint") >= 0 ||
                        args.get_eventTarget().indexOf("btnEmployeeRefresh") >= 0 ||
                        args.get_eventTarget().indexOf("LinkEmployeeRefresh") >= 0
                    ) {
                    args.set_enableAjax(false);
                }
            }
            
           
        </script>
    </telerik:RadCodeBlock>

    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" ClientEvents-OnRequestStart="onRequestStart" LoadingPanelID="RadAjaxLoadingPanel1">
        <div class="widget">

            <table style="margin-top:25px;">
                
                <tr>
                    <td style="padding-bottom: 15px;">
                        <asp:Label ID="lblisprjvis" CssClass="ConfigLabel" runat="server" Text="Is project dropdown visible:"></asp:Label>
                        <telerik:RadCheckBox ID="cbxisprjvis" runat="server" ></telerik:RadCheckBox>
                    </td>
                </tr>
                <tr>
                    <td style="padding-bottom: 15px;padding-right:18px">
                        <asp:Label ID="lblisvndrvis" CssClass="ConfigLabel" runat="server" Text="Is vendor visible:"></asp:Label>
                        <telerik:RadCheckBox ID="cbxisvndrvis" runat="server" ></telerik:RadCheckBox>
                    </td>
                </tr>
                <tr>
                    <td style="padding-bottom: 15px;padding-right:18px">
                        <asp:Label ID="lblisexphisreq" CssClass="ConfigLabel" runat="server" Text="Is expense history required:"></asp:Label>
                        <telerik:RadCheckBox ID="cbxisexphisreq" runat="server" ></telerik:RadCheckBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="wizButtons">
                            <span class="wNavButtons">

                                <asp:Button ID="rBtnSave" runat="server" OnClick="rBtnSave_Click" Text="Save"
                                    ValidationGroup="FrmSubmit" class="button greenB" CausesValidation="true"></asp:Button>

                                <asp:Button ID="rbtnCancel" runat="server" OnClick="rbtnCancel_Click" Text="Cancel"
                                    ValidationGroup="FrmSubmit" class="button blueB" CausesValidation="false"></asp:Button>

                            </span>
                        </div>
                    </td>
                </tr>

            </table>

        </div>
    </telerik:RadAjaxPanel>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" IsSticky="true" runat="server" Transparency="20" Skin="Telerik">
    </telerik:RadAjaxLoadingPanel>
</asp:Content>




