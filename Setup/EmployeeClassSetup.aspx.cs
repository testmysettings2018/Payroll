using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Payroll_EmployeeClassSetup : System.Web.UI.Page
{
    public static Hashtable htSearchParams = null;
    public bool exporting = false;

    // page load function
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    // employee class master grid data loading and binding function
    protected void gvEmployeeClass_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_All_EmployeeClassess", htSearchParams).Tables[0];
        dt.TableName = "EmployeeClassMaster";
        gvEmployeeClass.DataSource = dt;
        gvEmployeeClass.DataMember = "EmployeeClassMaster";
    }

    // employment type ddl data loading and binding
    protected void rGrdEmploymentType4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromPayroll(Constraints.DropDownLists.ECEmploymentType, -1, 1).Tables[0];
    }

    // ticket class ddl data loading and binding
    protected void rGrdTicketClass4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromPayroll(Constraints.DropDownLists.ECTicketClass, -1, 1).Tables[0];
    }

    // tikcet period ddl data loading and binding
    protected void rGrdTicketPeriod4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromCentralDb(Constraints.DropDownLists.ECTicketPeriod, -1, 1).Tables[0];
    }
     
    // loan ddl data loading and binding
    protected void rGrdLoanCode4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_GetLoanRecords", htSearchParams).Tables[0];
    }
    
    // contribution ddl data loading and binding
    protected void rGrdContributionCode4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_GetContributionRecords", htSearchParams).Tables[0];
    }
    
    // leave ddl data loading and binding
    protected void rGrdLeave4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_GetAllLeaves", htSearchParams).Tables[0];
    }

    // gratuity ddl data loading and binding
    protected void rGrdGratuity4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_All_Gratuity_Records", htSearchParams).Tables[0];
    }

    // position ddl data loading and binding
    protected void rGrdPosition4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_payroll_GetAllPositions", htSearchParams).Tables[0];
    }

    // overtime ddl data loading and binding
    protected void rGrdOvertime4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_payroll_GetAllOvertimeRecords", htSearchParams).Tables[0];
    }
    
    // department ddl data loading and binding
    protected void rGrdDepartment4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_GetAllDepartments", htSearchParams).Tables[0];
    }

    // calender ddl data loading and binding   
    protected void rGrdCalender4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_payroll_GetAllCalenderRecords", htSearchParams).Tables[0];
    }
    
    // benefit code ddl data loading  and binding
    protected void rGrdBenifitCode4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_BenefitCode_Records", htSearchParams).Tables[0];
    }

    // pay code ddl data loading and binding
    protected void rGrdPayCode4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_PayCode_Records", htSearchParams).Tables[0];
    }

    // deduction ddl data loading and binding
    protected void rGrdDeductionCode4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_Deduction_Records", htSearchParams).Tables[0];
    }

    // detail tables data loading and binding
    protected void gvEmployeeClass_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;
        switch (e.DetailTableView.Name)
        {
            case "PayCodes":
                {
                    Int32 ID = Convert.ToInt32(dataItem.GetDataKeyValue("recidd").ToString());
                    Hashtable ht = new Hashtable();
                    ht.Add("@EmployeeClassID", ID);

                    DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_GetEmployeeClassPayCodes", ht).Tables[0];

                    dt.TableName = "PayCodes";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "PayCodes";
                    break;
                }
            case "BenefitCodes":
                {
                    Int32 ID = Convert.ToInt32(dataItem.GetDataKeyValue("recidd").ToString());
                    Hashtable ht = new Hashtable();
                    ht.Add("@EmployeeClassID", ID);

                    DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_GetEmployeeClassBenefitCodes", ht).Tables[0];
                    dt.TableName = "BenefitCodes";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "BenefitCodes";
                    break;
                }
            case "DeductionCodes":
                {
                    Int32 ID = Convert.ToInt32(dataItem.GetDataKeyValue("recidd").ToString());
                    Hashtable ht = new Hashtable();
                    ht.Add("@EmployeeClassID", ID);

                    DataTable dt = clsDAL.GetDataSet_Payroll("sp_payroll_GetEmployeeClassDeductionCodes", ht).Tables[0];
                    dt.TableName = "DeductionCodes";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "DeductionCodes";
                    break;
                }
            case "LoanRecords":
                {
                    Int32 ID = Convert.ToInt32(dataItem.GetDataKeyValue("recidd").ToString());
                    Hashtable ht = new Hashtable();
                    ht.Add("@EmployeeClassID", ID);

                    DataTable dt = clsDAL.GetDataSet_Payroll("sp_payroll_GetEmployeeClassLoanRecords", ht).Tables[0];
                    dt.TableName = "LoanRecords";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "LoanRecords";
                    break;
                }
            case "ContributionRecords":
                {
                    Int32 ID = Convert.ToInt32(dataItem.GetDataKeyValue("recidd").ToString());
                    Hashtable ht = new Hashtable();
                    ht.Add("@EmployeeClassID", ID);

                    DataTable dt = clsDAL.GetDataSet_Payroll("sp_payroll_GetEmployeeClassContributionRecords", ht).Tables[0];
                    dt.TableName = "ContributionRecords";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "ContributionRecords";
                    break;
                }
        }
    }

    // grid update command
    protected void gvEmployeeClass_UpdateCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_User(ref e, "Update");
    }

    // grid delete command for all master and detail tables
    protected void gvEmployeeClass_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        try
        {

            int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("recidd");
            Hashtable ht = new Hashtable();
            ht.Add("@ID", ID);

            if (e.Item.OwnerTableView.DataMember == "EmployeeClassMaster")
            {
                if (ID > 0)
                {
                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_EmployeeClass", ht);
                }
            }
            else if (e.Item.OwnerTableView.DataMember == "PayCodes")
            {
                if (ID > 0)
                {
                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_EmployeeClass_Codes", ht);
                }
            }
            else if (e.Item.OwnerTableView.DataMember == "BenefitCodes")
            {
                if (ID > 0)
                {
                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_EmployeeClass_Codes", ht);
                }
            }
            else if (e.Item.OwnerTableView.DataMember == "DeductionCodes")
            {
                if (ID > 0)
                {
                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_EmployeeClass_Codes", ht);
                }
            }
            else if (e.Item.OwnerTableView.DataMember == "LoanRecords")
            {
                if (ID > 0)
                {
                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_EmployeeClass_LoanCode", ht);
                }
            }
            else if (e.Item.OwnerTableView.DataMember == "ContributionRecords")
            {
                if (ID > 0)
                {
                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_EmployeeClass_ContributionCodebyId", ht);
                }
            }
        }
        catch (Exception ex)
        {

        }
    }

    // client side validation for employee class master input form
    public void ValidateEmployeeClass(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadTextBox txtEmployeeClassCode = (editForm.FindControl("txtEmployeeClassCode") as RadTextBox);
        RadTextBox txtDescription = (editForm.FindControl("txtDescription") as RadTextBox);

        RadComboBox ddlEmploymentType = (editForm.FindControl("ddlEmploymentType") as RadComboBox);

        RadComboBox ddlTicketClass = (editForm.FindControl("ddlTicketClass") as RadComboBox);
        RadNumericTextBox txtNoofTickets = (editForm.FindControl("txtNoofTickets") as RadNumericTextBox);
        RadComboBox ddlTicketPeriod = (editForm.FindControl("ddlTicketPeriod") as RadComboBox);
        RadNumericTextBox txtTicketFrequency = (editForm.FindControl("txtTicketFrequency") as RadNumericTextBox);
                
        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidateEmployeeClass('" +
                txtEmployeeClassCode.ClientID + "','" +
                txtDescription.ClientID + "','" +
                ddlEmploymentType.ClientID + "','" +
                ddlTicketClass.ClientID + "','" +
                txtNoofTickets.ClientID + "','" +
                ddlTicketPeriod.ClientID + "','" +
                txtTicketFrequency.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateEmployeeClass('" +
               txtEmployeeClassCode.ClientID + "','" +
                txtDescription.ClientID + "','" +
                ddlEmploymentType.ClientID + "','" +
                ddlTicketClass.ClientID + "','" +
                txtNoofTickets.ClientID + "','" +
                ddlTicketPeriod.ClientID + "','" +
                txtTicketFrequency.ClientID
                + "')");
        }
    }

    // client side validation function for citizen input form
    public void ValidateLoan(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadNumericTextBox txtbxMaxLoanAmount = (editForm.FindControl("txtbxMaxLoanAmount") as RadNumericTextBox);
        RadComboBox ddlLoanCode = (editForm.FindControl("ddlLoanCode") as RadComboBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidateLoan('" +
                txtbxMaxLoanAmount.ClientID + "','" +
                ddlLoanCode.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateLoan('" +
                txtbxMaxLoanAmount.ClientID + "','" +
                ddlLoanCode.ClientID
                + "')");
        }
    }

    // form controls setting for insert/update
    protected void gvEmployeeClass_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            if (e.Item.OwnerTableView.DataMember == "EmployeeClassMaster")
            {
                ValidateEmployeeClass(e);
                if (e.Item.OwnerTableView.IsItemInserted)
                {
                    #region  item is about to be inserted

                    GridEditableItem insertedItem = (GridEditableItem)e.Item;

                    //RadComboBox ddlEmployeeClassType = (RadComboBox)insertedItem.FindControl("ddlEmployeeClassType");
                    //RadComboBox ddlPaycode = (RadComboBox)insertedItem.FindControl("ddlPaycode");
                    //RadComboBox ddlMethod = (RadComboBox)insertedItem.FindControl("ddlMethod");
                    //RadComboBox ddlclsPeriod = (RadComboBox)insertedItem.FindControl("ddlclsPeriod");
                    //RadComboBox ddlNewEmoloyeeAnualLeave = (RadComboBox)insertedItem.FindControl("ddlNewEmoloyeeAnualLeave");
                    //RadComboBox ddlEmployeeClass = (RadComboBox)insertedItem.FindControl("ddlEmployeeClass");

                    //if (ddlEmployeeClassType != null)
                    //{
                    //    RadGrid grid = ddlEmployeeClassType.Items[0].FindControl("rclsEmployeeClassType4DDL") as RadGrid;
                    //    grid.Rebind();
                    //}
                    //if (ddlPaycode != null)
                    //{
                    //    Hashtable ht_filters = new Hashtable();
                    //    DataTable dt_Reports = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_PayCode_Records", ht_filters).Tables[0];
                    //    ddlPaycode.DataSource = dt_Reports;
                    //    ddlPaycode.DataTextField = "paycod";
                    //    ddlPaycode.DataValueField = "recidd";
                    //    ddlPaycode.DataBind();
                    //    ddlPaycode.SelectedIndex = 0;
                    //}
                    //if (ddlclsPeriod != null)
                    //{
                    //    RadGrid grid = ddlclsPeriod.Items[0].FindControl("rclsclsPeriod4DDL") as RadGrid;
                    //    grid.Rebind();
                    //}
                    //if (ddlMethod != null)
                    //{
                    //    RadGrid grid = ddlMethod.Items[0].FindControl("rclsMethod4DDL") as RadGrid;
                    //    grid.Rebind();
                    //}
                    //if (ddlEmployeeClass != null)
                    //{
                    //    Hashtable ht_filters = new Hashtable();
                    //    DataTable dt_Reports = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_EmployeeClass_clsords", ht_filters).Tables[0];
                    //    ddlEmployeeClass.DataSource = dt_Reports;
                    //    ddlEmployeeClass.DataTextField = "clscod";
                    //    ddlEmployeeClass.DataValueField = "recidd";
                    //    ddlEmployeeClass.DataBind();
                    //    ddlEmployeeClass.SelectedIndex = 0;
                    //}
                    
                    #endregion
                }
                else
                {
                    #region item is about to be edited
                    GridEditableItem editedItem = (GridEditableItem)e.Item;

                    RadComboBox ddlTicketPeriod = (RadComboBox)editedItem.FindControl("ddlTicketPeriod");
                    HiddenField hfTicketPerioddllID = (HiddenField)editedItem.FindControl("hfTicketPerioddllID");
                    HiddenField hfTicketPeriodddlText = (HiddenField)editedItem.FindControl("hfTicketPeriodddlText");
                    if (ddlTicketPeriod != null)
                    {
                        RadGrid grid = ddlTicketPeriod.Items[0].FindControl("rGrdTicketPeriod4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfTicketPerioddllID.Value) && !string.IsNullOrEmpty(hfTicketPeriodddlText.Value))
                        {
                            ddlTicketPeriod.Items[0].Value = hfTicketPerioddllID.Value;
                            ddlTicketPeriod.Items[0].Text = hfTicketPeriodddlText.Value;
                            ddlTicketPeriod.Text = hfTicketPeriodddlText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfTicketPerioddllID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["ValueSetID"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    RadComboBox ddlGratuity = (RadComboBox)editedItem.FindControl("ddlGratuity");
                    HiddenField hfGratuitydllID = (HiddenField)editedItem.FindControl("hfGratuitydllID");
                    HiddenField hfGratuitydllText = (HiddenField)editedItem.FindControl("hfGratuitydllText");

                    if (ddlGratuity != null)
                    {
                        RadGrid grid = ddlGratuity.Items[0].FindControl("rGrdGratuity4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfGratuitydllID.Value) && !string.IsNullOrEmpty(hfGratuitydllText.Value))
                        {
                            ddlGratuity.Items[0].Value = hfGratuitydllID.Value;
                            ddlGratuity.Items[0].Text = hfGratuitydllText.Value;
                            ddlGratuity.Text = hfGratuitydllText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfGratuitydllID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    RadComboBox ddlTicketClass = (RadComboBox)editedItem.FindControl("ddlTicketClass");
                    HiddenField hfTicketClassdllID = (HiddenField)editedItem.FindControl("hfTicketClassdllID");
                    HiddenField hfTicketClassdllText = (HiddenField)editedItem.FindControl("hfTicketClassdllText");

                    if (ddlTicketClass != null)
                    {
                        RadGrid grid = ddlTicketClass.Items[0].FindControl("rGrdTicketClass4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfTicketClassdllID.Value) && !string.IsNullOrEmpty(hfTicketClassdllText.Value))
                        {
                            ddlTicketClass.Items[0].Value = hfTicketClassdllID.Value;
                            ddlTicketClass.Items[0].Text = hfTicketClassdllText.Value;
                            ddlTicketClass.Text = hfTicketClassdllText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfTicketClassdllID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["ValueSetID"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    RadComboBox ddlLeave = (RadComboBox)editedItem.FindControl("ddlLeave");
                    HiddenField hfLeavedllID = (HiddenField)editedItem.FindControl("hfLeavedllID");
                    HiddenField hfLeavedllText = (HiddenField)editedItem.FindControl("hfLeavedllText");

                    if (ddlLeave != null)
                    {
                        RadGrid grid = ddlLeave.Items[0].FindControl("rGrdLeave4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfLeavedllID.Value) && !string.IsNullOrEmpty(hfLeavedllText.Value))
                        {
                            ddlLeave.Items[0].Value = hfLeavedllID.Value;
                            ddlLeave.Items[0].Text = hfLeavedllText.Value;
                            ddlLeave.Text = hfLeavedllText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfLeavedllID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    RadComboBox ddlPosition = (RadComboBox)editedItem.FindControl("ddlPosition");
                    HiddenField hfPositiondllID = (HiddenField)editedItem.FindControl("hfPositiondllID");
                    HiddenField hfPositiondllText = (HiddenField)editedItem.FindControl("hfPositiondllText");

                    if (ddlPosition != null)
                    {
                        RadGrid grid = ddlPosition.Items[0].FindControl("rGrdPosition4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfPositiondllID.Value) && !string.IsNullOrEmpty(hfPositiondllText.Value))
                        {
                            ddlPosition.Items[0].Value = hfPositiondllID.Value;
                            ddlPosition.Items[0].Text = hfPositiondllText.Value;
                            ddlPosition.Text = hfPositiondllText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfPositiondllID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    RadComboBox ddlDepartment = (RadComboBox)editedItem.FindControl("ddlDepartment");
                    HiddenField hfDepartmentdllID = (HiddenField)editedItem.FindControl("hfDepartmentdllID");
                    HiddenField hfDepartmentdllText = (HiddenField)editedItem.FindControl("hfDepartmentdllText");

                    if (ddlDepartment != null)
                    {
                        RadGrid grid = ddlDepartment.Items[0].FindControl("rGrdDepartment4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfDepartmentdllID.Value) && !string.IsNullOrEmpty(hfDepartmentdllText.Value))
                        {
                            ddlDepartment.Items[0].Value = hfDepartmentdllID.Value;
                            ddlDepartment.Items[0].Text = hfDepartmentdllText.Value;
                            ddlDepartment.Text = hfDepartmentdllText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfDepartmentdllID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["dptidd"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    RadComboBox ddlEmploymentType = (RadComboBox)editedItem.FindControl("ddlEmploymentType");
                    HiddenField hfEmploymentTypedllID = (HiddenField)editedItem.FindControl("hfEmploymentTypedllID");
                    HiddenField hfEmploymentTypedllText = (HiddenField)editedItem.FindControl("hfEmploymentTypedllText");

                    if (ddlEmploymentType != null)
                    {
                        RadGrid grid = ddlEmploymentType.Items[0].FindControl("rGrdEmploymentType4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfEmploymentTypedllID.Value) && !string.IsNullOrEmpty(hfEmploymentTypedllText.Value))
                        {
                            ddlEmploymentType.Items[0].Value = hfEmploymentTypedllID.Value;
                            ddlEmploymentType.Items[0].Text = hfEmploymentTypedllText.Value;
                            ddlEmploymentType.Text = hfEmploymentTypedllText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfEmploymentTypedllID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["ValueSetID"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    RadComboBox ddlOvertime = (RadComboBox)editedItem.FindControl("ddlOvertime");
                    HiddenField hfOvertimedllID = (HiddenField)editedItem.FindControl("hfOvertimedllID");
                    HiddenField hfOvertimedllText = (HiddenField)editedItem.FindControl("hfOvertimedllText");

                    if (ddlOvertime != null)
                    {
                        RadGrid grid = ddlOvertime.Items[0].FindControl("rGrdOvertime4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfOvertimedllID.Value) && !string.IsNullOrEmpty(hfOvertimedllText.Value))
                        {
                            ddlOvertime.Items[0].Value = hfOvertimedllID.Value;
                            ddlOvertime.Items[0].Text = hfOvertimedllText.Value;
                            ddlOvertime.Text = hfOvertimedllText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfOvertimedllID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
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

            else if (e.Item.OwnerTableView.DataMember == "PayCodes")
            {
                if (e.Item.OwnerTableView.IsItemInserted)
                {
                    #region  item is about to be inserted

                    GridEditableItem insertedItem = (GridEditableItem)e.Item;
                    RadComboBox ddlPaycode = (RadComboBox)insertedItem.FindControl("ddlPaycode");
                    HiddenField hfEmployeeClassId = (HiddenField)insertedItem.FindControl("hfEmployeeClassId");
                    if (hfEmployeeClassId.Value == "")
                       hfEmployeeClassId.Value =  e.Item.OwnerTableView.ParentItem.GetDataKeyValue("recidd").ToString();
                    
                    if (ddlPaycode != null)
                    {
                        if (hfEmployeeClassId != null)
                        {
                            Int32 ID = Convert.ToInt32(hfEmployeeClassId.Value);
                            Hashtable ht = new Hashtable();
                            ht.Add("@EmployeeClassID", ID);
                            DataTable dt_PayCodes = clsDAL.GetDataSet_Payroll("sp_Payroll_GetEmployeeClassPayCodes", ht).Tables[0];

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
                                            if (row["codpci"].ToString().Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
                                            {
                                                if (!string.IsNullOrEmpty(ddlPaycode.Text))
                                                    ddlPaycode.Text = ddlPaycode.Text + ",";
                                                ddlPaycode.Text = ddlPaycode.Text + row["codpcc"].ToString();
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
                else
                {
                    #region item is about to be edited
                    GridEditableItem editedItem = (GridEditableItem)e.Item;

                    RadComboBox ddlPaycode = (RadComboBox)editedItem.FindControl("ddlPaycode");
                    HiddenField hfEmployeeClassId = (HiddenField)editedItem.FindControl("hfEmployeeClassId");

                    if (ddlPaycode != null)
                    {
                        if (hfEmployeeClassId != null)
                        {
                            Int32 ID = Convert.ToInt32(hfEmployeeClassId.Value);
                            Hashtable ht = new Hashtable();
                            ht.Add("@EmployeeClassID", ID);
                            DataTable dt_PayCodes = clsDAL.GetDataSet_Payroll("sp_Payroll_GetEmployeeClassPayCodes", ht).Tables[0];

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
                                            if (row["codpci"].ToString().Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
                                            {
                                                if (!string.IsNullOrEmpty(ddlPaycode.Text))
                                                    ddlPaycode.Text = ddlPaycode.Text + ",";
                                                ddlPaycode.Text = ddlPaycode.Text + row["codpcc"].ToString();
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
            else if (e.Item.OwnerTableView.DataMember == "BenefitCodes")
            {
                if (e.Item.OwnerTableView.IsItemInserted)
                {
                    #region  item is about to be inserted

                    GridEditableItem insertedItem = (GridEditableItem)e.Item;
                    RadComboBox ddlBenefitcode = (RadComboBox)insertedItem.FindControl("ddlBenifitCode");
                    HiddenField hfEmployeeClassId = (HiddenField)insertedItem.FindControl("hfEmployeeClassId");
                    if (hfEmployeeClassId.Value == "")
                        hfEmployeeClassId.Value = e.Item.OwnerTableView.ParentItem.GetDataKeyValue("recidd").ToString();

                    if (ddlBenefitcode != null)
                    {
                        if (hfEmployeeClassId != null)
                        {
                            Int32 ID = Convert.ToInt32(hfEmployeeClassId.Value);
                            Hashtable ht = new Hashtable();
                            ht.Add("@EmployeeClassID", ID);
                            DataTable dt_BenefitCodes = clsDAL.GetDataSet_Payroll("sp_Payroll_GetEmployeeClassBenefitCodes", ht).Tables[0];

                            RadGrid grid = ddlBenefitcode.Items[0].FindControl("rGrdBenifitCode4DDL") as RadGrid;
                            if (grid != null)
                            {
                                grid.Rebind();
                                ddlBenefitcode.Text = string.Empty;
                                foreach (GridItem item in grid.MasterTableView.Items)
                                {
                                    if (item is GridDataItem)
                                    {
                                        GridDataItem dataItem = (GridDataItem)item;

                                        foreach (DataRow row in dt_BenefitCodes.Rows)
                                        {
                                            if (row["codbni"].ToString().Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
                                            {
                                                if (!string.IsNullOrEmpty(ddlBenefitcode.Text))
                                                    ddlBenefitcode.Text = ddlBenefitcode.Text + ",";
                                                ddlBenefitcode.Text = ddlBenefitcode.Text + row["codbnc"].ToString();
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
                else
                {
                    #region item is about to be edited
                    GridEditableItem editedItem = (GridEditableItem)e.Item;

                    RadComboBox ddlBenefitcode = (RadComboBox)editedItem.FindControl("ddlBenifitCode");
                    HiddenField hfEmployeeClassId = (HiddenField)editedItem.FindControl("hfEmployeeClassId");

                    if (ddlBenefitcode != null)
                    {
                        if (hfEmployeeClassId != null)
                        {
                            Int32 ID = Convert.ToInt32(hfEmployeeClassId.Value);
                            Hashtable ht = new Hashtable();
                            ht.Add("@EmployeeClassID", ID);
                            DataTable dt_BenefitCodes = clsDAL.GetDataSet_Payroll("sp_Payroll_GetEmployeeClassBenefitCodes", ht).Tables[0];

                            RadGrid grid = ddlBenefitcode.Items[0].FindControl("rGrdBenifitCode4DDL") as RadGrid;
                            if (grid != null)
                            {
                                grid.Rebind();
                                ddlBenefitcode.Text = string.Empty;
                                foreach (GridItem item in grid.MasterTableView.Items)
                                {
                                    if (item is GridDataItem)
                                    {
                                        GridDataItem dataItem = (GridDataItem)item;

                                        foreach (DataRow row in dt_BenefitCodes.Rows)
                                        {
                                            if (row["codbni"].ToString().Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
                                            {
                                                if (!string.IsNullOrEmpty(ddlBenefitcode.Text))
                                                    ddlBenefitcode.Text = ddlBenefitcode.Text + ",";
                                                ddlBenefitcode.Text = ddlBenefitcode.Text + row["codbnc"].ToString();
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
            else if (e.Item.OwnerTableView.DataMember == "DeductionCodes")
            {
                if (e.Item.OwnerTableView.IsItemInserted)
                {
                    #region  item is about to be inserted

                    GridEditableItem insertedItem = (GridEditableItem)e.Item;
                    RadComboBox ddlDeductioncode = (RadComboBox)insertedItem.FindControl("ddlDeductioncode");
                    HiddenField hfEmployeeClassId = (HiddenField)insertedItem.FindControl("hfEmployeeClassId");
                    if (hfEmployeeClassId.Value == "")
                        hfEmployeeClassId.Value = e.Item.OwnerTableView.ParentItem.GetDataKeyValue("recidd").ToString();

                    if (ddlDeductioncode != null)
                    {
                        if (hfEmployeeClassId != null)
                        {
                            Int32 ID = Convert.ToInt32(hfEmployeeClassId.Value);
                            Hashtable ht = new Hashtable();
                            ht.Add("@EmployeeClassID", ID);
                            DataTable dt_DeductionCodes = clsDAL.GetDataSet_Payroll("sp_Payroll_GetEmployeeClassDeductionCodes", ht).Tables[0];

                            RadGrid grid = ddlDeductioncode.Items[0].FindControl("rGrdDeductionCode4DDL") as RadGrid;
                            if (grid != null)
                            {
                                grid.Rebind();
                                ddlDeductioncode.Text = string.Empty;
                                foreach (GridItem item in grid.MasterTableView.Items)
                                {
                                    if (item is GridDataItem)
                                    {
                                        GridDataItem dataItem = (GridDataItem)item;

                                        foreach (DataRow row in dt_DeductionCodes.Rows)
                                        {
                                            if (row["codddi"].ToString().Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
                                            {
                                                if (!string.IsNullOrEmpty(ddlDeductioncode.Text))
                                                    ddlDeductioncode.Text = ddlDeductioncode.Text + ",";
                                                ddlDeductioncode.Text = ddlDeductioncode.Text + row["coddc"].ToString();
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
                else
                {
                    #region item is about to be edited
                    GridEditableItem editedItem = (GridEditableItem)e.Item;

                    RadComboBox ddlDeductioncode = (RadComboBox)editedItem.FindControl("ddlDeductioncode");
                    HiddenField hfEmployeeClassId = (HiddenField)editedItem.FindControl("hfEmployeeClassId");

                    if (ddlDeductioncode != null)
                    {
                        if (hfEmployeeClassId != null)
                        {
                            Int32 ID = Convert.ToInt32(hfEmployeeClassId.Value);
                            Hashtable ht = new Hashtable();
                            ht.Add("@EmployeeClassID", ID);
                            DataTable dt_DeductionCodes = clsDAL.GetDataSet_Payroll("sp_Payroll_GetEmployeeClassDeductionCodes", ht).Tables[0];

                            RadGrid grid = ddlDeductioncode.Items[0].FindControl("rGrdDeductionCode4DDL") as RadGrid;
                            if (grid != null)
                            {
                                grid.Rebind();
                                ddlDeductioncode.Text = string.Empty;
                                foreach (GridItem item in grid.MasterTableView.Items)
                                {
                                    if (item is GridDataItem)
                                    {
                                        GridDataItem dataItem = (GridDataItem)item;

                                        foreach (DataRow row in dt_DeductionCodes.Rows)
                                        {
                                            if (row["codddi"].ToString().Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
                                            {
                                                if (!string.IsNullOrEmpty(ddlDeductioncode.Text))
                                                    ddlDeductioncode.Text = ddlDeductioncode.Text + ",";
                                                ddlDeductioncode.Text = ddlDeductioncode.Text + row["coddc"].ToString();
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
            else if (e.Item.OwnerTableView.DataMember == "LoanRecords")
            {
                ValidateLoan(e);
                if (e.Item.OwnerTableView.IsItemInserted)
                {
                    #region  item is about to be inserted
                
                    #endregion
                }
                else
                {
                    #region item is about to be edited
                    GridEditableItem editedItem = (GridEditableItem)e.Item;

                    RadComboBox ddlLoanCode = (RadComboBox)editedItem.FindControl("ddlLoanCode");
                    HiddenField hfddlLoanCodeId = (HiddenField)editedItem.FindControl("hfddlLoanCodeId");
                    HiddenField hfddlLoanCodeText = (HiddenField)editedItem.FindControl("hfddlLoanCodeText");

                    if (ddlLoanCode != null)
                    {
                        RadGrid grid = ddlLoanCode.Items[0].FindControl("rGrdLoanCode4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfddlLoanCodeId.Value) && !string.IsNullOrEmpty(hfddlLoanCodeText.Value))
                        {
                            ddlLoanCode.Items[0].Value = hfddlLoanCodeId.Value;
                            ddlLoanCode.Items[0].Text = hfddlLoanCodeText.Value;
                            ddlLoanCode.Text = hfddlLoanCodeText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfddlLoanCodeId.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
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
            else if (e.Item.OwnerTableView.DataMember == "ContributionRecords")
            {
                if (e.Item.OwnerTableView.IsItemInserted)
                {
                    #region  item is about to be inserted

                    GridEditableItem insertedItem = (GridEditableItem)e.Item;
                    RadComboBox ddlContributionCode = (RadComboBox)insertedItem.FindControl("ddlContributionCode");
                    HiddenField hfEmployeeClassId = (HiddenField)insertedItem.FindControl("hfEmployeeClassId");
                    if (hfEmployeeClassId.Value == "")
                        hfEmployeeClassId.Value = e.Item.OwnerTableView.ParentItem.GetDataKeyValue("recidd").ToString();

                    if (ddlContributionCode != null)
                    {
                        if (hfEmployeeClassId != null)
                        {
                            Int32 ID = Convert.ToInt32(hfEmployeeClassId.Value);
                            Hashtable ht = new Hashtable();
                            ht.Add("@EmployeeClassID", ID);
                            DataTable dt_ContributionCodes = clsDAL.GetDataSet_Payroll("sp_payroll_GetEmployeeClassContributionRecords", ht).Tables[0];

                            RadGrid grid = ddlContributionCode.Items[0].FindControl("rGrdContributionCode4DDL") as RadGrid;
                            if (grid != null)
                            {
                                grid.Rebind();
                                ddlContributionCode.Text = string.Empty;
                                foreach (GridItem item in grid.MasterTableView.Items)
                                {
                                    if (item is GridDataItem)
                                    {
                                        GridDataItem dataItem = (GridDataItem)item;

                                        foreach (DataRow row in dt_ContributionCodes.Rows)
                                        {
                                            if (row["cntidd"].ToString().Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
                                            {
                                                if (!string.IsNullOrEmpty(ddlContributionCode.Text))
                                                    ddlContributionCode.Text = ddlContributionCode.Text + ",";
                                                ddlContributionCode.Text = ddlContributionCode.Text + row["cntcod"].ToString();
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
                else
                {
                    #region item is about to be edited
                    GridEditableItem editedItem = (GridEditableItem)e.Item;

                    RadComboBox ddlContributionCode = (RadComboBox)editedItem.FindControl("ddlContributionCode");
                    HiddenField hfEmployeeClassId = (HiddenField)editedItem.FindControl("hfEmployeeClassId");
                    if (hfEmployeeClassId.Value == "")
                        hfEmployeeClassId.Value = e.Item.OwnerTableView.ParentItem.GetDataKeyValue("recidd").ToString();

                    if (ddlContributionCode != null)
                    {
                        if (hfEmployeeClassId != null)
                        {
                            Int32 ID = Convert.ToInt32(hfEmployeeClassId.Value);
                            Hashtable ht = new Hashtable();
                            ht.Add("@EmployeeClassID", ID);
                            DataTable dt_ContributionCodes = clsDAL.GetDataSet_Payroll("sp_payroll_GetEmployeeClassContributionRecords", ht).Tables[0];

                            RadGrid grid = ddlContributionCode.Items[0].FindControl("rGrdContributionCode4DDL") as RadGrid;
                            if (grid != null)
                            {
                                grid.Rebind();
                                ddlContributionCode.Text = string.Empty;
                                foreach (GridItem item in grid.MasterTableView.Items)
                                {
                                    if (item is GridDataItem)
                                    {
                                        GridDataItem dataItem = (GridDataItem)item;

                                        foreach (DataRow row in dt_ContributionCodes.Rows)
                                        {
                                            if (row["cntidd"].ToString().Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
                                            {
                                                if (!string.IsNullOrEmpty(ddlContributionCode.Text))
                                                    ddlContributionCode.Text = ddlContributionCode.Text + ",";
                                                ddlContributionCode.Text = ddlContributionCode.Text + row["cntcod"].ToString();
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
    protected void gvEmployeeClass_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (exporting && e.Item.ItemType == Telerik.Web.UI.GridItemType.FilteringItem)
        {
            e.Item.Visible = false;
        }
    }
    
    // clear form controls for input 
    // export functions
    protected void gvEmployeeClass_ItemCommand(object sender, GridCommandEventArgs e)
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
            //grid.ExportSettings.HideStructuclsolumns = true;

            foreach (GridDataItem item in grid.Items)
            {
                item["ExpandColumn"].Visible = false;
            }

            if (e.Item.OwnerTableView.DataMember == "EmployeeClassMaster")
            {
                grid.MasterTableView.GetColumn("Editclscod").Visible = false;
                grid.MasterTableView.GetColumn("Deleteclscod").Visible = false;
            }
            else if (e.Item.OwnerTableView.DataMember == "PayCodes")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "BenefitCodes")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "DeductionCodes")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "LoanRecords")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "ContributionRecords")
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
            if (e.Item.OwnerTableView.DataMember == "EmployeeClassMaster")
            {
                grid.MasterTableView.GetColumn("Editclscod").Visible = false;
                grid.MasterTableView.GetColumn("Deleteclscod").Visible = false;
            }
            else if (e.Item.OwnerTableView.DataMember == "PayCodes")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "BenefitCodes")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "DeductionCodes")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "LoanRecords")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "ContributionRecords")
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
            if (e.Item.OwnerTableView.DataMember == "EmployeeClassMaster")
            {
                grid.MasterTableView.GetColumn("Editclscod").Visible = false;
                grid.MasterTableView.GetColumn("Deleteclscod").Visible = false;
            }
            else if (e.Item.OwnerTableView.DataMember == "PayCodes")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "BenefitCodes")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "DeductionCodes")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "LoanRecords")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "ContributionRecords")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            grid.MasterTableView.ExportToPdf();
        }
        if (e.CommandName == "Print")
        {
            Button btnPrint = (Button)e.Item.FindControl("btnEmployeeClassPrint");
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
    
    // export format settings
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
                if (column.UniqueName == "DeleteBenefitCode" || column.UniqueName == "EditBenefitCode")
                {
                    column.Display = false;
                    column.Visible = false;
                }
                if (column.UniqueName == "EditPayCode" || column.UniqueName == "DeletePayCode")
                {
                    column.Display = false;
                    column.Visible = false;
                }
                if (column.UniqueName == "EditDeductionCode" || column.UniqueName == "DeleteDeductionCode")
                {
                    column.Display = false;
                    column.Visible = false;
                }
                if (column.UniqueName == "EditLoanRecords" || column.UniqueName == "DeleteLoanRecords")
                {
                    column.Display = false;
                    column.Visible = false;
                }
                if (column.UniqueName == "EditContributionCode" || column.UniqueName == "DeleteContributionCode")
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
    protected void gvEmployeeClass_InsertCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_User(ref e, "Insert");
    }

    // insert/update function
    private void Insert_or_Update_User(ref GridCommandEventArgs e, string operation)
    {
        GridEditableItem editedItem = e.Item as GridEditableItem;
        try
        {
            if (e.Item.OwnerTableView.DataMember == "EmployeeClassMaster")
            {
                #region Grid Master
                //Insert new values
                Hashtable newValues = new Hashtable();
                if (operation == "Update")
                {
                    newValues["@recidd"] = (int)editedItem.GetDataKeyValue("recidd");
                }
                newValues["@clscod"] = (editedItem.FindControl("txtEmployeeClassCode") as RadTextBox).Text.Trim();
                newValues["@clsds1"] = (editedItem.FindControl("txtDescription") as RadTextBox).Text;
                newValues["@clsds2"] = (editedItem.FindControl("txtArabicDescription") as RadTextBox).Text;
                newValues["@clsetp"] = (editedItem.FindControl("ddlEmploymentType") as RadComboBox).Items[0].Value.Trim();

                newValues["@dptidd"] = (editedItem.FindControl("ddlDepartment") as RadComboBox).Items[0].Value.Trim();
                newValues["@posidd"] = (editedItem.FindControl("ddlPosition") as RadComboBox).Items[0].Value.Trim();
                newValues["@anlidd"] = (editedItem.FindControl("ddlLeave") as RadComboBox).Items[0].Value.Trim();
                newValues["@grtidd"] = (editedItem.FindControl("ddlGratuity") as RadComboBox).Items[0].Value.Trim();
                newValues["@ovtidd"] = (editedItem.FindControl("ddlOvertime") as RadComboBox).Items[0].Value.Trim();
                
                newValues["@clstcp"] = (editedItem.FindControl("ddlTicketClass") as RadComboBox).Items[0].Value.Trim();
                newValues["@clstcc"] = (editedItem.FindControl("txtNoofTickets") as RadNumericTextBox).Text;
                newValues["@clsprd"] = (editedItem.FindControl("ddlTicketPeriod") as RadComboBox).Items[0].Value.Trim();
                newValues["@clsfrq"] = (editedItem.FindControl("txtTicketFrequency") as RadNumericTextBox).Text;
                
                newValues["@DBMessage"] = "";

                string DBMessage = "";

                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_clsroll_Insert_EmployeeClass", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_clsroll_Update_EmployeeClass", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                else
                {
                gvEmployeeClass.Rebind();
                ShowClientMessage("Employee Class record save successfully.", MessageType.Success);
                }
                
                #endregion
            }
            else if (e.Item.OwnerTableView.DataMember == "PayCodes")
            {
                #region Pay Code
                //Insert new values
                Hashtable newValues = new Hashtable();

                GridDataItem parentItem = (GridDataItem)(e.Item.OwnerTableView.ParentItem);
                if (parentItem != null)
                {
                    newValues["@clsidd"] = Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["recidd"].ToString());

                    newValues["@codtyp"] = 1; // code type 1 for pay code

                    RadComboBox ddlPayCode = (editedItem.FindControl("ddlPayCode") as RadComboBox);
                    if (ddlPayCode != null)
                    {
                        if (ddlPayCode.Items.Count > 0)
                        {
                            RadGrid rgPayCodes = (ddlPayCode.Items[0].FindControl("rGrdPayCode4DDL") as RadGrid);
                            if (rgPayCodes.SelectedItems.Count > 0)
                            {
                                #region delete old records

                                Hashtable ht = new Hashtable();
                                ht.Add("@ID", Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["recidd"].ToString()));
                                clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_EmployeeClass_PayCode", ht);

                                #endregion

                                foreach (GridDataItem dataItem in rgPayCodes.SelectedItems)
                                {
                                    newValues["@codpci"] = Convert.ToInt32(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString());
                                    newValues["@DBMessage"] = "";

                                    string DBMessage = "";
                                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_EmployeeClass_PayCode", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                                    if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                                    {
                                        ShowClientMessage(DBMessage, MessageType.Error);
                                        e.Canceled = true;
                                    }
                                }
                                ShowClientMessage("Pay codes saved successfully.", MessageType.Success);
                            }
                        }
                    }
                }
                #endregion
            }
            else if (e.Item.OwnerTableView.DataMember == "BenefitCodes")
            {
                #region Benefit Code
                //Insert new values
                Hashtable newValues = new Hashtable();

                GridDataItem parentItem = (GridDataItem)(e.Item.OwnerTableView.ParentItem);
                if (parentItem != null)
                {
                    newValues["@clsidd"] = Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["recidd"].ToString());

                    newValues["@codtyp"] = 2; // code type 2 for benefit code

                    RadComboBox ddlBenifitCode = (editedItem.FindControl("ddlBenifitCode") as RadComboBox);
                    if (ddlBenifitCode != null)
                    {
                        if (ddlBenifitCode.Items.Count > 0)
                        {
                            RadGrid rgPayCodes = (ddlBenifitCode.Items[0].FindControl("rGrdBenifitCode4DDL") as RadGrid);
                            if (rgPayCodes.SelectedItems.Count > 0)
                            {
                                #region delete old records

                                Hashtable ht = new Hashtable();
                                ht.Add("@ID", Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["recidd"].ToString()));
                                clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_EmployeeClass_BenefitCode", ht);

                                #endregion

                                foreach (GridDataItem dataItem in rgPayCodes.SelectedItems)
                                {
                                    newValues["@codbni"] = Convert.ToInt32(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString());
                                    newValues["@DBMessage"] = "";

                                    string DBMessage = "";
                                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_EmployeeClass_BenefitCode", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                                    if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                                    {
                                        ShowClientMessage(DBMessage, MessageType.Error);
                                        e.Canceled = true;
                                    }
                                }
                                ShowClientMessage("Benefit codes saved successfully.", MessageType.Success);
                            }
                        }
                    }
                }
                #endregion
            }
            else if (e.Item.OwnerTableView.DataMember == "DeductionCodes")
            {
                #region Deduction Code
                //Insert new values
                Hashtable newValues = new Hashtable();

                GridDataItem parentItem = (GridDataItem)(e.Item.OwnerTableView.ParentItem);
                if (parentItem != null)
                {
                    newValues["@clsidd"] = Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["recidd"].ToString());

                    newValues["@codtyp"] = 3; // code type 3 for deduction code

                    RadComboBox ddlDeductionCode = (editedItem.FindControl("ddlDeductionCode") as RadComboBox);
                    if (ddlDeductionCode != null)
                    {
                        if (ddlDeductionCode.Items.Count > 0)
                        {
                            RadGrid rgDeductionCodes = (ddlDeductionCode.Items[0].FindControl("rGrdDeductionCode4DDL") as RadGrid);
                            if (rgDeductionCodes.SelectedItems.Count > 0)
                            {
                                #region delete old records

                                Hashtable ht = new Hashtable();
                                ht.Add("@ID", Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["recidd"].ToString()));
                                clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_EmployeeClass_DeductionCode", ht);

                                #endregion

                                foreach (GridDataItem dataItem in rgDeductionCodes.SelectedItems)
                                {
                                    newValues["@codddi"] = Convert.ToInt32(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString());
                                    newValues["@DBMessage"] = "";

                                    string DBMessage = "";
                                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_EmployeeClass_DeductionCode", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                                    if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                                    {
                                        ShowClientMessage(DBMessage, MessageType.Error);
                                        e.Canceled = true;
                                    }
                                }
                                ShowClientMessage("Deduction codes saved successfully.", MessageType.Success);
                            }
                        }
                    }
                }
                #endregion
            }
            else if (e.Item.OwnerTableView.DataMember == "LoanRecords")
            {
                #region Loan Code
                //Insert new values
                Hashtable newValues = new Hashtable();

                if (operation == "Update")
                {
                    newValues["@recidd"] = (int)editedItem.GetDataKeyValue("recidd");
                }
                GridDataItem parentItem = (GridDataItem)(e.Item.OwnerTableView.ParentItem);
                if (parentItem != null)
                {
                    newValues["@clsidd"] = Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["recidd"].ToString());               
                }
                newValues["@clslni"] = (editedItem.FindControl("ddlLoanCode") as RadComboBox).Items[0].Value.Trim();
                newValues["@clsmal"] = (editedItem.FindControl("txtbxMaxLoanAmount") as RadNumericTextBox).Text;

                newValues["@DBMessage"] = "";

                string DBMessage = "";

                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Insert_EmployeeClassLoan", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Update_EmployeeClassLoan", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                else
                {
                ShowClientMessage("Employee Class Loan record save successfully.", MessageType.Success);
                }
                #endregion
            }
            else if (e.Item.OwnerTableView.DataMember == "ContributionRecords")
            {
                #region Contributon Code
                //Insert new values
                Hashtable newValues = new Hashtable();

                GridDataItem parentItem = (GridDataItem)(e.Item.OwnerTableView.ParentItem);
                if (parentItem != null)
                {
                    newValues["@clsidd"] = Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["recidd"].ToString());

                    RadComboBox ddlContributionCode = (editedItem.FindControl("ddlContributionCode") as RadComboBox);
                    if (ddlContributionCode != null)
                    {
                        if (ddlContributionCode.Items.Count > 0)
                        {
                            RadGrid rgPayCodes = (ddlContributionCode.Items[0].FindControl("rGrdContributionCode4DDL") as RadGrid);
                            if (rgPayCodes.SelectedItems.Count > 0)
                            {
                                #region delete old records

                                Hashtable ht = new Hashtable();
                                ht.Add("@ID", Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["recidd"].ToString()));
                                clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_EmployeeClass_ContributionCode", ht);

                                #endregion

                                foreach (GridDataItem dataItem in rgPayCodes.SelectedItems)
                                {
                                    newValues["@clslni"] = Convert.ToInt32(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString());
                                    newValues["@DBMessage"] = "";

                                    string DBMessage = "";
                                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_EmployeeContributionCode", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                                    if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                                    {
                                        ShowClientMessage(DBMessage, MessageType.Error);
                                        e.Canceled = true;
                                    }
                                }
                                ShowClientMessage("Contribution codes saved successfully.", MessageType.Success);
                            }
                        }
                    }
                }
                #endregion
            }
        }
        catch (Exception ex)
        {
            ShowClientMessage("Unable to update/insert Employee Class Code: " + ex.Message, MessageType.Error);
            e.Canceled = true;
        }
    }
    
    // display client messages
    public void ShowClientMessage(string message, MessageType type, string rediclst = "")
    {
        if (type == MessageType.Error)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "radalert", "showError('" + message + "', '" + rediclst + "', 5000)", true);
        }
        else if (type == MessageType.Success)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "radalert", "showSuccess('" + message + "', '" + rediclst + "', 5000)", true);
        }
        else if (type == MessageType.Warning)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "radalert", "showWarning('" + message + "', '" + rediclst + "', 5000)", true);
        }
        else if (type == MessageType.Info)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "radalert", "showInfo('" + message + "', '" + rediclst + "', 5000)", true);
        }
    }
   
    // get value for boolean grid columns
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
}
