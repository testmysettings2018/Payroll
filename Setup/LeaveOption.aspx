<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/UserMasterPage.master" AutoEventWireup="true" CodeFile="LeaveOption.aspx.cs" Inherits="LeaveOption" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ControlContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="mainContentPlaceHolder" Runat="Server">
    <fieldset>
        <div class="widget">
            <div class="title">
                <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" />
                <h6>Leave Options</h6>
                <div style="float: right; margin-top: 5px; margin-right: 10px;">
                    <asp:Button ID="rbutUpdate" runat="server" AutoPostBack="false" Text="Update" OnClick="rbutUpdate_Click" Width="250px"></asp:Button>
                </div>
            </div>


            <div class="formRow">
                <div class="formRight width40Perc">

                    <asp:CheckBox ID="chkBoxAllowAdvanceLeave" Text="Allow for Advance Leave (Negative Balance)" runat="server" AutoPostBack="true" />
                </div>
                <div class="formRight width40Perc">

                    <asp:CheckBox ID="chbBoxShowPlannedLeave" Text="Show Planned Leave" runat="server" AutoPostBack="true" />
                </div>
                <div class="clear"></div>

            </div>
            <div class="formRow">
                <div class="formRight width40Perc">

                    <asp:CheckBox ID="CheckBox1" Text="Check for Expiry Document on Leave" runat="server" AutoPostBack="true" />
                </div>
                <div class="formRight width40Perc">

                    <asp:CheckBox ID="CheckBox2" Text="Leave Approval Required" runat="server" AutoPostBack="true" />
                </div>
                <div class="clear"></div>

            </div>
            <div class="formRow">
                <div class="formRight width40Perc">

                    <asp:CheckBox ID="CheckBox3" Text="Warns When Vacation Available Falls Below Zero" runat="server" AutoPostBack="true" />
                </div>
                <div class="formRight width40Perc">

                    <asp:CheckBox ID="CheckBox4" Text="Exclude employee salary from payroll process" runat="server" AutoPostBack="true" />
                </div>
                <div class="clear"></div>

            </div>
             <div class="formRow">
                <div class="formRight width40Perc">

                    <asp:CheckBox ID="CheckBox5" Text="Check for Leave in Same Department" runat="server" AutoPostBack="true" />
                </div>
                <div class="formRight width40Perc" >

                    <asp:CheckBox ID="CheckBox6" Text="Recalculate Leave Balance for EOS" runat="server" AutoPostBack="true" />
                </div>
                <div class="clear"></div>

            </div>
             <div class="formRow">
                <div class="formRight width40Perc">

                    <asp:CheckBox ID="CheckBox7" Text="Check for Leave in the Same Position" runat="server" AutoPostBack="true" />
                </div>
                <div class="formRight width40Perc">

                    <asp:CheckBox ID="CheckBox8" Text="User Special Allowance for Replacement ID" runat="server" AutoPostBack="true" />
                </div>
                <div class="clear"></div>

            </div>

            <div class="formRow">
                <label>
                    Leave Balance Option
                </label>
                <div class="formRight">
                    <asp:DropDownList runat="server" ID="DropDownList1" Width="150px" />
                 <label class="marginleft2Perc">
                   Month
                </label>
                    <asp:DropDownList runat="server" ID="DropDownList2" Width="150px" />
                 <label class="marginleft2Perc">
                    Day
                </label>
                    <asp:DropDownList runat="server" ID="DropDownList3" Width="150px" />
              
                      </div>
                <div class="clear"></div>

            </div>
            <div class="formRow">
                <label>Cutt Off Date</label>
                <div class="formRight">
                   <telerik:RadDatePicker ID="fixture_date" runat="server" Culture="en-US" Style="margin: 2px; padding: 1px 0px;" Width="175px">
                            <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" DayCellToolTipFormat=" MM, dd, yyyy"></Calendar>
                            <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>
                        </telerik:RadDatePicker>
                </div>
                <div class="clear"></div>

            </div>
            <div class="formRow">
                <label>New Employee Anual Leave</label>
                <div class="formRight">
                    <asp:DropDownList runat="server" ID="ddl_documentupload" Width="150px" />
                </div>
                <div class="clear"></div>

            </div>
        </div>
    </fieldset>

</asp:Content>

