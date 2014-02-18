<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="viewLogs.aspx.cs" Inherits="FALMHousekeeping.logs.showLogs" MasterPageFile="../../masterpages/umbracoPage.Master" Title="F.A.L.M. Housekeeping - Show Logs" %>

<%@ Register TagPrefix="cc1" Assembly="controls" Namespace="umbraco.uicontrols" %>
<%@ Register TagPrefix="cc2" Assembly="cms" Namespace="umbraco.controls" %>

<asp:Content ID="cphHead" ContentPlaceHolderID="head" runat="server" >
</asp:Content>

<asp:Content ID="cphBody" ContentPlaceHolderID="body" runat="server">
	<cc1:UmbracoPanel ID="umbPanelShowLogs" Text="F.A.L.M. Housekeeping" runat="server" Width="612px" Height="600px" hasMenu="false">
		<cc1:Pane ID="PanelShowLogs" Style="padding-right: 10px; padding-left: 10px; padding-bottom: 10px; padding-top: 10px;" runat="server" CssClass="innerContent" Text="Show logs">
			<asp:Table ID="tblFilter" runat="server">
				<asp:TableRow>
					<asp:TableCell>
						<small>Filter by nodeId</small>
					</asp:TableCell>
					<asp:TableCell>
						<small>Filter by user</small>
					</asp:TableCell>
					<asp:TableCell>
						<small>Filter by log type</small>
					</asp:TableCell>
					<asp:TableCell>
						<small>Filter by date range (from)</small>
					</asp:TableCell>
					<asp:TableCell>
						<small>Filter by date range (to)</small>
					</asp:TableCell>
				</asp:TableRow>
				<asp:TableRow>
					<asp:TableCell>
						<asp:TextBox ID="txtbNodeID" runat="server" />
					</asp:TableCell>
					<asp:TableCell>
						<asp:DropDownList ID="ddlUsers" AppendDataBoundItems="true" runat="server" DataSourceID="SqlDataSourceUsers" DataTextField="userName" DataValueField="Id">
							<asp:ListItem Text="-- Any --" Value="any" />
						</asp:DropDownList>
						<asp:SqlDataSource ID="SqlDataSourceUsers" runat="server" ConnectionString="<%$ appSettings:umbracoDbDSN %>" SelectCommand="SELECT Id, userName FROM umbracoUser ORDER BY userName" />
					</asp:TableCell>
					<asp:TableCell>
						<asp:DropDownList ID="ddlLogTypes" AppendDataBoundItems="true" runat="server">
							<asp:ListItem Text="-- Any --" Value="any" />
						</asp:DropDownList>
					</asp:TableCell>
					<asp:TableCell>
						<cc2:datePicker ID="dtpckrDateFrom" runat="server" />
					</asp:TableCell>
					<asp:TableCell>
						<cc2:datePicker ID="dtpckrDateTo" runat="server" />
					</asp:TableCell>
				</asp:TableRow>
				<asp:TableRow>
					<asp:TableCell ColumnSpan="4">
						<asp:Button ID="btnShowLog" runat="server" Text="Show Logs" OnClick="btnShowLogs_Click" />
					</asp:TableCell>
				</asp:TableRow>
			</asp:Table>
			<p>
				<asp:Literal ID="ltrlLogInfo" runat="server" Text="" Visible="false" /></p>
			<asp:GridView ID="gvLogTypesList" runat="server" AutoGenerateColumns="False" AllowPaging="True" AllowCustomPaging="False" AllowSorting="True" PageSize="20" BackColor="#FFFFFF" BorderColor="#DEDFDE" BorderWidth="1" GridLines="Both" CellPadding="4" ForeColor="#000000" OnSorting="gvLogTypesList_Sorting" OnPageIndexChanging="gvLogTypesList_PageIndexChanging" >
				<RowStyle BackColor="#F7F7DE" />
				<HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="#FFFFFF" HorizontalAlign="Center" Wrap="false" />
				<AlternatingRowStyle BackColor="White" />
				<PagerSettings Mode="NumericFirstLast" FirstPageText="First" LastPageText="Last" />
				<PagerStyle BackColor="#6B696B" ForeColor="#FFFFFF" HorizontalAlign="Right" />
				<FooterStyle BackColor="#CCCC99" />
				<Columns>
					
					<asp:TemplateField SortExpression="UserName asc" HeaderText="User Name" >
						<HeaderStyle Width="10%" />
						<ItemTemplate>
							<%# Eval("UserName", "{0}")%>
						</ItemTemplate>
					</asp:TemplateField>
					
					<asp:TemplateField SortExpression="NodeId asc" HeaderText="Node Id" >
						<HeaderStyle Width="5%" />
						<ItemTemplate>
							<%# Eval("NodeId", "{0}")%>
						</ItemTemplate>
					</asp:TemplateField>
					
					<asp:TemplateField SortExpression="NodeName asc" HeaderText="Node Name" >
						<HeaderStyle Width="26%" />
						<ItemTemplate>
							<%# Eval("NodeName", "{0}").Replace("SYSTEM DATA: umbraco master root", "")%>
						</ItemTemplate>
					</asp:TemplateField>
					
					<asp:TemplateField SortExpression="DateStamp asc" HeaderText="Log Date" >
						<HeaderStyle Width="9%" />
						<ItemTemplate>
							<%# convertToShortDateTime(Eval("DateStamp", "{0}"))%></ItemTemplate>
					</asp:TemplateField>
					
					<asp:TemplateField SortExpression="logHeader asc" HeaderText="Log Type" >
						<HeaderStyle Width="10%" />
						<ItemTemplate>
							<%# Eval("logHeader", "{0}")%>
						</ItemTemplate>
					</asp:TemplateField>
					
					<asp:TemplateField SortExpression="logComment asc" HeaderText="Log Detail" >
						<HeaderStyle Width="40%" />
						<ItemTemplate>
							<%# Eval("logComment", "{0}")%>
						</ItemTemplate>
					</asp:TemplateField>
					
				</Columns>
				<EmptyDataTemplate><strong>There are no logs to show.</strong></EmptyDataTemplate>
			</asp:GridView>
		</cc1:Pane>
	</cc1:UmbracoPanel>
</asp:Content>