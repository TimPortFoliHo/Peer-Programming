param (
    [string]$argument = ""
)

# Creating function testInternetAccess():
function testInternetAccess {
    try {
        # assign $url to google domain
        $url = "https://www.google.com"
        #using the cmdlet to send web request to check if a HTTP response can be obtained within 5 sec
        $response = Invoke-WebRequest -Uri $url -UseBasicParsing -TimeoutSec 5
        # if HTTP response status code is 200
        if ($response.StatusCode -eq 200) {
            Write-Output "Webpage was successfully obtained."
            Write-Output "HTTP Status code: $($response.StatusCode)"
        } else {
        # if HTTP response is successful but code not 200
            Write-Output "Web request successful."
            Write-Output "The HTTP Status code is $($response.StatusCode)."
        }
    } catch {
        # Output if no response from webpage "$_" - display details of why
        Write-Output "Web request unsuccessful: $_"
    }
}

# Creating function enableRestrictInternet():
function enableRestrictInternet {
    try {
        # Configuure the proxy to a fake, non-existent server "proxy"
        [System.Net.HttpWebRequest]::DefaultWebProxy = New-Object System.Net.WebProxy("http://proxy", $true)
        # if successful output:
        Write-Output "Internet access has been restricted."
    } catch {
        #else ouput:
        Write-Output "Failed to restrict internet access: $_"
    }
}

# Creating function resetRestrictInternet():
function resetRestrictInternet {
    try {
        # Remove the fake proxy to re-enable internet access
        [System.Net.HttpWebRequest]::DefaultWebProxy = New-Object System.Net.WebProxy($null)
        Write-Output "Internet access has been re-enabled."
    } catch {
        # Output if an error occurs while resetting the proxy
        Write-Output "Failed to reset internet access: $_"
    }
}
# Check the command line and present valid arguments
switch ($argument) {
    "testInternetAccess" {
        testInternetAccess
        break
    }
    "enableRestrictInternet" {
        enableRestrictInternet
        break
    }
    "resetRestrictInternet" {
        resetRestrictInternet
        break
    }
    default {
        # if invalid input, display options to users to select from
        Write-Output "Invalid argument. Please select from 'testInternetAccess', 'enableRestrictInternet' or 'resetRestrictInternet'."
        break
    }
}
