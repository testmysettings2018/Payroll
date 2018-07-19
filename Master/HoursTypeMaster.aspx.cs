using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class HoursTypeMaster : BasePage
{

    public static Hashtable htSearchParams = null;
    public bool exporting = false;
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
    protected void gvHourType_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        DataTable dt = clsDAL.GetDataSet_Payroll("sp_payroll_GetHourTypeRecords", htSearchParams).Tables[0];
        dt.TableName = "HourTypeMaster";
        gvHourType.DataSource = dt;
        gvHourType.DataMember = "HourTypeMaster";
    }

    

    // grid update command
    protected void gvHourType_UpdateCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_HoursType(ref e, "Update");
    }

    // grid delete command for master and detail grid
    protected void gvHourType_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        Hashtable ht = new Hashtable();

        if (e.Item.OwnerTableView.DataMember == "HourTypeMaster")
        {
            int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("recidd");
            if (ID > 0)
            {
                ht.Add("@ID", ID);
                clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_HourTypeMaster", ht);
            }
        }
        
    }

    // client side validation function for premium type master input form
    public void ValidateHoursType(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadTextBox txthourtypecode = (editForm.FindControl("txthourtypecode") as RadTextBox);
        RadTextBox txthourtypedescription = (editForm.FindControl("txthourtypedescription") as RadTextBox);
        RadTextBox txthourtypedescription2 = (editForm.FindControl("txthourtypedescription2") as RadTextBox);
        CheckBox cbSpecVal = (editForm.FindControl("cbSpecVal") as CheckBox);
        RadNumericTextBox txtfromval = (editForm.FindControl("txtfromval") as RadNumericTextBox);
        RadNumericTextBox txttoval = (editForm.FindControl("txttoval") as RadNumericTextBox);
        RadNumericTextBox txtdefval = (editForm.FindControl("txtdefval") as RadNumericTextBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidateHoursType('" +
                txthourtypecode.ClientID + "','" +
                txthourtypedescription.ClientID + "','" +
                txthourtypedescription2.ClientID + "','" +
                cbSpecVal.ClientID + "','" +
                txtfromval.ClientID + "','" +
                txttoval.ClientID + "','" +
                txtdefval.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateHoursType('" +
                txthourtypecode.ClientID + "','" +
                txthourtypedescription.ClientID + "','" +
                txthourtypedescription2.ClientID + "','" +
                cbSpecVal.ClientID + "','" +
                txtfromval.ClientID + "','" +
                txttoval.ClientID + "','" +
                txtdefval.ClientID
                + "')");
        }
    }

    
    // form input control settings for insert/udpate
    protected void gvHourType_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            if (e.Item.OwnerTableView.DataMember == "HourTypeMaster")
            {
                ValidateHoursType(e);

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
    protected void gvHourType_ItemCommand(object sender, GridCommandEventArgs e)
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

            if (e.Item.OwnerTableView.DataMember == "HourTypeMaster")
            {
                grid.MasterTableView.GetColumn("EditHourType").Visible = false;
                grid.MasterTableView.GetColumn("DeleteHourType").Visible = false;
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

            if (e.Item.OwnerTableView.DataMember == "HourTypeMaster")
            {
                grid.MasterTableView.GetColumn("EditHourType").Visible = false;
                grid.MasterTableView.GetColumn("DeleteHourType").Visible = false;
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

            if (e.Item.OwnerTableView.DataMember == "HourTypeMaster")
            {
                grid.MasterTableView.GetColumn("EditHourType").Visible = false;
                grid.MasterTableView.GetColumn("DeleteHourType").Visible = false;
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

    

    // grid insert command
    protected void gvHourType_InsertCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_HoursType(ref e, "Insert");
    }

    // insert/update function
    private void Insert_or_Update_HoursType(ref GridCommandEventArgs e, string operation)
    {
        GridEditableItem editedItem = e.Item as GridEditableItem;
        try
        {
            //Insert new values
            Hashtable newValues = new Hashtable();

            if (e.Item.OwnerTableView.DataMember == "HourTypeMaster")
            {
                if (operation == "Update")
                {
                    newValues["@recidd"] = (int)editedItem.GetDataKeyValue("recidd");
                }
                newValues["@hourtypecode"] = (editedItem.FindControl("txthourtypecode") as RadTextBox).Text.Trim();
                newValues["@hourtypedescription"] = (editedItem.FindControl("txthourtypedescription") as RadTextBox).Text.Trim();
                newValues["@hourtypedescription2"] = (editedItem.FindControl("txthourtypedescription2") as RadTextBox).Text.Trim();

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
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Insert_HoursTypeMaster", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                    string oid = DBMessage; 
                    if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                    {
                        ShowClientMessage(DBMessage, MessageType.Error);
                        e.Canceled = true;
                    }
                    else
                    {
                        ShowClientMessage("Hour Type record saved successfully.", MessageType.Success);
                        gvHourType.Rebind();
                    }
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Update_HoursTypeMaster", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                    if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                    {
                        ShowClientMessage(DBMessage, MessageType.Error);
                        e.Canceled = true;
                    }
                    else
                    {
                        ShowClientMessage("Hour Type record saved successfully.", MessageType.Success);
                        gvHourType.Rebind();
                    }
                }           
            }
            
        }
        catch (Exception ex)
        {
            ShowClientMessage("Unable to update/insert Hour type record. Reason: " + ex.Message, MessageType.Error);
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

    // grid header setting for exporting
    protected void gvHourType_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (exporting && e.Item.ItemType == Telerik.Web.UI.GridItemType.FilteringItem)
        {
            e.Item.Visible = false;
        }
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