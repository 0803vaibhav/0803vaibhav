param ($resourceGroupName, $logicAppName, $triggerName, $baseUrl, $pathUrl,$baseUrlv1, $tempUrl)				
    Install-Module Az.LogicApp -Scope CurrentUser -Force            
	$logicApp = Get-AzLogicApp -ResourceGroupName  $resourceGroupName -Name $logicAppName
	$triggerUrl = Get-AzLogicAppTriggerCallbackUrl -ResourceGroupName  $resourceGroupName -Name $logicAppName -TriggerName  $triggerName
	$triggerUrlValue = $triggerUrl.Value
	
	Write-Host 'Url for logic app - ' $logicAppName ' is = ' $triggerUrlValue
	
	$logicAppUri = [System.Uri]$triggerUrlValue
	$logicAppUriLocalPath = $logicAppUri.PathAndQuery
	$logicAppBaseUrl = $logicAppUri.GetLeftPart('Authority')
					

    $encodedUriPath = [System.Web.HttpUtility]::HtmlEncode($logicAppUriLocalPath)
	$encodedUriPathFull = [System.Web.HttpUtility]::HtmlEncode($logicAppUri)
	
	$varbaseUrlv1 = $encodedUriPathFull.Split('/',8)[0..5] -join '/'
	$vartempUrl = "/"
    $vartempUrl += $encodedUriPathFull.Split('/',8)[6..8] -join '/' 
	
	$vartempUrl = $vartempUrl -replace "2018-07-01-preview" , "2016-10-01"
    $encodedUriPath = $logicAppUriLocalPath -replace "2018-07-01-preview" , "2016-10-01"
	
    Write-Host 'Encoded Uri Path:' $encodedUriPath
    Write-Host 'Base Url:' $logicAppBaseUrl
	Write-Host 'Base Url V1 is:' $varbaseUrlv1
	Write-Host 'Temp URL is:' $vartempUrl
	

   
    Write-Host "##vso[task.setvariable variable=$($baseUrl)]$($logicAppBaseUrl)"    
    Write-Host "##vso[task.setvariable variable=$($pathUrl)]$($encodedUriPath)"
	Write-Host "##vso[task.setvariable variable=$($baseUrlv1)]$($varbaseUrlv1)"
	Write-Host "##vso[task.setvariable variable=$($tempUrl)]$($vartempUrl)"
	
	