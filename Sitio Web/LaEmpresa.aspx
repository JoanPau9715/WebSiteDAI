<%@ Page Language="C#" MasterPageFile="~/Principal.master" AutoEventWireup="true" CodeFile="LaEmpresa.aspx.cs" Inherits="LaEmpresa" Title="Página sin título" %>
<%@ MasterType TypeName="Principal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadPlace" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyPlace" Runat="Server">
    <div class="BodyPlace">
        <asp:Panel ID="Panel1" CssClass="panelClisOn" runat="server">
            <asp:Label ID="Label1" runat="server" Text="<b>2011 ©</b>"></asp:Label>        
            <br /><br />
            Non Commercial Web Site. Comunicación y Tecnología
        </asp:Panel>
    </div>
</asp:Content>

