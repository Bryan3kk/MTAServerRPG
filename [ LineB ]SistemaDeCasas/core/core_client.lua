local me       = getLocalPlayer();
local scX, scY = guiGetScreenSize();

local hc_gui   = {}; --house construction
local hc_edit  = {}; --edit fields
local hm_gui   = {}; --management

addEventHandler( 'onClientResourceStart', resourceRoot, function()
  hc_gui['main'] = guiCreateWindow( scX-310, scY/2-450/2, 300, 450, 'Criador de Casa', false );
  guiSetAlpha( hc_gui['main'], 1.0 );
  --Entrance--
  hc_gui['label_ec'] = guiCreateLabel( 0.042, 0.05, 0.4, 0.1, 'Coordenadas da entrada', true, hc_gui['main'] );
  guiLabelSetHorizontalAlign( hc_gui['label_ec'], 'center', true );
  hc_edit['edit_ec_X'] = guiCreateEdit( 0.063, 0.15, 0.39, 0.06, '', true, hc_gui['main'] );
  hc_edit['edit_ec_Y'] = guiCreateEdit( 0.063, 0.22, 0.39, 0.06, '', true, hc_gui['main'] );
  hc_edit['edit_ec_Z'] = guiCreateEdit( 0.063, 0.29, 0.39, 0.06, '', true, hc_gui['main'] );
  hc_gui['btn_ecPick'] = guiCreateButton( 0.063, 0.36, 0.39, 0.06, 'Pegar as coordenadas', true, hc_gui['main'] ); --1
  
  --Entrance teleport--
  hc_gui['label_etc'] = guiCreateLabel( 0.009, 0.45, 0.5, 0.1, 'Coordenadas teleporte dentro da casa', true, hc_gui['main'] );
  guiLabelSetHorizontalAlign( hc_gui['label_etc'], 'center', true );
  hc_edit['edit_etc_X'] = guiCreateEdit( 0.063, 0.55, 0.39, 0.06, '', true, hc_gui['main'] );
  hc_edit['edit_etc_Y'] = guiCreateEdit( 0.063, 0.62, 0.39, 0.06, '', true, hc_gui['main'] );
  hc_edit['edit_etc_Z'] = guiCreateEdit( 0.063, 0.69, 0.39, 0.06, '', true, hc_gui['main'] );
  hc_gui['btn_etcPick'] = guiCreateButton( 0.063, 0.76, 0.39, 0.06, 'Pegar as coordenadas', true, hc_gui['main'] ); --2
  
  --Exit--
  hc_gui['label_exc'] = guiCreateLabel( 0.55, 0.05, 0.4, 0.1, 'Coordenadas da Saida', true, hc_gui['main'] );
  guiLabelSetHorizontalAlign( hc_gui['label_exc'], 'center', true );
  hc_edit['edit_exc_X'] = guiCreateEdit( 0.55, 0.15, 0.39, 0.06, '', true, hc_gui['main'] );
  hc_edit['edit_exc_Y'] = guiCreateEdit( 0.55, 0.22, 0.39, 0.06, '', true, hc_gui['main'] );
  hc_edit['edit_exc_Z'] = guiCreateEdit( 0.55, 0.29, 0.39, 0.06, '', true, hc_gui['main'] );
  hc_gui['btn_excPick'] = guiCreateButton( 0.55, 0.36, 0.39, 0.06, 'Pegar as coordenadas', true, hc_gui['main'] ); --3
  
  --Exit teleport--
  hc_gui['label_extc'] = guiCreateLabel( 0.51, 0.45, 0.47, 0.1, 'Coordenadas teleporte fora da casa', true, hc_gui['main'] );
  guiLabelSetHorizontalAlign( hc_gui['label_extc'], 'center', true );
  hc_edit['edit_extc_X'] = guiCreateEdit( 0.55, 0.55, 0.39, 0.06, '', true, hc_gui['main'] );
  hc_edit['edit_extc_Y'] = guiCreateEdit( 0.55, 0.62, 0.39, 0.06, '', true, hc_gui['main'] );
  hc_edit['edit_extc_Z'] = guiCreateEdit( 0.55, 0.69, 0.39, 0.06, '', true, hc_gui['main'] );
  hc_gui['btn_extcPick'] = guiCreateButton( 0.55, 0.76, 0.39, 0.06, 'Pegar as coordenadas', true, hc_gui['main'] ); --4
  
  for i, v in pairs( hc_edit ) do guiEditSetReadOnly( v, true ); end;
  
  hc_gui['btn_close'] = guiCreateButton( 0.88, 0.915, 0.09, 0.05, 'X', true, hc_gui['main'] );
  hc_gui['btn_reset'] = guiCreateButton( 0.88-0.21, 0.915, 0.2, 0.05, 'Resetar', true, hc_gui['main'] );
  hc_gui['btn_create'] = guiCreateButton( 0.0, 0.915, 0.3, 0.05, 'Criar Casa', true, hc_gui['main'] );
  
  hc_gui['main_add'] = guiCreateWindow( scX-310-200, (scY/2-250/2)-450/4.5, 200, 250, 'Informacoes adicionais', false );
  
  hc_gui['edit_intID'] = guiCreateEdit( 0.09, 0.1, 0.35, 0.1, '', true, hc_gui['main_add'] );
  hc_gui['label_intID'] = guiCreateLabel( 0.57, 0.09, 0.3, 0.1, 'Interior ID', true, hc_gui['main_add'] );
  guiLabelSetVerticalAlign( hc_gui['label_intID'], 'center' );
  
  hc_gui['edit_dim'] = guiCreateEdit( 0.09, 0.25, 0.35, 0.1, '', true, hc_gui['main_add'] );
  hc_gui['label_dim'] = guiCreateLabel( 0.57, 0.249, 0.3, 0.1, 'Dimensao', true, hc_gui['main_add'] );
  guiLabelSetVerticalAlign( hc_gui['label_dim'], 'center' );
  
  hc_gui['edit_cost'] = guiCreateEdit( 0.09, 0.4, 0.45, 0.1, '', true, hc_gui['main_add'] );
  hc_gui['label_cost'] = guiCreateLabel( 0.57, 0.399, 0.3, 0.1, 'Preco R$', true, hc_gui['main_add'] );
  guiLabelSetVerticalAlign( hc_gui['label_cost'], 'center' );
  
  for i, v in pairs( hc_gui ) do
    guiSetFont( v, 'default-bold-small' );
    if getElementType( v ) == 'gui-button' then
      guiButtonSetColor( v, '0099FFFF' );
    end;
    if getElementType( v ) == 'gui-window' then
      guiWindowSetMovable( v, false );
      guiWindowSetSizable( v, false );
    end;
  end;
  
  guiSetVisible( hc_gui['main'], false );
  guiSetVisible( hc_gui['main_add'], false );
  
  addEventHandler( 'onClientGUIClick', hc_gui['btn_close'], function( btn )
    if btn ~= 'left' then return false; end;
    triggerEvent( 'HP_SetVisible', me, false );
  end, false );
    
  addEventHandler( 'onClientGUIClick', root, function( btn )
    if btn ~= 'left' then return false; end;
    if source == hc_gui['btn_ecPick'] then
      local x, y, z = getElementPosition( me );
      guiSetText( hc_edit['edit_ec_X'], x );
      guiSetText( hc_edit['edit_ec_Y'], y );
      guiSetText( hc_edit['edit_ec_Z'], z );
    elseif source == hc_gui['btn_etcPick'] then
      local x, y, z = getElementPosition( me );
      guiSetText( hc_edit['edit_etc_X'], x );
      guiSetText( hc_edit['edit_etc_Y'], y );
      guiSetText( hc_edit['edit_etc_Z'], z );
    elseif source == hc_gui['btn_excPick'] then
      local x, y, z = getElementPosition( me );
      guiSetText( hc_edit['edit_exc_X'], x );
      guiSetText( hc_edit['edit_exc_Y'], y );
      guiSetText( hc_edit['edit_exc_Z'], z );
    elseif source == hc_gui['btn_extcPick'] then
      local x, y, z = getElementPosition( me );
      guiSetText( hc_edit['edit_extc_X'], x );
      guiSetText( hc_edit['edit_extc_Y'], y );
      guiSetText( hc_edit['edit_extc_Z'], z );
    end;
  end );
  
  addEventHandler( 'onClientGUIClick', hc_gui['btn_reset'], function( btn )
    if btn ~= 'left' then return false; end;
    for i, v in pairs( hc_edit ) do
      guiSetText( v, '' );
    end;
    for i, v in pairs( hc_gui ) do
      if getElementType( v ) == 'gui-edit' then
        guiSetText( v, '' );
      end;
    end;
  end, false );
  
  addEventHandler( 'onClientGUIChanged', root, function()
    if source == hc_gui['edit_intID'] or source == hc_gui['edit_dim'] or source == hc_gui['edit_cost'] then
      local currText = guiGetText( source );
      local newText = string.gsub( currText, '[^0-9]', '' );
      if newText ~= currText then
        guiSetText( source, newText );
      end;
    end;
  end );
  
  addEventHandler( 'onClientGUIClick', hc_gui['btn_create'], function( btn )
    if btn ~= 'left' then return false; end;
    for i, v in pairs( hc_edit ) do
      if guiGetText( v ) == '' then
        outputChatBox( '* Todos os campos de edição deve ser preenchido!', 255, 51, 36 );
        return false;
      end;
    end;
    for i, v in pairs( hc_gui ) do
      if getElementType( v ) == 'gui-edit' and guiGetText( v ) == '' then
        outputChatBox( '* Todos os campos de edição deve ser preenchido!', 255, 51, 36 );
        return false;
      end;
    end;
    
    local tableToSend = {
      [1] = guiGetText( hc_edit['edit_ec_X'] ), [4] = guiGetText( hc_edit['edit_etc_X'] ),
      [2] = guiGetText( hc_edit['edit_ec_Y'] ), [5] = guiGetText( hc_edit['edit_etc_Y'] ),
      [3] = guiGetText( hc_edit['edit_ec_Z'] ), [6] = guiGetText( hc_edit['edit_etc_Z'] ),
      
      [7] = guiGetText( hc_edit['edit_exc_X'] ), [10] = guiGetText( hc_edit['edit_extc_X'] ),
      [8] = guiGetText( hc_edit['edit_exc_Y'] ), [11] = guiGetText( hc_edit['edit_extc_Y'] ),
      [9] = guiGetText( hc_edit['edit_exc_Z'] ), [12] = guiGetText( hc_edit['edit_extc_Z'] ),
      
      [13] = guiGetText( hc_gui['edit_intID'] ),
      [14] = guiGetText( hc_gui['edit_dim'] ),
      [15] = guiGetText( hc_gui['edit_cost'] )
    };
    
    for i, v in ipairs( tableToSend ) do tableToSend[ i ] = tonumber( tableToSend[ i ] ); end;
    
    triggerServerEvent( 'onPlayerAttemptCreateHouse', me, tableToSend );
    triggerEvent( 'HP_SetVisible', me, false );
    
  end, false );
  
  hm_gui['main'] = guiCreateWindow( scX-360, scY-390, 350, 390, 'Gestao de Casa', false );
  guiSetAlpha( hm_gui['main'], 1.0 );
  
  hm_gui['label_buy'] = guiCreateLabel( 0.03, 0.08, 0.255, 0.1, 'Comprar esta Casa', true, hm_gui['main'] );
  guiLabelSetHorizontalAlign( hm_gui['label_buy'], 'center', true );
  guiLabelSetColor( hm_gui['label_buy'], 0, 153, 255 );
  hm_gui['bck_buy'] = guiCreateGridList( 0.03, 0.15, 0.255, 0.255, true, hm_gui['main'] );
  hm_gui['icon_buy'] = guiCreateStaticImage( 0.005, 0.05, 1.0, 1.0, 'images/script/icon_buy.png', true, hm_gui['bck_buy'] );
  
  hm_gui['label_sale'] = guiCreateLabel( 0.365, 0.08, 0.255, 0.1, 'Vender esta casa', true, hm_gui['main'] );
  guiLabelSetHorizontalAlign( hm_gui['label_sale'], 'center', true );
  guiLabelSetColor( hm_gui['label_sale'], 0, 153, 255 );
  hm_gui['bck_sale'] = guiCreateGridList( 0.365, 0.15, 0.255, 0.255, true, hm_gui['main'] );
  hm_gui['icon_sale'] = guiCreateStaticImage( 0.005, 0.05, 1.0, 1.0, 'images/script/icon_sale.png', true, hm_gui['bck_sale'] );
  
  hm_gui['label_key'] = guiCreateLabel( 0.7, 0.08, 0.255, 0.1, 'Definir Senha', true, hm_gui['main'] );
  guiLabelSetHorizontalAlign( hm_gui['label_key'], 'center', true );
  guiLabelSetColor( hm_gui['label_key'], 0, 153, 255 );
  hm_gui['bck_key'] = guiCreateGridList( 0.7, 0.15, 0.255, 0.255, true, hm_gui['main'] );
  hm_gui['icon_key'] = guiCreateStaticImage( 0.005, 0.05, 1.0, 1.0, 'images/script/icon_key.png', true, hm_gui['bck_key'] );
  
  hm_gui['label_enter'] = guiCreateLabel( 0.03, 0.45, 0.265, 0.1, 'Entrar na Casa', true, hm_gui['main'] );
  guiLabelSetHorizontalAlign( hm_gui['label_enter'], 'center', true );
  guiLabelSetColor( hm_gui['label_enter'], 0, 153, 255 );
  hm_gui['bck_enter'] = guiCreateGridList( 0.03, 0.53, 0.255, 0.255, true, hm_gui['main'] );
  hm_gui['icon_enter'] = guiCreateStaticImage( 0.005, 0.05, 1.0, 1.0, 'images/script/icon_enter.png', true, hm_gui['bck_enter'] );
  
  hm_gui['label_newowner'] = guiCreateLabel( 0.365, 0.45, 0.255, 0.1, 'Definir novo Dono', true, hm_gui['main'] );
  guiLabelSetHorizontalAlign( hm_gui['label_newowner'], 'center', true );
  guiLabelSetColor( hm_gui['label_newowner'], 0, 153, 255 );
  hm_gui['bck_newowner'] = guiCreateGridList( 0.365, 0.53, 0.255, 0.255, true, hm_gui['main'] );
  hm_gui['icon_newowner'] = guiCreateStaticImage( 0.005, 0.05, 1.0, 1.0, 'images/script/icon_newowner.png', true, hm_gui['bck_newowner'] );
  
  hm_gui['label_destroy'] = guiCreateLabel( 0.68, 0.45, 0.295, 0.1, 'Destruir esta Casa', true, hm_gui['main'] );
  guiLabelSetHorizontalAlign( hm_gui['label_destroy'], 'center', true );
  guiLabelSetColor( hm_gui['label_destroy'], 0, 153, 255 );
  hm_gui['bck_destroy'] = guiCreateGridList( 0.7, 0.53, 0.255, 0.255, true, hm_gui['main'] );
  hm_gui['icon_destroy'] = guiCreateStaticImage( 0.005, 0.05, 1.0, 1.0, 'images/script/icon_destroy.png', true, hm_gui['bck_destroy'] );
  
  addEventHandler( 'onClientMouseEnter', root, function()
    for i, v in ipairs( { 'buy', 'sale', 'key', 'enter', 'newowner', 'destroy' } ) do
      if source == hm_gui['bck_'..v] or source == hm_gui['icon_'..v] then
        guiSetAlpha( hm_gui['icon_'..v], 0.5 );
        break;
      end;
    end;
  end );
  
  addEventHandler( 'onClientMouseLeave', root, function()
    for i, v in ipairs( { 'buy', 'sale', 'key', 'enter', 'newowner', 'destroy' } ) do
      if source == hm_gui['bck_'..v] or source == hm_gui['icon_'..v] then
        guiSetAlpha( hm_gui['icon_'..v], 1.0 );
        break;
      end;
    end;
  end );
  
  hm_gui['label_ID'] = guiCreateLabel( 0.05, 0.82, 0.25, 0.1, 'Casa ID: ', true, hm_gui['main'] );
  hm_gui['label_owner'] = guiCreateLabel( 0.05, 0.88, 0.25, 0.1, 'Dono da casa: ', true, hm_gui['main'] );
  hm_gui['label_price'] = guiCreateLabel( 0.34, 0.82, 0.30, 0.1, 'Preco da Casa R$: ', true, hm_gui['main'] );
  hm_gui['label_owner'] = guiCreateLabel( 0.25, 0.93, 0.60, 0.1, 'v1.1.0 Traduzida por [M]ister ', true, hm_gui['main'] );
  
  hm_gui['label_ID_dyn'] = guiCreateLabel( 0.22, 0.82, 0.25, 0.1, '0', true, hm_gui['main'] );
  hm_gui['label_owner_dyn'] = guiCreateLabel( 0.29, 0.88, 0.49, 0.1, 'none', true, hm_gui['main'] );
  hm_gui['label_price_dyn'] = guiCreateLabel( 0.64, 0.82, 0.35, 0.1, '0', true, hm_gui['main'] );
  
  hm_gui['btn_close'] = guiCreateButton( 0.89, 0.89, 0.07, 0.07, 'X', true, hm_gui['main'] );
  
  guiSetVisible( hm_gui['main'], false );
  
  addEventHandler( 'onClientGUIClick', hm_gui['btn_close'], function( btn )
    if btn ~= 'left' then return false; end;
    guiSetVisible( hm_gui['main'], false );
    triggerServerEvent( 'setFrozen', me, false );
    showCursor( false );
  end, false );
  
  addEventHandler( 'onClientGUIClick', root, function( btn )
    if btn ~= 'left' then return false; end;
    if source == hm_gui['icon_buy'] then
      guiSetVisible( hm_gui['main'], false );
      guiSetVisible( hm_gui['wnd_key_onBuy'], true );
      guiSetText( hm_gui['onBuy_edit'], 'Senha' );
      playSound( 'sounds/click_icon.wav' );
      guiSetInputEnabled( true );
    elseif source == hm_gui['icon_sale'] then
      guiSetVisible( hm_gui['main'], false );
      guiSetVisible( hm_gui['wnd_key_onSale'], true );
      guiSetText( hm_gui['onSale_edit'], 'Senha' );
      playSound( 'sounds/click_icon.wav' );
      guiSetInputEnabled( true );
    elseif source == hm_gui['icon_key'] then
      guiSetVisible( hm_gui['main'], false );
      guiSetVisible( hm_gui['wnd_key_onChange'], true );
      guiSetText( hm_gui['onChange_edit_Old'], 'Senha Antiga' );
      guiSetText( hm_gui['onChange_edit_New'], 'Nova Senha' );
      guiSetText( hm_gui['onChange_edit_RepeatNew'], 'Repita a nova Senha' );
      playSound( 'sounds/click_icon.wav' );
      guiSetInputEnabled( true );
    elseif source == hm_gui['icon_newowner'] then
      guiSetVisible( hm_gui['main'], false );
      guiSetVisible( hm_gui['wnd_key_onNewOwner'], true );
      guiSetText( hm_gui['onNewOwner_keyEdit'], 'Senha' );
      guiSetText( hm_gui['onNewOwner_nameEdit'], 'Nome de usuario' );
      playSound( 'sounds/click_icon.wav' );
      guiSetInputEnabled( true );
    elseif source == hm_gui['icon_destroy'] then
      guiSetVisible( hm_gui['main'], false );
      guiSetVisible( hm_gui['wnd_onDestroy'], true );
      playSound( 'sounds/click_icon.wav' );
    end;
  end );
  
  --Buy
  hm_gui['wnd_key_onBuy'] = guiCreateWindow( scX/2-250/2, scY/2-150/2, 250, 150, 'Chave | Senha', false );
  guiSetAlpha( hm_gui['wnd_key_onBuy'], 1.0 );
  hm_gui['onBuy_label'] = guiCreateLabel( 0.05, 0.15, 0.9, 0.4, "Você vai comprar a casa. Digite sua chave para que ninguém mais pode entrar nesta casa. Não esqueça!", true, hm_gui['wnd_key_onBuy'] ); 
  guiLabelSetHorizontalAlign( hm_gui['onBuy_label'], 'center', true );
  guiLabelSetColor( hm_gui['onBuy_label'], 0, 153, 255 );
  hm_gui['onBuy_edit'] = guiCreateEdit( 0.14, 0.5, 0.7, 0.15, '', true, hm_gui['wnd_key_onBuy'] );
  hm_gui['onBuy_confirm'] = guiCreateButton( 0.2, 0.75, 0.3, 0.15, 'Confirmar', true, hm_gui['wnd_key_onBuy'] );
  hm_gui['onBuy_cancel'] = guiCreateButton( 0.57, 0.75, 0.3, 0.15, 'Cancelar', true, hm_gui['wnd_key_onBuy'] );
  guiSetVisible( hm_gui['wnd_key_onBuy'], false );
  
  --Sale
  hm_gui['wnd_key_onSale'] = guiCreateWindow( scX/2-250/2, scY/2-150/2, 250, 150, 'Chave | Senha', false );
  guiSetAlpha( hm_gui['wnd_key_onSale'], 1.0 );
  hm_gui['onSale_label'] = guiCreateLabel( 0.05, 0.15, 0.9, 0.4, "Você vai vender esta casa na metade do seu preço. Digite sua chave para confirmar que você é o proprietário real.", true, hm_gui['wnd_key_onSale'] ); 
  guiLabelSetHorizontalAlign( hm_gui['onSale_label'], 'center', true );
  guiLabelSetColor( hm_gui['onSale_label'], 0, 153, 255 );
  hm_gui['onSale_edit'] = guiCreateEdit( 0.14, 0.5, 0.7, 0.15, '', true, hm_gui['wnd_key_onSale'] );
  hm_gui['onSale_confirm'] = guiCreateButton( 0.2, 0.75, 0.3, 0.15, 'Confirmar', true, hm_gui['wnd_key_onSale'] );
  hm_gui['onSale_cancel'] = guiCreateButton( 0.57, 0.75, 0.3, 0.15, 'Cancelar', true, hm_gui['wnd_key_onSale'] );
  guiSetVisible( hm_gui['wnd_key_onSale'], false );
  
  addEventHandler( 'onClientGUIClick', root, function( btn )
    if btn ~= 'left' then return false; end;
    if source == hm_gui['onBuy_edit'] then guiSetText( hm_gui['onBuy_edit'], '' ); end;
    if source == hm_gui['onBuy_confirm'] then
      local passTxt = guiGetText( hm_gui['onBuy_edit'] );
      if #passTxt >= getElementData( me, 'k_len' ) then
        if not passTxt:find( ' ' ) then
          triggerServerEvent( 'HOUSE_Buy', me, guiGetText( hm_gui['label_price_dyn'] ), guiGetText( hm_gui['onBuy_edit'] ) );
          guiSetText( hm_gui['onBuy_edit'], '' );
          guiSetVisible( hm_gui['wnd_key_onBuy'], false );
          showCursor( false );
          playSound( 'sounds/click_confirm.wav' );
          guiSetInputEnabled( false );
        else
          outputChatBox( '* A chave de casa não deve conter espaços!', 255, 51, 36 );
        end;
      else
        outputChatBox( '* O comprimento da chave deve ser de pelo menos '..tostring( getElementData( me, 'k_len' ) )..' characters long!', 255, 51, 36 );
      end;
    elseif source == hm_gui['onBuy_cancel'] then
      guiSetText( hm_gui['onBuy_edit'], '' );
      guiSetVisible( hm_gui['wnd_key_onBuy'], false );
      guiSetVisible( hm_gui['main'], true );
      guiSetInputEnabled( false );
    end;
  end );
  
  addEventHandler( 'onClientGUIClick', root, function( btn )
    if btn ~= 'left' then return false; end;
    if source == hm_gui['onSale_edit'] then guiSetText( hm_gui['onSale_edit'], '' ); end;
    if source == hm_gui['onSale_confirm'] then
      local mrk = getHouseByID( getElementData( me, 'mrk_in' ) );
      if guiGetText( hm_gui['onSale_edit'] ) == getElementData( mrk, 'HS_INFO' )[8] then
        triggerServerEvent( 'HOUSE_Sell', me );
        outputChatBox( '* Você acaba de vender a sua casa!', 255, 255, 0 );
        guiSetText( hm_gui['onSale_edit'], '' );
        guiSetVisible( hm_gui['wnd_key_onSale'], false );
        playSound( 'sounds/click_confirm.wav' );
        guiSetInputEnabled( false );
      else
        outputChatBox( '* Senha inválida!', 255, 51, 36 );
      end;
    elseif source == hm_gui['onSale_cancel'] then
      guiSetText( hm_gui['onSale_edit'], '' );
      guiSetVisible( hm_gui['wnd_key_onSale'], false );
      guiSetVisible( hm_gui['main'], true );
      guiSetInputEnabled( false );
    end;
  end );
  
  hm_gui['wnd_key_onChange'] = guiCreateWindow( scX/2-250/2, scY/2-250/2, 250, 250, 'Chave | Senha', false );
  guiSetAlpha( hm_gui['wnd_key_onChange'], 1.0 );
  hm_gui['onChange_label'] = guiCreateLabel( 0.05, 0.15, 0.9, 0.4, "Para alterar o seu tipo, chave em sua chave antiga e uma nova.", true, hm_gui['wnd_key_onChange'] ); 
  guiLabelSetHorizontalAlign( hm_gui['onChange_label'], 'center', true );
  guiLabelSetColor( hm_gui['onChange_label'], 0, 153, 255 );
  hm_gui['onChange_edit_Old'] = guiCreateEdit( 0.14, 0.3, 0.7, 0.1, 'Senha Antiga', true, hm_gui['wnd_key_onChange'] );
  hm_gui['onChange_edit_New'] = guiCreateEdit( 0.14, 0.45, 0.7, 0.1, 'Nova Senha', true, hm_gui['wnd_key_onChange'] );
  hm_gui['onChange_edit_RepeatNew'] = guiCreateEdit( 0.14, 0.6, 0.7, 0.1, 'Repita a nova senha', true, hm_gui['wnd_key_onChange'] );
  hm_gui['onChange_confirm'] = guiCreateButton( 0.2, 0.75, 0.29, 0.11, 'Confirmar', true, hm_gui['wnd_key_onChange'] );
  hm_gui['onChange_cancel'] = guiCreateButton( 0.525, 0.75, 0.29, 0.11, 'Cancelar', true, hm_gui['wnd_key_onChange'] );
  guiSetVisible( hm_gui['wnd_key_onChange'], false );
  
  addEventHandler( 'onClientGUIClick', root, function( btn )
    if btn ~= 'left' then return false; end;
    if source == hm_gui['onChange_edit_Old'] or source == hm_gui['onChange_edit_New'] or source == hm_gui['onChange_edit_RepeatNew'] then
      guiSetText( source, '' );
    elseif source == hm_gui['onChange_confirm'] then
      local mrk = getHouseByID( getElementData( me, 'mrk_in' ) );
      local currKey = getElementData( mrk, 'HS_INFO' )[8];
      if guiGetText( hm_gui['onChange_edit_Old'] ) == currKey then
        if #guiGetText( hm_gui['onChange_edit_New'] ) >= getElementData( me, 'k_len' ) then
          if guiGetText( hm_gui['onChange_edit_New'] ) == guiGetText( hm_gui['onChange_edit_RepeatNew'] ) then
            triggerServerEvent( 'HOUSE_ChangeKey', me, guiGetText( hm_gui['onChange_edit_RepeatNew'] ) );
            outputChatBox( '* Nova Senha foi definido para #00FF00'..guiGetText( hm_gui['onChange_edit_RepeatNew'] ), 255, 51, 36, true );
            guiSetText( hm_gui['onChange_edit_Old'], '' );
            guiSetText( hm_gui['onChange_edit_New'], '' );
            guiSetText( hm_gui['onChange_edit_RepeatNew'], '' );
            guiSetVisible( hm_gui['wnd_key_onChange'], false );
            guiSetVisible( hm_gui['main'], true );
            playSound( 'sounds/click_confirm.wav' );
            guiSetInputEnabled( false );
          else
            outputChatBox( '* As novas senhas são diferentes. Verifique sua semelhança!', 255, 51, 36 );
          end;
        else
          outputChatBox( '* O comprimento da senha deve ser de pelo menos '..tostring( getElementData( me, 'k_len' ) )..' characters long!', 255, 51, 36 );
        end;
      else
        outputChatBox( '* A senha velha é inválida!', 255, 51, 36 );
      end;
    elseif source == hm_gui['onChange_cancel'] then
      guiSetVisible( hm_gui['wnd_key_onChange'], false );
      guiSetText( hm_gui['onChange_edit_Old'], '' );
      guiSetText( hm_gui['onChange_edit_New'], '' );
      guiSetText( hm_gui['onChange_edit_RepeatNew'], '' );
      guiSetVisible( hm_gui['main'], true );
      guiSetInputEnabled( false );
    end;
  end );
  
  hm_gui['wnd_key_onNewOwner'] = guiCreateWindow( scX/2-250/2, scY/2-250/2, 250, 250, "Nome do novo Dono", false );
  guiSetAlpha( hm_gui['wnd_key_onNewOwner'], 1.0 );
  hm_gui['onNewOwner_label'] = guiCreateLabel( 0.05, 0.11, 0.9, 0.4, "Digite o nome do novo proprietário da conta e sua chave atual. NOTA: após esta operação não será o proprietário desta casa mais!", true, hm_gui['wnd_key_onNewOwner'] ); 
  guiLabelSetHorizontalAlign( hm_gui['onNewOwner_label'], 'center', true );
  guiLabelSetColor( hm_gui['onNewOwner_label'], 0, 153, 255 );
  hm_gui['onNewOwner_keyEdit'] = guiCreateEdit( 0.14, 0.45, 0.7, 0.1, 'Senha', true, hm_gui['wnd_key_onNewOwner'] );
  hm_gui['onNewOwner_nameEdit'] = guiCreateEdit( 0.14, 0.6, 0.7, 0.1, 'Nome de usuario', true, hm_gui['wnd_key_onNewOwner'] );
  hm_gui['onNewOwner_confirm'] = guiCreateButton( 0.2, 0.75, 0.27, 0.11, 'Confirmar', true, hm_gui['wnd_key_onNewOwner'] );
  hm_gui['onNewOwner_cancel'] = guiCreateButton( 0.5, 0.75, 0.27, 0.11, 'Cancelar', true, hm_gui['wnd_key_onNewOwner'] );
  guiSetVisible( hm_gui['wnd_key_onNewOwner'], false );
  
  addEventHandler( 'onClientGUIClick', root, function( btn )
    if btn ~= 'left' then return false; end;
    if source == hm_gui['onNewOwner_keyEdit'] or source == hm_gui['onNewOwner_nameEdit'] then
      guiSetText( source, '' );
    end;
  end );
  
  addEventHandler( 'onClientGUIClick', root, function( btn )
    if btn ~= 'left' then return false; end;
    if source == hm_gui['onNewOwner_confirm'] then
      if not guiGetText( hm_gui['onNewOwner_nameEdit'] ):find( ' ' ) then
        if guiGetText( hm_gui['onNewOwner_nameEdit'] ) ~= getPlayerName( me ) then
          if getPlayerByAccountName( guiGetText( hm_gui['onNewOwner_nameEdit'] ) ) then
            if guiGetText( hm_gui['onNewOwner_keyEdit'] ) == getElementData( getHouseByID( getElementData( me, 'mrk_in' ) ), 'HS_INFO' )[8] then
              triggerServerEvent( 'HOUSE_ChangeOwner', me, guiGetText( hm_gui['onNewOwner_nameEdit'] ) );
              outputChatBox( '* O novo proprietário da casa é #00FF00'..guiGetText( hm_gui['onNewOwner_nameEdit'] ):gsub( "%x%x%x%x%x%x", "" )..' for now!', 255, 51, 36, true );
              guiSetText( hm_gui['onNewOwner_nameEdit'], '' );
              guiSetVisible( hm_gui['wnd_key_onNewOwner'], false );
              playSound( 'sounds/click_confirm.wav' );
              guiSetInputEnabled( false );
            else
              outputChatBox( '* Chave inválida! Tente novamente.', 255, 51, 36 );
              guiSetText( hm_gui['onNewOwner_nameEdit'], '' );
              guiSetText( hm_gui['onNewOwner_keyEdit'], '' );
            end;
          else
            outputChatBox( '* Nenhum jogador foi encontrado!', 255, 51, 36 );
          end;
        end;
      else
        outputChatBox( "* The new owner's name must not contain spaces!", 255, 51, 36 );
      end;
    elseif source == hm_gui['onNewOwner_cancel'] then
      guiSetText( hm_gui['onNewOwner_keyEdit'], '' );
      guiSetText( hm_gui['onNewOwner_nameEdit'], '' );
      guiSetVisible( hm_gui['wnd_key_onNewOwner'], false );
      guiSetVisible( hm_gui['main'], true );
      guiSetInputEnabled( false );
    end;
  end );
  
  hm_gui['wnd_onDestroy'] = guiCreateWindow( scX/2-250/2, scY/2-150/2, 250, 150, 'Destruir a casa', false );
  guiSetAlpha( hm_gui['wnd_onDestroy'], 1.0 );
  hm_gui['onDestroy_label'] = guiCreateLabel( 0.05, 0.23, 0.9, 0.4, 'Tem certeza de que quer destruir esta casa?', true, hm_gui['wnd_onDestroy'] ); 
  guiLabelSetHorizontalAlign( hm_gui['onDestroy_label'], 'center', true );
  guiLabelSetColor( hm_gui['onDestroy_label'], 0, 153, 255 );
  hm_gui['onDestroy_confirm'] = guiCreateButton( 0.2, 0.65, 0.3, 0.15, 'Confirmar', true, hm_gui['wnd_onDestroy'] );
  hm_gui['onDestroy_cancel'] = guiCreateButton( 0.57, 0.65, 0.3, 0.15, 'Cancelar', true, hm_gui['wnd_onDestroy'] );
  guiSetVisible( hm_gui['wnd_onDestroy'], false );
  
  addEventHandler( 'onClientGUIClick', root, function( btn )
    if btn ~= 'left' then return false; end;
    if source == hm_gui['onDestroy_confirm'] then
      triggerServerEvent( 'HOUSE_Destroy', me );
      guiSetVisible( hm_gui['wnd_onDestroy'], false );
      showCursor( false );
      playSound( 'sounds/click_confirm.wav' );
    elseif source == hm_gui['onDestroy_cancel'] then
      guiSetVisible( hm_gui['wnd_onDestroy'], false );
      guiSetVisible( hm_gui['main'], true );
    end;
  end );
  
  hm_gui['wnd_key_onEnter'] = guiCreateWindow( scX/2-250/2, scY/2-150/2, 250, 150, 'Chave | Senha', false );
  guiSetAlpha( hm_gui['wnd_key_onEnter'], 1.0 );
  hm_gui['onEnter_label'] = guiCreateLabel( 0.05, 0.15, 0.9, 0.4, "Você vai entrar na casa. Digite sua chave, por favor:", true, hm_gui['wnd_key_onEnter'] ); 
  guiLabelSetHorizontalAlign( hm_gui['onEnter_label'], 'center', true );
  guiLabelSetColor( hm_gui['onEnter_label'], 0, 153, 255 );
  hm_gui['onEnter_edit'] = guiCreateEdit( 0.14, 0.5, 0.7, 0.15, '', true, hm_gui['wnd_key_onEnter'] );
  hm_gui['onEnter_confirm'] = guiCreateButton( 0.2, 0.75, 0.3, 0.15, 'Confirmar', true, hm_gui['wnd_key_onEnter'] );
  hm_gui['onEnter_cancel'] = guiCreateButton( 0.57, 0.75, 0.3, 0.15, 'Cancelar', true, hm_gui['wnd_key_onEnter'] );
  guiSetVisible( hm_gui['wnd_key_onEnter'], false );
  
  addEventHandler( 'onClientGUIClick', root, function( btn )
    if btn ~= 'left' then return false; end;
    if source == hm_gui['onEnter_edit'] then guiSetText( hm_gui['onEnter_edit'], '' ); end;
    if source == hm_gui['icon_enter'] then
      guiSetVisible( hm_gui['main'], false );
      guiSetVisible( hm_gui['wnd_key_onEnter'], true );
      guiSetText( hm_gui['onEnter_edit'], 'Senha' );
      playSound( 'sounds/click_icon.wav' );
      guiSetInputEnabled( true );
    elseif source == hm_gui['onEnter_confirm'] then
      local mrk = getHouseByID( getElementData( me, 'mrk_in' ) );
      if guiGetText( hm_gui['onEnter_edit'] ) == getElementData( mrk, 'HS_INFO' )[8] then
        guiSetVisible( hm_gui['wnd_key_onEnter'], false );
        showCursor( false );
        triggerServerEvent( 'HOUSE_Enter', me );
        playSound( 'sounds/click_confirm.wav' );
        guiSetInputEnabled( false );
      else
        outputChatBox( '* Chave inválida!', 255, 51, 36 );
      end;
    elseif source == hm_gui['onEnter_cancel'] then
      guiSetVisible( hm_gui['wnd_key_onEnter'], false );
      guiSetVisible( hm_gui['main'], true );
      guiSetInputEnabled( false );
    end;
  end );
  
  for i, v in pairs( hm_gui ) do
    guiSetFont( v, 'default-bold-small' );
    if getElementType( v ) == 'gui-button' then
      guiButtonSetColor( v, '0099FFFF' );
    end;
    if getElementType( v ) == 'gui-window' then
      guiWindowSetMovable( v, false );
      guiWindowSetSizable( v, false );
    end;
  end;
  
  setElementData( me, 'HP_Opened', false );
  if getElementData( me, 'mrk_in' ) then triggerServerEvent( 'setFrozen', me, false ); end;
end );

