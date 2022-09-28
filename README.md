Twingate PagerDuty Integration
===========================
This project provides the functionality to trigger PagerDuty alerts when error are found in the Twingate Analytic log.

Prerequisite
===========================
* Pagerduty account

Setup Steps
===========================
Enable Twingate Connector Analytic Log
* adding line `TWINGATE_LOG_ANALYTICS=v1` in file `/etc/twingate/connector.conf`
* Restart Twingate Connector `sudo service twingate-connector restart`

Download the latest [twingate_pagerduty.sh](https://github.com/Twingate-Labs/pagerduty/blob/main/twingate_pagerduty.sh)

Create new service in PagerDuty UI

Once the service is created, select Integration -> Events API V2

Modify `twingate_pagerduty.sh`, replace `xxxxx` with Integration Key which can be found within the Events API V2 integration

Execute `twingate_pagerduty.sh` on the server where connector is installed, `nohup twingate_pagerduty.sh > twingate_pagerduty.log &`
