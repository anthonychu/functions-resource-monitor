param($eventGridEvent, $TriggerMetadata)

# Make sure to pass hashtables to Out-String so they're logged correctly
#$eventGridEvent | ConvertTo-Json 

$resourceId = $eventGridEvent.subject
$operationName = $eventGridEvent.data.operationName
$username = $eventGridEvent.data.claims["name"]
$eventType = $eventGridEvent.eventType
$timestamp = $eventGridEvent.eventTime

if ($eventType -ne "Microsoft.Resources.ResourceDeleteSuccess") {
    $resource = Get-AzResource -ResourceId $resourceId

    $resourceName = $resource.ResourceName
    $resourceGroupName = $resource.ResourceGroupName
    $location = $resource.Location
    $kind = $resource.Kind
}

#Write-Host "$($kind) $($location) $($operationName) $($username) $($eventType) $($timestamp)"

Push-OutputBinding -Name SignalRMessages -Value (@{
    Target = 'newResourceEvent'
    Arguments = , @{
        resourceGroupName = $resourceGroupName
        resourceName = $resourceName
        resourceId = $resourceId
        kind = $kind
        location = $location
        timestamp = $timestamp
        operationName = $operationName
        username = $username
        eventType = $eventType
    }
})
