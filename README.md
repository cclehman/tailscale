# tailscale
Repository for SE role
OVERVIEW
This document reviews the steps Craig Lehman took to accomplish the homework exercise in applying for a Solutions Engineer role at Tailscale.  This document shows the steps to deploy a Tailscale subnet router, advertising one private CIDR.  We will deploy a webserver behind that subnet and make it accessible via the tailnet.  This will be reproducible using Infrastructure as Code.  Please refer to tailnet: tail4a4495.ts.net
DETAILS
  This lab was set up using Azure, Terraform, and Tailscale.  Virtual machines are created in Azure.  Other endpoints in a home network included an Android mobile phone, Windows 11 Pro laptop, and an Android tablet.
  Azure was chosen as the cloud provider as it’s commonly used and authentication would work well with the existing home lab.  Test endpoints were chosen simply because they were readily available.  
VALIDATION TECHNIQUE
  The webserver in the private subnet is a Linux box that does not have Tailscale on it.  It is not publicly available.  There is no VPN between the test endpoints and the webserver.  To test connectivity, I connected to the webserver by its internal IP 10.10.1.4 on port 80.  Web pages being served in this manner show connectivity.  Also included in this submission is an output file named “Laptop command line results.txt” showing windows command prompt output displaying connectivity via ping and curl.  
	Screenshot from laptop
	 
	
Screenshot from tablet
	 
REFLECTION AND AI DISCLOSURE
  There were some pieces of this process that were new to me.  In order to accomplish all that was needed for this task, I utilized Tailscale documentation, Terraform documentation, Google and ChatGPT.  Knowing that results from Google and ChatGPT need to be taken with a grain of salt, I leaned on the Tailscale documentation as my primary source before piecing everything together with the other tools.  
  Initially I started this task by trying to create the lab on my windows laptop using Hyper-V, but ended up shifting to Azure due to local machine complications and the fact that it’s not a practical environment which Tailscale partners would use.  A majority would use AWS/Azure/GCP, so I felt it appropriate to shift to one of those to make it relatable.
PREREQUISITES
1)	Install Terraform
2)	Install Azure Command Line Interface
3)	Install Tailscale
4)	Account with Azure
STEPS
1)	Generate an Auth key in Tailscale
a.	Settings->Personal Settings->Keys
b.	Click Generate auth key. 
c.	Document this key right away.
2)	Authenticate the Azure CLI
a.	In powershell, type “az login”
b.	Select your subscription, and note it.
3)	Create a Service Principal
a.	Update the below powershell by inserting your Subscription ID
b.	az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<SUBSCRIPTION_ID>"
4)	Update your environment variables in Windows, replacing the values from the prior output.
a.	$Env:ARM_CLIENT_ID = "<APPID_VALUE>"
b.	$Env:ARM_CLIENT_SECRET = "<PASSWORD_VALUE>"
c.	$Env:ARM_SUBSCRIPTION_ID = "<SUBSCRIPTION_ID>"
d.	$Env:ARM_TENANT_ID = "<TENANT_VALUE>"
5)	Create a directory for your project
a.	mkdir my-terraform-project
b.	cd my-terraform-project
6)	Create Configuration files
a.	# Create main configuration file
b.	New-Item -Path . -Name "main.tf" -ItemType File
c.	# Create variables file (optional but recommended)
d.	New-Item -Path . -Name "variables.tf" -ItemType File
e.	# Create outputs file (optional but recommended)
f.	New-Item -Path . -Name "outputs.tf" -ItemType File
7)	Create sub-directory for server configurations
a.	mkdir cloud-init
b.	cd cloud-init
8)	Create files for your servers
a.	New-Item -Path . -Name "subnet-router.yaml" -ItemType File
b.	New-Item -Path . -Name "webserver.yaml" -ItemType File
9)	Update main.tf file
 
10)	 Update variables.tf file
a.	Note to update tailscale auth key and SSH Public key, mention others are optional.
b.	 
11)	 Update outputs.tf file
a.	 
12)	 Update subnet-router.yaml file
a.	 
13)	 Update webserver.yaml file
a.	 
14)	Deploy
a.	terraform init
b.	terraform apply
15)	Approve subnet route in Tailscale
a.	Machines->Subnet Router
16)	Assign public IP to access your Subnet Router and webserver.  These will only be used for SSH access from your network.
a.	Select your VM
b.	Click Networking->Network Settings
c.	Click on Public IP Address -> Configure
d.	Click on the internal address and check the box “Associate public IP Address”
17)	Install tailscale on your Subnet Router.
a.	From the command line on the VM, install.
i.	curl -fsSL https://tailscale.com/install.sh | sh
b.	Start tailscale
i.	sudo tailscale up
c.	Copy the URL to authenticate and associate to your account by logging in.
18)	Follow steps in this article to set up the Subnet Router, with some slight modifications listed below.
a.	Advertise Routes
i.	sudo tailscale up --advertise-routes=10.10.1.0/24
19)	Test connectivity
a.	http://10.10.1.4 from other devices
