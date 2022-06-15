# OpenRazer Kernel Module Signer

It's a simple script that signs [OpenRazer](https://openrazer.github.io/) drivers 
for Opensuse, which enables you to load these drivers on an UEFI enabled system.

## Setup

In order to sign openrazer modules:

 1. Create certificates:
    
        openssl req -config ./openssl.cnf \
          -new -x509 -newkey rsa:2048 \
          -nodes -days 36500 -outform DER \
          -keyout "MOK.priv" \
          -out "MOK.der"
    
 2. Import the keys:
 
     sudo mokutil --import MOK.der

 3. Reboot and import the key in EFI. 
 Provide the password you entered when importing the key

## Signing

First install the drivers:

    zypper addrepo https://download.opensuse.org/repositories/hardware:razer/openSUSE_Leap_15.4/hardware:razer.repo
    zypper refresh
    zypper install openrazer-meta

Then run razer-sign:

    sudo sh ./razer-sign.sh

## Security

Since you imported the custom key into your EFI environment you should not store this key on the same machine.
If someone gains access to this key he could use it to sign other modules which would then be accepted by the machine
where this key was imported.

## License

Public domain. 

