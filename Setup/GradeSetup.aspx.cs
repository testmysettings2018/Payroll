using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Payroll_GradeSetup : System.Web.UI.Page
{
    public static Hashtable htSearchParams = null;
    public bool exporting = false;

    // page load function
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    // grade master grid data loading and binding
    protected void gvGrade_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_All_Grades", htSearchParams).Tables[0];
        dt.TableName = "GradeMaster";
        gvGrade.DataSource = dt;
        gvGrade.DataMember = "GradeMaster";
    }

    // loan ddl data loading and binding
    protected void rGrdLoanCode4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_GetLoanRecords", htSearchParams).Tables[0];
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

    // grade ddl data loading and binding
    protected void rGrdGrade4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_All_Grades", htSearchParams).Tables[0];
    }

    // pension ddl data loading and binding
    protected void rGrdPensionCode4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromCentralDb(Constraints.DropDownLists.PensionCode, -1, 1).Tables[0];
    }

    // grade ddl data loading and binding
    protected void rGrdNextGrade4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_All_Grades", htSearchParams).Tables[0];
    }

    // leave ddl data loading and binding
    protected void rGrdLeave4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_Leave_AllRecords", htSearchParams).Tables[0];
    }

    // overtime ddl data loading and binding
    protected void rGrdOvertime4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_payroll_GetAllOvertimeRecords", htSearchParams).Tables[0];
    }

    // calender ddl data loading and binding
    protected void rGrdCalender4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_payroll_GetAllCalenderRecords", htSearchParams).Tables[0];
    }

    // gratuity ddl data loading and binding
    protected void rGrdGraduity4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_All_Gratuity_Records", htSearchParams).Tables[0];
    }

    // gratuity provision ddl data loading and binding
    protected void rGrdGraduityProv4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
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

    // detail grids data loading and binding
    protected void gvGrade_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;
        switch (e.DetailTableView.Name)
        {
            case "Citizens":
                {
                    string ID = dataItem.GetDataKeyValue("grdidd").ToString();

                    Hashtable ht = new Hashtable();
                    ht.Add("@GradeID", ID);

                    DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_GetGradeCitizens", ht).Tables[0];
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
                        ID = Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["grdidd"].ToString());
                    }
                    Hashtable ht = new Hashtable();
                    ht.Add("@GradeID", ID);

                    DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_GetGradePayCodesCitizens", ht).Tables[0];

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
                        ID = Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["grdidd"].ToString());
                    }
                    Hashtable ht = new Hashtable();
                    ht.Add("@GradeID", ID);

                    DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_GetGradeBenefitCodesCitizens", ht).Tables[0];
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
                        ID = Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["grdidd"].ToString());
                    }
                    Hashtable ht = new Hashtable();
                    ht.Add("@GradeID", ID);

                    DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_GetGradeDeductionCodesCitizens", ht).Tables[0];
                    dt.TableName = "CiizensDeductionCodes";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "CiizensDeductionCodes";
                    break;
                }
            case "CiizensContributionCodes":
                {
                    GridDataItem parentItem = (GridDataItem)(dataItem.OwnerTableView.ParentItem);
                    Int32 ID = 0;
                    if (parentItem != null)
                    {
                        ID = Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["grdidd"].ToString());
                    }
                    Hashtable ht = new Hashtable();
                    ht.Add("@GradeID", ID);

                    DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_GetGradeContributionCodesCitizens", ht).Tables[0];
                    dt.TableName = "CiizensContributionCodes";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "CiizensContributionCodes";
                    break;
                }
            case "CitizenLoanRecords":
                {
                    GridDataItem parentItem = (GridDataItem)(dataItem.OwnerTableView.ParentItem);
                    Int32 ID = 0;
                    if (parentItem != null)
                    {
                        ID = Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["grdidd"].ToString());
                    }
                    Hashtable ht = new Hashtable();
                    ht.Add("@GradeID", ID);

                    DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_GetGradeLoanCodesCitizen", ht).Tables[0];
                    dt.TableName = "CitizenLoanRecords";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "CitizenLoanRecords";
                    break;
                }
            case "Expatriate":
                {
                    string ID = dataItem.GetDataKeyValue("grdidd").ToString();

                    Hashtable ht = new Hashtable();
                    ht.Add("@GradeID", ID);

                    DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_GetGradeExpat", ht).Tables[0];
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
                        ID = Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["grdidd"].ToString());
                    }
                    Hashtable ht = new Hashtable();
                    ht.Add("@GradeID", ID);

                    DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_GetGradePayCodesExpat", ht).Tables[0];

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
                        ID = Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["grdidd"].ToString());
                    }
                    Hashtable ht = new Hashtable();
                    ht.Add("@GradeID", ID);

                    DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_GetGradeBenefitCodesExpat", ht).Tables[0];
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
                        ID = Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["grdidd"].ToString());
                    }
                    Hashtable ht = new Hashtable();
                    ht.Add("@GradeID", ID);

                    DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_GetGradeDeductionCodesExpat", ht).Tables[0];
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
                        ID = Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["grdidd"].ToString());
                    }
                    Hashtable ht = new Hashtable();
                    ht.Add("@GradeID", ID);

                    DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_GetGradeContributionCodesExpatriate", ht).Tables[0];
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
                        ID = Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["grdidd"].ToString());
                    }
                    Hashtable ht = new Hashtable();
                    ht.Add("@GradeID", ID);

                    DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_GetGradeLoanCodesExpatriate", ht).Tables[0];
                    dt.TableName = "ExpatriateLoanRecords";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "ExpatriateLoanRecords";
                    break;
                }
        }
    }

    // grid update command
    protected void gvGrade_UpdateCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_User(ref e, "Update");
    }

    // grid delete command for master and child grids
    protected void gvGrade_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        try
        {
            if (e.Item.OwnerTableView.DataMember == "GradeMaster")
            {
                int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("grdidd");
                Hashtable ht = new Hashtable();
                ht.Add("@ID", ID);
                if (ID > 0)
                {
                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Grade", ht);
                }
            }
            else if (e.Item.OwnerTableView.DataMember == "CiizensPayCodes")
            {
                int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("grdidd");
                Hashtable ht = new Hashtable();
                ht.Add("@ID", ID);
                if (ID > 0)
                {
                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Grade_Citizen_PayCodes", ht);
                }
            }
            else if (e.Item.OwnerTableView.DataMember == "CiizensBenefitCodes")
            {
                int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("grdidd");
                Hashtable ht = new Hashtable();
                ht.Add("@ID", ID);
                if (ID > 0)
                {
                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Grade_Citizen_BenefitCodes", ht);
                }
            }
            else if (e.Item.OwnerTableView.DataMember == "CiizensDeductionCodes")
            {
                int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("grdidd");
                Hashtable ht = new Hashtable();
                ht.Add("@ID", ID);
                if (ID > 0)
                {
                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Grade_Citizen_DeductionCodes", ht);
                }
            }
            else if (e.Item.OwnerTableView.DataMember == "CiizensContributionCodes")
            {
                int contID = (int)((GridDataItem)e.Item).GetDataKeyValue("recidd");
                Hashtable contht = new Hashtable();
                contht.Add("@cntID", contID);
                if (contID > 0)
                {
                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Grade_Citizen_ContributionCode", contht);
                }
            }
            else if (e.Item.OwnerTableView.DataMember == "CitizenLoanRecords")
            {
                int loanID = (int)((GridDataItem)e.Item).GetDataKeyValue("recidd");
                Hashtable loanht = new Hashtable();
                loanht.Add("@LoanID", loanID);
                if (loanID > 0)
                {
                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Grade_LoneCode", loanht);
                }
            }
            else if (e.Item.OwnerTableView.DataMember == "ExpatriateContributionCodes")
            {
                int contID = (int)((GridDataItem)e.Item).GetDataKeyValue("recidd");
                Hashtable contht = new Hashtable();
                contht.Add("@cntID", contID);
                if (contID > 0)
                {
                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Grade_Citizen_ContributionCode", contht);
                }
            }     
            else if (e.Item.OwnerTableView.DataMember == "ExpatriatePayCodes")
            {
                int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("grdidd");
                Hashtable ht = new Hashtable();
                ht.Add("@ID", ID);
                if (ID > 0)
                {
                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Grade_Expatriate_PayCodes", ht);
                }
            }
            else if (e.Item.OwnerTableView.DataMember == "ExpatriateBenefitCodes")
            {
                int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("grdidd");
                Hashtable ht = new Hashtable();
                ht.Add("@ID", ID);
                if (ID > 0)
                {
                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Grade_Expatriate_BenefitCodes", ht);
                }
            }
            else if (e.Item.OwnerTableView.DataMember == "ExpatriateDeductionCodes")
            {
                int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("grdidd");
                Hashtable ht = new Hashtable();
                ht.Add("@ID", ID);
                if (ID > 0)
                {
                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Grade_Expatriate_DeductionCodes", ht);
                }
            }
            else if (e.Item.OwnerTableView.DataMember == "ExpatriateLoanRecords")
            {
                int loanID = (int)((GridDataItem)e.Item).GetDataKeyValue("recidd");
                Hashtable loanht = new Hashtable();
                loanht.Add("@LoanID", loanID);
                if (loanID > 0)
                {
                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Grade_LoneCode", loanht);
                }
            }
        }
        catch (Exception ex)
        {

        }
    }

    // client side validation function for grade input form
    public void ValidateGrade(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadTextBox txtGradeCode = (editForm.FindControl("txtGradeCode") as RadTextBox);
        RadTextBox txtDescription = (editForm.FindControl("txtDescription") as RadTextBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidateGrade('" +
                txtGradeCode.ClientID + "','" +
                txtDescription.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateGrade('" +
                txtGradeCode.ClientID + "','" +
                txtDescription.ClientID
                + "')");
        }
    }

    // client side validation function for grade citizien pay codes input form
    public void ValidateGradeCiizensPayCodes(GridItemEventArgs e)
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
            update.Attributes.Add("onclick", "return ValidateGradeCiizensPayCodes('" +
                ddlPayCode.ClientID + "','" +
                txtCPCsngfrm.ClientID + "','" +
                txtBxCPCsngtoo.ClientID + "','" +
                txtBxCPCmarfrm.ClientID + "','" +
                txtBxCPCmartoo.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateGradeCiizensPayCodes('" +
                ddlPayCode.ClientID + "','" +
                txtCPCsngfrm.ClientID + "','" +
                txtBxCPCsngtoo.ClientID + "','" +
                txtBxCPCmarfrm.ClientID + "','" +
                txtBxCPCmartoo.ClientID
                + "')");
        }
    }

    // client side validation function for grade citizien benefit codes input form
    public void ValidateGradeCiizensBenefitCodes(GridItemEventArgs e)
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
            update.Attributes.Add("onclick", "return ValidateGradeCiizensBenefitCodes('" +
                ddlBenefitCode.ClientID + "','" +
                txtCBCsngfrm.ClientID + "','" +
                txtBxCBCsngtoo.ClientID + "','" +
                txtBxCBCmarfrm.ClientID + "','" +
                txtBxCBCmartoo.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateGradeCiizensBenefitCodes('" +
                ddlBenefitCode.ClientID + "','" +
                txtCBCsngfrm.ClientID + "','" +
                txtBxCBCsngtoo.ClientID + "','" +
                txtBxCBCmarfrm.ClientID + "','" +
                txtBxCBCmartoo.ClientID
                + "')");
        }
    }

    // client side validation function for grade citizien deduction codes input form
    public void ValidateGradeCiizensDeductionCodes(GridItemEventArgs e)
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
            update.Attributes.Add("onclick", "return ValidateGradeCiizensDeductionCodes('" +
                ddlDeductionCode.ClientID + "','" +
                txtCDCsngfrm.ClientID + "','" +
                txtBxCDCsngtoo.ClientID + "','" +
                txtBxCDCmarfrm.ClientID + "','" +
                txtBxCDCmartoo.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateGradeCiizensDeductionCodes('" +
                ddlDeductionCode.ClientID + "','" +
                txtCDCsngfrm.ClientID + "','" +
                txtBxCDCsngtoo.ClientID + "','" +
                txtBxCDCmarfrm.ClientID + "','" +
                txtBxCDCmartoo.ClientID
                + "')");
        }
    }

    // client side validation function for grade expat pay codes input form
    public void ValidateGradeExpatriatePayCodes(GridItemEventArgs e)
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
            update.Attributes.Add("onclick", "return ValidateGradeExpatriatePayCodes('" +
               ddlPayCode.ClientID + "','" +
                txtEPCsngfrm.ClientID + "','" +
                txtBxEPCsngtoo.ClientID + "','" +
                txtBxEPCmarfrm.ClientID + "','" +
                txtBxEPCmartoo.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateGradeExpatriatePayCodes('" +
                 ddlPayCode.ClientID + "','" +
                txtEPCsngfrm.ClientID + "','" +
                txtBxEPCsngtoo.ClientID + "','" +
                txtBxEPCmarfrm.ClientID + "','" +
                txtBxEPCmartoo.ClientID
                + "')");
        }
    }

    // client side validation function for grade expat benefit codes input form
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
                ddlBenefitCode.ClientID + "','" +
                txtEBCsngfrm.ClientID + "','" +
                txtBxEBCsngtoo.ClientID + "','" +
                txtBxEBCmarfrm.ClientID + "','" +
                txtBxEBCmartoo.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateExpatriateBenefitCodes('" +
                ddlBenefitCode.ClientID + "','" +
                txtEBCsngfrm.ClientID + "','" +
                txtBxEBCsngtoo.ClientID + "','" +
                txtBxEBCmarfrm.ClientID + "','" +
                txtBxEBCmartoo.ClientID
                + "')");
        }
    }

    // client side validation function for grade expat deduction codes input form
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
                ddlDeductionCode.ClientID + "','" +
                txtEDCsngfrm.ClientID + "','" +
                txtBxEDCsngtoo.ClientID + "','" +
                txtBxEDCmarfrm.ClientID + "','" +
                txtBxEDCmartoo.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateExpatriateDeductionCodes('" +
                ddlDeductionCode.ClientID + "','" +
                txtEDCsngfrm.ClientID + "','" +
                txtBxEDCsngtoo.ClientID + "','" +
                txtBxEDCmarfrm.ClientID + "','" +
                txtBxEDCmartoo.ClientID
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

    // settings of form input controls for insert/update operations
    protected void gvGrade_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            if (e.Item.OwnerTableView.DataMember == "GradeMaster")
            {
                ValidateGrade(e);
                if (e.Item.OwnerTableView.IsItemInserted)
                {
                    #region  item is about to be inserted

                    GridEditableItem insertedItem = (GridEditableItem)e.Item;

                    RadComboBox ddlGradeType = (RadComboBox)insertedItem.FindControl("ddlGradeType");
                    //RadComboBox ddlGarnismentCategory = (RadComboBox)insertedItem.FindControl("ddlGarnismentCategory");
                    RadComboBox ddlMethod = (RadComboBox)insertedItem.FindControl("ddlMethod");
                    RadComboBox ddlgrdPeriod = (RadComboBox)insertedItem.FindControl("ddlgrdPeriod");
                    RadComboBox ddlNewEmoloyeeAnualLeave = (RadComboBox)insertedItem.FindControl("ddlNewEmoloyeeAnualLeave");
                    RadComboBox ddlGrade = (RadComboBox)insertedItem.FindControl("ddlGrade");

                    if (ddlGradeType != null)
                    {
                        RadGrid grid = ddlGradeType.Items[0].FindControl("rGrdGradeType4DDL") as RadGrid;
                        grid.Rebind();
                    }
                    //if (ddlGarnismentCategory != null)
                    //{
                    //    RadGrid grid = ddlGarnismentCategory.Items[0].FindControl("rGrdGarnismentCategory4DDL") as RadGrid;
                    //    grid.Rebind();
                    //}
                    if (ddlgrdPeriod != null)
                    {
                        RadGrid grid = ddlgrdPeriod.Items[0].FindControl("rGrdgrdPeriod4DDL") as RadGrid;
                        grid.Rebind();
                    }
                    if (ddlMethod != null)
                    {
                        RadGrid grid = ddlMethod.Items[0].FindControl("rGrdMethod4DDL") as RadGrid;
                        grid.Rebind();
                    }
                    if (ddlGrade != null)
                    {
                        Hashtable ht_filters = new Hashtable();
                        DataTable dt_Reports = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_Grade_grdords", ht_filters).Tables[0];
                        ddlGrade.DataSource = dt_Reports;
                        ddlGrade.DataTextField = "grdcod";
                        ddlGrade.DataValueField = "grdidd";
                        ddlGrade.DataBind();
                        ddlGrade.SelectedIndex = 0;
                    }
                    #endregion
                }
                else
                {
                    #region item is about to be edited
                    GridEditableItem editedItem = (GridEditableItem)e.Item;

                    RadComboBox ddlPensionCode = (RadComboBox)editedItem.FindControl("ddlPensionCode");
                    HiddenField hfPensionCodedllID = (HiddenField)editedItem.FindControl("hfPensionCodedllID");
                    HiddenField hfPensionCodedllText = (HiddenField)editedItem.FindControl("hfPensionCodedllText");

                    if (ddlPensionCode != null)
                    {
                        RadGrid grid = ddlPensionCode.Items[0].FindControl("rGrdPensionCode4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfPensionCodedllID.Value) && !string.IsNullOrEmpty(hfPensionCodedllText.Value))
                        {
                            ddlPensionCode.Items[0].Value = hfPensionCodedllID.Value;
                            ddlPensionCode.Items[0].Text = hfPensionCodedllText.Value;
                            ddlPensionCode.Text = hfPensionCodedllText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfPensionCodedllID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["ValueSetID"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    RadComboBox ddlNextGrade = (RadComboBox)editedItem.FindControl("ddlNextGrade");
                    HiddenField hfnextgradeId = (HiddenField)editedItem.FindControl("hfnextgradeId");
                    HiddenField hfnextgradeText = (HiddenField)editedItem.FindControl("hfnextgradeText");

                    if (ddlNextGrade != null)
                    {
                        RadGrid grid = ddlNextGrade.Items[0].FindControl("rGrdNextGrade4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfnextgradeId.Value) && !string.IsNullOrEmpty(hfnextgradeText.Value))
                        {
                            ddlNextGrade.Items[0].Value = hfnextgradeId.Value;
                            ddlNextGrade.Items[0].Text = hfnextgradeText.Value;
                            ddlNextGrade.Text = hfnextgradeText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfnextgradeId.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["grdidd"].ToString()))
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
                        RadGrid grid = ddlCalender.Items[0].FindControl("rGrdCalender4DDL") as RadGrid;
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

                    RadComboBox ddlGratuityPro = (RadComboBox)editedItem.FindControl("ddlGratuityPro");
                    HiddenField hfGratuityProdllID = (HiddenField)editedItem.FindControl("hfGratuityProdllID");
                    HiddenField hfGratuityProdllText = (HiddenField)editedItem.FindControl("hfGratuityProdllText");

                    if (ddlGratuityPro != null)
                    {
                        RadGrid grid = ddlGratuityPro.Items[0].FindControl("rGrdGraduityProv4DDL") as RadGrid;
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
                        RadGrid grid = ddlGraduity.Items[0].FindControl("rGrdGraduity4DDL") as RadGrid;
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
                ValidateGradeCiizensPayCodes(e);

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
                ValidateGradeCiizensBenefitCodes(e);

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
                ValidateGradeCiizensDeductionCodes(e);

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
            else if (e.Item.OwnerTableView.DataMember == "CiizensContributionCodes")
            {
                if (e.Item.OwnerTableView.IsItemInserted)
                {
                    #region  item is about to be inserted

                    GridEditableItem insertedItem = (GridEditableItem)e.Item;
                    RadComboBox ddlContributionCode = (RadComboBox)insertedItem.FindControl("ddlContributionCode");
                    HiddenField hfGradeId = (HiddenField)insertedItem.FindControl("hfGradeId");
                    if (hfGradeId.Value == "")
                        hfGradeId.Value = e.Item.OwnerTableView.ParentItem.OwnerTableView.ParentItem.GetDataKeyValue("grdidd").ToString();

                    if (ddlContributionCode != null)
                    {
                        if (hfGradeId != null)
                        {
                            Int32 ID = Convert.ToInt32(hfGradeId.Value);
                            Hashtable ht = new Hashtable();
                            ht.Add("@GradeID", ID);
                            DataTable dt_ContributionCodes = clsDAL.GetDataSet_Payroll("sp_Payroll_GetGradeContributionCodesCitizens", ht).Tables[0];                   

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

                    HiddenField hfGradeId = (HiddenField)editedItem.FindControl("hfGradeId");
                    if (hfGradeId.Value == "")
                        hfGradeId.Value = e.Item.OwnerTableView.ParentItem.GetDataKeyValue("grdidd").ToString();

                    if (ddlContributionCode != null)
                    {
                        if (hfGradeId != null)
                        {
                            Int32 ID = Convert.ToInt32(hfGradeId.Value);
                            Hashtable ht = new Hashtable();
                            ht.Add("@GradeID", ID);
                            DataTable dt_ContributionCodes = clsDAL.GetDataSet_Payroll("sp_Payroll_GetGradeContributionCodesCitizens", ht).Tables[0];

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
            else if (e.Item.OwnerTableView.DataMember == "ExpatriatePayCodes")
            {
                ValidateGradeExpatriatePayCodes(e);

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
                    HiddenField hfGradeId = (HiddenField)insertedItem.FindControl("hfGradeId");
                    if (hfGradeId.Value == "")
                        hfGradeId.Value = e.Item.OwnerTableView.ParentItem.OwnerTableView.ParentItem.GetDataKeyValue("grdidd").ToString();

                    if (ddlContributionCode != null)
                    {
                        if (hfGradeId != null)
                        {
                            Int32 ID = Convert.ToInt32(hfGradeId.Value);
                            Hashtable ht = new Hashtable();
                            ht.Add("@GradeID", ID);
                            DataTable dt_ContributionCodes = clsDAL.GetDataSet_Payroll("sp_Payroll_GetGradeContributionCodesExpatriate", ht).Tables[0];

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

                    HiddenField hfGradeId = (HiddenField)editedItem.FindControl("hfGradeId");
                    if (hfGradeId.Value == "")
                        hfGradeId.Value = e.Item.OwnerTableView.ParentItem.GetDataKeyValue("grdidd").ToString();

                    if (ddlContributionCode != null)
                    {
                        if (hfGradeId != null)
                        {
                            Int32 ID = Convert.ToInt32(hfGradeId.Value);
                            Hashtable ht = new Hashtable();
                            ht.Add("@GradeID", ID);
                            DataTable dt_ContributionCodes = clsDAL.GetDataSet_Payroll("sp_Payroll_GetGradeContributionCodesExpatriate", ht).Tables[0];

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

    // grid header settings for exporting
    protected void gvGrade_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (exporting && e.Item.ItemType == Telerik.Web.UI.GridItemType.FilteringItem)
        {
            e.Item.Visible = false;
        }
    }

    // setting of input controls for insert/update
    // export functions
    protected void gvGrade_ItemCommand(object sender, GridCommandEventArgs e)
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
            //grid.ExportSettings.HideStructugrdolumns = true;

            foreach (GridDataItem item in grid.Items)
            {
                item["ExpandColumn"].Visible = false;
            }

            if (e.Item.OwnerTableView.DataMember == "GradeMaster")
            {
                grid.MasterTableView.GetColumn("Editgrdcode").Visible = false;
                grid.MasterTableView.GetColumn("Deletegrdcode").Visible = false;
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
            else if (e.Item.OwnerTableView.DataMember == "CitizenLoanRecords")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }    
            else if (e.Item.OwnerTableView.DataMember == "CiizensContributionCodes")
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
            if (e.Item.OwnerTableView.DataMember == "GradeMaster")
            {
                grid.MasterTableView.GetColumn("Editgrdcode").Visible = false;
                grid.MasterTableView.GetColumn("Deletegrdcode").Visible = false;
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
            else if (e.Item.OwnerTableView.DataMember == "CiizensContributionCodes")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "CitizenLoanRecords")
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
            if (e.Item.OwnerTableView.DataMember == "GradeMaster")
            {
                grid.MasterTableView.GetColumn("Editgrdcode").Visible = false;
                grid.MasterTableView.GetColumn("Deletegrdcode").Visible = false;
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
            else if (e.Item.OwnerTableView.DataMember == "CiizensContributionCodes")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "CitizenLoanRecords")
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

            grid.MasterTableView.ExportToPdf();
        }
        if (e.CommandName == "Print")
        {
            Button btnPrint = (Button)e.Item.FindControl("btnGradePrint");
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

    // grid export settings
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
                if (column.UniqueName == "Deletegrdcode" || column.UniqueName == "Editgrdcode")
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
    protected void gvGrade_InsertCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_User(ref e, "Insert");
    }

    // insert/update function
    private void Insert_or_Update_User(ref GridCommandEventArgs e, string operation)
    {
        GridEditableItem editedItem = e.Item as GridEditableItem;
        try
        {
            if (e.Item.OwnerTableView.DataMember == "GradeMaster")
            {
                #region Grid Master
                //Insert new values
                Hashtable newValues = new Hashtable();
                if (operation == "Update")
                {
                    newValues["@grdidd"] = (int)editedItem.GetDataKeyValue("grdidd");
                }
                newValues["@grdcod"] = (editedItem.FindControl("txtGradeCode") as RadTextBox).Text.Trim();
                newValues["@grdds1"] = (editedItem.FindControl("txtDescription") as RadTextBox).Text;
                newValues["@grdds2"] = (editedItem.FindControl("txtArabicDescription") as RadTextBox).Text;
                newValues["@grdnid"] = (editedItem.FindControl("ddlNextGrade") as RadComboBox).Items[0].Value.Trim();
                newValues["@grdcli"] = (editedItem.FindControl("ddlCalender") as RadComboBox).Items[0].Value.Trim();
                newValues["@grdgti"] = (editedItem.FindControl("ddlGraduity") as RadComboBox).Items[0].Value.Trim();
                newValues["@grdgpi"] = (editedItem.FindControl("ddlGratuityPro") as RadComboBox).Items[0].Value.Trim();
                newValues["@grdovi"] = (editedItem.FindControl("ddlOvertime") as RadComboBox).Items[0].Value.Trim();
                newValues["@grdani"] = (editedItem.FindControl("ddlLeave") as RadComboBox).Items[0].Value.Trim();
                newValues["@grdpni"] = (editedItem.FindControl("ddlPensionCode") as RadComboBox).Items[0].Value.Trim();
                newValues["@grdlon"] = string.IsNullOrEmpty((editedItem.FindControl("txtgrdlone") as RadNumericTextBox).Text) ? "0" : (editedItem.FindControl("txtgrdlone") as RadNumericTextBox).Text;

                newValues["@DBMessage"] = "";

                string DBMessage = "";

                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Insert_Grade", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Update_Grade", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                else
                {
                    gvGrade.Rebind();
                    ShowClientMessage("Grade record save successfully.", MessageType.Success);
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
                    newValues["@grdidd"] = (int)editedItem.GetDataKeyValue("grdidd");
                }
                GridDataItem parentItem = (GridDataItem)(e.Item.OwnerTableView.ParentItem);
                if (parentItem != null)
                {
                    GridDataItem secondParentItem = (GridDataItem)parentItem.OwnerTableView.ParentItem;
                    if (secondParentItem != null)
                        newValues["@grdgid"] = Convert.ToInt32(secondParentItem.OwnerTableView.DataKeyValues[secondParentItem.ItemIndex]["grdidd"].ToString());
                }
                newValues["@grdetype"] = 1; // emptype 1 for citizen
                newValues["@grdcdtyp"] = 1; // code type 1 for paycode
                newValues["@grdpci"] = (editedItem.FindControl("ddlPayCode") as RadComboBox).Items[0].Value.Trim();
                newValues["@grdsfrm"] = (editedItem.FindControl("txtCPCsngfrm") as RadNumericTextBox).Text;
                newValues["@grdsto"] = (editedItem.FindControl("txtBxCPCsngtoo") as RadNumericTextBox).Text;
                newValues["@grdmfrm"] = (editedItem.FindControl("txtBxCPCmarfrm") as RadNumericTextBox).Text;
                newValues["@grdmto"] = (editedItem.FindControl("txtBxCPCmartoo") as RadNumericTextBox).Text;

                newValues["@DBMessage"] = "";

                string DBMessage = "";

                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Insert_Grade_Citizen_PayCode", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Update_Grade_Citizen_PayCode", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
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
                    newValues["@grdidd"] = (int)editedItem.GetDataKeyValue("grdidd");
                }
                GridDataItem parentItem = (GridDataItem)(e.Item.OwnerTableView.ParentItem);
                if (parentItem != null)
                {
                    GridDataItem secondParentItem = (GridDataItem)parentItem.OwnerTableView.ParentItem;
                    if (secondParentItem != null)
                        newValues["@grdgid"] = Convert.ToInt32(secondParentItem.OwnerTableView.DataKeyValues[secondParentItem.ItemIndex]["grdidd"].ToString());
                }
                newValues["@grdetype"] = 1; // emptype 1 for citizen
                newValues["@grdcdtyp"] = 2; // code type 2 for benefit code
                newValues["@grdbni"] = (editedItem.FindControl("ddlBenefitCode") as RadComboBox).Items[0].Value.Trim();
                newValues["@grdsfrm"] = (editedItem.FindControl("txtCBCsngfrm") as RadNumericTextBox).Text;
                newValues["@grdsto"] = (editedItem.FindControl("txtBxCBCsngtoo") as RadNumericTextBox).Text;
                newValues["@grdmfrm"] = (editedItem.FindControl("txtBxCBCmarfrm") as RadNumericTextBox).Text;
                newValues["@grdmto"] = (editedItem.FindControl("txtBxCBCmartoo") as RadNumericTextBox).Text;

                newValues["@DBMessage"] = "";

                string DBMessage = "";

                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Insert_Grade_Citizen_BenefitCode", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Update_Grade_Citizen_BenefitCode", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
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
                    newValues["@grdidd"] = (int)editedItem.GetDataKeyValue("grdidd");
                }
                GridDataItem parentItem = (GridDataItem)(e.Item.OwnerTableView.ParentItem);
                if (parentItem != null)
                {
                    GridDataItem secondParentItem = (GridDataItem)parentItem.OwnerTableView.ParentItem;
                    if (secondParentItem != null)
                        newValues["@grdgid"] = Convert.ToInt32(secondParentItem.OwnerTableView.DataKeyValues[secondParentItem.ItemIndex]["grdidd"].ToString());
                }
                newValues["@grdetype"] = 1; // emptype 1 for citizen
                newValues["@grdcdtyp"] = 3; // code type 3 for deduction code
                newValues["@grdddi"] = (editedItem.FindControl("ddlDeductionCode") as RadComboBox).Items[0].Value.Trim();
                newValues["@grdsfrm"] = (editedItem.FindControl("txtCDCsngfrm") as RadNumericTextBox).Text;
                newValues["@grdsto"] = (editedItem.FindControl("txtBxCDCsngtoo") as RadNumericTextBox).Text;
                newValues["@grdmfrm"] = (editedItem.FindControl("txtBxCDCmarfrm") as RadNumericTextBox).Text;
                newValues["@grdmto"] = (editedItem.FindControl("txtBxCDCmartoo") as RadNumericTextBox).Text;

                newValues["@DBMessage"] = "";

                string DBMessage = "";

                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Insert_Grade_Citizen_DeductionCode", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Update_Grade_Citizen_DeductionCode", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
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
            else if (e.Item.OwnerTableView.DataMember == "CiizensContributionCodes")
            {
                #region Citizen Contribution Code
                //Insert new values
                Hashtable newValues = new Hashtable();

                GridDataItem parentItem = (GridDataItem)(e.Item.OwnerTableView.ParentItem);
                if (parentItem != null)
                {
                    GridDataItem secondParentItem = (GridDataItem)parentItem.OwnerTableView.ParentItem;
                    if (secondParentItem != null)
                        newValues["@grdidd"] = Convert.ToInt32(secondParentItem.OwnerTableView.DataKeyValues[secondParentItem.ItemIndex]["grdidd"].ToString());

                    newValues["@grdtyp"] = 1; // emptype 1 for citizen
                    newValues["@grdtyd"] = "Citizen";

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
                                ht.Add("@grdIdd", Convert.ToInt32(secondParentItem.OwnerTableView.DataKeyValues[secondParentItem.ItemIndex]["grdidd"].ToString()));
                                ht.Add("@grdtyp", newValues["@grdtyp"]);

                                clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Grade_ContributionCodes", ht);

                                #endregion

                                foreach (GridDataItem dataItem in rgContributionCodes.SelectedItems)
                                {
                                    newValues["@cntidd"] = Convert.ToInt32(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString());
                                    newValues["@DBMessage"] = "";

                                    string DBMessage = "";
                                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_GradeContributionCode", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
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
                        newValues["@grdidd"] = Convert.ToInt32(secondParentItem.OwnerTableView.DataKeyValues[secondParentItem.ItemIndex]["grdidd"].ToString());

                    newValues["@grdtyp"] = 1; // emptype 1 for citizen
                    newValues["@grdtyd"] = "Citizen";

                    newValues["@lonidd"] = (editedItem.FindControl("ddlLoanCode") as RadComboBox).Items[0].Value.Trim();
                    newValues["@lonmax"] = (editedItem.FindControl("txtbxMaxLoanAmount") as RadNumericTextBox).Text;

                    newValues["@DBMessage"] = "";

                    string DBMessage = "";

                    if (operation == "Insert")
                    {
                        DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Insert_Grade_Loan", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                    }
                    else if (operation == "Update")
                    {
                        DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Update_Grade_Loan", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
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
                    newValues["@grdidd"] = (int)editedItem.GetDataKeyValue("grdidd");
                }
                GridDataItem parentItem = (GridDataItem)(e.Item.OwnerTableView.ParentItem);
                if (parentItem != null)
                {
                    GridDataItem secondParentItem = (GridDataItem)parentItem.OwnerTableView.ParentItem;
                    if (secondParentItem != null)
                        newValues["@grdgid"] = Convert.ToInt32(secondParentItem.OwnerTableView.DataKeyValues[secondParentItem.ItemIndex]["grdidd"].ToString());
                }
                newValues["@grdetype"] = 0; // emptype 0 for Expatriate
                newValues["@grdcdtyp"] = 1; // code type 1 for paycode
                newValues["@grdpci"] = (editedItem.FindControl("ddlPayCode") as RadComboBox).Items[0].Value.Trim();
                newValues["@grdsfrm"] = (editedItem.FindControl("txtEPCsngfrm") as RadNumericTextBox).Text;
                newValues["@grdsto"] = (editedItem.FindControl("txtBxEPCsngtoo") as RadNumericTextBox).Text;
                newValues["@grdmfrm"] = (editedItem.FindControl("txtBxEPCmarfrm") as RadNumericTextBox).Text;
                newValues["@grdmto"] = (editedItem.FindControl("txtBxEPCmartoo") as RadNumericTextBox).Text;

                newValues["@DBMessage"] = "";

                string DBMessage = "";

                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Insert_Grade_Expatriate_PayCode", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Update_Grade_Expatriate_PayCode", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
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
                    newValues["@grdidd"] = (int)editedItem.GetDataKeyValue("grdidd");
                }
                GridDataItem parentItem = (GridDataItem)(e.Item.OwnerTableView.ParentItem);
                if (parentItem != null)
                {
                    GridDataItem secondParentItem = (GridDataItem)parentItem.OwnerTableView.ParentItem;
                    if (secondParentItem != null)
                        newValues["@grdgid"] = Convert.ToInt32(secondParentItem.OwnerTableView.DataKeyValues[secondParentItem.ItemIndex]["grdidd"].ToString());
                }
                newValues["@grdetype"] = 0; // emptype 0 for Expatriate
                newValues["@grdcdtyp"] = 2; // code type 2 for benefit code
                newValues["@grdbni"] = (editedItem.FindControl("ddlBenefitCode") as RadComboBox).Items[0].Value.Trim();
                newValues["@grdsfrm"] = (editedItem.FindControl("txtEBCsngfrm") as RadNumericTextBox).Text;
                newValues["@grdsto"] = (editedItem.FindControl("txtBxEBCsngtoo") as RadNumericTextBox).Text;
                newValues["@grdmfrm"] = (editedItem.FindControl("txtBxEBCmarfrm") as RadNumericTextBox).Text;
                newValues["@grdmto"] = (editedItem.FindControl("txtBxEBCmartoo") as RadNumericTextBox).Text;

                newValues["@DBMessage"] = "";

                string DBMessage = "";

                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Insert_Grade_Expatriate_BenefitCode", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Update_Grade_Expatriate_BenefitCode", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
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
                    newValues["@grdidd"] = (int)editedItem.GetDataKeyValue("grdidd");
                }
                GridDataItem parentItem = (GridDataItem)(e.Item.OwnerTableView.ParentItem);
                if (parentItem != null)
                {
                    GridDataItem secondParentItem = (GridDataItem)parentItem.OwnerTableView.ParentItem;
                    if (secondParentItem != null)
                        newValues["@grdgid"] = Convert.ToInt32(secondParentItem.OwnerTableView.DataKeyValues[secondParentItem.ItemIndex]["grdidd"].ToString());
                }
                newValues["@grdetype"] = 0; // emptype 0 for Expatriate
                newValues["@grdcdtyp"] = 3; // code type 3 for deduction code
                newValues["@grdddi"] = (editedItem.FindControl("ddlDeductionCode") as RadComboBox).Items[0].Value.Trim();
                newValues["@grdsfrm"] = (editedItem.FindControl("txtEDCsngfrm") as RadNumericTextBox).Text;
                newValues["@grdsto"] = (editedItem.FindControl("txtBxEDCsngtoo") as RadNumericTextBox).Text;
                newValues["@grdmfrm"] = (editedItem.FindControl("txtBxEDCmarfrm") as RadNumericTextBox).Text;
                newValues["@grdmto"] = (editedItem.FindControl("txtBxEDCmartoo") as RadNumericTextBox).Text;

                newValues["@DBMessage"] = "";

                string DBMessage = "";

                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Insert_Grade_Expatriate_DeductionCode", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Update_Grade_Expatriate_DeductionCode", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
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
                        newValues["@grdidd"] = Convert.ToInt32(secondParentItem.OwnerTableView.DataKeyValues[secondParentItem.ItemIndex]["grdidd"].ToString());

                    newValues["@grdtyp"] = 0; // emptype 0 for Expatriate
                    newValues["@grdtyd"] = "Expatriate";

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
                                ht.Add("@grdIdd", Convert.ToInt32(secondParentItem.OwnerTableView.DataKeyValues[secondParentItem.ItemIndex]["grdidd"].ToString()));
                                ht.Add("@grdtyp", newValues["@grdtyp"]);

                                clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Grade_ContributionCodes", ht);

                                #endregion

                                foreach (GridDataItem dataItem in rgContributionCodes.SelectedItems)
                                {
                                    newValues["@cntidd"] = Convert.ToInt32(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString());
                                    newValues["@DBMessage"] = "";

                                    string DBMessage = "";
                                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_GradeContributionCode", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
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
                        newValues["@grdidd"] = Convert.ToInt32(secondParentItem.OwnerTableView.DataKeyValues[secondParentItem.ItemIndex]["grdidd"].ToString());

                    newValues["@grdtyp"] = 0; // emptype 0 for expatriate
                    newValues["@grdtyd"] = "Expatriate";

                    newValues["@lonidd"] = (editedItem.FindControl("ddlLoanCode") as RadComboBox).Items[0].Value.Trim();
                    newValues["@lonmax"] = (editedItem.FindControl("txtbxMaxLoanAmount") as RadNumericTextBox).Text;

                    newValues["@DBMessage"] = "";

                    string DBMessage = "";

                    if (operation == "Insert")
                    {
                        DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Insert_Grade_Loan", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                    }
                    else if (operation == "Update")
                    {
                        DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Update_Grade_Loan", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
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
            ShowClientMessage("Unable to update/insert grade Code: " + ex.Message, MessageType.Error);
            e.Canceled = true;
        }
    }

    // display client side messages 
    public void ShowClientMessage(string message, MessageType type, string redigrdt = "")
    {
        if (type == MessageType.Error)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "radalert", "showError('" + message + "', '" + redigrdt + "', 5000)", true);
        }
        else if (type == MessageType.Success)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "radalert", "showSuccess('" + message + "', '" + redigrdt + "', 5000)", true);
        }
        else if (type == MessageType.Warning)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "radalert", "showWarning('" + message + "', '" + redigrdt + "', 5000)", true);
        }
        else if (type == MessageType.Info)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "radalert", "showInfo('" + message + "', '" + redigrdt + "', 5000)", true);
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