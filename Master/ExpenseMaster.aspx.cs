using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class ExpenseMaster : BasePage
{

    public static Hashtable htSearchParams = null;
    public bool exporting = false;
    DataTable dtExpTypeDetail = new DataTable();
    int formType = 3130;

    // base page initializing
    protected override void Page_Init(object sender, EventArgs e)
    {
        FormName = "Expense Master";
        base.Page_Init(sender, e);
    }

    // page load function
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    // overtime master grid data loading and binding
    protected void gvExpense_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        DataTable dt = clsDAL.GetDataSet_Payroll("sp_payroll_GetExpenseTypeRecords", htSearchParams).Tables[0];
        dt.TableName = "ExpenseMaster";
        gvExpense.DataSource = dt;
        gvExpense.DataMember = "ExpenseMaster";
    }

    

    // grid update command
    protected void gvExpense_UpdateCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_ExpenseType(ref e, "Update");
    }

    // grid delete command for master and detail grid
    protected void gvExpense_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        Hashtable ht = new Hashtable();

        if (e.Item.OwnerTableView.DataMember == "ExpenseMaster")
        {
            int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("exptidd");
            if (ID > 0)
            {
                ht.Add("@ID", ID);
                clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_ExpenseTypeMaster", ht);
            }
        }
        else if (e.Item.OwnerTableView.DataMember == "ExpenseTypeDetail")
        {
            int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("expsubtidd");
            if (ID > 0)
            {
                ht.Add("@ID", ID);
                clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_ExpenseSubTypeRecord", ht);
            }
        }
    }

    // client side validation function for premium type master input form
    public void ValidateExpenseType(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        //ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadTextBox txtexptcod = (editForm.FindControl("txtexptcod") as RadTextBox);
        RadTextBox txtexpttitle = (editForm.FindControl("txtexpttitle") as RadTextBox);

        CheckBox cbSpecVal = (editForm.FindControl("cbSpecVal") as CheckBox);
        RadNumericTextBox txtfromval = (editForm.FindControl("txtfromval") as RadNumericTextBox);
        RadNumericTextBox txttoval = (editForm.FindControl("txttoval") as RadNumericTextBox);

        RadComboBox ddlMeasurmentType = (editForm.FindControl("ddlMeasurmentType") as RadComboBox);
        RadTextBox txtUnitType = (editForm.FindControl("txtUnitType") as RadTextBox);
        RadNumericTextBox txtUnitValue = (editForm.FindControl("txtUnitValue") as RadNumericTextBox);

        //if (update != null)
        //{
        //    update.Attributes.Add("onclick", "return ValidateExpenseType('" +
        //        txtexptcod.ClientID + "','" +
        //        txtexpttitle.ClientID 
        //        + "')");
        //}
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateExpenseType('" +
                txtexptcod.ClientID + "','" +
                txtexpttitle.ClientID + "','" +
                cbSpecVal.ClientID + "','" +
                ddlMeasurmentType.ClientID + "','" +
                txtUnitType.ClientID + "','" +
                txtUnitValue.ClientID + "','" +
                txtfromval.ClientID + "','" +
                txttoval.ClientID
                + "')");
        }
    }

    // client side validation function for overtime detail input form
    public void ValidateExpenseTypeDetail(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        //ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadTextBox txtexpsubtcod = (editForm.FindControl("txtexpsubtcod") as RadTextBox);
        RadTextBox txtexpsubttitle = (editForm.FindControl("txtexpsubttitle") as RadTextBox);
        CheckBox cbSpecVal = (editForm.FindControl("cbSpecVal") as CheckBox);
        RadNumericTextBox txtfromval = (editForm.FindControl("txtfromval") as RadNumericTextBox);
        RadNumericTextBox txttoval = (editForm.FindControl("txttoval") as RadNumericTextBox);

        RadComboBox ddlMeasurmentType = (editForm.FindControl("ddlMeasurmentType") as RadComboBox);
        RadTextBox txtUnitType = (editForm.FindControl("txtUnitType") as RadTextBox);
        RadNumericTextBox txtUnitValue = (editForm.FindControl("txtUnitValue") as RadNumericTextBox);

        //if (update != null)
        //{
        //    update.Attributes.Add("onclick", "return ValidateExpenseTypeDetail('" +
        //        txtexpsubtcod.ClientID + "','" +
        //        txtexpsubttitle.ClientID + "','" +
        //        cbSpecVal.ClientID + "','" +
        //        ddlMeasurmentType.ClientID + "','" +
        //        txtUnitType.ClientID + "','" +
        //        txtUnitValue.ClientID + "','" +
        //        txtfromval.ClientID + "','" +
        //        txttoval.ClientID
        //        + "')");
        //}
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateExpenseTypeDetail('" +
                txtexpsubtcod.ClientID + "','" +
                txtexpsubttitle.ClientID + "','" +
                cbSpecVal.ClientID + "','" +
                ddlMeasurmentType.ClientID + "','" +
                txtUnitType.ClientID + "','" +
                txtUnitValue.ClientID + "','" +
                txtfromval.ClientID + "','" +
                txttoval.ClientID
                + "')");
        }
    }

    // form input control settings for insert/udpate
    protected void gvExpense_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            if (e.Item.OwnerTableView.DataMember == "ExpenseMaster")
            {
                ValidateExpenseType(e);

                if (e.Item.OwnerTableView.IsItemInserted)
                {
                    #region  item is about to be inserted

                    GridEditableItem insertedItem = (GridEditableItem)e.Item;
                    CheckBox cbSpecVal = (CheckBox)insertedItem.FindControl("cbSpecVal");
                    cbSpecVal.Checked = true;

                    RadComboBox ddlMeasurmentType = (RadComboBox)insertedItem.FindControl("ddlMeasurmentType");
                    
                    if (ddlMeasurmentType != null)
                    {
                        RadGrid grid = ddlMeasurmentType.Items[0].FindControl("rGrdMeasurmentType4DDL") as RadGrid;
                        if (grid != null)
                        {
                            grid.Rebind();
                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    ddlMeasurmentType.Items[0].Value = dataItem.GetDataKeyValue("ValueSetID").ToString();
                                    ddlMeasurmentType.Items[0].Text = dataItem.GetDataKeyValue("Text").ToString();
                                    ddlMeasurmentType.SelectedValue = dataItem.GetDataKeyValue("ValueSetID").ToString();
                                    string unitType = dataItem.GetDataKeyValue("Text").ToString();
                                    if (unitType.ToLower() == "money")
                                    {
                                        Label lblUnitType = (insertedItem.FindControl("lblUnitType") as Label);
                                        RadTextBox txtUnitType = (insertedItem.FindControl("txtUnitType") as RadTextBox);
                                        RequiredFieldValidator RFVtxtUnitType = (insertedItem.FindControl("RFVtxtUnitType") as RequiredFieldValidator);
                                        Label lblUnitValue = insertedItem.FindControl("lblUnitValue") as Label;
                                        RadNumericTextBox txtUnitValue = insertedItem.FindControl("txtUnitValue") as RadNumericTextBox;
                                        RequiredFieldValidator RFVtxtUnitValue = insertedItem.FindControl("RFVtxtUnitValue") as RequiredFieldValidator;

                                        lblUnitType.Visible = false;
                                        txtUnitType.Visible = false;
                                        RFVtxtUnitType.Enabled = false;
                                        lblUnitValue.Visible = false;
                                        txtUnitValue.Visible = false;
                                        RFVtxtUnitValue.Enabled = false;

                                    }
                                    break;
                                }
                            }
                        }
                    }
                    #endregion
                }
                else
                {
                    #region item is about to be edited
                    GridEditableItem editedItem = (GridEditableItem)e.Item;
                    CheckBox cbSpecVal = (CheckBox)editedItem.FindControl("cbSpecVal");
                    Label lblfromval = (editedItem.FindControl("lblfromval") as Label);
                    Label lbltoval = (editedItem.FindControl("lbltoval") as Label);
                    RadNumericTextBox txtfromval = (editedItem.FindControl("txtfromval") as RadNumericTextBox);
                    RadNumericTextBox txttoval = (editedItem.FindControl("txttoval") as RadNumericTextBox);
                    RequiredFieldValidator RFVtxtfromval = (editedItem.FindControl("RFVtxtfromval") as RequiredFieldValidator);
                    RequiredFieldValidator RFVtxttoval = (editedItem.FindControl("RFVtxttoval") as RequiredFieldValidator);
                    if (!cbSpecVal.Checked)
                    {
                        lblfromval.Visible = false;
                        lbltoval.Visible = false;
                        txtfromval.Visible = false;
                        txttoval.Visible = false;
                        RFVtxtfromval.Enabled = false;
                        RFVtxttoval.Enabled = false;
                    }

                    RadComboBox ddlMeasurmentType = editedItem.FindControl("ddlMeasurmentType") as RadComboBox;
                    Label lblUnitType = (editedItem.FindControl("lblUnitType") as Label);
                    RadTextBox txtUnitType = (editedItem.FindControl("txtUnitType") as RadTextBox);
                    RequiredFieldValidator RFVtxtUnitType = (editedItem.FindControl("RFVtxtUnitType") as RequiredFieldValidator);
                    Label lblUnitValue = editedItem.FindControl("lblUnitValue") as Label;
                    RadNumericTextBox txtUnitValue = editedItem.FindControl("txtUnitValue") as RadNumericTextBox;
                    RequiredFieldValidator RFVtxtUnitValue = editedItem.FindControl("RFVtxtUnitValue") as RequiredFieldValidator;

                    if (ddlMeasurmentType != null)
                    {
                        ddlMeasurmentType.Items[0].Value = DataBinder.Eval(editedItem.DataItem, "measurmenttidd").ToString();
                        ddlMeasurmentType.Items[0].Text = DataBinder.Eval(editedItem.DataItem, "measurmenttcod").ToString();
                        ddlMeasurmentType.SelectedValue = DataBinder.Eval(editedItem.DataItem, "measurmenttidd").ToString();
                        if (DataBinder.Eval(editedItem.DataItem, "measurmenttcod").ToString().ToLower() == "money")
                        {
                            lblUnitType.Visible = false;
                            txtUnitType.Visible = false;
                            RFVtxtUnitType.Enabled = false;
                            lblUnitValue.Visible = false;
                            txtUnitValue.Visible = false;
                            RFVtxtUnitValue.Enabled = false;
                        }
                    }
                    
                    #endregion
                }
            }
            else if (e.Item.OwnerTableView.DataMember == "ExpenseTypeDetail")
            {
                ValidateExpenseTypeDetail(e);

                if (e.Item.OwnerTableView.IsItemInserted)
                {
                    #region  item is about to be inserted

                    GridEditableItem insertedItem = (GridEditableItem)e.Item;
                    CheckBox cbSpecVal = (CheckBox)insertedItem.FindControl("cbSpecVal");
                    cbSpecVal.Checked = true;

                    RadComboBox ddlMeasurmentType = (RadComboBox)insertedItem.FindControl("ddlMeasurmentType");

                    if (ddlMeasurmentType != null)
                    {
                        RadGrid grid = ddlMeasurmentType.Items[0].FindControl("rGrdMeasurmentType4DDL") as RadGrid;
                        if (grid != null)
                        {
                            grid.Rebind();
                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    ddlMeasurmentType.Items[0].Value = dataItem.GetDataKeyValue("ValueSetID").ToString();
                                    ddlMeasurmentType.Items[0].Text = dataItem.GetDataKeyValue("Text").ToString();
                                    ddlMeasurmentType.SelectedValue = dataItem.GetDataKeyValue("ValueSetID").ToString();
                                    string unitType = dataItem.GetDataKeyValue("Text").ToString();
                                    if (unitType.ToLower() == "money")
                                    {
                                        Label lblUnitType = (insertedItem.FindControl("lblUnitType") as Label);
                                        RadTextBox txtUnitType = (insertedItem.FindControl("txtUnitType") as RadTextBox);
                                        RequiredFieldValidator RFVtxtUnitType = (insertedItem.FindControl("RFVtxtUnitType") as RequiredFieldValidator);
                                        Label lblUnitValue = insertedItem.FindControl("lblUnitValue") as Label;
                                        RadNumericTextBox txtUnitValue = insertedItem.FindControl("txtUnitValue") as RadNumericTextBox;
                                        RequiredFieldValidator RFVtxtUnitValue = insertedItem.FindControl("RFVtxtUnitValue") as RequiredFieldValidator;

                                        lblUnitType.Visible = false;
                                        txtUnitType.Visible = false;
                                        RFVtxtUnitType.Enabled = false;
                                        lblUnitValue.Visible = false;
                                        txtUnitValue.Visible = false;
                                        RFVtxtUnitValue.Enabled = false;
                                        
                                    }
                                    break;
                                }
                            }
                        }
                    }

                    #endregion
                }
                else
                {
                    #region item is about to be edited

                    GridEditableItem editedItem = (GridEditableItem)e.Item;

                    CheckBox cbSpecVal = (CheckBox)editedItem.FindControl("cbSpecVal");
                    Label lblfromval = (editedItem.FindControl("lblfromval") as Label);
                    Label lbltoval = (editedItem.FindControl("lbltoval") as Label);
                    RadNumericTextBox txtfromval = (editedItem.FindControl("txtfromval") as RadNumericTextBox);
                    RadNumericTextBox txttoval = (editedItem.FindControl("txttoval") as RadNumericTextBox);
                    RequiredFieldValidator RFVtxtfromval = (editedItem.FindControl("RFVtxtfromval") as RequiredFieldValidator);
                    RequiredFieldValidator RFVtxttoval = (editedItem.FindControl("RFVtxttoval") as RequiredFieldValidator);
                    if (!cbSpecVal.Checked)
                    {
                        lblfromval.Visible = false;
                        lbltoval.Visible = false;
                        txtfromval.Visible = false;
                        txttoval.Visible = false;
                        RFVtxtfromval.Enabled = false;
                        RFVtxttoval.Enabled = false;
                    }

                    RadComboBox ddlMeasurmentType = editedItem.FindControl("ddlMeasurmentType") as RadComboBox;
                    Label lblUnitType = (editedItem.FindControl("lblUnitType") as Label);
                    RadTextBox txtUnitType = (editedItem.FindControl("txtUnitType") as RadTextBox);
                    RequiredFieldValidator RFVtxtUnitType = (editedItem.FindControl("RFVtxtUnitType") as RequiredFieldValidator);
                    Label lblUnitValue = editedItem.FindControl("lblUnitValue") as Label;
                    RadNumericTextBox txtUnitValue = editedItem.FindControl("txtUnitValue") as RadNumericTextBox;
                    RequiredFieldValidator RFVtxtUnitValue = editedItem.FindControl("RFVtxtUnitValue") as RequiredFieldValidator;
                    
                    if (ddlMeasurmentType != null)
                    {
                        ddlMeasurmentType.Items[0].Value = DataBinder.Eval(editedItem.DataItem, "measurmenttidd").ToString();
                        ddlMeasurmentType.Items[0].Text = DataBinder.Eval(editedItem.DataItem, "measurmenttcod").ToString();
                        ddlMeasurmentType.SelectedValue = DataBinder.Eval(editedItem.DataItem, "measurmenttidd").ToString();
                        if (DataBinder.Eval(editedItem.DataItem, "measurmenttcod").ToString().ToLower() == "money")
                        {
                            lblUnitType.Visible = false;
                            txtUnitType.Visible = false;
                            RFVtxtUnitType.Enabled = false;
                            lblUnitValue.Visible = false;
                            txtUnitValue.Visible = false;
                            RFVtxtUnitValue.Enabled = false;
                        }
                    }
                    #endregion
                }
            }
        }
        if (e.Item is GridCommandItem)
        {
            GridCommandItem commandItem = (GridCommandItem)e.Item;
            RadComboBox ddlPrintOptions = (RadComboBox)commandItem.FindControl("ddlPrintOptions");
            if (ddlPrintOptions != null)
            {
                Hashtable ht_Reports = new Hashtable();
                ht_Reports.Add("@userid", Session["_UserID"].ToString());
                ht_Reports.Add("@formtypeid", formType); 
                DataTable dt_Reports = clsDAL.GetDataSet_admin("sp_Payroll_Get_Reports", ht_Reports).Tables[0];
                if (ddlPrintOptions != null)
                {
                    ddlPrintOptions.DataSource = dt_Reports;
                    ddlPrintOptions.DataTextField = "reportname";
                    ddlPrintOptions.DataValueField = "idd";
                    ddlPrintOptions.DataBind();
                    ddlPrintOptions.SelectedIndex = 0;
                }
            }
        }
    }

    // clear form input controls for insert/update
    // grid export functions
    protected void gvExpense_ItemCommand(object sender, GridCommandEventArgs e)
    {
        RadGrid grid = (sender as RadGrid);
        if (e.CommandName == RadGrid.InitInsertCommandName)
        {
            grid.MasterTableView.ClearEditItems();

        }
        if (e.CommandName == RadGrid.EditCommandName)
        {
            e.Item.OwnerTableView.IsItemInserted = false;

        }
        if (e.CommandName == RadGrid.RebindGridCommandName)
        {
            grid.MasterTableView.ClearEditItems();
            e.Item.OwnerTableView.IsItemInserted = false;

            if (htSearchParams != null)
                htSearchParams.Clear();
        }
        if (e.CommandName == RadGrid.ExportToExcelCommandName)
        {
            exporting = true;
            grid.GridLines = GridLines.Both;
            grid.BorderStyle = BorderStyle.Solid;
            grid.BorderWidth = Unit.Pixel(1);
            grid.ExportSettings.ExportOnlyData = true;
            grid.ExportSettings.HideStructureColumns = true;

            foreach (GridDataItem item in grid.Items)
            {
                item["ExpandColumn"].Visible = false;
            }

            if (e.Item.OwnerTableView.DataMember == "ExpenseMaster")
            {
                grid.MasterTableView.GetColumn("EditExpenseType").Visible = false;
                grid.MasterTableView.GetColumn("DeleteExpenseType").Visible = false;
                grid.MasterTableView.ExportToExcel();
            }
            else if (e.Item.OwnerTableView.DataMember == "ExpenseTypeDetail")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
                grid.MasterTableView.ExportToExcel();
            }
        }
        if (e.CommandName == RadGrid.ExportToCsvCommandName)
        {
            exporting = true;
            grid.GridLines = GridLines.Both;
            grid.BorderStyle = BorderStyle.Solid;
            grid.BorderWidth = Unit.Pixel(1);
            grid.ExportSettings.ExportOnlyData = false;
            grid.MasterTableView.EnableHierarchyExpandAll = false;

            foreach (GridDataItem item in grid.Items)
            {
                item["ExpandColumn"].Visible = false;
            }

            if (e.Item.OwnerTableView.DataMember == "ExpenseMaster")
            {
                grid.MasterTableView.GetColumn("EditExpenseType").Visible = false;
                grid.MasterTableView.GetColumn("DeleteExpenseType").Visible = false;
            }
            else if (e.Item.OwnerTableView.DataMember == "ExpenseTypeDetail")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            grid.MasterTableView.ExportToCSV();
        }
        if (e.CommandName == RadGrid.ExportToPdfCommandName)
        {
            exporting = true;
            grid.GridLines = GridLines.Both;
            grid.BorderStyle = BorderStyle.Solid;
            grid.BorderWidth = Unit.Pixel(1);

            foreach (GridDataItem item in grid.Items)
            {
                item["ExpandColumn"].Visible = false;
            }

            if (e.Item.OwnerTableView.DataMember == "ExpenseMaster")
            {
                grid.MasterTableView.GetColumn("EditExpenseType").Visible = false;
                grid.MasterTableView.GetColumn("DeleteExpenseType").Visible = false;
            }
            else if (e.Item.OwnerTableView.DataMember == "ExpenseTypeDetail")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }

            grid.MasterTableView.ExportToPdf();
        }
        if (e.CommandName == "Print")
        {
            Button btnPrint = (Button)e.Item.FindControl("btnOvertimePrint");
            RadComboBox ddlPrintOptions = (RadComboBox)e.Item.FindControl("ddlPrintOptions");
            if (ddlPrintOptions != null)
            {
                if (!string.IsNullOrEmpty(ddlPrintOptions.Text))
                {
                    String qstring = clsEncryption.EncryptData(ddlPrintOptions.Text);
                    //btnPrint.Attributes["onclick"] = String.Format("return ShowReport('{0}');", qstring);
                    ScriptManager.RegisterStartupScript(this, Page.GetType(), "mykey", "ShowReport('" + qstring + "');", true);
                }
            }
        }
    }

    // function for export formating
    protected void GridTableHierarchySetEditability(GridTableView view, bool editAllowed)
    {
        foreach (GridFilteringItem item in view.GetItems(GridItemType.FilteringItem))
            item.Visible = false;

        foreach (GridHeaderItem item in view.GetItems(GridItemType.Header))
        {
            if (item.Cells[0].Text == "&nbsp;")
            {
                item.Cells[0].Visible = false;
            }
        }

        //If editing is not allowed, remove any edit or command-button columns.  
        if (editAllowed)
        {

            //Remove editing columns in the current view  
            foreach (GridColumn column in view.Columns)
            {
                if (column.UniqueName == "ExpandColumn")
                {
                    column.Display = false;
                    column.Visible = false;
                }

                if (column.UniqueName == "EditExpenseTypeDetail" || column.UniqueName == "DeleteExpenseTypeDetail")
                {
                    column.Display = false;
                    column.Visible = false;
                }

            }
        }

        if (view.HasDetailTables)
        {
            foreach (GridDataItem item in view.Items)
            {
                if (item.HasChildItems)
                {
                    foreach (GridTableView innerView in item.ChildItem.NestedTableViews)
                    {
                        GridTableHierarchySetEditability(innerView, true);
                    }
                }
            }
        }
    }

    // grid insert command
    protected void gvExpense_InsertCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_ExpenseType(ref e, "Insert");
    }

    // insert/update function
    private void Insert_or_Update_ExpenseType(ref GridCommandEventArgs e, string operation)
    {
        GridEditableItem editedItem = e.Item as GridEditableItem;
        try
        {
            //Insert new values
            Hashtable newValues = new Hashtable();

            if (e.Item.OwnerTableView.DataMember == "ExpenseMaster")
            {
                if (operation == "Update")
                {
                    newValues["@exptidd"] = (int)editedItem.GetDataKeyValue("exptidd");
                }
                newValues["@exptcod"] = (editedItem.FindControl("txtexptcod") as RadTextBox).Text.Trim();
                newValues["@expttitle"] = (editedItem.FindControl("txtexpttitle") as RadTextBox).Text.Trim();

                newValues["@specval"] = (editedItem.FindControl("cbSpecVal") as CheckBox).Checked;

                newValues["@measurmenttidd"] = Convert.ToInt32((editedItem.FindControl("ddlMeasurmentType") as RadComboBox).Items[0].Value);
                newValues["@measurmenttcod"] = (editedItem.FindControl("ddlMeasurmentType") as RadComboBox).Items[0].Text.ToString();
                if ((editedItem.FindControl("txtUnitType") as RadTextBox).Visible)
                {
                    newValues["@unittype"] = (editedItem.FindControl("txtUnitType") as RadTextBox).Text.Trim();
                }
                if ((editedItem.FindControl("txtUnitValue") as RadNumericTextBox).Visible)
                {
                    newValues["@unitval"] = (editedItem.FindControl("txtUnitValue") as RadNumericTextBox).Text.Trim();
                }
                CheckBox cbSpecVal = (editedItem.FindControl("cbSpecVal") as CheckBox);
                RadNumericTextBox txtfromval = editedItem.FindControl("txtfromval") as RadNumericTextBox;
                RadNumericTextBox txttoval = editedItem.FindControl("txttoval") as RadNumericTextBox;
                if (cbSpecVal.Checked)
                {
                    newValues["@fromval"] = txtfromval.Text;
                    newValues["@toval"] = txttoval.Text;
                }
                newValues["@DBMessage"] = "";

                string DBMessage = "";

                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Insert_ExpenseTypeMaster", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                    string oid = DBMessage; 
                    if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                    {
                        ShowClientMessage(DBMessage, MessageType.Error);
                        e.Canceled = true;
                    }
                    else
                    {
                        ShowClientMessage("Expense Type record saved successfully.", MessageType.Success);
                        gvExpense.Rebind();
                    }
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Update_ExpenseTypeMaster", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                    if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                    {
                        ShowClientMessage(DBMessage, MessageType.Error);
                        e.Canceled = true;
                    }
                    else
                    {
                        ShowClientMessage("Expense Type record saved successfully.", MessageType.Success);
                        gvExpense.Rebind();
                    }
                }           
            }

            else if (e.Item.OwnerTableView.DataMember == "ExpenseTypeDetail")
            {
                if (operation == "Update")
                {
                    newValues["@expsubtidd"] = (int)editedItem.GetDataKeyValue("expsubtidd");
                }
                GridDataItem parentItem = (GridDataItem)(e.Item.OwnerTableView.ParentItem);
                if (parentItem != null)
                {
                    newValues["@exptidd"] = Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["exptidd"].ToString());
                }

                newValues["@expsubtcod"] = (editedItem.FindControl("txtexpsubtcod") as RadTextBox).Text.Trim();
                newValues["@expsubttitle"] = (editedItem.FindControl("txtexpsubttitle") as RadTextBox).Text.Trim();

                newValues["@specval"] = (editedItem.FindControl("cbSpecVal") as CheckBox).Checked;

                newValues["@measurmenttidd"] = Convert.ToInt32((editedItem.FindControl("ddlMeasurmentType") as RadComboBox).Items[0].Value);
                newValues["@measurmenttcod"] = (editedItem.FindControl("ddlMeasurmentType") as RadComboBox).Items[0].Text.ToString();
                if ((editedItem.FindControl("txtUnitType") as RadTextBox).Visible)
                {
                    newValues["@unittype"] = (editedItem.FindControl("txtUnitType") as RadTextBox).Text.Trim();
                }
                if ((editedItem.FindControl("txtUnitValue") as RadNumericTextBox).Visible)
                {
                    newValues["@unitval"] = (editedItem.FindControl("txtUnitValue") as RadNumericTextBox).Text.Trim();
                }
                CheckBox cbSpecVal = (editedItem.FindControl("cbSpecVal") as CheckBox);
                RadNumericTextBox txtfromval = editedItem.FindControl("txtfromval") as RadNumericTextBox;
                RadNumericTextBox txttoval = editedItem.FindControl("txttoval") as RadNumericTextBox;
                if (cbSpecVal.Checked)
                {
                    newValues["@fromval"] = txtfromval.Text;
                    newValues["@toval"] = txttoval.Text;
                }
                newValues["@DBMessage"] = "";

                string DBMessage = "";

                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_ExpenseSubTypeRecord", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Update_ExpenseSubTypeRecord", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                else
                {
                    ShowClientMessage("Expense type detail record saved successfully.", MessageType.Success);
                }
            }
        }
        catch (Exception ex)
        {
            ShowClientMessage("Unable to update/insert Expense type detail record. Reason: " + ex.Message, MessageType.Error);
            e.Canceled = true;
        }
    }

    // function for displaying client side messages
    public void ShowClientMessage(string message, MessageType type, string redirect = "")
    {
        if (type == MessageType.Error)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "radalert", "showError('" + message + "', '" + redirect + "', 5000)", true);
        }
        else if (type == MessageType.Success)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "radalert", "showSuccess('" + message + "', '" + redirect + "', 5000)", true);
        }
        else if (type == MessageType.Warning)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "radalert", "showWarning('" + message + "', '" + redirect + "', 5000)", true);
        }
        else if (type == MessageType.Info)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "radalert", "showInfo('" + message + "', '" + redirect + "', 5000)", true);
        }
    }

    // overtime detail tables data loading and binding
    protected void gvExpense_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;

        switch (e.DetailTableView.Name)
        {
            case "ExpenseTypeDetail":
                {
                    string ID = dataItem.GetDataKeyValue("exptidd").ToString();

                    Hashtable ht = new Hashtable();
                    ht.Add("@ID", ID);

                    dtExpTypeDetail = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_ExpenseSubType_Records", ht).Tables[0];
                    dtExpTypeDetail.TableName = "ExpenseTypeDetail";
                    e.DetailTableView.DataSource = dtExpTypeDetail;
                    e.DetailTableView.DataMember = "ExpenseTypeDetail";
                    break;
                }
        }
    }

    // get value of grid boolean columns
    protected bool CheckBoxValue(object value)
    {
        if (Convert.ToString(value) == "1") return true;
        else if (Convert.ToString(value) == "True") return true;
        else if (Convert.ToString(value) == "true") return true;

        return false;
    }

    // get image for grid boolean columns
    protected string getImagePathForTrue(bool flag)
    {
        if (flag)
            return "~/Images/16x16_tick.png";
        else
            return "";
    }

    // grid header setting for exporting
    protected void gvExpense_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (exporting && e.Item.ItemType == Telerik.Web.UI.GridItemType.FilteringItem)
        {
            e.Item.Visible = false;
        }
    }
    protected void rGrdUnitOFPayment4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        htSearchParams = new Hashtable();
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromCentralDb(Constraints.DropDownLists.UnitOfPayment, -1, 1).Tables[0];
    }
    protected void cbSpecVal_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox cbSpecVal = sender as CheckBox;
        GridEditFormItem editForm = cbSpecVal.NamingContainer as GridEditFormItem;
        Label lblfromval = (editForm.FindControl("lblfromval") as Label);
        Label lbltoval = (editForm.FindControl("lbltoval") as Label);

        RadNumericTextBox txtfromval = (editForm.FindControl("txtfromval") as RadNumericTextBox);
        RadNumericTextBox txttoval = (editForm.FindControl("txttoval") as RadNumericTextBox);
        RequiredFieldValidator RFVtxtfromval = (editForm.FindControl("RFVtxtfromval") as RequiredFieldValidator);
        RequiredFieldValidator RFVtxttoval = (editForm.FindControl("RFVtxttoval") as RequiredFieldValidator);

        if (cbSpecVal.Checked)
        {
            lblfromval.Visible = true;
            lbltoval.Visible = true;
            txtfromval.Visible = true;
            txttoval.Visible = true;
            RFVtxtfromval.Enabled = true;
            RFVtxttoval.Enabled = true;
        }
        else
        {
            lblfromval.Visible = false;
            lbltoval.Visible = false;
            txtfromval.Visible = false;
            txttoval.Visible = false;
            RFVtxtfromval.Enabled = false;
            RFVtxttoval.Enabled = false;
        }
    }
    protected void rGrdMeasurmentType4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        htSearchParams = new Hashtable();
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromCentralDb(Constraints.DropDownLists.MeasurmentType, -1, 1).Tables[0];
    }
    protected void ddlMeasurmentType_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        RadComboBox ddlMeasurmentType = sender as RadComboBox;

        Label lblUnitType = ddlMeasurmentType.NamingContainer.FindControl("lblUnitType") as Label;
        RadTextBox txtUnitType = ddlMeasurmentType.NamingContainer.FindControl("txtUnitType") as RadTextBox;
        RequiredFieldValidator RFVtxtUnitType = ddlMeasurmentType.NamingContainer.FindControl("RFVtxtUnitType") as RequiredFieldValidator;
        
        Label lblUnitValue = ddlMeasurmentType.NamingContainer.FindControl("lblUnitValue") as Label;
        RadNumericTextBox txtUnitValue = ddlMeasurmentType.NamingContainer.FindControl("txtUnitValue") as RadNumericTextBox;
        RequiredFieldValidator RFVtxtUnitValue = ddlMeasurmentType.NamingContainer.FindControl("RFVtxtUnitValue") as RequiredFieldValidator;
        if (txtUnitType != null && RFVtxtUnitType != null)
        {
            if (ddlMeasurmentType.Items[0].Text.ToLower() == "money")
            {
                lblUnitType.Visible = false;
                txtUnitType.Visible = false;
                RFVtxtUnitType.Enabled = false;

                lblUnitValue.Visible = false;
                txtUnitValue.Visible = false;
                RFVtxtUnitValue.Enabled = false;
            }
            else 
            {
                lblUnitType.Visible = true;
                txtUnitType.Visible = true;
                RFVtxtUnitType.Enabled = true;

                lblUnitValue.Visible = true;
                txtUnitValue.Visible = true;
                RFVtxtUnitValue.Enabled = true;
            }
        }
    }
}