<%@ Page Title="Attendance Entry Configuration" Language="C#" MasterPageFile="~/MasterPages/UserMasterPage.master" AutoEventWireup="true" CodeFile="AttendanceEntryConfiguration.aspx.cs" Inherits="AttendanceEntryConfiguration" %>

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



            function ValidateAttEntConfig() {
                var str = '';
                if ($("#txtbtnsubtxt").val() == undefined || $("#txtbtnsubtxt").val() == "") {
                    str += 'Submit Button Text Required.<br/>';
                }

                if ($("#txtbtnsubmsg").val() == undefined || $("#txtbtnsubmsg").val() == "") {
                    str += 'Submit Button Confirmation Message Text Required.<br/>';
                }

                if (str != '') {
                    showError(str, null, 10000);
                    return false;
                }
                else {
                    return true;
                }
            }
           
        </script>
    </telerik:RadCodeBlock>

    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" ClientEvents-OnRequestStart="onRequestStart" LoadingPanelID="RadAjaxLoadingPanel1">
        <div class="widget">

            <table style="margin-top:25px;">
                <tr>
                    <td style="padding-bottom: 15px; padding-right: 18px;">
                        <asp:Label ID="lblbtnsubtxt" CssClass="ConfigLabel" runat="server" Text="Submit button text:"></asp:Label>
                        <asp:TextBox ID="txtbtnsubtxt" Style="width: 200px;" runat="server" Text="Submit" ClientIDMode="Static"></asp:TextBox>

                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="rfvtxtbtnsubtxt" Style="float: left" runat="server" ErrorMessage="*"
                            ForeColor="Red" Display="Dynamic" ControlToValidate="txtbtnsubtxt" ValidationGroup="FrmSubmit"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td style="padding-bottom: 15px;padding-right: 18px;">
                        <asp:Label ID="lblbtnsubmsg" CssClass="ConfigLabel" runat="server" Text="Submit button Confirmation message text:"></asp:Label>
                        <asp:TextBox ID="txtbtnsubmsg" style="width:200px;" runat="server" Text="Are you sure." ClientIDMode="Static" ></asp:TextBox>
                       
                    </td>
                    <td>
                         <asp:RequiredFieldValidator ID="rfvtxtbtnsubmsg" Style="float: left" runat="server" ErrorMessage="*" 
                            ForeColor="Red" Display="Dynamic" ControlToValidate="txtbtnsubmsg" ValidationGroup="FrmSubmit"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td style="padding-bottom: 15px;">
                        <asp:Label ID="lblisddlposvis" CssClass="ConfigLabel" runat="server" Text="Is position dropdown visible:"></asp:Label>
                        <telerik:RadCheckBox ID="cbxisddlposvis" runat="server"  ></telerik:RadCheckBox>
                    </td>
                </tr>
                <tr>
                    <td style="padding-bottom: 15px;">
                        <asp:Label ID="lblcpypremval" CssClass="ConfigLabel" runat="server" Text="Allow to copy Premium values:"></asp:Label>
                        <telerik:RadCheckBox ID="cbxcpypremval" runat="server" ></telerik:RadCheckBox>
                    </td>
                </tr>
                <tr>
                    <td style="padding-bottom: 15px;">
                        <asp:Label ID="lblcpyhrtval" CssClass="ConfigLabel" runat="server" Text="Allow to copy Hour type values:"></asp:Label>
                        <telerik:RadCheckBox ID="cbxcpyhrtval" runat="server" ></telerik:RadCheckBox>
                    </td>
                </tr>

                <tr>
                    <td style="padding-bottom: 15px;">
                        <asp:Label ID="lblallowedit" CssClass="ConfigLabel" runat="server" Text="Allow edit from tab3 & tab4:"></asp:Label>
                        <telerik:RadCheckBox ID="cbxallowedit" runat="server" ></telerik:RadCheckBox>
                    </td>
                </tr>
                <tr>
                    <td style="padding-bottom: 15px;">
                        <asp:Label ID="lblisprthisreq" CssClass="ConfigLabel" runat="server" Text="Is Premium type history required:"></asp:Label>
                        <telerik:RadCheckBox ID="cbxisprthisreq" runat="server" ></telerik:RadCheckBox>
                    </td>
                </tr>
                <tr>
                    <td style="padding-bottom: 15px;">
                        <asp:Label ID="lblishrthisreq" CssClass="ConfigLabel" runat="server" Text="Is Hour type history required:"></asp:Label>
                        <telerik:RadCheckBox ID="cbxishrthisreq" runat="server" ></telerik:RadCheckBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="wizButtons">
                            <span class="wNavButtons">

                                <asp:Button ID="rBtnSave" runat="server"  Text="Save" CausesValidation="true" ValidationGroup="FrmSubmit"
                                     OnClientClick="if (!ValidateAttEntConfig()) { return false;};" OnClick="rBtnSave_Click"
                                     class="button greenB"  ></asp:Button><%--ClientIDMode="Static"--%>

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




