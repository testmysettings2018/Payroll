using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class EmployeeHourTypeAssignment : BasePage
{

    public static Hashtable htSearchParams = null;
    public bool exporting = false;
    DataTable dtEmployeeDetail = new DataTable();
    int formType = 3130;

    // base page initializing
    protected override void Page_Init(object sender, EventArgs e)
    {
        FormName = "EmployeeHourTypeAssignment";
        base.Page_Init(sender, e);
    }

    // page load function
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    // overtime master grid data loading and binding
    protected void gvEmployee_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        DataTable dt = clsDAL.GetDataSet_Payroll("sp_payroll_GetAllEmployeeRecords", htSearchParams).Tables[0];
        dt.TableName = "EmployeeMaster";
        gvEmployee.DataSource = dt;
        gvEmployee.DataMember = "EmployeeMaster";
    }

    

    // grid update command
    protected void gvEmployee_UpdateCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_EmployeeMaster(ref e, "Update");
    }

    // grid delete command for master and detail grid
    protected void gvEmployee_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        Hashtable ht = new Hashtable();
        try
        {
            if (e.Item.OwnerTableView.DataMember == "EmployeeMaster")
            {
                int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("recidd");
                if (ID > 0)
                {
                    ht.Add("@ID", ID);
                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_EmployeeHourTypeAssignment_detail", ht);
                }
            }
            else if (e.Item.OwnerTableView.DataMember == "EmployeeDetail")
            {
                int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("recidd");
                if (ID > 0)
                {
                    ht.Add("@ID", ID);
                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_EmployeeHourTypeAssignment_Record", ht);
                }
            }
            ShowClientMessage("Employee hour type assignment record deleted successfully.", MessageType.Success);
        }
        catch (Exception ex)
        {
            ShowClientMessage("Unable to delete employee hour type assignment record. Reason: " + ex.Message, MessageType.Error);
            e.Canceled = true;
        }

    }

    // client side validation function for premium type master input form
    public void ValidateEmployeeMaster(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");
        
        RadComboBox ddlHourType = (editForm.FindControl("ddlHourType") as RadComboBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidateEmployeeMaster('" +
                ddlHourType.ClientID 
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateEmployeeMaster('" +
                ddlHourType.ClientID 
                + "')");
        }
    }

    // form input control settings for insert/udpate
    protected void gvEmployee_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            if (e.Item.OwnerTableView.DataMember == "EmployeeMaster")
            {
                ValidateEmployeeMaster(e);

                if (e.Item.OwnerTableView.IsItemInserted)
                {
                    #region  item is about to be inserted

                    GridEditableItem insertedItem = (GridEditableItem)e.Item;

                    

                    #endregion
                }
                else
                {
                    #region item is about to be edited
                    GridEditableItem editedItem = (GridEditableItem)e.Item;

                    RadComboBox ddlHourType = (RadComboBox)editedItem.FindControl("ddlHourType");

                    if (ddlHourType != null)
                    {
                        int ID = Convert.ToInt32(editedItem.GetDataKeyValue("recidd"));
                        Hashtable ht = new Hashtable();
                        ht.Add("@ID", ID);
                        DataTable dtEmp = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_EmployeeHourTypeAssignment_detail", ht).Tables[0];

                        RadGrid grid = ddlHourType.Items[0].FindControl("rGrdHourType4DDL") as RadGrid;
                        if (grid != null)
                        {
                            grid.Rebind();
                            ddlHourType.Text = string.Empty;
                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;

                                    foreach (DataRow row in dtEmp.Rows)
                                    {
                                        if (row["hrtidd"].ToString().Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
                                        {
                                            if (!string.IsNullOrEmpty(ddlHourType.Text))
                                                ddlHourType.Text = ddlHourType.Text + ",";
                                            ddlHourType.Text = ddlHourType.Text + row["hrtidd"].ToString();
                                            dataItem.Selected = true;
                                            break;
                                        }
                                    }
                                }
                            }
                        }
                    }
                    #endregion
                }
            }
            else if (e.Item.OwnerTableView.DataMember == "EmployeeDetail")
            {
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
    protected void gvEmployee_ItemCommand(object sender, GridCommandEventArgs e)
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

            if (e.Item.OwnerTableView.DataMember == "EmployeeMaster")
            {
                grid.MasterTableView.GetColumn("EditEmployee").Visible = false;
                grid.MasterTableView.GetColumn("DeleteEmployee").Visible = false;
                grid.MasterTableView.GetColumn("hourtypecode").Visible = false;
                grid.MasterTableView.ExportToExcel();
            }
            else if (e.Item.OwnerTableView.DataMember == "EmployeeDetail")
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

            if (e.Item.OwnerTableView.DataMember == "EmployeeMaster")
            {
                grid.MasterTableView.GetColumn("EditEmployee").Visible = false;
                grid.MasterTableView.GetColumn("DeleteEmployee").Visible = false;
                grid.MasterTableView.GetColumn("hourtypecode").Visible = false;
            }
            else if (e.Item.OwnerTableView.DataMember == "EmployeeDetail")
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

            if (e.Item.OwnerTableView.DataMember == "EmployeeMaster")
            {
                grid.MasterTableView.GetColumn("EditEmployee").Visible = false;
                grid.MasterTableView.GetColumn("DeleteEmployee").Visible = false;
                grid.MasterTableView.GetColumn("hourtypecode").Visible = false;
            }
            else if (e.Item.OwnerTableView.DataMember == "EmployeeDetail")
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

                if (column.UniqueName == "EditEmployeeDetail" || column.UniqueName == "DeleteEmployeeDetail")
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
    protected void gvEmployee_InsertCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_EmployeeMaster(ref e, "Insert");
    }

    // insert/update function
    private void Insert_or_Update_EmployeeMaster(ref GridCommandEventArgs e, string operation)
    {
        GridEditableItem editedItem = e.Item as GridEditableItem;
        try
        {
            
            if (e.Item.OwnerTableView.DataMember == "EmployeeMaster")
            { 
                //Insert new values
                Hashtable newPaycodeValues = new Hashtable();

                newPaycodeValues["@empidd"] = Convert.ToInt32(editedItem.GetDataKeyValue("recidd"));
                newPaycodeValues["@empcod"] = editedItem.GetDataKeyValue("empcod");
                newPaycodeValues["@empfsn"] = editedItem.GetDataKeyValue("empfsn");
                RadComboBox ddlHourType = (editedItem.FindControl("ddlHourType") as RadComboBox);
                if (ddlHourType != null)
                {
                    if (ddlHourType.Items.Count > 0)
                    {
                        #region delete old records

                        Hashtable ht = new Hashtable();
                        ht.Add("@ID", Convert.ToInt32(editedItem.GetDataKeyValue("recidd")));
                        clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_EmployeeHourTypeAssignment_detail", ht);

                        #endregion

                        RadGrid rgProject = (ddlHourType.Items[0].FindControl("rGrdHourType4DDL") as RadGrid);
                        if (rgProject.SelectedItems.Count > 0)
                        {
                            foreach (GridDataItem dataItem in rgProject.SelectedItems)
                            {
                                newPaycodeValues["@hrtidd"] = Convert.ToInt32(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString());
                                newPaycodeValues["@hrtcod"] = dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["hourtypecode"].ToString();
                                newPaycodeValues["@DBMessage"] = "";
                                string DBMessage = "";

                                DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_HourTypeEmployeeAssignment_Record", newPaycodeValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255).ToString();
                                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                                {
                                    ShowClientMessage(DBMessage, MessageType.Error);
                                    e.Canceled = true;
                                }
                            }
                        }
                    }
                }
                ShowClientMessage("Employee hour type assignment record saved successfully.", MessageType.Success);
                gvEmployee.Rebind();
            }
        }
        catch (Exception ex)
        {
            ShowClientMessage("Unable to save employee hour type assignment record. Reason: " + ex.Message, MessageType.Error);
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
    protected void gvEmployee_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;

        switch (e.DetailTableView.Name)
        {
            case "EmployeeDetail":
                {
                    string id = dataItem.GetDataKeyValue("recidd").ToString();

                    Hashtable ht = new Hashtable();
                    ht.Add("@ID", id);

                    dtEmployeeDetail = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_EmployeeHourTypeAssignment_detail", ht).Tables[0];
                    dtEmployeeDetail.TableName = "EmployeeDetail";
                    e.DetailTableView.DataSource = dtEmployeeDetail;
                    e.DetailTableView.DataMember = "EmployeeDetail";
                    break;
                }
        }
    }

    // grid header setting for exporting
    protected void gvEmployee_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (exporting && e.Item.ItemType == Telerik.Web.UI.GridItemType.FilteringItem)
        {
            e.Item.Visible = false;
        }
    }
   
    protected void rGrdHourType4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        htSearchParams = new Hashtable();
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_payroll_GetHourTypeRecords", htSearchParams).Tables[0];
    }
}