# OKCN Experiment


## How to use (on Ubuntu)

### Install

- Assume you have two machines *NodeS* and *NodeC*.
- Assume from the view of *NodeC* *NodeS* has IPv4 address `22.33.44.55`.
- Assume you have logged on to *NodeS* and *NodeC* as a sudo-able user.
- Assume on *NodeS* port 8000-9000 is free.

  If that's not possible, you will have to edit some configuration file before running.
- Do some quick install first.
  ```
  sudo apt get install -y git autoconf libtool-bin lib-pcre3-dev
  ```
- On each of *NodeS* and *NodeC*, get the source code.
  ```
  git clone --recursive https://https://github.com/zjma/okcn_experiment.git
  ```
  It may take 5-15 minutes to complete,
  since large projects like openssl and httpd (and their commit history) will be downloaded.
- On *NodeS*,
  enter the source directory,
  choose a location and install.
  ```
  cd okcn_experiment
  INSTALL_LOCATION=/tmp/okcn
  ./setup-server $INSTALL_LOCATION
  ```
  This installs openssl (with OQSKEX enabled) to `$INSTALL_LOCATION/ssl`,
  httpd to `$INSTALL_LOCATION/httpd` and overwrites `httpd.conf`.
  
  Finally you should see line `Server side ready`, meaning that installation is completed.
- On *NodeC*, enter the source directory,
  choose a location and install.
  ```
  cd okcn_experiment
  INSTALL_LOCATION=/tmp/okcn
  ./setup-client $INSTALL_LOCATION
  ```
  This installs openssl (with OQSKEX enabled) to `$INSTALL_LOCATION/ssl`,
  http_load to `$INSTALL_LOCATION/http_load`.

  Finally you should see line `Client side ready`, meaning that installation is completed.

### Run
- On *NodeS*, check the httpd configuration file `$INSTALL_LOCATION/httpd/conf/extra/httpd-vhosts.conf`,
  and you will see 14 HTTPS servers configured with unique listening port and unique TLS ciphersuite.

  By default the settings are summarized as follows.
  Edit that file if necessary (e.g., some port below is unavailable).
  
| Port | Ciphersuite |
|------|-------------|
| 8010 | `ECDHE-RSA-AES256-GCM-SHA384` |
| 8011 | `ECDHE-ECDSA-AES256-GCM-SHA384` |
| 8020 | `OQSKEX-RLWE-BCNS15-RSA-AES256-GCM-SHA384` |
| 8021 | `OQSKEX-RLWE-BCNS15-ECDSA-AES256-GCM-SHA384` |
| 8030 | `OQSKEX-RLWE-NEWHOPE-RSA-AES256-GCM-SHA384` |
| 8031 | `OQSKEX-RLWE-NEWHOPE-ECDSA-AES256-GCM-SHA384` |
| 8040 | `OQSKEX-RLWE-MSRLN16-RSA-AES256-GCM-SHA384` |
| 8041 | `OQSKEX-RLWE-MSRLN16-ECDSA-AES256-GCM-SHA384` |
| 8050 | `OQSKEX-LWE-FRODO-RECOMMENDED-RSA-AES256-GCM-SHA384` |
| 8051 | `OQSKEX-LWE-FRODO-RECOMMENDED-ECDSA-AES256-GCM-SHA384` |
| 8060 | `OQSKEX-SIDH-CLN16-RSA-AES256-GCM-SHA384` |
| 8061 | `OQSKEX-SIDH-CLN16-ECDSA-AES256-GCM-SHA384` |
| 8070 | `OQSKEX-LWE-OKCN-RSA-AES256-GCM-SHA384` |
| 8071 | `OQSKEX-LWE-OKCN-ECDSA-AES256-GCM-SHA384` |
| 8080 | `OQSKEX-LWR-OKCN-RSA-AES256-GCM-SHA384` |
| 8081 | `OQSKEX-LWR-OKCN-ECDSA-AES256-GCM-SHA384` |

- On *NodeS*, start HTTPS servers.
  ```
  $INSTALL_LOCATION/httpd/bin/apachectl restart
  ```
- On *NodeC*, use http_load to send requests.
  ```
  echo "https://22.33.44.55:8010" > urls
  $INSTALL_LOCATION/http_load/bin/http_load -parallel 10 -seconds 6 urls
  ```
  This sends lots of requests to the server at port 8010
  so that 10 requests are simultaneously being processed at any time.

  After 6 seconds it stops and prints some statistics.
  
## TODO
- Make openssl source code compactible with autotools.
- Separate liboqs from openssl.
- Generate server-side certs and keys at installation time. If possible, take some arguments (e.g., rsa key size, ec named curves).
  So far, they are staic files.
  
