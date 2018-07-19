using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Payroll_CalenderSetup : BasePage
{
    public static Hashtable htSearchParams = null;
    public bool exporting = false;
    public bool exportingHolidays = false;
    public bool exportingSection = false;
    DataTable dtHolidays = new DataTable();
    DataTable dtShift = new DataTable();
    DataTable dtShiftDetail = new DataTable();

    // base page initializing 
    protected override void Page_Init(object sender, EventArgs e)
    {
        FormName = "Calender Form";
        base.Page_Init(sender, e);
    }

    // page load function
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    // calender master grid loading and data binding
    protected void gvCalender_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        DataTable dt = clsDAL.GetDataSet_Payroll("sp_payroll_GetAllCalenderRecords", htSearchParams).Tables[0];
        dt.TableName = "CalenderMaster";
        gvCalender.DataSource = dt;
        gvCalender.DataMember = "CalenderMaster";
    }

    // days rounding ddl data loading and binding
    protected void rGrdDaysRounding4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromCentralDb(Constraints.DropDownLists.DaysRounding, -1, 1).Tables[0];
    }

    // based on ddl data loading and binding
    protected void rGrdBasedOn4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromCentralDb(Constraints.DropDownLists.GrtBasedOn, -1, 1).Tables[0];
    }

    // salary option ddl data loading and binding
    protected void rGrdSalaryOption4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromCentralDb(Constraints.DropDownLists.GrtSalaryOptions, -1, 1).Tables[0];
    }

    // grid update command
    protected void gvCalender_UpdateCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_Calender(ref e, "Update");
    }

    // grid delete command for master and detail tables
    protected void gvCalender_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        Hashtable ht = new Hashtable();
        if (e.Item.OwnerTableView.DataMember == "CalenderMaster")
        {
            int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("recidd");

            if (ID > 0)
            {
                ht.Add("@ID", ID);
                clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_CalenderMasterRecord", ht);
            }
        }
        else if (e.Item.OwnerTableView.DataMember == "Holidays")
        {
            int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("recidd");

            if (ID > 0)
            {
                ht.Add("@ID", ID);
                clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Holidays", ht);
            }
        }
        else if (e.Item.OwnerTableView.DataMember == "ShiftDetail")
        {
            int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("recidd");

            if (ID > 0)
            {
                ht.Add("@ID", ID);
                clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_CalenderShiftDetail", ht);
            }
        }
    }

    // client side function for calender master form input
    public void ValidateCalender(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadTextBox txtcalcode = (editForm.FindControl("txtcalcode") as RadTextBox);
        RadTextBox txtcaldsc = (editForm.FindControl("txtcaldsc") as RadTextBox);
        RadComboBox ddlBasedOn = (editForm.FindControl("ddlBasedOn") as RadComboBox);
        RadComboBox ddlDaysRounding = (editForm.FindControl("ddlDaysRounding") as RadComboBox);
        RadNumericTextBox txtgrtsom = (editForm.FindControl("txtgrtsom") as RadNumericTextBox);
        RadNumericTextBox txtBxgrtamt = (editForm.FindControl("txtBxgrtamt") as RadNumericTextBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidateCalender('" +
                txtcalcode.ClientID + "','" +
                txtcaldsc.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateCalender('" +
                txtcalcode.ClientID + "','" +
                txtcaldsc.ClientID

                + "')");
        }
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

    // client side validation function for hoilday form input controls
    public void ValidateHolidays(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadDatePicker dtpExpectedDate = (editForm.FindControl("dtpExpectedDate") as RadDatePicker);
        RadComboBox ddlDayType = (editForm.FindControl("ddlDayType") as RadComboBox);
        RadTextBox txtDescription = (editForm.FindControl("txtDescription") as RadTextBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidateHolidays('" +
                dtpExpectedDate.ClientID + "','" +
                ddlDayType.ClientID + "','" +
                txtDescription.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateHolidays('" +
                dtpExpectedDate.ClientID + "','" +
                ddlDayType.ClientID + "','" +
                txtDescription.ClientID
                + "')");
        }
    }

    // client side validation function for shift detail form input controls
    public void ValidateShiftDetail(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadComboBox ddlDayType = (editForm.FindControl("ddlDayType") as RadComboBox);
        RadTimePicker tpkrTimeIn = (editForm.FindControl("tpkrTimeIn") as RadTimePicker);
        RadTimePicker tpkrTimeOut = (editForm.FindControl("tpkrTimeOut") as RadTimePicker);
        RadTimePicker tpkrLateArrival = (editForm.FindControl("tpkrLateArrival") as RadTimePicker);
        RadTimePicker tpkrLeaveEarly = (editForm.FindControl("tpkrLeaveEarly") as RadTimePicker);
        RadTimePicker tpkrOvertimeStart = (editForm.FindControl("tpkrOvertimeStart") as RadTimePicker);
        RadTimePicker tpkrNightShiftStart = (editForm.FindControl("tpkrNightShiftStart") as RadTimePicker);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidateShiftDetail('" +
                ddlDayType.ClientID + "','" +
                tpkrTimeIn.ClientID + "','" +
                tpkrTimeOut.ClientID + "','" +
                tpkrLateArrival.ClientID + "','" +
                tpkrLeaveEarly.ClientID + "','" +
                tpkrOvertimeStart.ClientID + "','" +
                tpkrNightShiftStart.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateShiftDetail('" +
                ddlDayType.ClientID + "','" +
                tpkrTimeIn.ClientID + "','" +
                tpkrTimeOut.ClientID + "','" +
                tpkrLateArrival.ClientID + "','" +
                tpkrLeaveEarly.ClientID + "','" +
                tpkrOvertimeStart.ClientID + "','" +
                tpkrNightShiftStart.ClientID
                + "')");
        }
    }

    // input control settings for insert/update operations
    protected void gvCalender_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            if (e.Item.OwnerTableView.DataMember == "CalenderMaster")
            {
                ValidateCalender(e);

                if (e.Item.OwnerTableView.IsItemInserted)
                {
                    #region  item is about to be inserted

                    GridEditableItem insertedItem = (GridEditableItem)e.Item;

                    RadComboBox ddlEmployeeClassType = (RadComboBox)insertedItem.FindControl("ddlEmployeeClassType");

                    #endregion
                }
                else
                {
                    #region item is about to be edited
                    GridEditableItem editedItem = (GridEditableItem)e.Item;

                    RadComboBox ddlDaysRounding = (RadComboBox)editedItem.FindControl("ddlDaysRounding");
                    HiddenField hfDaysRoundingdllID = (HiddenField)editedItem.FindControl("hfDaysRoundingdllID");
                    HiddenField hfDaysRoundingdllText = (HiddenField)editedItem.FindControl("hfDaysRoundingdllText");

                    if (ddlDaysRounding != null)
                    {
                        RadGrid grid = ddlDaysRounding.Items[0].FindControl("rGrdDaysRounding4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfDaysRoundingdllID.Value) && !string.IsNullOrEmpty(hfDaysRoundingdllText.Value))
                        {
                            ddlDaysRounding.Items[0].Value = hfDaysRoundingdllID.Value;
                            ddlDaysRounding.Items[0].Text = hfDaysRoundingdllText.Value;
                            ddlDaysRounding.Text = hfDaysRoundingdllText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfDaysRoundingdllID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["ValueSetID"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }

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


                    RadComboBox ddlPaycode = (RadComboBox)editedItem.FindControl("ddlPaycode");
                    HiddenField hfCalenderId = (HiddenField)editedItem.FindControl("hfCalenderId");

                    if (ddlPaycode != null)
                    {
                        if (hfCalenderId != null)
                        {
                            Int32 ID = Convert.ToInt32(hfCalenderId.Value);
                            Hashtable ht = new Hashtable();
                            ht.Add("@ID", ID);
                            DataTable dt_PayCodes = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_Calender_PayCodes", ht).Tables[0];

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
            else if (e.Item.OwnerTableView.DataMember == "Holidays")
            {
                ValidateHolidays(e);

                if (e.Item.OwnerTableView.IsItemInserted)
                {
                    #region  item is about to be inserted

                    GridEditableItem insertedItem = (GridEditableItem)e.Item;

                    RadComboBox ddlEmployeeClassType = (RadComboBox)insertedItem.FindControl("ddlEmployeeClassType");

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
            else if (e.Item.OwnerTableView.DataMember == "ShiftDetail")
            {
                ValidateShiftDetail(e);

                if (e.Item.OwnerTableView.IsItemInserted)
                {
                    #region  item is about to be inserted

                    GridEditableItem insertedItem = (GridEditableItem)e.Item;

                    RadComboBox ddlEmployeeClassType = (RadComboBox)insertedItem.FindControl("ddlEmployeeClassType");

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
    // exporting functions
    protected void gvCalender_ItemCommand(object sender, GridCommandEventArgs e)
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

            if (e.Item.OwnerTableView.DataMember == "CalenderMaster")
            {
                grid.MasterTableView.GetColumn("EditCalender").Visible = false;
                grid.MasterTableView.GetColumn("DeleteCalender").Visible = false;
                grid.MasterTableView.ExportToExcel();
            }
            else if (e.Item.OwnerTableView.DataMember == "Holidays")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
                grid.MasterTableView.ExportToExcel();
            }
            else if (e.Item.OwnerTableView.DataMember == "Shift")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
                grid.MasterTableView.ExportToExcel();
            }
            else if (e.Item.OwnerTableView.DataMember == "ShiftDetail")
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

            if (e.Item.OwnerTableView.DataMember == "CalenderMaster")
            {
                grid.MasterTableView.GetColumn("EditCalender").Visible = false;
                grid.MasterTableView.GetColumn("DeleteCalender").Visible = false;
            }
            else if (e.Item.OwnerTableView.DataMember == "Holidays")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "Shift")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
                grid.MasterTableView.ExportToExcel();
            }
            else if (e.Item.OwnerTableView.DataMember == "ShiftDetail")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
                grid.MasterTableView.ExportToExcel();
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

            if (e.Item.OwnerTableView.DataMember == "CalenderMaster")
            {
                grid.MasterTableView.GetColumn("EditCalender").Visible = false;
                grid.MasterTableView.GetColumn("DeleteCalender").Visible = false;
            }
            else if (e.Item.OwnerTableView.DataMember == "Holidays")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "Shift")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
                grid.MasterTableView.ExportToExcel();
            }
            else if (e.Item.OwnerTableView.DataMember == "ShiftDetail")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
                grid.MasterTableView.ExportToExcel();
            }

            grid.MasterTableView.ExportToPdf();
        }
        if (e.CommandName == "Print")
        {
            Button btnPrint = (Button)e.Item.FindControl("btnDepartmentPrint");
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

    // export formating function
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

                if (column.UniqueName == "EditHolidays" || column.UniqueName == "DeleteHolidays")
                {
                    column.Display = false;
                    column.Visible = false;
                }
                if (column.UniqueName == "EditShiftDetails" || column.UniqueName == "DeleteShiftDetails")
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

    // export formating functions
    void HideCommandColumns(GridTableView gridTableView)
    {
        foreach (GridNestedViewItem nestedViewItem in gridTableView.GetItems(GridItemType.NestedView))
        {
            if (nestedViewItem.NestedTableViews.Length > 0)
            {
                foreach (GridColumn column in gridTableView.Columns)
                {
                    if (column.UniqueName == "EditHolidays" || column.UniqueName == "DeleteHolidays")
                    {
                        column.Display = false;
                        column.Visible = false;
                    }

                }
                HideCommandColumns(nestedViewItem.NestedTableViews[0]);
            }
        }

    }

    // grid insert command
    protected void gvCalender_InsertCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_Calender(ref e, "Insert");
    }

    // insert/update function
    private void Insert_or_Update_Calender(ref GridCommandEventArgs e, string operation)
    {
        GridEditableItem editedItem = e.Item as GridEditableItem;
        try
        {
            //Insert new values
            Hashtable newValues = new Hashtable();
            if (e.Item.OwnerTableView.DataMember == "CalenderMaster")
            {
                #region Calender Master

                if (operation == "Update")
                {
                    newValues["@recidd"] = (int)editedItem.GetDataKeyValue("recidd");
                }
                newValues["@calcod"] = (editedItem.FindControl("txtcalcode") as RadTextBox).Text.Trim();
                newValues["@caldsc"] = (editedItem.FindControl("txtcaldsc") as RadTextBox).Text;
                newValues["@calact"] = (editedItem.FindControl("chkbxActive") as CheckBox).Checked;

                newValues["@DBMessage"] = "";

                string DBMessage = "";

                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_CalenderMasterRecord", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Update_CalenderMasterRecord", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }

                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                else
                {
                    ShowClientMessage("Calender master record saved successfully.", MessageType.Success);
                    gvCalender.Rebind();
                }

                #endregion
            }
            else if (e.Item.OwnerTableView.DataMember == "Holidays")
            {
                #region Holidays

                if (operation == "Update")
                {
                    newValues["@recidd"] = (int)editedItem.GetDataKeyValue("recidd");
                }
                GridDataItem parentItem = (GridDataItem)(e.Item.OwnerTableView.ParentItem);
                if (parentItem != null)
                {
                    newValues["@calidd"] = Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["recidd"].ToString());
                }

                newValues["@calext"] = (editedItem.FindControl("dtpExpectedDate") as RadDatePicker).SelectedDate;
                newValues["@calact"] = (editedItem.FindControl("dtpActualdate") as RadDatePicker).SelectedDate;
                newValues["@calholidd"] = (editedItem.FindControl("ddlDayType") as RadComboBox).Items[0].Value.Trim();
                newValues["@caldsc"] = (editedItem.FindControl("txtDescription") as RadTextBox).Text;

                newValues["@DBMessage"] = "";

                string DBMessage = "";

                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_CalenderHoliday", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Update_CalenderHoliday", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }

                #endregion

                ShowClientMessage("Holiday details saved successfully.", MessageType.Success);
            }
            else if (e.Item.OwnerTableView.DataMember == "ShiftDetail")
            {
                #region Shift Detail

                if (operation == "Update")
                {
                    newValues["@recidd"] = (int)editedItem.GetDataKeyValue("recidd");
                }
                GridDataItem parentItem = (GridDataItem)(e.Item.OwnerTableView.ParentItem);
                if (parentItem != null)
                {
                    newValues["@calsid"] = Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["ValueSetID"].ToString());
                }
                GridDataItem secondParentItem = (GridDataItem)(e.Item.OwnerTableView.ParentItem);
                if (secondParentItem != null)
                {
                    newValues["@calidd"] = Convert.ToInt32(secondParentItem.OwnerTableView.ParentItem.OwnerTableView.DataKeyValues[secondParentItem.OwnerTableView.ParentItem.ItemIndex]["recidd"].ToString());
                }

                newValues["@caldid"] = (editedItem.FindControl("ddlDayType") as RadComboBox).Items[0].Value.Trim();
                newValues["@caltmi"] = (editedItem.FindControl("tpkrTimeIn") as RadTimePicker).SelectedTime;
                newValues["@caltmo"] = (editedItem.FindControl("tpkrTimeOut") as RadTimePicker).SelectedTime;
                newValues["@callta"] = (editedItem.FindControl("tpkrLateArrival") as RadTimePicker).SelectedTime;
                newValues["@callve"] = (editedItem.FindControl("tpkrLeaveEarly") as RadTimePicker).SelectedTime;
                newValues["@calovs"] = (editedItem.FindControl("tpkrOvertimeStart") as RadTimePicker).SelectedTime;
                newValues["@calnss"] = (editedItem.FindControl("tpkrNightShiftStart") as RadTimePicker).SelectedTime;

                newValues["@DBMessage"] = "";

                string DBMessage = "";

                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_CalenderShiftDetail", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Update_CalenderShiftDetail", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                else
                {
                    ShowClientMessage("Shift details saved successfully.", MessageType.Success);
                }
                #endregion

            }
        }
        catch (Exception ex)
        {
            ShowClientMessage("Unable to update/insert Calender record. Reason: " + ex.Message, MessageType.Error);
            e.Canceled = true;
        }
    }

    // display message on client side
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

    // get value of boolean grid column
    protected bool CheckBoxValue(object value)
    {
        if (Convert.ToString(value) == "1") return true;
        else if (Convert.ToString(value) == "True") return true;
        else if (Convert.ToString(value) == "true") return true;

        return false;
    }

    // get image of boolean grid column
    protected string getImagePathForTrue(bool flag)
    {
        if (flag)
            return "~/Images/16x16_tick.png";
        else
            return "";
    }

    // grid export formating
    protected void gvCalender_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (exporting)
        {
            if ((e.Item.ItemType == Telerik.Web.UI.GridItemType.FilteringItem) || (e.Item.ItemType == Telerik.Web.UI.GridItemType.CommandItem))
            {
                e.Item.Visible = false;
            }
        }
    }

    // calender detail table data loading and binding
    protected void gvCalender_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;

        switch (e.DetailTableView.Name)
        {
            case "Holidays":
                {
                    string ID = dataItem.GetDataKeyValue("recidd").ToString();

                    Hashtable ht = new Hashtable();
                    ht.Add("@CalID", ID);

                    dtHolidays = clsDAL.GetDataSet_Payroll("sp_Payroll_GetCalenderHolidays", ht).Tables[0];
                    dtHolidays.TableName = "Holidays";
                    e.DetailTableView.DataSource = dtHolidays;
                    e.DetailTableView.DataMember = "Holidays";
                    break;
                }
            case "Shift":
                {
                    dtShift = clsCommon.DDLValueSet_GetByDDLID_FromCentralDb(Constraints.DropDownLists.CalenderShift, -1, 1).Tables[0];
                    dtShift.TableName = "Shift";
                    e.DetailTableView.DataSource = dtShift;
                    e.DetailTableView.DataMember = "Shift";
                    break;
                }
            case "ShiftDetail":
                {
                    string calID = dataItem.OwnerTableView.ParentItem.OwnerTableView.DataKeyValues[dataItem.OwnerTableView.ParentItem.ItemIndex]["recidd"].ToString();

                    string shiftID = dataItem.GetDataKeyValue("ValueSetID").ToString();

                    Hashtable ht = new Hashtable();
                    ht.Add("@CalID", calID);
                    ht.Add("@ShftID", shiftID);

                    dtShiftDetail = clsDAL.GetDataSet_Payroll("sp_Payroll_GetCalenderShift", ht).Tables[0];
                    dtShiftDetail.TableName = "ShiftDetail";
                    e.DetailTableView.DataSource = dtShiftDetail;
                    e.DetailTableView.DataMember = "ShiftDetail";
                    break;
                }
        }
    }
}