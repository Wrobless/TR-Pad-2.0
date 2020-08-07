#property strict

#include <defines.mqh>
#include <texts.mqh>
#include <TRPad.mqh>
#include <TRIndicator.mqh>
#include <Controls/Rect.mqh>
#include <Controls/Label.mqh>

extern double inpLot = 1.0;           // Number of lots
extern double inpStopLoss = 1500.0;   // Stop loss level
extern double inpTakeProfit = 4500.0; // Take profit level
extern int inpSlippage = 0;           // Slippage value
extern int inpMaxNumberOfOrders = 2;  // Maximum number of open orders
extern int inpBreakEvenOffset = 100;  // BreakEven offset value
extern int inpLimit = 10;             // Daily order limit

CTrade Trade(inpLot, inpStopLoss, inpTakeProfit, inpSlippage, inpMaxNumberOfOrders, inpBreakEvenOffset, inpLimit);
TRPad Panel(&Trade);
Indicator Labels();
// CRect last_panel_position;

int OnInit()
{
    if (!Panel.Create())
        return (INIT_FAILED);
    Labels.Create();
    
    // if (GlobalVariableCheck("left"))
    // {
    //     last_panel_position.left = (int)GlobalVariableGet("left");
    //     last_panel_position.top = (int)GlobalVariableGet("top");
    //     GlobalVariablesDeleteAll();
    //     Panel.SetPosition(last_panel_position);
    // }
    Panel.Run();

    return (INIT_SUCCEEDED);
}

void OnDeinit(const int reason)
{
    // last_panel_position = Panel.GetLastPosition();
    // GlobalVariableSet("left", (double)last_panel_position.left);
    // GlobalVariableSet("top", (double)last_panel_position.top);
    Panel.Destroy(reason);
}

void OnTick()
{
    Labels.UpdateValues();
}

void OnChartEvent(const int id, const long &lparam, const double &dparam, const string &sparam)
{
    Panel.OnEvent(id, lparam, dparam, sparam);
    Labels.OnEvent(id, lparam, dparam, sparam);
}