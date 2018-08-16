[![CircleCI](https://circleci.com/gh/AjinkyaBapat/Ansible-Run-Analyser/tree/master.svg?style=svg&circle-token=7f1296f39d95b79a100375ad55a2299c4c77b4a7)](https://circleci.com/gh/AjinkyaBapat/Ansible-Run-Analyser/tree/master) [![CircleCI token](https://img.shields.io/circleci/project/github/RedSparr0w/node-csgo-parser/master.svg?style=plastic)](https://circleci.com/gh/AjinkyaBapat/Ansible-Run-Analyser)

*************************************************************************
Dependencies: Ansible, Python 2.7 above, SSH

Made(Creator): Ajinkya

Contact: ajinkyabapat12@gmail.com

Created:

Last modified:

Passed(tested) for: Ubuntu 14 to 17

*************************************************************************


ARA
=========

Ansible role to install "ARA" on your system.
Clone this repo & run Playbook.yml. That's it!

Requirements
------------

None

Role Variables
--------------

ara_webserver_port : Port to be used for ARA

Dependencies
------------

None

Example Playbook
----------------

Here's a sample playbook code that you can use to call your "ARA" role.

    - hosts: localhost
      roles:
         - ARA

Author Information
------------------

Ajinkya

### Below commented by Cain Chen - Augest 16, 2018 ####

By default, the ARA portal listening address is 127.0.0.1.

And port number is 9191.

Modify below let them to the you want address and port:

Ansible-Run-Analyser/roles/ARA/defaults/main.yml

=== main.yml ===
   ...
   ara_webserver_port: 9191      ## For a example: 8800
   ara_webserver_ip: 127.0.0.1   ## For a example: "{{ ansible_default_ipv4.address }}"

=== End ===









