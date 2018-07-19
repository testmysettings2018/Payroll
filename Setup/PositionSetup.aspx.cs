using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;


public partial class Payroll_PositionSetup : System.Web.UI.Page
{
    public static Hashtable htSearchParams = null;
    public bool exporting = false;

    // page load function
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    // position master grid data loading and binding
    protected void gvPosition_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        DataTable dt = clsDAL.GetDataSet_Payroll("sp_payroll_GetAllPositions", htSearchParams).Tables[0];
        dt.TableName = "PositionMaster";
        gvPosition.DataSource = dt;
        gvPosition.DataMember = "PositionMaster";
    }

    // pay code ddl data loading and binding
    protected void rGrdPayCode4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_PayCode_Records", htSearchParams).Tables[0];
    }

    // benefit code ddl data loading and binding
    protected void rGrdBenefitCode4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_BenefitCode_Records", htSearchParams).Tables[0];
    }

    // deduction code ddl data loading and binding
    protected void rGrdDeductionCode4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_Deduction_Records", htSearchParams).Tables[0];
    }

    // position ddl data loading and binding
    protected void rposPosition4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_All_Positions", htSearchParams).Tables[0];
    }

    // ticket class data loading and binding
    protected void rposTicketClass4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromCentralDb(Constraints.DropDownLists.ECTicketClass, -1, 1).Tables[0];
    }

    // next position ddl data loading and binding
    protected void rposNextPosition4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_All_Positions", htSearchParams).Tables[0];
    }

    // leave ddl data loading and binding
    protected void rposLeave4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_Leave_AllRecords", htSearchParams).Tables[0];
    }

    // overtime ddl data loading and binding
    protected void rposOvertime4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_payroll_GetAllOvertimeRecords", htSearchParams).Tables[0];
    }

    // calender ddl data loading and binding
    protected void rposCalender4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_payroll_GetAllCalenderRecords", htSearchParams).Tables[0];
    }

    // gratuity ddl data loading and binding
    protected void rposGraduity4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_All_Gratuity_Records", htSearchParams).Tables[0];
    }

    // gratuity provision ddl data loading and binding
    protected void rposGraduityProv4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_All_Gratuity_Records", htSearchParams).Tables[0];
    }

    // contribution ddl data loading and binding
    protected void rGrdContributionCode4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_GetContributionRecords", htSearchParams).Tables[0];
    }

    // grid detail table data binding and loading
    protected void gvPosition_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;
        switch (e.DetailTableView.Name)
        {
            case "Citizens":
                {
                    string ID = dataItem.GetDataKeyValue("recidd").ToString();

                    Hashtable ht = new Hashtable();
                    ht.Add("@PositionID", ID);

                    DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_GetPositionCitizens", ht).Tables[0];
                    dt.TableName = "Citizens";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "Citizens";
                    break;
                }
            case "CiizensPayCodes":
                {
                    GridDataItem parentItem = (GridDataItem)(dataItem.OwnerTableView.ParentItem);
                    Int32 ID = 0;
                    if (parentItem != null)
                    {
                        ID = Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["recidd"].ToString());
                    }
                    Hashtable ht = new Hashtable();
                    ht.Add("@PositionID", ID);

                    DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_GetPositionPayCodesCitizens", ht).Tables[0];

                    dt.TableName = "CiizensPayCodes";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "CiizensPayCodes";
                    break;
                }
            case "CiizensBenefitCodes":
                {
                    GridDataItem parentItem = (GridDataItem)(dataItem.OwnerTableView.ParentItem);
                    Int32 ID = 0;
                    if (parentItem != null)
                    {
                        ID = Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["recidd"].ToString());
                    }
                    Hashtable ht = new Hashtable();
                    ht.Add("@PositionID", ID);

                    DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_GetPositionBenefitCodesCitizens", ht).Tables[0];
                    dt.TableName = "CiizensPayCodes";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "CiizensBenefitCodes";
                    break;
                }
            case "CiizensDeductionCodes":
                {
                    GridDataItem parentItem = (GridDataItem)(dataItem.OwnerTableView.ParentItem);
                    Int32 ID = 0;
                    if (parentItem != null)
                    {
                        ID = Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["recidd"].ToString());
                    }
                    Hashtable ht = new Hashtable();
                    ht.Add("@PositionID", ID);

                    DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_GetPositionDeductionCodesCitizens", ht).Tables[0];
                    dt.TableName = "CiizensDeductionCodes";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "CiizensDeductionCodes";
                    break;
                }
            case "CitizenContributionCodes":
                {
                    GridDataItem parentItem = (GridDataItem)(dataItem.OwnerTableView.ParentItem);
                    Int32 ID = 0;
                    if (parentItem != null)
                    {
                        ID = Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["recidd"].ToString());
                    }
                    Hashtable ht = new Hashtable();
                    ht.Add("@PositionID", ID);

                    DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_GetPositionContributionCodesCitizens", ht).Tables[0];
                    dt.TableName = "CitizenContributionCodes";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "CitizenContributionCodes";
                    break;
                }
            case "CitizenLoanRecords":
                {
                    GridDataItem parentItem = (GridDataItem)(dataItem.OwnerTableView.ParentItem);
                    Int32 ID = 0;
                    if (parentItem != null)
                    {
                        ID = Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["recidd"].ToString());
                    }
                    Hashtable ht = new Hashtable();
                    ht.Add("@PositionID", ID);

                    DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_GetPositionLoanCodesCitizen", ht).Tables[0];
                    dt.TableName = "CitizenLoanRecords";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "CitizenLoanRecords";
                    break;
                }
            case "Expatriate":
                {
                    string ID = dataItem.GetDataKeyValue("recidd").ToString();

                    Hashtable ht = new Hashtable();
                    ht.Add("@PositionID", ID);

                    DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_GetPositionExpat", ht).Tables[0];
                    dt.TableName = "Expatriate";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "Expatriate";
                    break;
                }
            case "ExpatriatePayCodes":
                {
                    GridDataItem parentItem = (GridDataItem)(dataItem.OwnerTableView.ParentItem);
                    Int32 ID = 0;
                    if (parentItem != null)
                    {
                        ID = Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["recidd"].ToString());
                    }
                    Hashtable ht = new Hashtable();
                    ht.Add("@PositionID", ID);

                    DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_GetPositionPayCodesExpat", ht).Tables[0];

                    dt.TableName = "ExpatriatePayCodes";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "ExpatriatePayCodes";
                    break;
                }
            case "ExpatriateBenefitCodes":
                {
                    GridDataItem parentItem = (GridDataItem)(dataItem.OwnerTableView.ParentItem);
                    Int32 ID = 0;
                    if (parentItem != null)
                    {
                        ID = Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["recidd"].ToString());
                    }
                    Hashtable ht = new Hashtable();
                    ht.Add("@PositionID", ID);

                    DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_GetPositionBenefitCodesExpat", ht).Tables[0];
                    dt.TableName = "ExpatriateBenefitCodes";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "ExpatriateBenefitCodes";
                    break;
                }
            case "ExpatriateDeductionCodes":
                {
                    GridDataItem parentItem = (GridDataItem)(dataItem.OwnerTableView.ParentItem);
                    Int32 ID = 0;
                    if (parentItem != null)
                    {
                        ID = Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["recidd"].ToString());
                    }
                    Hashtable ht = new Hashtable();
                    ht.Add("@PositionID", ID);

                    DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_GetPositionDeductionCodesExpat", ht).Tables[0];
                    dt.TableName = "ExpatriateDeductionCodes";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "ExpatriateDeductionCodes";
                    break;
                }
            case "ExpatriateContributionCodes":
                {
                    GridDataItem parentItem = (GridDataItem)(dataItem.OwnerTableView.ParentItem);
                    Int32 ID = 0;
                    if (parentItem != null)
                    {
                        ID = Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["recidd"].ToString());
                    }
                    Hashtable ht = new Hashtable();
                    ht.Add("@PositionID", ID);

                    DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_GetPositionContributionCodesExpatriate", ht).Tables[0];
                    dt.TableName = "ExpatriateContributionCodes";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "ExpatriateContributionCodes";
                    break;
                }
            case "ExpatriateLoanRecords":
                {
                    GridDataItem parentItem = (GridDataItem)(dataItem.OwnerTableView.ParentItem);
                    Int32 ID = 0;
                    if (parentItem != null)
                    {
                        ID = Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["recidd"].ToString());
                    }
                    Hashtable ht = new Hashtable();
                    ht.Add("@PositionID", ID);

                    DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_GetPositionLoanCodesExpatriate", ht).Tables[0];
                    dt.TableName = "ExpatriateLoanRecords";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "ExpatriateLoanRecords";
                    break;
                }
        }
    }

    // loan ddl data loading and binding
    protected void rGrdLoanCode4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_GetLoanRecords", htSearchParams).Tables[0];
    }

    // grid update command
    protected void gvPosition_UpdateCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_User(ref e, "Update");
    }

    // grid delete command for master and detail tables
    protected void gvPosition_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        try
        {

            if (e.Item.OwnerTableView.DataMember == "PositionMaster")
            {
                int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("recidd");
                Hashtable ht = new Hashtable();
                ht.Add("@ID", ID);
                if (ID > 0)
                {
                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Position", ht);
                }
            }
            else if (e.Item.OwnerTableView.DataMember == "CiizensPayCodes")
            {
                int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("recidd");
                Hashtable ht = new Hashtable();
                ht.Add("@ID", ID);
                if (ID > 0)
                {
                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Position_Citizen_PayCodes", ht);
                }
            }
            else if (e.Item.OwnerTableView.DataMember == "CiizensBenefitCodes")
            {
                int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("recidd");
                Hashtable ht = new Hashtable();
                ht.Add("@ID", ID);
                if (ID > 0)
                {
                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Position_Citizen_BenefitCodes", ht);
                }
            }
            else if (e.Item.OwnerTableView.DataMember == "CiizensDeductionCodes")
            {
                int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("recidd");
                Hashtable ht = new Hashtable();
                ht.Add("@ID", ID);
                if (ID > 0)
                {
                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Position_Citizen_DeductionCodes", ht);
                }
            }
            else if (e.Item.OwnerTableView.DataMember == "CitizenContributionCodes")
            {
                int contID = (int)((GridDataItem)e.Item).GetDataKeyValue("recidd");
                Hashtable contht = new Hashtable();
                contht.Add("@cntID", contID);
                if (contID > 0)
                {
                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Position_Citizen_ContributionCode", contht);
                }
            }
            else if (e.Item.OwnerTableView.DataMember == "CitizenLoanRecords")
            { int loanID = (int)((GridDataItem)e.Item).GetDataKeyValue("recidd");
                Hashtable loanht = new Hashtable();
                loanht.Add("@LoanID", loanID);
                if (loanID > 0)
                {
                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Position_LoneCode", loanht);
                }    
            }
            else if (e.Item.OwnerTableView.DataMember == "ExpatriateContributionCodes")
            {
                int contID = (int)((GridDataItem)e.Item).GetDataKeyValue("recidd");
                Hashtable contht = new Hashtable();
                contht.Add("@cntID", contID);
                if (contID > 0)
                {
                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Position_Citizen_ContributionCode", contht);
                }
            }
            else if (e.Item.OwnerTableView.DataMember == "ExpatriatePayCodes")
            {
                int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("recidd");
                Hashtable ht = new Hashtable();
                ht.Add("@ID", ID);
                if (ID > 0)
                {
                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Position_Expatriate_PayCodes", ht);
                }
            }
            else if (e.Item.OwnerTableView.DataMember == "ExpatriateBenefitCodes")
            {
                int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("recidd");
                Hashtable ht = new Hashtable();
                ht.Add("@ID", ID);
                if (ID > 0)
                {
                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Position_Expatriate_BenefitCodes", ht);
                }
            }
            else if (e.Item.OwnerTableView.DataMember == "ExpatriateDeductionCodes")
            {
                int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("recidd");
                Hashtable ht = new Hashtable();
                ht.Add("@ID", ID);
                if (ID > 0)
                {
                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Position_Expatriate_DeductionCodes", ht);
                }
            }
            else if (e.Item.OwnerTableView.DataMember == "ExpatriateLoanRecords")
            {
                int loanID = (int)((GridDataItem)e.Item).GetDataKeyValue("recidd");
                Hashtable loanht = new Hashtable();
                loanht.Add("@LoanID", loanID);
                if (loanID > 0)
                {
                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Position_LoneCode", loanht);
                }
            }
        }
        catch (Exception ex)
        {

        }
    }

    // client side validation function for position master form input
    public void ValidatePosition(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadTextBox txtPositionCode = (editForm.FindControl("txtPositionCode") as RadTextBox);
        RadTextBox txtDescription = (editForm.FindControl("txtDescription") as RadTextBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidatePosition('" +
                txtPositionCode.ClientID + "','" +
                txtDescription.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidatePosition('" +
                txtPositionCode.ClientID + "','" +
                txtDescription.ClientID
                + "')");
        }
    }

    // client side validation function for citizen paycode form input
    public void ValidatePositionCiizensPayCodes(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadComboBox ddlPayCode = (editForm.FindControl("ddlPayCode") as RadComboBox);
        RadNumericTextBox txtCPCsngfrm = (editForm.FindControl("txtCPCsngfrm") as RadNumericTextBox);
        RadNumericTextBox txtBxCPCsngtoo = (editForm.FindControl("txtBxCPCsngtoo") as RadNumericTextBox);
        RadNumericTextBox txtBxCPCmarfrm = (editForm.FindControl("txtBxCPCmarfrm") as RadNumericTextBox);
        RadNumericTextBox txtBxCPCmartoo = (editForm.FindControl("txtBxCPCmartoo") as RadNumericTextBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidatePositionCiizensPayCodes('" +
                txtCPCsngfrm.ClientID + "','" +
                txtBxCPCsngtoo.ClientID + "','" +
                txtBxCPCmarfrm.ClientID + "','" +
                txtBxCPCmartoo.ClientID + "','" +
                ddlPayCode.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidatePositionCiizensPayCodes('" +
                txtCPCsngfrm.ClientID + "','" +
                txtBxCPCsngtoo.ClientID + "','" +
                txtBxCPCmarfrm.ClientID + "','" +
                txtBxCPCmartoo.ClientID + "','" +
                ddlPayCode.ClientID
                + "')");
        }
    }

    // client side validation function for citizen benefit code form input
    public void ValidatePositionCiizensBenefitCodes(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadComboBox ddlBenefitCode = (editForm.FindControl("ddlBenefitCode") as RadComboBox);
        RadNumericTextBox txtCBCsngfrm = (editForm.FindControl("txtCBCsngfrm") as RadNumericTextBox);
        RadNumericTextBox txtBxCBCsngtoo = (editForm.FindControl("txtBxCBCsngtoo") as RadNumericTextBox);
        RadNumericTextBox txtBxCBCmarfrm = (editForm.FindControl("txtBxCBCmarfrm") as RadNumericTextBox);
        RadNumericTextBox txtBxCBCmartoo = (editForm.FindControl("txtBxCBCmartoo") as RadNumericTextBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidatePositionCiizensBenefitCodes('" +
                txtCBCsngfrm.ClientID + "','" +
                txtBxCBCsngtoo.ClientID + "','" +
                txtBxCBCmarfrm.ClientID + "','" +
                txtBxCBCmartoo.ClientID + "','" +
                ddlBenefitCode.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidatePositionCiizensBenefitCodes('" +
                txtCBCsngfrm.ClientID + "','" +
                txtBxCBCsngtoo.ClientID + "','" +
                txtBxCBCmarfrm.ClientID + "','" +
                txtBxCBCmartoo.ClientID + "','" +
                ddlBenefitCode.ClientID
                + "')");
        }
    }

    // client side validation function for citizen deduction code form input
    public void ValidatePositionCiizensDeductionCodes(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadComboBox ddlDeductionCode = (editForm.FindControl("ddlDeductionCode") as RadComboBox);
        RadNumericTextBox txtCDCsngfrm = (editForm.FindControl("txtCDCsngfrm") as RadNumericTextBox);
        RadNumericTextBox txtBxCDCsngtoo = (editForm.FindControl("txtBxCDCsngtoo") as RadNumericTextBox);
        RadNumericTextBox txtBxCDCmarfrm = (editForm.FindControl("txtBxCDCmarfrm") as RadNumericTextBox);
        RadNumericTextBox txtBxCDCmartoo = (editForm.FindControl("txtBxCDCmartoo") as RadNumericTextBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidatePositionCiizensDeductionCodes('" +
                txtCDCsngfrm.ClientID + "','" +
                txtBxCDCsngtoo.ClientID + "','" +
                txtBxCDCmarfrm.ClientID + "','" +
                txtBxCDCmartoo.ClientID + "','" +
                ddlDeductionCode.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidatePositionCiizensDeductionCodes('" +
                txtCDCsngfrm.ClientID + "','" +
                txtBxCDCsngtoo.ClientID + "','" +
                txtBxCDCmarfrm.ClientID + "','" +
                txtBxCDCmartoo.ClientID + "','" +
                ddlDeductionCode.ClientID
                + "')");
        }
    }

    // client side validation function for expat paycode form input
    public void ValidatePositionExpatriatePayCodes(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadComboBox ddlPayCode = (editForm.FindControl("ddlPayCode") as RadComboBox);
        RadNumericTextBox txtEPCsngfrm = (editForm.FindControl("txtEPCsngfrm") as RadNumericTextBox);
        RadNumericTextBox txtBxEPCsngtoo = (editForm.FindControl("txtBxEPCsngtoo") as RadNumericTextBox);
        RadNumericTextBox txtBxEPCmarfrm = (editForm.FindControl("txtBxEPCmarfrm") as RadNumericTextBox);
        RadNumericTextBox txtBxEPCmartoo = (editForm.FindControl("txtBxEPCmartoo") as RadNumericTextBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidatePositionExpatriatePayCodes('" +
                txtEPCsngfrm.ClientID + "','" +
                txtBxEPCsngtoo.ClientID + "','" +
                txtBxEPCmarfrm.ClientID + "','" +
                txtBxEPCmartoo.ClientID + "','" +
                ddlPayCode.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidatePositionExpatriatePayCodes('" +
                txtEPCsngfrm.ClientID + "','" +
                txtBxEPCsngtoo.ClientID + "','" +
                txtBxEPCmarfrm.ClientID + "','" +
                txtBxEPCmartoo.ClientID + "','" +
                ddlPayCode.ClientID
                + "')");
        }
    }

    // client side validation function for expat benefit code form input
    public void ValidateExpatriateBenefitCodes(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadComboBox ddlBenefitCode = (editForm.FindControl("ddlBenefitCode") as RadComboBox);
        RadNumericTextBox txtEBCsngfrm = (editForm.FindControl("txtEBCsngfrm") as RadNumericTextBox);
        RadNumericTextBox txtBxEBCsngtoo = (editForm.FindControl("txtBxEBCsngtoo") as RadNumericTextBox);
        RadNumericTextBox txtBxEBCmarfrm = (editForm.FindControl("txtBxEBCmarfrm") as RadNumericTextBox);
        RadNumericTextBox txtBxEBCmartoo = (editForm.FindControl("txtBxEBCmartoo") as RadNumericTextBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidateExpatriateBenefitCodes('" +
                txtEBCsngfrm.ClientID + "','" +
                txtBxEBCsngtoo.ClientID + "','" +
                txtBxEBCmarfrm.ClientID + "','" +
                txtBxEBCmartoo.ClientID + "','" +
                ddlBenefitCode.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateExpatriateBenefitCodes('" +
                txtEBCsngfrm.ClientID + "','" +
                txtBxEBCsngtoo.ClientID + "','" +
                txtBxEBCmarfrm.ClientID + "','" +
                txtBxEBCmartoo.ClientID + "','" +
                ddlBenefitCode.ClientID
                + "')");
        }
    }

    // client side validation function for expat deduction code for input
    public void ValidateExpatriateDeductionCodes(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadComboBox ddlDeductionCode = (editForm.FindControl("ddlDeductionCode") as RadComboBox);
        RadNumericTextBox txtEDCsngfrm = (editForm.FindControl("txtEDCsngfrm") as RadNumericTextBox);
        RadNumericTextBox txtBxEDCsngtoo = (editForm.FindControl("txtBxEDCsngtoo") as RadNumericTextBox);
        RadNumericTextBox txtBxEDCmarfrm = (editForm.FindControl("txtBxEDCmarfrm") as RadNumericTextBox);
        RadNumericTextBox txtBxEDCmartoo = (editForm.FindControl("txtBxEDCmartoo") as RadNumericTextBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidateExpatriateDeductionCodes('" +
                txtEDCsngfrm.ClientID + "','" +
                txtBxEDCsngtoo.ClientID + "','" +
                txtBxEDCmarfrm.ClientID + "','" +
                txtBxEDCmartoo.ClientID + "','" +
                ddlDeductionCode.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateExpatriateDeductionCodes('" +
                txtEDCsngfrm.ClientID + "','" +
                txtBxEDCsngtoo.ClientID + "','" +
                txtBxEDCmarfrm.ClientID + "','" +
                txtBxEDCmartoo.ClientID + "','" +
                ddlDeductionCode.ClientID
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

    // form setting for insert/update
    protected void gvPosition_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            if (e.Item.OwnerTableView.DataMember == "PositionMaster")
            {
                ValidatePosition(e);
                if (e.Item.OwnerTableView.IsItemInserted)
                {
                    #region  item is about to be inserted

                    GridEditableItem insertedItem = (GridEditableItem)e.Item;

                    RadComboBox ddlPositionType = (RadComboBox)insertedItem.FindControl("ddlPositionType");
                    //RadComboBox ddlGarnismentCategory = (RadComboBox)insertedItem.FindControl("ddlGarnismentCategory");
                    RadComboBox ddlMethod = (RadComboBox)insertedItem.FindControl("ddlMethod");
                    RadComboBox ddlposPeriod = (RadComboBox)insertedItem.FindControl("ddlposPeriod");
                    RadComboBox ddlNewEmoloyeeAnualLeave = (RadComboBox)insertedItem.FindControl("ddlNewEmoloyeeAnualLeave");
                    RadComboBox ddlPosition = (RadComboBox)insertedItem.FindControl("ddlPosition");

                    if (ddlPositionType != null)
                    {
                        RadGrid grid = ddlPositionType.Items[0].FindControl("rposPositionType4DDL") as RadGrid;
                        grid.Rebind();
                    }
                    if (ddlposPeriod != null)
                    {
                        RadGrid grid = ddlposPeriod.Items[0].FindControl("rposposPeriod4DDL") as RadGrid;
                        grid.Rebind();
                    }
                    if (ddlMethod != null)
                    {
                        RadGrid grid = ddlMethod.Items[0].FindControl("rposMethod4DDL") as RadGrid;
                        grid.Rebind();
                    }
                    if (ddlPosition != null)
                    {
                        Hashtable ht_filters = new Hashtable();
                        DataTable dt_Reports = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_Position_posords", ht_filters).Tables[0];
                        ddlPosition.DataSource = dt_Reports;
                        ddlPosition.DataTextField = "poscod";
                        ddlPosition.DataValueField = "recidd";
                        ddlPosition.DataBind();
                        ddlPosition.SelectedIndex = 0;
                    }
                    #endregion
                }
                else
                {
                    #region item is about to be edited
                    GridEditableItem editedItem = (GridEditableItem)e.Item;

                    RadComboBox ddlPositionCode = (RadComboBox)editedItem.FindControl("ddlPositionCode");
                    HiddenField hfPositionCodedllID = (HiddenField)editedItem.FindControl("hfPositionCodedllID");
                    HiddenField hfPositionCodedllText = (HiddenField)editedItem.FindControl("hfPositionCodedllText");

                    if (ddlPositionCode != null)
                    {
                        RadGrid grid = ddlPositionCode.Items[0].FindControl("rposPositionCode4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfPositionCodedllID.Value) && !string.IsNullOrEmpty(hfPositionCodedllText.Value))
                        {
                            ddlPositionCode.Items[0].Value = hfPositionCodedllID.Value;
                            ddlPositionCode.Items[0].Text = hfPositionCodedllText.Value;
                            ddlPositionCode.Text = hfPositionCodedllText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfPositionCodedllID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["ValueSetID"].ToString()))
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
                        RadGrid grid = ddlTicketClass.Items[0].FindControl("rposTicketClass4DDL") as RadGrid;
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

                    RadComboBox ddlCalender = (RadComboBox)editedItem.FindControl("ddlCalender");
                    HiddenField hfCalenderdllID = (HiddenField)editedItem.FindControl("hfCalenderdllID");
                    HiddenField hfCalenderdllText = (HiddenField)editedItem.FindControl("hfCalenderdllText");

                    if (ddlCalender != null)
                    {
                        RadGrid grid = ddlCalender.Items[0].FindControl("rposCalender4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfCalenderdllID.Value) && !string.IsNullOrEmpty(hfCalenderdllText.Value))
                        {
                            ddlCalender.Items[0].Value = hfCalenderdllID.Value;
                            ddlCalender.Items[0].Text = hfCalenderdllText.Value;
                            ddlCalender.Text = hfCalenderdllText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfCalenderdllID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
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
                        RadGrid grid = ddlLeave.Items[0].FindControl("rposLeave4DDL") as RadGrid;
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

                    RadComboBox ddlOvertime = (RadComboBox)editedItem.FindControl("ddlOvertime");
                    HiddenField hfOvertimedllID = (HiddenField)editedItem.FindControl("hfOvertimedllID");
                    HiddenField hfOvertimedllText = (HiddenField)editedItem.FindControl("hfOvertimedllText");

                    if (ddlOvertime != null)
                    {
                        RadGrid grid = ddlOvertime.Items[0].FindControl("rposOvertime4DDL") as RadGrid;
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

                    RadComboBox ddlGratuityPro = (RadComboBox)editedItem.FindControl("ddlGratuityPro");
                    HiddenField hfGratuityProdllID = (HiddenField)editedItem.FindControl("hfGratuityProdllID");
                    HiddenField hfGratuityProdllText = (HiddenField)editedItem.FindControl("hfGratuityProdllText");

                    if (ddlGratuityPro != null)
                    {
                        RadGrid grid = ddlGratuityPro.Items[0].FindControl("rposGraduityProv4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfGratuityProdllID.Value) && !string.IsNullOrEmpty(hfGratuityProdllText.Value))
                        {
                            ddlGratuityPro.Items[0].Value = hfGratuityProdllID.Value;
                            ddlGratuityPro.Items[0].Text = hfGratuityProdllText.Value;
                            ddlGratuityPro.Text = hfGratuityProdllText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfGratuityProdllID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    RadComboBox ddlGraduity = (RadComboBox)editedItem.FindControl("ddlGraduity");
                    HiddenField hfGraduitydllID = (HiddenField)editedItem.FindControl("hfGraduitydllID");
                    HiddenField hfGraduitydllText = (HiddenField)editedItem.FindControl("hfGraduitydllText");

                    if (ddlGraduity != null)
                    {
                        RadGrid grid = ddlGraduity.Items[0].FindControl("rposGraduity4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfGraduitydllID.Value) && !string.IsNullOrEmpty(hfGraduitydllText.Value))
                        {
                            ddlGraduity.Items[0].Value = hfGraduitydllID.Value;
                            ddlGraduity.Items[0].Text = hfGraduitydllText.Value;
                            ddlGraduity.Text = hfGraduitydllText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfGraduitydllID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
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
            else if (e.Item.OwnerTableView.DataMember == "CiizensPayCodes")
            {
                ValidatePositionCiizensPayCodes(e);
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

                    RadComboBox ddlPayCode = (RadComboBox)editedItem.FindControl("ddlPayCode");
                    HiddenField hfddlPayCodeId = (HiddenField)editedItem.FindControl("hfddlPayCodeId");
                    HiddenField hfddlPayCodeText = (HiddenField)editedItem.FindControl("hfddlPayCodeText");

                    if (ddlPayCode != null)
                    {
                        RadGrid grid = ddlPayCode.Items[0].FindControl("rGrdPayCode4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfddlPayCodeId.Value) && !string.IsNullOrEmpty(hfddlPayCodeText.Value))
                        {
                            ddlPayCode.Items[0].Value = hfddlPayCodeId.Value;
                            ddlPayCode.Items[0].Text = hfddlPayCodeText.Value;
                            ddlPayCode.Text = hfddlPayCodeText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfddlPayCodeId.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
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
            else if (e.Item.OwnerTableView.DataMember == "CiizensBenefitCodes")
            {
                ValidatePositionCiizensBenefitCodes(e);

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

                    RadComboBox ddlBenefitCode = (RadComboBox)editedItem.FindControl("ddlBenefitCode");
                    HiddenField hfddlBenefitCodeID = (HiddenField)editedItem.FindControl("hfddlBenefitCodeID");
                    HiddenField hfddlBenefitCodeText = (HiddenField)editedItem.FindControl("hfddlBenefitCodeText");

                    if (ddlBenefitCode != null)
                    {
                        RadGrid grid = ddlBenefitCode.Items[0].FindControl("rGrdBenefitCode4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfddlBenefitCodeID.Value) && !string.IsNullOrEmpty(hfddlBenefitCodeText.Value))
                        {
                            ddlBenefitCode.Items[0].Value = hfddlBenefitCodeID.Value;
                            ddlBenefitCode.Items[0].Text = hfddlBenefitCodeText.Value;
                            ddlBenefitCode.Text = hfddlBenefitCodeText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfddlBenefitCodeID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
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
            else if (e.Item.OwnerTableView.DataMember == "CiizensDeductionCodes")
            {
                ValidatePositionCiizensDeductionCodes(e);

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

                    RadComboBox ddlDeductionCode = (RadComboBox)editedItem.FindControl("ddlDeductionCode");
                    HiddenField hfddlDeductionCodeID = (HiddenField)editedItem.FindControl("hfddlDeductionCodeID");
                    HiddenField hfddlDeductionCodeText = (HiddenField)editedItem.FindControl("hfddlDeductionCodeText");

                    if (ddlDeductionCode != null)
                    {
                        RadGrid grid = ddlDeductionCode.Items[0].FindControl("rGrdDeductionCode4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfddlDeductionCodeID.Value) && !string.IsNullOrEmpty(hfddlDeductionCodeText.Value))
                        {
                            ddlDeductionCode.Items[0].Value = hfddlDeductionCodeID.Value;
                            ddlDeductionCode.Items[0].Text = hfddlDeductionCodeText.Value;
                            ddlDeductionCode.Text = hfddlDeductionCodeText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfddlDeductionCodeID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
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
            else if (e.Item.OwnerTableView.DataMember == "CitizenContributionCodes")
            {
                if (e.Item.OwnerTableView.IsItemInserted)
                {
                    #region  item is about to be inserted

                    GridEditableItem insertedItem = (GridEditableItem)e.Item;
                    RadComboBox ddlContributionCode = (RadComboBox)insertedItem.FindControl("ddlContributionCode");
                    HiddenField hfPositionId = (HiddenField)insertedItem.FindControl("hfPositionId");
                    if (hfPositionId.Value == "")
                        hfPositionId.Value = e.Item.OwnerTableView.ParentItem.OwnerTableView.ParentItem.GetDataKeyValue("recidd").ToString();

                    if (ddlContributionCode != null)
                    {
                        if (hfPositionId != null)
                        {
                            Int32 ID = Convert.ToInt32(hfPositionId.Value);
                            Hashtable ht = new Hashtable();
                            ht.Add("@PositionID", ID);
                            DataTable dt_ContributionCodes = clsDAL.GetDataSet_Payroll("sp_Payroll_GetPositionContributionCodesCitizens", ht).Tables[0];

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

                    HiddenField hfPositionId = (HiddenField)editedItem.FindControl("hfPositionId");
                    if (hfPositionId.Value == "")
                        hfPositionId.Value = e.Item.OwnerTableView.ParentItem.GetDataKeyValue("recidd").ToString();

                    if (ddlContributionCode != null)
                    {
                        if (hfPositionId != null)
                        {
                            Int32 ID = Convert.ToInt32(hfPositionId.Value);
                            Hashtable ht = new Hashtable();
                            ht.Add("@PositionID", ID);
                            DataTable dt_ContributionCodes = clsDAL.GetDataSet_Payroll("sp_Payroll_GetPositionContributionCodesCitizens", ht).Tables[0];

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
            else if (e.Item.OwnerTableView.DataMember == "ExpatriatePayCodes")
            {
                ValidatePositionExpatriatePayCodes(e);

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

                    RadComboBox ddlPayCode = (RadComboBox)editedItem.FindControl("ddlPayCode");
                    HiddenField hfddlPayCodeId = (HiddenField)editedItem.FindControl("hfddlPayCodeId");
                    HiddenField hfddlPayCodeText = (HiddenField)editedItem.FindControl("hfddlPayCodeText");

                    if (ddlPayCode != null)
                    {
                        RadGrid grid = ddlPayCode.Items[0].FindControl("rGrdPayCode4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfddlPayCodeId.Value) && !string.IsNullOrEmpty(hfddlPayCodeText.Value))
                        {
                            ddlPayCode.Items[0].Value = hfddlPayCodeId.Value;
                            ddlPayCode.Items[0].Text = hfddlPayCodeText.Value;
                            ddlPayCode.Text = hfddlPayCodeText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfddlPayCodeId.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
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
            else if (e.Item.OwnerTableView.DataMember == "ExpatriateBenefitCodes")
            {
                ValidateExpatriateBenefitCodes(e);

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

                    RadComboBox ddlBenefitCode = (RadComboBox)editedItem.FindControl("ddlBenefitCode");
                    HiddenField hfddlBenefitCodeID = (HiddenField)editedItem.FindControl("hfddlBenefitCodeID");
                    HiddenField hfddlBenefitCodeText = (HiddenField)editedItem.FindControl("hfddlBenefitCodeText");

                    if (ddlBenefitCode != null)
                    {
                        RadGrid grid = ddlBenefitCode.Items[0].FindControl("rGrdBenefitCode4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfddlBenefitCodeID.Value) && !string.IsNullOrEmpty(hfddlBenefitCodeText.Value))
                        {
                            ddlBenefitCode.Items[0].Value = hfddlBenefitCodeID.Value;
                            ddlBenefitCode.Items[0].Text = hfddlBenefitCodeText.Value;
                            ddlBenefitCode.Text = hfddlBenefitCodeText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfddlBenefitCodeID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
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
            else if (e.Item.OwnerTableView.DataMember == "ExpatriateDeductionCodes")
            {
                ValidateExpatriateDeductionCodes(e);

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

                    RadComboBox ddlDeductionCode = (RadComboBox)editedItem.FindControl("ddlDeductionCode");
                    HiddenField hfddlDeductionCodeID = (HiddenField)editedItem.FindControl("hfddlDeductionCodeID");
                    HiddenField hfddlDeductionCodeText = (HiddenField)editedItem.FindControl("hfddlDeductionCodeText");

                    if (ddlDeductionCode != null)
                    {
                        RadGrid grid = ddlDeductionCode.Items[0].FindControl("rGrdDeductionCode4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfddlDeductionCodeID.Value) && !string.IsNullOrEmpty(hfddlDeductionCodeText.Value))
                        {
                            ddlDeductionCode.Items[0].Value = hfddlDeductionCodeID.Value;
                            ddlDeductionCode.Items[0].Text = hfddlDeductionCodeText.Value;
                            ddlDeductionCode.Text = hfddlDeductionCodeText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfddlDeductionCodeID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
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
            else if (e.Item.OwnerTableView.DataMember == "ExpatriateContributionCodes")
            {
                if (e.Item.OwnerTableView.IsItemInserted)
                {
                    #region  item is about to be inserted

                    GridEditableItem insertedItem = (GridEditableItem)e.Item;
                    RadComboBox ddlContributionCode = (RadComboBox)insertedItem.FindControl("ddlContributionCode");
                    HiddenField hfPositionId = (HiddenField)insertedItem.FindControl("hfPositionId");
                    if (hfPositionId.Value == "")
                        hfPositionId.Value = e.Item.OwnerTableView.ParentItem.OwnerTableView.ParentItem.GetDataKeyValue("recidd").ToString();

                    if (ddlContributionCode != null)
                    {
                        if (hfPositionId != null)
                        {
                            Int32 ID = Convert.ToInt32(hfPositionId.Value);
                            Hashtable ht = new Hashtable();
                            ht.Add("@PositionID", ID);
                            DataTable dt_ContributionCodes = clsDAL.GetDataSet_Payroll("sp_Payroll_GetPositionContributionCodesExpatriate", ht).Tables[0];

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

                    HiddenField hfPositionId = (HiddenField)editedItem.FindControl("hfPositionId");
                    if (hfPositionId.Value == "")
                        hfPositionId.Value = e.Item.OwnerTableView.ParentItem.GetDataKeyValue("recidd").ToString();

                    if (ddlContributionCode != null)
                    {
                        if (hfPositionId != null)
                        {
                            Int32 ID = Convert.ToInt32(hfPositionId.Value);
                            Hashtable ht = new Hashtable();
                            ht.Add("@PositionID", ID);
                            DataTable dt_ContributionCodes = clsDAL.GetDataSet_Payroll("sp_Payroll_GetPositionContributionCodesExpatriate", ht).Tables[0];

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
            else if (e.Item.OwnerTableView.DataMember == "ExpatriateLoanRecords")
            {
                ValidateLoan(e);
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
            else if (e.Item.OwnerTableView.DataMember == "CitizenLoanRecords")
            {
                ValidateLoan(e);
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
    protected void gvPosition_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (exporting && e.Item.ItemType == Telerik.Web.UI.GridItemType.FilteringItem)
        {
            e.Item.Visible = false;
        }
    }

    // clear form fields for insert/update
    // grid export setting
    protected void gvPosition_ItemCommand(object sender, GridCommandEventArgs e)
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
            //grid.ExportSettings.HideStructuposolumns = true;

            foreach (GridDataItem item in grid.Items)
            {
                item["ExpandColumn"].Visible = false;
            }

            if (e.Item.OwnerTableView.DataMember == "PositionMaster")
            {
                grid.MasterTableView.GetColumn("Editposcod").Visible = false;
                grid.MasterTableView.GetColumn("Deleteposcod").Visible = false;
            }
            else if (e.Item.OwnerTableView.DataMember == "Citizens")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "Expatriate")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "CiizensPayCodes")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "CiizensBenefitCodes")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "CiizensDeductionCodes")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "CitizenContributionCodes")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "ExpatriatePayCodes")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "ExpatriateBenefitCodes")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "ExpatriateDeductionCodes")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "ExpatriateContributionCodes")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "ExpatriateLoanRecords")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "CitizenLoanRecords")
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
            if (e.Item.OwnerTableView.DataMember == "PositionMaster")
            {
                grid.MasterTableView.GetColumn("Editposcod").Visible = false;
                grid.MasterTableView.GetColumn("Deleteposcod").Visible = false;
            }
            else if (e.Item.OwnerTableView.DataMember == "Citizens")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "Expatriate")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "CiizensPayCodes")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "CiizensBenefitCodes")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "CiizensDeductionCodes")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "CitizenContributionCodes")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "ExpatriatePayCodes")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "ExpatriateBenefitCodes")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "ExpatriateDeductionCodes")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "ExpatriateContributionCodes")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "ExpatriateLoanRecords")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "CitizenLoanRecords")
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
            if (e.Item.OwnerTableView.DataMember == "PositionMaster")
            {
                grid.MasterTableView.GetColumn("Editposcod").Visible = false;
                grid.MasterTableView.GetColumn("Deleteposcod").Visible = false;
            }
            else if (e.Item.OwnerTableView.DataMember == "Citizens")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "Expatriate")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "CiizensPayCodes")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "CiizensBenefitCodes")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "CiizensDeductionCodes")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "CitizenContributionCodes")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "ExpatriatePayCodes")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "ExpatriateBenefitCodes")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "ExpatriateDeductionCodes")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "ExpatriateContributionCodes")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "ExpatriateLoanRecords")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "CitizenLoanRecords")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }

            grid.MasterTableView.ExportToPdf();
        }
        if (e.CommandName == "Print")
        {
            Button btnPrint = (Button)e.Item.FindControl("btnPositionPrint");
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
                if (column.UniqueName == "Deleteposcod" || column.UniqueName == "Editposcod")
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
                if (column.UniqueName == "EditContributionCode" || column.UniqueName == "DeleteContributionCode")
                {
                    column.Display = false;
                    column.Visible = false;
                }
                if (column.UniqueName == "EditLoanRecords" || column.UniqueName == "DeleteLoanRecords")
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
    protected void gvPosition_InsertCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_User(ref e, "Insert");
    }

    // insert/udpate function
    private void Insert_or_Update_User(ref GridCommandEventArgs e, string operation)
    {
        GridEditableItem editedItem = e.Item as GridEditableItem;
        try
        {
            if (e.Item.OwnerTableView.DataMember == "PositionMaster")
            {
                #region Grid Master
                //Insert new values
                Hashtable newValues = new Hashtable();
                if (operation == "Update")
                {
                    newValues["@recidd"] = (int)editedItem.GetDataKeyValue("recidd");
                }
                newValues["@poscod"] = (editedItem.FindControl("txtPositionCode") as RadTextBox).Text.Trim();
                newValues["@posds1"] = (editedItem.FindControl("txtDescription") as RadTextBox).Text;
                newValues["@posds2"] = (editedItem.FindControl("txtArabicDescription") as RadTextBox).Text;
                newValues["@postcc"] = (editedItem.FindControl("ddlTicketClass") as RadComboBox).Items[0].Value.Trim();
                newValues["@poscli"] = (editedItem.FindControl("ddlCalender") as RadComboBox).Items[0].Value.Trim();
                newValues["@posgri"] = (editedItem.FindControl("ddlGraduity") as RadComboBox).Items[0].Value.Trim();
                newValues["@posgpi"] = (editedItem.FindControl("ddlGratuityPro") as RadComboBox).Items[0].Value.Trim();
                newValues["@posovi"] = (editedItem.FindControl("ddlOvertime") as RadComboBox).Items[0].Value.Trim();
                newValues["@posani"] = (editedItem.FindControl("ddlLeave") as RadComboBox).Items[0].Value.Trim();

                newValues["@DBMessage"] = "";

                string DBMessage = "";

                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Insert_Position", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Update_Position", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                else
                {
                    gvPosition.Rebind();
                    ShowClientMessage("Position record save successfully.", MessageType.Success);
                }
                
                #endregion
            }
            else if (e.Item.OwnerTableView.DataMember == "CiizensPayCodes")
            {
                #region Citizen Pay Code
                //Insert new values
                Hashtable newValues = new Hashtable();

                if (operation == "Update")
                {
                    newValues["@recidd"] = (int)editedItem.GetDataKeyValue("recidd");
                }
                GridDataItem parentItem = (GridDataItem)(e.Item.OwnerTableView.ParentItem);
                if (parentItem != null)
                {
                    GridDataItem secondParentItem = (GridDataItem)parentItem.OwnerTableView.ParentItem;
                    if (secondParentItem != null)
                        newValues["@posidd"] = Convert.ToInt32(secondParentItem.OwnerTableView.DataKeyValues[secondParentItem.ItemIndex]["recidd"].ToString());
                }
                newValues["@postyp"] = 1; // type 1 for citizen
                newValues["@poscdtyp"] = 1; // code type 1 for paycode
                newValues["@pospci"] = (editedItem.FindControl("ddlPayCode") as RadComboBox).Items[0].Value.Trim();
                newValues["@possfrm"] = (editedItem.FindControl("txtCPCsngfrm") as RadNumericTextBox).Text;
                newValues["@possto"] = (editedItem.FindControl("txtBxCPCsngtoo") as RadNumericTextBox).Text;
                newValues["@posmfrm"] = (editedItem.FindControl("txtBxCPCmarfrm") as RadNumericTextBox).Text;
                newValues["@posmto"] = (editedItem.FindControl("txtBxCPCmartoo") as RadNumericTextBox).Text;

                newValues["@DBMessage"] = "";

                string DBMessage = "";

                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Insert_Position_Citizen_PayCode", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Update_Position_Citizen_PayCode", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                else
                {
                    ShowClientMessage("Citizen Paycode saved successfully.", MessageType.Success);
                }
                #endregion
            }
            else if (e.Item.OwnerTableView.DataMember == "CiizensBenefitCodes")
            {
                #region Citizen Benefit Code
                //Insert new values
                Hashtable newValues = new Hashtable();

                if (operation == "Update")
                {
                    newValues["@recidd"] = (int)editedItem.GetDataKeyValue("recidd");
                }
                GridDataItem parentItem = (GridDataItem)(e.Item.OwnerTableView.ParentItem);
                if (parentItem != null)
                {
                    GridDataItem secondParentItem = (GridDataItem)parentItem.OwnerTableView.ParentItem;
                    if (secondParentItem != null)
                        newValues["@posidd"] = Convert.ToInt32(secondParentItem.OwnerTableView.DataKeyValues[secondParentItem.ItemIndex]["recidd"].ToString());
                }
                newValues["@postyp"] = 1; // type 1 for citizen
                newValues["@poscdtyp"] = 2; // code type 2 for benefit code
                newValues["@posbni"] = (editedItem.FindControl("ddlBenefitCode") as RadComboBox).Items[0].Value.Trim();
                newValues["@possfrm"] = (editedItem.FindControl("txtCBCsngfrm") as RadNumericTextBox).Text;
                newValues["@possto"] = (editedItem.FindControl("txtBxCBCsngtoo") as RadNumericTextBox).Text;
                newValues["@posmfrm"] = (editedItem.FindControl("txtBxCBCmarfrm") as RadNumericTextBox).Text;
                newValues["@posmto"] = (editedItem.FindControl("txtBxCBCmartoo") as RadNumericTextBox).Text;

                newValues["@DBMessage"] = "";

                string DBMessage = "";

                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Insert_Position_Citizen_BenefitCode", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Update_Position_Citizen_BenefitCode", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                else
                {
                    ShowClientMessage("Citizen Benefit code saved successfully.", MessageType.Success);
                }
                #endregion
            }
            else if (e.Item.OwnerTableView.DataMember == "CiizensDeductionCodes")
            {
                #region Citizen Deduction Code
                //Insert new values
                Hashtable newValues = new Hashtable();

                if (operation == "Update")
                {
                    newValues["@recidd"] = (int)editedItem.GetDataKeyValue("recidd");
                }
                GridDataItem parentItem = (GridDataItem)(e.Item.OwnerTableView.ParentItem);
                if (parentItem != null)
                {
                    GridDataItem secondParentItem = (GridDataItem)parentItem.OwnerTableView.ParentItem;
                    if (secondParentItem != null)
                        newValues["@posidd"] = Convert.ToInt32(secondParentItem.OwnerTableView.DataKeyValues[secondParentItem.ItemIndex]["recidd"].ToString());
                }
                newValues["@postyp"] = 1; // type 1 for citizen
                newValues["@poscdtyp"] = 3; // code type 3 for deduction code
                newValues["@posddi"] = (editedItem.FindControl("ddlDeductionCode") as RadComboBox).Items[0].Value.Trim();
                newValues["@possfrm"] = (editedItem.FindControl("txtCDCsngfrm") as RadNumericTextBox).Text;
                newValues["@possto"] = (editedItem.FindControl("txtBxCDCsngtoo") as RadNumericTextBox).Text;
                newValues["@posmfrm"] = (editedItem.FindControl("txtBxCDCmarfrm") as RadNumericTextBox).Text;
                newValues["@posmto"] = (editedItem.FindControl("txtBxCDCmartoo") as RadNumericTextBox).Text;

                newValues["@DBMessage"] = "";

                string DBMessage = "";

                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Insert_Position_Citizen_DeductionCode", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Update_Position_Citizen_DeductionCode", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                else
                {
                    ShowClientMessage("Citizen Deduction saved successfully.", MessageType.Success);
                }
                #endregion
            }
            else if (e.Item.OwnerTableView.DataMember == "CitizenContributionCodes")
            {
                #region Citizen Contribution Code
                //Insert new values
                Hashtable newValues = new Hashtable();

                GridDataItem parentItem = (GridDataItem)(e.Item.OwnerTableView.ParentItem);
                if (parentItem != null)
                {
                    GridDataItem secondParentItem = (GridDataItem)parentItem.OwnerTableView.ParentItem;
                    if (secondParentItem != null)
                        newValues["@posidd"] = Convert.ToInt32(secondParentItem.OwnerTableView.DataKeyValues[secondParentItem.ItemIndex]["recidd"].ToString());

                    newValues["@postyp"] = 1; // emptype 1 for citizen
                    newValues["@postyd"] = "Citizen";

                    RadComboBox ddlContributionCode = (editedItem.FindControl("ddlContributionCode") as RadComboBox);
                    if (ddlContributionCode != null)
                    {
                        if (ddlContributionCode.Items.Count > 0)
                        {
                            RadGrid rgContributionCodes = (ddlContributionCode.Items[0].FindControl("rGrdContributionCode4DDL") as RadGrid);
                            if (rgContributionCodes.SelectedItems.Count > 0)
                            {
                                #region delete old records

                                Hashtable ht = new Hashtable();
                                ht.Add("@posIdd", Convert.ToInt32(secondParentItem.OwnerTableView.DataKeyValues[secondParentItem.ItemIndex]["recidd"].ToString()));
                                ht.Add("@postyp", newValues["@postyp"]);

                                clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Position_Citizen_ContributionCodes", ht);

                                #endregion

                                foreach (GridDataItem dataItem in rgContributionCodes.SelectedItems)
                                {
                                    newValues["@cntidd"] = Convert.ToInt32(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString());
                                    newValues["@DBMessage"] = "";

                                    string DBMessage = "";
                                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_PositionContributionCode", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
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
            else if (e.Item.OwnerTableView.DataMember == "CitizenLoanRecords")
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
                    GridDataItem secondParentItem = (GridDataItem)parentItem.OwnerTableView.ParentItem;
                    if (secondParentItem != null)
                        newValues["@posidd"] = Convert.ToInt32(secondParentItem.OwnerTableView.DataKeyValues[secondParentItem.ItemIndex]["recidd"].ToString());

                    newValues["@postyp"] = 1; // emptype 1 for citizen
                    newValues["@postyd"] = "Citizen";

                    newValues["@lonidd"] = (editedItem.FindControl("ddlLoanCode") as RadComboBox).Items[0].Value.Trim();
                    newValues["@lonmax"] = (editedItem.FindControl("txtbxMaxLoanAmount") as RadNumericTextBox).Text;

                    newValues["@DBMessage"] = "";

                    string DBMessage = "";

                    if (operation == "Insert")
                    {
                        DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Insert_Position_Loan", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                    }
                    else if (operation == "Update")
                    {
                        DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Update_Position_Loan", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                    }
                    if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                    {
                        ShowClientMessage(DBMessage, MessageType.Error);
                        e.Canceled = true;
                    }
                    else
                    {
                        ShowClientMessage("Citizen Loan Code save successfully.", MessageType.Success);
                    }
                }
                #endregion
            }
            else if (e.Item.OwnerTableView.DataMember == "ExpatriatePayCodes")
            {
                #region Expatriate Pay Code
                //Insert new values
                Hashtable newValues = new Hashtable();

                if (operation == "Update")
                {
                    newValues["@recidd"] = (int)editedItem.GetDataKeyValue("recidd");
                }
                GridDataItem parentItem = (GridDataItem)(e.Item.OwnerTableView.ParentItem);
                if (parentItem != null)
                {
                    GridDataItem secondParentItem = (GridDataItem)parentItem.OwnerTableView.ParentItem;
                    if (secondParentItem != null)
                        newValues["@posidd"] = Convert.ToInt32(secondParentItem.OwnerTableView.DataKeyValues[secondParentItem.ItemIndex]["recidd"].ToString());
                }
                newValues["@postyp"] = 0; // type 0 for Expatriate
                newValues["@poscdtyp"] = 1; // code type 1 for paycode
                newValues["@pospci"] = (editedItem.FindControl("ddlPayCode") as RadComboBox).Items[0].Value.Trim();
                newValues["@possfrm"] = (editedItem.FindControl("txtEPCsngfrm") as RadNumericTextBox).Text;
                newValues["@possto"] = (editedItem.FindControl("txtBxEPCsngtoo") as RadNumericTextBox).Text;
                newValues["@posmfrm"] = (editedItem.FindControl("txtBxEPCmarfrm") as RadNumericTextBox).Text;
                newValues["@posmto"] = (editedItem.FindControl("txtBxEPCmartoo") as RadNumericTextBox).Text;

                newValues["@DBMessage"] = "";

                string DBMessage = "";

                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Insert_Position_Expatriate_PayCode", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Update_Position_Expatriate_PayCode", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                else
                {
                    ShowClientMessage("Expatriate Paycode saved successfully.", MessageType.Success);
                }
                #endregion
            }
            else if (e.Item.OwnerTableView.DataMember == "ExpatriateBenefitCodes")
            {
                #region Expatriate Benefit Code
                //Insert new values
                Hashtable newValues = new Hashtable();

                if (operation == "Update")
                {
                    newValues["@recidd"] = (int)editedItem.GetDataKeyValue("recidd");
                }
                GridDataItem parentItem = (GridDataItem)(e.Item.OwnerTableView.ParentItem);
                if (parentItem != null)
                {
                    GridDataItem secondParentItem = (GridDataItem)parentItem.OwnerTableView.ParentItem;
                    if (secondParentItem != null)
                        newValues["@posidd"] = Convert.ToInt32(secondParentItem.OwnerTableView.DataKeyValues[secondParentItem.ItemIndex]["recidd"].ToString());
                }
                newValues["@postyp"] = 0; // type 0 for Expatriate
                newValues["@poscdtyp"] = 2; // code type 2 for benefit code
                newValues["@posbni"] = (editedItem.FindControl("ddlBenefitCode") as RadComboBox).Items[0].Value.Trim();
                newValues["@possfrm"] = (editedItem.FindControl("txtEBCsngfrm") as RadNumericTextBox).Text;
                newValues["@possto"] = (editedItem.FindControl("txtBxEBCsngtoo") as RadNumericTextBox).Text;
                newValues["@posmfrm"] = (editedItem.FindControl("txtBxEBCmarfrm") as RadNumericTextBox).Text;
                newValues["@posmto"] = (editedItem.FindControl("txtBxEBCmartoo") as RadNumericTextBox).Text;

                newValues["@DBMessage"] = "";

                string DBMessage = "";

                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Insert_Position_Expatriate_BenefitCode", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Update_Position_Expatriate_BenefitCode", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                else
                {
                    ShowClientMessage("Expatriate Benefit code saved successfully.", MessageType.Success);
                }
                #endregion
            }
            else if (e.Item.OwnerTableView.DataMember == "ExpatriateDeductionCodes")
            {
                #region Expatriate Deduction Code
                //Insert new values
                Hashtable newValues = new Hashtable();

                if (operation == "Update")
                {
                    newValues["@recidd"] = (int)editedItem.GetDataKeyValue("recidd");
                }
                GridDataItem parentItem = (GridDataItem)(e.Item.OwnerTableView.ParentItem);
                if (parentItem != null)
                {
                    GridDataItem secondParentItem = (GridDataItem)parentItem.OwnerTableView.ParentItem;
                    if (secondParentItem != null)
                        newValues["@posidd"] = Convert.ToInt32(secondParentItem.OwnerTableView.DataKeyValues[secondParentItem.ItemIndex]["recidd"].ToString());
                }
                newValues["@postyp"] = 0; // emptype 0 for Expatriate
                newValues["@poscdtyp"] = 3; // code type 3 for deduction code
                newValues["@posddi"] = (editedItem.FindControl("ddlDeductionCode") as RadComboBox).Items[0].Value.Trim();
                newValues["@possfrm"] = (editedItem.FindControl("txtEDCsngfrm") as RadNumericTextBox).Text;
                newValues["@possto"] = (editedItem.FindControl("txtBxEDCsngtoo") as RadNumericTextBox).Text;
                newValues["@posmfrm"] = (editedItem.FindControl("txtBxEDCmarfrm") as RadNumericTextBox).Text;
                newValues["@posmto"] = (editedItem.FindControl("txtBxEDCmartoo") as RadNumericTextBox).Text;

                newValues["@DBMessage"] = "";

                string DBMessage = "";

                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Insert_Position_Expatriate_DeductionCode", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Update_Position_Expatriate_DeductionCode", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                else
                {
                    ShowClientMessage("Expatriate Deduction saved successfully.", MessageType.Success);
                }
                #endregion
            }
            else if (e.Item.OwnerTableView.DataMember == "ExpatriateContributionCodes")
            {
                #region Expatriate Contribution Code
                //Insert new values
                Hashtable newValues = new Hashtable();

                GridDataItem parentItem = (GridDataItem)(e.Item.OwnerTableView.ParentItem);
                if (parentItem != null)
                {
                    GridDataItem secondParentItem = (GridDataItem)parentItem.OwnerTableView.ParentItem;
                    if (secondParentItem != null)
                        newValues["@posidd"] = Convert.ToInt32(secondParentItem.OwnerTableView.DataKeyValues[secondParentItem.ItemIndex]["recidd"].ToString());

                    newValues["@postyp"] = 0; // emptype 0 for expatriate
                    newValues["@postyd"] = "Expatriate";

                    RadComboBox ddlContributionCode = (editedItem.FindControl("ddlContributionCode") as RadComboBox);
                    if (ddlContributionCode != null)
                    {
                        if (ddlContributionCode.Items.Count > 0)
                        {
                            RadGrid rgContributionCodes = (ddlContributionCode.Items[0].FindControl("rGrdContributionCode4DDL") as RadGrid);
                            if (rgContributionCodes.SelectedItems.Count > 0)
                            {
                                #region delete old records

                                Hashtable ht = new Hashtable();
                                ht.Add("@posIdd", Convert.ToInt32(secondParentItem.OwnerTableView.DataKeyValues[secondParentItem.ItemIndex]["recidd"].ToString()));
                                ht.Add("@postyp", newValues["@postyp"]);

                                clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Position_Citizen_ContributionCodes", ht);

                                #endregion

                                foreach (GridDataItem dataItem in rgContributionCodes.SelectedItems)
                                {
                                    newValues["@cntidd"] = Convert.ToInt32(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString());
                                    newValues["@DBMessage"] = "";

                                    string DBMessage = "";
                                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_PositionContributionCode", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
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
            else if (e.Item.OwnerTableView.DataMember == "ExpatriateLoanRecords")
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
                    GridDataItem secondParentItem = (GridDataItem)parentItem.OwnerTableView.ParentItem;
                    if (secondParentItem != null)
                        newValues["@posidd"] = Convert.ToInt32(secondParentItem.OwnerTableView.DataKeyValues[secondParentItem.ItemIndex]["recidd"].ToString());

                    newValues["@postyp"] = 0; // emptype 0 for expatriate
                    newValues["@postyd"] = "Expatriate";

                    newValues["@lonidd"] = (editedItem.FindControl("ddlLoanCode") as RadComboBox).Items[0].Value.Trim();
                    newValues["@lonmax"] = (editedItem.FindControl("txtbxMaxLoanAmount") as RadNumericTextBox).Text;

                    newValues["@DBMessage"] = "";

                    string DBMessage = "";

                    if (operation == "Insert")
                    {
                        DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Insert_Position_Loan", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                    }
                    else if (operation == "Update")
                    {
                        DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Update_Position_Loan", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                    }
                    if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                    {
                        ShowClientMessage(DBMessage, MessageType.Error);
                        e.Canceled = true;
                    }
                    else
                    {
                        ShowClientMessage("Expatriate Loan Code save successfully.", MessageType.Success);
                    }
                }
                #endregion
            }
        }
        catch (Exception ex)
        {
            ShowClientMessage("Unable to update/insert Position Code: " + ex.Message, MessageType.Error);
            e.Canceled = true;
        }
    }

    // function to display client side messages
    public void ShowClientMessage(string message, MessageType type, string redipost = "")
    {
        if (type == MessageType.Error)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "radalert", "showError('" + message + "', '" + redipost + "', 5000)", true);
        }
        else if (type == MessageType.Success)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "radalert", "showSuccess('" + message + "', '" + redipost + "', 5000)", true);
        }
        else if (type == MessageType.Warning)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "radalert", "showWarning('" + message + "', '" + redipost + "', 5000)", true);
        }
        else if (type == MessageType.Info)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "radalert", "showInfo('" + message + "', '" + redipost + "', 5000)", true);
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

    // get image for boolean grid column
    protected string getImagePathForTrue(bool flag)
    {
        if (flag)
            return "~/Images/16x16_tick.png";
        else
            return "";
    }
}