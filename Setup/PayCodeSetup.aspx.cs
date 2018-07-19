using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Payroll_PayCodeSetup : System.Web.UI.Page
{
    public static Hashtable htSearchParams = null;
    public bool exporting = false;

    // page load function
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    // pay code master grid data loading and binding
    protected void gvPayCode_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_PayCode_Records", htSearchParams).Tables[0];
        dt.TableName = "PayCodeMaster";
        gvPayCode.DataSource = dt;
        gvPayCode.DataMember = "PayCodeMaster";
    }

    // pay code ddl data loading and binding
    protected void rGrdPayCodeType4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromCentralDb(Constraints.DropDownLists.PayCodeType, -1, 1).Tables[0];
    }

    // grade ddl data loading and binding
    protected void rGrdGrade4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_All_Grades", htSearchParams).Tables[0];
    }

    // pay period ddl data loading and binding
    protected void rGrdPayPeriod4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromCentralDb(Constraints.DropDownLists.PayCodePeriod, -1, 1).Tables[0];
    }

    // detail tables data binding
    protected void gvPayCode_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;
        switch (e.DetailTableView.Name)
        {
            case "Citizens":
                {
                    string ID = dataItem.GetDataKeyValue("recidd").ToString();

                    Hashtable ht = new Hashtable();
                    ht.Add("@PayCodeID", ID);

                    DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_GetPayCodeCitizens", ht).Tables[0];
                    dt.TableName = "Citizens";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "Citizens";
                    break;
                }
            case "Expatriate":
                {
                    string ID = dataItem.GetDataKeyValue("recidd").ToString();

                    Hashtable ht = new Hashtable();
                    ht.Add("@PayCodeID", ID);

                    DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_GetPayCodeExpatriate", ht).Tables[0];
                    dt.TableName = "Expatriate";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "Expatriate";
                    break;
                }
        }
    }

    // grid udpate command
    protected void gvPayCode_UpdateCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_User(ref e, "Update");
    }

    // grid delete command for both master and detail tables
    protected void gvPayCode_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        try
        {

            int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("recidd");
            Hashtable ht = new Hashtable();
            ht.Add("@ID", ID);

            if (e.Item.OwnerTableView.DataMember == "PayCodeMaster")
            {
                if (ID > 0)
                {
                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_PaycodeDetail", ht);
                }
            }
            else if (e.Item.OwnerTableView.DataMember == "Citizens")
            {
                if (ID > 0)
                {
                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_PaycodeDetailCitizenExpatriate", ht);
                }
            }
            else if (e.Item.OwnerTableView.DataMember == "Expatriate")
            {
                if (ID > 0)
                {
                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_PaycodeDetailCitizenExpatriate", ht);
                }
            }
        }
        catch (Exception ex)
        {

        }
    }

    // client side function to validate pay code function
    public void ValidatePayCode(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadTextBox txtPayCodeCode = (editForm.FindControl("txtPayCodeCode") as RadTextBox);
        RadTextBox txtDescription = (editForm.FindControl("txtDescription") as RadTextBox);
        RadComboBox ddlPayCodeType = (editForm.FindControl("ddlPayCodeType") as RadComboBox);
        RadComboBox ddlPayPeriod = (editForm.FindControl("ddlPayPeriod") as RadComboBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidatePayCode('" +
                txtPayCodeCode.ClientID + "','" +
                txtDescription.ClientID + "','" +
                ddlPayCodeType.ClientID + "','" +
                ddlPayPeriod.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidatePayCode('" +
                txtPayCodeCode.ClientID + "','" +
                txtDescription.ClientID + "','" +
                ddlPayCodeType.ClientID + "','" +
                ddlPayPeriod.ClientID
                + "')");
        }
    }

    // client side function to validate citizien form input
    public void ValidateCitizens(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadNumericTextBox txtCsngfrm = (editForm.FindControl("txtCsngfrm") as RadNumericTextBox);
        RadNumericTextBox txtBxCsngtoo = (editForm.FindControl("txtBxCsngtoo") as RadNumericTextBox);
        RadNumericTextBox txtBxCmarfrm = (editForm.FindControl("txtBxCmarfrm") as RadNumericTextBox);
        RadNumericTextBox txtBxCmartoo = (editForm.FindControl("txtBxCmartoo") as RadNumericTextBox);
        RadComboBox ddlCGrade = (editForm.FindControl("ddlCGrade") as RadComboBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidateCitizens('" +
                txtCsngfrm.ClientID + "','" +
                txtBxCsngtoo.ClientID + "','" +
                txtBxCmarfrm.ClientID + "','" +
                txtBxCmartoo.ClientID + "','" +
                ddlCGrade.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateCitizens('" +
                txtCsngfrm.ClientID + "','" +
                txtBxCsngtoo.ClientID + "','" +
                txtBxCmarfrm.ClientID + "','" +
                txtBxCmartoo.ClientID + "','" +
                ddlCGrade.ClientID
                + "')");
        }
    }

    // client side function to validate expat form input
    public void ValidateExpatriate(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadNumericTextBox txtEsngfrm = (editForm.FindControl("txtEsngfrm") as RadNumericTextBox);
        RadNumericTextBox txtBxEsngtoo = (editForm.FindControl("txtBxEsngtoo") as RadNumericTextBox);
        RadNumericTextBox txtBxEmarfrm = (editForm.FindControl("txtBxEmarfrm") as RadNumericTextBox);
        RadNumericTextBox txtBxEmartoo = (editForm.FindControl("txtBxEmartoo") as RadNumericTextBox);
        RadComboBox ddlEGrade = (editForm.FindControl("ddlEGrade") as RadComboBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidateExpatriate('" +
                txtEsngfrm.ClientID + "','" +
                txtBxEsngtoo.ClientID + "','" +
                txtBxEmarfrm.ClientID + "','" +
                txtBxEmartoo.ClientID + "','" +
                ddlEGrade.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateExpatriate('" +
                txtEsngfrm.ClientID + "','" +
                txtBxEsngtoo.ClientID + "','" +
                txtBxEmarfrm.ClientID + "','" +
                txtBxEmartoo.ClientID + "','" +
                ddlEGrade.ClientID
                + "')");
        }
    }

    // form input control setting for insert/update
    protected void gvPayCode_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            if (e.Item.OwnerTableView.DataMember == "PayCodeMaster")
            {
                ValidatePayCode(e);
                if (e.Item.OwnerTableView.IsItemInserted)
                {
                    #region  item is about to be inserted

                    GridEditableItem insertedItem = (GridEditableItem)e.Item;

                    RadComboBox ddlPayCodeType = (RadComboBox)insertedItem.FindControl("ddlPayCodeType");
                    //RadComboBox ddlGarnismentCategory = (RadComboBox)insertedItem.FindControl("ddlGarnismentCategory");
                    RadComboBox ddlMethod = (RadComboBox)insertedItem.FindControl("ddlMethod");
                    RadComboBox ddlPayPeriod = (RadComboBox)insertedItem.FindControl("ddlPayPeriod");
                    RadComboBox ddlNewEmoloyeeAnualLeave = (RadComboBox)insertedItem.FindControl("ddlNewEmoloyeeAnualLeave");
                    RadComboBox ddlPaycode = (RadComboBox)insertedItem.FindControl("ddlPaycode");

                    if (ddlPayCodeType != null)
                    {
                        RadGrid grid = ddlPayCodeType.Items[0].FindControl("rGrdPayCodeType4DDL") as RadGrid;
                        grid.Rebind();
                    }
                    //if (ddlGarnismentCategory != null)
                    //{
                    //    RadGrid grid = ddlGarnismentCategory.Items[0].FindControl("rGrdGarnismentCategory4DDL") as RadGrid;
                    //    grid.Rebind();
                    //}
                    if (ddlPayPeriod != null)
                    {
                        RadGrid grid = ddlPayPeriod.Items[0].FindControl("rGrdPayPeriod4DDL") as RadGrid;
                        grid.Rebind();
                    }
                    if (ddlMethod != null)
                    {
                        RadGrid grid = ddlMethod.Items[0].FindControl("rGrdMethod4DDL") as RadGrid;
                        grid.Rebind();
                    }
                    if (ddlPaycode != null)
                    {
                        Hashtable ht_filters = new Hashtable();
                        DataTable dt_Reports = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_PayCode_Records", ht_filters).Tables[0];
                        ddlPaycode.DataSource = dt_Reports;
                        ddlPaycode.DataTextField = "paycod";
                        ddlPaycode.DataValueField = "recidd";
                        ddlPaycode.DataBind();
                        ddlPaycode.SelectedIndex = 0;
                    }
                    #endregion
                }
                else
                {
                    #region item is about to be edited
                    GridEditableItem editedItem = (GridEditableItem)e.Item;

                    RadComboBox ddlPayCodeType = (RadComboBox)editedItem.FindControl("ddlPayCodeType");
                    HiddenField hfPayCodeTypedllID = (HiddenField)editedItem.FindControl("hfPayCodeTypedllID");
                    HiddenField hfPayCodeTypedllText = (HiddenField)editedItem.FindControl("hfPayCodeTypedllText");
                    HiddenField hfPayCodeTypedllValue = (HiddenField)editedItem.FindControl("hfPayCodeTypedllValue");

                    //RadComboBox ddlGarnismentCategory = (RadComboBox)editedItem.FindControl("ddlGarnismentCategory");
                    RadComboBox ddlPayPeriod = (RadComboBox)editedItem.FindControl("ddlPayPeriod");
                    HiddenField hfPayPerioddllID = (HiddenField)editedItem.FindControl("hfPayPerioddllID");
                    HiddenField hfPayPeriodddlText = (HiddenField)editedItem.FindControl("hfPayPeriodddlText");
                    HiddenField hfPayPeriodddlValue = (HiddenField)editedItem.FindControl("hfPayPeriodddlValue");

                    RadComboBox ddlMethod = (RadComboBox)editedItem.FindControl("ddlMethod");
                    HiddenField hfMethoddllID = (HiddenField)editedItem.FindControl("hfMethoddllID");
                    HiddenField hfMethodddlText = (HiddenField)editedItem.FindControl("hfMethodddlText");
                    HiddenField hfMethodddlValue = (HiddenField)editedItem.FindControl("hfMethodddlValue");

                    RadComboBox ddlPaycode = (RadComboBox)editedItem.FindControl("ddlPaycode");
                    HiddenField hfddlPaycodeID = (HiddenField)editedItem.FindControl("hfddlPaycodeID");
                    HiddenField hfddlPaycodeText = (HiddenField)editedItem.FindControl("hfddlPaycodeText");

                    HiddenField hfPayCodeID = (HiddenField)editedItem.FindControl("hfPayCodeID");


                    if (ddlPayCodeType != null)
                    {
                        RadGrid grid = ddlPayCodeType.Items[0].FindControl("rGrdPayCodeType4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfPayCodeTypedllID.Value) && !string.IsNullOrEmpty(hfPayCodeTypedllText.Value))
                        {
                            ddlPayCodeType.Items[0].Value = hfPayCodeTypedllID.Value;
                            ddlPayCodeType.Items[0].Text = hfPayCodeTypedllText.Value;
                            ddlPayCodeType.Text = hfPayCodeTypedllText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfPayCodeTypedllID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["ValueSetID"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }
                    //if (ddlGarnismentCategory != null)
                    //{
                    //    RadGrid grid = ddlGarnismentCategory.Items[0].FindControl("rGrdGarnismentCategory4DDL") as RadGrid;
                    //    grid.Rebind();
                    //}
                    if (ddlPayPeriod != null)
                    {
                        RadGrid grid = ddlPayPeriod.Items[0].FindControl("rGrdPayPeriod4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfPayPerioddllID.Value) && !string.IsNullOrEmpty(hfPayCodeTypedllText.Value))
                        {
                            ddlPayPeriod.Items[0].Value = hfPayPerioddllID.Value;
                            ddlPayPeriod.Items[0].Text = hfPayPeriodddlText.Value;
                            ddlPayPeriod.Text = hfPayPeriodddlText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfPayPerioddllID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["ValueSetID"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }
                    if (ddlMethod != null)
                    {
                        RadGrid grid = ddlMethod.Items[0].FindControl("rGrdMethod4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfMethoddllID.Value) && !string.IsNullOrEmpty(hfMethodddlText.Value))
                        {
                            ddlMethod.Items[0].Value = hfMethoddllID.Value;
                            ddlMethod.Items[0].Text = hfMethodddlText.Value;
                            ddlMethod.Text = hfMethodddlText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfMethoddllID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["ValueSetID"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    if (ddlPaycode != null)
                    {
                        Hashtable ht_filters = new Hashtable();
                        DataTable dt_Reports = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_PayCode_Records", ht_filters).Tables[0];
                        ddlPaycode.DataSource = dt_Reports;
                        ddlPaycode.DataTextField = "paycod";
                        ddlPaycode.DataValueField = "recidd";
                        ddlPaycode.DataBind();
                        ddlPaycode.SelectedIndex = 0;

                        if (hfPayCodeID != null)
                        {
                            Hashtable ht_PayCodesfilters = new Hashtable();
                            ht_PayCodesfilters.Add("@ID", Convert.ToInt32(hfPayCodeID.Value));
                            DataTable dt_PayCodes = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_PayCodePayCodes", ht_PayCodesfilters).Tables[0];

                            foreach (DataRow row in dt_PayCodes.Rows)
                            {
                                foreach (RadComboBoxItem item in ddlPaycode.Items)
                                {
                                    if (row["pcdidd"].ToString() == item.Value)
                                        item.Checked = true;
                                }
                            }
                        }
                    }
                    #endregion
                }
            }
            else if (e.Item.OwnerTableView.DataMember == "Citizens")
            {
                ValidateCitizens(e);
                if (e.Item.OwnerTableView.IsItemInserted)
                {
                    #region  item is about to be inserted

                    GridEditableItem insertedItem = (GridEditableItem)e.Item;
                    RadComboBox ddlCGrade = (RadComboBox)insertedItem.FindControl("ddlCGrade");
                    if (ddlCGrade != null)
                    {
                        RadGrid grid = ddlCGrade.Items[0].FindControl("rGrdCGrade4DDL") as RadGrid;
                        grid.Rebind();
                    }
                    #endregion
                }
                else
                {
                    #region item is about to be edited
                    GridEditableItem editedItem = (GridEditableItem)e.Item;

                    RadComboBox ddlCGrade = (RadComboBox)editedItem.FindControl("ddlCGrade");
                    HiddenField hfGradedllID = (HiddenField)editedItem.FindControl("hfGradedllID");
                    HiddenField hfGradedllText = (HiddenField)editedItem.FindControl("hfGradedllText");
                    if (ddlCGrade != null)
                    {
                        RadGrid grid = ddlCGrade.Items[0].FindControl("rGrdCGrade4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfGradedllID.Value) && !string.IsNullOrEmpty(hfGradedllText.Value))
                        {
                            ddlCGrade.Items[0].Value = hfGradedllID.Value;
                            ddlCGrade.Items[0].Text = hfGradedllText.Value;
                            ddlCGrade.Text = hfGradedllText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfGradedllID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["grdidd"].ToString()))
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
            else if (e.Item.OwnerTableView.DataMember == "Expatriate")
            {
                ValidateExpatriate(e);
                if (e.Item.OwnerTableView.IsItemInserted)
                {
                    #region  item is about to be inserted

                    GridEditableItem insertedItem = (GridEditableItem)e.Item;
                    RadComboBox ddlEGrade = (RadComboBox)insertedItem.FindControl("ddlEGrade");
                    if (ddlEGrade != null)
                    {
                        RadGrid grid = ddlEGrade.Items[0].FindControl("rGrdEGrade4DDL") as RadGrid;
                        grid.Rebind();
                    }
                    #endregion
                }
                else
                {
                    #region item is about to be edited
                    GridEditableItem editedItem = (GridEditableItem)e.Item;

                    RadComboBox ddlEGrade = (RadComboBox)editedItem.FindControl("ddlEGrade");
                    HiddenField hfEGradedllID = (HiddenField)editedItem.FindControl("hfEGradedllID");
                    HiddenField hfEGradedllText = (HiddenField)editedItem.FindControl("hfEGradedllText");
                    if (ddlEGrade != null)
                    {
                        RadGrid grid = ddlEGrade.Items[0].FindControl("rGrdEGrade4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfEGradedllID.Value) && !string.IsNullOrEmpty(hfEGradedllText.Value))
                        {
                            ddlEGrade.Items[0].Value = hfEGradedllID.Value;
                            ddlEGrade.Items[0].Text = hfEGradedllText.Value;
                            ddlEGrade.Text = hfEGradedllText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfEGradedllID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["grdidd"].ToString()))
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

    // grid header setting for exporting
    protected void gvPayCode_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (exporting && e.Item.ItemType == Telerik.Web.UI.GridItemType.FilteringItem)
        {
            e.Item.Visible = false;
        }
    }
    
    // settings to clear form input for insert/update
    // grid export function
    protected void gvPayCode_ItemCommand(object sender, GridCommandEventArgs e)
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

            if (e.Item.OwnerTableView.DataMember == "PayCodeMaster")
            {
                grid.MasterTableView.GetColumn("EditPaycod").Visible = false;
                grid.MasterTableView.GetColumn("DeletePaycod").Visible = false;
            }
            else if (e.Item.OwnerTableView.DataMember == "Citizens")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "Expatriate")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            grid.MasterTableView.ExportToExcel();
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
            if (e.Item.OwnerTableView.DataMember == "PayCodeMaster")
            {
                grid.MasterTableView.GetColumn("EditPaycod").Visible = false;
                grid.MasterTableView.GetColumn("DeletePaycod").Visible = false;
            }
            else if (e.Item.OwnerTableView.DataMember == "Citizens")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "Expatriate")
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
            if (e.Item.OwnerTableView.DataMember == "PayCodeMaster")
            {
                grid.MasterTableView.GetColumn("EditPaycod").Visible = false;
                grid.MasterTableView.GetColumn("DeletePaycod").Visible = false;
            }
            else if (e.Item.OwnerTableView.DataMember == "Citizens")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "Expatriate")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }

            grid.MasterTableView.ExportToPdf();
        }
        if (e.CommandName == "Print")
        {
            Button btnPrint = (Button)e.Item.FindControl("btnPayCodePrint");
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
    
    // function for export setting
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
                if (column.UniqueName == "DeletePaycode" || column.UniqueName == "EditPaycod")
                {
                    column.Display = false;
                    column.Visible = false;
                }
                if (column.UniqueName == "EditCitizen" || column.UniqueName == "DeleteCitizen")
                {
                    column.Display = false;
                    column.Visible = false;
                }
                if (column.UniqueName == "EditExpat" || column.UniqueName == "DeleteExpat")
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
    protected void gvPayCode_InsertCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_User(ref e, "Insert");
    }

    // insert/udpate function
    private void Insert_or_Update_User(ref GridCommandEventArgs e, string operation)
    {
        GridEditableItem editedItem = e.Item as GridEditableItem;
        try
        {
            if (e.Item.OwnerTableView.DataMember == "PayCodeMaster")
            {
                //Insert new values
                Hashtable newValues = new Hashtable();
                if (operation == "Update")
                {
                    newValues["@recidd"] = (int)editedItem.GetDataKeyValue("recidd");
                }
                newValues["@paycod"] = (editedItem.FindControl("txtPayCodeCode") as RadTextBox).Text.Trim();
                newValues["@payds1"] = (editedItem.FindControl("txtDescription") as RadTextBox).Text;
                newValues["@payds2"] = (editedItem.FindControl("txtArabicDescription") as RadTextBox).Text;
                newValues["@paytyp"] = (editedItem.FindControl("ddlPayCodeType") as RadComboBox).Items[0].Value.Trim();
                newValues["@payrat"] = string.IsNullOrEmpty((editedItem.FindControl("txtPayrate") as RadNumericTextBox).Text) ? "0" : (editedItem.FindControl("txtPayrate") as RadNumericTextBox).Text;
                newValues["@payunp"] = ""; // (editedItem.FindControl("txtUnitofPay") as RadTextBox).Text;
                newValues["@payper"] = (editedItem.FindControl("ddlPayPeriod") as RadComboBox).Items[0].Value.Trim();
                newValues["@payppr"] = string.IsNullOrEmpty((editedItem.FindControl("txtpayperpriod") as RadNumericTextBox).Text) ? "0" : (editedItem.FindControl("txtpayperpriod") as RadNumericTextBox).Text;
                newValues["@payact"] = (editedItem.FindControl("chkbxInclude") as CheckBox).Checked;
                newValues["@paydft"] = (editedItem.FindControl("chkbxDefault") as CheckBox).Checked;
                newValues["@DBMessage"] = "";

                string DBMessage = "";

                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_Paycode", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Update_PayCode", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                else
                {
                    gvPayCode.Rebind();
                    ShowClientMessage("Pay Code record save successfully.", MessageType.Success);
                }
            }
            else if (e.Item.OwnerTableView.DataMember == "Citizens")
            {
                Hashtable newValues = new Hashtable();

                if (operation == "Update")
                {
                    newValues["@recidd"] = (int)editedItem.GetDataKeyValue("recidd");
                }
                GridDataItem parentItem = (GridDataItem)(e.Item.OwnerTableView.ParentItem);
                if (parentItem != null)
                {
                    newValues["@pcdidd"] = Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["recidd"].ToString());
                }
                newValues["@emptyp"] = 1; // emptype 1 for citizen
                newValues["@grdidd"] = (editedItem.FindControl("ddlCGrade") as RadComboBox).Items[0].Value.Trim();
                newValues["@sngfrm"] = Convert.ToDecimal((editedItem.FindControl("txtCsngfrm") as RadNumericTextBox).Text);
                newValues["@sngtoo"] = Convert.ToDecimal((editedItem.FindControl("txtBxCsngtoo") as RadNumericTextBox).Text);
                newValues["@marfrm"] = Convert.ToDecimal((editedItem.FindControl("txtBxCmarfrm") as RadNumericTextBox).Text);
                newValues["@martoo"] = Convert.ToDecimal((editedItem.FindControl("txtBxCmartoo") as RadNumericTextBox).Text);

                newValues["@DBMessage"] = "";

                string DBMessage = "";

                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_PaycodeCitizion", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Update_PaycodeCitizion", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                else
                {
                    ShowClientMessage("Citizen record saved successfully.", MessageType.Success);
                }
            }
            else if (e.Item.OwnerTableView.DataMember == "Expatriate")
            {
                Hashtable newValues = new Hashtable();

                if (operation == "Update")
                {
                    newValues["@recidd"] = (int)editedItem.GetDataKeyValue("recidd");
                }
                GridDataItem parentItem = (GridDataItem)(e.Item.OwnerTableView.ParentItem);
                if (parentItem != null)
                {
                    newValues["@pcdidd"] = Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["recidd"].ToString());
                }
                newValues["@emptyp"] = 0;  // emptype 0 for Expat
                newValues["@grdidd"] = (editedItem.FindControl("ddlEGrade") as RadComboBox).Items[0].Value.Trim();
                newValues["@sngfrm"] = Convert.ToDecimal((editedItem.FindControl("txtEsngfrm") as RadNumericTextBox).Text);
                newValues["@sngtoo"] = Convert.ToDecimal((editedItem.FindControl("txtBxEsngtoo") as RadNumericTextBox).Text);
                newValues["@marfrm"] = Convert.ToDecimal((editedItem.FindControl("txtBxEmarfrm") as RadNumericTextBox).Text);
                newValues["@martoo"] = Convert.ToDecimal((editedItem.FindControl("txtBxEmartoo") as RadNumericTextBox).Text);

                newValues["@DBMessage"] = "";

                string DBMessage = "";

                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_PaycodeCitizion", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Update_PaycodeCitizion", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                else
                {
                    ShowClientMessage("Expatriate record saved successfully.", MessageType.Success);
                }
            }
        }
        catch (Exception ex)
        {
            ShowClientMessage("Unable to update/insert Pay Code: " + ex.Message, MessageType.Error);
            e.Canceled = true;
        }
    }

    // function to display client side messages
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

    // get value for grid boolean column
    protected bool CheckBoxValue(object value)
    {
        if (Convert.ToString(value) == "1") return true;
        else if (Convert.ToString(value) == "True") return true;
        else if (Convert.ToString(value) == "true") return true;

        return false;
    }

    // get image for grid boolean column
    protected string getImagePathForTrue(bool flag)
    {
        if (flag)
            return "~/Images/16x16_tick.png";
        else
            return "";
    }
}