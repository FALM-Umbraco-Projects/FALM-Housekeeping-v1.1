<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cleanupVersionsByCount.aspx.cs" Inherits="FALMHousekeeping.versions.cleanupVersionsByCount" MasterPageFile="../../masterpages/umbracoPage.Master" Title="F.A.L.M. Housekeeping - Cleanup Versions by Count" %>

<%@ Register TagPrefix="cc1" Assembly="controls" Namespace="umbraco.uicontrols" %>

<asp:Content ID="cphHead" ContentPlaceHolderID="head" runat="server" />

<asp:Content ID="cphBody" ContentPlaceHolderID="body" runat="server">
	<cc1:UmbracoPanel ID="umbPanelCleanupVersionsByCount" Text="F.A.L.M. Housekeeping" runat="server" Width="612px" Height="600px" hasMenu="false">
		<cc1:Pane ID="PanelCleanupVersionsByCount" Style="padding-right: 10px; padding-left: 10px; padding-bottom: 10px; padding-top: 10px;" runat="server" CssClass="innerContent" Text="Cleanup versions by count">
			<p>With this tool you can cleanup the version history, keeping a given number of versions for each content node.</p>
			<p><em>Please note that Umbraco requires each node to have at least 2 versions (the currently published and the latest). These versions will never be deleted.</em><br /><br /></p>
			<p>
				Number of versions to keep:&nbsp;&nbsp;&nbsp;
				<asp:TextBox ID="txtNVer" Width="20" MaxLength="2" runat="server" />&nbsp;&nbsp;&nbsp;
				<asp:Button ID="btnClearVersions" runat="server" Text="Delete" OnClick="btnClearVersions_Click" /></p>
			<p>
				&nbsp;</p>
			<p>
				<asp:Literal ID="ltrlVersions" runat="server" Text="" /></p>
		</cc1:Pane>
	</cc1:UmbracoPanel>
</asp:Content>
