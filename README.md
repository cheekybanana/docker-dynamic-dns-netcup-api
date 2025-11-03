# Dynamic DNS client for netcup DNS API
*This project is not affiliated with the company netcup GmbH. Although it is developed by an employee, it is not an official client by netcup GmbH and was developed in my free time.*
*netcup is a registered trademark of netcup GmbH, Karlsruhe, Germany.*

**A simple dynamic DNS client written in PHP for use with the netcup DNS API.**

## Requirements
* Be a netcup customer: https://www.netcup.de – or for international customers: https://www.netcup.eu
  * You don't have to be a domain reseller to use the necessary functions for this client – every customer with a domain may use it.
* netcup API key and API password, which can be created within your CCP at https://www.customercontrolpanel.de
* PHP-CLI with CURL extension
* A domain :wink:

## Features
### Implemented
* All necessary API functions for DNS actions implemented (REST API)
* Determines correct public IP address, uses fallback API for determining the IP address, in case main API does return invalid / no IP
* Automatically retries API requests on errors
* IPv4 and IPv6 Support (can be individually enabled / disabled)
* Possible to manually provide IPv4 / IPv6 address to set as a CLI option
* Update everything you want in one go: Every combination of domains, subdomains, domain root, and domain wildcard is possible
* Creation of DNS record, if it doesn't already exist
* If configured, lowers TTL to 300 seconds for the domain on each run, if necessary
* Hiding output (quiet option)

### Missing
* Caching the IP provided to netcup DNS, to avoid running into (currently extremely tolerant) rate limits in the DNS API
* Probably a lot more :grin: – to be continued...

## Getting started
### Download
Clone the repository:

`$ git clone https://github.com/cheekybanana/docker-dynamic-dns-netcup-api.git`




### Configuration
Copy the `.env.example` to `.env` and make your cahnges:

`cp .env.example .env`

The `run.sh` creates a new `config.php` while building the image

### How to use
Build teh image:

`docker build -t netcup-ddns .`

Deploy the container:
`docker compose up -d`

You can let show the logs with 
`docker logs netcup-ddns`

You should se something like this:
```
Running update.php...
[1970/01/01 00:00:34 +0000][NOTICE] =============================================
[1970/01/01 00:00:34 +0000][NOTICE] Running dynamic DNS client for netcup 5.0
[1970/01/01 00:00:34 +0000][NOTICE] This script is not affiliated with netcup.
[1970/01/01 00:00:34 +0000][NOTICE] =============================================

[1970/01/01 00:00:34 +0000][NOTICE] Getting IPv4 address from https://get-ipv4.steck.cc.
[1970/01/01 00:00:34 +0000][NOTICE] Logging into netcup CCP DNS API.
[1970/01/01 00:00:35 +0000][NOTICE] Logged in successfully!
[1970/01/01 00:00:35 +0000][NOTICE] Beginning work on domain "domain.de"
[1970/01/01 00:00:35 +0000][NOTICE] Getting Domain info for "domain.de".
[1970/01/01 00:00:35 +0000][NOTICE] Successfully received Domain info.
[1970/01/01 00:00:35 +0000][NOTICE] Getting DNS records data for "domain.de".
[1970/01/01 00:00:35 +0000][NOTICE] Successfully received DNS record data.
[1970/01/01 00:00:35 +0000][NOTICE] Updating DNS records for subdomain "test01" of domain "domain.de".
[1970/01/01 00:00:35 +0000][NOTICE] IPv4 address hasn't changed. Current IPv4 address: 1.2.3.4
[1970/01/01 00:00:35 +0000][NOTICE] Logging out from netcup CCP DNS API.
[1970/01/01 00:00:36 +0000][NOTICE] Logged out successfully!
Next update in 300s...
```

### CLI options
Just add these Options after the command like `./update.php --quiet`

| short option | long option        | function                                                  |
| ------------ | ------------------ |----------------------------------------------------------:|
| -q           | --quiet            | The script won't output notices, only errors and warnings |
| -c           | --config           | Manually provide a path to the config file                |
| -4           | --ipv4             | Manually provide the IPv4 address to set                  |
| -6           | --ipv6             | Manually provide the IPv6 address to set                  |
| -h           | --help             | Outputs this help                                         |
| -v           | --version          | Outputs the current version of the script                 |

If you have ideas on how to improve this script, please don't hesitate to create an issue. Thank you!
