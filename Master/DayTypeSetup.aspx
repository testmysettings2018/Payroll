<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/UserMasterPage.master" AutoEventWireup="true" CodeFile="DayTypeSetup.aspx.cs" Inherits="Payroll_DayType" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ControlContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="mainContentPlaceHolder" runat="Server">
    <telerik:RadCodeBlock ID="rcb1" runat="server">
        <script type="text/javascript">
            function onRequestStart(sender, args) {
                if (args.get_eventTarget().indexOf("btnDayTypeExcelExport") >= 0 ||
                  args.get_eventTarget().indexOf("LinkDayTypeExcelExport") >= 0 ||
                      args.get_eventTarget().indexOf("btnDayTypeCsvExport") >= 0 ||
                      args.get_eventTarget().indexOf("LinkDayTypeCsvExport") >= 0 ||
                      args.get_eventTarget().indexOf("btnDayTypePdfExport") >= 0 ||
                      args.get_eventTarget().indexOf("LinkDayTypePdfExport") >= 0 ||
                      args.get_eventTarget().indexOf("btnDayTypePrint") >= 0 ||
                      args.get_eventTarget().indexOf("LinkbtnDayTypePrint") >= 0 ||
                      args.get_eventTarget().indexOf("btnDayTypeRefresh") >= 0 ||
                      args.get_eventTarget().indexOf("LinkDayTypeRefresh") >= 0
                  ) {
                    args.set_enableAjax(false);
                }
            }
            function ValidateDayType(txtbxCodeId, txtDescriptionId) {
                var str = '';
                if ($('#' + txtbxCodeId).val() == undefined || $('#' + txtbxCodeId).val() == "") {
                    str = 'DayType Code Required.<br/>';
                }
                if ($('#' + txtDescriptionId).val() == undefined || $('#' + txtDescriptionId).val() == "") {
                    str += 'Description Required.<br/>';
                }
                if (str != '') {
                    showError(str, null, 10000);
                }
            }

            function ShowReport(Reportname) {
                window.open("../Reports/LaunchReport.aspx?Reportname=" + Reportname);
                return false;
            }
        </script>
    </telerik:RadCodeBlock>
    <div class="widget">

        <fieldset>
            <div class="widget">
                <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" ClientEvents-OnRequestStart="onRequestStart" LoadingPanelID="RadAjaxLoadingPanel1">
                    <div class="formRight">
                        <telerik:RadGrid ID="gvDayType" runat="server" AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="True"
                            AutoGenerateColumns="False" CellSpacing="0" GridLines="None" OnInsertCommand="gvDayType_InsertCommand"
                            OnNeedDataSource="gvDayType_NeedDataSource" PageSize="20" OnDeleteCommand="gvDayType_DeleteCommand"
                            OnUpdateCommand="gvDayType_UpdateCommand" ShowStatusBar="false" OnItemDataBound="gvDayType_ItemDataBound"
                            OnItemCommand="gvDayType_ItemCommand" OnDetailTableDataBind="gvDayType_DetailTableDataBind" OnItemCreated="gvDayType_ItemCreated">
                            <FilterMenu EnableImageSprites="False">
                            </FilterMenu>
                            <ClientSettings>
                                <Selecting CellSelectionMode="None"></Selecting>
                            </ClientSettings>
                            <ExportSettings
                                HideStructureColumns="true"
                                ExportOnlyData="true"
                                IgnorePaging="true"
                                OpenInNewWindow="true">
                                <Csv ColumnDelimiter="Tab" RowDelimiter="NewLine" FileExtension="TXT" EncloseDataWithQuotes="false" />
                                <Pdf PaperSize="A4">
                                </Pdf>
                            </ExportSettings>
                            <MasterTableView CommandItemDisplay="Top" AutoGenerateColumns="False" DataKeyNames="recidd"
                                InsertItemPageIndexAction="ShowItemOnCurrentPage" EditMode="InPlace">
                                <DetailTables>
                                </DetailTables>
                                <CommandItemTemplate>
                                    <div class="title">
                                        <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Day Type Setup</h6>
                                    </div>
                                    <tr class="rgCommandRow">

                                        <td colspan="8" class="rgCommandCell">

                                            <table style="width: 100%;" summary="Command item for additional functionalities for the grid like adding a new record and exporting." class="rgCommandTable">
                                                <caption>

                                                    <span style="display: none">Command item</span>
                                                </caption>
                                                <thead>
                                                    <tr>
                                                        <th scope="col"></th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>

                                                        <td align="left">
                                                            <asp:Button ID="Button1" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
                                                        </td>
                                                        <td align="right">
                                                            <asp:Button runat="server" ID="btnDayTypeExcelExport" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />

                                                            <asp:Button runat="server" ID="btnDayTypeCsvExport" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />

                                                            <asp:Button runat="server" ID="btnDayTypePdfExport" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />
                                                            <telerik:RadComboBox ID="ddlPrintOptions" Style="margin: 0px 5px" runat="server" Width="250px" DropDownWidth="250px"></telerik:RadComboBox>

                                                            <asp:Button runat="server" ID="btnDayTypePrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />

                                                            <asp:Button ID="btnDayTypeRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </td>
                                    </tr>
                                </CommandItemTemplate>
                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                </RowIndicatorColumn>
                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                </ExpandCollapseColumn>

                                <Columns>
                                    <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column column"
                                        HeaderText="ID" UniqueName="recidd" ReadOnly="True" DataType="System.Int32" Visible="false">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text=""></ModelErrorMessage>
                                        </ColumnValidationSettings>
                                        <FilterTemplate>
                                            <strong>Search</strong>
                                        </FilterTemplate>
                                    </telerik:GridBoundColumn>

                                    <telerik:GridTemplateColumn DataField="daycod" FilterControlWidth="130px" SortExpression="daycod" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                        HeaderText="Code" UniqueName="daycod">
                                        <ItemTemplate>
                                            <asp:Label ID="lbldaycod" runat="server" Text='<%# Eval("daycod") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 180px; border-bottom: 0px; padding-left: 0px">
                                                        <telerik:RadTextBox ID="txtdaycod" MaxLength="15" Style="float: left" runat="server" Text='<%# Eval("daycod") %>'>
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td style="border-bottom: 0px; padding-left: 0px">
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                            ControlToValidate="txtdaycod"></asp:RequiredFieldValidator></td>

                                                </tr>
                                            </table>

                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="dayds1" FilterControlWidth="130px" AutoPostBackOnFilter="true" SortExpression="dayds1" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                        HeaderText="Description" UniqueName="dayds1">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("dayds1") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 300px; border-bottom: 0px; padding-left: 0px">
                                                        <telerik:RadTextBox ID="txtdayds1" MaxLength="200" runat="server" Text='<%# Eval("dayds1") %>'>
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td style="border-bottom: 0px; padding-left: 0px">
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6111" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                            ControlToValidate="txtdayds1"></asp:RequiredFieldValidator>
                                                </tr>
                                            </table>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="dayds2" FilterControlWidth="130px" AutoPostBackOnFilter="true" SortExpression="dayds2" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                        HeaderText="Description 2" UniqueName="dayds2">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDescription2" runat="server" Text='<%# Eval("dayds2") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 300px; border-bottom: 0px; padding-left: 0px">
                                                        <telerik:RadTextBox ID="txtdayds2" MaxLength="200" runat="server" Text='<%# Eval("dayds2") %>'>
                                                        </telerik:RadTextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn Visible="false" DataField="daywkd" AllowFiltering="false" FilterControlAltText="Filter TemplateColumn44 column"
                                        HeaderText="Weekend" UniqueName="daywkd">
                                        <ItemTemplate>
                                            <asp:Image ID="imgdaywkd" runat="server" ImageUrl='<%# getImagePathForTrue(bool.Parse(Eval("daywkd").ToString())) %>'
                                                Visible='<%# Eval("daywkd") %>' />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                                        <asp:CheckBox runat="server" ID="chkbxdaywkd" Text="" Checked='<%# CheckBoxValue( Eval("daywkd")) %>' />
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn Visible="false" DataField="daygov" AllowFiltering="false" FilterControlAltText="Filter TemplateColumn449 column"
                                        HeaderText="Goverment Holiday" UniqueName="daygov">
                                        <ItemTemplate>
                                            <asp:Image ID="imgdaygov" runat="server" ImageUrl='<%# getImagePathForTrue(bool.Parse(Eval("daygov").ToString())) %>'
                                                Visible='<%# Eval("daygov") %>' />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                                        <asp:CheckBox runat="server" ID="chkbxdaygov" Text="" Checked='<%# CheckBoxValue( Eval("daygov")) %>' />
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn Visible="false" DataField="dayrel" AllowFiltering="false" FilterControlAltText="Filter TemplateColumn474 column"
                                        HeaderText="Religious Holiday" UniqueName="dayrel">
                                        <ItemTemplate>
                                            <asp:Image ID="imgdayrel" runat="server" ImageUrl='<%# getImagePathForTrue(bool.Parse(Eval("dayrel").ToString())) %>'
                                                Visible='<%# Eval("dayrel") %>' />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                                        <asp:CheckBox runat="server" ID="chkbxdayrel" Text="" Checked='<%# CheckBoxValue( Eval("dayrel")) %>' />      
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column" UniqueName="EditDayType"
                                        ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </telerik:GridEditCommandColumn>
                                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this DayType?"
                                        ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                        UniqueName="DeleteDayType" ConfirmTextFormatString='Are you sure to delete DayType record # "{0}"?'>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </telerik:GridButtonColumn>
                                </Columns>
                                <EditFormSettings CaptionFormatString='Edit Details for DayType # "{0}":' CaptionDataField="recidd">
                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                    </EditColumn>
                                    <EditColumn ButtonType="ImageButton" />
                                </EditFormSettings>
                            </MasterTableView>

                        </telerik:RadGrid>
                    </div>
                </telerik:RadAjaxPanel>
                <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Default" Transparency="20">
                </telerik:RadAjaxLoadingPanel>
            </div>
        </fieldset>
    </div>
</asp:Content>


