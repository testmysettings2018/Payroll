<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EditLeaveTransaction.aspx.cs" MasterPageFile="~/MasterPages/Main.master" Inherits="EditLeaveTransaction" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="~/Controls/ucEmployeeCard.ascx" TagPrefix="uc1" TagName="ucEmployeeCard" %>


<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <style type="text/css">
        .style1 {
            height: 15px;
        }
        body {
            background: white !important;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">

    <script type="text/javascript">

        function CloseAndRebind(msg) {
            //alert("CloseAndRebind");
            GetRadWindow().BrowserWindow.refreshGrid();
            GetRadWindow().BrowserWindow.showSuccessMessage(msg);
            GetRadWindow().close();
        }

        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow)
                oWindow = window.radWindow; //Will work in Moz in all cases, including clasic dialog
            else if (window.frameElement.radWindow)
                oWindow = window.frameElement.radWindow; //IE (and Moz as well)

            return oWindow;
        }

        function CancelEdit() {
            GetRadWindow().close();
        }

        function pageLoad() {
            var rID = getParameterByName("LeaveTransactionID");

            if (rID == "") {
                CancelEdit();
            }
        }

        function getParameterByName(name) {
            name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
            var regexS = "[\\?&]" + name + "=([^&#]*)";
            var regex = new RegExp(regexS);
            var results = regex.exec(window.location.search);
            if (results == null)
                return "";
            else
                return decodeURIComponent(results[1].replace(/\+/g, " "));
        }

        (function () {

            window.onClientFileUploaded = function (radAsyncUpload, args) {
                var row = args.get_row(),
                    inputName = radAsyncUpload.getAdditionalFieldID("TextBox"),
                    inputType = "text",
                    inputID = inputName,
                    input = createInput(inputType, inputID, inputName),
                    label = createLabel(inputID),
                    br = document.createElement("br");

                row.appendChild(br);
                row.appendChild(label);
                row.appendChild(input);
            }

            function createInput(inputType, inputID, inputName) {
                var input = document.createElement("input");

                input.setAttribute("type", inputType);
                input.setAttribute("id", inputID);
                input.setAttribute("name", inputName);

                input.style.width = "295px";


                return input;
            }

            function createLabel(forArrt) {
                var label = document.createElement("label");

                label.setAttribute("for", forArrt);
                label.innerHTML = "File info: ";
                label.style.width = "350px";

                return label;
            }

        })();

    </script>

    <telerik:RadCodeBlock ID="RadScriptBlock1" runat="server">
        <script type="text/javascript">
            // on upload button click temporarily disables ajax to perform
            // upload actions
            function conditionalPostback(sender, args) {
                if (args.get_eventTarget() == "<%= rBtnSave.UniqueID %>") {
                    args.set_enableAjax(false);
                }

                if (args.get_eventTarget() == "<%= rBtnSaveAndSubmit.UniqueID %>") {
                    args.set_enableAjax(false);
                }
            }
        </script>
    </telerik:RadCodeBlock>

    <!-- this for dropdown grid common functions-->
    <telerik:RadCodeBlock ID="RadCodeBlock7" runat="server">
        <script type="text/javascript">
            var isSorted = false;
            var ctrlId = "";
            function setSorted(senderID) {
                isSorted = true;
                ctrlId = senderID;
            }
            function OnClientDropDownClosing(sender, eventArgs) {
                if (sender.get_id() == ctrlId && isSorted) {
                    eventArgs.set_cancel(true);
                }
                else {
                    eventArgs.set_cancel(false);
                }
                isSorted = false;
                ctrlId = "";
                if (sender.get_value() == "")
                    sender.set_text("");
            }

            function RowSelect(row, senderID) {
                var combo = $find(senderID);
                setTimeout(function () {
                    combo.set_text($(row).find('td.text').text().trim());
                    combo.set_value($(row).find('td.value').text().trim());
                }, 50);
            }
            function OnClientLoad(editor, args) {
                editor.add_modeChange(function (editor, args) {
                    var mode = editor.get_mode();
                    if (mode == 2) {
                        var htmlMode = editor.get_textArea();  //get a reference to the Html mode textarea
                        htmlMode.disabled = "true";
                    }
                });
            }

            function RowClickedEmployee(sender, args) {
                var cellValues = args.getDataKeyValue("EmployeeFullNameWithID");
                var UserID = args.getDataKeyValue("UserID");

                var combo = $find(sender.ClientID.replace('_i0_rGrdEmployees4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(UserID);
                    combo.commitChanges();
                }, 50);
            }
            function RowClickedBatch(sender, args) {
                var cellValues = args.getDataKeyValue("bchcod");
                var UserID = args.getDataKeyValue("recidd");

                var combo = $find(sender.ClientID.replace('_i0_rGrdBatches4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(UserID);
                    combo.commitChanges();
                }, 50);
            }
            function RowClickedEntryType(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var UserID = args.getDataKeyValue("Value");

                var combo = $find(sender.ClientID.replace('_i0_rGrdEntryTypes4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(UserID);
                    combo.commitChanges();
                }, 50);
            }
            function RowClickedLeaveType(sender, args) {
                var cellValues = args.getDataKeyValue("levtypcod");
                var RecID = args.getDataKeyValue("recidd");

                var combo = $find(sender.ClientID.replace('_i0_rGrdLeaveTypes4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(RecID);
                    combo.commitChanges();
                }, 50);
            }
            function RowClickedLeaveCode(sender, args) {
                var cellValues = args.getDataKeyValue("levcod");
                var UserID = args.getDataKeyValue("recidd");

                var combo = $find(sender.ClientID.replace('_i0_rGrdLeaveCodes4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(UserID);
                    combo.commitChanges();
                }, 50);
            }
            function RowClickedCalander(sender, args) {
                var cellValues = args.getDataKeyValue("grdclc");
                var UserID = args.getDataKeyValue("grdcli");

                var combo = $find(sender.ClientID.replace('_i0_rGrdCalanders4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(UserID);
                    combo.commitChanges();
                }, 50);
            }

            function onRequestStart(sender, args) {
                if (args.get_eventTarget().indexOf("linkButton") >= 0
                   ) {
                    args.set_enableAjax(false);
                }
            }

        </script>
    </telerik:RadCodeBlock>

    <telerik:RadAjaxPanel ID="RadAjaxPanel11" runat="server"   ClientEvents-OnRequestStart="onRequestStart"
        LoadingPanelID="RadAjaxLoadingPanel1" Width="100%" Height="100%">

        <div class="widget">
            <div class="tab_container">
                <div id="tab1" class="tab_content">

                    <div class="fluid">
                        <div class="span8">

                            <div class="widget">
                                <div class="title">
                                    <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" />
                                    <h6>Personal Details</h6>
                                </div>

                                <div class="formRow">
                                    <div class="formCol">
                                        <label>Transaction Number</label>
                                        <div class="formRight">
                                            <label><asp:Literal runat="server" ID="lblTransactionNumber"></asp:Literal></label>
                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                <div class="formRow">
                                    <div class="formCol">
                                        <label>Employee</label>
                                        <div class="formRight">
                                            <telerik:RadComboBox ID="rCmbEmployee" runat="server" Width="400px" DropDownWidth="400px"
                                                 OnSelectedIndexChanged="rCmbEmployee_SelectedIndexChanged" 
                                                EmptyMessage="Please select...">
                                                <ItemTemplate>
                                                    <telerik:RadGrid ID="rGrdEmployees4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                        CellSpacing="0" GridLines="None" Width="400px" 
                                                        ClientSettings-EnableRowHoverStyle="True" 
                                                        OnItemCommand="rGrdEmployees4DDL_ItemCommand"
                                                       OnDataBound="rGrdEmployees4DDL_DataBound"
                                                        >
                                                     
                                                        <MasterTableView DataKeyNames="UserID,EmployeeID" ClientDataKeyNames="UserID,EmployeeID,EmployeeFullNameWithID">
                                                            <Columns>
                                                                <telerik:GridBoundColumn DataField="UserID" FilterControlAltText="Filter column column"
                                                                    HeaderText="User ID" UniqueName="column">
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="EmployeeID" FilterControlAltText="Filter column1 column"
                                                                    HeaderText="Employee ID" UniqueName="column1">
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="EmployeeFullNameWithID" FilterControlAltText="Filter column2 column"
                                                                    HeaderText="Name" UniqueName="column2">
                                                                </telerik:GridBoundColumn>
                                                            </Columns>
                                                        </MasterTableView>
                                                        <ClientSettings EnablePostBackOnRowClick="true">
                                                            <Selecting AllowRowSelect="true"></Selecting>
                                                            <ClientEvents OnRowClick="RowClickedEmployee"></ClientEvents>
                                                        </ClientSettings>
                                                    </telerik:RadGrid>
                                                </ItemTemplate>
                                                <Items>
                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                </Items>
                                            </telerik:RadComboBox>

                                            <asp:RequiredFieldValidator
                                                ID="RequiredFieldValidator2"
                                                ControlToValidate="rCmbEmployee"
                                                ErrorMessage="*"
                                                Display="Dynamic"
                                                CssClass="requiredvalidators"
                                                ValidationGroup="FrmSubmit"
                                                SetFocusOnError="False"
                                                runat="server"></asp:RequiredFieldValidator>

                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                <div class="formRow">
                                    <div class="formCol">
                                        <label>Calander</label>
                                        <div class="formRight">
                                            <telerik:RadComboBox ID="rCmbCalander" runat="server" Width="400px" DropDownWidth="400px" EmptyMessage="Please select...">
                                                <ItemTemplate>
                                                    <telerik:RadGrid ID="rGrdCalanders4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                        CellSpacing="0" GridLines="None" Width="400px" ClientSettings-EnableRowHoverStyle="True">
                                                        <ClientSettings>
                                                            <Selecting AllowRowSelect="true"></Selecting>
                                                        </ClientSettings>
                                                        <MasterTableView DataKeyNames="grdcli" ClientDataKeyNames="grdcli,grdclc">
                                                            <Columns>
                                                                <telerik:GridBoundColumn DataField="grdcli" FilterControlAltText="Filter column column" HeaderText="ID" UniqueName="column">
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="grdclc" FilterControlAltText="Filter column1 column" HeaderText="Code" UniqueName="column1">
                                                                </telerik:GridBoundColumn>
                                                            </Columns>
                                                        </MasterTableView>
                                                        <ClientSettings>
                                                            <ClientEvents OnRowClick="RowClickedCalander"></ClientEvents>
                                                        </ClientSettings>
                                                    </telerik:RadGrid>
                                                </ItemTemplate>
                                                <Items>
                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                </Items>
                                            </telerik:RadComboBox>

                                            
                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                <div class="formRow">
                                    <div class="formCol">
                                        <label>Entry Type</label>
                                        <div class="formRight">
                                            <telerik:RadComboBox ID="rCmbEntryType" runat="server" Width="400px" DropDownWidth="400px"
                                                 EmptyMessage="Please select...">
                                                <ItemTemplate>
                                                    <telerik:RadGrid ID="rGrdEntryTypes4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                        CellSpacing="0" GridLines="None" Width="400px" ClientSettings-EnableRowHoverStyle="True"
                                                         OnItemCommand="rGrdEntryTypes4DDL_ItemCommand" >
                                                        <ClientSettings>
                                                            <Selecting AllowRowSelect="true"></Selecting>
                                                        </ClientSettings>
                                                        <MasterTableView DataKeyNames="Value" ClientDataKeyNames="Value,Text">
                                                            <Columns>
                                                                <telerik:GridBoundColumn DataField="Value" FilterControlAltText="Filter column column" HeaderText="ID" UniqueName="column">
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="Text" FilterControlAltText="Filter column1 column" HeaderText="Entry Type" UniqueName="column1">
                                                                </telerik:GridBoundColumn>
                                                            </Columns>
                                                        </MasterTableView>
                                                       <ClientSettings EnablePostBackOnRowClick="true">
                                                            <ClientEvents OnRowClick="RowClickedEntryType"></ClientEvents>
                                                        </ClientSettings>
                                                    </telerik:RadGrid>
                                                </ItemTemplate>
                                                <Items>
                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                </Items>
                                            </telerik:RadComboBox>

                                            <asp:RequiredFieldValidator
                                                ID="RequiredFieldValidator3"
                                                ControlToValidate="rCmbEntryType"
                                                ErrorMessage="*"
                                                Display="Dynamic"
                                                CssClass="requiredvalidators"
                                                ValidationGroup="FrmSubmit"
                                                SetFocusOnError="False"
                                                runat="server"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>

                                <div class="formRow">
                                    <div class="formCol">
                                        <label>Leave Type</label>
                                        <div class="formRight">
                                            <telerik:RadComboBox ID="rCmbLeaveType" runat="server" Width="400px" DropDownWidth="400px" EmptyMessage="Please select...">
                                                <ItemTemplate>
                                                    <telerik:RadGrid ID="rGrdLeaveTypes4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                        CellSpacing="0" GridLines="None" Width="400px" ClientSettings-EnableRowHoverStyle="True" 
                                                        OnItemCommand="rGrdLeaveTypes4DDL_ItemCommand"  >
                                                        <MasterTableView DataKeyNames="recidd" ClientDataKeyNames="recidd,levtypcod">
                                                            <Columns>
                                                                <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column column" HeaderText="ID" UniqueName="column">
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="levtypcod" FilterControlAltText="Filter column1 column" HeaderText="Leave Type" UniqueName="column1">
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="levdsc" FilterControlAltText="Filter column1 column" HeaderText="Description" UniqueName="column1">
                                                                </telerik:GridBoundColumn>
                                                            </Columns>
                                                        </MasterTableView>
                                                        <ClientSettings EnablePostBackOnRowClick="true">
                                                            <Selecting AllowRowSelect="true"></Selecting>
                                                            <ClientEvents OnRowClick="RowClickedLeaveType"></ClientEvents>
                                                        </ClientSettings>
                                                    </telerik:RadGrid>
                                                </ItemTemplate>
                                                <Items>
                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                </Items>
                                            </telerik:RadComboBox>

                                            <asp:RequiredFieldValidator
                                                ID="RequiredFieldValidator4"
                                                ControlToValidate="rCmbLeaveType"
                                                ErrorMessage="*"
                                                Display="Dynamic"
                                                CssClass="requiredvalidators"
                                                ValidationGroup="FrmSubmit"
                                                SetFocusOnError="False"
                                                runat="server"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                <div class="formRow">
                                    <div class="formCol">
                                        <label>Leave Code</label>
                                        <div class="formRight">
                                            <telerik:RadComboBox ID="rCmbLeaveCode" runat="server" Width="400px" DropDownWidth="400px" EmptyMessage="Please select...">
                                                <ItemTemplate>
                                                    <telerik:RadGrid ID="rGrdLeaveCodes4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                        CellSpacing="0" GridLines="None" Width="400px" ClientSettings-EnableRowHoverStyle="True"
                                                       
                                                            OnItemCommand="rGrdLeaveCodes4DDL_ItemCommand"
                                                        >
                                                        <MasterTableView DataKeyNames="recidd" ClientDataKeyNames="recidd,levcod">
                                                            <Columns>
                                                                <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column column" HeaderText="ID" UniqueName="column">
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="levcod" FilterControlAltText="Filter column1 column" HeaderText="Code" UniqueName="column1">
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="levdsc" FilterControlAltText="Filter column1 column" HeaderText="Description" UniqueName="column1">
                                                                </telerik:GridBoundColumn>
                                                            </Columns>
                                                        </MasterTableView>
                                                        <ClientSettings>
                                                            <Selecting AllowRowSelect="true"></Selecting>
                                                            <ClientEvents OnRowClick="RowClickedLeaveCode"></ClientEvents>
                                                        </ClientSettings>
                                                    </telerik:RadGrid>
                                                </ItemTemplate>
                                                <Items>
                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                </Items>
                                            </telerik:RadComboBox>

                                            <asp:RequiredFieldValidator
                                                ID="RequiredFieldValidator5"
                                                ControlToValidate="rCmbLeaveCode"
                                                ErrorMessage="*"
                                                Display="Dynamic"
                                                CssClass="requiredvalidators"
                                                ValidationGroup="FrmSubmit"
                                                SetFocusOnError="False"
                                                runat="server"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>

                                <div class="formRow">
                                    <div class="formCol">
                                        <label>From Date</label>
                                        <div class="formRight">
                                            <telerik:RadDatePicker ID="txtFromDate" runat="server" DateInput-DateFormat="MM/dd/yyyy" AutoPostBack="true"
                                                 OnSelectedDateChanged="txtFromDate_SelectedDateChanged"></telerik:RadDatePicker>
                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                <div class="formRow">
                                    <div class="formCol">
                                        <label>To Date</label>
                                        <div class="formRight">
                                            <telerik:RadDatePicker ID="txtToDate" runat="server" DateInput-DateFormat="MM/dd/yyyy" AutoPostBack="true"
                                                 OnSelectedDateChanged="txtToDate_SelectedDateChanged"></telerik:RadDatePicker>
                                        </div>
                                    </div>

                                    <div class="clear"></div>
                                </div>



                                <div class="formRow">
                                    <div class="formCol">
                                        <label>Rejoining Date</label>
                                        <div class="formRight">
                                            <telerik:RadDatePicker ID="txtRejoiningDate" runat="server" DateInput-DateFormat="MM/dd/yyyy"></telerik:RadDatePicker>
                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                <div class="formRow">
                                    <div class="formCol">
                                        <label>Air Ticket Requested</label>
                                        <div class="formRight">
                                            <asp:CheckBox ID="checkAirTicket" runat="server" Text=""></asp:CheckBox>
                                        </div>
                                    </div>

                                    <div class="clear"></div>
                                </div>

                                <div class="formRow">
                                    <div class="formCol">
                                        <label>Number of Days</label>
                                        <div class="formRight" style="width: 50px;">
                                            <telerik:RadTextBox ID="txtNumberOfDays" runat="server" MaxLength="3" Height="25px" AutoPostBack="true">
                                            </telerik:RadTextBox>

                                        </div>
                                    </div>

                                    <div class="clear"></div>
                                </div>

                                <div class="formRow">
                                    <div class="formCol">
                                        <label>Remarks 1</label>
                                        <div class="formRight">
                                            <telerik:RadTextBox ID="txtRemarks1" runat="server" MaxLength="30" Height="25px">
                                            </telerik:RadTextBox>
                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                <div class="formRow">
                                    <div class="formCol">
                                        <label>Remarks 2</label>
                                        <div class="formRight">
                                            <telerik:RadTextBox ID="txtRemarks2" runat="server" MaxLength="30" Height="25px">
                                            </telerik:RadTextBox>
                                        </div>
                                    </div>

                                    <div class="clear"></div>
                                </div>
                                <%--start--%>
                                <div class="formRow">
                                    <div class="formCol">
                                        <label>Attachments</label>
                                        <div class="formRight">
                                            <telerik:RadAsyncUpload runat="server" ID="ruDocument" overwriteexistingfiles="true"
                                                AllowedFileExtensions="txt,pdf,doc,jpg,png,gif,bmp,docx,xlsx"
                                                MultipleFileSelection="Automatic" MaxFileSize="524288"
                                                MaxFileInputsCount="3"
                                                OnClientFileUploaded="onClientFileUploaded"
                                                TemporaryFolder="~\App_Data\RadUploadTemp\">
                                            </telerik:RadAsyncUpload>

                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                <%--end--%>
                            </div>
                        </div>
                        

                        <div class="span4">

                            <uc1:ucEmployeeCard runat="server" ID="ucEmployeeCard" />

                            <div class="widget">

                                <div class="title">
                                    <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" />
                                    <h6>Employee Leave Card</h6>
                                </div>

                                <div class="formRow">
                                    <div class="formCol">
                                        <label>
                                            Brought Forward:
                                            <asp:Literal runat="server" ID="literalBroughtForward"></asp:Literal></label>
                                    </div>
                                    <div class="formCol">
                                        <label>
                                            Leave Taken YTD:
                                            <asp:Literal runat="server" ID="literalLeaveTakenYTD"></asp:Literal></label>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                <div class="formRow">
                                    <div class="formCol">
                                        <label>
                                            Available Balance:
                                            <asp:Literal runat="server" ID="literalAvailableBalance"></asp:Literal></label>
                                    </div>
                                    <div class="formCol">
                                        <label>
                                            Leave Taken LTD:
                                            <asp:Literal runat="server" ID="literalLeaveTakenLTD"></asp:Literal></label>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                <div class="formRow">
                                    <div class="formCol">
                                        <label>
                                            LV Balance AOD:
                                            <asp:Literal runat="server" ID="literalLVBalanceAOD"></asp:Literal></label>
                                    </div>
                                    <div class="formCol">
                                        <label>
                                            Leave Taken AOY:
                                            <asp:Literal runat="server" ID="literalLeaveTakenAOY"></asp:Literal></label>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                <div class="formRow">
                                    <div class="formCol">
                                        <label>
                                            Unposted Leaves:
                                            <asp:Literal runat="server" ID="literalUnpostedLeaves"></asp:Literal></label>
                                    </div>
                                    <div class="formCol">
                                        <label></label>
                                    </div>
                                    <div class="clear"></div>
                                </div>





                                <div class="formRow">
                                    <div class="formCol">
                                        <label>
                                            Calandar Days:
                                            <asp:Literal runat="server" ID="literalCalandarDays"></asp:Literal></label>
                                    </div>
                                    <div class="formCol">
                                        <label>
                                            Adjusted Days:
                                            <asp:Literal runat="server" ID="literalAdjustedDays"></asp:Literal></label>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                <div class="formRow">
                                    <div class="formCol">
                                        <label>
                                            Weekends:
                                            <asp:Literal runat="server" ID="literalWeekends"></asp:Literal></label>
                                    </div>
                                    <div class="formCol">
                                        <label>
                                            Excess Days:
                                            <asp:Literal runat="server" ID="literalExcessDays"></asp:Literal></label>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                <div class="formRow">
                                    <div class="formCol">
                                        <label>
                                            Rest Days:
                                            <asp:Literal runat="server" ID="literalRestDays"></asp:Literal></label>
                                    </div>
                                    <div class="formCol">
                                        <label></label>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                <div class="formRow">
                                    <div class="formCol">
                                        <label>
                                            Public Holidays:
                                            <asp:Literal runat="server" ID="literalPublicHolidays"></asp:Literal></label>
                                    </div>
                                    <div class="formCol">
                                        <label></label>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                <div class="formRow">
                                    <div class="formCol">
                                        <label>
                                            Actual Leave Days:
                                            <asp:Literal runat="server" ID="literalActualLeaveDays"></asp:Literal></label>
                                    </div>
                                    <div class="formCol">
                                        <label></label>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                            </div>
                        </div>

                        <%--start--%>
                        <asp:HiddenField ID="hfTransactionNo" runat="server" />
                        <div class="span4" style="padding:15px">
                              <div class="formCol">
                                    <label></label>
                                    <div class="formRight">
                                        <h3>Uploaded Files</h3>
 
                                 <hr class="qsf-clear-float" />
 
                                <div class="uploaded-files">
                                    <asp:Literal runat="server" ID="ltrNoResults" Visible="True" Text="<strong>No files uploaded</strong>" />
                                    <asp:Repeater runat="server" ID="Repeater1" OnItemCommand="Repeater1_ItemCommand">
                                        <HeaderTemplate>
                                            <ul>
                                        </HeaderTemplate>
                                        <FooterTemplate></ul></FooterTemplate>
                                        <ItemTemplate>
                                                
                                               <li>
                                                <dl>
                                                    <dt>File name : 

                                                    <asp:LinkButton ID="linkButton" ClientIDMode="Static" runat="server" CssClass="linkattachments" Text='<%# DataBinder.Eval(Container.DataItem, "documentname").ToString() %>'
                                                     CommandName="Download" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "idd").ToString() %>' ></asp:LinkButton>

 
                                                    <asp:ImageButton ID="delAttch" runat="server" CommandName="Remove" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "idd").ToString() %>' Text="Delete Attachment"
                                                        ValidationGroup="FrmSubmit" CausesValidation="True" ImageUrl="~/Images/icons/remove.png"></asp:ImageButton>
                                                
                                 
                                                                           </dt>
                                                    <dt>File Description:
                                                       <telerik:RadTextBox ID="txtfiledescription" runat="server" Height="200px" Text='<%# DataBinder.Eval(Container.DataItem, "description").ToString() %>' TextMode="MultiLine" Columns="200" Rows="3"></telerik:RadTextBox>
                                                                            <asp:ImageButton ID="upAttach" runat="server" CommandName="Change" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "idd").ToString() %>' Text="Update"
                                                        ValidationGroup="FrmSubmit" CausesValidation="True" ImageUrl="~/Images/icons/change.png" AlternateText="Update"></asp:ImageButton>
                                
                                                  </dt>
                                                                                                        
                                                </dl>

                                               </li>
                                             
                                            
                                           
                                                                                    </ItemTemplate>
                                    </asp:Repeater>
                                </div>

                                    </div>
                                    
                                                                  </div>
                               <div class="clear"></div>
                        </div>

                        <%--end--%>

                        <div class="clear"></div>
                        <div class="wizButtons">
                            <span class="wNavButtons">

                                <asp:Button ID="rBtnSave" runat="server" OnClick="rBtnSave_Click" Text="Save"
                                    ValidationGroup="FrmSubmit" class="button greenB" CausesValidation="True"></asp:Button>
                                <asp:Button ID="rBtnSaveAndSubmit" runat="server" OnClick="rBtnSaveAndSubmit_Click"
                                    Text="Save and Submit" class="button blueB" ValidationGroup="FrmSubmit" CausesValidation="True"></asp:Button>
                            </span>
                        </div>
                        <div class="clear"></div>
                    </div>
                </div>
            </div>
        </div>
    </telerik:RadAjaxPanel>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />
</asp:Content>
