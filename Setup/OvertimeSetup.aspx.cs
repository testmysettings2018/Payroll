using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Payroll_OvertimeSetup : BasePage
{

    public static Hashtable htSearchParams = null;
    public bool exporting = false;
    DataTable dtovtDetail = new DataTable();

    // base page initializing
    protected override void Page_Init(object sender, EventArgs e)
    {
        FormName = "Overtime Form";
        base.Page_Init(sender, e);
    }

    // page load function
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    // overtime master grid data loading and binding
    protected void gvOvertime_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        DataTable dt = clsDAL.GetDataSet_Payroll("sp_payroll_GetAllOvertimeRecords", htSearchParams).Tables[0];
        dt.TableName = "OvertimeMaster";
        gvOvertime.DataSource = dt;
        gvOvertime.DataMember = "OvertimeMaster";
    }

    // data entry ddl data loading and binding
    protected void rGrdDataEntryStyle4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromCentralDb(Constraints.DropDownLists.DataEntryStyle, -1, 1).Tables[0];
    }

    // based on ddl data loading and binding
    protected void rGrdBasedOn4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromCentralDb(Constraints.DropDownLists.GrtBasedOn, -1, 1).Tables[0];
    }

    // pay code ddl data loading and binding
    protected void rGrdPayCode4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_PayCode_Records", htSearchParams).Tables[0];
    }

    // day type ddl data loading and binding
    protected void rGrdDayType4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_GetDayTypes", htSearchParams).Tables[0];
    }

    // grid update command
    protected void gvOvertime_UpdateCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_Overtime(ref e, "Update");
    }

    // grid delete command for master and detail grid
    protected void gvOvertime_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        Hashtable ht = new Hashtable();

        if (e.Item.OwnerTableView.DataMember == "OvertimeMaster")
        {
            int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("recidd");
            if (ID > 0)
            {
                ht.Add("@ID", ID);
                clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_OvertimeMaster", ht);
            }
        }
        else if (e.Item.OwnerTableView.DataMember == "ovtDetail")
        {
            int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("recidd");
            if (ID > 0)
            {
                ht.Add("@ID", ID);
                clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Overtime_DayType", ht);
            }
        }
    }

    // client side validation function for overtime master input form
    public void ValidateOvertime(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadTextBox txtovtcod = (editForm.FindControl("txtovtcod") as RadTextBox);
        RadTextBox txtovtdsc = (editForm.FindControl("txtovtdsc") as RadTextBox);
        RadComboBox ddlBasedOn = (editForm.FindControl("ddlBasedOn") as RadComboBox);
        RadComboBox ddlDataEntryStyle = (editForm.FindControl("ddlDataEntryStyle") as RadComboBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidateOvertime('" +
                txtovtcod.ClientID + "','" +
                txtovtdsc.ClientID + "','" +
                ddlBasedOn.ClientID + "','" +
                ddlDataEntryStyle.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateOvertime('" +
                txtovtcod.ClientID + "','" +
                txtovtdsc.ClientID + "','" +
                ddlBasedOn.ClientID + "','" +
                ddlDataEntryStyle.ClientID
                + "')");
        }
    }

    // client side validation function for overtime detail input form
    public void ValidateOvertimeDetail(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadComboBox ddlDayType = (editForm.FindControl("ddlDayType") as RadComboBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidateOvertimeDetail('" +
                ddlDayType.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateOvertimeDetail('" +
                ddlDayType.ClientID
                + "')");
        }
    }

    // form input control settings for insert/udpate
    protected void gvOvertime_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            if (e.Item.OwnerTableView.DataMember == "OvertimeMaster")
            {
                ValidateOvertime(e);

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

                    RadComboBox ddlBasedOn = (RadComboBox)editedItem.FindControl("ddlBasedOn");
                    HiddenField hfBasedOndllID = (HiddenField)editedItem.FindControl("hfBasedOndllID");
                    HiddenField hfBasedOndllText = (HiddenField)editedItem.FindControl("hfBasedOndllText");

                    if (ddlBasedOn != null)
                    {
                        RadGrid grid = ddlBasedOn.Items[0].FindControl("rGrdBasedOn4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfBasedOndllID.Value) && !string.IsNullOrEmpty(hfBasedOndllText.Value))
                        {
                            ddlBasedOn.Items[0].Value = hfBasedOndllID.Value;
                            ddlBasedOn.Items[0].Text = hfBasedOndllText.Value;
                            ddlBasedOn.Text = hfBasedOndllText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfBasedOndllID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["ValueSetID"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    RadComboBox ddlDataEntryStyle = (RadComboBox)editedItem.FindControl("ddlDataEntryStyle");
                    HiddenField hfDataEntryStyledllID = (HiddenField)editedItem.FindControl("hfDataEntryStyledllID");
                    HiddenField hfDataEntryStyledllText = (HiddenField)editedItem.FindControl("hfDataEntryStyledllText");

                    if (ddlDataEntryStyle != null)
                    {
                        RadGrid grid = ddlDataEntryStyle.Items[0].FindControl("rGrdDataEntryStyle4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfDataEntryStyledllID.Value) && !string.IsNullOrEmpty(hfDataEntryStyledllText.Value))
                        {
                            ddlDataEntryStyle.Items[0].Value = hfDataEntryStyledllID.Value;
                            ddlDataEntryStyle.Items[0].Text = hfDataEntryStyledllText.Value;
                            ddlDataEntryStyle.Text = hfDataEntryStyledllText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfDataEntryStyledllID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["ValueSetID"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    RadComboBox ddlPaycode = (RadComboBox)editedItem.FindControl("ddlPaycode");
                    HiddenField hfOvertimeId = (HiddenField)editedItem.FindControl("hfOvertimeId");

                    if (ddlPaycode != null)
                    {
                        if (hfOvertimeId != null)
                        {
                            Int32 ID = Convert.ToInt32(hfOvertimeId.Value);
                            Hashtable ht = new Hashtable();
                            ht.Add("@ID", ID);
                            DataTable dt_PayCodes = clsDAL.GetDataSet_Payroll("sp_Payroll_GetOvertimePayCodes", ht).Tables[0];

                            RadGrid grid = ddlPaycode.Items[0].FindControl("rGrdPayCode4DDL") as RadGrid;
                            if (grid != null)
                            {
                                grid.Rebind();
                                ddlPaycode.Text = string.Empty;
                                foreach (GridItem item in grid.MasterTableView.Items)
                                {
                                    if (item is GridDataItem)
                                    {
                                        GridDataItem dataItem = (GridDataItem)item;

                                        foreach (DataRow row in dt_PayCodes.Rows)
                                        {
                                            if (row["payidd"].ToString().Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
                                            {
                                                if (!string.IsNullOrEmpty(ddlPaycode.Text))
                                                    ddlPaycode.Text = ddlPaycode.Text + ",";
                                                ddlPaycode.Text = ddlPaycode.Text + row["paycod"].ToString();
                                                dataItem.Selected = true;
                                                break;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    #endregion
                }
            }
            else if (e.Item.OwnerTableView.DataMember == "ovtDetail")
            {
                ValidateOvertimeDetail(e);

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

                    RadComboBox ddlDayType = (RadComboBox)editedItem.FindControl("ddlDayType");
                    HiddenField hfdayId = (HiddenField)editedItem.FindControl("hfdayId");
                    HiddenField hfdaycod = (HiddenField)editedItem.FindControl("hfdaycod");

                    if (ddlDayType != null)
                    {
                        RadGrid grid = ddlDayType.Items[0].FindControl("rGrdDayType4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfdayId.Value) && !string.IsNullOrEmpty(hfdaycod.Value))
                        {
                            ddlDayType.Items[0].Value = hfdayId.Value;
                            ddlDayType.Items[0].Text = hfdaycod.Value;
                            ddlDayType.Text = hfdaycod.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfdayId.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
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
                ht_Reports.Add("@formtypeid", Request.QueryString["FormType"]); 
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
    protected void gvOvertime_ItemCommand(object sender, GridCommandEventArgs e)
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

            if (e.Item.OwnerTableView.DataMember == "OvertimeMaster")
            {
                grid.MasterTableView.GetColumn("EditOvertime").Visible = false;
                grid.MasterTableView.GetColumn("DeleteOvertime").Visible = false;
                grid.MasterTableView.ExportToExcel();
            }
            else if (e.Item.OwnerTableView.DataMember == "ovtDetail")
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

            if (e.Item.OwnerTableView.DataMember == "OvertimeMaster")
            {
                grid.MasterTableView.GetColumn("EditOvertime").Visible = false;
                grid.MasterTableView.GetColumn("DeleteOvertime").Visible = false;
            }
            else if (e.Item.OwnerTableView.DataMember == "ovtDetail")
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

            if (e.Item.OwnerTableView.DataMember == "OvertimeMaster")
            {
                grid.MasterTableView.GetColumn("EditOvertime").Visible = false;
                grid.MasterTableView.GetColumn("DeleteOvertime").Visible = false;
            }
            else if (e.Item.OwnerTableView.DataMember == "ovtDetail")
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

                if (column.UniqueName == "EditovtDetail" || column.UniqueName == "DeleteovtDetail")
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
    protected void gvOvertime_InsertCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_Overtime(ref e, "Insert");
    }

    // insert/update function
    private void Insert_or_Update_Overtime(ref GridCommandEventArgs e, string operation)
    {
        GridEditableItem editedItem = e.Item as GridEditableItem;
        try
        {
            //Insert new values
            Hashtable newValues = new Hashtable();

            if (e.Item.OwnerTableView.DataMember == "OvertimeMaster")
            {
                if (operation == "Update")
                {
                    newValues["@recidd"] = (int)editedItem.GetDataKeyValue("recidd");
                }
                newValues["@ovtcod"] = (editedItem.FindControl("txtovtCod") as RadTextBox).Text.Trim();
                newValues["@ovtdsc"] = (editedItem.FindControl("txtovtdsc") as RadTextBox).Text;
                newValues["@ovtbao"] = (editedItem.FindControl("ddlBasedOn") as RadComboBox).Items[0].Value.Trim();
                newValues["@ovtdae"] = (editedItem.FindControl("ddlDataEntryStyle") as RadComboBox).Items[0].Value.Trim();

                newValues["@DBMessage"] = "";

                string DBMessage = "";

                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Insert_OvertimeMaster", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                    string oid = DBMessage; 
                    if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                    {
                        ShowClientMessage(DBMessage, MessageType.Error);
                        e.Canceled = true;
                    }
                    else
                    {
                        #region Pay Codes

                        //Insert new values
                        Hashtable newPaycodeValues = new Hashtable();

                        if (!string.IsNullOrEmpty(oid))
                        {
                            newPaycodeValues["@ovtidd"] = Convert.ToInt32(oid);

                            RadComboBox ddlPayCode = (editedItem.FindControl("ddlPayCode") as RadComboBox);
                            if (ddlPayCode != null)
                            {
                                if (ddlPayCode.Items.Count > 0)
                                {
                                    #region delete old records

                                    Hashtable ht = new Hashtable();
                                    ht.Add("@ID", Convert.ToInt32(oid));
                                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Overtime_Paycodes", ht);

                                    #endregion

                                    RadGrid rgPayCodes = (ddlPayCode.Items[0].FindControl("rGrdPayCode4DDL") as RadGrid);
                                    if (rgPayCodes.SelectedItems.Count > 0)
                                    {
                                        foreach (GridDataItem dataItem in rgPayCodes.SelectedItems)
                                        {
                                            newPaycodeValues["@payidd"] = Convert.ToInt32(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString());
                                            newPaycodeValues["@DBMessage"] = "";

                                            clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_Overtime_PayCode", newPaycodeValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255);
                                            if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                                            {
                                                ShowClientMessage(DBMessage, MessageType.Error);
                                                e.Canceled = true;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        #endregion

                        ShowClientMessage("Overtime record saved successfully.", MessageType.Success);
                        gvOvertime.Rebind();
                    }
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Update_OvertimeMaster", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                    if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                    {
                        ShowClientMessage(DBMessage, MessageType.Error);
                        e.Canceled = true;
                    }
                    else
                    {
                        #region Pay Codes

                    //Insert new values
                    Hashtable newPaycodeValues = new Hashtable();

                    newPaycodeValues["@ovtidd"] = Convert.ToInt32((int)editedItem.GetDataKeyValue("recidd"));

                    RadComboBox ddlPayCode = (editedItem.FindControl("ddlPayCode") as RadComboBox);
                    if (ddlPayCode != null)
                    {
                        if (ddlPayCode.Items.Count > 0)
                        {
                            #region delete old records

                            Hashtable ht = new Hashtable();
                            ht.Add("@ID", Convert.ToInt32((int)editedItem.GetDataKeyValue("recidd")));
                            clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Overtime_Paycodes", ht);

                            #endregion

                            RadGrid rgPayCodes = (ddlPayCode.Items[0].FindControl("rGrdPayCode4DDL") as RadGrid);
                            if (rgPayCodes.SelectedItems.Count > 0)
                            {
                                foreach (GridDataItem dataItem in rgPayCodes.SelectedItems)
                                {
                                    newPaycodeValues["@payidd"] = Convert.ToInt32(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString());
                                    newPaycodeValues["@DBMessage"] = "";

                                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_Overtime_PayCode", newPaycodeValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255);
                                    if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                                    {
                                        ShowClientMessage(DBMessage, MessageType.Error);
                                        e.Canceled = true;
                                    }
                                }
                            }
                        }
                    }

                    #endregion
                        
                        ShowClientMessage("Overtime record saved successfully.", MessageType.Success);
                        gvOvertime.Rebind();
                    }
                }           
            }

            else if (e.Item.OwnerTableView.DataMember == "ovtDetail")
            {
                if (operation == "Update")
                {
                    newValues["@recidd"] = (int)editedItem.GetDataKeyValue("recidd");
                }
                GridDataItem parentItem = (GridDataItem)(e.Item.OwnerTableView.ParentItem);
                if (parentItem != null)
                {
                    newValues["@ovtidd"] = Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["recidd"].ToString());
                }
                newValues["@dayidd"] = (editedItem.FindControl("ddlDayType") as RadComboBox).Items[0].Value.Trim();
                newValues["@dayprt"] = (editedItem.FindControl("txtdayprt") as RadNumericTextBox).Text == "" ? "0" : (editedItem.FindControl("txtdayprt") as RadNumericTextBox).Text;
                newValues["@dayrat"] = (editedItem.FindControl("txtdayrat") as RadNumericTextBox).Text == "" ? "0" : (editedItem.FindControl("txtdayrat") as RadNumericTextBox).Text;
                newValues["@dy2prt"] = (editedItem.FindControl("txtdy2prt") as RadNumericTextBox).Text == "" ? "0" : (editedItem.FindControl("txtdy2prt") as RadNumericTextBox).Text;
                newValues["@dy2rat"] = (editedItem.FindControl("txtdy2rat") as RadNumericTextBox).Text == "" ? "0" : (editedItem.FindControl("txtdy2rat") as RadNumericTextBox).Text;

                newValues["@DBMessage"] = "";

                string DBMessage = "";

                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_Overtime_DayType", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Update_Overtime_DayType", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                else
                {
                    ShowClientMessage("Overtime Day type record saved successfully.", MessageType.Success);
                }
            }
        }
        catch (Exception ex)
        {
            ShowClientMessage("Unable to update/insert Overtime record. Reason: " + ex.Message, MessageType.Error);
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
    protected void gvOvertime_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;

        switch (e.DetailTableView.Name)
        {
            case "ovtDetail":
                {
                    string ID = dataItem.GetDataKeyValue("recidd").ToString();

                    Hashtable ht = new Hashtable();
                    ht.Add("@ID", ID);

                    dtovtDetail = clsDAL.GetDataSet_Payroll("sp_Payroll_GetOvertimeDayTypes", ht).Tables[0];
                    dtovtDetail.TableName = "ovtDetail";
                    e.DetailTableView.DataSource = dtovtDetail;
                    e.DetailTableView.DataMember = "ovtDetail";
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
    protected void gvOvertime_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (exporting && e.Item.ItemType == Telerik.Web.UI.GridItemType.FilteringItem)
        {
            e.Item.Visible = false;
        }
    }
}