addEventHandler( 'onClientResourceStop', resourceRoot, function()
  if getElementData( me, 'mrk_in' ) then triggerServerEvent( 'setFrozen', me, false ); end;
end );

function getPlayerByAccountName( name )
  for i, v in ipairs( getElementsByType( 'player' ) ) do
    if getElementData( v, 'HS_accountName' ) == name then
      return v;
    end;
  end;
  return false;
end;

function guiButtonSetColor( btn, hex )
  guiSetProperty( btn, "HoverTextColour", string.sub( hex, 7, 8 )..string.sub( hex, 1, 6 ) );
end;

addEvent( 'HP_SetVisible', true );
addEventHandler( 'HP_SetVisible', root, function( state )
  guiSetVisible( hc_gui['main'], state );
  guiSetVisible( hc_gui['main_add'], state );
  showCursor( state );
  setElementData( me, 'HP_Opened', state );
  if state then
    bindKey( 'mouse2', 'down', showHide );
  else
    unbindKey( 'mouse2', 'down', showHide );
  end;
end );

function showHide()
  showCursor( not isCursorShowing() );
end;

local cursorOverGUI = false;
addEventHandler( 'onClientMouseEnter', root, function() cursorOverGUI = true; end );
addEventHandler( 'onClientMouseLeave', root, function() cursorOverGUI = false; end );

