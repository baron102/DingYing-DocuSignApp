# Updating Individual Permissions

# Check that we're in a bash shell
if [[ $SHELL != *"bash"* ]]; then
  echo "PROBLEM: Run these scripts from within the bash shell."
fi

# Check that we have a profile id
if [ ! -f config/PROFILE_ID ]; then
    echo ""
    echo "PROBLEM: Permission profile Id is needed. To fix: execute script eg024CreateingPermissionProfiles.sh"
    echo ""
    exit -1
fi


# Step 1: Obtain your OAuth token
# Note: Substitute these values with your own
# Set up variables for full code example
ACCESS_TOKEN=$(cat config/ds_access_token.txt)
account_id=$(cat config/API_ACCOUNT_ID)
permission_profile_id=`cat config/PROFILE_ID`
profile_name=`cat config/PROFILE_NAME`
base_path="https://demo.docusign.net/restapi"

# Step 2: Construct your API headers
declare -a Headers=('--header' "Authorization: Bearer ${ACCESS_TOKEN}" \
					'--header' "Accept: application/json" \
					'--header' "Content-Type: application/json")

# Step 3: Construct the request body for your pemisison profile
# Create a temporary file to store the request body
request_data=$(mktemp /tmp/request-perm-001.XXXXXX)
printf \
'{

   "permissionProfileName": "'"${profile_name} - updated $(date +%Y-%m-%d-%H:%M:%S) "'",
    "settings" : { 
        "useNewDocuSignExperienceInterface":0,
        "allowBulkSending":"true",
        "allowEnvelopeSending":"true",
        "allowSignerAttachments":"true",
        "allowTaggingInSendAndCorrect":"true",
        "allowWetSigningOverride":"true",
        "allowedAddressBookAccess":"personalAndShared",
        "allowedTemplateAccess":"share",
        "enableRecipientViewingNotifications":"true",
        "enableSequentialSigningInterface":"true",
        "receiveCompletedSelfSignedDocumentsAsEmailLinks":"false",
        "signingUiVersion":"v2",
        "useNewSendingInterface":"true",
        "allowApiAccess":"true",
        "allowApiAccessToAccount":"true",
        "allowApiSendingOnBehalfOfOthers":"true",
        "allowApiSequentialSigning":"true",
        "enableApiRequestLogging":"true",
        "allowDocuSignDesktopClient":"false",
        "allowSendersToSetRecipientEmailLanguage":"true",
        "allowVaulting":"false",
        "allowedToBeEnvelopeTransferRecipient":"true",
        "enableTransactionPointIntegration":"false",
        "powerFormRole":"admin",
        "vaultingMode":"none"
    }
}' >> $request_data

# Step 4: a) Call the eSignature API
#         b) Display the JSON response    
# Create a temporary file to store the response
response=$(mktemp /tmp/response-perm.XXXXXX)

Status=$(curl -w '%{http_code}' -i --request POST ${base_path}/v2.1/accounts/${account_id}/permission_profiles/${permission_profile_id} \
     "${Headers[@]}" \
     --data-binary @${request_data} \
     --output ${response})

# If the Status code returned is greater than 399, display an error message along with the API response
if [[ "$Status" -gt "399" ]] ; then
    echo ""
	echo "Updating Individual Permission Settings failed."
	echo ""
	cat $response
	exit 0
fi

echo ""
echo "Response:"
cat $response
echo ""

# Remove the temporary files
rm "$request_data"
rm "$response"
echo ""
echo ""
echo "Done."
echo ""

