# Clear stuff
TF_VAR_org_id=""
TF_VAR_billing_account=""
TF_VAR_region=""
TF_CREDS=""

echo "Verifying organization..."
export TF_VAR_org_id = "$(gcloud organizations list --format="value(ID)" --limit=1)"

echo "Verifying billing account..."
export TF_VAR_billing_account = "$(gcloud beta billing accounts list --format="value(ACCOUNT_ID)" --limit=1)"

echo "Setting region..."
TF_VAR_region = "us-central1"

echo "Setting credentials..."
export TF_CREDS=~/.config/gcloud/credentials_file.json
export GOOGLE_APPLICATION_CREDENTIALS=$TF_CREDS

echo "----------------------------------------"
echo "Organization ID set to $TF_VAR_org_id"
echo "Billing Account ID set to $TF_VAR_billing_account"
echo "Region set to $TF_VAR_region"
echo "Credentials set to $TF_CREDS"
echo "GOOGLE_APPLICATION_CREDENTIALS set to $GOOGLE_APPLICATION_CREDENTIALS"
echo "----------------------------------------"