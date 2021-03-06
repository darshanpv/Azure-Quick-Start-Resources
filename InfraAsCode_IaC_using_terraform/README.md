## Dev Ops

## Step by Step - Build and deploy the terrform - Infrastructure as Code (IaC) supporting multiple environments.

This is a terraform template/skeleton for creating the resources as per your specific needs.  
The required resources being provisioned are added as modules. (e.g. resource group, storage account and databricks)  
The demo provisions storage account and databricks. The demo also consist of sample notebook (in /notebooks folder) which takes data as input as YYYY-MM-DD and foramts it as an output in YYYY-MM-DD HH:MM:SS (you can see these configured in pipeline as notebook_parameters and notebook_result)  

### DevOps Project Creation

1. Go to Azure DevOps portal (https://dev.azure.com/) and create the new project.
1. Go to project setting --> Repos --> Repository and create the new repo or rename the default one.
1. Add .gitignore so as to add all terraform related file extension so that the azure resource details are not revelaed. (.tfstate, secrets etc.)
1. Go to Repos and Clone the repo to IDE VS code. This will prompt to select the local folder in VS Code, where you want the local copy of the code to be stored. Now, you should have the empty repo opened in VS code.

### Terraform backend and Key vault creation for storing secrets
1. Go to Azure portal (https://portal.azure.com) and create the resource group in your subscription that will be used to store the terraform state files and also the key vault that stores secrets. (e.g. terraform\_backend\_rsg)
1. Create storage account in the above resource group that will as terraform backend to store all the state files. (e.g. tfstatefilessa) (IMPORTANT - Disable the public access by selecting "Allow Blob public access" --> Disabled)
1. Create a container that will store all tfstate files (e.g. tf-state-files)
1. Create Azure key vault that will store the access keys securely in secrets. (e.g. tf-secret-vault)

### Creating Service principal and assigning RBAC
1. Service principal will allow the DevOPs portal client to communicate with Azure resources. Go to Azure Active Directory
1. Go to App Registration --> register an app (e.g. cicd-tf-spn)
1. Copy the Client ID, Object ID, tenant ID to notepad
1. Go to 'Certification and secrets' and create the secret (e.g. secret-1)
1. Copy the secret Value to notepad.
1. Now go to your main resource group ( IMP- this is not terraform\_backend\_rsg but the one where you will likely to provision new infra) --> Access control(IAM) --> Role Assignment and add your service principal as owner. With this it will gain access to all the resources within this resource group.

### Storing the access keys and App Ids to keyvault
1. Copy the subscription id in which you want to provision your new resources to notepad
2. Copy the storage account access keys (key1, key2) to notepad
1. Create the secrets in keyvault and store all the keys copied to notepad so far.
`	`(e.g. 	deploy-subscription-id,
`	    `cicd-tf-spn-client-id,
`		`cicd-tf-spn-object-id,
`		`cicd-tf-spn-tenenat-id,
`		`cicd-tf-spn-secret,
`		`tfstatefilessa-key1 ,
`		`tfstatefilessa-key2)
1. Now go to "Access policies" --> add access policy --> select "GET" and "LIST" secret permissions --> select principal to give access to service principal. (cicd-tf-spn). --> Save

### Connecting Azure DevOps to Azure Resources and link to secrets

1. Go to DevOps portal --> Project settings --> New service connection --> Azure Resource Manager --> Service principal (manual) -->
enter all the details --> verify .. NOTE- service principal ID is client ID and service principal key is your secret value)
1. Goto Pipelines --> Library --> Variable group --> give the name (e.g. tf-secrets-vault) and enable "link secrets from an Azure key vault" --> select your service connection (created in above step) --> Add and select all your secrets --> Save
1. Goto "Repos" --> Branches --> select "Branch Policies" by clicking right most ... (dots) --> Enable "Require minimum number of of reviewers", enter 1,  and Enable "Limit merge types" so that you are not allowed to upload to main branch directly.

### CD Pipelines for IaC creation using terraform

1. Go to your VS code (step-4) and create "Dev" branch.
1. Create new folder deployment and copy all the files from this git repo to it.
2. Provide your input details for `dev` and `prod` envirinements in dev.tfvars as well as prod.tfvars located in deploy-env folder.
3. Commit your changes so that the DevOps repo reflect all your changes in "Dev" branch.
4. Create a pull request and merge the dev branch to main branch.
5. Go to Pipeline --> Environments --> New Environment. Add new environment --> dev , Resources --> None , Click "Create". Goto right most ... (dots) and add approvals and add approver as yourself.
6. Go to Pipelines and create a new pipeline --> Select your repo --> "Existing Azure Pipelines YAML file"--> select `dev` branch and select 'create-infra-pipeline.yaml' under 'deployment\pipelines' folder. This will open a YAML file in pipeline editor.
7. **IMPORTANT** - Go to 'variables' option availble on top and add new variable 'Environment' with default value as dummy. You will have to change this variable during runtime based on the environment that you plan to create. (e.g. `dev` or `prod`)
8. The pipeline has 2 stages - Stage 1 -> Validate (terraform Init and Plan) , Stage-2 -> Deploy (terraform apply)
9. Check all the parameters and you should be able to run the pipeline. You need to approval before "Deploy" stage is triggered
10. If everything goes well, you should see the new resource group created.
11. You can check the new .tfstate file stored in tf-state-files container.

**Important**- If you re-run the pipeline with new resource group, it will automatically delete the old resource group and create new one as terraform maintains the old state and to-be state.

#### Azure Pipeline Directory Structure

$(Agent.WorkFolder) => /home/vsts/work  
$(Agent.RootDirectory) => /home/vsts/work   
$(Agent.BuildDirectory) => /home/vsts/work/1  

$(Build.ArtifactStagingDirectory) => /home/vsts/work/1/a  
$(Build.StagingDirectory) => home/vsts/work/1/a  
$(Build.BinariesDirectory) => /home/vsts/work/1/b  
$(Build.SourcesDirectory) => /home/vsts/work/1/s  

$(System.ArtifactsDirectory) => home/vsts/work/1/a  
$(System.DefaultWorkingDirectory) => /home/vsts/work/1/s  

$(Pipeline.Workspace) => /home/vsts/work/1