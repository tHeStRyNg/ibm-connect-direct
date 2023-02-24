### Silent Install Automation for IBM Connect Direct 6.2.0 version


#### Step 1. 
Below installation and configuration files are required for a silent installation of Sterling Connect:Direct for UNIX:
Download link provided with each, except the installer for which **Passport Advantage Account is required**.

- i. ```cdinstall_a``` script
This script is a wrapper to cdinstall script which is also used during interactive mode install.

- ii. ```cdinstall script```
It is the core installation script for Connect Direct

- iii. ```cpio``` file
This refers to the installer file (installation archive) which is exploded during install process. If you don’t have it, either use PA Account or get it from company if using Connect Direct.

- iv. ```key certificate```
File containing the Key and trusted certificates. This is self-signed cert and not suitable for enterprise use. Use CA signed cert for production.

- v. ```netmap.cfg```
This is needed to add the network mappings for other hosts to or from which file transfers happen. This file is optional.

- vi. ```userfile.cfg```
Configure custom users using this file during silent install. This is optional.

- vii. Options file - ```options.txt```
It contains all the parameters required for installation e.g install path, Keystore Password etc. These options can also be passed through command line, however options file is always a preferred choice.
Installation process is straight forward and simple, but before execution, let’s understand the various aspects.

options.txt – This is the response file, where all required parameters are provided. Let’s look at the fields, which needs to be updated as per your environment.

**options.txt Parameter Description**
- **cdai_cpioFile**	- This is the Connect Direct Installer
- **cdai_installDir**	- Base Installation Directory
- **cdai_localNodeName** - Hostname
- **cdai_serverPort**	- Listen Port for Server Connections
- **cdai_clientPort** - API Port
- **cdai_localCertFile** - Keycert file containing the Key and Certificate
- **cdai_adminUserid** - User ID designated as admin in the host

#### Step 2. Place all these files in the installation directory:
- cdinstall
- 4.2.0.4-SterlingConnectDirectforUNIX-Linux-x86-iFix056.tar
- cdinstall_a
- spcust.txt
- netmap.cfg
- userfile.cfg
- options.txt

**Note**: Update ```cdinstall_a```, ```spcust.txt```, ```netmap.cfg```, ```userfile.cfg``` and ```options.txt``` as per your needs. Below are the most common changes:

#### Step 3. Trigger Silent Install:

```./cdinstall_a -f ./options.txt```

#### Step 4. Once finished, check below 2 files for any errors or non-zero exit code:

- ```exitStatusFile.txt```
- ```cdaiLog.txt```

#### References
- https://www.ibm.com/docs/en/connect-direct/6.2.0?topic=guide-installation-overview - Silent Install
- How To Video - https://www.youtube.com/watch?v=fKPDeftv2Co