addEventHandler( 'onClientElementDataChange', me, function( name )
  if name == 'HP_Opened' then
    if getElementData( me, name ) then
      addEventHandler( 'onClientRender', root, drawCrsrInfo );
    else
      removeEventHandler( 'onClientRender', root, drawCrsrInfo );
    end;
  end;
end );

function drawCrsrInfo()
  if isCursorShowing() and not cursorOverGUI then
    local x, y = getCursorPosition();
    if x and y then
      dxDrawText( 'RMB para mostrar / ocultar o cursor', scX * x + 10, scY * y - 10, scX, scY, tocolor( 255, 255, 255, 255 ), 1, 'default', 'left', 'top', false, false, true );
    end;
  end;
end;

addEvent( 'openHouseManagementWnd', true );
addEventHandler('openHouseManagementWnd', root, function( rt, cursor )
  for i, cname in ipairs( { 'buy', 'sale', 'key', 'enter', 'newowner', 'destroy' } ) do
    guiSetEnabled( hm_gui['bck_'..cname], rt[i] );
    guiSetEnabled( hm_gui['icon_'..cname], rt[i] );
    if not rt[i] then
      guiSetAlpha( hm_gui['icon_'..cname], 0.3 );
    else
      guiSetAlpha( hm_gui['icon_'..cname], 1.0 );
    end;
  end;
  guiSetText( hm_gui['label_ID_dyn'], rt[7] );
  guiSetText( hm_gui['label_owner_dyn'], rt[8] );
  guiSetText( hm_gui['label_price_dyn'], rt[9] );
  guiSetVisible( hm_gui['main'], true );
  if cursor then showCursor( true ); end;
end );

