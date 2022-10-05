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

1. Create new service in PagerDuty UI

2. Once the service is created, select Integration -> Custom Event Transformer

3. Name the Custom Event Transformer as Twingate Event Transformer

4. Paste the block below into the Twingate Event Transformer
```
    var normalized_event = {
      event_type: PD.Trigger,
      description: `Twingate Analytics: ${JSON.parse(PD.inputRequest.rawBody).connection.error_message}`,
      details: JSON.stringify(JSON.parse(PD.inputRequest.rawBody), null, 4)
    };

    PD.emitGenericEvents([normalized_event]);
```


5. Modify `twingate_pagerduty.sh`, replace `xxxxx` with Integration Key which can be found within the Twingate Event Transformer integration

6. Execute `twingate_pagerduty.sh` on the server where connector is installed, `nohup bash twingate_pagerduty.sh > twingate_pagerduty.log &`
