<%@ Page Language="C#" MasterPageFile="~/Principal.master" AutoEventWireup="true" CodeFile="ZonaProSoftOferta.aspx.cs" Inherits="ZonaProSoftOferta" Title="Comunicación y tecnología" %>
<%@ MasterType TypeName="Principal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadPlace" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyPlace" Runat="Server">
    <div class="BodyPlace">
        <asp:Panel ID="Panel1" CssClass="panelClisOn" runat="server">
            <asp:Label ID="Label1" runat="server" Text="<b>Oferta</b>"></asp:Label>
        </asp:Panel>            
        <asp:Panel ID="Panel2" CssClass="panelSolicitudes" runat="server">        
            <p>
                <asp:Label ID="Label5" runat="server" CssClass="labels2" Text="Cliente"></asp:Label>
                <asp:TextBox ID="txtBoxCli" CssClass="txtBoxPro" runat="server"
                    onkeyup="verClientes(this.value)" onfocus="mostrarListBoxClis()"></asp:TextBox>
                <asp:Label ID="errCustomer" runat="server" CssClass="etqError" Text="!"></asp:Label>                    
            </p>
            <p>
                <asp:Label ID="Label3" CssClass="labels2" runat="server" Text="Tipo"></asp:Label>
                <asp:DropDownList ID="ddTipo" runat="server" CssClass="dropdownCli" onchange="focusDescripcion()" 
                    onfocus="ocultarListBoxClis()">
                    <asp:ListItem Text="" Value="nil" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="Sitio Web" Value="Sitio Web"></asp:ListItem>
                    <asp:ListItem Text="Aplicación Windows" Value="Aplicación Windows"></asp:ListItem>
                </asp:DropDownList>
                <asp:Label ID="errTipo" runat="server" CssClass="etqError" Text="!"></asp:Label>                                    
            </p>                        
            <p>
                <asp:Label ID="Label4" CssClass="labels2" runat="server" Text="Descripción"></asp:Label>
                <asp:TextBox ID="txtDesc" runat="server" TextMode="MultiLine" CssClass="txtCli" Height="70" Text=""
                    onfocus="ocultarListBoxClis()"></asp:TextBox>
                <asp:Label ID="errDescripcion" runat="server" CssClass="etqError" Text="!"></asp:Label>                                    
            </p>    
            <p>
                <span class="chkbd">
                    <input id="chkpers" type="checkbox" name="ctl00$BodyPlace$chkpers" onfocus="ocultarListBoxClis()" />
                    <label for="chkpers">A medida</label>
                </span>            
            </p>            
            <p>
                <span class="chkbd">
                    <input id="chkbd" type="checkbox" name="ctl00$BodyPlace$chkbd" onclick="mostrarTipoBD()"
                        onfocus="ocultarListBoxClis()" />
                    <label for="chkbd">Conexión a base de datos</label>
                </span>            
            </p>
            <p>
                <asp:Label ID="lblTipobd" CssClass="labelTipoBD" runat="server" Text="Tipo de base de datos"></asp:Label>
                <asp:DropDownList ID="ddTipobd" runat="server" CssClass="dropdownTipoBD" onfocus="ocultarListBoxClis()">
                    <asp:ListItem Text="Cliente / Servidor" Value="Cliente / Servidor"></asp:ListItem>
                    <asp:ListItem Text="De escritorio" Value="De escritorio"></asp:ListItem>
                </asp:DropDownList>   
            </p>
            <p>
                <asp:Image ID="preloader" runat="server" ImageUrl="FOTOS/loading.gif" CssClass="preloader" />            
            </p>   
        </asp:Panel>                        
        <p>
            <input id="btnOfertar" type="button" value="Realizar oferta" class="Botonpedido" onclick="ofertarSoftware()" />
        </p>        
        <asp:ListBox ID="listBoxClis" CssClass="listBoxPro" runat="server" onclick="seleccionarCliente(this.value)">                
        </asp:ListBox>        
        <p>
            <asp:Label ID="lblEnviado" runat="server" Text="<b>Maika'i. Su oferta ha quedado registrada</b>" CssClass="enviado"></asp:Label>
        </p>                                                     
    </div>
</asp:Content>

