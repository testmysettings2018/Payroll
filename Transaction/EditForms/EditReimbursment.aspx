<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EditReimbursment.aspx.cs" MasterPageFile="~/MasterPages/Main.master" 
    Inherits="EditReimbursment" %>

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

        .filename {
            display : none !important;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">

    <script type="text/javascript">

        function CloseAndRebind(msg) {
            GetRadWindow().BrowserWindow.refreshGrid2();
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
            var rID = getParameterByName("ReimbursmentID");

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
            function RowClickedReimbursment(sender, args) {
                var cellValues = args.getDataKeyValue("bchcod");
                var UserID = args.getDataKeyValue("recidd");

                var combo = $find(sender.ClientID.replace('_i0_rGrdReimbursments4DDL', ''));
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

    <telerik:RadAjaxPanel ID="RadAjaxPanel11" runat="server" LoadingPanelID="RadAjaxLoadingPanel1"  ClientEvents-OnRequestStart="onRequestStart"
         Width="100%" Height="100%">

        <div class="widget">
            <div class="tab_container">
                <div id="tab1" class="tab_content">

                    <div class="fluid">
                        <div class="span8">
                            <div class="widget">
                                <div class="title">
                                    <img src="../../../images/icons/dark/list.png" alt="" class="titleIcon" />
                                    <h6>Personal Details</h6>
                                </div>

                                <div class="formRow">
                                    <div class="formCol">
                                        <label>Requested By</label>
                                        <div class="formRight">

                                            <telerik:RadComboBox ID="rCmbEmployee" runat="server" Width="400px" DropDownWidth="400px" EmptyMessage="Please select...">
                                                <ItemTemplate>
                                                    <telerik:RadGrid ID="rGrdEmployees4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                        CellSpacing="0" GridLines="None" Width="400px" ClientSettings-EnableRowHoverStyle="True">
                                                        <ClientSettings>
                                                            <Selecting AllowRowSelect="true"></Selecting>
                                                        </ClientSettings>
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
                                                        <ClientSettings>
                                                            <ClientEvents OnRowClick="RowClickedEmployee"></ClientEvents>
                                                        </ClientSettings>
                                                    </telerik:RadGrid>
                                                </ItemTemplate>
                                                <Items>
                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                </Items>
                                            </telerik:RadComboBox>
                                        </div>
                                    </div>

                                    <div class="formCol">
                                        <label></label>
                                        <div class="formRight">
                                            <label></label>
                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>

                                <div class="formRow">
                                    <div class="formCol">
                                        <label>Reimbursement Type</label>
                                        <div class="formRight">
                                            <telerik:RadComboBox ID="rCmbReimbursment" runat="server" Width="400px" DropDownWidth="400px" EmptyMessage="Please select...">
                                                <ItemTemplate>
                                                    <telerik:RadGrid ID="rGrdReimbursments4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                        CellSpacing="0" GridLines="None" Width="400px" ClientSettings-EnableRowHoverStyle="True">
                                                        <ClientSettings>
                                                            <Selecting AllowRowSelect="true"></Selecting>
                                                        </ClientSettings>
                                                        <MasterTableView DataKeyNames="recidd" ClientDataKeyNames="recidd,bchcod,bchdsc">
                                                            <Columns>
                                                                <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column column" HeaderText="ID" UniqueName="column">
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="bchcod" FilterControlAltText="Filter column1 column" HeaderText="Batch" UniqueName="column1">
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="bchdsc" FilterControlAltText="Filter column2 column" HeaderText="Description" UniqueName="column2">
                                                                </telerik:GridBoundColumn>
                                                            </Columns>
                                                        </MasterTableView>
                                                        <ClientSettings>
                                                            <ClientEvents OnRowClick="RowClickedReimbursment"></ClientEvents>
                                                        </ClientSettings>
                                                    </telerik:RadGrid>
                                                </ItemTemplate>
                                                <Items>
                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                </Items>
                                            </telerik:RadComboBox>
                                        </div>
                                    </div>
                                    <div class="formCol">
                                        <label></label>
                                        <div class="formRight">
                                            <label></label>
                                        </div>
                                    </div>

                                    <div class="clear"></div>
                                </div>

                                <div class="formRow">

                                    <div class="formCol">
                                        <label>Amount </label>
                                        <div class="formRight"   style="width:100px;">
                                            <telerik:RadNumericTextBox ID="txtAmount" runat="server" MaxLength="10" Height="25px"></telerik:RadNumericTextBox>

                                            <asp:RequiredFieldValidator
                                                ID="RequiredFieldValidator1"
                                                ControlToValidate="txtAmount"
                                                ErrorMessage="*"
                                                Display="Dynamic"
                                                CssClass="requiredvalidators"
                                                ValidationGroup="FrmSubmit"
                                                SetFocusOnError="False"
                                                runat="server"></asp:RequiredFieldValidator>

                                        </div>
                                    </div>
                                    <div class="formCol">
                                        <label></label>
                                        <div class="formRight">
                                            <label></label>
                                        </div>
                                    </div>

                                    <div class="clear"></div>
                                </div>

                                                                  <div class="formRow">
                                <div class="formCol">
                                    <label>Sub Amount 1</label>
                                    <div class="formRight"  style="width:100px;">
                                        <telerik:RadNumericTextBox ID="txtSub1" runat="server" MaxLength="10" Height="25px"></telerik:RadNumericTextBox>

                                    </div>

                                </div>

                                <div class="clear"></div>
                            </div>
                                      <div class="formRow">
                                <div class="formCol">
                                    <label>Sub Amount 2</label>
                                    <div class="formRight"  style="width:100px;">
                                        <telerik:RadNumericTextBox ID="txtSub2" runat="server" MaxLength="10" Height="25px"></telerik:RadNumericTextBox>

                                    </div>

                                </div>

                                <div class="clear"></div>
                            </div>
                                      <div class="formRow">
                                <div class="formCol">
                                    <label>Sub Amount 3</label>
                                    <div class="formRight"  style="width:100px;">
                                        <telerik:RadNumericTextBox ID="txtSub3" runat="server" MaxLength="10" Height="25px"></telerik:RadNumericTextBox>

                                    </div>

                                </div>

                                <div class="clear"></div>
                            </div>


                                 <div class="formRow">
                                   <div class="formCol">
                                        <label>Description</label>
                                        <div class="formRight">
                                            <telerik:RadTextBox ID="txtDescription" runat="server" MaxLength="200" Height="25px">
                                            </telerik:RadTextBox>

                                            <asp:RequiredFieldValidator
                                                ID="Required_txtDescription"
                                                ControlToValidate="txtDescription"
                                                ErrorMessage="*"
                                                Display="Dynamic"
                                                CssClass="requiredvalidators"
                                                ValidationGroup="FrmSubmit"
                                                SetFocusOnError="False"
                                                runat="server"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                    <div class="formCol">
                                        <label></label>
                                        <div class="formRight">
                                            <label></label>
                                        </div>
                                    </div>

                                    <div class="clear"></div>
                                </div>

                                                             <div class="formRow">
                                <div class="formCol">
                                    <label>Description 1</label>
                                    <div class="formRight">
                                        <telerik:RadTextBox ID="txtDescription1" runat="server" MaxLength="200" Height="25px">
                                        </telerik:RadTextBox>

                                      
                                    </div>
                                </div>
                                <div class="clear"></div>
                            </div>
                              <div class="formRow">
                                <div class="formCol">
                                    <label>Description 2</label>
                                    <div class="formRight">
                                        <telerik:RadTextBox ID="txtDescription2" runat="server" MaxLength="200" Height="25px">
                                        </telerik:RadTextBox>

                                      
                                    </div>
                                </div>
                                <div class="clear"></div>
                            </div>

                              <div class="formRow">
                                <div class="formCol">
                                    <label>Description 3</label>
                                    <div class="formRight">
                                        <telerik:RadTextBox ID="txtDescription3" runat="server" MaxLength="200" Height="25px">
                                        </telerik:RadTextBox>                                  
                                    </div>
                                </div>
                                <div class="clear"></div>
                            </div>
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


                            </div>
                        </div>
                        <div class="span4">
                            <uc1:ucEmployeeCard runat="server" ID="ucEmployeeCard" />
                        </div>
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
