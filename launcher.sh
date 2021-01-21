#!/bin/bash
set -e

api_version=""

if [ ! -f "config/settings.txt" ]; then
    echo "Error: "
    echo "First copy the file 'config/settings.example.txt' to 'config/settings.txt'."
    echo "Next, fill in your API credentials, Signer name and email to continue."
    echo ""
    exit 1
fi

if [ -f "config/settings.txt" ]; then
    . config/settings.txt
fi

function resetToken() {
    rm -f config/ds_access_token* || true
}

# Choose an OAuth Strategy
function login() {
    echo ""
    api_version=$1
    PS3='Choose an OAuth Strategy: '
    select METHOD in \
        "Use_Authorization_Code_Grant" \
        "Use_JSON_Web_Token" \
        "Skip_To_APIs" \
        "Exit"; do
        case "$METHOD" in

        \
            Use_Authorization_Code_Grant)
            php ./OAuth/code_grant.php "$api_version"
            continu $api_version
            ;;

        Use_JSON_Web_Token)
            php ./OAuth/jwt.php "$api_version"
            continu $api_version
            ;;

        Skip_To_APIs)
            choices
            ;;

        Exit)
            exit 0
            ;;
        esac
    done

    mv ds_access_token.txt $token_file_name

    account_id=$(cat config/API_ACCOUNT_ID)
    ACCESS_TOKEN=$(cat $token_file_name)

    export ACCOUNT_ID
    export ACCESS_TOKEN
}

# Choose an API
function choices() {
    echo ""
    PS3='Choose an API: '
    select METHOD in \
        "eSignature" \
        "Rooms" \
        "Click" \
        "Exit"; do
        case "$METHOD" in

        eSignature)
            api_version="eSignature"
            login $api_version
            startSignature
            ;;

        Rooms)
            api_version="Rooms"
            login $api_version
            startRooms
            ;;
        
        Click)
            api_version="Click"
            login $api_version
            startRooms
            ;;
        
        Exit)
            exit 0
            ;;
        esac
    done
}

# Select the action
function startSignature() {
    echo ""
    PS3='Select the action : '
    select CHOICE in \
        "Embedded_Signing" \
        "Signing_Via_Email" \
        "List_Envelopes" \
        "Envelope_Info" \
        "Envelope_Recipients" \
        "Envelope_Docs" \
        "Envelope_Get_Doc" \
        "Create_Template" \
        "Use_Template" \
        "Send_Binary_Docs" \
        "Embedded_Sending" \
        "Embedded_Console" \
        "Add_Doc_To_Template" \
        "Collect_Payment" \
        "Envelope_Tab_Data" \
        "Set_Tab_Values" \
        "Set_Template_Tab_Values" \
        "Envelope_Custom_Field_Data" \
        "Signing_Via_Email_With_Access_Code" \
        "Signing_Via_Email_With_Sms_Authentication" \
        "Signing_Via_Email_With_Phone_Authentication" \
        "Signing_Via_Email_With_Knoweldge_Based_Authentication" \
        "Signing_Via_Email_With_IDV_Authentication" \
        "Creating_Permission_Profiles" \
        "Setting_Permission_Profiles" \
        "Updating_Individual_Permission" \
        "Deleting_Permissions" \
        "Creating_A_Brand" \
        "Applying_Brand_Envelope" \
        "Applying_Brand_Template" \
        "Bulk_Sending" \
        "Pause_Signature_Workflow" \
        "Unpause_Signature_Workflow" \
        "Use_Conditional_Recipients" \
        "Home"; do
        case "$CHOICE" in

        Home)
            choices
            ;;
        Embedded_Signing)
            bash eg001EmbeddedSigning.sh
            startSignature
            ;;
        Signing_Via_Email)
            bash examples/eSignature/eg002SigningViaEmail.sh
            startSignature
            ;;
        List_Envelopes)
            bash examples/eSignature/eg003ListEnvelopes.sh
            startSignature
            ;;
        Envelope_Info)
            bash examples/eSignature/eg004EnvelopeInfo.sh
            startSignature
            ;;
        Envelope_Recipients)
            bash examples/eSignature/eg005EnvelopeRecipients.sh
            startSignature
            ;;
        Envelope_Docs)
            bash examples/eSignature/eg006EnvelopeDocs.sh
            startSignature
            ;;
        Envelope_Get_Doc)
            bash examples/eSignature/eg007EnvelopeGetDoc.sh
            constartSignature
            ;;
        Create_Template)
            bash examples/eSignature/eg008CreateTemplate.sh
            startSignature
            ;;
        Use_Template)
            bash examples/eSignature/eg009UseTemplate.sh
            startSignature
            ;;
        Send_Binary_Docs)
            bash examples/eSignature/eg010SendBinaryDocs.sh
            startSignature
            ;;
        Embedded_Sending)
            bash examples/eSignature/eg011EmbeddedSending.sh
            startSignature
            ;;
        Embedded_Console)
            bash examples/eSignature/eg012EmbeddedConsole.sh
            startSignature
            ;;
        Add_Doc_To_Template)
            bash examples/eSignature/eg013AddDocToTemplate.sh
            startSignature
            ;;
        Collect_Payment)
            bash examples/eSignature/eg014CollectPayment.sh
            startSignature
            ;;
        Envelope_Tab_Data)
            bash examples/eSignature/eg015EnvelopeTabData.sh
            startSignature
            ;;
        Set_Tab_Values)
            bash examples/eSignature/eg016SetTabValues.sh
            startSignature
            ;;
        Set_Template_Tab_Values)
            bash examples/eSignature/eg017SetTemplateTabValues.sh
            startSignature
            ;;
        Envelope_Custom_Field_Data)
            bash examples/eSignature/eg018EnvelopeCustomFieldData.sh
            startSignature
            ;;
        Signing_Via_Email_With_Access_Code)
            bash examples/eSignature/eg019SigningViaEmailWithAccessCode.sh
            startSignature
            ;;
        Signing_Via_Email_With_Sms_Authentication)
            bash examples/eSignature/eg020SigningViaEmailWithSmsAuthentication.sh
            startSignature
            ;;
        Signing_Via_Email_With_Phone_Authentication)
            bash examples/eSignature/eg021SigningViaEmailWithPhoneAuthentication.sh
            startSignature
            ;;
        Signing_Via_Email_With_Knoweldge_Based_Authentication)
            bash examples/eSignature/eg022SigningViaEmailWithKnoweldgeBasedAuthentication.sh
            startSignature
            ;;
        Signing_Via_Email_With_IDV_Authentication)
            bash examples/eSignature/eg023SigningViaEmailWithIDVAuthentication.sh
            startSignature
            ;;
        Creating_Permission_Profiles)
            bash examples/eSignature/eg024CreatingPermissionProfiles.sh
            startSignature
            ;;
        Setting_Permission_Profiles)
            bash examples/eSignature/eg025SettingPermissionProfiles.sh
            startSignature
            ;;
        Updating_Individual_Permission)
            bash examples/eSignature/eg026UpdatingIndividualPermission.sh
            startSignature
            ;;
        Deleting_Permissions)
            bash examples/eSignature/eg027DeletingPermissions.sh
            startSignature
            ;;
        Creating_A_Brand)
            bash examples/eSignature/eg028CreatingABrand.sh
            startSignature
            ;;
        Applying_Brand_Envelope)
            bash examples/eSignature/eg029ApplyingBrandEnvelope.sh
            startSignature
            ;;
        Applying_Brand_Template)
            bash examples/eSignature/eg030ApplyingBrandTemplate.sh
            startSignature
            ;;
        Bulk_Sending)
            bash examples/eSignature/eg031BulkSending.sh
            startSignature
            ;;
        Pause_Signature_Workflow)
            bash examples/eSignature/eg032PauseSignatureWorkflow.sh
            startSignature
            ;;
        Unpause_Signature_Workflow)
            bash examples/eSignature/eg033UnpauseSignatureWorkflow.sh
            startSignature
            ;;
        Use_Conditional_Recipients)
            bash examples/eSignature/eg034UseConditionalRecipients.sh
            startSignature
            ;;
        *)
            echo "Default action..."
            startSignature
            ;;
        esac
    done
}

