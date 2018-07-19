using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class PremiumMaster : BasePage
{

    public static Hashtable htSearchParams = null;
    public bool exporting = false;
    DataTable dtPremTypeDetail = new DataTable();
    int formType = 3130;

    // base page initializing
    protected override void Page_Init(object sender, EventArgs e)
    {
        FormName = "Premium Master";
        base.Page_Init(sender, e);
    }

    // page load function
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    // overtime master grid data loading and binding
    protected void gvPremium_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        Hashtable htSearchParams = new Hashtable();
        htSearchParams.Add("@type",0);
        DataTable dt = clsDAL.GetDataSet_Payroll("sp_payroll_GetPremiumTypeRecords", htSearchParams).Tables[0];
        dt.TableName = "PremiumMaster";
        gvPremium.DataSource = dt;
        gvPremium.DataMember = "PremiumMaster";
    }

    // day type ddl data loading and binding
    protected void rGrdDayType4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_GetDayTypes", htSearchParams).Tables[0];
    }

    // grid update command
    protected void gvPremium_UpdateCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_PremiumType(ref e, "Update");
    }

    // grid delete command for master and detail grid
    protected void gvPremium_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        Hashtable ht = new Hashtable();

        if (e.Item.OwnerTableView.DataMember == "PremiumMaster")
        {
            int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("recidd");
            if (ID > 0)
            {
                ht.Add("@ID", ID);
                clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_PremiumTypeMaster", ht);
            }
        }
        else if (e.Item.OwnerTableView.DataMember == "PremTypeDetail")
        {
            int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("recidd");
            if (ID > 0)
            {
                ht.Add("@ID", ID);
                clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_PremTypeDtl", ht);
            }
        }
    }

    // client side validation function for premium type master input form
    public void ValidatePremType(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadTextBox txtpremtype = (editForm.FindControl("txtpremtype") as RadTextBox);
        RadTextBox txtpremtypedesc = (editForm.FindControl("txtpremtypedesc") as RadTextBox);
        RadComboBox ddlUnitOFPayment = (editForm.FindControl("ddlUnitOFPayment") as RadComboBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidatePremType('" +
                txtpremtype.ClientID + "','" +
                txtpremtypedesc.ClientID + "','" +
                ddlUnitOFPayment.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidatePremType('" +
                txtpremtype.ClientID + "','" +
                txtpremtypedesc.ClientID + "','" +
                ddlUnitOFPayment.ClientID
                + "')");
        }
    }

    // client side validation function for overtime detail input form
    public void ValidatePremTypeDetail(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadComboBox ddlDayType = (editForm.FindControl("ddlDayType") as RadComboBox);
        CheckBox cbSpecVal = (editForm.FindControl("cbSpecVal") as CheckBox);
        RadNumericTextBox txtfromval = (editForm.FindControl("txtfromval") as RadNumericTextBox);
        RadNumericTextBox txttoval = (editForm.FindControl("txttoval") as RadNumericTextBox);
        RadNumericTextBox txtdefval = (editForm.FindControl("txtdefval") as RadNumericTextBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidatePremTypeDetail('" +
                ddlDayType.ClientID + "','" +
                cbSpecVal.ClientID + "','" +
                txtfromval.ClientID + "','" +
                txttoval.ClientID + "','" +
                txtdefval.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidatePremTypeDetail('" +
                ddlDayType.ClientID + "','" +
                cbSpecVal.ClientID + "','" +
                txtfromval.ClientID + "','" +
                txttoval.ClientID + "','" +
                txtdefval.ClientID
                + "')");
        }
    }

    // form input control settings for insert/udpate
    protected void gvPremium_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            if (e.Item.OwnerTableView.DataMember == "PremiumMaster")
            {
                ValidatePremType(e);

                if (e.Item.OwnerTableView.IsItemInserted)
                {
                    #region  item is about to be inserted

                    GridEditableItem insertedItem = (GridEditableItem)e.Item;

                    RadComboBox ddlBasedOn = (RadComboBox)insertedItem.FindControl("ddlBasedOn");

                    #endregion
                }
                else
                {
                    #region item is about to be edited
                    GridEditableItem editedItem = (GridEditableItem)e.Item;
                    RadComboBox ddlUnitOFPayment = (RadComboBox)editedItem.FindControl("ddlUnitOFPayment");

                    ddlUnitOFPayment.Items[0].Value = DataBinder.Eval(e.Item.DataItem, "uopidd").ToString();
                    ddlUnitOFPayment.Items[0].Text = DataBinder.Eval(e.Item.DataItem, "uopcod").ToString();
                    ddlUnitOFPayment.SelectedValue = DataBinder.Eval(e.Item.DataItem, "uopidd").ToString();

                    #endregion
                }
            }
            else if (e.Item.OwnerTableView.DataMember == "PremTypeDetail")
            {
                ValidatePremTypeDetail(e);

                if (e.Item.OwnerTableView.IsItemInserted)
                {
                    #region  item is about to be inserted

                    GridEditableItem insertedItem = (GridEditableItem)e.Item;
                    CheckBox cbSpecVal = (CheckBox)insertedItem.FindControl("cbSpecVal");
                    cbSpecVal.Checked = true;

                    #endregion
                }
                else
                {
                    #region item is about to be edited

                    GridEditableItem editedItem = (GridEditableItem)e.Item;

                    RadComboBox ddlDayType = (RadComboBox)editedItem.FindControl("ddlDayType");

                    ddlDayType.Items[0].Value = DataBinder.Eval(e.Item.DataItem, "daytidd").ToString();
                    ddlDayType.Items[0].Text = DataBinder.Eval(e.Item.DataItem, "daytcod").ToString();
                    ddlDayType.SelectedValue = DataBinder.Eval(e.Item.DataItem, "daytidd").ToString();

                    CheckBox cbSpecVal = (CheckBox)editedItem.FindControl("cbSpecVal");
                    RadNumericTextBox txtfromval = (editedItem.FindControl("txtfromval") as RadNumericTextBox);
                    RadNumericTextBox txttoval = (editedItem.FindControl("txttoval") as RadNumericTextBox);
                    RequiredFieldValidator RFVtxtfromval = (editedItem.FindControl("RFVtxtfromval") as RequiredFieldValidator);
                    RequiredFieldValidator RFVtxttoval = (editedItem.FindControl("RFVtxttoval") as RequiredFieldValidator);
                    if (!cbSpecVal.Checked)
                    {
                        txtfromval.Enabled = false;
                        txttoval.Enabled = false;
                        RFVtxtfromval.Enabled = false;
                        RFVtxttoval.Enabled = false;
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
    protected void gvPremium_ItemCommand(object sender, GridCommandEventArgs e)
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

            if (e.Item.OwnerTableView.DataMember == "PremiumMaster")
            {
                grid.MasterTableView.GetColumn("EditPremiumType").Visible = false;
                grid.MasterTableView.GetColumn("DeletePremiumType").Visible = false;
                grid.MasterTableView.ExportToExcel();
            }
            else if (e.Item.OwnerTableView.DataMember == "PremTypeDetail")
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

            if (e.Item.OwnerTableView.DataMember == "PremiumMaster")
            {
                grid.MasterTableView.GetColumn("EditPremiumType").Visible = false;
                grid.MasterTableView.GetColumn("DeletePremiumType").Visible = false;
            }
            else if (e.Item.OwnerTableView.DataMember == "PremTypeDetail")
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

            if (e.Item.OwnerTableView.DataMember == "PremiumMaster")
            {
                grid.MasterTableView.GetColumn("EditPremiumType").Visible = false;
                grid.MasterTableView.GetColumn("DeletePremiumType").Visible = false;
            }
            else if (e.Item.OwnerTableView.DataMember == "PremTypeDetail")
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

                if (column.UniqueName == "EditPremTypeDetail" || column.UniqueName == "DeletePremTypeDetail")
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
    protected void gvPremium_InsertCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_PremiumType(ref e, "Insert");
    }

    // insert/update function
    private void Insert_or_Update_PremiumType(ref GridCommandEventArgs e, string operation)
    {
        GridEditableItem editedItem = e.Item as GridEditableItem;
        try
        {
            //Insert new values
            Hashtable newValues = new Hashtable();

            if (e.Item.OwnerTableView.DataMember == "PremiumMaster")
            {
                if (operation == "Update")
                {
                    newValues["@recidd"] = (int)editedItem.GetDataKeyValue("recidd");
                }
                newValues["@premtype"] = (editedItem.FindControl("txtpremtype") as RadTextBox).Text.Trim();
                newValues["@premtypedescription"] = (editedItem.FindControl("txtpremtypedesc") as RadTextBox).Text.Trim();

                newValues["@uopidd"] = Convert.ToInt32((editedItem.FindControl("ddlUnitOFPayment") as RadComboBox).Items[0].Value);
                newValues["@uopcod"] = (editedItem.FindControl("ddlUnitOFPayment") as RadComboBox).Items[0].Text.ToString();

                newValues["@DBMessage"] = "";

                string DBMessage = "";

                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Insert_PremiumTypeMaster", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                    string oid = DBMessage; 
                    if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                    {
                        ShowClientMessage(DBMessage, MessageType.Error);
                        e.Canceled = true;
                    }
                    else
                    {
                        ShowClientMessage("Premium Type record saved successfully.", MessageType.Success);
                        gvPremium.Rebind();
                    }
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Update_PremiumTypeMaster", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                    if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                    {
                        ShowClientMessage(DBMessage, MessageType.Error);
                        e.Canceled = true;
                    }
                    else
                    {
                        ShowClientMessage("Premium Type record saved successfully.", MessageType.Success);
                        gvPremium.Rebind();
                    }
                }           
            }

            else if (e.Item.OwnerTableView.DataMember == "PremTypeDetail")
            {
                if (operation == "Update")
                {
                    newValues["@recidd"] = (int)editedItem.GetDataKeyValue("recidd");
                }
                GridDataItem parentItem = (GridDataItem)(e.Item.OwnerTableView.ParentItem);
                if (parentItem != null)
                {
                    newValues["@mrecidd"] = Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["recidd"].ToString());
                }
                
                newValues["@daytidd"] = Convert.ToInt32((editedItem.FindControl("ddlDayType") as RadComboBox).Items[0].Value);
                newValues["@daytcod"] = (editedItem.FindControl("ddlDayType") as RadComboBox).Items[0].Text.ToString();

                newValues["@specval"] = (editedItem.FindControl("cbSpecVal") as CheckBox).Checked;
                CheckBox cbSpecVal = (editedItem.FindControl("cbSpecVal") as CheckBox);
                RadNumericTextBox txtfromval = editedItem.FindControl("txtfromval") as RadNumericTextBox;
                if (!string.IsNullOrEmpty(txtfromval.Text) && cbSpecVal.Checked)
                {
                    newValues["@fromval"] = txtfromval.Text;
                }

                RadNumericTextBox txttoval = editedItem.FindControl("txttoval") as RadNumericTextBox;
                if (!string.IsNullOrEmpty(txttoval.Text) && cbSpecVal.Checked)
                {
                    newValues["@toval"] = txttoval.Text;
                }

                RadNumericTextBox txtdefval = editedItem.FindControl("txtdefval") as RadNumericTextBox;
                if (!string.IsNullOrEmpty(txtdefval.Text))
                {
                    newValues["@defval"] = txtdefval.Text;
                }
                newValues["@DBMessage"] = "";

                string DBMessage = "";

                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_PremTypeDtl", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Update_PremTypeDtl", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                else
                {
                    ShowClientMessage("Premium type detail record saved successfully.", MessageType.Success);
                }
            }
        }
        catch (Exception ex)
        {
            ShowClientMessage("Unable to update/insert Premium type detail record. Reason: " + ex.Message, MessageType.Error);
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
    protected void gvPremium_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;

        switch (e.DetailTableView.Name)
        {
            case "PremTypeDetail":
                {
                    string ID = dataItem.GetDataKeyValue("recidd").ToString();

                    Hashtable ht = new Hashtable();
                    ht.Add("@ID", ID);

                    dtPremTypeDetail = clsDAL.GetDataSet_Payroll("sp_Payroll_GetPremTypeDtl", ht).Tables[0];
                    dtPremTypeDetail.TableName = "PremTypeDetail";
                    e.DetailTableView.DataSource = dtPremTypeDetail;
                    e.DetailTableView.DataMember = "PremTypeDetail";
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
    protected void gvPremium_ItemCreated(object sender, GridItemEventArgs e)
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
        GridEditFormItem.EditFormTableCell editForm = cbSpecVal.Parent as GridEditFormItem.EditFormTableCell;
        RadNumericTextBox txtfromval = (editForm.FindControl("txtfromval") as RadNumericTextBox);
        RadNumericTextBox txttoval = (editForm.FindControl("txttoval") as RadNumericTextBox);
        RequiredFieldValidator RFVtxtfromval = (editForm.FindControl("RFVtxtfromval") as RequiredFieldValidator);
        RequiredFieldValidator RFVtxttoval = (editForm.FindControl("RFVtxttoval") as RequiredFieldValidator);

        if (cbSpecVal.Checked)
        {
            txtfromval.Enabled = true;
            txttoval.Enabled = true;
            RFVtxtfromval.Enabled = true;
            RFVtxttoval.Enabled = true;
        }
        else
        {
            txtfromval.Enabled = false;
            txttoval.Enabled = false;
            //txtfromval.Text = "";
            //txttoval.Text = "";
            RFVtxtfromval.Enabled = false;
            RFVtxttoval.Enabled = false;
        }
    }
}