addEventHandler( 'onClientPlayerWasted', me, function()
  for i, v in pairs( hc_gui ) do if getElementType( hc_gui[ i ] ) == 'gui-window' then guiSetVisible( hc_gui[ i ], false ); end; end;
  for i, v in pairs( hm_gui ) do if getElementType( hm_gui[ i ] ) == 'gui-window' then guiSetVisible( hm_gui[ i ], false ); end; end;
  if isCursorShowing() then showCursor( false ); end;
  triggerEvent( 'HP_SetVisible', me, false );
  guiSetInputEnabled( false );
end );

local l_w      = 64;
local l_h      = 64;
local l_ratio  = l_w / l_h;
local lscale_w = 1920 / scX;
l_w            = l_w / lscale_w;
l_h            = l_w / l_ratio;

addEventHandler( 'onClientRender', root, function()
  for i, v in ipairs( getElementsByType( 'marker', getResourceRootElement(), true ) ) do
    if getElementData( v, 'HS_INFO' ) then
      local x, y, z = getElementPosition( v );
      local cx, cy, cz = getCameraMatrix();
      if isLineOfSightClear( cx, cy, cz, x, y, z, false, false, false, false, false, false, false, v ) then
        local dist = getDistanceBetweenPoints3D( cx, cy, cz, x, y, z );
        if dist >= 5 and dist <= 15 then
          local px, py = getScreenFromWorldPosition( x, y, z + 1.8, 0.06 );
          if px then
            local owner = getElementData( v, 'HS_INFO' )[7];
            local price = getElementData( v, 'HS_INFO' )[6];
            local r, g, b = getMarkerColor( v );
            if r == 0 and g == 153 and b == 255 then
              r, g, b = 255, 255, 255;
            end;
            if owner then
              if owner == '' then owner = 'none'; end;
              dxDrawText( 'Proprietário: '..owner, px + 1, py + scY/38, px + 1, py + 1, tocolor( 0, 0, 0, 255 ), 1, 'default-bold', 'center', 'center', false, false );
              dxDrawText( 'Proprietário: '..owner, px, py + scY/38, px, py, tocolor( 255, 255, 255, 255 ), 1, 'default-bold', 'center', 'center', false, false );
              dxDrawText( 'Preço: R$ '..tostring( price ), px + 1, py + scY/15, px + 1, py + 1, tocolor( 0, 0, 0, 255 ), 1, 'default-bold', 'center', 'center', false, false );
              dxDrawText( 'Preço: R$ '..tostring( price ), px, py + scY/15, px, py, tocolor( 255, 255, 255, 255 ), 1, 'default-bold', 'center', 'center', false, false );
              dxDrawImage( px-l_w/2, py - scY/17, l_w, l_h, 'images/script/house_.png', 0, 0, 0, tocolor( r, g, b, 255 ) );
            end;
          end;
        end;
      end;
    end;
  end;
end );

function getHouseByID( ID )
  for i, v in ipairs( getElementsByType( 'marker', getResourceRootElement() ) ) do
    if getElementData( v, 'HS_INFO' ) then
      if getElementData( v, 'HS_INFO' )[9] == ID then
        return v;
      end;
    end;
  end;
  return false;
end;

bindKey( 'i', 'both', function( key, keyState )
  if keyState == 'down' then
    for k, v in ipairs ( getElementsByType( 'marker', getResourceRootElement() ) ) do
      if getElementData( v, 'HS_INFO' ) and getElementData( v, 'HS_INFO' )[7] then
        if getElementData( v, 'HS_INFO' )[7] ~= '' then
          createBlipAttachedTo( v, 32 );
        else
          createBlipAttachedTo( v, 31 );
        end;
      end;
    end;
  else
    for k, v in ipairs( getElementsByType( 'marker', getResourceRootElement() ) ) do
      if getElementData( v, 'HS_INFO' ) then
        for k, elem in ipairs( getAttachedElements( v ) ) do
          if getElementType( elem ) == 'blip' then
            destroyElement( elem );
          end;
        end;
      end;
    end;
  end;
end );