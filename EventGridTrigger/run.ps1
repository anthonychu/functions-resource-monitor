param($eventGridEvent, $TriggerMetadata)

$resourceId = $eventGridEvent.subject
$eventType = $eventGridEvent.eventType

if ($eventType -ne "Microsoft.Resources.ResourceDeleteSuccess") {
    $resource = Get-AzResource -ResourceId $resourceId
}

Push-OutputBinding -Name SignalRMessages -Value (@{
    Target = 'newResourceEvent'
    Arguments = , @{
        resourceGroupName = $resource.ResourceGroupName
        resourceName = $resource.ResourceName
        resourceId = $resourceId
        resourceProvider = $eventGridEvent.data.resourceProvider
        location = $resource.Location
        timestamp = $eventGridEvent.eventTime
        operationName = $eventGridEvent.data.operationName
        username = $eventGridEvent.data.claims["name"]
        eventType = $eventGridEvent.eventType
    }
})
