# Real-time Azure Resource Monitor

Powered by PowerShell [Azure Functions](https://docs.microsoft.com/azure/azure-functions/?WT.mc_id=functionsresourcemonitor-github-antchu), [Azure Event Grid](https://docs.microsoft.com/azure/event-grid/?WT.mc_id=functionsresourcemonitor-github-antchu), and [Azure SignalR Service](https://docs.microsoft.com/azure/azure-signalr/?WT.mc_id=functionsresourcemonitor-github-antchu)

## How does this work?

1. Resources are changed in an Azure subscription
1. Azure Event Grid reacts to event and triggers an Azure Function
1. PowerShell Azure Function retrieves more information about the resource
1. Function uses Azure SignalR Service output binding to send messages
1. Web client receives messages over WebSocket

**Check out [PowerShell for Azure Functions](https://docs.microsoft.com/azure/azure-functions/functions-create-first-function-powershell?WT.mc_id=functionsresourcemonitor-github-antchu) for more information**

![](powershell-func-resource-monitor.gif)