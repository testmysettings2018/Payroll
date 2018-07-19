using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Telerik.Web.UI.GridExcelBuilder;

public partial class Payroll_LeaveType : BasePage
{
    public static Hashtable htSearchParams = null;
    public bool exporting = false;

    // base page initialization
    protected override void Page_Init(object sender, EventArgs e)
    {
        FormName = "LeaveForm";
        base.Page_Init(sender, e);
    }

    // page load function
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    // leave type master grid data loading and binding
    protected void gvLeaveType_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_All_LeaveTypeSetup", htSearchParams).Tables[0];
        dt.TableName = "LeaveTypeMaster";
        gvLeaveType.DataSource = dt;
        gvLeaveType.DataMember = "LeaveTypeMaster";
    }

    // grid update command
    protected void gvLeaveType_UpdateCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_Leave(ref e, "Update");
    }

    // grid delete command for all master and detail tables
    protected void gvLeaveType_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        try
        {
            Hashtable ht = new Hashtable();
            if (e.Item.OwnerTableView.DataMember == "LeaveTypeMaster")
            {
                int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("recidd");
                if (ID > 0)
                {
                    ht.Add("@ID", ID);
                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_LeaveType", ht);
                }
            }
            else if (e.Item.OwnerTableView.DataMember == "Leaves")
            {
                int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("recidd");

                if (ID > 0)
                {
                    ht.Add("@ID", ID);
                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_LeaveRecord", ht);
                }
            }
            else if (e.Item.OwnerTableView.DataMember == "LeavePattren")
            {
                int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("recidd");
                if (ID > 0)
                {
                    ht.Add("@ID", ID);
                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Leave_Pattren", ht);
                }
            }
            else if (e.Item.OwnerTableView.DataMember == "LeaveDeductionPattren")
            {
                int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("recidd");
                if (ID > 0)
                {
                    ht.Add("@ID", ID);
                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Leave_Deduction_Pattren", ht);
                }
            }
        }
        catch (Exception ex)
        {

        }
    }

    // client side validation function for leave type input form
    public void ValidateLeaveType(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadTextBox txttypcod = (editForm.FindControl("txttypcod") as RadTextBox);
        RadTextBox txtDescription = (editForm.FindControl("txtDescription") as RadTextBox);
        RadComboBox ddlLeaveBasedon = (editForm.FindControl("ddlLeaveBasedon") as RadComboBox);
        RadComboBox ddlSalaryBasedOn = (editForm.FindControl("ddlSalaryBasedOn") as RadComboBox);
        RadComboBox ddlLeaveProvision = (editForm.FindControl("ddlLeaveProvision") as RadComboBox);
        RadComboBox ddlFrequency = (editForm.FindControl("ddlFrequency") as RadComboBox);
        RadNumericTextBox txtbxDays = (editForm.FindControl("txtbxDays") as RadNumericTextBox);
        RadComboBox ddlNewEmployeeAnualLeave = (editForm.FindControl("ddlNewEmoloyeeAnualLeave") as RadComboBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidateLeaveType('" +
                txttypcod.ClientID + "','" +
                txtDescription.ClientID + "','" +
                ddlLeaveBasedon.ClientID + "','" +
                ddlSalaryBasedOn.ClientID + "','" +
                ddlLeaveProvision.ClientID + "','" +
                ddlFrequency.ClientID + "','" +
                txtbxDays.ClientID + "','" +
                ddlNewEmployeeAnualLeave.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateLeaveType('" +
                txttypcod.ClientID + "','" +
                txtDescription.ClientID + "','" +
                ddlLeaveBasedon.ClientID + "','" +
                ddlSalaryBasedOn.ClientID + "','" +
                ddlLeaveProvision.ClientID + "','" +
                ddlFrequency.ClientID + "','" +
                txtbxDays.ClientID + "','" +
                ddlNewEmployeeAnualLeave.ClientID
                + "')");
        }
    }

    // client side validation function for leave input form
    public void ValidateLeave(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadTextBox txtlevcod = (editForm.FindControl("txtlevcod") as RadTextBox);
        RadTextBox txtLeaveDescription = (editForm.FindControl("txtLeaveDescription") as RadTextBox);
        RadComboBox ddlPayCode = (editForm.FindControl("ddlPayCode") as RadComboBox);
        RadComboBox ddlDeductionCode = (editForm.FindControl("ddlDeductionCode") as RadComboBox);
        RadComboBox ddlBenefitCode = (editForm.FindControl("ddlBenefitCode") as RadComboBox);
        RadNumericTextBox txtMaximumBalance = (editForm.FindControl("txtMaximumBalance") as RadNumericTextBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidateLeave('" +
                txtlevcod.ClientID + "','" +
                txtLeaveDescription.ClientID + "','" +
                ddlPayCode.ClientID + "','" +
                ddlDeductionCode.ClientID + "','" +
                ddlBenefitCode.ClientID + "','" +
                txtMaximumBalance.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateLeave('" +
                txtlevcod.ClientID + "','" +
                txtLeaveDescription.ClientID + "','" +
                ddlPayCode.ClientID + "','" +
                ddlDeductionCode.ClientID + "','" +
                ddlBenefitCode.ClientID + "','" +
                txtMaximumBalance.ClientID
                + "')");
        }
    }

    // client side validation function for leave pattren input form
    public void ValidateLeavePattren(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        //RadNumericTextBox txtBxlevseq = (editForm.FindControl("txtBxlevseq") as RadNumericTextBox);
        RadNumericTextBox txtBxFromYear = (editForm.FindControl("txtBxFromYear") as RadNumericTextBox);
        RadNumericTextBox txtBxToYear = (editForm.FindControl("txtBxToYear") as RadNumericTextBox);
        RadNumericTextBox txtBxlevnod = (editForm.FindControl("txtBxlevnod") as RadNumericTextBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidateLeavePattren('" +
                //txtBxlevseq.ClientID + "','" +
                txtBxFromYear.ClientID + "','" +
                txtBxToYear.ClientID + "','" +
                txtBxlevnod.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateLeavePattren('" +
                //txtBxlevseq.ClientID + "','" +
                txtBxFromYear.ClientID + "','" +
                txtBxToYear.ClientID + "','" +
                txtBxlevnod.ClientID
                + "')");
        }
    }

    // client side validation function for leave deduction pattren input form
    public void ValidateLeaveDeductionPattren(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        //RadNumericTextBox txtlevseq = (editForm.FindControl("txtlevseq") as RadNumericTextBox);
        RadNumericTextBox txtFromDay = (editForm.FindControl("txtFromDay") as RadNumericTextBox);
        RadNumericTextBox txtToDay = (editForm.FindControl("txtToDay") as RadNumericTextBox);
        RadNumericTextBox txtSalaryPercentage = (editForm.FindControl("txtSalaryPercentage") as RadNumericTextBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidateLeaveDeductionPattren('" +
                //txtlevseq.ClientID + "','" +
                txtFromDay.ClientID + "','" +
                txtToDay.ClientID + "','" +
                txtSalaryPercentage.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateLeaveDeductionPattren('" +
                //txtlevseq.ClientID + "','" +
                txtFromDay.ClientID + "','" +
                txtToDay.ClientID + "','" +
                txtSalaryPercentage.ClientID
                + "')");
        }
    }

    // form input controls setting for insert/update
    protected void gvLeaveType_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            if (e.Item.OwnerTableView.DataMember == "LeaveTypeMaster")
            {
                ValidateLeaveType(e);

                if (e.Item.OwnerTableView.IsItemInserted)
                {
                    #region  item is about to be inserted

                    GridEditableItem insertedItem = (GridEditableItem)e.Item;

                    RadComboBox ddlLeaveBasedon = (RadComboBox)insertedItem.FindControl("ddlLeaveBasedon");
                    RadComboBox ddlSalaryBasedOn = (RadComboBox)insertedItem.FindControl("ddlSalaryBasedOn");
                    RadComboBox ddlFrequency = (RadComboBox)insertedItem.FindControl("ddlFrequency");
                    RadComboBox ddlLeaveProvision = (RadComboBox)insertedItem.FindControl("ddlLeaveProvision");
                    RadComboBox ddlNewEmoloyeeAnualLeave = (RadComboBox)insertedItem.FindControl("ddlNewEmoloyeeAnualLeave");


                    if (ddlLeaveBasedon != null)
                    {
                        RadGrid grid = ddlLeaveBasedon.Items[0].FindControl("rGrdLeaveBasedon4DDL") as RadGrid;
                        grid.Rebind();
                    }
                    if (ddlSalaryBasedOn != null)
                    {
                        RadGrid grid = ddlSalaryBasedOn.Items[0].FindControl("rGrdSalaryBasedon4DDL") as RadGrid;
                        grid.Rebind();
                    }
                    if (ddlFrequency != null)
                    {
                        RadGrid grid = ddlFrequency.Items[0].FindControl("rGrdFrequency4DDL") as RadGrid;
                        grid.Rebind();
                    }
                    if (ddlLeaveProvision != null)
                    {
                        RadGrid grid = ddlLeaveProvision.Items[0].FindControl("rGrdLeaveProvision4DDL") as RadGrid;
                        grid.Rebind();
                    }
                    if (ddlNewEmoloyeeAnualLeave != null)
                    {
                        RadGrid grid = ddlNewEmoloyeeAnualLeave.Items[0].FindControl("rGrdNewEmoloyeeAnualLeave4DDL") as RadGrid;
                        grid.Rebind();
                    }
                    #endregion
                }
                else
                {
                    #region item is about to be edited
                    GridEditableItem editedItem = (GridEditableItem)e.Item;

                    RadComboBox ddlLeaveBasedon = (RadComboBox)editedItem.FindControl("ddlLeaveBasedon");
                    HiddenField hfleavebasedlID = (HiddenField)editedItem.FindControl("hfleavebasedlID");
                    HiddenField hfleavebaseddlText = (HiddenField)editedItem.FindControl("hfleavebaseddlText");
                    HiddenField hfleavebaseddlValue = (HiddenField)editedItem.FindControl("hfleavebaseddlValue");

                    RadComboBox ddlSalaryBasedOn = (RadComboBox)editedItem.FindControl("ddlSalaryBasedOn");
                    HiddenField hfSalaryBasedddlID = (HiddenField)editedItem.FindControl("hfSalaryBasedddlID");
                    HiddenField hfSalaryBasedddlText = (HiddenField)editedItem.FindControl("hfSalaryBasedddlText");
                    HiddenField hfSalaryBasedddlValue = (HiddenField)editedItem.FindControl("hfSalaryBasedddlValue");

                    RadComboBox ddlFrequency = (RadComboBox)editedItem.FindControl("ddlFrequency");
                    HiddenField hffrequencyddlID = (HiddenField)editedItem.FindControl("hffrequencyddlID");
                    HiddenField hffrequencyddlText = (HiddenField)editedItem.FindControl("hffrequencyddlText");
                    HiddenField hffrequencyddlValue = (HiddenField)editedItem.FindControl("hffrequencyddlValue");

                    RadComboBox ddlLeaveProvision = (RadComboBox)editedItem.FindControl("ddlLeaveProvision");
                    HiddenField hflevprvId = (HiddenField)editedItem.FindControl("hflevprvId");
                    HiddenField hflevprvtext = (HiddenField)editedItem.FindControl("hflevprvtext");
                    HiddenField hflevprvvalue = (HiddenField)editedItem.FindControl("hflevprvvalue");

                    RadComboBox ddlNewEmoloyeeAnualLeave = (RadComboBox)editedItem.FindControl("ddlNewEmoloyeeAnualLeave");
                    HiddenField hfNewEmoloyeeAnualId = (HiddenField)editedItem.FindControl("hfNewEmoloyeeAnualId");
                    HiddenField hfNewEmoloyeeAnualText = (HiddenField)editedItem.FindControl("hfNewEmoloyeeAnualText");
                    HiddenField hfNewEmoloyeeAnualValue = (HiddenField)editedItem.FindControl("hfNewEmoloyeeAnualValue");

                    if (ddlLeaveBasedon != null)
                    {
                        RadGrid grid = ddlLeaveBasedon.Items[0].FindControl("rGrdLeaveBasedon4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfleavebasedlID.Value) && !string.IsNullOrEmpty(hfleavebaseddlText.Value))
                        {
                            ddlLeaveBasedon.Items[0].Value = hfleavebasedlID.Value;
                            ddlLeaveBasedon.Items[0].Text = hfleavebaseddlText.Value;
                            ddlLeaveBasedon.Text = hfleavebaseddlText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfleavebasedlID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["ValueSetID"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }
                    if (ddlSalaryBasedOn != null)
                    {
                        RadGrid grid = ddlSalaryBasedOn.Items[0].FindControl("rGrdSalaryBasedon4DDL") as RadGrid;
                        grid.Rebind();
                        if (!string.IsNullOrEmpty(hfSalaryBasedddlID.Value) && !string.IsNullOrEmpty(hfSalaryBasedddlText.Value))
                        {
                            ddlSalaryBasedOn.Items[0].Value = hfSalaryBasedddlID.Value;
                            ddlSalaryBasedOn.Items[0].Text = hfSalaryBasedddlText.Value;
                            ddlSalaryBasedOn.Text = hfSalaryBasedddlText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfSalaryBasedddlID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["ValueSetID"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }
                    if (ddlFrequency != null)
                    {
                        RadGrid grid = ddlFrequency.Items[0].FindControl("rGrdFrequency4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hffrequencyddlID.Value) && !string.IsNullOrEmpty(hffrequencyddlText.Value))
                        {
                            ddlFrequency.Items[0].Value = hffrequencyddlID.Value;
                            ddlFrequency.Items[0].Text = hffrequencyddlText.Value;
                            ddlFrequency.Text = hffrequencyddlText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hffrequencyddlID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["ValueSetID"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }
                    if (ddlLeaveProvision != null)
                    {
                        RadGrid grid = ddlLeaveProvision.Items[0].FindControl("rGrdLeaveProvision4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hflevprvId.Value) && !string.IsNullOrEmpty(hflevprvtext.Value))
                        {
                            ddlLeaveProvision.Items[0].Value = hflevprvId.Value;
                            ddlLeaveProvision.Items[0].Text = hflevprvtext.Value;
                            ddlLeaveProvision.Text = hflevprvtext.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hflevprvId.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["ValueSetID"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }
                    if (ddlNewEmoloyeeAnualLeave != null)
                    {
                        RadGrid grid = ddlNewEmoloyeeAnualLeave.Items[0].FindControl("rGrdNewEmoloyeeAnualLeave4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfNewEmoloyeeAnualId.Value) && !string.IsNullOrEmpty(hfNewEmoloyeeAnualText.Value))
                        {
                            ddlNewEmoloyeeAnualLeave.Items[0].Value = hfNewEmoloyeeAnualId.Value;
                            ddlNewEmoloyeeAnualLeave.Items[0].Text = hfNewEmoloyeeAnualText.Value;
                            ddlNewEmoloyeeAnualLeave.Text = hfNewEmoloyeeAnualText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfNewEmoloyeeAnualId.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["ValueSetID"].ToString()))
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
            else if (e.Item.OwnerTableView.DataMember == "Leaves")
            {
                ValidateLeave(e);

                if (e.Item.OwnerTableView.IsItemInserted)
                {
                    #region  item is about to be inserted

                    GridEditableItem insertedItem = (GridEditableItem)e.Item;

                    RadComboBox ddlPayCode = (RadComboBox)insertedItem.FindControl("ddlPayCode");
                    RadComboBox ddlDeductionCode = (RadComboBox)insertedItem.FindControl("ddlDeductionCode");
                    RadComboBox ddlBenefitCode = (RadComboBox)insertedItem.FindControl("ddlBenefitCode");

                    if (ddlPayCode != null)
                    {
                        RadGrid grid = ddlPayCode.Items[0].FindControl("rGrdPayCode4DDL") as RadGrid;
                        grid.Rebind();
                    }
                    if (ddlDeductionCode != null)
                    {
                        RadGrid grid = ddlDeductionCode.Items[0].FindControl("rGrdDeductionCode4DDL") as RadGrid;
                        grid.Rebind();
                    }
                    if (ddlBenefitCode != null)
                    {
                        RadGrid grid = ddlBenefitCode.Items[0].FindControl("rGrdBenefitCode4DDL") as RadGrid;
                        grid.Rebind();
                    }
                    #endregion
                }
                else
                {
                    #region item is about to be edited

                    GridEditableItem editedItem = (GridEditableItem)e.Item;

                    RadComboBox ddlPayCode = (RadComboBox)editedItem.FindControl("ddlPayCode");
                    RadComboBox ddlDeductionCode = (RadComboBox)editedItem.FindControl("ddlDeductionCode");
                    RadComboBox ddlBenefitCode = (RadComboBox)editedItem.FindControl("ddlBenefitCode");
                    HiddenField hflevidd = (HiddenField)editedItem.FindControl("hflevidd");

                    if (ddlPayCode != null && hflevidd != null)
                    {
                            Hashtable ht_filters = new Hashtable();
                            ht_filters.Add("@levidd", Convert.ToInt32(hflevidd.Value));
                            DataTable dt_leaves_paycodes = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_Leave_PayCodesById", ht_filters).Tables[0];
                            RadGrid grid = ddlPayCode.Items[0].FindControl("rGrdPayCode4DDL") as RadGrid;
                            if (grid != null)
                            {
                                grid.Rebind();
                                foreach (GridItem item in grid.MasterTableView.Items)
                                {
                                    if (item is GridDataItem)
                                    {
                                        GridDataItem dataItem = (GridDataItem)item;
                                        foreach (DataRow row in dt_leaves_paycodes.Rows)
                                        {
                                            if (row["pcdidd"].ToString().Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
                                            {
                                                if (!string.IsNullOrEmpty(ddlPayCode.Text))
                                                    ddlPayCode.Text = ddlPayCode.Text + ",";
                                                ddlPayCode.Text = ddlPayCode.Text + row["pcdcod"].ToString();
                                                dataItem.Selected = true;
                                                break;
                                            }
                                        }
                                    }
                                }
                            }
                    }
                    
                    if (ddlDeductionCode != null && hflevidd != null)
                    {
                        Hashtable ht_filters = new Hashtable();
                        ht_filters.Add("@levidd", Convert.ToInt32(hflevidd.Value));
                        DataTable dt_leaves_deductioncodes = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_Leave_DeductionCodesById", ht_filters).Tables[0];
                        RadGrid grid = ddlDeductionCode.Items[0].FindControl("rGrdDeductionCode4DDL") as RadGrid;
                        if (grid != null)
                        {
                            grid.Rebind();
                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    foreach (DataRow row in dt_leaves_deductioncodes.Rows)
                                    {
                                        if (row["dcdidd"].ToString().Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
                                        {
                                            if (!string.IsNullOrEmpty(ddlDeductionCode.Text))
                                                ddlDeductionCode.Text = ddlDeductionCode.Text + ",";
                                            ddlDeductionCode.Text = ddlDeductionCode.Text + row["dcdcod"].ToString();
                                            dataItem.Selected = true;
                                            break;
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    if (ddlBenefitCode != null && hflevidd != null)
                    {
                        Hashtable ht_filters = new Hashtable();
                        ht_filters.Add("@levidd", Convert.ToInt32(hflevidd.Value));
                        DataTable dt_leaves_provisioncodes = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_Leave_ProvisionCodesById", ht_filters).Tables[0];
                        RadGrid grid = ddlBenefitCode.Items[0].FindControl("rGrdBenefitCode4DDL") as RadGrid;
                        if (grid != null)
                        {
                            grid.Rebind();
                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    foreach (DataRow row in dt_leaves_provisioncodes.Rows)
                                    {
                                        if (row["prdidd"].ToString().Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
                                        {
                                            if (!string.IsNullOrEmpty(ddlBenefitCode.Text))
                                                ddlBenefitCode.Text = ddlBenefitCode.Text + ",";
                                            ddlBenefitCode.Text = ddlBenefitCode.Text + row["prdcod"].ToString();
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
            else if (e.Item.OwnerTableView.DataMember == "LeavePattren")
            {
                ValidateLeavePattren(e);

                if (e.Item.OwnerTableView.IsItemInserted)
                {
                    #region  item is about to be inserted

                    GridEditableItem insertedItem = (GridEditableItem)e.Item;

                    string leaveId = insertedItem.OwnerTableView.ParentItem.OwnerTableView.DataKeyValues[insertedItem.OwnerTableView.ParentItem.ItemIndex]["recidd"].ToString();

                    Hashtable ht_filters = new Hashtable();
                    ht_filters.Add("@LeaveID", leaveId);

                    DataTable dt_Leave = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_Leave_Pattrens", ht_filters).Tables[0];

                    DataView dt_LeaveView = dt_Leave.DefaultView;
                    dt_LeaveView.Sort = "recidd desc";
                    dt_Leave = dt_LeaveView.ToTable();

                    RadNumericTextBox txtBxFromYear = (RadNumericTextBox)insertedItem.FindControl("txtBxFromYear");

                    if (dt_Leave.Rows.Count > 0)
                        txtBxFromYear.Text = Convert.ToString(Convert.ToInt32(dt_Leave.Rows[0]["levtoo"].ToString()) + 1);
                    else
                        txtBxFromYear.Text = "0";

                    #endregion
                }
            }

            else if (e.Item.OwnerTableView.DataMember == "LeaveDeductionPattren")
            {
                ValidateLeaveDeductionPattren(e);

                if (e.Item.OwnerTableView.IsItemInserted)
                {
                    #region  item is about to be inserted

                    GridEditableItem insertedItem = (GridEditableItem)e.Item;

                    string leaveId = insertedItem.OwnerTableView.ParentItem.OwnerTableView.DataKeyValues[insertedItem.OwnerTableView.ParentItem.ItemIndex]["recidd"].ToString();

                    Hashtable ht_filters = new Hashtable();
                    ht_filters.Add("@LeaveID", leaveId);

                    DataTable dt_LeaveDeduction = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_Leave_Deduction_Pattrens", ht_filters).Tables[0];

                    DataView d_LeaveDeductionView = dt_LeaveDeduction.DefaultView;
                    d_LeaveDeductionView.Sort = "recidd desc";
                    dt_LeaveDeduction = d_LeaveDeductionView.ToTable();

                    RadNumericTextBox txtFromDay = (RadNumericTextBox)insertedItem.FindControl("txtFromDay");

                    if (dt_LeaveDeduction.Rows.Count > 0)
                        txtFromDay.Text = Convert.ToString(Convert.ToInt32(dt_LeaveDeduction.Rows[0]["levtod"].ToString()) + 1);
                    else
                        txtFromDay.Text = "0";

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

    // clear form controls for insert/update
    // grid exporting functions
    protected void gvLeaveType_ItemCommand(object sender, GridCommandEventArgs e)
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

            if (e.Item.OwnerTableView.DataMember == "LeaveTypeMaster")
            {
                grid.MasterTableView.GetColumn("LeaveTypeIsDefault").Visible = false;
                grid.MasterTableView.GetColumn("EditLeaveType").Visible = false;
                grid.MasterTableView.GetColumn("DeleteLeaveType").Visible = false;
            }
            else if (e.Item.OwnerTableView.DataMember == "Leaves")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "LeavePattren")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "LeaveDeductionPattren")
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

            if (e.Item.OwnerTableView.DataMember == "LeaveTypeMaster")
            {
                grid.MasterTableView.GetColumn("LeaveTypeIsDefault").Visible = false;
                grid.MasterTableView.GetColumn("EditLeaveType").Visible = false;
                grid.MasterTableView.GetColumn("DeleteLeaveType").Visible = false;
            }
            else if (e.Item.OwnerTableView.DataMember == "Leaves")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "LeavePattren")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "LeaveDeductionPattren")
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

            if (e.Item.OwnerTableView.DataMember == "LeaveTypeMaster")
            {
                grid.MasterTableView.GetColumn("LeaveTypeIsDefault").Visible = false;
                grid.MasterTableView.GetColumn("EditLeaveType").Visible = false;
                grid.MasterTableView.GetColumn("DeleteLeaveType").Visible = false;
            }
            else if (e.Item.OwnerTableView.DataMember == "Leaves")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "LeavePattren")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "LeaveDeductionPattren")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            grid.MasterTableView.ExportToPdf();
        }
        if (e.CommandName == "Print")
        {
            Button btnPrint = (Button)e.Item.FindControl("btnLeaveTypePrint");
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

    // export formating
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

                if (column.UniqueName == "LeaveIsDefault" || column.UniqueName == "DeleteLeave" || column.UniqueName == "EditLeave")
                {
                    column.Display = false;
                    column.Visible = false;
                }
                if (column.UniqueName == "EditLeavePattren" || column.UniqueName == "DeleteLeavePattren")
                {
                    column.Display = false;
                    column.Visible = false;
                }
                if (column.UniqueName == "EditLeaveDeduction" || column.UniqueName == "DeleteLeaveDeduction")
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
    protected void gvLeaveType_InsertCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_Leave(ref e, "Insert");
    }

    // function for insert/update operations
    private void Insert_or_Update_Leave(ref GridCommandEventArgs e, string operation)
    {
        GridEditableItem editedItem = e.Item as GridEditableItem;
        try
        {
            if (e.Item.OwnerTableView.DataMember == "LeaveTypeMaster")
            {
                //Insert new values
                Hashtable newValues = new Hashtable();

                if (operation == "Update")
                {
                    newValues["@recidd"] = (int)editedItem.GetDataKeyValue("recidd");
                }
                newValues["@levtypcod"] = (editedItem.FindControl("txttypcod") as RadTextBox).Text.Trim();
                newValues["@levdft"] = (editedItem.FindControl("chkbxIsDefault") as CheckBox).Checked;
                newValues["@levdsc"] = (editedItem.FindControl("txtDescription") as RadTextBox).Text;
                newValues["@levsld"] = (editedItem.FindControl("txtArabicDescription") as RadTextBox).Text;
                newValues["@levbso"] = (editedItem.FindControl("ddlLeaveBasedon") as RadComboBox).Items[0].Value.Trim();
                newValues["@levsbo"] = (editedItem.FindControl("ddlSalaryBasedOn") as RadComboBox).Items[0].Value.Trim();
                newValues["@levfba"] = (editedItem.FindControl("chkbxAccureLeave") as CheckBox).Checked;
                newValues["@levsal"] = (editedItem.FindControl("chkbxLeaveSalary") as CheckBox).Checked;
                newValues["@levfrw"] = (editedItem.FindControl("chkbxForwardBalance") as CheckBox).Checked;
                newValues["@levenc"] = (editedItem.FindControl("chkbxEncashable") as CheckBox).Checked;
                newValues["@levprv"] = (editedItem.FindControl("ddlLeaveProvision") as RadComboBox).Items[0].Value.Trim();
                newValues["@levfrq"] = (editedItem.FindControl("ddlFrequency") as RadComboBox).Items[0].Value.Trim();
                newValues["@levday"] = Convert.ToDecimal((editedItem.FindControl("txtbxDays") as RadNumericTextBox).Text);
                newValues["@levneg"] = (editedItem.FindControl("chkbxAllowAdvanceLeave") as CheckBox).Checked;
                newValues["@levexp"] = (editedItem.FindControl("chkbxCheck_For_Expiry_Document") as CheckBox).Checked;
                newValues["@levsdp"] = (editedItem.FindControl("chkbxcheckleaveforsamedepartment") as CheckBox).Checked;
                newValues["@levspo"] = (editedItem.FindControl("chkbxcheckleaveforsameposition") as CheckBox).Checked;
                newValues["@leveho"] = (editedItem.FindControl("chkbxputemployeeonholduntilleavereturn") as CheckBox).Checked;
                newValues["@levall"] = (editedItem.FindControl("chkbxusespecialallowancereplacement") as CheckBox).Checked;
                newValues["@levcut"] = (editedItem.FindControl("cutt_of_date") as RadDatePicker).SelectedDate;
                newValues["@levnew"] = (editedItem.FindControl("ddlNewEmoloyeeAnualLeave") as RadComboBox).Items[0].Value.Trim();
                newValues["@DBMessage"] = "";

                string DBMessage = "";

                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_LeaveType", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Update_LeaveType", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }

                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                else
                {
                    ShowClientMessage("Leave Type saved successfully.", MessageType.Success);
                    gvLeaveType.Rebind();
                }
            }
            else if (e.Item.OwnerTableView.DataMember == "Leaves")
            {
                Hashtable newValues = new Hashtable();

                if (operation == "Update")
                {
                    newValues["@recidd"] = (int)editedItem.GetDataKeyValue("recidd");
                }
                GridDataItem parentItem = (GridDataItem)(e.Item.OwnerTableView.ParentItem);
                if (parentItem != null)
                {
                    newValues["@ltpidd"] = Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["recidd"].ToString());
                }
                newValues["@levdft"] = (editedItem.FindControl("chkbxlevdft") as CheckBox).Checked;
                newValues["@levcod"] = (editedItem.FindControl("txtlevcod") as RadTextBox).Text.Trim();
                newValues["@levdsc"] = (editedItem.FindControl("txtLeaveDescription") as RadTextBox).Text;
                newValues["@levsld"] = (editedItem.FindControl("txtLeaveArabicDescription") as RadTextBox).Text;
                newValues["@levbso"] = (editedItem.FindControl("chkbxWeekendExcluded") as CheckBox).Checked;
                newValues["@levsbo"] = (editedItem.FindControl("chkbxRestDaysExcluded") as CheckBox).Checked;
                newValues["@levfba"] = (editedItem.FindControl("chkbxPublicHolidayExcluded") as CheckBox).Checked;
                //newValues["@paycodidd"] = (editedItem.FindControl("ddlPayCode") as RadComboBox).Items[0].Value.Trim();
                //newValues["@dedcodidd"] = (editedItem.FindControl("ddlDeductionCode") as RadComboBox).Items[0].Value.Trim();
                //newValues["@bencodidd"] = (editedItem.FindControl("ddlBenefitCode") as RadComboBox).Items[0].Value.Trim();
                newValues["@levsal"] = Convert.ToDecimal((editedItem.FindControl("txtMaximumBalance") as RadNumericTextBox).Text);

                newValues["@DBMessage"] = "";

                string DBMessage = "";

                int levidd = 0; 
                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_Leave", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Update_Leave", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }

                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                else
                {
                    if (operation == "Insert")
                    {
                        levidd = Convert.ToInt32(DBMessage);
                    }
                    else if (operation == "Update")
                    {
                        levidd = (int)editedItem.GetDataKeyValue("recidd");
                    }
                }

                if (levidd > 0)
                { 
                    #region Pay Codes 

                    RadComboBox ddlPayCode = (editedItem.FindControl("ddlPayCode") as RadComboBox);
                    if (ddlPayCode != null)
                    {
                        if (ddlPayCode.Items.Count > 0)
                        {
                            #region delete old records

                            //Delete existing code Values
                            Hashtable deleteValues = new Hashtable();
                            deleteValues["@levidd"] = levidd;
                            clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Leave_PayCodes", deleteValues);

                            #endregion

                            RadGrid rgPaycode = (ddlPayCode.Items[0].FindControl("rGrdPayCode4DDL") as RadGrid);
                            if (rgPaycode.SelectedItems.Count > 0)
                            {
                                #region Insert new records

                                foreach (GridDataItem dataItem in rgPaycode.SelectedItems)
                                {
                                    //Insert new values
                                    Hashtable newDetailValues = new Hashtable();
                                    newDetailValues["@levidd"] = levidd;
                                    newDetailValues["@pcdidd"] = Convert.ToInt32(dataItem["recidd"].Text);
                                    newDetailValues["@pcdcod"] = dataItem["paycod"].Text;

                                    newDetailValues["@DBMessage"] = "";
                                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_Leave_PayCode", newDetailValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                                }

                                #endregion
                            }
                        }
                    }

                    #endregion

                    #region Deduction Codes

                    RadComboBox ddlDeductionCode = (editedItem.FindControl("ddlDeductionCode") as RadComboBox);
                    if (ddlDeductionCode != null)
                    {
                        if (ddlDeductionCode.Items.Count > 0)
                        {
                            #region delete old records

                            //Delete existing code Values
                            Hashtable deleteValues = new Hashtable();
                            deleteValues["@levidd"] = levidd;
                            clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Leave_DeductionCodes", deleteValues);

                            #endregion

                            RadGrid rgDeductionCode = (ddlDeductionCode.Items[0].FindControl("rGrdDeductionCode4DDL") as RadGrid);
                            if (rgDeductionCode.SelectedItems.Count > 0)
                            {
                                #region Insert new records

                                foreach (GridDataItem dataItem in rgDeductionCode.SelectedItems)
                                {
                                    //Insert new values
                                    Hashtable newDetailValues = new Hashtable();
                                    newDetailValues["@levidd"] = levidd;
                                    newDetailValues["@dcdidd"] = Convert.ToInt32(dataItem["recidd"].Text);
                                    newDetailValues["@dcdcod"] = dataItem["dedcod"].Text;

                                    newDetailValues["@DBMessage"] = "";
                                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_Leave_DeductionCode", newDetailValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                                }

                                #endregion
                            }
                        }
                    }

                    #endregion

                    #region Provision Codes

                    RadComboBox ddlProvisionCode = (editedItem.FindControl("ddlBenefitCode") as RadComboBox);
                    if (ddlProvisionCode != null)
                    {
                        if (ddlProvisionCode.Items.Count > 0)
                        {
                            #region delete old records

                            //Delete existing code Values
                            Hashtable deleteValues = new Hashtable();
                            deleteValues["@levidd"] = levidd;
                            clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Leave_ProvisionCodes", deleteValues);

                            #endregion

                            RadGrid rgProvisionCode = (ddlProvisionCode.Items[0].FindControl("rGrdBenefitCode4DDL") as RadGrid);
                            if (rgProvisionCode.SelectedItems.Count > 0)
                            {
                                #region Insert new records

                                foreach (GridDataItem dataItem in rgProvisionCode.SelectedItems)
                                {
                                    //Insert new values
                                    Hashtable newDetailValues = new Hashtable();
                                    newDetailValues["@levidd"] = levidd;
                                    newDetailValues["@prdidd"] = Convert.ToInt32(dataItem["recidd"].Text);
                                    newDetailValues["@prdcod"] = dataItem["paycod"].Text;

                                    newDetailValues["@DBMessage"] = "";
                                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_Leave_ProvisionCode", newDetailValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                                }

                                #endregion
                            }
                        }
                    }

                    #endregion

                }

                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                else
                {
                    ShowClientMessage("Leave saved successfully.", MessageType.Success);
                }
            }
            else if (e.Item.OwnerTableView.DataMember == "LeavePattren")
            {
                Hashtable newValues = new Hashtable();

                if (operation == "Update")
                {
                    newValues["@recidd"] = (int)editedItem.GetDataKeyValue("recidd");
                }
                GridDataItem parentItem = (GridDataItem)(e.Item.OwnerTableView.ParentItem);
                if (parentItem != null)
                {
                    newValues["@levidd"] = Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["recidd"].ToString());
                }
                newValues["@levseq"] = 1;// (editedItem.FindControl("txtBxlevseq") as RadNumericTextBox).Text;
                newValues["@levfrm"] = (editedItem.FindControl("txtBxFromYear") as RadNumericTextBox).Text;
                newValues["@levtoo"] = (editedItem.FindControl("txtBxToYear") as RadNumericTextBox).Text;
                newValues["@levnod"] = (editedItem.FindControl("txtBxlevnod") as RadNumericTextBox).Text;

                newValues["@DBMessage"] = "";

                string DBMessage = "";

                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_Leave_Pattren", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Update_Leave_Pattren", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                ShowClientMessage("Leave Pattren saved successfully.", MessageType.Success);
            }
            else if (e.Item.OwnerTableView.DataMember == "LeaveDeductionPattren")
            {
                //Insert new values
                Hashtable newValues = new Hashtable();

                if (operation == "Update")
                {
                    newValues["@recidd"] = (int)editedItem.GetDataKeyValue("recidd");
                }
                GridDataItem parentItem = (GridDataItem)(e.Item.OwnerTableView.ParentItem);
                if (parentItem != null)
                {
                    newValues["@levidd"] = Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["recidd"].ToString());
                }
                newValues["@levseq"] = 1; // (editedItem.FindControl("txtlevseq") as RadNumericTextBox).Text;
                newValues["@levfrm"] = (editedItem.FindControl("txtFromDay") as RadNumericTextBox).Text;
                newValues["@levtod"] = (editedItem.FindControl("txtToDay") as RadNumericTextBox).Text;
                newValues["@levslp"] = (editedItem.FindControl("txtSalaryPercentage") as RadNumericTextBox).Text;

                newValues["@DBMessage"] = "";

                string DBMessage = "";

                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_Leave_Deduction_Pattren", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Update_Leave_Deduction_Pattren", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                ShowClientMessage("Leave Deduction Pattren Saved Successfully.", MessageType.Success);
            }
        }
        catch (Exception ex)
        {
            ShowClientMessage("Unable to update/insert Leave Type. Reason: " + ex.Message, MessageType.Error);
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

    // leave based on ddl data loading and binding
    protected void rGrdLeaveBasedon4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromCentralDb(Constraints.DropDownLists.LeaveBased, -1, 1).Tables[0];
    }

    // benefit code ddl data loading and binding
    protected void rGrdBenefitCode4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_PayCode_Records", htSearchParams).Tables[0];
    }

    // deduction code ddl data loading and binding
    protected void rGrdDeductionCode4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_Deduction_Records", htSearchParams).Tables[0];
    }

    // salary based on ddl data loading and binding
    protected void rGrdSalaryBasedon4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromCentralDb(Constraints.DropDownLists.SalaryBased, -1, 1).Tables[0];
    }

    // pay code ddl data loading and binding
    protected void rGrdPayCode4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_PayCode_Records", htSearchParams).Tables[0];
    }

    // leave provision ddl data loading and binding
    protected void rGrdLeaveProvision4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromCentralDb(Constraints.DropDownLists.LeaveProvision, -1, 1).Tables[0];
    }

    // frequency ddl data loading and binding
    protected void rGrdFrequency4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromCentralDb(Constraints.DropDownLists.LeaveFrequency, -1, 1).Tables[0];
    }

    // anual leaes dll data loading and binding
    protected void rGrdNewEmoloyeeAnualLeave4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromCentralDb(Constraints.DropDownLists.NewEmployeeAnnualLeave, -1, 1).Tables[0];
    }

    // detail tables data binding and loading 
    protected void gvLeaveType_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;

        switch (e.DetailTableView.Name)
        {
            case "Leaves":
                {
                    string ID = dataItem.GetDataKeyValue("recidd").ToString();

                    Hashtable ht = new Hashtable();
                    ht.Add("@LeaveTypeID", ID);

                    DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_Leave_Records", ht).Tables[0];
                    dt.TableName = "Leaves";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "Leaves";
                    break;
                }
            case "LeavePattren":
                {
                    string ID = dataItem.GetDataKeyValue("recidd").ToString();

                    Hashtable ht = new Hashtable();
                    ht.Add("@LeaveID", ID);

                    DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_Leave_Pattrens", ht).Tables[0];
                    dt.TableName = "LeavePattren";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "LeavePattren";
                    break;
                }
            case "LeaveDeductionPattren":
                {
                    string ID = dataItem.GetDataKeyValue("recidd").ToString();

                    Hashtable ht = new Hashtable();
                    ht.Add("@LeaveID", ID);

                    DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_Leave_Deduction_Pattrens", ht).Tables[0];
                    dt.TableName = "LeaveDeductionPattren";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "LeaveDeductionPattren";
                    break;
                }

        }
    }

    // get value of boolean grid columns
    protected bool CheckBoxValue(object value)
    {
        if (Convert.ToString(value) == "1") return true;
        else if (Convert.ToString(value) == "True") return true;
        else if (Convert.ToString(value) == "true") return true;

        return false;
    }

    // get image for boolean grid columns
    protected string getImagePathForTrue(bool flag)
    {
        if (flag)
            return "~/Images/16x16_tick.png";
        else
            return "";
    }

    // grid header setting for exporting
    protected void gvLeaveType_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (exporting && e.Item.ItemType == Telerik.Web.UI.GridItemType.FilteringItem)
        {
            e.Item.Visible = false;
        }
    }
}