using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/UI }
using { /Fortnite.com/UI }
using { /UnrealEngine.com/Temporary/SpatialMath }

StoreUi := class(creative_device):

    # Set the Button device in the Editor to reference the device in the level
    @editable
    TeamA_Store : character_device = character_device{}
    @editable
    TeamB_Store : character_device = character_device{}
    @editable
    TeamC_Store : character_device = character_device{}
    @editable
    TeamD_Store : character_device = character_device{}
    
    @editable
    Wood_Dispenser:conditional_button_device = conditional_button_device{}

    @editable
    Meivan_rare_Dispenser:conditional_button_device = conditional_button_device{}
    @editable
    Tactical_rare_Dispenser:conditional_button_device = conditional_button_device{}
    @editable
    LeverAction_rare_Dispenser:conditional_button_device = conditional_button_device{}
    @editable
    Prime_rare_Dispenser:conditional_button_device = conditional_button_device{}
    @editable
    Pump_rare_Dispenser:conditional_button_device = conditional_button_device{}

    @editable
    Meivan_epic_Dispenser:conditional_button_device = conditional_button_device{}
    @editable
    Tactical_epic_Dispenser:conditional_button_device = conditional_button_device{}
    @editable
    LeverAction_epic_Dispenser:conditional_button_device = conditional_button_device{}
    @editable
    Prime_epic_Dispenser:conditional_button_device = conditional_button_device{}
    @editable
    Pump_epic_Dispenser:conditional_button_device = conditional_button_device{}

    @editable
    Meivan_legend_Dispenser:conditional_button_device = conditional_button_device{}
    @editable
    Tactical_legend_Dispenser:conditional_button_device = conditional_button_device{}
    @editable
    LeverAction_legend_Dispenser:conditional_button_device = conditional_button_device{}
    @editable
    Prime_legend_Dispenser:conditional_button_device = conditional_button_device{}
    @editable
    Pump_legend_Dispenser:conditional_button_device = conditional_button_device{}

    @editable
    Twinmag_rare_Dispenser:conditional_button_device = conditional_button_device{}
    @editable
    CombatSMG_rare_Dispenser:conditional_button_device = conditional_button_device{}
    @editable
    SilencerSMG_rare_Dispenser:conditional_button_device = conditional_button_device{}

    @editable
    Slapujuice_Dispenser:conditional_button_device = conditional_button_device{}
    @editable
    Slapfish_Dispenser:conditional_button_device = conditional_button_device{}
    @editable
    MiniPotion_Dispenser:conditional_button_device = conditional_button_device{}
    @editable
    DekaPotion_Dispenser:conditional_button_device = conditional_button_device{}
    @editable
    ChagSprash_Dispenser:conditional_button_device = conditional_button_device{}


    # 武器の宣言
    Assult<localizes> : message = "アサルトライフル"
    Cancel<localizes> : message = "キャンセル"
    SubMachineGun<localizes> : message ="サブマシンガン"
    ShotGun<localizes> : message ="ショットガン"
    Heal<localizes> : message = "回復"

    # SG系
    Meivan<localizes> : message ="メイヴァンショットガン"
    Tactical<localizes> : message ="タクティカルショットガン"
    LeverAction<localizes> : message ="レバーアクションショットガン"
    Prime<localizes> : message ="プライムショットガン"
    Pump<localizes> : message ="ポンプショットガン"

    # SMG系
    Twinmag<localizes> : message ="ツインマグSMG"
    CombatSMG<localizes> : message ="コンバットSMG"
    SilencerSMG<localizes> : message ="サイレンサー付きSMG"

    # 回復
    Slapujuice<localizes> : message = "スラープジュース"
    Slapfish<localizes> : message ="スラープフィッシュ"
    DekaPotion<localizes> : message ="シールドポーション(大)"
    MiniPotion<localizes> : message = "シールドポーション(小)"
    ChagSprash<localizes> : message = "チャグスプラッシュ"

    Wood<localizes> : message ="木"

    var MaybeMyUIPerPlayer : [player]?canvas = map{}

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends> : void =
        TeamA_Store.InteractedWithEvent.Subscribe(HandleButtonInteraction)
        TeamB_Store.InteractedWithEvent.Subscribe(HandleButtonInteraction)
        TeamC_Store.InteractedWithEvent.Subscribe(HandleButtonInteraction)
        TeamD_Store.InteractedWithEvent.Subscribe(HandleButtonInteraction)

    # A custom UI can only be associated with a specific player, and only that player can see it
    HandleButtonInteraction(Agent : agent) : void =
        if (Player := player[Agent], PlayerUI := GetPlayerUI[Player]):
            if (MyUI := MaybeMyUIPerPlayer[Player]?):
                PlayerUI.RemoveWidget(MyUI)
                if (set MaybeMyUIPerPlayer[Player] = false) {}
            else:
                OneUI := CreateOne()
                PlayerUI.AddWidget(OneUI, player_ui_slot{InputMode := ui_input_mode.All})
                if (set MaybeMyUIPerPlayer[Player] = option{OneUI}) {}
                
    CreateOne() : canvas =
        AssultrifleButton : button_loud = button_loud{DefaultText := Assult}
        CancelButton : button_loud = button_loud{DefaultText := Cancel}
        SubMachineButton : button_loud = button_loud{DefaultText := SubMachineGun}
        WoodButton : button_loud = button_loud{DefaultText := Wood}
        ShotGunButton : button_loud = button_loud{DefaultText := ShotGun}
        ShotGunButton.OnClick().Subscribe(BoardOne)
        AssultrifleButton.OnClick().Subscribe(BoardOne)
        CancelButton.OnClick().Subscribe(BoardOne)
        SubMachineButton.OnClick().Subscribe(BoardOne)
        WoodButton.OnClick().Subscribe(BoardOne)
            MyInteractableButtons : canvas = canvas:
                Slots := array:
                    canvas_slot:
                        Anchors := anchors{ Maximum:= vector2{X:=1.0, Y:=1.0} }
                        Offsets := margin{ Top:=100.0, Left:= 600.0, Right:=600.0, Bottom := -100.0 }
                        Widget := stack_box:
                            Orientation := orientation.Horizontal
                            Slots := array:
                                stack_box_slot:
                                    Widget := AssultrifleButton
                                stack_box_slot:
                                    Widget := WoodButton
                                stack_box_slot:
                                    Widget := SubMachineButton
                                stack_box_slot:
                                    Widget := ShotGunButton
                                stack_box_slot:
                                    Widget := CancelButton 
        return MyInteractableButtons

    CreateSG() : canvas =
            CancelButton : button_loud = button_loud{DefaultText := Cancel}
            MeivanButton : button_loud = button_loud{DefaultText := Meivan}
            PrimeButton : button_loud = button_loud{DefaultText := Prime}
            TacticalButton : button_loud = button_loud{DefaultText := Tactical}
            LeverActionButton : button_loud = button_loud{DefaultText := LeverAction}
            PumpButton : button_loud = button_loud{DefaultText := Pump}
            CancelButton.OnClick().Subscribe(BoardSG)
            PumpButton.OnClick().Subscribe(BoardSG)
            LeverActionButton.OnClick().Subscribe(BoardSG)
            TacticalButton.OnClick().Subscribe(BoardSG)
            PrimeButton.OnClick().Subscribe(BoardSG)
            MeivanButton.OnClick().Subscribe(BoardSG)
            MyInteractableButtons : canvas = canvas:
                Slots := array:
                    canvas_slot:
                        Anchors := anchors{ Maximum:= vector2{X:=1.0, Y:=1.0} }
                        Offsets := margin{ Top:=100.0, Left:= 250.0, Right:=600.0, Bottom := -100.0 }
                        Widget := stack_box:
                            Orientation := orientation.Horizontal
                            Slots := array:
                                stack_box_slot:
                                    Widget := PumpButton
                                stack_box_slot:
                                    Widget := LeverActionButton
                                stack_box_slot:
                                    Widget := PrimeButton
                                stack_box_slot:
                                    Widget := MeivanButton
                                stack_box_slot:
                                    Widget := TacticalButton
                                stack_box_slot:
                                    Widget := CancelButton 
        return MyInteractableButtons

    CreateHeal() : canvas =
            CancelButton : button_loud = button_loud{DefaultText := Cancel}
            SlapujuiceButton : button_loud = button_loud{DefaultText := Slapujuice}
            SlapfishButton : button_loud = button_loud{DefaultText := Slapfish}
            DekaPotionButton : button_loud = button_loud{DefaultText := DekaPotion}
            MiniPotionButton : button_loud = button_loud{DefaultText := MiniPotion}
            ChagSprashButton : button_loud = button_loud{DefaultText := ChagSprash}

            CancelButton.OnClick().Subscribe(BoardHeal)
            SlapujuiceButton.OnClick().Subscribe(BoardHeal)
            DekaPotionButton.OnClick().Subscribe(BoardHeal)
            SlapfishButton.OnClick().Subscribe(BoardHeal)
            MiniPotionButton.OnClick().Subscribe(BoardHeal)
            ChagSprashButton.OnClick().Subscribe(BoardHeal)
            MyInteractableButtons : canvas = canvas:
                Slots := array:
                    canvas_slot:
                        Anchors := anchors{ Maximum:= vector2{X:=1.0, Y:=1.0} }
                        Offsets := margin{ Top:=100.0, Left:= 250.0, Right:=600.0, Bottom := -100.0 }
                        Widget := stack_box:
                            Orientation := orientation.Horizontal
                            Slots := array:
                                stack_box_slot:
                                    Widget := MiniPotionButton
                                stack_box_slot:
                                    Widget := DekaPotionButton
                                stack_box_slot:
                                    Widget := ChagSprashButton
                                stack_box_slot:
                                    Widget := SlapfishButton
                                stack_box_slot:
                                    Widget := SlapujuiceButton
                                stack_box_slot:
                                    Widget := CancelButton 
            return MyInteractableButtons

    BoardOne(Message : widget_message ) : void =
        if (PlayerUI := GetPlayerUI[Message.Player], MyUI := MaybeMyUIPerPlayer[Message.Player]?, SelectedButton := text_button_base[Message.Source]):
            var ButtonText : string = SelectedButton.GetText()
            if ( ButtonText = "木"):
                Print("木を買う")

                Wood_Dispenser.Activate(Message.Player)
                PlayerUI.RemoveWidget(MyUI)
                if (set MaybeMyUIPerPlayer[Message.Player] = false) {}
                OneUI := CreateOne()
                PlayerUI.AddWidget(OneUI, player_ui_slot{InputMode := ui_input_mode.All})
                if (set MaybeMyUIPerPlayer[Message.Player] = option{OneUI}) {}

            else if (ButtonText = "ショットガン"):

                Print("これはショットガン")
                PlayerUI.RemoveWidget(MyUI)
                if (set MaybeMyUIPerPlayer[Message.Player] = false) {}

                SGUI := CreateSG()
                PlayerUI.AddWidget(SGUI, player_ui_slot{InputMode := ui_input_mode.All})
                if (set MaybeMyUIPerPlayer[Message.Player] = option{SGUI}) {}

            else if (ButtonText = "キャンセル"):
                Print("キャンセルだよ")
                PlayerUI.RemoveWidget(MyUI)
                if (set MaybeMyUIPerPlayer[Message.Player] = false) {}

            else:
                PlayerUI.RemoveWidget(MyUI)
                if (set MaybeMyUIPerPlayer[Message.Player] = false) {}

    BoardSG(Message : widget_message ) : void =
        if (PlayerUI := GetPlayerUI[Message.Player], MyUI := MaybeMyUIPerPlayer[Message.Player]?, SelectedButton := text_button_base[Message.Source]):
            var ButtonText : string = SelectedButton.GetText()
            if (ButtonText = "ポンプショットガン"):
                Pump_rare_Dispenser.Activate(Message.Player)
                Print("ポンプショットガン")

                PlayerUI.RemoveWidget(MyUI)
                if (set MaybeMyUIPerPlayer[Message.Player] = false) {}
                OneUI := CreateSG()
                PlayerUI.AddWidget(OneUI, player_ui_slot{InputMode := ui_input_mode.All})
                if (set MaybeMyUIPerPlayer[Message.Player] = option{OneUI}) {}

            else if (ButtonText = "レバーアクションショットガン"):
                LeverAction_rare_Dispenser.Activate(Message.Player)
                Print("レバーアクションショットガン")

                PlayerUI.RemoveWidget(MyUI)
                if (set MaybeMyUIPerPlayer[Message.Player] = false) {}
                OneUI := CreateSG()
                PlayerUI.AddWidget(OneUI, player_ui_slot{InputMode := ui_input_mode.All})
                if (set MaybeMyUIPerPlayer[Message.Player] = option{OneUI}) {}

            else if (ButtonText = "メイヴァンショットガン"):
                Meivan_rare_Dispenser.Activate(Message.Player)
                Print("メイヴァンショットガン")

                PlayerUI.RemoveWidget(MyUI)
                if (set MaybeMyUIPerPlayer[Message.Player] = false) {}
                OneUI := CreateSG()
                PlayerUI.AddWidget(OneUI, player_ui_slot{InputMode := ui_input_mode.All})
                if (set MaybeMyUIPerPlayer[Message.Player] = option{OneUI}) {}
                
            else if (ButtonText = "タクティカルショットガン"):
                Tactical_rare_Dispenser.Activate(Message.Player)
                Print("タクティカルショットガン")
                
                PlayerUI.RemoveWidget(MyUI)
                if (set MaybeMyUIPerPlayer[Message.Player] = false) {}
                OneUI := CreateSG()
                PlayerUI.AddWidget(OneUI, player_ui_slot{InputMode := ui_input_mode.All})
                if (set MaybeMyUIPerPlayer[Message.Player] = option{OneUI}) {}
                
            else if (ButtonText = "プライムショットガン"):
                Prime_rare_Dispenser.Activate(Message.Player)
                Print("プライムショットガン")
                
                PlayerUI.RemoveWidget(MyUI)
                if (set MaybeMyUIPerPlayer[Message.Player] = false) {}
                OneUI := CreateSG()
                PlayerUI.AddWidget(OneUI, player_ui_slot{InputMode := ui_input_mode.All})
                if (set MaybeMyUIPerPlayer[Message.Player] = option{OneUI}) {}
                
            else if (ButtonText = "キャンセル"):
                Print("キャンセル")
                PlayerUI.RemoveWidget(MyUI)
                if (set MaybeMyUIPerPlayer[Message.Player] = false) {}
            else:
                PlayerUI.RemoveWidget(MyUI)
                if (set MaybeMyUIPerPlayer[Message.Player] = false) {}


    BoardHeal(Message : widget_message ) : void =
        if (PlayerUI := GetPlayerUI[Message.Player], MyUI := MaybeMyUIPerPlayer[Message.Player]?, SelectedButton := text_button_base[Message.Source]):
            var ButtonText : string = SelectedButton.GetText()
            if (ButtonText = "チャグスプラッシュ"):
                ChagSprash_Dispenser.Activate(Message.Player)
                Print("チャグスプラッシュ")

                PlayerUI.RemoveWidget(MyUI)
                if (set MaybeMyUIPerPlayer[Message.Player] = false) {}
                OneUI := CreateHeal()
                PlayerUI.AddWidget(OneUI, player_ui_slot{InputMode := ui_input_mode.All})
                if (set MaybeMyUIPerPlayer[Message.Player] = option{OneUI}) {}

            else if (ButtonText = "シールドポーション(小)"):
                MiniPotion_Dispenser.Activate(Message.Player)
                Print("シールドポーション(小)")

                PlayerUI.RemoveWidget(MyUI)
                if (set MaybeMyUIPerPlayer[Message.Player] = false) {}
                OneUI := CreateHeal()
                PlayerUI.AddWidget(OneUI, player_ui_slot{InputMode := ui_input_mode.All})
                if (set MaybeMyUIPerPlayer[Message.Player] = option{OneUI}) {}

            else if (ButtonText = "シールドポーション(大)"):
                DekaPotion_Dispenser.Activate(Message.Player)
                Print("シールドポーション(大)")

                PlayerUI.RemoveWidget(MyUI)
                if (set MaybeMyUIPerPlayer[Message.Player] = false) {}
                OneUI := CreateHeal()
                PlayerUI.AddWidget(OneUI, player_ui_slot{InputMode := ui_input_mode.All})
                if (set MaybeMyUIPerPlayer[Message.Player] = option{OneUI}) {}
                
            else if (ButtonText = "スラープフィッシュ"):
                Slapfish_Dispenser.Activate(Message.Player)
                Print("スラープフィッシュ")
                
                PlayerUI.RemoveWidget(MyUI)
                if (set MaybeMyUIPerPlayer[Message.Player] = false) {}
                OneUI := CreateHeal()
                PlayerUI.AddWidget(OneUI, player_ui_slot{InputMode := ui_input_mode.All})
                if (set MaybeMyUIPerPlayer[Message.Player] = option{OneUI}) {}
                
            else if (ButtonText = "スラープジュース"):
                Slapujuice_Dispenser.Activate(Message.Player)
                Print("スラープジュース")
                
                PlayerUI.RemoveWidget(MyUI)
                if (set MaybeMyUIPerPlayer[Message.Player] = false) {}
                OneUI := CreateHeal()
                PlayerUI.AddWidget(OneUI, player_ui_slot{InputMode := ui_input_mode.All})
                if (set MaybeMyUIPerPlayer[Message.Player] = option{OneUI}) {}
                
            else if (ButtonText = "キャンセル"):
                Print("キャンセル")
                PlayerUI.RemoveWidget(MyUI)
                if (set MaybeMyUIPerPlayer[Message.Player] = false) {}
            else:
                PlayerUI.RemoveWidget(MyUI)
                if (set MaybeMyUIPerPlayer[Message.Player] = false) {}

