{
        "ActionErrorDetails": "@{union(result('Try'), result('Catch'))}",
        "ESTimestamp": "@convertTimeZone(utcNow(), 'UTC', 'Eastern Standard Time', 'yyyy-MM-ddTHH:mm:ss.fffffffZ')",
        "ESTimestamp@odata.type": "Edm.DateTime",
        "Errors": "",
        "Payload": "",
        "RowKey": "@guid()",
        "RunId": "@{workflow()['run']['name']}",
        "StatusCode": 500
    }
