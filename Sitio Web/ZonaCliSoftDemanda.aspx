<%@ Page Language="C#" MasterPageFile="~/Principal.master" AutoEventWireup="true" CodeFile="ZonaCliSoftDemanda.aspx.cs" Inherits="Customers_SoftDemanda" Title="Comunicación y tecnología" %>
<%@ MasterType TypeName="Principal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadPlace" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyPlace" Runat="Server">
    <div class="BodyPlace">
        <asp:Panel ID="Panel1" CssClass="panelClisOn" runat="server">
            <asp:Label ID="Label1" runat="server" Text="<b>Solicitud</b>"></asp:Label>
        </asp:Panel>            
        <asp:Panel ID="Panel2" CssClass="panelSolicitudes" runat="server">        
            <p>
                <asp:Label ID="Label5" runat="server" CssClass="labels2" Text="Programador"></asp:Label>
                <asp:TextBox ID="txtBoxPro" CssClass="txtBoxPro" runat="server" onkeyup="verProgramadores(this.value)" 
                    onfocus="mostrarListBoxPros()"></asp:TextBox>
                <asp:Label ID="errProgrammer" runat="server" CssClass="etqError" Text="!"></asp:Label>                    
            </p>
            <p>
                <asp:Label ID="Label3" CssClass="labels2" runat="server" Text="Tipo"></asp:Label>
                <asp:DropDownList ID="ddTipo" runat="server" CssClass="dropdownCli" onchange="focusDescripcion()"
                    onfocus="ocultarListBoxPros()">
                    <asp:ListItem Text="" Value="nil" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="Sitio Web" Value="Sitio Web"></asp:ListItem>
                    <asp:ListItem Text="Aplicación Windows" Value="Aplicación Windows"></asp:ListItem>
                </asp:DropDownList>
                <asp:Label ID="errTipo" runat="server" CssClass="etqError" Text="!"></asp:Label>                                    
            </p>                        
            <p>
                <asp:Label ID="Label4" CssClass="labels2" runat="server" Text="Descripción"></asp:Label>
                <asp:TextBox ID="txtDesc" runat="server" TextMode="MultiLine" CssClass="txtCli" Height="70"
                 onfocus="ocultarListBoxPros()" Text=""></asp:TextBox>
                <asp:Label ID="errDescripcion" runat="server" CssClass="etqError" Text="!"></asp:Label>                                    
            </p>    
            <p>
                <span class="chkbd">
                    <input id="chkbd" type="checkbox" name="ctl00$BodyPlace$chkbd" onclick="mostrarTipoBD()"
                    onfocus="ocultarListBoxPros()"/>
                    <label for="chkbd">Conexión a base de datos</label>
                </span>            
            </p>
            <p>
                <asp:Label ID="lblTipobd" CssClass="labelTipoBD" runat="server" Text="Tipo de base de datos"></asp:Label>
                <asp:DropDownList ID="ddTipobd" runat="server" CssClass="dropdownTipoBD" onfocus="ocultarListBoxPros()">
                    <asp:ListItem Text="Cliente / Servidor" Value="Cliente / Servidor"></asp:ListItem>
                    <asp:ListItem Text="De escritorio" Value="De escritorio"></asp:ListItem>
                </asp:DropDownList>   
            </p>
            <p>
                <asp:Image ID="preloader" runat="server" ImageUrl="FOTOS/loading.gif" CssClass="preloader" />            
            </p>   
        </asp:Panel>                        
        <p>
            <input id="btnSolicitar" type="button" value="Realizar pedido" onclick="demandarSoftware()" class="Botonpedido" />
        </p>        
        <asp:ListBox ID="listBoxPros" CssClass="listBoxPro" runat="server" onclick="seleccionarProgramador(this.value)">                
        </asp:ListBox>        
        <p>
            <asp:Label ID="lblEnviado" runat="server" Text="<b>Maika'i. Su solicitud ha quedado registrada</b>" CssClass="enviado"></asp:Label>
        </p>                                                     
    </div>
</asp:Content>