# Select the action
function startRooms() {
    echo ""
    PS3='Select the action : '
    select CHOICE in \
        "Create_Room_With_Data_Controller" \
        "Create_Room_With_Template_Controller" \
        "Export_Data_From_Room_Controller" \
        "Add_Forms_To_Room_Controller" \
        "Get_Rooms_With_Filters_Controller" \
        "Create_An_External_Form_Fill_Session_Controller" \
        "Home"; do
        case "$CHOICE" in

        Home)
            choices
            ;;
        Create_Room_With_Data_Controller)
            bash examples/Rooms/eg001CreateRoomWithDataController.sh
            startRooms
            ;;
        Create_Room_With_Template_Controller)
            bash examples/Rooms/eg002CreateRoomWithTemplateController.sh
            startRooms
            ;;
        Export_Data_From_Room_Controller)
            bash examples/Rooms/eg003ExportDataFromRoomController.sh
            startRooms
            ;;
        Add_Forms_To_Room_Controller)
            bash examples/Rooms/eg004AddFormsToRoomController.sh
            startRooms
            ;;
        Get_Rooms_With_Filters_Controller)
            bash examples/Rooms/eg005GetRoomsWithFiltersController.sh
            startRooms
            ;;
        Create_An_External_Form_Fill_Session_Controller)
            bash examples/Rooms/eg006CreateAnExternalFormFillSessionController.sh
            startRooms
            ;;
        *)
            echo "Default action..."
            startRooms
            ;;
        esac
    done
}

function startClick() {
    echo ""
    PS3='Select the action : '
    select CHOICE in \
        "Create_Clickwraps" \
        "Activate_Clickwrap" \
        "Create_New_Clickwrap_Version" \
        "Get_List_Of_Clickwraps" \
        "Get_Clickwrap_Responses" \
        "Home"; do
        case "$CHOICE" in

        Home)
            choices
            ;;
        Create_Clickwraps)
            bash examples/Click/eg001CreateClickwraps.sh
            startClick
            ;;
        Activate_Clickwrap)
            bash examples/Click/eg002ActivateClickwrap.sh
            startClick
            ;;
        Create_New_Clickwrap_Version)
            bash examples/Click/eg003CreateNewClickwrapVersion.sh
            startClick
            ;;
        Get_List_Of_Clickwraps)
            bash examples/Click/eg004GetListOfClickwraps.sh
            startClick
            ;;
        Get_Clickwrap_Responses)
            bash examples/Click/eg005GetClickwrapResponses.sh
            startClick
            ;;
        *)
            echo "Default action..."
            startClick
            ;;
        esac
    done
}

function continu() {
    echo "press the 'any' key to continue"
    read nothin
    api_version=$1
    if [[ $api_version == "eSignature" ]]
    then
      startSignature
    elif [[ $api_version == "Rooms" ]]
    then
      startRooms
    elif [[ $api_version == "Click" ]]
    then
      startClick
    fi
}

echo ""
echo "Welcome to the DocuSign Bash Launcher"
echo "using Authorization Code grant or JWT grant authentication."

choices
